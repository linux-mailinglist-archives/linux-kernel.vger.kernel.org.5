Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F9475F986
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjGXONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjGXOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:12:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C9E57;
        Mon, 24 Jul 2023 07:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/jrSvegb4v8ZTP4Zuvalphe/GCO3KSukFTPiRaDir9Yntnves5B4Fy7TYS6E5nvzcmZ1c3Eyu5+rNTQbHX82FOnJNvmxKeVA0MhS7p2f+/z0E8C6wcTWg0nruk9R/KZ+1iRtsn8EtZRCbxKSZfXaFRYx7UVCwf51jrcy0m2yO0B05Q4ghf2Y8Csm7BjVDURLyVLXHtNPrARzUHtiT06kWazk1fSkADfthRx9acNvyuo4lei/Cs29tSB2EvemdnWeLtZaKm+Vgqs+vY1fdG/8CymlsNfjb+3UL0+uq2C7lEGtUlriLF1+0V59zxJaSTn9rjdwxV/zzY5IfELMnH/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caG9w6+mScE8FYg4vaj8ykQMxUOnnCtAPYAtgRzJuas=;
 b=dQlnWnWSvhDaH0jhkGviRD/Wguhjmi3wJcsqKxOPWGm6xP3N9CIs05sj+DBCqdW/vwWlSJdV89+tpqHos+94dFh2yb1o6nE1Ol9lLBcM0cPYIqQvjMB7bsvXAK8lmcAbtVrNnbkSOw/wtaQ31asutZHIMIFpiWTtQk9IUDmhFVi5qAHOgOiaMM9/Y9l4XBiK7shdxtszywtUt/BzR6unieUEWC01DlvzdSMU+QoT39b3uJQa5097RA3X5wYHdi+BuZkDZ21SbvkU3gBNBNxNtAD0ud8GN8Ei0peoGtz+0pUYXTtgrqvzFPp6UqCUrrISGfTisqKixRYJoAMWdwKdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caG9w6+mScE8FYg4vaj8ykQMxUOnnCtAPYAtgRzJuas=;
 b=Ohbrf/dLcMniJXz9CtSKhR43K/zNr8IqrFzRmu6LGBR1mpgWE0hMCc1Oj7fH2f1A1+i+yfL5C+wMVwpDOmEd+1wPijFDErC5kg0pw5wEjrzBpikKkjobsXw4CPmUOd3L7POrvWi0ffVsh8d9TFH0ZMSt2bOXDIAk5rGYrOEBi6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:12:49 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:49 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 06/11] net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
