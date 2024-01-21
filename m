Return-Path: <linux-kernel+bounces-32054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AA08355C8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D720F1F22116
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D4381A4;
	Sun, 21 Jan 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TaKEfFnn"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2036.outbound.protection.outlook.com [40.92.107.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332537711;
	Sun, 21 Jan 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841021; cv=fail; b=kn5Ecz3AGL25Ljn5qPzvbD4Z4+7AKG1p3/TTrmcqRHYGowEBhb1VtHuGOhwMP4NjVXnvfVfOTosR6MIVLQn72utqqWKLous0wtGdtZ6g4sDwlsS34Q8KEpJcaiIpHO7CdygIWMF3tE5jDbb/l8XiOuAws0NukqJZYZySsYArUew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841021; c=relaxed/simple;
	bh=9+spHWTZg8IP7y6iQW3LOYx1dE4lXC28+wN8FZ4micA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SF2qZWBA+B3hy/JrmSr4K7jjfPrpB7TViJbwj5uykv7kP5jfPKz5Qj+JaUC13cSaKxfUjT2HCgOs9omtreXlcM0tmHvWkF9QygjK/atjMS9yS7RzPSP8zcAH0hheXweK2cxVIvJfjTX1AqDtDANFz7VR5JI+K9C5A/7eb7+uAXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TaKEfFnn; arc=fail smtp.client-ip=40.92.107.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZZnQashbBdTY91tUp5wZJwGiEqaPOkkgNEPKjsKcGetu7W5TOe/wN0DjefMAMRnY479pc75MTBAPxuwxn4pLXQyKOkMecfiLcgiOQDM5iY1Npk/AGnRULuIvlCwos91MYjezbJz0R7gVE7l7RzYLpicNii2yZ7f4HOgalIExYqoskI1iMQYb9jeMcNOY5LDHc0OuDMzgc4tcgB2Hnze1EnEnbnMG/jmv/Yz0+NkSZb2s8/ajz34vlhLuVUU5ucnmqmjRwoqHPvCx7nxyOvNWlBpLHMlG/rkzNeuJoFCgpamqe5h/xVzqgp1q+NjNEhPbT9eiOzlYEqHSJ49FWRZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeF/Np6r3wx5dMVJ4z8gk42WxkpVi8rIybYiu1roWII=;
 b=JE1dcNOcZOYsb+fZoiLugcAgKI1miA9aByBFhXt0RvYMtBumBgo7jU5Je78b8XgzyH0Q1Sk3rch9Vm7GvNhPaRDsgk3nlG1jTFS9zt4s8dypp7M4fidvZcMOnhFA/oS5kwwKGi5P72qOmfKHdzNKoxIbxejp/jp7C2OhFxQmoaTfUT93VPEHEBP5awCQrDuvVGkmcuLHHrZ8PtOvt4e80kJJWeT6/V1xZBlGRC5UDXcZRxTeZfsLKJHl7gGTB81lZNZGymewR5W/ogE5o73+vMYaKuPQVD7JhjJsvd/WTPauEIrMBeGdpHzFLCaw3+KH8BYmTWMNlz68+TkzPCIQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeF/Np6r3wx5dMVJ4z8gk42WxkpVi8rIybYiu1roWII=;
 b=TaKEfFnnBYW/pnO2zI8PizUvSmp5B9x1e0BQ2LuARhqNndSp4/b7f6aiB7cn8sqNN1hAfV/ZLOcSKWEyFl74tQXOLpnZR/czUb6waCduR0h1mhYPoTxw3Qv3+GTuvDsPAA4iuymgOx17edL1JKNkV+ybeSulu2UHfisETvlbXgSghhNy3DCYTeFY1b2khXTcvbxmJyTx4Z4S6opx5WNV175dy8QoW8u9XYVT+kOFfGfTLP3SEBAeqKCIOTynyZ1Wcl3TwkQ3Tb5WwYhDrDOVsNOpJfhasaD4/oRNLh2EiHYSS0ftYQgMApVn/V87Y8frJNiByaEnF9cxHsSNW7P0ug==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by OSQPR01MB6119.apcprd01.prod.exchangelabs.com
 (2603:1096:604:27b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 12:43:36 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0%7]) with mapi id 15.20.7181.019; Sun, 21 Jan 2024
 12:43:36 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 6/8] net: mdio: ipq4019: support reset control
Date: Sun, 21 Jan 2024 20:42:35 +0800
Message-ID:
 <TYZPR01MB55568177805D79143E8CF4E2C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [6eQm7VelkNsE2KT1NBJq/W242KG1dVYWwqvIXC+ZwKZnQo77a+eDuw==]
