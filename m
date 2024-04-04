Return-Path: <linux-kernel+bounces-131483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B889887C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E0D1F25671
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7753D126F1E;
	Thu,  4 Apr 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="MTpYeE0N"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159E12E7E;
	Thu,  4 Apr 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235929; cv=fail; b=D7PtVDnOWOuJKPrLiiFwpIBtnVbxLny6nOzICfaAKO9GqFHzT5M5fIZrlxYKN6sbWdEFWGVeu99rF41UkegxqMod76NSBOyqyFNveHOSKEDHo+LhpZdQGb11Ke6f2ZYo7pYc/JitzRikm4UdjtdNmtJaShupW8wLUOCVab//GlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235929; c=relaxed/simple;
	bh=xLnBZ4SUQ6oMe8Q0Cg3krv1wyiWVNVojN2TMNRZk/uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VKlfUCY2xLVLaK09WkfLktjI0NRsA8KOdURU2G53NNocG/dTiqHFjufI7farnfOS10cKNbQG+TBCwUqTqyy98lp3LrEeZC2wiLq8b/c7BML90f42WAhcIk075aWaEwSMFA6aHlah42dE1kcoEAGV39y6bj7ScYzdT8GZOIzCVzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=MTpYeE0N; arc=fail smtp.client-ip=40.107.13.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDhnAt0b1trUCax7diMgjdBR5PYCfUvdZc722T+dkbPBpvAnVynJ+YCwqxElqsjE9DfVU2k9biX4SBEgkIVezgnN+/uPO8vEUwxENrgKAaXkDJTLo1be6Bus6iSHChAS3W15cgIJpYSgbCr8EhFTycTmyrGGgLAnjMiJ25m0ZYmfQm716m+1FJ+4NFx3rvWes5/LmlBCmkpLsJUZTIl8CPidV7+ZZ3+w6C+gaP0QU/iPSqEXOkPLjhGgbmKPtBIvm7rhHnohAH6z4W9vl6gjQ5NOn/ty7xJH/xg/cPbGfbXHEHTusKORjfOjK3GnbaTdJIaISR51gmmd2Bu5VPhYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzpgRXlbmeZheDbrAhXL9GkP9FcS6sTjqVWE8JrP8S8=;
 b=gW+lTHsElthOhabrLN9k5xBTVMLv6MSsnw7SckKgVbv/3+AsAtSqeRv7UFNF8hLHWv2glhiooXFzwgCv/RXNi4qmKMPQoi4XQ5GVTXgQPm0nHQIMJparJLP845CiVAIBdgSUO6m7Vom6/aG//iByQ3B1qQjwINIEmTIxEiH7CkJZgQsO5sG8Sw1ODDWhOTRa85Ty2Fcu8moPIhhWTw8honmpbrG9UYZevcx8Lcm6mlqPTjj41Z5B6WXgjeksCEwqa4X5F+488YznC3tkoe1E8hyeCswgIpKFc8j0BpgzIyJ/dC3cOS+PRBVgFCSOgwY7+yIST3R2kgUE1Gk7iMf1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzpgRXlbmeZheDbrAhXL9GkP9FcS6sTjqVWE8JrP8S8=;
 b=MTpYeE0N2eZr23cxPH2ktiGrHkt1pOg8bkCG3vW8HEktfj6OeAygTeLZSeWJQZAkC2joKxnHh5QIGLr0lModdmYulXOWmgL4ecvTMOIhZE54d4QK5cyGOKJwSfgDCnl2QN5ljY6D6xiG3EfyVz3GqAsrRLsQ9BBTzCyk1jofq3g=
