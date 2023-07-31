Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D478876915E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjGaJRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGaJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:16:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187A137;
        Mon, 31 Jul 2023 02:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzDID2kn1EM62pVgMlwgQZeybZTkZUs9m1jpggpv3HUodvsilx0nhvqJMyaDDfiWbCdXaAzXG1G8G7QJQWp1vxKRr5aUtu4PnzG60mN731QVM3evrt2dYt45/UVgV872e+fhnpxVU5bQEPPaK3CwDA8iA6muB25qSXw/INrwsJnNjEHD6znwog321dtfnMjLza//7NN1RkEiNZR4oeezusvS5oZT+R4ZgjR/Hc/vst9QQG1AcNhuQLrbJUsIO2AtBV/sg4OqqW8akc3LIb5HYQFPE5WbZPcdaIPH/fUEXTasWsHbvUj+OxPi+Z4x6IUlBkWjLYyazDMoxLyLBINuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzR7EcT5tGaWk6WMsxMCxCakyxk8ndhKpBh/sECspak=;
 b=GVoTpQKJj8XbmJ/SKWTvxLVFk6Aeq2tAD7HTB7nGHsznQPTVJJqySPT2Flf/olHZJzdYpLKv36L4F0F3yjpTO5Lqu5u7qITt1oZnIXMdlvyJXQeCfB4tmaR68LZMXJOhJgfN6e9re1MUVT6D9bucfWzzCLLeESZU8wAEMsh+IsUFcLxEtEzAIEenbBhJ+MaDT/lCI4ZboXBryWuqMJZtiL2jKLFurDGd31uk0my5vQwaAUkFrIhYRcfWntkUCJZV3YMp+6R92TC5yrh7+RpXuDwy79vLKbmLjlZYXazbsTF9zbS52Ha/axQ2iUDnXTfhZnHTXPuBQlyKMH6ExHagkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzR7EcT5tGaWk6WMsxMCxCakyxk8ndhKpBh/sECspak=;
 b=WFJO6DrTrNBBS3POJK7ixWwjbMeVvZUMe0VybpjuvZc2lzpGIl+Vu34MRyHdjDvi9Vyy3ZjMm42TZ//MMP8aC6bilfMubQ2e4Sa/L3Je7a9fkGFPhsiJ8uB6jTdXOOQhJqOYQAlekwSWshchIIHOgnF4Y73ZtsQuVNm5QpALexU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:43 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:43 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 07/11] net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