X-ClientProxiedBy: PH8PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::26) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20240121124237.3328702-6-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|OSQPR01MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af9ed1d-9519-4440-ef77-08dc1a7e95e6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g1lKhGeYf37neibm5/CFAXSAjsas+WKF3Vih7Ut6qxMjpdliQwGdju2leiNvl1BY5J3HXydxAHfBIsv+Nqifxh5YOboh4S2lN3XGyJ4XbIWrGOHrd9gXSgP4d7XSe8UFiZhchyuScbVfN8IUsy/2PJ2K+0eTM04XZHZ1IqADgRlQ5ts9/uCkoWoq3xQNk++MH0Qtp3IwHibCJxyrNdC71Mh54jGzRpSLjAcMUICGdDTg8bKQ/Daz9nFl68RI2cwwZOIy0sH1TEdCh/tzi7WQoKsIbh/6++FG7CEtdym8vDQPD2qKugsGsIXIG95t97YuG4L1j5uMJ+CLTGhZRi0FF1/J9ZtYGEyIXqCcj3xKxUZTTZQgssK/NuYEjeg3vJwoe5tQdGIUDbSfccMonjJTexmLT3G4c+Bp7R25XGun/BbFAiC++3TtqQ6VfLznLf8x69rdrFzz/Fh5RuWp3GIiQuJDN/12CYSvMrHVK1UcSh8xoRTE7Z3iXSFj6aIh42X+miK76cW7bP0RQAdEH7K34og8c6PNp4XRrEJSDRx/mLck4IGue2dsPT1Wex67NgPkmyvcdLH9l0DrB55P3VloiMGjep40Z4nONI688GhVmd0mimPB9al4jDG504VqME/S
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RJHehYWzhK/vGFTqjyK+gW51WGFcaRqSxdFWnLzK7okowacFhIfslGcv+xf/?=
 =?us-ascii?Q?UYf7rqSlPO2MntZ1uvQP22vZ3YHQdk0ezrQVlzkLVL3870++D1en5sREZlDx?=
 =?us-ascii?Q?Z+qGqVnLydMDU6eeIayVxpXQCvZIZAgHbks15DZbnThXZS2H/GV1u6XSVm8W?=
 =?us-ascii?Q?B47w+tfHpdlsOCP6aWvg2mOhpz5AgbprTjpnvGuzpWHmWD126Ed0W3xD3NcA?=
 =?us-ascii?Q?pTzFzsT8y9bY8ysmlcXotaqD9hcIac+mUJISmlzD32MWaU+tSG3lXBcYuG7S?=
 =?us-ascii?Q?rmGxuHONqtz2bRHCXcbNBxOZljpQIlx8FNGFmcetLZrTdVSJnGjwLpocZzK4?=
 =?us-ascii?Q?xlYB878DEgvgKHEcSYU7sUpy25keuADomz+XEYOJwLZ7fqwKPuJ7hfO5yvOo?=
 =?us-ascii?Q?W1qX0f54UIUIGXe2WBM02bR0ZSCIij4k/+hKlzpGPdihXmvXMOm/7XjUUkix?=
 =?us-ascii?Q?F5ziphz3Dq77xV9aWePW+GOqP28xgIMYy5RBYhP2N6M0ugalyYjyJJlGXdAg?=
 =?us-ascii?Q?wLhAsovfyjr04kbElNcztdt82v1VmiS+0WC9oDrR5Q0QnFZAiJtpigwNfSGj?=
 =?us-ascii?Q?r8DgfZKb0ohWAOMOVLjWzAPuRG6KwoZIaWOA8BniPPVCRb4h5fvU4hMKC3Bh?=
 =?us-ascii?Q?lUVBZUpct6wKoLJlnAR5TXc5BFpNsBmHAtZbaEy93LjpIYNmmKikcpX52tjr?=
 =?us-ascii?Q?DED5WApnsRpazbiljyHSIVi80sVJyqwwN/sEgGOkyefyKEfuBtKh/K2nwW8W?=
 =?us-ascii?Q?Bi96HMi1/nEStMC+/RSVw+r+Pf3BLazrdu2wkwo5aftwFKsh7SClcpb//2ec?=
 =?us-ascii?Q?gX+XxXU+gqgaUds3QlB8qcssLvWf5EW7bAm//X1DMsM59VmUAYaM8bOXyvBl?=
 =?us-ascii?Q?GhOnQbEuXtLI03EbskVgUWD/ZygU2UKKC5o+Oyq0CXvAsAb5JuEQYDACpwsY?=
 =?us-ascii?Q?/nlsUkFHB2iLEyiW7V9LqsT66+xuiLPkoF56vzU3hvaM5EGtPgfo4JnE9EcQ?=
 =?us-ascii?Q?TXqq0K13eAnX6LoDWIJajen6/6LHJeLEPIt4A9Qf+up+ww/RMCShDevrDPC/?=
 =?us-ascii?Q?jAtabuqipnakM/gkHG8lfJGzVKAs5eigg50oQb3/nkry6QXk7H0XwuLsXEGN?=
 =?us-ascii?Q?HPcIQtrPwVwQTD7dnBYHZo7XvyW4Z7b2530n4CUN29494GuOuyjFsUwX18DO?=
 =?us-ascii?Q?tZHV/26Skb/7s7ndUPS1Soa3CDy/G0oQkwMMJ/7lo1NM0W70BinioOngUdc2?=
 =?us-ascii?Q?TB74xnGyRoZrItckuxeE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af9ed1d-9519-4440-ef77-08dc1a7e95e6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 12:43:36.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6119

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 78b93de636f5..b52c5e1fb99b 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 
 #define MDIO_MODE_REG				0x40
 #define MDIO_ADDR_REG				0x44
@@ -40,6 +41,7 @@
 struct ipq4019_mdio_data {
 	void __iomem	*membase;
 	void __iomem *eth_ldo_rdy;
+	struct reset_control *rst;
 	struct clk *mdio_clk;
 };
 
@@ -219,6 +221,10 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 		fsleep(IPQ_PHY_SET_DELAY_US);
 	}
 
+	ret = reset_control_reset(priv->rst);
+	if (ret)
+		return ret;
+
 	/* Configure MDIO clock source frequency if clock is specified in the device tree */
 	ret = clk_set_rate(priv->mdio_clk, IPQ_MDIO_CLK_RATE);
 	if (ret)
@@ -248,6 +254,10 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->membase))
 		return PTR_ERR(priv->membase);
 
+	priv->rst = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
 	priv->mdio_clk = devm_clk_get_optional(&pdev->dev, "gcc_mdio_ahb_clk");
 	if (IS_ERR(priv->mdio_clk))
 		return PTR_ERR(priv->mdio_clk);
-- 
2.40.1


