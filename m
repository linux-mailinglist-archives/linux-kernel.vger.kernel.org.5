Return-Path: <linux-kernel+bounces-105783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20BF87E444
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4AB28169C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB8625570;
	Mon, 18 Mar 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFJv2dbo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD28249F7;
	Mon, 18 Mar 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748029; cv=none; b=mptGTlB4RvweZu5WKd6J5oZDCAqGNxHcTRpUjwJA+sVrr3kY5XWveg0EdLN9cqBJSM/76EMPqw+LGtwOvDmmV21/XC6L+eQ8HyXJeYZF5xXGyIVKo/cED9VG02GMw+yMSty0IzWEHXBBru7I2to8yMKBnnS3KyzuzYJYFGPKUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748029; c=relaxed/simple;
	bh=Qg6wGn348TMW5vD8jxjP5W64953WeOV0NbR9aKpKJWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OA/3AFSICk8s/htj1SUt9vJwKGM2har9KNp/rTjZ4+usqMSYz8dWQGSIjh6A8gqfcrI8dtMqYnte6GaF49+5T2XDWAa+eTeMo8FhYpVMfMXTUCBknfczbFRAIKMMUK/KKRBdRn2e3g1ZWPvjQRlknqMGLJoXw4uZmJsFI985H3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFJv2dbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED23DC433A6;
	Mon, 18 Mar 2024 07:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710748029;
	bh=Qg6wGn348TMW5vD8jxjP5W64953WeOV0NbR9aKpKJWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fFJv2dbopy2N08oK7/uaLZlAJAyNVDYDT5UVFJPMifpqxz/tRnpMo+yFC6JXDqbqc
	 n9AzVWq5IPAl6K5Sid0rcE788s1jlezqbTklhyPpY32u1UP1RbIqo+FmfWiiAdAh2M
	 /VGhLLMZpxuU9ic2Kli49ONnv05/wXO/vA8EB+ejS9vsqBhuaVoo+pcwYU8gqPeDpD
	 ed9H1CNibz0o5nSq7s8YmpxdWrfrySPqd3t3ZcXBexui5TYXqbZvkZbLJYqi0gNZm7
	 fniXmkj6Hi1OTjvIhcAYhfCriy8B9N9hFP8q3qvv7xIwfUIxUAK6bUkNRrSZxeYa4m
	 wIbk1bAgB0zLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD04BC54E6A;
	Mon, 18 Mar 2024 07:47:08 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 18 Mar 2024 10:46:25 +0300
Subject: [PATCH 3/3] net: phy: mediatek-ge: do not disable EEE
 advertisement
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: =?utf-8?q?=3C20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v?=
 =?utf-8?q?1-3-3f17226344e8=40arinc9=2Ecom=3E?=
References: =?utf-8?q?=3C20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v?=
 =?utf-8?q?1-0-3f17226344e8=40arinc9=2Ecom=3E?=
In-Reply-To: =?utf-8?q?=3C20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-?=
 =?utf-8?q?v1-0-3f17226344e8=40arinc9=2Ecom=3E?=
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>, 
 Russell King <linux@armlinux.org.uk>, 
 SkyLake Huang <SkyLake.Huang@mediatek.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710748010; l=1173;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=5X/oaW7mTS2TiAUhw0sZVt3FkSCBq14+if6oX62AfQ4=;
 b=+MNXFbgyZ7XWlbB+caj20Ex4VdOFh3bRWNk+7DxEulDTftFo/dQMZlnVMPgDMgzfE7zV31TEr
 3C0SXiZRhwiArszbs0GX8DiM1j4yZODltXA+UTuvosvV+CjFhIJGXcI
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

There's no need to disable Energy-Efficient Ethernet (EEE) advertisement on
the MT7530 and MT7531 switch PHYs. EEE works fine on MT7530 and MT7531
switch PHYs. Remove the code where EEE advertisement is disabled.

This is a bugfix because there's a possible race condition where the
mediatek-ge driver would kick in after the MT7530 DSA subdriver which would
have EEE disabled until manually enabled.

Fixes: e40d2cca0189 ("net: phy: add MediaTek Gigabit Ethernet PHY driver")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/phy/mediatek-ge.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/phy/mediatek-ge.c b/drivers/net/phy/mediatek-ge.c
index a493ae01b267..54ea64a37ab3 100644
--- a/drivers/net/phy/mediatek-ge.c
+++ b/drivers/net/phy/mediatek-ge.c
@@ -23,9 +23,6 @@ static int mtk_gephy_write_page(struct phy_device *phydev, int page)
 
 static void mtk_gephy_config_init(struct phy_device *phydev)
 {
-	/* Disable EEE */
-	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
-
 	/* Enable HW auto downshift */
 	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED, 0x14, 0, BIT(4));
 

-- 
2.40.1


