Return-Path: <linux-kernel+bounces-106621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF587F112
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA85282DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E47557879;
	Mon, 18 Mar 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI0ivwG0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456D38395;
	Mon, 18 Mar 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793284; cv=none; b=f8ybR4ydYkZV7SN2hqThJJxgJuplLsn4FZDc4bkW/ENBPu+qCOUpN+T29JOS78+Nmx5rLDMzaPoTf/5giBInHamfD/51grjgvCA8z4hYiNW0is5UCIO6fqV4oSnq/ifbj9KmuBBTT5dhFBDuWLEqggAMyV38Ke1fSH2LtwRbuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793284; c=relaxed/simple;
	bh=xbA+A4Sn/jWGynEOPEAKuBYZCVmC+y7CRcBOCeWJZXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XRIU4Cj/s3KoV4aQn5V6GsWYe3sAs7Lk4jdYOyJViRgt/LKtNq5Js8zOBgCozyit0OM4Y+ggtcrMmYzqSPC2Hxvl0kZmqnuZElLMUQBuaQ2IUp7cpp4DnjUpMNU1Qkqr+S163SK1d7ehodrpj8706tozhyt6Ms6ULiIFEKMKbq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI0ivwG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35268C433F1;
	Mon, 18 Mar 2024 20:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710793284;
	bh=xbA+A4Sn/jWGynEOPEAKuBYZCVmC+y7CRcBOCeWJZXk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uI0ivwG06Pxa8J9A3Mh+EfAY2GBr9iYDKGKlXy8tCJ9DATJYWAVRZ1jpD3GEh0y/r
	 Rm1ZzjZaXbrcmepg1+Og+RZKxHLYbxypn1uwMDbQQRTrqeyRWFSHQv1dUTkrSxS+Zd
	 RQ1WFwRcD0uLUH/3tdYsdNKASphaYvq3oTG91ifuLckGXzCOj/HEq8+yLNAz39KVoa
	 FIw8jQfvnUZVYC1b8VB7dWOX3819cb4yOHoRAYWOA0xKy6dMKU9PXOnbgFXyC7YGqZ
	 bR90CQTLS7qn98S2KTdmtmeDyzdLSfMUO2dkagpga1kF8rp4aoci70ieuoGCxt0e7f
	 YrXSGSgndJ8nw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 22:21:20 +0200
Message-Id: <CZX5LR621YXT.A2MGGVPKINOG@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 02/13] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-3-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-3-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> For NIST P192/256/384 the public key's x and y parameters could be copied
> directly from a given array since both parameters filled 'ndigits' of

We "could" do various things but a commit message should describe the
gain or motivation of doing something, even if you think it should be
obvious.


> digits (a 'digit' is a u64). For support of NIST P521 the key parameters
> need to have leading zeros prepended to the most significant digit since
> only 2 bytes of the most significant digit are provided.
>
> Therefore, implement ecc_digits_from_bytes to convert a byte array into a=
n
> array of digits and use this function in ecdsa_set_pub_key where an input
> byte array needs to be converted into digits.

Please, dscribe the format of "array of digits" instead of waving hands
here.


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

This pointer increment is more confusing...

> +
> +	ecc_digits_from_bytes(d, digitlen, ctx->pub_key.x, ndigits);

..than "&d[1]" which would also match better the earlier code.


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

BR, Jarkko

