Return-Path: <linux-kernel+bounces-122956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B400890052
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55AF290EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72280BF8;
	Thu, 28 Mar 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="oRof7uaY"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B0405FF;
	Thu, 28 Mar 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632846; cv=fail; b=ltBLJGJQy9qsWt2eadxVI2TMfRdN0psWdrrpLt4C3Fvgj3KJMqeLFZCUOLIQdnZEpbp84fPC6LSWbOdEkXKd6ZVBBASCw8DYES9PsEmbeO4cgmSma3YzrsNi/fV0VYTzI+LYkZJzuzGou28K8Qi7k/iXjjMMAzP724a8PmIr6Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632846; c=relaxed/simple;
	bh=SHNLdxp/PLdrt7wrL9aZNVpCDC53Mvoey/oz4VBlsjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j7gwFKIb92tO4MwhxdLUEVHgAf5EfAYRdqVzQUIJlXEaB65QKxZwLWDCE/7nwoWQVN73ii3QMrfYmJowExg0tmhB7Q/tZtepV1uDyy9Ph+53pWCpWSUtdZRhJXhUvy7HTJ68c9ev7b3TYj1GXndwK04rtZQ6w82e5ujZkTsMr0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=oRof7uaY; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI9alzlEvOVsYOVWMIYv9XR8t7rKLgJGFqfX6UZWWSqAiSlcsuskI+wYLKnJFqgqhNv94e/RMToDrG3jy53Fmix2iurjnyS1b83BKi3BMpFf/Qo83PJfLiHY+Yd4jv0KHTb3fPJg0aYLhfZ7uw9eB3x7zGbq8wy8hTPwVjCh060v6ii8pH9rOEuAe72tTZrYlBGTa0+kJ5k3vl65mInq9M4s/mRoerHDIKW6yvtCuVpDFBeFlrqTbeZuKVNeujmb+hE4yaFZXom/jacrkLNkd7aznqK1Oleg2w2VlACDVvwxCI8udFvJW2bqRPErMLq/X5rnxkf3WzWjxiMmEmeAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7qTa1e5gL04NahTXWBkAoJ3nAXRX0dNz+AleYJucY0=;
 b=oaBKT3OvcIRVX6s01VeivDBQIEjs73s0EpXNLLXdZs+5e11wTUh1a4XJ+jgESHw0UB/Y9lpVWaMJe+JxbvIGOBOG5yvuZl4tg2D2qRLO/Xv49+270tyHnsMcCdif/frSD2L6MtpxsCf2Qa/4MHJYYnljUXRGNWFXDcZ9mK7uGGFVILPwU+6td91npCm4aswOWvjKxQbFMgRs8s459IhGy3zmOu85gbkyX2WS27SvSphUjSdJJh1tmlpLuAUAs7zE7N42jquKSwFYnsX6BNEs+SpNZLu4vld0RpYzOOOZCH9YdU8T5cIwA+hUuUdL32dxeyVZQ/mF4TlTEU4fZBEfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7qTa1e5gL04NahTXWBkAoJ3nAXRX0dNz+AleYJucY0=;
 b=oRof7uaYikauF4Uur7Qm9uRl8DKYrBBVatN1HNBSSrlxqpkQvBioGA1W3c9nXQdeQmYgKDALaRblJK2vmlFRv8IpRz/9MVnJ8SeliMqJ8OXWK47lSFKJAEHNCq0jz+IXd7RCqSdeA81s5SPBqn0iovPjSFxkbN7+XVYAgyn1aZw=
Received: from AS9PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:20b:46a::29)
 by PAXPR06MB8424.eurprd06.prod.outlook.com (2603:10a6:102:22f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 13:34:01 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:46a:cafe::cb) by AS9PR04CA0036.outlook.office365.com
 (2603:10a6:20b:46a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 13:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 13:34:01 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 28 Mar 2024 14:34:00 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH net-next v2] net: phy: dp8382x: keep WOL settings across suspends
