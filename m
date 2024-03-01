Return-Path: <linux-kernel+bounces-89093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B586EA61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B444B289718
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342C23D0B3;
	Fri,  1 Mar 2024 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+pgumSP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216F3CF5D;
	Fri,  1 Mar 2024 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325392; cv=none; b=EC+UYVqDzcVOJjdnvfoo6pCNF2VofEe5YH1JEKWa+lZ4sfXdeTgvP0RwHjkSvYW2gC32X8SsuwBNANAJo/gzZulhlskQWZkMOB3kpOXVdmsXWirkC6UMSdH9dcqm10hjH1fzmhmah2NUq6P6cxmUeRkYxO0Hmcp7ETlpSSjf7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325392; c=relaxed/simple;
	bh=WDsGuB3hsDm+lPKKQjS9A7bzXYwwHm0Ut6KHfEl37OU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lPdU1DOsxL0ZJcuvX8U5a9aBGn/9dGMsKyz8it3YxvgHcnDVHuFX1tZdUjSZHmAg4t9HEs0sqdMFVLw+/AbMxrExtrMDurOn7Vj/B7SAo0rqbCpAKBMyk4FKswyQq82WZQv3FXphz5N94XuebNmhTisZX4APIsrMRDTNpMF9o2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+pgumSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA34BC433F1;
	Fri,  1 Mar 2024 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709325392;
	bh=WDsGuB3hsDm+lPKKQjS9A7bzXYwwHm0Ut6KHfEl37OU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Q+pgumSPQib7pKFvehmimPR72IWsE1P6U+gXDksISrwdM/+BWVTneFY0OyMDiz7Sc
	 ZCBYUPO92217AZQiGucFlX31kRTT3nUPmLWC/cowJl+IpPm9oJcx426p4+NXHHQ1PP
	 Fn9BCnGbWg0KJqI39NGDp2veV5sEtbR0tM7jkDRUoBQ67TEPNdnqXfd62Iei4jsEl8
	 KsthP1JBFLQTvlsBnPOZs6B+ihvU2F8xgppVdMcPpjJxFMudIqy7vejQbC19YOrRYM
	 bURlr1VKCKUHDc/e2ry6pk7PikrxKapEX2Gg2ADNVBTYFcnwtiALlvhLq2YJBRLZGD
	 TKYW9v0VAH05A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Mar 2024 22:36:28 +0200
Message-Id: <CZIPA2YV5AUI.3MS4AUWRD516P@suppilovahvero>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>
Subject: Re: [PATCH v4 01/12] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-2-stefanb@linux.ibm.com>
In-Reply-To: <20240301022007.344948-2-stefanb@linux.ibm.com>

On Fri Mar 1, 2024 at 4:19 AM EET, Stefan Berger wrote:
> For NIST P192/256/384 the public key's x and y parameters could be copied
> directly from a given array since both parameters filled 'ndigits' of
> digits (a 'digit' is a u64). For support of NIST P521 the key parameters
> need to have leading zeros prepended to the most significant digit since
> only 2 bytes of the most significant digit are provided.
>
> Therefore, implement ecc_digits_from_bytes to convert a byte array into a=
n
> array of digits and use this function in ecdsa_set_pub_key where an input
> byte array needs to be converted into digits.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  crypto/ecdsa.c                | 14 +++++++++-----
>  include/crypto/internal/ecc.h | 25 +++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index fbd76498aba8..6653dec17327 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -222,9 +222,8 @@ static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
>  static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *ke=
y, unsigned int keylen)
>  {
>  	struct ecc_ctx *ctx =3D akcipher_tfm_ctx(tfm);
> +	unsigned int digitlen, ndigits;
>  	const unsigned char *d =3D key;
> -	const u64 *digits =3D (const u64 *)&d[1];
> -	unsigned int ndigits;
>  	int ret;
> =20
>  	ret =3D ecdsa_ecc_ctx_reset(ctx);
> @@ -238,12 +237,17 @@ static int ecdsa_set_pub_key(struct crypto_akcipher=
 *tfm, const void *key, unsig
>  		return -EINVAL;
> =20
>  	keylen--;
> -	ndigits =3D (keylen >> 1) / sizeof(u64);
> +	digitlen =3D keylen >> 1;
> +
> +	ndigits =3D DIV_ROUND_UP(digitlen, sizeof(u64));
>  	if (ndigits !=3D ctx->curve->g.ndigits)
>  		return -EINVAL;
> =20
> -	ecc_swap_digits(digits, ctx->pub_key.x, ndigits);
> -	ecc_swap_digits(&digits[ndigits], ctx->pub_key.y, ndigits);
> +	d++;
> +
> +	ecc_digits_from_bytes(d, digitlen, ctx->pub_key.x, ndigits);
> +	ecc_digits_from_bytes(&d[digitlen], digitlen, ctx->pub_key.y, ndigits);
> +
>  	ret =3D ecc_is_pubkey_valid_full(ctx->curve, &ctx->pub_key);
> =20
>  	ctx->pub_key_set =3D ret =3D=3D 0;
> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.=
h
> index 4f6c1a68882f..48a04605da7f 100644
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -56,6 +56,31 @@ static inline void ecc_swap_digits(const void *in, u64=
 *out, unsigned int ndigit
>  		out[i] =3D get_unaligned_be64(&src[ndigits - 1 - i]);
>  }
> =20
> +/**
> + * ecc_digits_from_bytes() - Create ndigits-sized digits array from byte=
 array
> + * @in:       Input byte array
> + * @nbytes    Size of input byte array
> + * @out       Output digits array
> + * @ndigits:  Number of digits to create from byte array
> + */
> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbyt=
es,
> +					 u64 *out, unsigned int ndigits)
> +{
> +	unsigned int o =3D nbytes & 7;
> +	u64 msd =3D 0;
> +	size_t i;
> +
> +	if (o =3D=3D 0) {
> +		ecc_swap_digits(in, out, ndigits);
> +	} else {
> +		/* if key length is not a multiple of 64 bits (NIST P521) */
> +		for (i =3D 0; i < o; i++)
> +			msd =3D (msd << 8) | in[i];
> +		out[ndigits - 1] =3D msd;
> +		ecc_swap_digits(&in[o], out, (nbytes - o) >> 3);
> +	}

https://lore.kernel.org/keyrings/CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero/

BR, Jarkko

