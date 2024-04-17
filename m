Return-Path: <linux-kernel+bounces-149290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5795C8A8EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC041C21592
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED57A80626;
	Wed, 17 Apr 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0Fro5Q2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433F3B185;
	Wed, 17 Apr 2024 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393820; cv=none; b=X+Gsjs9nBjf4ugoV2/Og0MYYrRtO3eBKPTLOJmde+Vwa1JUZD/VcXZr0SvaMKDGUMQ/umHFv8PmWXBws00THfV4nYvi2r39elVOSIP8G60mOxF/0JM92WsOzH4j0U3rhyS/c7NYhZMdRrpUDwSflwLa+HaujyaYw9OP5ggAqT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393820; c=relaxed/simple;
	bh=+14QJeMdBGkxgTOPkn5IuAtb7i8tyHYVDWYbHI+Wlzs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fe2cCAZn4oi/EL2WKLfWpOLEGzGYBvfCet5BWXfuuY/OacEUUInskjAvXEBu0BvQx+7b6a0guG3QskfErpMWtISCvc+5v7dztyinugS4rqgiVNBzZfn6+G2b7vVzcXpjyJ/hiGePYPgQtgW/5nyH+GOnIxB53P7u7EH7hshpaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0Fro5Q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C771CC072AA;
	Wed, 17 Apr 2024 22:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713393819;
	bh=+14QJeMdBGkxgTOPkn5IuAtb7i8tyHYVDWYbHI+Wlzs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=W0Fro5Q2xaFBYjQ95s5sdi8WsgC6vfd9+30Q+g8HXD4EGxKvve3NDDmGO1M+qMy51
	 yLIEf/tI8uiArjqeXoICDqvTlDqSY6FzjNZ6LcnEMUWZmFzda77GqxpixOWMrkljHS
	 E4bwe4uzxcygaYk3HkRYbYUI3j4CUlAOICSbj5gXvfbpjX0xbjhIKwPsnc00alJbG+
	 f8mUSHo9PzVOqIzxBsEQUIQAJaGBpK2QR6H5FCWVl/vyAhdJvv+fO7Q2KmbJCbDvAx
	 YZ17Psomc2pBig3oKEv1Hpgvdo4kOBnX7pCxpOHkHtKU20ITNvEJANzqZ5d5k/xwEw
	 14gQa27fYx42g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 01:43:35 +0300
Message-Id: <D0MRF0NXMBZ4.1N89J0L8RWWBM@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <ardb@kernel.org>,
 <salvatore.benedetto@intel.com>, <git@jvdsn.com>
Subject: Re: [PATCH v2 2/2] crypto: ecdh & ecc - Initialize ctx->private_key
 in proper byte order
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240417162117.2752326-1-stefanb@linux.ibm.com>
 <20240417162117.2752326-3-stefanb@linux.ibm.com>
In-Reply-To: <20240417162117.2752326-3-stefanb@linux.ibm.com>

On Wed Apr 17, 2024 at 7:21 PM EEST, Stefan Berger wrote:
> The private key in ctx->private_key is currently initialized in reverse
> byte order in ecdh_set_secret and whenever the key is needed in proper
> byte order the variable priv is introduced and the bytes from
> ctx->private_key are copied into priv while being byte-swapped
> (ecc_swap_digits). To get rid of the unnecessary byte swapping initialize
> ctx->private_key in proper byte order and clean up all functions that wer=
e
> previously using priv or were called with ctx->private_key:
>
> - ecc_gen_privkey: Directly initialize the passed ctx->private_key with
>   random bytes and get rid of the priv variable. This function only has
>   ecdh_set_secret as a caller.
>
> - crypto_ecdh_shared_secret: Called only from ecdh_compute_value with
>   ctx->private_key. Get rid of the priv variable and work with the passed
>   private_key directly.
>
> - ecc_make_pub_key: Called only from ecdh_compute_value with
>   ctx->private_key. Get rid of the priv variable and work with the passed
>   private_key directly.
>
> Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  crypto/ecc.c                  | 29 ++++++++++-------------------
>  crypto/ecdh.c                 |  8 +++-----
>  include/crypto/internal/ecc.h |  3 ++-
>  3 files changed, 15 insertions(+), 25 deletions(-)
>
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index 2e05387b9499..c1d2e884be1e 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -1497,10 +1497,10 @@ EXPORT_SYMBOL(ecc_is_key_valid);
>   * This method generates a private key uniformly distributed in the rang=
e
>   * [2, n-3].
>   */
> -int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *pr=
ivkey)
> +int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits,
> +		    u64 *private_key)
>  {
>  	const struct ecc_curve *curve =3D ecc_get_curve(curve_id);
> -	u64 priv[ECC_MAX_DIGITS];
>  	unsigned int nbytes =3D ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
>  	unsigned int nbits =3D vli_num_bits(curve->n, ndigits);
>  	int err;
> @@ -1509,7 +1509,7 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned=
 int ndigits, u64 *privkey)
