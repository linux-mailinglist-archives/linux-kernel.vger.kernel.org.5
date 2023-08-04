Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462C2770374
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjHDOsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjHDOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:47:55 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966A49E4;
        Fri,  4 Aug 2023 07:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVHG3QIznhTPWuHD0jx3LoX/WzjUcFN1LhTZw1aYJq9Fd98gnILREstGlElpTJadRCcuGQh99koL+BGASmMNdAyiTEuepbWDguC2jWsTWyWoHYmggRUmowcXxIyWqb3QJyogHZ9OVsfIWm1RRzlQZbifKVn9ZH/Bt5QNbBt0VvqfMkWuk75j3oHkqhrc1J8EHWgLeGAKgjoJ3h3YThbxPXYxfg2KUtMDZKls18SdwYxFzfJ8/Y1yi/wiwDe+xGGOJtHFOk2v2QiD/sT3n5DWVDx6/ail1wZXvScA3utoaBOb8Bv9N7nZQ0Es7Ank2A0y9vZTfO5Qq8eplsyOjhuDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGbPuq2q0T7eiTKElDGoBiJMPxwOUf6i2U4/UUKSjpA=;
 b=NviIYjtFn++KvG/YReN0s9uxxL95Sr/imD/rqGz5p5n3AyvrZEe+k0+4EU8voQc/9kHXFqraHIc7QfGuCBWul46lEo68u4okKInP5MuxqnrCs+xIEddkQyD166hT0VAZmU7C4eI4us2sniQjNb2mpUzWNywpDHdaHpz0aEmgnrAq3v1dSuBAyViCvJh/VQ+21/jCd3O6UJdUHLUCBpYXYHBPYpiUH3RDM89Z+cy8xUMoPosL5CVqiqzNrmBWP210TN82nVHRSQmQ8WKty37+8rz8ebfiqx5Bwv/VdNe/9ekBMdcBZnWls8w7XhChkxPlJ8ts4oQTdIXpZ6TjrEiZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGbPuq2q0T7eiTKElDGoBiJMPxwOUf6i2U4/UUKSjpA=;
 b=aVO4VGyuqmuXdYeV5U/Q6M/sZjO3ms8bruC+n0zySPif37ouuNf+5eEyCplDYW0RKcNmVGzLt31IFnZ2V74PKDHoUurCfNpsewPtPcVf0rACfbF2F/YH7vfp1I4gz8XGv3yoMuuuSYXqu1DTScLfMWeJaWeZGjNxZUH6I6+AC1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 14:47:47 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:47:47 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
        Frank Li <frank.li@nxp.com>