Received: from DUZPR01CA0245.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::25) by PAXPR06MB7520.eurprd06.prod.outlook.com
 (2603:10a6:102:153::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Thu, 4 Apr
 2024 13:05:24 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::c2) by DUZPR01CA0245.outlook.office365.com
 (2603:10a6:10:4b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27 via Frontend
 Transport; Thu, 4 Apr 2024 13:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 13:05:23 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 4 Apr 2024 15:05:22 +0200
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
Subject: [PATCH net-next v3] net: phy: dp8382x: keep WOL settings across suspends
Date: Thu,  4 Apr 2024 15:05:16 +0200
Message-Id: <20240404130516.2897310-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Apr 2024 13:05:22.0857 (UTC) FILETIME=[C0C79990:01DA8690]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0A:EE_|PAXPR06MB7520:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f1958550-a3a7-4671-cb4d-08dc54a7e3b8
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FiBiLi+eZlTjWG1yjO5UiJ6uYEce5+J3qfjiAsrfXya8EIbp/tbltOgIfIQqQ/fMIoGMfxFo6dxdGz9MtVRgs6vt0NsN6Z26To9KgvY4yD71OJtKK+TEvy8xfuvBtkPhYxw/2vpnuuWQaM/nuB55Cyi2EhzOsj3QZUFDFbqYWPaRjJx2LVtUiWKF5m6eTZyHuwkPFdDi7GQLPjpSfV92UiwWzGVjyuZyMeGPJk2VoJFiXjNDYIU7ODFAnabOygM40mbR6jb+u5LaTptN5xIfD/pFk7eiNjtdAezNhhr8pyB7oHk+IUjW61hUcd3P80sTP0GePc/vX9FotdBzopMsCy5wq0/WtoN8+u0G35VFj7W70HyGHQ2irqnyZHWTScSzIFoi9a7Bu+X2BsaxmR/6vdefXxAaicA00cz2+QMbn09iJ+pT0kbykPqHfN7qrlSE//ObZPSlgpgVw+DOK2me2mxR1GuS6JSxONbAENqQC6tB0m6zZTvvyFXlW6LIJtUQrMP5RsrAXMN6qzYItnCcKq6LR2DVqrqgoQsKo81yXjO39F39Eu6Dm9wV8fzG1aIfo/Ggr4RftGJ5Dq4aBVMqxDuhRyhYKWGCq/wfLEIyyjQOKSd4710Ducpj1NGhv9UKOb2sjQcYxfQRekEIY7jw41iNhNYTLMn+bRXnpAY6tzeZ+a0dlLV/WYsmfpVRQrBd3KyczCZ752ZCfNeQL757jPTH5mNnzlpFKMyp6wYTtgFkf+rz4beovkQhuKGagDKB
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 13:05:23.5171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1958550-a3a7-4671-cb4d-08dc54a7e3b8
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7520

Unlike other ethernet PHYs from TI, PHY dp8382x has WOL enabled
at reset. The driver explicitly disables WOL in config_init callback
which is called during init and during resume from suspend. Hence,
WOL is unconditionally disabled during resume, even if it was enabled
before the suspend. We make sure that WOL configuration is persistent
across suspends.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
Changes in v3:
 - rename function _dp83822_set_wol to dp83822_config_wol
---
 drivers/net/phy/dp83822.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index c3426a17e6d0..efeb643c1373 100644
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
+static int dp83822_config_wol(struct phy_device *phydev,
+			      struct ethtool_wolinfo *wol)
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
+	ret = dp83822_config_wol(phydev, wol);
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
+	return dp83822_config_wol(phydev, &dp83822->wol);
 }
 
 static int dp83826_config_rmii_mode(struct phy_device *phydev)
@@ -575,12 +584,14 @@ static int dp83826_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	return dp8382x_disable_wol(phydev);
+	return dp83822_config_wol(phydev, &dp83822->wol);
 }
 
 static int dp8382x_config_init(struct phy_device *phydev)
 {
-	return dp8382x_disable_wol(phydev);
+	struct dp83822_private *dp83822 = phydev->priv;
+
+	return dp83822_config_wol(phydev, &dp83822->wol);
 }
 
 static int dp83822_phy_reset(struct phy_device *phydev)

base-commit: 2b3d5988ae2cb5cd945ddbc653f0a71706231fdd
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


