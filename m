Return-Path: <linux-kernel+bounces-94319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5B873D16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E8EB24CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F5813BAFE;
	Wed,  6 Mar 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="amaSlf18"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C9A13B7A9;
	Wed,  6 Mar 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745295; cv=fail; b=iiYnr2j6fFeNM56QAhf9w5v92TMGyGj/EDGsj4oOqLbxLyOsAPE2GEnbLUTCFBaW68EiBDavYtZnjXKmQdmHxJLin6TrFcPKjmPYLfKkPzHWsVQ/AZUM34NyEnzwKJ9EcFbHqviAB42e1ZKrityqd12GdnkUB8BvQjgMOjE/XQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745295; c=relaxed/simple;
	bh=cm/B0aMZff8+c4vEFJJ2zV0q3NFSlqWSnT5z/ITeN5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=opMubdfU1aLJHMBlRhVlADKS0bB2Q5qaKXdciNr12QMTg5eI7AJ7T5bnO1tri+udYTb2BzUIZ0qdNwstQS/TbwOlWXs+jqXCsiecqEqq1+XBxJSl+Kjoxn4HneV0qNU9oTCq8QeJb3UHCUEVnTc1590+Fwc11WAQ3PYAiywtjDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=amaSlf18; arc=fail smtp.client-ip=40.107.105.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URb6JDZGq4T/zZ51/K3OOwWeoCwGiZE8EaRIj1gZk48zoOWeNhdhpL0uKoa5vNW6VYkcM0sJ+PyG+RzljzW29bnioBdH72TJhH0AWleU1C5vhJTX5ZZMmF6i4HXGi4jwrEsWgrzSHTTVMriQJlbDYFqcqrl1ZxPXNk8T9YWG8rYsZbz7mTQPQ9K4m2MIVzazt9c/9VfkR/KKhjZeWh3kyn0qVDNP+hxIYSopaVs5S6C4E6E0LnGvlYc98uVnpK32ctSm5386twanHfpN8WFBviDSmqBYuYG5qoEobcOKq9I0g/lUApwLcEm+bhdwtjij/ERAItT2J9ClMOCWOc3nNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI3nR0zCiWM9LHDj/yP5dIbXFb7X1UaliqE1va7jhRM=;
 b=eZjuzwKXvwgkfeokRbUz3MCD9slD4jit8A4sgZqJlKnQppMaPNc1bGxQNSUOddkmCIYR3opQjGVt6hhTNQHkp9JScyKn29wpbwL1RNFGKgaXvG+VlY6ialsheAwbL3vjq8PxbqFQByzyLu9jFNFrKlYuVpu77Zk9bGagHE7Qt+gU/1FQqsjSUGRZfbrfDBBjZMFYdRXWw+nGGVbH2VTjocMK4jaCQoeBDjOLcEunXQAtAJZ4QFCm0VVoNRj6DakMwbVgHhssXR0s+pBwrj1k7w3k96f3O2F2r4I0vnr0BgCUIH8/aKIVooOS4Na1kD+l8ikTA30QLC0AnnhEnpioqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI3nR0zCiWM9LHDj/yP5dIbXFb7X1UaliqE1va7jhRM=;
 b=amaSlf18LhnuG90gFIUsyuGV6prXUg/B3m1vrV/vnkZr+pFR00i9OIl+CfhebXo9jl+0txLXwZE+ImZuLDnOTtplchtc4eCRTEUkCeHCrB4rLUisBu27fDZ+uXvWINmX0FQrdFy06WhrPAhpguS7TWSzzuwj2SZ/z2xu9dcikOM=
Received: from AS4P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::8)
 by GV1PR06MB8337.eurprd06.prod.outlook.com (2603:10a6:150:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 17:14:49 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::48) by AS4P192CA0019.outlook.office365.com
 (2603:10a6:20b:5e1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 17:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 17:14:49 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 6 Mar 2024 18:14:48 +0100
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
	bsp-development.geo@leica-geosystems.com,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH net-next] net: phy: dp8382x: keep WOL setting across suspends
