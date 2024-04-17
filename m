Return-Path: <linux-kernel+bounces-148101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D98A7DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC6328134C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6BA7CF39;
	Wed, 17 Apr 2024 08:06:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D256BFB3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341213; cv=none; b=kHo9EW3qF69U/lDuT+VQ8icLIql2qcAfknVzg4WcuQZudFmc38h6PjOn6mtDZtmrPPD5OE2+c2WqSdzAU5Xq3jAlLlkHoGpaV2Z7SPeC/kgxgNBUjqaz6gGyqvU0CQgUBenTSq21olQhX+k5RS7uj00NbOge6Ec/f65969xyX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341213; c=relaxed/simple;
	bh=w/Urp16yxBrBlbQ0FwhKJmNlOuwGGOs/m9vemgqOvVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6xrBy8O8CiKweIZXQ7xbXrUJmSqmhb2dxO4JZ90SO70CKLrTuoedE0+6K39ti9Xv7vLS/xALvFbUgZbMtgV+xZVCs86UppBwtGBCC7oZwCLCCOBc02nkq9RmYSkZQRGJouRAB6WCWAA+bwTQPpzskPW6omyzkfEnz/vV0lWiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0J8-0007Ur-OT; Wed, 17 Apr 2024 10:06:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0J4-00CkpM-Fr; Wed, 17 Apr 2024 10:06:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0J4-002eR5-1F;
	Wed, 17 Apr 2024 10:06:14 +0200
Date: Wed, 17 Apr 2024 10:06:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 12/18] dt-bindings: pwm: mediatek,pwm-disp: add
 compatible for mt8365 SoC
Message-ID: <vasuzy7cf5x6p5rnrmdrk5z54oncu2yuutupf25h5fgd5y6fpl@mnkf67agw64g>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-12-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="io3h7fqcywjsjxa4"
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-12-33ce8864b227@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--io3h7fqcywjsjxa4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 16, 2024 at 05:53:13PM +0200, Alexandre Mergnat wrote:
> Add a compatible string for MediaTek Genio 350 MT8365's display PWM
> block: this is the same as MT8183.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

I already asked in reply to v1 what the merge plan is here. There are
changes in my pwm tree to the mediatek,pwm-disp binding already. I don't
think they conflict with this patch, but maybe it's still easier to take
this via pwm?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--io3h7fqcywjsjxa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYfgvUACgkQj4D7WH0S
/k78IAgAhF2CBY2gx+0pIvPzhA01LKYoH1PW7O9/VqjB74kUiFSUlcSeRrutEtNX
ZEg4pND9OmmBG82ECTvIccPKIL/n/aJOrZmng5N69kS14q4JUBYSVXbDDAF1dCbX
0PieK7SFo9D87VIaJATg+qpjGibELEWpKVbPeTeO5J2wzUJSltGSG5oNzJ8dX3XO
uqQoTu0bGayvkTeIy6I1XXkNDC8OGER+18nco1/s6w0zkBdm26UUbc3DCy/o5eeA
R0WD+DHqWiTxA80vpSEGFJ2RBPB96z3bbFBz4U0n5Q9vU34oqBr3oyvOd9qPXTMt
ok+B9O4U4Q0Cag8pOsGc7GXkD41LXA==
=hlSO
-----END PGP SIGNATURE-----

--io3h7fqcywjsjxa4--

