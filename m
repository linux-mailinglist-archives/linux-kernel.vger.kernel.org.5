Return-Path: <linux-kernel+bounces-117230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5A88A8E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366681FA16C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8385A152DFE;
	Mon, 25 Mar 2024 14:17:38 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906715253A;
	Mon, 25 Mar 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376258; cv=none; b=EcuJAqrCgNGn5cID6XWEVNHlD3nrXv6BJv3nrJbg+Hn1iUEWau/4vjrjJYS97JO+9HM6Pb3l+SuCIcwxqwiZ+K+GqcEClFMxvjRAlAJG6ZtGaywd3zaqQDc2VuAUz0eO6ctgm91L23gqSQ5boFDVHwLBqFSKc76z64aQ5Qus8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376258; c=relaxed/simple;
	bh=knRLRkcs1XeCiknEac0thERyRApGdlYT5XFrHlPxorc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGNW7vSXQl2t2jonOYDhYSNHUynIUcCJ6ekMWTZrOIIi04UdrKPz7SmH61D16WjXkynONfv8ai+OyOWEi0MpNy+dg4aKEBexUMxn84YSr2dCg/EmU+rSUQNhvRkQnuSpc/Sf6/xEODCIeYQJC9puv9LVIWGxCsHk+ypAdB8Z3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rol8h-0008IU-3g; Mon, 25 Mar 2024 15:17:27 +0100
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
Date: Mon, 25 Mar 2024 15:17:26 +0100
Message-ID: <3274787.oiGErgHkdL@diego>
In-Reply-To: <20240216170514.75200-3-sebastian.reichel@collabora.com>
References:
 <20240216170514.75200-1-sebastian.reichel@collabora.com>
 <20240216170514.75200-3-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 16. Februar 2024, 18:01:17 CET schrieb Sebastian Reichel:
> This adds a new USBDP combo PHY with Samsung IP block driver.
> 
> The driver get lane mux and mapping info in 2 ways, supporting
> DisplayPort alternate mode or parsing from DT. When parsing from DT,
> the property "rockchip,dp-lane-mux" provide the DP mux and mapping
> info. This is needed when the PHY is not used with TypeC Alt-Mode.
> For example if the USB3 interface of the PHY is connected to a USB
> Type A connector and the DP interface is connected to a DisplayPort
> connector.
> 
> When do DP link training, need to set lane number, link rate, swing,
> and pre-emphasis via PHY configure interface.
> 
> Co-developed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Co-developed-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> Signed-off-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

after 6.9-rc1 this needs a respin with

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 1f3b7955c9f3..38dc96cfe403 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1420,7 +1420,7 @@ static const struct regmap_config rk_udphy_pma_regmap_cfg = {
        .max_register = 0x20dc,
 };
 
-static struct phy *rk_udphy_phy_xlate(struct device *dev, struct of_phandle_args *args)
+static struct phy *rk_udphy_phy_xlate(struct device *dev, const struct of_phandle_args *args)
 {
        struct rk_udphy *udphy = dev_get_drvdata(dev);
 


to honor the change from
commit 00ca8a15dafa ("phy: constify of_phandle_args in xlate")


Heiko



