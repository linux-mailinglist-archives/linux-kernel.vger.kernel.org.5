Return-Path: <linux-kernel+bounces-94330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ED8873D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F1EB23E7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CE713DBA2;
	Wed,  6 Mar 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="lU4DMf7b"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2813BAD4;
	Wed,  6 Mar 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745858; cv=fail; b=TKWzO7bOZ+NXhHkBiLuhxVn4SKvJQCp63tUPdiokvVhfBf06+BLa8BSfCQh1fEYMhF+KQWXFUuQo2b+7gst+n3vYrPEYnmsZH+nPS5tubCGBEsXZ0zhfX5zUCiRDQp34wL1gCRJutCF39tuD5u6gllqm9xYw0d4ymQKXADtIbGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745858; c=relaxed/simple;
	bh=vcgWp5TJBXL6cOh9tIhKWQvVOFHby8gvNZQwRIBVgk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qlqimo6tOAPZRS3wLMAHgMcmIhrRuMcI1ucyEKrWSjWEUF3J+J8g5Ng6qHptVhs9lynalswZ1MVTa3AsIp6HsYxp/uQ8qQzdx7cnorGJaKZhYSi7JWuuBTDbks/jMMhAgSHvznEFOqE1G82HyiIzPibeIdwP1l+mqSf29BEAYWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=lU4DMf7b; arc=fail smtp.client-ip=40.107.249.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du1fW0rW80SBf6i85Hd/y/+pS6GCnTWQBCb8If49+KJc5jbazvjx0z/fh/cLPrB3mJoZP/48IWPXQNSED5JFVpBfYKapLezuEdvkEp4Ht/tww5mNdp1vING77UJ/MhmApnGulzkffhMCFvURnA28U7s4j5Yevx7UNJhjKYa90p7jUY/NkoipuCIlsRFt9Ew8+j+VwXryfZbkqNoFA9c9wI9LrBFx9XtemnDNezdDDowTAuUFOtA0UVkrUzRS+3jhRl6+aOtSRvH1NAQqq7+MqKUIT1SGYY7KiGJn1fZ7xUik4gCVH/8hkqmksGgtSmicU3s7aC2R877cD+bvDs0T8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGaeE1bYJJpRe+mBdhfHv5qwBoRinQKyAbpJJwn88Tk=;
 b=myAY95OjZrVKO85payh30tcikMMw+cgfBTDiVQzKjGgCvoLnocctjonDGURP0kQhpdsa/bSE0wl12fcFUPP91VdGOUZH8Vi2cPLvFrj+ReQX6U14CohpK8Ufv4vBygCHbVL9NtWJcGzKmUNXIMdmnL+CQGh1UYqN12hpw0u9hWJW9iKKk+Ay3/H2lUwCKh3dghDyJ1KCqaJKElAt23LQUGV0P0FxlIGsf1DEkNwLtaEU8FrbDuXhUXp14si7cseiOdQKvRBiMHlPV2f4oIVUJITxDCk+sczg/7uh3fL2l7XOOVOMGXRFQ1ER5GuHQ2STYWd68X820t/w58QdOTdMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGaeE1bYJJpRe+mBdhfHv5qwBoRinQKyAbpJJwn88Tk=;
 b=lU4DMf7byJmChVWyYz7oyfikMizNi5RYReyBqCXWYmKjYyaf8tUTWjhkyhbZSTx02Dw1UEqfdmqlYtSvO4awPTFbPRLptPE86z+EkCy2ORAQvJwOPradRs76ckMda27vyUSO9r6/6UGByM4Femjtl1tPg7pFOFVdtUKxndRrP9c=
Received: from AS8PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:20b:310::15)
 by GVXPR06MB9041.eurprd06.prod.outlook.com (2603:10a6:150:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 17:24:12 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:310:cafe::f9) by AS8PR04CA0010.outlook.office365.com
 (2603:10a6:20b:310::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 17:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 17:24:11 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 6 Mar 2024 18:24:11 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	xiaoning.wang@nxp.com,
	linux-imx@nxp.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	bsp-development.geo@leica-geosystems.com,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH net-next 2/2] net: stmmac: dwmac-imx: add support for PHY WOL
