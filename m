Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFEF75F988
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjGXONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGXOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:12:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E52E54;
        Mon, 24 Jul 2023 07:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abeQum17DXkbm74g6qSl1P8rOF5TX6Nc9Q/FVeLi/NvZ1j1CBXjE7dG3HPUEtjh0gcTaNP8XTggR3RyJQDdgQfJAiMfwwFqnLL3mw8G0HU9oSptv7um97HhqsQ4/wO7pums1rWEN2Me3BTFboLpZ2SlabIn0/S0MhMTBo+YOYXtI4xin11isTNh+aD5LDdeHv9smErKZlrT0Zfu+uIadPmHBc+Hzn5M0OloGm9QYiJa0v/musoAGXY5mwTec+FcE+OfhliHqIu1BrkPdITLiAcdw7X6lMkTiW+KHiRlk6cBKpfwZ166ZvYiki0ei5h5aAdPmJK7XinUlTGs5JMcCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9ZhOVvXQBX6vcdkyDC66zUtGeo3HwWNDGX91SbU7eA=;
 b=g6eMV3vQaWamUg71gXKfsK4AScFVp0FXnnPAYjfqkc3HTJpeEU199+jpAlg8ADLSY2Ckn5mTeelU68syPRn4r8BFd9tQjcFSH/pJkZSAfmLLCOIKOwgzASdua3/kQbrYv1fopK4p7GV0w9KXSUJxGPttGchm9CPuC5ouQ39WYnQVdDZQTpDCyXqkcsIPaM1+DFYZx7Ylpf0TgufFvqtbLMmtW/Wxslr4ZBp2IFKvxh5HJTSkMNsys5puSXlae0Nt9I8hgjXv/UFPOkKlCKWBFS6kJrYEsVS9m0uII4PhaWv9+WoZ4Q8h3ZF8t8yYAVPkTrrVVc7MksasYxkwAwn/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9ZhOVvXQBX6vcdkyDC66zUtGeo3HwWNDGX91SbU7eA=;
 b=V6LwIYpTotai7Hd0Pn02xxup2u6WsnSyvilybNdnrprKVIfgShe8U0+WU7KDvBM1McjamoNt3jhsXpvj2K0AVDImmDWOBpIZqLCVh/HbqHTSPBuKUiJC1lHn9DYYpe1lS4y8NNhvNFq502FUZUHMNZWz2thKQK/4rHpwIMKwJ3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:12:50 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:50 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 07/11] net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
