Return-Path: <linux-kernel+bounces-159765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910178B33AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32F51C21E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6FB13F434;
	Fri, 26 Apr 2024 09:14:39 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB513F428;
	Fri, 26 Apr 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122878; cv=none; b=hOWebJbJlgWEW0kz9JK7xaCsh65OL7Fo7vM314XvvrP8KXdRpKl0rfMRJcfItjPXqk7lY4XUGn0M3LxZ8p/P0L0Q/HdedMLwZxcBgSSj5O6zklovAtrJxhUCu0NA63wi7f2nWHKxh55eh4Hymi2PR6zEs9FIgrnMo/Hv/uGEB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122878; c=relaxed/simple;
	bh=B8Lll3xWX332PRlV5HPm+9hPCrTUmSXqVBq3Y3DSJjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnEV5Dv+FbWq3vOHbTcm4NYPMgyeMPU6DPPhEitDDze+8kJ/amHfj3TSxRNPNw497omG1M7UmCW/PifIZsQniI50cfQYwuYouBUI+u3V7YASjpinAT0TrMPKICm/xTvxUBskUAGXPNgqqn9uEPZmRrQOmdC4WGHdsaYQ15jhhgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1s0Hex-006dwS-QV; Fri, 26 Apr 2024 17:14:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Apr 2024 17:14:41 +0800
Date: Fri, 26 Apr 2024 17:14:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
	git@jvdsn.com, hkario@redhat.com, simo@redhat.com,
	Salvatore Benedetto <salvatore.benedetto@intel.com>
Subject: Re: [PATCH v3 1/2] crypto: ecdh - Pass private key in proper byte
 order to check valid key
Message-ID: <ZitwgY7qRsnkrzG6@gondor.apana.org.au>
References: <20240418152445.2773042-1-stefanb@linux.ibm.com>
 <20240418152445.2773042-2-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418152445.2773042-2-stefanb@linux.ibm.com>

On Thu, Apr 18, 2024 at 11:24:44AM -0400, Stefan Berger wrote:
> ecc_is_key_valid expects a key with the most significant digit in the last
> entry of the digit array. Currently ecdh_set_secret passes a reversed key
> to ecc_is_key_valid that then passes the rather simple test checking
> whether the private key is in range [2, n-3]. For all current ecdh-
> supported curves (NIST P192/256/384) the 'n' parameter is a rather large
> number, therefore easily passing this test.
> 
> Throughout the ecdh and ecc codebase the variable 'priv' is used for a
> private_key holding the bytes in proper byte order. Therefore, introduce
> priv in ecdh_set_secret and copy the bytes from ctx->private_key into
> priv in proper byte order by using ecc_swap_digits. Pass priv to
> ecc_is_valid_key.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  crypto/ecdh.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/ecdh.c b/crypto/ecdh.c
> index 3049f147e011..c02c9a2b9682 100644
> --- a/crypto/ecdh.c
> +++ b/crypto/ecdh.c
> @@ -27,7 +27,9 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
>  			   unsigned int len)
>  {
>  	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
> +	u64 priv[ECC_MAX_DIGITS];
>  	struct ecdh params;
> +	int ret = 0;
>  
>  	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
>  	    params.key_size > sizeof(u64) * ctx->ndigits)
> @@ -40,13 +42,16 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
>  				       ctx->private_key);
>  
>  	memcpy(ctx->private_key, params.key, params.key_size);
> +	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);

These functions need to use our sparse marking mechanism correctly
to prevent future occurences of such errors.  They should not be
passing around void * pointers or worse, treating u64 * arrays as
big-endian.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

