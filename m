Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE9769C30
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjGaQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjGaQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:20:39 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37F171B;
        Mon, 31 Jul 2023 09:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DexxKx864HhEono/iQBD4YPVEnRiaF9Pde0RTjQiF5nWNvJGMyu5hOQoWoQt7PlvVXbp7iqnkqyPXFKdE5a6UDZY+Lgla1/AmQ4OQEFMHk8zaFfDXLudWtUkenTN+jpBP+AdxLLL90eMMF8eGXXNt/0UiX000n/rkzfWsJR/JKpvWI99JyUIeZKseGkKI4NPwt/QEa5z2XOQ/2VU2zyvD/8AnEIr1TchhA/OZVkUAPryRpJFcZOtG/pJ5J7p8wHHm6VLgX6G79k5s8O7lxN8CTe82EQdLFtsWZ7yqofsqYrwV8vE+6B9QpEqGN3Sutmc1zS3wBggruvKnCYBMjdfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5I8OU839VhPlsTYhHxwfzmqSlYssToK+cPVuu8TuiwI=;
 b=cEHkBCu3DV528DVSVGxAOo8MemIam/njv7OHLEqonR9abjodIlvO/QzoB8BPEmEl4+OpgxJB067UfPnSFBtUh6DBhtkDKk9aiZ1KToRiWh1SwPDUNkXaTvNV6nlPyXfcMkiyRPIMmjpytUc/oFmehQMyB0CesKi0htm6Fb+61lgle56vsOWF6zDmq+gFJ+h5LRu2KnccecvjCdTJp1Rgw/LhDKwnonzFLOQ5aDvQ3LV90JpHol0+HhlEswJBArLcc5WVPjQVpd2YOatpNu7TVgJ/IcRxShvsCxIlkXXRZW8Ktl4t2XF32UiAeR3B1ycmnorzWGNYBP5A4sETsKr22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I8OU839VhPlsTYhHxwfzmqSlYssToK+cPVuu8TuiwI=;
 b=PO0XAdE6J8chwZUQVjo+c3L7lInVFviupjkY37qk73facGKt+UIHhebHRL6KpyewH0gH1rZf0WtWHjQQwH+zqtrr8aSYV5G1lNpHYjAAzPuYA9Z25FUUzDftbiiNnBfIwgxU6bI//Gwce29N1IdEl97v3NuaZepjfxKg44XuKPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 16:20:29 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 16:20:29 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Russell King <linux@armlinux.org.uk>,
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
Subject: [PATCH v3 net 2/2] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
Date:   Mon, 31 Jul 2023 11:19:29 -0500
Message-Id: <20230731161929.2341584-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731161929.2341584-1-shenwei.wang@nxp.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d109f44-fc09-4d15-22ec-08db91e20e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IQHA7YQGQvxbRc01cumXQQvxAvUThnqYrO0iQnBBjp2WgRUTGcKVS3myeFWMnCs5h7pGg+ktQockqwPfz0eXTC2OVECBxhZbh0riZ+xcVrU/88Czi6edn3XPPSOmTC/1DznEcDAaeu9EGUOVWJGqHBTi4XJRlOL+N4B7rQvd77MM+YpqbLL6bGfY846aiwMV/CfpH7OjhpjmJ5sqG8KBrIz2PKDn3pMxl9SDDvWLK1NvY0GPkAmkjh/fPPeCoN1G4ZgXg6E0aQ5eBbtT0ePLiEeW6cY4e9ngEAcgIfQZBSC+cjTK2yi6KF6wqKtF1FGJT1s3TMOudvABdwDl/LvWQm9PXysL26E7TlTBsmzls4csTsUM9FpYbfIobGez7N0aK9bFND4fZQxml8DrotV/Gxr/CpYs371mUNYdXWdFYrkE97W8cWySNbRdqHjb/9tVVPurlLCjPBHsMsLkudzevjXRBP0hbRbo7e3M/U1GlXRhhUDVWb34uECQ/zhIu4JTgzwm/8ISSfcPMEi9krctBWQaL9vGVV8l3zLquiQ3deQTN2MPETr62MrgFt9PDJ0lhFBWEOUu1iS7lOI3ZOPt00c0BhkZB5Pa6QgFxRQS0QH52DvNeeosCtDvu4oyBAR6FFWx+zmQKu/WpvYHbLDSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(6512007)(52116002)(6486002)(186003)(83380400001)(2616005)(36756003)(86362001)(921005)(38350700002)(38100700002)(26005)(1076003)(6506007)(55236004)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66476007)(66556008)(2906002)(7406005)(316002)(7416002)(478600001)(110136005)(54906003)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QR9GzBiQQKSv01YT47Ny6FUr92Pm/3nEeYMW6lxxawn3xTzD36fxm5wanyvy?=
 =?us-ascii?Q?T996mnwo1gyVm8gHy20vJbj/gbeQWEyJiWaXRwVMNfP1f2MHXEa0RmbFo/ph?=
 =?us-ascii?Q?QzNeXT+qNpL+geuOKqlAnAAzv2xwCaA2H7gj9Pu2mhsjU4L5LGcDC/o4xn21?=
 =?us-ascii?Q?7dowciIVP/YhNoJViw0weqwGqCKdINvNhXfXt+0rAJtQLvaJlUx8A1g0WSWn?=
 =?us-ascii?Q?Jf/Wj+hGgNNrZ2JHqvJojlOdJwqF1BDPq5mVQuI5az/BrORu/EbLid3iGitW?=
 =?us-ascii?Q?WmxjJjjZ/oiX2+qC2QGLityvF/hxo6dNUj8+VAtaFIGrjcpJ9GGnvahD/2zD?=
 =?us-ascii?Q?xEO2DptIc75rGDZuKPUxkmrlmbqSk2FLDbNqmALYq52R7G8YICeROhENv0Zl?=
 =?us-ascii?Q?jVX0DAi18MU93YL3K0JsUWOz3/CirE7qMltPOaKgBBF8HAYLAsx+2zq0yenk?=
 =?us-ascii?Q?vDOR8PPqhGsJkNpy+l3vudLASi+9SggfEd906XXDKoG0ix+CqlYjnrIokHrC?=
 =?us-ascii?Q?40ZTVpR1hOlFNgLiQOXruNhIHuhIoKzKEYUknq90E4mv/jix2CCgk5RiqOSl?=
 =?us-ascii?Q?kzg6E1aSoS77XP+Apxki3Yr71RiFM5IOP80yIP4cTII6ho8zZ+C6U7q+J5iR?=
 =?us-ascii?Q?S68SdmEnf9mG+Nl/KXMvYmc8686qPJmHCeA6sXnV/wPlJ3jj6eThFvOxFaxZ?=
 =?us-ascii?Q?P7mqUwMsak/YUcvrQIHEpQL6ao3HA6bnyFRAhXZhdHkQAVOgQdBVoH9oGxLM?=
 =?us-ascii?Q?YT/8FwkNhwitxAYTN8oWfTLyqdVnVW99j0VjH61Cl9RaBQfeTg/F13eoRl0E?=
 =?us-ascii?Q?yWijAwx/MveZ45po3XAfn+fPGi8BjAs3Ew2JuG8Uw94JRuJy74goJpksPNYC?=
 =?us-ascii?Q?qYdUyQgaIHifIA4Tvp/djSEE96oniGzuVo4MY3nqWsJunGMzutKCRj6UUNeY?=
 =?us-ascii?Q?Ja2x8LqCfHdX1NWxSXaU9MvfRe2gr6Vyhh5kASwoac+R8gIK3svpZrAyiZ9T?=
 =?us-ascii?Q?1fT2YHrfXzEBDlqSMBtwTe7IG/3bL+nb9uymOXd0yqd6/Md+pm+EQyXQYWss?=
 =?us-ascii?Q?k4cKcU+z8PIS1BFzce4KTht8EszrISZMcaDGFqd4J/sMz4u/wOvU15Om6c+c?=
 =?us-ascii?Q?8EvY7eO3l/DO/3BLZS3FgzhjQZEsCPIQ1D0MGt9lAa1Kq6JIh5tbuoK4WNfT?=
 =?us-ascii?Q?2L9plVFH+hS0Y2m3uJSV5fux2wqrZvd21CP5Qbdf8xO/LTFsPXO5CTW8SrmY?=
 =?us-ascii?Q?klGYTErp7GNUjhkC7UbHCif7ZmdblDvBOQBo2c9tSzFKdhAYrhHsdDx4eTsu?=
 =?us-ascii?Q?DtY3V2wdpbCA6zsKJQn+0fB/2FcCzy9Ze92t5pmcUFPzuBE4Y/06R8FjN9wd?=
 =?us-ascii?Q?ZWSo/10/hlb4kxdYV5NdT589cJr08fSl/v112QbMrUs8NbGO1hLqO3AKXJXM?=
 =?us-ascii?Q?gZJLgoebYmYNe75S9iCC3u3836ZQJWAOMyFwH/ps7Jfa1rK9RkdqAJ7WLswt?=
 =?us-ascii?Q?TW+he1ADe10z1xqFYo07iHF4EborQb5uRksTfSlBDtbvq5Ly88nCuFzIg5g8?=
 =?us-ascii?Q?lPOS1Y/qJCLhkAmpt7Ip69KmLp5G0gHXgoyMOCtl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d109f44-fc09-4d15-22ec-08db91e20e1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:20:29.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugICYOfmY6lpdWXfgvKtRRG73vXrfNOJwz5ORKnBv2Wfe5HyvVZZIhpZbNEJY2BheArkRPURgugzpVUalXzc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