Subject: [PATCH v4 net-next 2/2] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
Date:   Fri,  4 Aug 2023 09:46:29 -0500
Message-Id: <20230804144629.358455-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804144629.358455-1-shenwei.wang@nxp.com>
References: <20230804144629.358455-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB8PR04MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a99481-9a17-4d09-d5e2-08db94f9c4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZaO+tLVveb5cCHO4dYxBSYyhNlf1DGiU5iNI69pDgvzlc2UQs0OdvqzBL0EogfJfCKwnXJ6D4dxBDq1FGx8ENNGKrUJyZ14CH6O2iH04zo2+zL9YySd5hwjYvxvF17BkVGyeLKCrfkedFXJbMWoNhAlNSaJxRYOmK4T92gawk9XFHRwOa1GNwkJGG0BxSfSlAncLaO4pGGab8lnELOD5Fnw1gMLp9ygze5sYKnK7zn6zxvHQ7Dh1Pz/ATkHlwulOddwoDhnPPxwL+vGQz6rXaZxHyiHop/F4vsWg6jcQgyqNKyRxvFVszwFAJkho7chMhB3bH3wN8RJt6TWZTyfEhrCUyB90OLC2HXrBXho0UBP3m+AN8kElT1zg6jbU/HQEbZ+Hzr3HrDAU1fK8MfsUwLgXMSzymGiQ09uF4M+irbEGLzvtEm57UOHjMGPu2mAx6d//qrhkZEwi29LynFkAYzqstS3vn5AsZgZLJI7AjeYriXYgcatH/2HL5BbBkvkk75+OeXfNaHFu9JRSb9NuzSBTlM9S50qcljtYXAGqkHLhbzoH4DhQuJsAhXx1SKuDe3rbMkIVAEeBMyxK0PtIgscLgRaRUpGBaDlMWd+OThf9yeyzrJRs2w1pUkIcXast7uSE/RgoXVH/gg4eBzwF3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(1800799003)(186006)(2616005)(1076003)(83380400001)(55236004)(26005)(6506007)(8676002)(316002)(66556008)(2906002)(5660300002)(66946007)(66476007)(4326008)(44832011)(7416002)(41300700001)(8936002)(6486002)(7406005)(6512007)(6666004)(54906003)(52116002)(478600001)(110136005)(921005)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yxcl1AHNqBWz8J5AzIrUUVoPTBpiMJnX/Msfkc5ihAfpo7sq5tnbCqCUGgT1?=
 =?us-ascii?Q?G73xk8f2Mb5FoHfqT17gSlDhdcMYRgxLlVnrLKwCMXhhze3CGHmfNAVnZXBx?=
 =?us-ascii?Q?6+zW15ZJGfwFNfZaOosKByDI2bJ567RgvIW3yZeXa9dWyl+ie7QT+FJBwDRw?=
 =?us-ascii?Q?uwpQkH8rOXPkegfb2UKJJzoQ+3+tx1M/R1DimG76ul3lwmTCul0dBIHbSSp7?=
 =?us-ascii?Q?RMLmjbFnghW9qEr2cHi6smXnkPdaPNtZhPi3p/m2148D8okk5UZzDKYjK/rd?=
 =?us-ascii?Q?Po6M1rXcA6QtmRqpOJA8dwxiCo44BtZ2wKi1FQnZ/fsV/DZe/fwPDKtUqIeh?=
 =?us-ascii?Q?lFQXggMMOQ5Rm55nFl0Xat4AUJtnizBGSWgWbvEssLqRnafDMt7msVyIwEwY?=
 =?us-ascii?Q?Bh9zc0x0GBPPkiOJVRG3qgJNQapaAxHGSQfiMhDyPV0DykfZHfcO9VixOVRv?=
 =?us-ascii?Q?TSUZjCaA3odBorCba4IisgZEB665CsPU1XBSXGjghvkHW1HOC2XcGZOArMoS?=
 =?us-ascii?Q?1ATgZ72mX04JGl//NzygyUsaI18SjYIoaoiLheNCVkiCQ8PzsZfYiyxhW7FZ?=
 =?us-ascii?Q?QxpHQ0+ciLmQVTOn6IdCfk2X79RNT7iKiUwz7sAak0KiQEX8MUaNGYF9Pf0k?=
 =?us-ascii?Q?zEtMOkqEnssQcYDiynLJL79x++8o1kKNab7D8Tq+UimatkOK6HQIA6S+5VZS?=
 =?us-ascii?Q?zxN2WmD4oVgBS7ZkSWZdhL827cYxuDx0FaBbQCZz7vbpGGgK3DBxux24UjWq?=
 =?us-ascii?Q?Xz03HRj4n9L4UDATtA4M5ceVIspgdcYyw64uQQQYUBdNyyflpaw7//opULAx?=
 =?us-ascii?Q?sTrJj0DMJ9yfvSgqkOLjSXmVs/7zMtBLy0Nv4BVVnNTcK85WE5N6H2jk0vp4?=
 =?us-ascii?Q?q6Lotc9Wn4yY02eosgp25OEqjaOoMFTnzBtUM4vJIVdwYBoR/GO+i2wGo11u?=
 =?us-ascii?Q?ZoE7Z/YdDKDO95yKLX8jiNknKbsa9DQ4kCFuuBnlxFQGWFZyXzHLUg+HUvGu?=
 =?us-ascii?Q?CQqRci+GU5NM/COkyfD38KSndkaQ4XfhuzNzozFnKjAHnjvK0C+KS4JjXuzq?=
 =?us-ascii?Q?kLBl2B4uBLlaGMCGIMaTfrlTHWCGuNReeVMbXnc5koTtQRSChjPUW1a0rB0c?=
 =?us-ascii?Q?0xmCUW/f1KHqleaBlAv8B4Vlfe8PPMVWEBSjPnH1BnYlFax8vUKrrjJwNhzH?=
 =?us-ascii?Q?FEzTCjhtPGdgs45lTEJWz43ziWDr0TCku8II1SK0ZwQECBRPChwVIY55gCCP?=
 =?us-ascii?Q?NTdtsokdJ0BZIU8iZO2dNCdKKRAtgOr5VxVw9BvF72z8Ay1OoMLXAzcXL2OK?=
 =?us-ascii?Q?Cmbk8IcZ8gY+PbXX+oLL2IGeOkned1wj/mjGRNjGFHzRHntDEiQRWAH/7EOv?=
 =?us-ascii?Q?t6gwDLy+hSXqA7xWQMIrjxVM/Cjbrmug9U1YK/igFSxEYZLvewpjzcsYcloU?=
 =?us-ascii?Q?KWLhLH0DNuFiPlUF1fkXdXOXBXiqTuK7ZzUunjkky4J5Bzn0u0VOsCbyiGsQ?=
 =?us-ascii?Q?Lg7BiikSik0bJdaGNOEyGXDbpC/fQJtG7MSbvgjP5df9zVgsKq8ySESxyMuq?=
 =?us-ascii?Q?GPPtxnmWLylieqN9A6+QAv1XXt1DoCZXSskZiCPK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a99481-9a17-4d09-d5e2-08db94f9c4aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:47:47.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVj2IqPafdzRZoYF+4OZTnkf6rXkJwtbJAZ39MWExaQI8IHOC7RGhX1WWpwqe8FvofxF+YsMRjBLVbsW4mhjnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using a fixed-link setup, certain devices like the SJA1105 require a
