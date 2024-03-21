Return-Path: <linux-kernel+bounces-110479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFFF885F80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990321F2438B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1E762EB;
	Thu, 21 Mar 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+MJN64d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B6E79E0;
	Thu, 21 Mar 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041526; cv=none; b=lhg9vvUul/JQjxe3M1JO7Nn2H1K1wfPj6GtXSvDm4F5Qe8EXS77+l029HJZLQVfQR88xrm7M5GaMz4j41p6rBDuIzdE/pd7ewVDYW6Ia/KMRhB0l3adwfcULruC8l68F2j8OCPcQAPcHHqD/XIV+SNcu/8Ql9r7qjt+Bxqy4fec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041526; c=relaxed/simple;
	bh=MYnh+31E98SgBIrjhR594cbuy75Zbq1Yl+5mK+4i7kM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CAqx1rxc+UMEfhaq2Y/96eFVipCKVardAeAgxuYEPZuldfLlPHGsYaAqqQ2y+GERpkNVjBD9146JegmEbH5HmaS9AwHK7DM/eOpvV99r/81M0wItJxpYE660uPpWIfwz104N2grhDjd6ZU8T2rZmjczKHcHbDMyo2KVtWuhjlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+MJN64d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5844DC43390;
	Thu, 21 Mar 2024 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041526;
	bh=MYnh+31E98SgBIrjhR594cbuy75Zbq1Yl+5mK+4i7kM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=I+MJN64dUWgymtd+VwDW15uSGG84tvCmNMtawhrQ+mHDB97VER0hOwQq/VH+qxl3e
	 +v4SJ/H/cLVsi3GgqlnW5MtSquSYSb82gl41UDrd/z19swG8Y018SBFoSmUoWZYZAh
	 q0fEkZRbcopWLqTbCXhMUnVkmjgqMkpiYhex5pFGZ0vrcLU+C1RTuLdcXGdKwMDarQ
	 M2WV/4N8miAqHehPWNiivnHv5a8kJPc0mFzxOEIU7KXrXFxX5C2el+3bk+g6Cu5ufG
	 Ru89/OfML0T708Vm11t9EINIYvQEITETskcdVSTg7CqwUKOP5SVMNaMNXqxMSh+8f0
	 OYFMIUuhh6+1w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:18:42 +0200
Message-Id: <CZZLLJZZ65UD.1KGYIWJ2KJT1X@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>
Subject: Re: [PATCH v7 06/13] crypto: ecc - Implement vli_mmod_fast_521 for
 NIST p521
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-7-stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-7-stefanb@linux.ibm.com>

On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> Implement vli_mmod_fast_521 following the description for how to calculat=
e
> the modulus for NIST P521 in the NIST publication "Recommendations for
> Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
> section G.1.4.
>
> NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
> the vli digit array provides enough elements to fit the larger integers
> required by this curve.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecc.c                  | 25 +++++++++++++++++++++++++
>  include/crypto/internal/ecc.h |  3 ++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index 415a2f4e7291..99d41887c005 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -902,6 +902,28 @@ static void vli_mmod_fast_384(u64 *result, const u64=
 *product,
>  #undef AND64H
>  #undef AND64L
> =20
> +/*
> + * Computes result =3D product % curve_prime
> + * from "Recommendations for Discrete Logarithm-Based Cryptography:
> + *       Elliptic Curve Domain Parameters" section G.1.4
> + */
> +static void vli_mmod_fast_521(u64 *result, const u64 *product,
> +			      const u64 *curve_prime, u64 *tmp)
> +{
> +	const unsigned int ndigits =3D ECC_CURVE_NIST_P521_DIGITS;
> +	size_t i;
> +
> +	/* Initialize result with lowest 521 bits from product */
> +	vli_set(result, product, ndigits);
> +	result[8] &=3D 0x1ff;
> +
> +	for (i =3D 0; i < ndigits; i++)
> +		tmp[i] =3D (product[8 + i] >> 9) | (product[9 + i] << 55);
> +	tmp[8] &=3D 0x1ff;
> +
> +	vli_mod_add(result, result, tmp, curve_prime, ndigits);
> +}
> +
>  /* Computes result =3D product % curve_prime for different curve_primes.
>   *
>   * Note that curve_primes are distinguished just by heuristic check and
> @@ -941,6 +963,9 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>  	case ECC_CURVE_NIST_P384_DIGITS:
>  		vli_mmod_fast_384(result, product, curve_prime, tmp);
>  		break;
> +	case ECC_CURVE_NIST_P521_DIGITS:
> +		vli_mmod_fast_521(result, product, curve_prime, tmp);
> +		break;
>  	default:
>  		pr_err_ratelimited("ecc: unsupported digits size!\n");
>  		return false;
> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.=
h
> index ab722a8986b7..4e2f5f938e91 100644
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -33,7 +33,8 @@
>  #define ECC_CURVE_NIST_P192_DIGITS  3
>  #define ECC_CURVE_NIST_P256_DIGITS  4
>  #define ECC_CURVE_NIST_P384_DIGITS  6
> -#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
> +#define ECC_CURVE_NIST_P521_DIGITS  9
> +#define ECC_MAX_DIGITS              DIV_ROUND_UP(521, 64) /* NIST P521 *=
/
> =20
>  #define ECC_DIGITS_TO_BYTES_SHIFT 3
> =20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