Date: Wed,  6 Mar 2024 18:14:46 +0100
Message-Id: <20240306171446.859750-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Mar 2024 17:14:48.0958 (UTC) FILETIME=[CB4AA1E0:01DA6FE9]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|GV1PR06MB8337:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f3b582e-dfd9-4266-2ebd-08dc3e00edee
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TsUZZ0lZ5zSs0qo54RQ0ybMcJE0Z5+Gya8w0ZcYnVYPmuW1X+6zqLMgoFlJFTi7bWdV8FJ86Shfy+IjaKP96xYw8gEejsAsW2MeFfqXserDVTp/0ZDLiZbXHwb1jaaCQIH8Wf1G6sJX04tYGbUMsyjba2xuVy4elpoF6w8P1c8akyTHBwovaWF02hDnD4pBzogYlm+9/UihCvOOLKdPWZKmmrB9DSmHMsjPDCpDT/DaetXlaqTJAu5EEcgUiQAqx89M8cWcDFSwzNbj4cCjarJ0dXxljLTu97LAsCjtr3R7KRJ7T7MnJhZF6W1IJGXxh+X3iw7jBuMBkHz5fFiKCVbHOrDRZvoQk/Cynt/BsKoHFmFnpccpuDzh4aIRj7pgdo1lnuESrMbc8ZB6VDxCW8RNJhxPz4g96nLQdAyyZcigLsotJa0mtTIqvoX1VjOI4M4LOYkD+MtZTpZMU3utJSabm91F1xKKTOw0wcGJ+UsEAX3hbr1oYfDAKRDgdN2KcCqb7mzJc1bbRIjXaev1B7Vl1Zlil94kjzAdchEutPXOGctyWjtAAGD5i0bBtl4QzsInQiZ+tavcLqmadcdqjzTqq549rTMId6mxpzANTHebp/AxytySf1iUkNCjivE99VAp6OcT91vnjl5mjvXjp9xR92JluUswdeTeNEgioROQRq4wnRqtWk9wVeSyQRud23Qdj9LVUHwqM7WP/P9nw8KMJ+2LGy7uCyDpwDPGnvNEWibgwRie3S9irbAJefqXM
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:14:49.1405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3b582e-dfd9-4266-2ebd-08dc3e00edee
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB8337

Unlike other ethernet PHYs from TI, PHY dp83822x has WOL enabled
at reset. The driver explicitly disables WOL in config_init callback
which is called during init and during resume from suspend. Hence,
WOL is unconditionally disabled during resume, even if it was enabled
before the suspend. We make sure that WOL configuration is persistent
across suspends.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 drivers/net/phy/dp83822.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 95178e26a060..618317c1e27f 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -136,6 +136,7 @@
 
 struct dp83822_private {
 	bool fx_signal_det_low;
+	bool wol_enabled;
 	int fx_enabled;
 	u16 fx_sd_enable;
 	u8 cfg_dac_minus;
@@ -146,8 +147,10 @@ static int dp83822_set_wol(struct phy_device *phydev,
 			   struct ethtool_wolinfo *wol)
 {
 	struct net_device *ndev = phydev->attached_dev;
+	struct dp83822_private *dp83822 = phydev->priv;
 	u16 value;
 	const u8 *mac;
+	int ret;
 
 	if (wol->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
 		mac = (const u8 *)ndev->dev_addr;
@@ -193,11 +196,17 @@ static int dp83822_set_wol(struct phy_device *phydev,
 		value |= DP83822_WOL_EN | DP83822_WOL_INDICATION_SEL |
 			 DP83822_WOL_CLR_INDICATION;
 
-		return phy_write_mmd(phydev, DP83822_DEVADDR,
-				     MII_DP83822_WOL_CFG, value);
+		ret = phy_write_mmd(phydev, DP83822_DEVADDR,
+				    MII_DP83822_WOL_CFG, value);
+		if (!ret)
+			dp83822->wol_enabled = true;
+		return ret;
 	} else {
-		return phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
-					  MII_DP83822_WOL_CFG, DP83822_WOL_EN);
+		ret = phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
+					 MII_DP83822_WOL_CFG, DP83822_WOL_EN);
+		if (!ret)
+			dp83822->wol_enabled = false;
+		return ret;
 	}
 }
 
@@ -493,6 +502,9 @@ static int dp83822_config_init(struct phy_device *phydev)
 				return err;
 		}
 	}
+
+	if (dp83822->wol_enabled)
+		return 0;
 	return dp8382x_disable_wol(phydev);
 }
 
@@ -572,11 +584,17 @@ static int dp83826_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	if (dp83822->wol_enabled)
+		return 0;
 	return dp8382x_disable_wol(phydev);
 }
 
 static int dp8382x_config_init(struct phy_device *phydev)
 {
+	struct dp83822_private *dp83822 = phydev->priv;
+
+	if (dp83822->wol_enabled)
+		return 0;
 	return dp8382x_disable_wol(phydev);
 }
 

base-commit: 61996c073c9b070922ad3a36c981ca6ddbea19a5
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


