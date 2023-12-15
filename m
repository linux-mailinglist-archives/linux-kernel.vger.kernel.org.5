Return-Path: <linux-kernel+bounces-1519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4164B814FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2041C23E29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE283FB30;
	Fri, 15 Dec 2023 18:20:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169730139
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rECna-0005Cl-42; Fri, 15 Dec 2023 19:20:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rECnZ-00G5Nx-Bc; Fri, 15 Dec 2023 19:20:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rECnZ-003kV5-2H; Fri, 15 Dec 2023 19:20:33 +0100
Date: Fri, 15 Dec 2023 19:20:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: James Clark <james.clark@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
	linux-next@vger.kernel.org, will@kernel.org, mark.rutland@arm.com,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/1] arm: perf: Fix ARCH=arm build with GCC
Message-ID: <20231215182032.yainbyffntkqpkye@pengutronix.de>
References: <20231215175648.3397170-1-james.clark@arm.com>
 <20231215175648.3397170-2-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="itsdxshq7bgb2hps"
Content-Disposition: inline
In-Reply-To: <20231215175648.3397170-2-james.clark@arm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--itsdxshq7bgb2hps
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 05:56:48PM +0000, James Clark wrote:
> LLVM ignores everything inside the if statement and doesn't generate
> errors, but GCC doesn't ignore it, resulting in the following error:
>=20
>   drivers/perf/arm_pmuv3.c: In function =E2=80=98armv8pmu_write_evtype=E2=
=80=99:
>   include/linux/bits.h:34:29: error: left shift count >=3D width of type =
[-Werror=3Dshift-count-overflow]
>   34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
>=20
> Fix it by using GENMASK_ULL which doesn't overflow on arm32 (even though
> the value is never used there).
>=20
> Fixes: 3115ee021bfb ("arm64: perf: Include threshold control fields in PM=
EVTYPER mask")
> Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Closes: https://lore.kernel.org/linux-arm-kernel/20231215120817.h2f3akgv7=
2zhrtqo@pengutronix.de/
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  include/linux/perf/arm_pmuv3.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv=
3.h
> index 0f4d62ef3a9a..46377e134d67 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -234,8 +234,8 @@
>   * PMXEVTYPER: Event selection reg
>   */
>  #define ARMV8_PMU_EVTYPE_EVENT	GENMASK(15, 0)	/* Mask for EVENT bits */
> -#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
> -#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)
> +#define ARMV8_PMU_EVTYPE_TH	GENMASK_ULL(43, 32) /* arm64 only */
> +#define ARMV8_PMU_EVTYPE_TC	GENMASK_ULL(63, 61) /* arm64 only */

As expected this fixes compilation on my end, too and it's nicer than
v1.

Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--itsdxshq7bgb2hps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV8mPAACgkQj4D7WH0S
/k70Nwf/RKlhvu5kU7OLm1mwdjKU6aYfvAZkSBnFv1UIDqNO8kUiqQ1LNc7dYKYT
+fmz88BDDkzJF8QYG73bLrwtn9paSrbPxc6kg24tdp2mH4Fq8FuDH7FuMK1Dd8CW
L9zcHcVt1ymmRmY86UgGxSihpmeXFbqg+dt0R67TiWE/4fGMe2ilVFHtaYpZfE1s
cw0fN2tiFUqbpWu50lokbStcsxkwhZ4RF1OCodVW4vPYUDnYyvLc/P//GS3Er6vn
aVCFZT9WoUom77pG9L0q2f5CmZeUHC0ra2qAnguUvCIja3goldOYe0LKgetBcpK6
PunHLJ35H+n7OoDkZiBm9fedtquNmw==
=E8iy
-----END PGP SIGNATURE-----

--itsdxshq7bgb2hps--

