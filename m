Return-Path: <linux-kernel+bounces-110463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B2885F49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3801C2425F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7773385286;
	Thu, 21 Mar 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Z13RIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E2945A;
	Thu, 21 Mar 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040851; cv=none; b=T8m58bFNYtpB8sxGJPPM1OItE5mfcQz7/Sl3b8jfhy3y+ebSPHL50DZjmZTx3KQUaZV10kutV4RSJev2mdiIRWnMumdBZiSJ6OhI6+aN/XS8y6DO9fYGujiTinGPx5EaCgy4M1x/NAFcT+uSNzWG9qWSwuwLhpcmXoxChpO5mKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040851; c=relaxed/simple;
	bh=x31dRnanpuEOE+TpZoQKnEZnozJmN68318OzuXDtDHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=H77Yfo1Klx/vUsDN3u9282wHZC6j3F3tvdwjzalyoqvQfQM5Zfnofgm3+Oo+YRLt79v0nh3AOcOPYGzMypL+upbKNnmIU4SdUomFXpX4m9QoyAEoeszAh0dcjULVJgWssRfo/H5lwrcvaSTwmAWtvjD43KdQWoudXcjuEltV+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Z13RIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A529C433C7;
	Thu, 21 Mar 2024 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711040851;
	bh=x31dRnanpuEOE+TpZoQKnEZnozJmN68318OzuXDtDHs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=G/Z13RIl688aA2O0Ceok0bgt6upvgGDIlYJFOS4hkQ4Ok5+z4v7pN8+4fRPX7iYQc
	 waTBX0dRKi5r1JdlvtzqRvTRm8k4LoyprFBQvx7IDTfCV84dK/K7ANFSWg1uEkjUAn
	 HdxgppKneX9OMc+LQxbVIIvcPH1Cee74cwJJ4hrRi25qAJu1qGxG1+jLOgoL40QvUQ
	 9HQQHK2RnSvTkrGil9ph/L7bqVt6xQQ+Wg6KhSKl9rBuVvtsAEZ0RjnTnN3pXc3IrM
	 CXeX/3hRuB1ZoMW5etj2vgoUeb5lH2yq6AUWNlxvu4EbM5eEsN43Axrh7200z2AL6u
	 Z5IFhcrLFbyFQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:07:27 +0200
Message-Id: <CZZLCXZUZVUP.3OMCAU6AHJ6WB@kernel.org>
Subject: Re: [PATCH v7 02/13] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-3-stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-3-stefanb@linux.ibm.com>

On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
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
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecdsa.c                | 14 +++++++++-----
>  include/crypto/internal/ecc.h | 21 +++++++++++++++++++++
>  2 files changed, 30 insertions(+), 5 deletions(-)
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
> index 4f6c1a68882f..ab722a8986b7 100644
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -56,6 +56,27 @@ static inline void ecc_swap_digits(const void *in, u64=
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
> +	__be64 msd =3D 0;
> +
> +	if (o) {
> +		memcpy((u8 *)&msd + sizeof(msd) - o, in, o);
> +		out[--ndigits] =3D be64_to_cpu(msd);
> +		in +=3D o;
> +	}
> +	ecc_swap_digits(in, out, ndigits);
> +}
> +
>  /**
>   * ecc_is_key_valid() - Validate a given ECDH private key
>   *

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

