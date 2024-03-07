Return-Path: <linux-kernel+bounces-96074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455608756C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01485283702
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCFF136643;
	Thu,  7 Mar 2024 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqi4kDuB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0412FF8C;
	Thu,  7 Mar 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838702; cv=none; b=SuKskkIjEQnDsY6XQWS9D/YaZXlZnAoy52nlXk0hprVfuqcKSIwvGRFjhKY+LVJ3feg0y2kInym/FUv6NxCo1Qg2lsBMF9tCRXwaElNt8C4jBJ3sjekhiEj3drNcu1QrsE33PDKeVCIcDAcJScXqQT4EG6nmj8VSoMMhlLP3OIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838702; c=relaxed/simple;
	bh=fol1BOoCpwI0WdVUr7vg75bkd5E3nq3lMKDX8NsltnI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nUVGUdptYM7uvHLRCsMcn0RrVyWgbJwhzMlIyhp0KJZocijvIrOBH51RC9eCFGO5Zgrm0udFffkhCODoxnFIfJn4tYSNTgUhJ7HcCfGSiYUyRRpfpTIliRNRTAnn7ZTymMHLsBqMDoaGqO2gh10QOdFPjTpsX3ldAe4YEZ3Jb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqi4kDuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E084C43390;
	Thu,  7 Mar 2024 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709838701;
	bh=fol1BOoCpwI0WdVUr7vg75bkd5E3nq3lMKDX8NsltnI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Oqi4kDuBIkpmoJLiq5UO2jFg1qrAFcaNp2FJuhOGN5KFWq/Thfo1ARYh6zgu1OMdG
	 Z35ed1XE0wsQGqdoRBNGCoXLj7woNMZkaCiUrlEKvmMI3b1vQQx9g4gPmzgCq/tIA7
	 NIdxN5tIr0bdilHFvnaKYpiewL48KYRQk0X7wvrQH43bEFYgFR0cmvohpyz3kGI5ug
	 /InWYjYuAcQ/nztUWZTmkdWfVoYqhNOvVbSDgUovfOv0hiLwQmZ6Rdw0gGCqVbr8D8
	 FjbKESSifY2UbCduxYIrq0Ug8Jkyv1rwJVPQFlmR/ctwK8zpzU1JxLuqYHcMdowPdU
	 RME2vS5NoSo3A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 21:11:37 +0200
Message-Id: <CZNR8E07IQ14.301SKAK0CJX1G@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>
Subject: Re: [PATCH v5 05/12] crypto: ecc - Implement vli_mmod_fast_521 for
 NIST p521
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-6-stefanb@linux.ibm.com>
In-Reply-To: <20240306222257.979304-6-stefanb@linux.ibm.com>

On Thu Mar 7, 2024 at 12:22 AM EET, Stefan Berger wrote:
> Implement vli_mmod_fast_521 following the description for how to calculat=
e
> the modulus for NIST P521 in the NIST publication "Recommendations for
> Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
> section G.1.4.
>
> NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
> arrays fit the larger numbers.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecc.c                  | 31 +++++++++++++++++++++++++++++++
>  include/crypto/internal/ecc.h |  2 +-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index f53fb4d6af99..373660e7b19d 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -902,6 +902,31 @@ static void vli_mmod_fast_384(u64 *result, const u64=
 *product,
>  #undef AND64H
>  #undef AND64L
> =20
> +/* Computes result =3D product % curve_prime

Missing empty comment line:

/*
 *

> + * from "Recommendations for Discrete Logarithm-Based Cryptography:
> + *       Elliptic Curve Domain Parameters" G.1.4
> + */
> +static void vli_mmod_fast_521(u64 *result, const u64 *product,
> +				const u64 *curve_prime, u64 *tmp)
> +{
> +	const unsigned int ndigits =3D 9;
> +	size_t i;
> +
> +	for (i =3D 0; i < ndigits; i++)
> +		tmp[i] =3D product[i];
> +	tmp[8] &=3D 0x1ff;
> +
> +	vli_set(result, tmp, ndigits);
> +
> +
> +	for (i =3D 0; i < ndigits; i++)
> +		tmp[i] =3D (product[8 + i] >> 9) | (product[9 + i] << 55);
> +	tmp[8] &=3D 0x1ff;
> +
> +	vli_mod_add(result, result, tmp, curve_prime, ndigits);
> +}
> +
> +
>  /* Computes result =3D product % curve_prime for different curve_primes.
>   *
>   * Note that curve_primes are distinguished just by heuristic check and
> @@ -941,6 +966,12 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>  	case 6:
>  		vli_mmod_fast_384(result, product, curve_prime, tmp);
>  		break;
> +	case 9:
> +		if (curve->nbits =3D=3D 521) {

Missing inline comment about the branching decision, and has a magic
number.

> +			vli_mmod_fast_521(result, product, curve_prime, tmp);
> +			break;
> +		}
> +		fallthrough;
>  	default:
>  		pr_err_ratelimited("ecc: unsupported digits size!\n");
>  		return false;
> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.=
h
> index 4a556b41873e..de17bcdeb53a 100644
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -33,7 +33,7 @@
>  #define ECC_CURVE_NIST_P192_DIGITS  3
>  #define ECC_CURVE_NIST_P256_DIGITS  4
>  #define ECC_CURVE_NIST_P384_DIGITS  6
> -#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
> +#define ECC_MAX_DIGITS              DIV_ROUND_UP(521, 64) /* NIST P521 *=
/
> =20
>  #define ECC_DIGITS_TO_BYTES_SHIFT 3
> =20

BR, Jarkko