Date:   Mon, 24 Jul 2023 17:12:28 +0300
Message-Id: <20230724141232.233101-8-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b557b20e-e623-4890-8d8e-08db8c501066
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/IH9qVvxn/GQ/1E/UbJjUTxbsQYvUw43lwm2Zf7iBvGLVnXfaMEWQ3NtRJOKYM8fWFOdUZTHKaVGqiznoZhXWi46MSUhHJsxYm04tMpAIVu/zVuHHsjBmrSDQAy0QOFTau+rngQLojkSojUaoqTiIFAK7iCUgwljRZzISXT89E7nmTwpIL8oZTHJMrguujQCzlSLeavFJbrdEcrR60rZ4YJSxBgM8Ph1H4yifpQNu1kmQ+s3TROy/7xQvbaq2Mgmtu+CEcM0txv+Meo5kdasGH8pQsMKfEaAyFsZDfsOY1QlTutyw6WxFcW4QosftBhIKE8Ly04cp4D0XAb0FAmLWkwXWYYXpoWk0JeednHj2niR2hbmo+MTeIJLsOybH0BYVmNyYhAmSSOX7s4ZQe0c5VmqqrxpDmvlrCBaVi9rCV75NN7NZbtk/gcwmtZTnkPAWZ+V5M9Vp0ALjvmghk2Mt9DWJCRnl8IOzhfzIF8HdF1MEMrjW1o/a0u/0DNL+gIKMysOHhTB9Z5aR9zItWxHDeeiIfmgatYpg0GNfFu7sZuHNIudXHcCzVx1rQ3udqS40gvSuXm1z8quZEJfbjOWb9cw+PBTj2AyRzchN+LAoXiOwyr1G/2zVgYlN8ZoFhd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(8676002)(8936002)(478600001)(2906002)(7416002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(6506007)(1076003)(186003)(26005)(52116002)(6486002)(6512007)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rLeTfs6vLhyhMCiv58WPaHA7SKdSJXmPLT7AgZDBK9UnNpf4rVJDBguBid1w?=
 =?us-ascii?Q?q1txKUVBnFB6uRVBBNT4VQnGDL1KiA+/d/hIf8y6jPZkS3l98rJBH2IqoKHU?=
 =?us-ascii?Q?Qy6lQss1j/ZvBURcTdbnK0FS1ZDdiH9lZ2rfz8fPeaFBhnSVR6Of0/HBTAjC?=
 =?us-ascii?Q?LaUcarfqjnD7Rl8JEl4rHjI65L3nmXZQ2e5M7dd9w5f9zrjpibeSwO0j+hnq?=
 =?us-ascii?Q?KXvR1LdrDuWmolSSZdKXk2bFra1D3Rvc549tKvrUo+4A/KpR3XjB0ALNE/7u?=
 =?us-ascii?Q?NiKzQaz4sP0oxPY4LSJwAccvyNb4to/Y8hH4iQwSzKlFgq5M5uXHNkbCMQnl?=
 =?us-ascii?Q?neI8VIKL/BTeeQ/yTNVsJPh/NBdjxtOGL3bzMOmBv3+GUswHdilCASeHV3b+?=
 =?us-ascii?Q?2l2bDp3enxo9nK/OUje7DghpwOF5otxBECxH4qc/AukV6+sMq5ki8MmX1KV/?=
 =?us-ascii?Q?fdLv62aeKLLLa5WdKZtxx93y2qWGvKfhk4+cl9kkpGfr029yiBpOnNBnFZ/Z?=
 =?us-ascii?Q?D/JWco2dnTnOAOYdvoyKNPAwxpV/0BXfiB48TubIxnO97aEX5HOTEA60Jy9s?=
 =?us-ascii?Q?/meTAxiDIar9hQ8ElM2YI3uvaVrGOrKy47/y9Gir5mO4iXKsp1RcHLpCA3j0?=
 =?us-ascii?Q?b8ZfSHFVyMp09vNCSi+rJAus2gCyskTw+5fRAw41HFJBxnxoSnfM15qyCfuF?=
 =?us-ascii?Q?FWemcs7wcekuvhyKyAbRa0U5LmP2a4J0I6tUNSaoq36SvgFigvcR+7O3PnYM?=
 =?us-ascii?Q?89/qU4RdLOd3fE0JRCZpyOmDVtCUMj/1D7IBuBpSeQsItPM8ru52qcmh5rii?=
 =?us-ascii?Q?v2xwhd1xcjHl3NnxExO6rXTxwUO1c+cTRSmFN0fc19bZuu1cp5Om83VTEnEW?=
 =?us-ascii?Q?DZBkD2VKUXxj7spnMkI2IajtKBU987L2T2Itv71yVMdBl6RZpm7g4746+Yc2?=
 =?us-ascii?Q?hWL5YENZ2oTF2JXtl1cklYyYFEsXiwMinZgDXZvB7JF8NY1WK3ZeGq+wSg0z?=
 =?us-ascii?Q?tOPB5gq5A05KwaUlNAM9StkN8Kns0CiBjkReKjEmX1oMDeYjK2qElvwBdumT?=
 =?us-ascii?Q?s35GP2pbMgDneZHqaEBJlgMSbupYfVubZ/8fn0wcnLiJ83UM4K/+8s4PxyDN?=
 =?us-ascii?Q?VnCIf8I6VJpb8fGS3zdC4Zet4p77giH62dnZ4dREYWdOrgRy01/aevSW+aeQ?=
 =?us-ascii?Q?loS072FkZ5aRfB5jCBJiyOSD6dEnmiVSIm8C2QWjVv+551rzs8IvGwwLatsj?=
 =?us-ascii?Q?Te5zUBSJhGCGjOoBvkpSn3H0YxqT4TesokUjBIB2rWS5quUK2i0/u0w5WQYp?=
 =?us-ascii?Q?DuTQJy8IsLsjtC706ONjUVKFfzdWtj9jOPYBeHMdbq6fpqhXDmoJEi2DDmWK?=
 =?us-ascii?Q?wfelFD9rCFnakLvGWvxH+2GMgNLWeC3LttdHUK4IYZup/xglL3yeUmFK9csO?=
 =?us-ascii?Q?RsBRwVD5+ymVVjF7D6J+UOw+bN+0uXo0j8/mBmPm5BmZ8nizZ8vbBCiSegzO?=
 =?us-ascii?Q?vsHsmG9k9YTq5MHj2eucDlT4opt5PoIqfXhZ+n9nF7KjlP80c8edX2D3qlRO?=
 =?us-ascii?Q?Xx0WpD5nE4cLP8x3Z4t405IQCmVJEW713BJHJZtv0xPR84NHkqK6tinlSJ6I?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b557b20e-e623-4890-8d8e-08db8c501066
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:50.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tu88+zURBtorExxPOpJiYJ7kKVeIX3+otMh3FwMV9Rroxl/AHpQKeIY6LPsWcRzTYYaOeRs/aqkwDthtBtRWDskNIQ7Px+zuujIC4rvFyeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The egress timestamp FIFO/circular buffer work different on TJA1120 than
TJA1103.

For TJA1103 the new timestamp should be manually moved from the FIFO to
the hardware buffer before checking if the timestamp is valid.

For TJA1120 the hardware will move automatically the new timestamp
from the FIFO to the buffer and the user should check the valid bit, read
the timestamp and unlock the buffer by writing any of the buffer
registers(which are read only).

Another change for the TJA1120 is the behaviour of the EGR TS IRQ bit.
This bit was a self-clear bit for TJA1103, but now should be cleared
before reading the timestamp.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 110 +++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 62be1712167e..0567a366af37 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -29,6 +29,11 @@
 
 #define TJA1120_VEND1_EXT_TS_MODE	0x1012
 
+#define TJA1120_EGRESS_TS_DATA_S	0x9060
+#define TJA1120_EGRESS_TS_END		0x9067
+#define TJA1120_TS_VALID		BIT(0)
+#define TJA1120_MORE_TS			BIT(15)
+
 #define VEND1_PHY_IRQ_ACK		0x80A0
 #define VEND1_PHY_IRQ_EN		0x80A1
 #define VEND1_PHY_IRQ_STATUS		0x80A2
@@ -59,6 +64,12 @@
 #define VEND1_PORT_ABILITIES		0x8046
 #define PTP_ABILITY			BIT(3)
 
+#define VEND1_PORT_FUNC_IRQ_EN		0x807A
+#define PTP_IRQS			BIT(3)
+
+#define VEND1_PTP_IRQ_ACK		0x9008
+#define EGR_TS_IRQ			BIT(1)
+
 #define VEND1_PORT_INFRA_CONTROL	0xAC00
 #define PORT_INFRA_CONTROL_EN		BIT(14)
 
@@ -158,6 +169,8 @@
 
 #define NXP_C45_SKB_CB(skb)	((struct nxp_c45_skb_cb *)(skb)->cb)
 
+struct nxp_c45_phy;
+
 struct nxp_c45_skb_cb {
 	struct ptp_header *header;
 	unsigned int type;
@@ -243,7 +256,10 @@ struct nxp_c45_phy_data {
 	int n_stats;
 	u8 ptp_clk_period;
 	bool ext_ts_both_edges;
+	bool ack_ptp_irq;
 	void (*counters_enable)(struct phy_device *phydev);
+	bool (*get_egressts)(struct nxp_c45_phy *priv,
+			     struct nxp_c45_hwts *hwts);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
 };
@@ -499,21 +515,11 @@ static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
 		      regmap->vend1_ext_trg_ctrl, RING_DONE);
 }
 