Date: Wed,  6 Mar 2024 18:24:09 +0100
Message-Id: <20240306172409.878928-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306172409.878928-1-catalin.popescu@leica-geosystems.com>
References: <20240306172409.878928-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Mar 2024 17:24:11.0885 (UTC) FILETIME=[1AD279D0:01DA6FEB]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|GVXPR06MB9041:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4dcbc95-26cf-4a30-c651-08dc3e023d64
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X/5Q0shPMEq/Br+URC7Cykfc1wlqGDj5L1HHw87a0ajMwxQmAJhuHsPFMBqee8svThpoXXEDJe4/fih5bU/DFJMNtW9F9Na4224FfZWt8pLYf4GhKRBV4qDrjxJKGWwRqL71a8YxO9CCShzdOK3IhBOjJrsURNYVHS3033HwFdQmI01NRmrpMiljoU33bj65QLLrgZ6dedLRZj5UIrYu2Cs/rFMLStKgaEMWQQRItvYDdlRQITwMimQxpfitEM+PswWulirl29g56VxNyoLNRbYU5mylUt+j0o+xPqxfCX7Y35Uv4E1ITLiOfjw4okPit+vXUadEP/xJaORoC2Y7i4c7OjxAsNqNQOw8NgLA/Vd0dqRiWuuQmxhQoOO3lWT9/eFrAhCojpbi4OKGIr6n+JDTbil5c7iDY3P25raATFgG6B8JvnjcxkJLj6YVsGhr5ujhGyE68b7Mk1AcNAxpw2j7O+mS4ijUggjqXYjIIK6fWiYq/81R570xxgml+3c5p2JwkZIz4ZpjymlYEt0Nj+RSm+3ppJt+ZfjGfeVBVH8pctegji/Ttg5+e/ZI9rPi0zK7zgodT1F0vRsnY2TkKQAzniWzCbjOI669ETV3Gz6G77ZZivOXNGqN1E64HQThfg7T6fRQJRCMp0DbeQSTLeK5c9+7KQlNwxX3cCLfTMHQu/ZRCR0ABIGhAIyZl0b5FbhEEivHNPmqZojqbw3jHyIyKlcG/I9ukk271iHhHW3hu/822T7hh8mb2f1S333Lul0pD03irJDy7sSmFe/vJg==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:24:11.9857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dcbc95-26cf-4a30-c651-08dc3e023d64
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9041

Add support for PHY WOL capability into dwmac-imx MAC driver.
This is required to enable WOL feature on a platform where MAC
WOL capability is not sufficient and WOL capability built into
the PHY is actually needed.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 6b65420e11b5..9d7278c083bf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -59,6 +59,7 @@ struct imx_priv_data {
 	struct regmap *intf_regmap;
 	u32 intf_reg_off;
 	bool rmii_refclk_ext;
+	bool phy_wol;
 	void __iomem *base_addr;
 
 	const struct imx_dwmac_ops *ops;
@@ -312,6 +313,8 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 		}
 	}
 
+	dwmac->phy_wol = of_property_read_bool(np, "nxp,phy-wol");
+
 	return err;
 }
 
@@ -353,6 +356,11 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
 
+	if (dwmac->phy_wol)
+		plat_dat->flags |= STMMAC_FLAG_USE_PHY_WOL;
+	else
+		plat_dat->flags &= ~STMMAC_FLAG_USE_PHY_WOL;
+
 	/* Default TX Q0 to use TSO and rest TXQ for TBS */
 	for (int i = 1; i < plat_dat->tx_queues_to_use; i++)
 		plat_dat->tx_queues_cfg[i].tbs_en = 1;
-- 
2.34.1