>  	 * Step 1 & 2: check that N is included in Table 1 of FIPS 186-5,
>  	 * section 6.1.1.
>  	 */
> -	if (nbits < 224 || ndigits > ARRAY_SIZE(priv))
> +	if (nbits < 224)
>  		return -EINVAL;
> =20
>  	/*
> @@ -1527,17 +1527,16 @@ int ecc_gen_privkey(unsigned int curve_id, unsign=
ed int ndigits, u64 *privkey)
>  		return -EFAULT;
> =20
>  	/* Step 3: obtain N returned_bits from the DRBG. */
> -	err =3D crypto_rng_get_bytes(crypto_default_rng, (u8 *)priv, nbytes);
> +	err =3D crypto_rng_get_bytes(crypto_default_rng,
> +				   (u8 *)private_key, nbytes);
>  	crypto_put_default_rng();
>  	if (err)
>  		return err;
> =20
>  	/* Step 4: make sure the private key is in the valid range. */
> -	if (__ecc_is_key_valid(curve, priv, ndigits))
> +	if (__ecc_is_key_valid(curve, private_key, ndigits))
>  		return -EINVAL;
> =20
> -	ecc_swap_digits(priv, privkey, ndigits);
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL(ecc_gen_privkey);
> @@ -1547,23 +1546,20 @@ int ecc_make_pub_key(unsigned int curve_id, unsig=
ned int ndigits,
>  {
>  	int ret =3D 0;
>  	struct ecc_point *pk;
> -	u64 priv[ECC_MAX_DIGITS];
>  	const struct ecc_curve *curve =3D ecc_get_curve(curve_id);
> =20
> -	if (!private_key || ndigits > ARRAY_SIZE(priv)) {
> +	if (!private_key) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> =20
> -	ecc_swap_digits(private_key, priv, ndigits);
> -
>  	pk =3D ecc_alloc_point(ndigits);
>  	if (!pk) {
>  		ret =3D -ENOMEM;
>  		goto out;
>  	}
> =20
> -	ecc_point_mult(pk, &curve->g, priv, NULL, curve, ndigits);
> +	ecc_point_mult(pk, &curve->g, private_key, NULL, curve, ndigits);
> =20
>  	/* SP800-56A rev 3 5.6.2.1.3 key check */
>  	if (ecc_is_pubkey_valid_full(curve, pk)) {
> @@ -1647,13 +1643,11 @@ int crypto_ecdh_shared_secret(unsigned int curve_=
id, unsigned int ndigits,
>  {
>  	int ret =3D 0;
>  	struct ecc_point *product, *pk;
> -	u64 priv[ECC_MAX_DIGITS];
>  	u64 rand_z[ECC_MAX_DIGITS];
>  	unsigned int nbytes;
>  	const struct ecc_curve *curve =3D ecc_get_curve(curve_id);
> =20
> -	if (!private_key || !public_key ||
> -	    ndigits > ARRAY_SIZE(priv) || ndigits > ARRAY_SIZE(rand_z)) {
> +	if (!private_key || !public_key || ndigits > ARRAY_SIZE(rand_z)) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> @@ -1674,15 +1668,13 @@ int crypto_ecdh_shared_secret(unsigned int curve_=
id, unsigned int ndigits,
>  	if (ret)
>  		goto err_alloc_product;
> =20
> -	ecc_swap_digits(private_key, priv, ndigits);
> -
>  	product =3D ecc_alloc_point(ndigits);
>  	if (!product) {
>  		ret =3D -ENOMEM;
>  		goto err_alloc_product;
>  	}
> =20
> -	ecc_point_mult(product, pk, priv, rand_z, curve, ndigits);
> +	ecc_point_mult(product, pk, private_key, rand_z, curve, ndigits);
> =20
>  	if (ecc_point_is_zero(product)) {
>  		ret =3D -EFAULT;
> @@ -1692,7 +1684,6 @@ int crypto_ecdh_shared_secret(unsigned int curve_id=
, unsigned int ndigits,
>  	ecc_swap_digits(product->x, secret, ndigits);
> =20
>  err_validity:
> -	memzero_explicit(priv, sizeof(priv));
>  	memzero_explicit(rand_z, sizeof(rand_z));
>  	ecc_free_point(product);
>  err_alloc_product:
> diff --git a/crypto/ecdh.c b/crypto/ecdh.c
> index c02c9a2b9682..72cfd1590156 100644
> --- a/crypto/ecdh.c
> +++ b/crypto/ecdh.c
> @@ -27,7 +27,6 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, cons=
t void *buf,
>  			   unsigned int len)
>  {
>  	struct ecdh_ctx *ctx =3D ecdh_get_ctx(tfm);
> -	u64 priv[ECC_MAX_DIGITS];
>  	struct ecdh params;
>  	int ret =3D 0;
> =20
> @@ -41,15 +40,14 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, co=
nst void *buf,
>  		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
>  				       ctx->private_key);
> =20
> -	memcpy(ctx->private_key, params.key, params.key_size);
> -	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
> +	ecc_digits_from_bytes(params.key, params.key_size,
> +			      ctx->private_key, ctx->ndigits);
> =20
>  	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
> -			     priv, params.key_size) < 0) {
> +			     ctx->private_key, params.key_size) < 0) {
>  		memzero_explicit(ctx->private_key, params.key_size);
>  		ret =3D -EINVAL;
>  	}
> -	memzero_explicit(priv, sizeof(priv));
> =20
>  	return ret;
>  }
> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.=
h
> index 4e2f5f938e91..7ca1f463d1ec 100644
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -103,7 +103,8 @@ int ecc_is_key_valid(unsigned int curve_id, unsigned =
int ndigits,
>   * Returns 0 if the private key was generated successfully, a negative v=
alue
>   * if an error occurred.
>   */
> -int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *pr=
ivkey);
> +int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits,
> +		    u64 *private_key);
> =20
>  /**
>   * ecc_make_pub_key() - Compute an ECC public key

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