-static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
-			       struct nxp_c45_hwts *hwts)
+static void nxp_c45_read_egress_ts(struct nxp_c45_phy *priv,
+				   struct nxp_c45_hwts *hwts)
 {
 	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
 	struct phy_device *phydev = priv->phydev;
-	bool valid;
-	u16 reg;
-
-	mutex_lock(&priv->ptp_lock);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_CTRL,
-		      RING_DONE);
-	reg = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_DATA_0);
-	valid = !!(reg & RING_DATA_0_TS_VALID);
-	if (!valid)
-		goto nxp_c45_get_hwtxts_out;
 
 	hwts->domain_number =
 		nxp_c45_read_reg_field(phydev, &regmap->domain_number);
@@ -527,12 +533,72 @@ static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
 		nxp_c45_read_reg_field(phydev, &regmap->nsec_29_16) << 16;
 	hwts->sec = nxp_c45_read_reg_field(phydev, &regmap->sec_1_0);
 	hwts->sec |= nxp_c45_read_reg_field(phydev, &regmap->sec_4_2) << 2;
+}
+
+static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
+			       struct nxp_c45_hwts *hwts)
+{
+	bool valid;
+	u16 reg;
 
+	mutex_lock(&priv->ptp_lock);
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_CTRL,
+		      RING_DONE);
+	reg = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_DATA_0);
+	valid = !!(reg & RING_DATA_0_TS_VALID);
+	if (!valid)
+		goto nxp_c45_get_hwtxts_out;
+
+	nxp_c45_read_egress_ts(priv, hwts);
 nxp_c45_get_hwtxts_out:
 	mutex_unlock(&priv->ptp_lock);
 	return valid;
 }
 
