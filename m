Return-Path: <linux-kernel+bounces-106632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3D87F137
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796FD1C21718
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3388258128;
	Mon, 18 Mar 2024 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8Catys+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A81862C;
	Mon, 18 Mar 2024 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794141; cv=none; b=NEa+mUuxTk6Gskvm36TBeyVxq5C0q3Mm3N1ateJqeoVd5W7S9UZaMTrI53W1EHqHswlnbh4xgBXZDv3gB/8/MaZ2v/JMvJbgP/0B5t5Y3pmcAcVvjt+WZFEr1PXRaKCnvmDidGxRfsAtzqQ9H0PHXJQ13eJYy9tzPth0KhiFBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794141; c=relaxed/simple;
	bh=orWSS3XjvgfjIC9DwWOLzXoI8+NsAFOPJClCk6qbYZI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cfwdBVZGcSvvXPqGEBBO+OmpJj8pLsfCX3MKrX3M6q5rhx1U8am5eLB6snQBB3f9T7UEFfabaMe1vofbdU5q4RUrPUnoV1SfLtIdthhHYUTzdjr5U/DbRrVY4zbAgNQFPKn3rSXnq/db9GDx1M5B9EBFlxojaeaJOCb+WWEA1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8Catys+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E436BC433C7;
	Mon, 18 Mar 2024 20:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794140;
	bh=orWSS3XjvgfjIC9DwWOLzXoI8+NsAFOPJClCk6qbYZI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=q8Catys+haXMiigzK4cBnscaZ1jbDck+drKVXs1es3K/vt/gGsVVPMtDhMcB68AG2
	 wL/Sm6etyvLdYRS6u6NKjevg/6YVJc6ENgxS1wHpnYNB+WnfI2Bvlup7zBz2IA73TV
	 HBkOgxJDdtTedYFR+x5+w5rtq0ZQqNFQmVwGh4OMDTFbYWT2PhK1nVLE1tNFAyeEv6
	 aZFx4BV5ug0/Hr2wfSAjFUNiEUHTDLIRrLaO4PxZTJKoY/qmGuEJ0W20MHNSqUe2mQ
	 KqBj8ecJZm1MPd9VA0/M+b0JJ7aZ1kLCmwjQLTB5pPlTT+U3KpuApIKqtcvzyhLPCU
	 llY4WLf32aSZQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 22:35:37 +0200
Message-Id: <CZX5WOTXS1KU.31Z1MRFBC1B0@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 06/13] crypto: ecc - Implement vli_mmod_fast_521 for
 NIST p521
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-7-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-7-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
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

Should provide context on what it will be used (for completeness).


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

Otherwise, lgtm

BR, Jarkko

