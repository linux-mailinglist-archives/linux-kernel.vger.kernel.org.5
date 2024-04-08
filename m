Return-Path: <linux-kernel+bounces-135028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6C89BA26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B3F1C21E00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749F5335DB;
	Mon,  8 Apr 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="czECoxQt"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408022E3F9;
	Mon,  8 Apr 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564773; cv=fail; b=ES55MBsgiK/mUANbAC3INaBwLjMLk5+ry335/njfpZluveQ1mjFeFHpdmOoZt6NFCjYQCldkDrN24UX5BYNCDDaSJOmFxNgmxjqBxDvijqqCa2wyBAvFRARXbIfHPNtCVcyPsjdRqbuZiIUmkOsD9b+XtXPue1jHvVwew+Ab/iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564773; c=relaxed/simple;
	bh=HGqXG4IQn1uQ1cSZq7PrwTSLsZjKFaUIcgnyqafwWp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VOl8Jnkm9vcAk2k5VyIl08Lkw/qCHmW4dbfAd3aXFE6r+5B2P2EPQH0DRaakFJUHLLcfY40y9AlVnocN1oD0hk4GZr0JyKUqavXWpy7j7Ccf8y79ecA+YT0y74QkvCKKIriHI/E7XVlQTaOG+ewAaiLkhtZ82rNAjflaK3dpbyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=czECoxQt; arc=fail smtp.client-ip=40.107.247.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTy7B1dQpFmzfiXj2jhHVXRYpB5XgiW5p3l3eq2pevfalc0L+RFEQGghD/yElcqxEJgOY9QDD9SJtatP/lP5dzaUeiBJXPa4s4tT/2ZctT55JNeweLRX4xQEJUy70qDRPCvvXJwX0q0GBJ12AAR39uTVT7NQPcM+o249qvZJBFWBYwrEHI6t1nvIHLWOl4ml+F968yWHJqBWOGyEcynfmMiytNqvDkgB2k0Dyobetb4VOSjoCzgs2aJTrewvQ0fdAiFw3n7yaScQ1QHqVzHY89A1ozHYjHeVsd0FP/SUSnIG3pvtwvf6/mqDb0xnGD3+GMTAOPx02Cm6I/vtC9fFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuOTcl2vUsgugw56Islh09chiMUvXpq720iPccjO8Pc=;
 b=kVP9+ypbTcET1OJoGtEfC1nkyXa/Iiub5JVOT5ovCI5oXKrPs74NOTVo7czgXEIzrnl5SZNBuebLCGWAGoo6S0/D+6ocFqbgQED6rE1JdeGFOlC5i+dZnYXJi74aW4ls8jzaq6d1Xp+DUm+G5J8rpCrayZe5OCrDygtQuGjBZkdcFe952L/ylHG8x2RdvVK3wRxq+UZ3hhTs27ax0iJjEKI2LBv8SmmBSh+tpbf/ECiEOSWKmecVXK7N4QvuR7+n/QKsINy7N1TiMEOX8gk4TX6MqMTVlXLQVXG5V4OcQ3WfHQiu79l0P2FL2N2cOU1ZqE65S138UCssmXVIANSCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuOTcl2vUsgugw56Islh09chiMUvXpq720iPccjO8Pc=;
 b=czECoxQtNks0gfauzOhaC2eMWyyMb7Oxuior41kvmd+/SDX/fWyp4NE1tXqA3DHn9rYqDqa7w4bryaAaN1aXFQOrCmFGnezPfd9lzxCyiw3pWCM3o/CCy0c984lIVRS2l8qvRQbasrvKMuVy1jzrj/tj/pJoZoOhqmU9CsFWc5k=
Received: from DU2P250CA0007.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::12)
 by DBAPR06MB7015.eurprd06.prod.outlook.com (2603:10a6:10:1ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 08:26:05 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::8f) by DU2P250CA0007.outlook.office365.com
 (2603:10a6:10:231::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.33 via Frontend
 Transport; Mon, 8 Apr 2024 08:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 08:26:04 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 8 Apr 2024 10:26:04 +0200
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH net-next v4] net: phy: dp8382x: keep WOL settings across suspends
Date: Mon,  8 Apr 2024 10:26:02 +0200
Message-Id: <20240408082602.3654090-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Apr 2024 08:26:04.0501 (UTC) FILETIME=[65AC6850:01DA898E]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|DBAPR06MB7015:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7b19489b-83bc-4820-84e7-08dc57a58874
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hfy0GacjKwhltGB+XLXwVu58R2SLbXOS5R4TgdvR7mPmPviRnnPzncqDcKCmdTsT86Li8pYPlEQ7AFGwnhLE4D+QGlCeXJzwVB40wQXp/Wq6T0hRml0XK231pZsyri9Bi1SvbGhhpoBRf9rqi/qJs4yslWv+AM8fkoskWm4TpqgTSobUx+jlZ7/+KVK62DCGU1Rcip2M3ylfQVe5++udWYvif45e/EzEt0C4BvWj29Gok/Ykof4hy7HuH5XCwsBTSsHBx92W0+j+tReq+vqnDs8IEGQO0ujs3Xinpcdcb4oGt1Tx+5NxyYmsQAMlpL0oFyNdYdx7U7nVkUdEvfTDwYQG43/lGq84gRh+Xgm/gayfiMCfIXq85oEwWbpZzgoXbLlJzBWswTirNwAuXC6kwFfKs+bC6vi2a6QSOKEC7tMBQ/hVCPGkSGqMpaqijr1iUpuZ1eKFCDCk0kC6pf3bsHjie535wGGN9Z3L0Rx4IB21ngNJWu1qMOLciBPOA3LB4d3UkAH0xEvlZvfpq1OM35hIp2GO8o/JB8sm8zi4ca/eXKgVEZ3yM1XJPlIoVhdYGioVpzpyONRG7GnBHQAPnMQG0ezp4AY/D7YWPo+5n1EkwpHv+8yKn2jCAWPGJGPFxLJzRJ+XfDXpAkUmtmHaULMV4DHu9kx+4NJEXv1sOmbWlfjvhGo3HuHTX9Dg7PCGOR8B+0tet4gvqDA5VkqWukT21jjyPds7AcMJS79GUcq3s13jR9eRYkbbCUcK/gWW
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 08:26:04.8919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b19489b-83bc-4820-84e7-08dc57a58874
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB7015

Unlike other ethernet PHYs from TI, PHY dp8382x has WOL enabled
at reset. The driver explicitly disables WOL in config_init callback
which is called during init and during resume from suspend. Hence,
WOL is unconditionally disabled during resume, even if it was enabled
before the suspend. We make sure that WOL configuration is persistent
across suspends.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v4:
 - adding reviewed-by tag

Changes in v3:
 - rename function _dp83822_set_wol to dp83822_config_wol

Changes in v2:
 - store the whole WoL settings not only the wol_enabled flag
 - in config_init, reconfigure WoL from stored settings, overriding
   any setting from BIOS/bootloader
 - fix device name in commit message (dp8382x vs dp83822x)
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

base-commit: 11cb68ad52ac78c81e33b806b531f097e68edfa2
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


