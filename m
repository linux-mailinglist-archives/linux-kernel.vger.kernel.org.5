Return-Path: <linux-kernel+bounces-145739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0398A5A37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E96284C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C34155753;
	Mon, 15 Apr 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm9lnOTn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2784D24;
	Mon, 15 Apr 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207206; cv=none; b=cqmC160oqq8+ZLMsUsd10SED0hNuoZf/g0WvOEWqhq+a/SHwHorir1dQqNh45kai+8ctiVHvMl2D/21bC8vunuhrNhqlIIWNfZqeVs1u/VgiyrLcOmFijGUEGSwkfFc41/8+dPdGj1yeJv4Ii7qv7JbjZWcz9riTANB6wrhpzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207206; c=relaxed/simple;
	bh=UkUaj+YEBYtsKTapfAJux7C066BfGC//yi1ms4YuhCE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D9zTWWhNWXlu48BENST/8vCVrZqVNpw/5YtKC0HV+FmGf+vxto4ZiI5j7yU8UezimXL4DejH2nhbjARIN3OILp1E0c+G4Pj/X1GT1wSfLCw6QDki2UM+3qT7EhX7TanyKIlqVgczda3RvmcMCKesuNtLBsN8ZDw9yLxv6JJ6a0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm9lnOTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A6EC113CC;
	Mon, 15 Apr 2024 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713207206;
	bh=UkUaj+YEBYtsKTapfAJux7C066BfGC//yi1ms4YuhCE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qm9lnOTnsra/ebQMHfh+2A2rXpue5E6ciUWJM5F38MPvYC1UH/92p2N/S3/nZjG9I
	 qwweOWJ1iPX9ewNimlUbpdQ6x7KmL0pn1sTBuR/DQgPwQnzTCGbVgyVChIb0UvBdIM
	 9rhQ/1CJi7xV7CEEu0ALA1gSi2nIVCOaU6GtudFPG5Q6TcKPZAI6Cfnl3U14rOhhER
	 GUz0z7z+hqxtyovunJq18pwDDOSYJ45+r7/rqpz5PCcaWxwwS7cWdvnxqnmaiSdDJe
	 gn17T+fE+6JJP9V8DdA5IXPmu8ecvtqera/edq2jngIq25qgZx4dja+ms001Zg/C89
	 vdqrmswEPoKJg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 21:53:22 +0300
Message-Id: <D0KX9NQPXKO1.2RXZU000DD1BB@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <ardb@kernel.org>,
 <salvatore.benedetto@intel.com>
Subject: Re: [PATCH 1/2] crypto: ecdh - Pass private key in proper byte
 order to check valid key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240415003026.2661270-1-stefanb@linux.ibm.com>
 <20240415003026.2661270-2-stefanb@linux.ibm.com>
In-Reply-To: <20240415003026.2661270-2-stefanb@linux.ibm.com>

On Mon Apr 15, 2024 at 3:30 AM EEST, Stefan Berger wrote:
> ecc_is_key_valid expects a key with the most significant digit in the las=
t
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
> ---
>  crypto/ecdh.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/ecdh.c b/crypto/ecdh.c
> index 3049f147e011..a73853bd44de 100644
> --- a/crypto/ecdh.c
> +++ b/crypto/ecdh.c
> @@ -27,6 +27,7 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, cons=
t void *buf,
>  			   unsigned int len)
>  {
>  	struct ecdh_ctx *ctx =3D ecdh_get_ctx(tfm);
> +	u64 priv[ECC_MAX_DIGITS];
>  	struct ecdh params;
> =20
>  	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
> @@ -40,9 +41,10 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, con=
st void *buf,
>  				       ctx->private_key);
> =20
>  	memcpy(ctx->private_key, params.key, params.key_size);
> +	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);

Does swapping speed up the test that follows are what effect does it
have to the ecc_is_key_valid() call?

Just a question to understand what is going on, not actual review
feedback.

> =20
>  	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
> -			     ctx->private_key, params.key_size) < 0) {
> +			     priv, params.key_size) < 0) {
>  		memzero_explicit(ctx->private_key, params.key_size);
>  		return -EINVAL;
>  	}

BR, Jarkko