transition and enable the internal TDLs.

So far we have only enabled this feature on the i.MX93 platform.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 53ee5a42c071..2e4173d099f3 100644
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
@@ -56,6 +58,7 @@ struct imx_priv_data {
 	struct regmap *intf_regmap;
 	u32 intf_reg_off;
 	bool rmii_refclk_ext;
+	void __iomem *base_addr;
 
 	const struct imx_dwmac_ops *ops;
 	struct plat_stmmacenet_data *plat_dat;
@@ -212,6 +215,42 @@ static void imx_dwmac_fix_speed(void *priv, uint speed, uint mode)
 		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
 }
 
+static void imx_dwmac_fix_speed_mx93(void *priv, uint speed, uint mode)
+{
+	struct imx_priv_data *dwmac = priv;
+	int ctrl, old_ctrl, iface;
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
+	/* Ensure the settings for CTRL are applied and avoid CPU/Compiler
+	 * reordering.
+	 */
+	wmb();
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
@@ -317,8 +356,11 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	plat_dat->exit = imx_dwmac_exit;
 	plat_dat->clks_config = imx_dwmac_clks_config;
 	plat_dat->fix_mac_speed = imx_dwmac_fix_speed;
+	if (of_machine_is_compatible("fsl,imx93"))
+		plat_dat->fix_mac_speed = imx_dwmac_fix_speed_mx93;
 	plat_dat->bsp_priv = dwmac;
 	dwmac->plat_dat = plat_dat;
+	dwmac->base_addr = stmmac_res.addr;
 
 	ret = imx_dwmac_clks_config(dwmac, true);
 	if (ret)
-- 
2.34.1