small pause in the TXC clock line to enable their internal tunable
delay line (TDL).

To satisfy this requirement, this patch temporarily disables the TX clock,
and restarts it after a required period. This provides the required
silent interval on the clock line for SJA1105 to complete the frequency
transition and enable the internal TDLs. This action occurs before the link
is built up, so it does not impact a normal device too. There is no
need to identify if the connected device is an SJA1105 alike or not during
the implementation.

So far we have only enabled this feature on the i.MX93 platform.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 3eb6b4457494..0aca089ef510 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -32,6 +32,7 @@
 #define GPR_ENET_QOS_RGMII_EN		(0x1 << 21)
 
 #define MX93_GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(3, 0)
+#define MX93_GPR_ENET_QOS_INTF_MASK		GENMASK(3, 1)
 #define MX93_GPR_ENET_QOS_INTF_SEL_MII		(0x0 << 1)
 #define MX93_GPR_ENET_QOS_INTF_SEL_RMII		(0x4 << 1)
 #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	(0x1 << 1)
@@ -40,6 +41,7 @@
 #define DMA_BUS_MODE			0x00001000
 #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
 #define RMII_RESET_SPEED		(0x3 << 14)
+#define CTRL_SPEED_MASK			GENMASK(15, 14)
 
 struct imx_dwmac_ops {
 	u32 addr_width;
@@ -47,6 +49,7 @@ struct imx_dwmac_ops {
 
 	int (*fix_soc_reset)(void *priv, void __iomem *ioaddr);
 	int (*set_intf_mode)(struct plat_stmmacenet_data *plat_dat);
+	void (*fix_mac_speed)(void *priv, unsigned int speed, unsigned int mode);
 };
 
 struct imx_priv_data {
@@ -56,6 +59,7 @@ struct imx_priv_data {
 	struct regmap *intf_regmap;
 	u32 intf_reg_off;
 	bool rmii_refclk_ext;
+	void __iomem *base_addr;
 
 	const struct imx_dwmac_ops *ops;
 	struct plat_stmmacenet_data *plat_dat;
@@ -212,6 +216,41 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
 		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
 }
 
+static void imx93_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
+{
+	struct imx_priv_data *dwmac = priv;
+	unsigned int iface;
+	int ctrl, old_ctrl;
+
+	imx_dwmac_fix_speed(priv, speed, mode);
+
+	if (!dwmac || mode != MLO_AN_FIXED)
+		return;
+
+	if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface))
+		return;
+
+	iface &= MX93_GPR_ENET_QOS_INTF_MASK;
+	if (iface != MX93_GPR_ENET_QOS_INTF_SEL_RGMII)
+		return;
+
+	old_ctrl = readl(dwmac->base_addr + MAC_CTRL_REG);
+	ctrl = old_ctrl & ~CTRL_SPEED_MASK;
+	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
+			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
+	writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
+
+	 /* Ensure the settings for CTRL are applied. */
+	readl(dwmac->base_addr + MAC_CTRL_REG);
+
+	usleep_range(10, 20);
+	iface |= MX93_GPR_ENET_QOS_CLK_GEN_EN;
+	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
+			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
+
+	writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG);
+}
+
 static int imx_dwmac_mx93_reset(void *priv, void __iomem *ioaddr)
 {
 	struct plat_stmmacenet_data *plat_dat = priv;
@@ -319,6 +358,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	plat_dat->fix_mac_speed = imx_dwmac_fix_speed;
 	plat_dat->bsp_priv = dwmac;
 	dwmac->plat_dat = plat_dat;
+	dwmac->base_addr = stmmac_res.addr;
 
 	ret = imx_dwmac_clks_config(dwmac, true);
 	if (ret)
@@ -328,6 +368,8 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dwmac_init;
 
+	if (dwmac->ops->fix_soc_reset)
+		plat_dat->fix_mac_speed = dwmac->ops->fix_mac_speed;
 	dwmac->plat_dat->fix_soc_reset = dwmac->ops->fix_soc_reset;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
@@ -364,6 +406,7 @@ static struct imx_dwmac_ops imx93_dwmac_data = {
 	.mac_rgmii_txclk_auto_adj = true,
 	.set_intf_mode = imx93_set_intf_mode,
 	.fix_soc_reset = imx_dwmac_mx93_reset,
+	.fix_mac_speed = imx93_dwmac_fix_speed,
 };
 
 static const struct of_device_id imx_dwmac_match[] = {
-- 
2.34.1

