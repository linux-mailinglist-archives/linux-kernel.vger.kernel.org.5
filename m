Return-Path: <linux-kernel+bounces-158052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623688B1AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949FC1C213A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8F3D971;
	Thu, 25 Apr 2024 06:08:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014303C466
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025330; cv=none; b=jwvzhzyv14c8ro9zauRk9j1Nx0vvVHIbKICkPi6Ws/PEe21BymqpQo5e6zvkhNEgqwvvaCWNcVXJGvjZgtFZfhQevygW+y161Z02Vggi3pUthZbcCrZxgl0BaT1qffLg33W8NFAVfcsBQsT44U+VrpJqUUUIvx72tv++6Nz/Qfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025330; c=relaxed/simple;
	bh=xm4lJVgPXqL1ldM/qcSHe43N26hkKvKIxlWsVth/exk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enSxbUYUeCXpC+f48Wxr2LTmW5hKADBnqI8232Muspm0YpyUvr3MWKCo5IIHUKuZLFP1TvdbwoPXIz1D8vwI+HXe3yDpM1doSd1OxCjgMsbl3+R8wmGixYmtEuF5o1hYwiVddd/MLUoOcILJWPJc23XuaHy3konBnr8wihpFrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzsHV-0003tM-OE; Thu, 25 Apr 2024 08:08:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzsHT-00ECyT-5a; Thu, 25 Apr 2024 08:08:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzsHT-008MV3-0D;
	Thu, 25 Apr 2024 08:08:27 +0200
Date: Thu, 25 Apr 2024 08:08:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Xilin Wu <wuxilin123@gmail.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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
Subject: Re: [PATCH 02/10] pwm: Add SI-EN SN3112 PWM support
Message-ID: <7j7d3ygupaprtryygxlpyjezd6naaaevrnzrpybxe7twcvuhbm@fzmswsfql37r>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-2-e0aa05c991fd@gmail.com>
 <17d36836-67cb-4d5a-a8b4-ecf1517a0020@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zh4yvalyaaytqrij"
Content-Disposition: inline
In-Reply-To: <17d36836-67cb-4d5a-a8b4-ecf1517a0020@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zh4yvalyaaytqrij
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 24, 2024 at 04:55:26PM +0100, Bryan O'Donoghue wrote:
> On 24/04/2024 16:29, Xilin Wu via B4 Relay wrote:
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
>=20
> Includes should be alphabetised

Also check if you need them all. (E.g. I wonder about delay.h)

> > +	dev_dbg(priv->pdev, "request regmap_write 0x%x 0x%x\n", reg, val);
> > +	err =3D regmap_write(priv->regmap, reg, val);
> > +	if (err)
> > +		dev_warn_ratelimited(
> > +			priv->pdev,
> > +			"regmap_write to register 0x%x failed: %pe\n", reg,
> > +			ERR_PTR(err));
>=20
> Multi-line should be encapsulated in {}
>=20
> if (err) {
> 	stuff
> 	goes here
> }

In my eyes a single state doesn't need {} even when spanning multiple
lines.

> > +	return err;
> > +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zh4yvalyaaytqrij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYp81oACgkQj4D7WH0S
/k6kxAf/c1u90d3vIMOZL5Sy8DR9MgBQGKJaZnQQUCk3HIdQyVyA4LhxHyxHiO/e
oLm0HCG9idBnRK5mTyNmtWhLg0djTCR6DxSeGUhuAPa3Nr6BZGMTYYkU0ESYIFcW
bKRxD29EiCcTvj0d7Ls5XwvXmmWTRkPMgoCXgtD2FDmyPCXvhfIEpOp+B8pvN/LD
rToO/lFSpmxBzT9sOCqoT/4nCjOSKh/NZXuilf/zbxArH0gKjnTzSek0OFH+nC2s
/oLGB00jxl8YKpSoUU0N67bbmnhYbLTVCed0yBT3wp9K1Mn9BBTns35UVkit5ytW
SwUooPCJ8Mvb64kcHSgtz4CKCq7BdQ==
=QM2k
-----END PGP SIGNATURE-----

--zh4yvalyaaytqrij--

