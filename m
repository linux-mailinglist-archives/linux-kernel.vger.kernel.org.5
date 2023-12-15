Return-Path: <linux-kernel+bounces-1202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA34814B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EFC1C219A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85A139FD4;
	Fri, 15 Dec 2023 15:19:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876736B17
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE9xk-0003J2-Du; Fri, 15 Dec 2023 16:18:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE9xj-00G3c1-Nm; Fri, 15 Dec 2023 16:18:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE9xj-003enb-EM; Fri, 15 Dec 2023 16:18:51 +0100
Date: Fri, 15 Dec 2023 16:18:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: James Clark <james.clark@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
	linux-next@vger.kernel.org, will@kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] arm: perf: Fix ARCH=arm build with GCC in
 armv8pmu_write_evtype()
Message-ID: <20231215151851.24wwciobjy5ritoe@pengutronix.de>
References: <20231215150040.3342183-1-james.clark@arm.com>
 <20231215150040.3342183-2-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vcdax2erkxxsbf2h"
Content-Disposition: inline
In-Reply-To: <20231215150040.3342183-2-james.clark@arm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--vcdax2erkxxsbf2h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 15, 2023 at 03:00:38PM +0000, James Clark wrote:
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 23fa6c5da82c..3ed2086cefc3 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -631,8 +631,9 @@ static void armv8pmu_write_evtype(int idx, unsigned l=
ong val)
>  			     ARMV8_PMU_EXCLUDE_EL0 |
>  			     ARMV8_PMU_EXCLUDE_EL1;
> =20
> -	if (IS_ENABLED(CONFIG_ARM64))
> -		mask |=3D ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
> +#if IS_ENABLED(CONFIG_ARM64)
> +	mask |=3D ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
> +#endif

maybe add a comment about why you used an #if here, to prevent the
people sending patches that revert your change?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vcdax2erkxxsbf2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV8bloACgkQj4D7WH0S
/k5b/wf+MEL3zkiZL0BMTR7yyXPKpsqbEG64vTZcxWV48jxm51wX+huoGcM3aSQj
CbCT6/uFb6IrWF299Ed7zuLDV38aTvrB3PV9L7GBxhvAedqEMMaSrpBTxDlyTNNq
4LFwOnj0h8Cl2l3GTwgrUgBkzc5rIOh4RGr9f/tsXzcjHQ2GUNxdJQfg0UvoGcxx
0Qhlff3eZpuNcX6mWH3f5QGRaqGpV4pxYL3b2Ik9tSLA1tDqWlpv2CXCVAJk6ZLD
hKd96oJY4DVjs7skS4ouBOiUtEvqtcs87iuLUbLNGBzpjPAQ78cNLoV761PkjEBT
df7m1XwzDzVnjQrOkhjLOy3K4BV7Jw==
=ojPK
-----END PGP SIGNATURE-----

--vcdax2erkxxsbf2h--