Date: Thu, 28 Mar 2024 14:33:58 +0100
Message-Id: <20240328133358.30544-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Mar 2024 13:34:00.0873 (UTC) FILETIME=[97E7C990:01DA8114]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A2:EE_|PAXPR06MB8424:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f491de73-da5b-4cda-9aa2-08dc4f2bba90
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LQhhmbDxFxkkaMtJGRZUwVjjTOVpcxVBLP+BzfgHcC/50lelVQlLUJ49VVxCuzo6A7LT0zMz1840xmENpmnwoihpgYNHMzYqMSJ2a/4aSYB1ZHvb1S47kfhqtZrvB6ulxu2zEWQbp+JmkE8biphnflejUtdOifg6gqnMQSX1dMe3AARYJ/v4kNkcW2giAMUX5y0q7I1zsUdd9EwGUy3hbtpSsPUYQtjP5YcKl2q+wrxXQAHOpOzmFm4BRMrqvQhsVjyWuT5r5biflINQcXRDu/wwNAwWlwoR4GGs7arGlfwjjvKjK9XnLCJ290P/PyS1giOJY2/cME49C+VtR2YHVWWaWCH8C1jiTSngzmEWNkl+8egKJspmmn6quhFQvnfonXaDGvQk5GVk7tepmG3+cLP0EIGtMk83jTta/EBZ+6ckev8lKIvVMLAuCB8F294ab74pIAD0YTkk62oNclm/Y7q9QPKdE5lEgxc7SKDCX97R+e4ZOL0d73uP5r4rdLPaxy7KPvWLLHfjgKXCUBaFyO3MMdKQ1/yeZJ2CrxKy/+KmKwFbSeIVHCG7R+qD5buV9f6moIuPBewkYS/FRfOLpxHAbANnkA/xVLNJ+0G98M02sRHDIDvLY0w9p0VWYpVTY5AzGRKbqiMxZC8AgCDQbHx+FFUcSDrQ0Rgj560nqbtkUqWUuBbPv5EBZwz0BbYH/PpvJnsjzboTzXs19spoHCoH5TD1W45arjabBfupyZvGVJmnQNCphyQtIMcnSpi3
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 13:34:01.0901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f491de73-da5b-4cda-9aa2-08dc4f2bba90
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8424

Unlike other ethernet PHYs from TI, PHY dp8382x has WOL enabled
at reset. The driver explicitly disables WOL in config_init callback
which is called during init and during resume from suspend. Hence,
WOL is unconditionally disabled during resume, even if it was enabled
before the suspend. We make sure that WOL configuration is persistent
across suspends.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
Changes in v2:
 - store the whole WoL settings not only the wol_enabled flag
 - in config_init, reconfigure WoL from stored settings, overriding
   any setting from BIOS/bootloader
 - fix device name in commit message (dp8382x vs dp83822x)
---
 drivers/net/phy/dp83822.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index c3426a17e6d0..683ebb13bd4f 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -140,10 +140,11 @@ struct dp83822_private {
 	u16 fx_sd_enable;
 	u8 cfg_dac_minus;
 	u8 cfg_dac_plus;
+	struct ethtool_wolinfo wol;
 };
 
-static int dp83822_set_wol(struct phy_device *phydev,
-			   struct ethtool_wolinfo *wol)
+static int _dp83822_set_wol(struct phy_device *phydev,
+			    struct ethtool_wolinfo *wol)
 {
 	struct net_device *ndev = phydev->attached_dev;
 	u16 value;
@@ -197,10 +198,25 @@ static int dp83822_set_wol(struct phy_device *phydev,
 				     MII_DP83822_WOL_CFG, value);
 	} else {
 		return phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
-					  MII_DP83822_WOL_CFG, DP83822_WOL_EN);
+					  MII_DP83822_WOL_CFG,
+					  DP83822_WOL_EN |
+					  DP83822_WOL_MAGIC_EN |
+					  DP83822_WOL_SECURE_ON);
 	}
 }
 
+static int dp83822_set_wol(struct phy_device *phydev,
+			   struct ethtool_wolinfo *wol)
+{
+	struct dp83822_private *dp83822 = phydev->priv;
+	int ret;
+
+	ret = _dp83822_set_wol(phydev, wol);
+	if (!ret)
+		memcpy(&dp83822->wol, wol, sizeof(*wol));
+	return ret;
+}
+
 static void dp83822_get_wol(struct phy_device *phydev,
 			    struct ethtool_wolinfo *wol)
 {
@@ -346,13 +362,6 @@ static irqreturn_t dp83822_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static int dp8382x_disable_wol(struct phy_device *phydev)
-{
-	return phy_clear_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_WOL_CFG,
-				  DP83822_WOL_EN | DP83822_WOL_MAGIC_EN |
-				  DP83822_WOL_SECURE_ON);
-}
-
 static int dp83822_read_status(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
@@ -496,7 +505,7 @@ static int dp83822_config_init(struct phy_device *phydev)
 				return err;
 		}
 	}
-	return dp8382x_disable_wol(phydev);
+	return _dp83822_set_wol(phydev, &dp83822->wol);
 }
 
 static int dp83826_config_rmii_mode(struct phy_device *phydev)
@@ -575,12 +584,14 @@ static int dp83826_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	return dp8382x_disable_wol(phydev);
+	return _dp83822_set_wol(phydev, &dp83822->wol);
 }
 
 static int dp8382x_config_init(struct phy_device *phydev)
 {
-	return dp8382x_disable_wol(phydev);
+	struct dp83822_private *dp83822 = phydev->priv;
+
+	return _dp83822_set_wol(phydev, &dp83822->wol);
 }
 
 static int dp83822_phy_reset(struct phy_device *phydev)

base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