Date:   Mon, 31 Jul 2023 12:16:15 +0300
Message-Id: <20230731091619.77961-8-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af6e3f7-9f42-4cce-f4c5-08db91a6db88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4e9E/XpliMa6KYOd2wiTY8eNlkh7YKQmCbeNybV9G3BW7i1qfPsEJFpnya4r7ULOVbhpjQ+RC5VTwt0IUcCd9DU2VEbm4qNI3Yvc01QJcoWgNBnWNBY0cx9nowjwf8lO+6dTek43gQtki5yUdrdbUa/ezHOE5HdzI/bIrFLLz8eHCBVKGMnkg/6VKXNax9Aa0aHO1PmUBZOzHHa9WNn8FAuYb3pyZsrWjTeOACt4JmbSi+OHdRHc6cZkTOPbR7AFaJPa8TRNeLrvq9mnuxWmedy1X99EWCUg9rve8QfOEVFEK5Z+CB0/VUfjlhAbLUKYlYydnJkYH+Z0S9+9x5KvPEPWDlbgC2q6GZndftBoUsjk7oEJeTDjUd1vaFy/G+/DLtMTr/xMl7biNon6KSSIphoRoLvbrLfto5cd/mkCUcZvgQlXUyv3ZTtZ5katmgjgeQRmKNgprADCMxuPC1jeM3OPLnV/ThmEX08CygSEF3tMOKghY1xYOnYS6Y0m+gr4A+1O2zl8I0tUG6H/bNEH6wja4+J4UbjPg2/ZoFAWn+V1KHyz/uWjhTm8kqF/pctl0LrFS4VLUuZb63nYcUkNE1JAoUCpOLSWjidqmMHsv8jPam3j/A4KnSAqjSkn1Oh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(5660300002)(4326008)(7416002)(66946007)(66556008)(38350700002)(478600001)(2906002)(38100700002)(6666004)(6512007)(52116002)(6486002)(6506007)(1076003)(26005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdqiTdc2M9IzNAHQAT0ppG8bDVskT5xoNffavzZdMDMM3hYYtbq99LiIootF?=
 =?us-ascii?Q?aqsRSY+rZhoFlQLmFuLhrHsa/U62FaHsXdYkPDg5Ol7xD2wk82sGO7H4DM/z?=
 =?us-ascii?Q?plnZIIMaqymbRh3wsKBvD9cCUbDHJNn7EeZ+f4+RzKVL0ECq4jvYQAAn4E1j?=
 =?us-ascii?Q?0s8f8a0cW6RvEWC+ZLkuGA9u4qzWQotyUT30yt4I8e/MIgaAjE1S7GAt5E6T?=
 =?us-ascii?Q?CjwbMAJm2NPshamioEW4oS8xIlETivXIprLaBHJIXBtsAy+YkNFD8IxL8yCf?=
 =?us-ascii?Q?nwoaeX3qoKF3JhyMPcMenrHXAIB5/AXbBvSrNgK9oVPoDSJ2e/7biFaFAyze?=
 =?us-ascii?Q?zT1IpKc+wXeokAHBCnn0xcOVC/4vQO5RNObxaZtxmN3HhIMn5gsuZDH9it90?=
 =?us-ascii?Q?NJU3LVoz+JSuV4dDVWyTwsA7GLMWyW74OdTNZim/7G2xQf/tgqsaGEaN4tWc?=
 =?us-ascii?Q?M9xyFeqk3tWKef67e9wWiYpKtv9OT7eQpsFRo+nDCoVqKbJyevo4Ulpzte56?=
 =?us-ascii?Q?COGIPpBt5ch78P2FvizO3cymzVqckqcBCW+3NvL0LLsJma9P/lv4ZYEche65?=
 =?us-ascii?Q?QFh342x9U9lPFIxkPjf+BuI/LPY6TKTyHoTTpDTSQnQbJK3VWwh+vWjw8hTm?=
 =?us-ascii?Q?9fdqo3NobiwJaz+cWU2bMPqzKjrdwWeiqJ2X6IbTNejMAr4qdra+aMWAjXNV?=
 =?us-ascii?Q?J6X1ikHj6mV70jw2ZW5pfFsNDTXpKi/P7MbKScZOVva8wwZK1RrmGAbLxhg6?=
 =?us-ascii?Q?hAXDcdn2treuOfT31bVuoWBrSDXmCCHtgDxRwYJv5tdoGy0441+8pjhQ3brr?=
 =?us-ascii?Q?23vTRGcbuq3ztmz6w/8Uy0IHxkyfLfuDMlmwiegEDZBoxIbDaxP0rcYlaxB3?=
 =?us-ascii?Q?MlCC0U8OYSlWMsr/SB44juxn3IuWrcUB2yaoVkCJ89iS++mHq1yfUojuRtuQ?=
 =?us-ascii?Q?6C0fQ9CuF19waENb6p6USFi/r+GjYVYzV7S/IXpqkh2948UI251sdJfF/pcR?=
 =?us-ascii?Q?D8S9Iqhmr5nHOTHkTPI7nXkuYExAymfNPbSwuJq+l4q10EZPYAxV8MK4KLzZ?=
 =?us-ascii?Q?hDp6nhSO7roHRIpVVSEnBFLCSnd1d88xR3H156o23kIfrXQDxDRMi4D4R3AZ?=
 =?us-ascii?Q?gSyyfn8nL4CrB/3Wu4nOvkLEyJz1ROGLjeyZqd25imLGOy5HxMYwgUUA4NdE?=
 =?us-ascii?Q?dVk5uIsM4QZthhY9+AU0c3Tn94ZnNHmXNP24cA0z0l80InwUbFNisDVD+hF7?=
 =?us-ascii?Q?FBrQOebXQSD6382Ii1mtHiQ/NS9TU5wjM/LUTI3kE7nezv6fZWC0RB1SnoAp?=
 =?us-ascii?Q?6iQWa+GiuaWB0DCd65rvyQRWznb4DnNaMDvay1aGwu9GpgprnN313IXC0yz4?=
 =?us-ascii?Q?GQYhBLAHLhgxQqZndt9u9znjCCwHBkFe+Dy9euTjlJQKAxGXLp8f3ebDltvd?=
 =?us-ascii?Q?Tjs3KFwO6A2u95oUuQITYSYyXhfJnFBjQbexkofYnPzftCk9x3wO8j+LDa6y?=
 =?us-ascii?Q?vh8i6WswJFKR0HC0JjFtm8zQCdmuvJkGy0puH85hycXoNHpZkMGKZ1+lUtkl?=
 =?us-ascii?Q?367tAk/dhYCwBPEgmul53OnnnExrEQH/3FrcPejVzOT40NYaeOboPp9sPax5?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af6e3f7-9f42-4cce-f4c5-08db91a6db88
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:43.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmX+8bq4Hrz3GauWynBxh35w5WGgJCwKGJcdpiYkc9xC+JBydeAxBpd+MxuBREHrYNMDIXHWdpm8IkTev7ymducmTMguBJSriVmXDaSprxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
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
index 8393c17a83cc..e596ffcf8683 100644
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

