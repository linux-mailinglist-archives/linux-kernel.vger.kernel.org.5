Return-Path: <linux-kernel+bounces-141826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34518A23F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201EF1C21F21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0B125CC;
	Fri, 12 Apr 2024 02:54:28 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47011185;
	Fri, 12 Apr 2024 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890468; cv=none; b=cPDViqyyXiD5PvP5Q8Ly4MhfMyJFyqyNCvtk5lGmHlK98tXNVD8JUfHjrnQySQ7fnAUO7YLtFfaDvqgjw/XmmI/Nh9wNlCNP+t7s7kxTqXdmozpVej2mzQMbQq3i/Ct33JsT3IVSl2fJPhOW9Fys2U1ji5Xos1B8maPI/wkFJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890468; c=relaxed/simple;
	bh=h4qSO4o4Q4wf7AGi/1qfp4K265zSU5U2oDv5u4UuZ84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCZjw1tcBw6NteM4Lq/9hT2d45o8gs3DVgF2aiFHP2bnM1ikpC/A2dogpsZmpe2CAKGR4hdEcK605ViZgnecyCZ/LYoQpBgyg1Ay0p/Ak/ldssKvP7xqqBCed2VFuVTio111PAuZKhDOp14pnORP2TtKyL1Ca6/CPIa2Gj2XSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rv73S-000gl1-65; Fri, 12 Apr 2024 10:54:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 10:54:35 +0800
Date: Fri, 12 Apr 2024 10:54:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hailey Mothershead <hailmo@amazon.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: aead,cipher - zeroize key buffer after use
Message-ID: <Zhiia00JmkH7hQt8@gondor.apana.org.au>
References: <20240411235157.19801-1-hailmo@amazon.com>
 <20240411235157.19801-2-hailmo@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411235157.19801-2-hailmo@amazon.com>

On Thu, Apr 11, 2024 at 11:51:57PM +0000, Hailey Mothershead wrote:
> I.G 9.7.B for FIPS 140-3 specifies that variables temporarily holding
> cryptographic information should be zeroized once they are no longer
> needed. Accomplish this by using kfree_sensitive for buffers that
> previously held the private key.
> 
> Signed-off-by: Hailey Mothershead <hailmo@amazon.com>
> ---
>  crypto/aead.c   | 2 +-
>  crypto/cipher.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/aead.c b/crypto/aead.c
> index 16991095270d..2592d5375de5 100644
> --- a/crypto/aead.c
> +++ b/crypto/aead.c
> @@ -36,7 +36,7 @@ static int setkey_unaligned(struct crypto_aead *tfm, const u8 *key,
>  	memcpy(alignbuffer, key, keylen);
>  	ret = crypto_aead_alg(tfm)->setkey(tfm, alignbuffer, keylen);
>  	memset(alignbuffer, 0, keylen);
> -	kfree(buffer);
> +	kfree_sensitive(buffer);

Please remove the now-redundant memset.

> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index b47141ed4a9f..efb87fa417e7 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -35,7 +35,7 @@ static int setkey_unaligned(struct crypto_cipher *tfm, const u8 *key,
>  	memcpy(alignbuffer, key, keylen);
>  	ret = cia->cia_setkey(crypto_cipher_tfm(tfm), alignbuffer, keylen);
>  	memset(alignbuffer, 0, keylen);
> -	kfree(buffer);
> +	kfree_sensitive(buffer);

Ditto.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

