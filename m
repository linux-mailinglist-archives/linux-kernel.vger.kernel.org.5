Return-Path: <linux-kernel+bounces-89603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0CF86F28E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF581C21225
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78F14176F;
	Sat,  2 Mar 2024 21:34:33 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F91F16B;
	Sat,  2 Mar 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709415273; cv=none; b=Tcl6tbfjQR/emzFHQlNtJ+K8QnXggd2Pc9rZ1n9wSZY/qVnUcIPO4CP6zPhAVAUw7grku9KBDTUfHU+63kE3H5qMLuvg6UwwQS/OgcDkWIlkOr0tTcV3SRyOu3PcPaQqY/G8FRCe5ev/spnIJy2UaQQiWZs5/1hy3CEA6vlVE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709415273; c=relaxed/simple;
	bh=qa67s/52VE4paDCQ+GpC5YuWdKmXNoqBaJKRgm4xFWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWeXy0dhW33U8ihdv1ugnj35JrXsuVuxScHcTHeDQsisv+MxCOWvHZ3aVrKYd/S39mmFQn2/+IARQx2s4UvRU1fQoKPYrP5X02ion8KBDzGGbSrfJFWrsIQIewJpvTQCjafQNo2af3ZgNfj5lgkLlnTTXp0PO0Vxy9txbcfkOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5C393100D9401;
	Sat,  2 Mar 2024 22:34:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3AD9F2E081; Sat,  2 Mar 2024 22:34:27 +0100 (CET)
Date: Sat, 2 Mar 2024 22:34:27 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v4 01/12] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Message-ID: <20240302213427.GA30938@wunner.de>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-2-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301022007.344948-2-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 29, 2024 at 09:19:56PM -0500, Stefan Berger wrote:
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -222,9 +222,8 @@ static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
>  static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsigned int keylen)
>  {
>  	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
> +	unsigned int digitlen, ndigits;
>  	const unsigned char *d = key;
> -	const u64 *digits = (const u64 *)&d[1];
> -	unsigned int ndigits;
>  	int ret;
>  
>  	ret = ecdsa_ecc_ctx_reset(ctx);

Hm, the removal of digits isn't strictly necessary.  If you would keep it,
the patch would become simpler (fewer lines changes).


> @@ -238,12 +237,17 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
>  		return -EINVAL;
>  
>  	keylen--;
> -	ndigits = (keylen >> 1) / sizeof(u64);
> +	digitlen = keylen >> 1;
> +
> +	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));

Instead of introducing an additional digitlen variable, you could just
use keylen.  It seems it's not used in the remainder of the function,
so modifying it is harmless:

 	keylen--;
+ 	keylen >>= 1;
-	ndigits = (keylen >> 1) / sizeof(u64);
+	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));

Just a suggestion.

Thanks,

Lukas

