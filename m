Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F2E772A28
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjHGQIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjHGQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:08:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6A2E76;
        Mon,  7 Aug 2023 09:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfWIMHdGKVPVWgR6sTJinqpwlWoHEnCgETSkmINLfzE3ATXfjhckf8FK2q6RAdih3Ek3CzTCSOsMCQZFbNTdM6P5DXnk8SENwKzFY7CnLDlTN2GW2bmVCla6BhoHXPL7fbtd1oCbLVKpKkEP0qPKif8xeY3wvvupFYlkXeUdGe/6V7PIXd7mvt/7GLlAFEV4IPHnQQXbYIPtJCtZ4Ba94yvCKf2iikmiZDGy7gAlxEBIXu0AGIX8OqWELNx7Lhmraem1qwZNGxPVyXoEjFfTfuCp54J9iJ0oBybX8qy4eI/P6JZC0qrKtgn62jFcc7zQb9KSMsF3JSW1axN08Z9kgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJnhaw4KNyuyfDYecq4DLlXtg+TIxjX+jy33NxMGBb8=;
 b=hBkg6nD7rRMao3eE/YfAuS/egMfXaHEEw2ko7sgCADy7oPFalfd9087WrCzv7GXI/bQDvqBm+aGHe3Azcrj+pbICkxGfirHap/49FUd5Zpb0uPSBOgEbb+zGAsafo+Fq97aGZmBQTo05QUPn1BEvQMIbpxPkds7uAdkOKWrjFHxGPymq8yc0rfyftJY+aieFkCHGdRHGq5IGORWe82usLnFTZEYaOlrVgFjfNrfaSi94DRjYsad8IyWpY+/+Bqq+JRuXJen1XDy9IwdmPbp0WaL7kkgptHoGlnXnu17rDlkuOcprbBwbWwYq1b0SE2BjPvsTs+LcQW+rPfHG3AAd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJnhaw4KNyuyfDYecq4DLlXtg+TIxjX+jy33NxMGBb8=;
 b=Rtl5noMuJMaB2aO4pxlmj9DIZQmffJ894q7ZinRyDnnkyeph5X/3/VZlJYTp6CCmP3Mb/5Hlj82r0EhEk41VZvcQxi99ynMYpU9qCFJuLNwp5sfAVc2KifjqsBTBMeHV6DIJaNT2i+95UAqzPOBWx7i1hzx/Fmj2GOcPhb2Wq0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 16:07:57 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:07:57 +0000
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
Subject: [PATCH v5 net-next 2/2] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
Date:   Mon,  7 Aug 2023 11:07:16 -0500
Message-Id: <20230807160716.259072-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807160716.259072-1-shenwei.wang@nxp.com>
References: <20230807160716.259072-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eca23d8-fcbf-44e3-ee8b-08db976076fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwEIt4Sh3KYtQGJSA45rJgiK8JnRKtwZh7l1AYeWniNxM8Zirrgojtb6eyeXkgUvtQn0Pxj8hUXbN+f2RNwTm3HkS1ShQygodlYlGnrekTGL0ynU+cmxDZaiy2H5jnbbmBVtipwwsmySfsv200oXa82qEnBsKXKk9PJSQKnktrXYs45zqkQFaMiVRj6w5bO+QBDm8dtHeVKrY1dtqsDk/VTm9DmJQOax7ZpBHiq5+Ds6WHNXfi3jOboBgZYwF45suMeWHO+W2+zzBrLfr1KO/vivOFb7f0VS9H5GuKOvJOLgnqsgW7Mq2i2Mh6yKiPkZKf0eEomd/VhWVGsvJsRXvapjXoV2Dg5QEQJFQSUvCEd8RdktjtP0eaitOmQ4WPaDzcu1MAUKsbrScSxgb1QQOGLj/nwcliSfWweqYnvIIPDBt8eTrQxBDIT2Ea1C3NVAp4eNsnX7ozAk5yveV1VQEre5E/+dnSHgp/QDniSwHkfNQRWfdAX8fH9DVb5dMgNO4r3skIG3vUEzYn583pkE48j4vZI/f76xy5UVp7D59m4RIzUEJzcAleLDZfF9pZRvbW7wBLzLOXDUC54ZVhVqalXgH0QaBh4QOE8qiSwoDqEu5EcK9NmP0E8S8IV9Sva1y1NHg+iYhkaD2NGn6uw3sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(186006)(1800799003)(451199021)(83380400001)(2616005)(921005)(54906003)(110136005)(2906002)(38350700002)(4326008)(316002)(5660300002)(8936002)(7406005)(44832011)(8676002)(7416002)(66946007)(66476007)(66556008)(38100700002)(86362001)(6512007)(478600001)(6666004)(6486002)(52116002)(41300700001)(36756003)(6506007)(26005)(1076003)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jo5axwpVWmwem3lUm5ksMpgsrayOwdMs7z46d1r2C2pBynmJntO5XnBxedII?=
 =?us-ascii?Q?qoncl0chMjNIzMOaciWK/vA5xGUR79T3Wu/sN6URxDLQB/9So/M86bK5ErA/?=
 =?us-ascii?Q?7CsMpJiDd9D+WYQ3dIT0f3MbiWTCk/Seuf5EaI8ARsyquBaX+mFrZzzDnVwY?=
 =?us-ascii?Q?gxG5c8QLpMvFM/WtEqtGheem5T8w+TaSMDDql9p719vS9yk85iBwfWhritrk?=
 =?us-ascii?Q?sVsm2NiCkXHINonsXNUoPvdPkK/2jYS5L2d3aCHeoaQ4Xe7tOgeJMqheo42x?=
 =?us-ascii?Q?P/is2vHIJDFOXx8jVRgM2j0eXYunVvS8yvv+W08lnqvOtJSGmhIcNgmztJvc?=
 =?us-ascii?Q?uajbQz52IIW4KgAVHhIK7H3pPqUufzyPppN1hg6Tn5CfzkEkbjJk0jhdBQ6N?=
 =?us-ascii?Q?3QjNuNbENzWl01zjHmmDp1qNrseHA7/vC3fhPS1b7547fub4RgB+vgzV2HrZ?=
 =?us-ascii?Q?DC5v3CblS3+3PJz14WV7MQTKtTJu9/nCKw9X6bh5njdta2IkrCB3h7ri9jlV?=
 =?us-ascii?Q?S8LpXhgA7/IzdNq7YUG2Y3VSAs42ZOIE/yxjXwdkylrFp8iQ3Gy0YAYRpDJG?=
 =?us-ascii?Q?PeZrnAn8xU6olfpOjgiQqK+YKcCoisU0zMvD47z69Yac/LR9FZ8CR9AzZeAn?=
 =?us-ascii?Q?mGvFjr55TYbEKZTrepD7TjXM8muu4lN0SNpUJ8Coi4nOpJOlO5ilU4k4lwng?=
 =?us-ascii?Q?x7iDdu9q6zdB4gH+ejS+U4x2eQKLhUZnHEAsueSxFmoRokg4/VDNF97H39iG?=
 =?us-ascii?Q?rE/EfXmkl+EpCzVfrUz6hZ+hTafzJibRI7BkSQVUnMknjghvAY9YDXXdSEI6?=
 =?us-ascii?Q?F9lfYE87bymth37JeTczHoXwmllUdu/6B6F7iBN4vMn/uARCMSZrIHVOSFSf?=
 =?us-ascii?Q?5Gy8gjvpQhb0gGqj5FiQ/b3ZJ/GRc8AqTIwimo+85hTQ0N3U8T3tKSNIZGp9?=
 =?us-ascii?Q?JoWtuTr1mbP/uSUCPQPXA+bnBG0QrF/8w/7iDjFlL7aUZpeoXEWcWm9KTOI1?=
 =?us-ascii?Q?YRcpsp4k+vz+DH9MFOuyGilCnLjudu+CXQ25uelUotgXy3Fy9heWMRNf7SVZ?=
 =?us-ascii?Q?ndJ0DdfSZETn7sf6BYAr8ca+P4pn5qikJckqTqdymto1v+jIjbukkKPCJdZf?=
 =?us-ascii?Q?Y3Jrw/7PBebEkinc0H3eI9DwUXHMP8me6oBNgko3oziRgStXuf7+b5eIuO74?=
 =?us-ascii?Q?U244kWB5jwoqEwvoMSM7mLyrCLsIZwz5GCpc2GGBp1YdEW4nYGYJBMiPYF1G?=
 =?us-ascii?Q?uBDHiF5/7Dr5Z3vtuO7uPjY+MOGxTfTL6j+tEJxW4EHPMdWuNjY5CZjmgK/A?=
 =?us-ascii?Q?4NwI6rq1a3jgM2EreBcEJdraLqxy+qooWKUaFeFtTt8NXaGubPxxyzmfAQpS?=
 =?us-ascii?Q?yQrmMYjrRx941uKx63PRXVD93EzRzBJqYrfGyKtv+cn4Er0Q60pcUuJRW0fM?=
 =?us-ascii?Q?+gGuFuLPYb6hvItIFPmsrECTbRkBFdj0VjCuToBwCwkxK2F1roSVrRC3qDyE?=
 =?us-ascii?Q?07FvYSyTIkaRFHd7Q1RizurUnr9qPN4Lx5lc5KJHkz4puawJ1E+bvGDz/4Hk?=
 =?us-ascii?Q?kz4QzhGPD22kMkd+vvkNjjT8zZ4Oc/UCvY+wuVEg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eca23d8-fcbf-44e3-ee8b-08db976076fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:07:57.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiRWqnlGtCwqsmIxXnxxjJzaLxpo70v+ZsAazU0DQqrMCJDBJungrqM+ognr4tsjTYMfRcfh9o6QMkPBIeLQTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
index 3eb6b4457494..43ff19b009d4 100644
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
 
+	if (dwmac->ops->fix_mac_speed)
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

