Return-Path: <linux-kernel+bounces-145979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B78A5DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62B41F22653
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337FA1586D3;
	Mon, 15 Apr 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITmyuvqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C0156225;
	Mon, 15 Apr 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221385; cv=none; b=UdQyP3DESJ3qFd+sF/RAWgABHif9aDpP0saflFKVSmMJdkfzZhxtHNbfo+CSMBm7L6woSL+Yuj2TlpdadazI8NKFCRaqj+k0Z87ZkKF+IY4RXhG6ld1fvr50wTrwfr+vGLyXG7hOnD1EzhPtgh6joFSJXB741F8KPhTf/K5PPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221385; c=relaxed/simple;
	bh=Ztq9N6zxAzOU2gFdxK5g04qiK/ipn5K96C+fvix/A5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU6gIZsn7Ro80IPR2PLO0NNhr1eLtxDJy2Rqp5M4c7o6G/Jztexmg+axAIIdR7ZrTaa7u9Yjk5dtsMMDk7zwZor+SwRgFJeHarpvw+MBMLQNrJ0OqtG3yQxX4ip/jQ7BSH2wIUlN3llZLmbyowj4flnim1qSgqVesYNB13acy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITmyuvqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3741C113CC;
	Mon, 15 Apr 2024 22:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713221385;
	bh=Ztq9N6zxAzOU2gFdxK5g04qiK/ipn5K96C+fvix/A5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITmyuvqWXm7bFcODxPf/3Yf6TWq3cO1rqr52IvCNaIm8eWh/FJUEbA1YEH2Fwx7z3
	 yBAJI+2PkixFUEdTLNFXNPW7KCLpTVGYe4ZVymIkv2xoowLhdemA9L9x8cqSlXdrdp
	 XCi101aHLiAl4LnGNDZu1PfP+i+neShMrhsLuHhi4rXU5h2nLONkwi03tWinI3+Nj2
	 4WnqOmeNFyrubyuJWCgLkGQoV3ALNUICNvLhRb1Ge8iEW3LjWI9xrKHYlQUu65iDV0
	 N6f361xTg78NxOMgrRI99kxSPjwV94l61ZjWoAwZao1MBzukCJLrXK8fH/UCtxeBXF
	 q0nkw8bmCP8ww==
Date: Mon, 15 Apr 2024 15:49:42 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hailey Mothershead <hailmo@amazon.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] crypto: aead,cipher - zeroize key buffer after use
Message-ID: <20240415224942.GC5206@sol.localdomain>
References: <20240415221915.20701-1-hailmo@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415221915.20701-1-hailmo@amazon.com>

On Mon, Apr 15, 2024 at 10:19:15PM +0000, Hailey Mothershead wrote:
> I.G 9.7.B for FIPS 140-3 specifies that variables temporarily holding
> cryptographic information should be zeroized once they are no longer
> needed. Accomplish this by using kfree_sensitive for buffers that
> previously held the private key.
> 
> Signed-off-by: Hailey Mothershead <hailmo@amazon.com>
> ---
>  crypto/aead.c   | 3 +--
>  crypto/cipher.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/crypto/aead.c b/crypto/aead.c
> index 16991095270d..c4ece86c45bc 100644
> --- a/crypto/aead.c
> +++ b/crypto/aead.c
> @@ -35,8 +35,7 @@ static int setkey_unaligned(struct crypto_aead *tfm, const u8 *key,
>  	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
>  	memcpy(alignbuffer, key, keylen);
>  	ret = crypto_aead_alg(tfm)->setkey(tfm, alignbuffer, keylen);
> -	memset(alignbuffer, 0, keylen);
> -	kfree(buffer);
> +	kfree_sensitive(buffer);
>  	return ret;
>  }
>  
> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index b47141ed4a9f..395f0c2fbb9f 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -34,8 +34,7 @@ static int setkey_unaligned(struct crypto_cipher *tfm, const u8 *key,
>  	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
>  	memcpy(alignbuffer, key, keylen);
>  	ret = cia->cia_setkey(crypto_cipher_tfm(tfm), alignbuffer, keylen);
> -	memset(alignbuffer, 0, keylen);
> -	kfree(buffer);
> +	kfree_sensitive(buffer);
>  	return ret;

Well, the memset()s that you're removing already did the zeroization.  This
patch seems worthwhile as a code simplification, but please don't characterize
it as a bug fix, because it's not.

- Eric

