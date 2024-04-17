Return-Path: <linux-kernel+bounces-149289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B553B8A8EED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B9B1C2136E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576C480626;
	Wed, 17 Apr 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyqqWAg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B333B185;
	Wed, 17 Apr 2024 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393750; cv=none; b=c/SblnJx6IpC4vX6kNhVq9+oi31Y5pE7X5Ndb0jHX5yvNtlRzn5YP2HtcjzuI5B6zl8Q+ByAHp22Gcvr2BeKt/pofXP5REBqLSPWfWV/YCRG5nAez7/dYqxdN/wASA/JP75a4dqY0hwABzBFvoqyyiUd4GlhALwz5TlhcPPT69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393750; c=relaxed/simple;
	bh=XWbQF5jD2/m0tERk6PZrN0PJtQTcq3cUhXrLmYsfu0I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AsuceNmDR19UJidjDJ4ePMqRem1EMAXoZRFka0Yfr0a4VsPLyTFY+0nJNyv93fbatS8dq8lrBEQ0ocluwjrAKOXVhW57ZJ6gkfra0+rDPAtvNcQvjRPUPIMFStHmPiSjNMjFqCyCAo0sje0bhplA/lSl143Rp47mPgXr5RvUq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyqqWAg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BCBC072AA;
	Wed, 17 Apr 2024 22:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713393750;
	bh=XWbQF5jD2/m0tERk6PZrN0PJtQTcq3cUhXrLmYsfu0I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DyqqWAg+82aIDxJpTcIQMPdxLK043FPaSnw0h3g6IKnBoi6nXZqs3CHoWRHlYNg5V
	 oEnC4LYtDRgDO+a2OZGgMoY/axWmxUgcWc9RSzblWPX6gsVusfp6krhxDo4qRSbIsD
	 O26BpBe4jDdPjpannmnZSiairkhzYbT5Zo8vv95lJQpvzoTDTveR3j2NUtWifxAx9a
	 9j+yCVQFM4Nd4YgIEGEMIeiTKWn9Fl/cJ+MDIc9B+V65B5UlIQCiWKqVDRnlPIWAO1
	 jCWNq1DF5MN3NJ8LMHkfMOKWpk18DHF6ztHUKDg2kUFV/orHTrElozlHx3d6/rLG7/
	 2jTSMq7RD0GkQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 01:42:26 +0300
Message-Id: <D0MRE4S5ROYW.32RRXAFQMD2W1@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <ardb@kernel.org>,
 <salvatore.benedetto@intel.com>, <git@jvdsn.com>
Subject: Re: [PATCH v2 1/2] crypto: ecdh - Pass private key in proper byte
 order to check valid key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240417162117.2752326-1-stefanb@linux.ibm.com>
 <20240417162117.2752326-2-stefanb@linux.ibm.com>
In-Reply-To: <20240417162117.2752326-2-stefanb@linux.ibm.com>

On Wed Apr 17, 2024 at 7:21 PM EEST, Stefan Berger wrote:
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
>  crypto/ecdh.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/crypto/ecdh.c b/crypto/ecdh.c
> index 3049f147e011..c02c9a2b9682 100644
> --- a/crypto/ecdh.c
> +++ b/crypto/ecdh.c
> @@ -27,7 +27,9 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, cons=
t void *buf,
>  			   unsigned int len)
>  {
>  	struct ecdh_ctx *ctx =3D ecdh_get_ctx(tfm);
> +	u64 priv[ECC_MAX_DIGITS];
>  	struct ecdh params;
> +	int ret =3D 0;
> =20
>  	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
>  	    params.key_size > sizeof(u64) * ctx->ndigits)
> @@ -40,13 +42,16 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, co=
nst void *buf,
>  				       ctx->private_key);
> =20
>  	memcpy(ctx->private_key, params.key, params.key_size);
> +	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
> =20
>  	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
> -			     ctx->private_key, params.key_size) < 0) {
> +			     priv, params.key_size) < 0) {
>  		memzero_explicit(ctx->private_key, params.key_size);
> -		return -EINVAL;
> +		ret =3D -EINVAL;
>  	}
> -	return 0;
> +	memzero_explicit(priv, sizeof(priv));
> +
> +	return ret;
>  }
> =20
>  static int ecdh_compute_value(struct kpp_request *req)

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

