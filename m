Return-Path: <linux-kernel+bounces-117233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED288A8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA861F2F6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8F12E1D8;
	Mon, 25 Mar 2024 14:19:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A1128368;
	Mon, 25 Mar 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376390; cv=none; b=OghaywwROzXIzxTRWYeDlSFINRSUgQ8eP3XdGm+/AoBhwKpHUwRcFGocymU18W2t+KnFgFA7kpZHlA5QQch+h+JTKQvSTLvKM+7wbPe3AkWT/7cAWVPrBAbxMeuy97Rq26mvEfFZRgEsca60qCGiOHw0MVhbpzVsOPfeW7IItp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376390; c=relaxed/simple;
	bh=sqpsnxYpK+i8G4hHRI5NiWY5dyKGD1SQbSxJQjm/5ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koNek6tH8PpBlH3lX0MWcx7gnJlmbPARD7xGrH5utT3hKntybejKeVWeW5SOg1ftALSwmeZVpYuxTM+a4FIA5zjTCqAjXzg/OcQgVRXdRoGzEDCvUmwpxjg+Q2g+3SWcpKrtoVABAXGyUeznku5CT9t8WYAoOhVh9RFiAfofTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rolAt-0008Lb-6m; Mon, 25 Mar 2024 15:19:43 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Wang <frank.wang@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 Zhang Yubing <yubing.zhang@rock-chips.com>
Subject: Re: [PATCH v3 02/10] phy: rockchip: add usbdp combo phy driver
Date: Mon, 25 Mar 2024 15:19:42 +0100
Message-ID: <6661610.4vTCxPXJkl@diego>
In-Reply-To: <3274787.oiGErgHkdL@diego>
References:
 <20240216170514.75200-1-sebastian.reichel@collabora.com>
 <20240216170514.75200-3-sebastian.reichel@collabora.com>
 <3274787.oiGErgHkdL@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Sebastian,

Am Montag, 25. M=E4rz 2024, 15:17:26 CET schrieb Heiko St=FCbner:
> Am Freitag, 16. Februar 2024, 18:01:17 CET schrieb Sebastian Reichel:
> > This adds a new USBDP combo PHY with Samsung IP block driver.
> >=20
> > The driver get lane mux and mapping info in 2 ways, supporting
> > DisplayPort alternate mode or parsing from DT. When parsing from DT,
> > the property "rockchip,dp-lane-mux" provide the DP mux and mapping
> > info. This is needed when the PHY is not used with TypeC Alt-Mode.
> > For example if the USB3 interface of the PHY is connected to a USB
> > Type A connector and the DP interface is connected to a DisplayPort
> > connector.
> >=20
> > When do DP link training, need to set lane number, link rate, swing,
> > and pre-emphasis via PHY configure interface.
> >=20
> > Co-developed-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Co-developed-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> > Signed-off-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> > Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
> > Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> after 6.9-rc1 this needs a respin with
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rock=
chip/phy-rockchip-usbdp.c
> index 1f3b7955c9f3..38dc96cfe403 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -1420,7 +1420,7 @@ static const struct regmap_config rk_udphy_pma_regm=
ap_cfg =3D {
>         .max_register =3D 0x20dc,
>  };
> =20
> -static struct phy *rk_udphy_phy_xlate(struct device *dev, struct of_phan=
dle_args *args)
> +static struct phy *rk_udphy_phy_xlate(struct device *dev, const struct o=
f_phandle_args *args)
>  {
>         struct rk_udphy *udphy =3D dev_get_drvdata(dev);
> =20
>=20
>=20
> to honor the change from
> commit 00ca8a15dafa ("phy: constify of_phandle_args in xlate")

and this "nicely" overlapped with you sending that v4, with said change
already included :-) .