+static bool tja1120_egress_ts_is_valid(struct phy_device *phydev)
+{
+	bool valid;
+	u16 reg;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1, TJA1120_EGRESS_TS_DATA_S);
+	valid = !!(reg & TJA1120_TS_VALID);
+
+	return valid;
+}
+
+static bool tja1120_get_hwtxts(struct nxp_c45_phy *priv,
+			       struct nxp_c45_hwts *hwts)
+{
+	struct phy_device *phydev = priv->phydev;
+	bool more_ts;
+	bool valid;
+	u16 reg;
+
+	mutex_lock(&priv->ptp_lock);
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1, TJA1120_EGRESS_TS_END);
+	more_ts = !!(reg & TJA1120_MORE_TS);
+	valid = tja1120_egress_ts_is_valid(phydev);
+	if (!valid) {
+		if (!more_ts)
+			goto tja1120_get_hwtxts_out;
+
+		/* Bug workaround for TJA1120 engineering samples: move the
+		 * new timestamp from the FIFO to the buffer.
+		 */
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      TJA1120_EGRESS_TS_END, TJA1120_TS_VALID);
+		valid = tja1120_egress_ts_is_valid(phydev);
+		if (!valid)
+			goto tja1120_get_hwtxts_out;
+	}
+	nxp_c45_read_egress_ts(priv, hwts);
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, TJA1120_EGRESS_TS_DATA_S,
+			   TJA1120_TS_VALID);
+tja1120_get_hwtxts_out:
+	mutex_unlock(&priv->ptp_lock);
+	return valid;
+}
+
 static void nxp_c45_process_txts(struct nxp_c45_phy *priv,
 				 struct nxp_c45_hwts *txts)
 {
@@ -571,6 +637,7 @@ static void nxp_c45_process_txts(struct nxp_c45_phy *priv,
 static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 {
 	struct nxp_c45_phy *priv = container_of(ptp, struct nxp_c45_phy, caps);
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(priv->phydev);
 	bool poll_txts = nxp_c45_poll_txts(priv->phydev);
 	struct skb_shared_hwtstamps *shhwtstamps_rx;
 	struct ptp_clock_event event;
@@ -582,7 +649,7 @@ static long nxp_c45_do_aux_work(struct ptp_clock_info *ptp)
 	u32 ts_raw;
 
 	while (!skb_queue_empty_lockless(&priv->tx_queue) && poll_txts) {
-		txts_valid = nxp_c45_get_hwtxts(priv, &hwts);
+		txts_valid = data->get_egressts(priv, &hwts);
 		if (unlikely(!txts_valid)) {
 			/* Still more skbs in the queue */
 			reschedule = true;
@@ -1111,13 +1178,16 @@ static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
-	/* There is no need for ACK.
-	 * The irq signal will be asserted until the EGR TS FIFO will be
-	 * emptied.
-	 */
 	irq = nxp_c45_read_reg_field(phydev, &data->regmap->irq_egr_ts_status);
 	if (irq) {
-		while (nxp_c45_get_hwtxts(priv, &hwts))
+		/* If ack_ptp_irq is false, the IRQ bit is self-clear and will
+		 * be cleared when the EGR TS FIFO is empty. Otherwise, the
+		 * IRQ bit should be cleared before reading the timestamp,
+		 */
+		if (data->ack_ptp_irq)
+			phy_write_mmd(phydev, MDIO_MMD_VEND1,
+				      VEND1_PTP_IRQ_ACK, EGR_TS_IRQ);
+		while (data->get_egressts(priv, &hwts))
 			nxp_c45_process_txts(priv, &hwts);
 
 		ret = IRQ_HANDLED;
@@ -1588,7 +1658,9 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.n_stats = ARRAY_SIZE(tja1103_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_100BT1,
 	.ext_ts_both_edges = false,
+	.ack_ptp_irq = false,
 	.counters_enable = tja1103_counters_enable,
+	.get_egressts = nxp_c45_get_hwtxts,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
 };
@@ -1684,7 +1756,9 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.n_stats = ARRAY_SIZE(tja1120_hw_stats),
 	.ptp_clk_period = PTP_CLK_PERIOD_1000BT1,
 	.ext_ts_both_edges = true,
+	.ack_ptp_irq = true,
 	.counters_enable = tja1120_counters_enable,
+	.get_egressts = tja1120_get_hwtxts,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
 };
-- 
2.34.1

