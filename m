Return-Path: <linux-kernel+bounces-158046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5018A8B1A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC50DB22377
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1DA3D0AF;
	Thu, 25 Apr 2024 06:05:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96F29CE2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025135; cv=none; b=W+nrFn/VR09FFyG9lcx0GLpNdwJORIVNpoy2VGzDdaHbJpGJN56esE4mZIv76rYWJPPHxTHJ4/eUVLIandABu+h56bwY81wbiKbJwTXit3h6iCpk9D/1mzkSds5P+5kabbbEjTRPfBMb8R6Zb9SBpQcEIiwNmrRpfEQFq6Mg7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025135; c=relaxed/simple;
	bh=o7SOvOKMp6d+9/tnzagKptxY6P/L8e0n+ELyyxTFucE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2Y+d2nTVeC/FSarOr7vgbN2kyfJgqLjpuGaroODJrp5PsVmww3bZKdhegbYPuoVsjUgzfQR1EZtOvH5TZ/pzZnHqIwHwVcrK74Kke6LUNB9QsU8P7R/TSkh51VLTGkBC142MZa+qfKrLN4g2VR/iPunDOGuh505DnfGqkicSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzsE6-0002dC-N8; Thu, 25 Apr 2024 08:04:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzsE5-00ECy4-9C; Thu, 25 Apr 2024 08:04:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzsE5-008MNw-0a;
	Thu, 25 Apr 2024 08:04:57 +0200
Date: Thu, 25 Apr 2024 08:04:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: wuxilin123@gmail.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Junhao Xie <bigfoot@classfun.cn>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Molly Sophia <mollysophia379@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: pwm: Add SI-EN SN3112 PWM support
Message-ID: <76yqvvgy325tn5y7coco7bhh4igpvmo5wqi22ywgmhhgfgpv6m@itmklxmtxfip>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-1-e0aa05c991fd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eadnze5bbqoj4vrs"
Content-Disposition: inline
In-Reply-To: <20240424-ayn-odin2-initial-v1-1-e0aa05c991fd@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--eadnze5bbqoj4vrs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 24, 2024 at 11:29:06PM +0800, Xilin Wu via B4 Relay wrote:
> From: Junhao Xie <bigfoot@classfun.cn>
>=20
> Add a new driver for the SI-EN SN3112 12-channel 8-bit PWM LED controller.
>=20
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>

Missing S-o-b for patch submitter.

> +  "#pwm-cells":
> +    const: 1

please use 3 here (which is also what the driver implements)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eadnze5bbqoj4vrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYp8ogACgkQj4D7WH0S
/k4zrQf/S1fJNqwknskpQET3N1WZ6fn0TeIejoI6KyaPdanNXWjVkPLajTaOSyno
PbFKQMtrMmmS+mzVTIfJ2Tgqg63LanDYD68fprQwN7PXz21LNvAOCw77Fi6zgnQN
Xk4UVQdDKDZRcXiGBBL/9nJwC92yYXPy8L36daDuNR2SdD5uUwbOXG4wZFD/7J30
bFJkUHQML3BU6YlveahYEWQwSEmYmTY0Am3n2tQ3l8TuGeWzbQjKD/d2dxw2ncvX
wlbO9sBP4M8Htgz0EFkmiLzKcnTJiugX+HYp1whRvAXy5Df6a0CvTJRS3S821TMT
neaBsa+5hmcE/CrxnN0EoYEuzWMiUw==
=NVqY
-----END PGP SIGNATURE-----

--eadnze5bbqoj4vrs--