Date:   Mon, 24 Jul 2023 17:12:27 +0300
Message-Id: <20230724141232.233101-7-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc10e99-d1dd-482e-1008-08db8c500fe1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j19j6tHuJFqOLo6fXoHZDkDXHiHhcEFfadpjpga/29TR9sj55wQHwlSHt3OgL+xdxDyKyacm3AJxS7uCBCm8NOdZ5bvTO3hQW9svYv4b0phiIKt6HQ99xStx4ZHzpxhAPs1WYBdtwZDI/T+dQeCEZ7T92mWGC7SYoBVggMCMRc2WV3QimZTP2nJt+aLwEGeblWm+Riaeo8ZmAnj0nOk/sWTXBFnOWUD7xEuvB0nmC9vkYV67J8bZLifgtbwUraQtDTu5rzi0fTSk6AFTK5GHAQybPuoeNo9l/2agv2CphS/3Ay1nXMmT21eVA6MyyDOJ8qlHmSp0pmXdtL8uW7F5Tg7SXYgWYIOz8w9aH6h1u8/8Tin/CwxZ0DItC5UFup1JDpHjpcm3vaY9yiy73CS9TI4UyBR6gtWuPDPckOTbjrliSWkbjLxTOuGALSdsYWK6NkM+ItqwG4li/SrCzfV86lnrM1rGjv8eGFYFmB7dGEdJedpuRNGeQ5Qtww/pxFpvy4gdfKamSL3UY58wl5aYthVIBAufO2Yx3W2ThfRzt1AWayQ90ReHE05obQTkSnX3jRLOd7vg/EgDg2/J4BgrCiXkTWEU19FQz44q4FLi7TCb0dDeviz2PUIWVO17U9ws
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(8676002)(8936002)(478600001)(2906002)(7416002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(6506007)(1076003)(186003)(26005)(66574015)(52116002)(6486002)(6512007)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b2HYdl9x82Hocj2Fx3KuX+BbBZGqIFeyS1U7mhfj0AOZnBGH7heJiuH5/ni4?=
 =?us-ascii?Q?kLJg7QDzHISCW/+dr8FeNHxFr1lAukCW7e7KR8aI31rwjkJBE8benzuN+9Vs?=
 =?us-ascii?Q?z8mz4SjD6jPnPCGw5W1WQ3CaA/PpWKzf8NHiOdBgZSUPfUTjr9KkZVOGlyOT?=
 =?us-ascii?Q?C2n1A82NHnibgLl7lXM61n/LuIqzhMW79H60atsh80yjKy/yayaFon3TlQfT?=
 =?us-ascii?Q?4plvG4aCT59/YlKMPJfA9xXCKk47f7Bl35YPwVYDMPbeiBF6negKnzaiItCO?=
 =?us-ascii?Q?LJo+BOEOrd24WdJPvZDwhSMa5bB6g16oE4VJE3QNv6DKME5uXJ0AYI0ZeVfh?=
 =?us-ascii?Q?OCGC42sW+3K5UzyqfutMRChlGaRUfct/AK0uGaJZ2D0Ju0xWNCU6WcwFyA69?=
 =?us-ascii?Q?y1idZ3exWd86JgEpCtNr/FpFXzJs4FNOEJtT4G37x0cA+8QCqOdCxnm7RL4r?=
 =?us-ascii?Q?eswI4RKCoEJuoAWitRG/Rs7M4K677Vd7teQ7VLPomnbrhxuWoty7pCLDDbUX?=
 =?us-ascii?Q?ua2CSbFybqGnKNCGr2eUAfWZ9jHYNS7C2JQMW/5Aoqrd9T5YJkTRfkgI5Sa/?=
 =?us-ascii?Q?LD3u6CoHviy2cePrdneG4LgwzeFKEUAmErSoI1FDc0iiHSSPfBCpbQWF6OU4?=
 =?us-ascii?Q?4a6w+0dIV4O0nm3ufbqfpiKA74IHnPaOmqJ79YU+Q8a5dvOD0X/Xu1x6izdF?=
 =?us-ascii?Q?4oxcymGTAhzlfx8e1AD0UvlQ8uC1aaDBTLFzL2c8UXp1J2we5YUDUiLrtNMe?=
 =?us-ascii?Q?gVTmoKnKDaS3DHX6hCa64gJF+gJuEFbrmEv5qRfknEx6/+bNNVfYq6O4bJ6G?=
 =?us-ascii?Q?J/zV6c06tw18PivGNIpQhr9Cmuud6OPq39Jz4rw5zme3ClFiZNBxxk+fbp8x?=
 =?us-ascii?Q?opkVTPWlQk3Ph5u+b67sDdCtBnAdFL4oemteL2wEYHEvEzDOOJ5RsG5QPUGg?=
 =?us-ascii?Q?0tzfF/jnjlOpttN0mPw4ijQuL5cqvmLsWUdnXxnA1tTFyC/fFt7cqwFAUOn4?=
 =?us-ascii?Q?3XpPSmRAtVsBZY72OenbFP9B7hnF5nosE77sg1QlP/MEE1eokMNcifay75WI?=
 =?us-ascii?Q?IYnAP+hBxMqpA8jIj2Fj2/9wgAZlkhtq61QQg9RDlwknH6c5+bKQLu9Hv3Ii?=
 =?us-ascii?Q?BFMQeSSsenZS5iZl0MEA+D+gyeobrHglMq+kLoiYICSpegn5TwgwLxivFpOI?=
 =?us-ascii?Q?Hfvbx3sIJ8egsScaWT6iHvSLloGkju/BcdcoV0qYSH0pQmKt7YuKmULzv8JR?=
 =?us-ascii?Q?BfzdLWdztk2qmB0srAEDENRs/qJgURmfYBrBSJ0xRAIf+u9iR1VhetL7dJ1V?=
 =?us-ascii?Q?KZoK1Fblfoj4ASG4eaNWaYXKF1t2AJ3WjgCDZWYtJhUCMif/RzQHugPn1Ip4?=
 =?us-ascii?Q?THwK0Zl9pm3qlrFXfkFhFwR2WqxlT0fELCuUqPLQzqvdr0pEeHYZ4o2QD4eD?=
 =?us-ascii?Q?9gPjWX56pc3X8As456QKmp2o9TGJTjNAGgUMHT82Lfx38V8HHeUjBPwpvMnn?=
 =?us-ascii?Q?XQVldn7xy9iGZOU/+p0CpGPop5fOlbBudhkaBT7CgebUMnwPyTIsY1EbNL3Q?=
 =?us-ascii?Q?mEem3QRncfmSR0UdEinkPWzKHs6++Ttr/EIuB2eqSvgaDhb6W49lcN8GdMXn?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc10e99-d1dd-482e-1008-08db8c500fe1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:49.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsH0uGKGzcsMtK/2tcu2E9bF01LRYSUfpLUUIuTiRMcg0btgKRiNOAoAUwzOBkm59C8Yn3ssx1WtSECPNtfATCf1b8MI/TqxKxRmUYNFO1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external trigger configuration for TJA1120 has changed. The PHY
supports sampling of the LTC on rising and on falling edge.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 60 ++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 47decf2677e1..62be1712167e 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -101,6 +101,10 @@
 #define VEND1_PTP_CONFIG		0x1102
 #define EXT_TRG_EDGE			BIT(1)
 
+#define TJA1120_SYNC_TRIG_FILTER	0x1010
+#define PTP_TRIG_RISE_TS		BIT(3)
+#define PTP_TRIG_FALLING_TS		BIT(2)
+
 #define CLK_RATE_ADJ_LD			BIT(15)
 #define CLK_RATE_ADJ_DIR		BIT(14)
 
@@ -238,6 +242,7 @@ struct nxp_c45_phy_data {
 	const struct nxp_c45_phy_stats *stats;
 	int n_stats;
 	u8 ptp_clk_period;
+	bool ext_ts_both_edges;
 	void (*counters_enable)(struct phy_device *phydev);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
@@ -684,9 +689,48 @@ static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 	return 0;
 }
 
+static void nxp_c45_set_rising_or_falling(struct phy_device *phydev,
+					  struct ptp_extts_request *extts)
+{
+	if (extts->flags & PTP_RISING_EDGE)
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   VEND1_PTP_CONFIG, EXT_TRG_EDGE);
+
+	if (extts->flags & PTP_FALLING_EDGE)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PTP_CONFIG, EXT_TRG_EDGE);
+}
+
+static void nxp_c45_set_rising_and_falling(struct phy_device *phydev,
+					   struct ptp_extts_request *extts)
+{
+	/* PTP_EXTTS_REQUEST may have only the PTP_ENABLE_FEATURE flag set. In
+	 * this case external ts will be enabled on rising edge.
+	 */
+	if (extts->flags & PTP_RISING_EDGE ||
+	    extts->flags == PTP_ENABLE_FEATURE)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_SYNC_TRIG_FILTER,
+				 PTP_TRIG_RISE_TS);
+	else
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_SYNC_TRIG_FILTER,
+				   PTP_TRIG_RISE_TS);
+
+	if (extts->flags & PTP_FALLING_EDGE)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_SYNC_TRIG_FILTER,
+				 PTP_TRIG_FALLING_TS);
+	else
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_SYNC_TRIG_FILTER,
+				   PTP_TRIG_FALLING_TS);
+}
+
 static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 				struct ptp_extts_request *extts, int on)
 {
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(priv->phydev);
 	int pin;
 
 	if (extts->flags & ~(PTP_ENABLE_FEATURE |
@@ -697,7 +741,8 @@ static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 
 	/* Sampling on both edges is not supported */
 	if ((extts->flags & PTP_RISING_EDGE) &&
-	    (extts->flags & PTP_FALLING_EDGE))
+	    (extts->flags & PTP_FALLING_EDGE) &&
+	    !data->ext_ts_both_edges)
 		return -EOPNOTSUPP;
 
 	pin = ptp_find_pin(priv->ptp_clock, PTP_PF_EXTTS, extts->index);
@@ -711,13 +756,10 @@ static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 		return 0;
 	}
 
-	if (extts->flags & PTP_RISING_EDGE)
-		phy_clear_bits_mmd(priv->phydev, MDIO_MMD_VEND1,
-				   VEND1_PTP_CONFIG, EXT_TRG_EDGE);
-
-	if (extts->flags & PTP_FALLING_EDGE)
-		phy_set_bits_mmd(priv->phydev, MDIO_MMD_VEND1,
-				 VEND1_PTP_CONFIG, EXT_TRG_EDGE);
+	if (data->ext_ts_both_edges)
+		nxp_c45_set_rising_and_falling(priv->phydev, extts);
+	else
+		nxp_c45_set_rising_or_falling(priv->phydev, extts);
 
 	nxp_c45_gpio_config(priv, pin, GPIO_EXTTS_OUT_CFG);
 	priv->extts = true;
@@ -1545,6 +1587,7 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.stats = tja1103_hw_stats,
 	.n_stats = ARRAY_SIZE(tja1103_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_100BT1,
+	.ext_ts_both_edges = false,
 	.counters_enable = tja1103_counters_enable,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
@@ -1640,6 +1683,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.stats = tja1120_hw_stats,
 	.n_stats = ARRAY_SIZE(tja1120_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_1000BT1,
+	.ext_ts_both_edges = true,
 	.counters_enable = tja1120_counters_enable,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
-- 
2.34.1

