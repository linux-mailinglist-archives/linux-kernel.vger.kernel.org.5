Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E394376577A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjG0P0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjG0PZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:25:46 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979A530DE;
        Thu, 27 Jul 2023 08:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACnDVclZpu3PdlECoxLgg0d/OUaNUMULAMnObIwE9GJ5B3DvdIXxDm8d/WbEWplRI09hLQQW2r+BERzJW0OVNF9u4PH4Ecs19acK38tXywfh9eZ3wqZKwiykESVHs7STbaTsTOGnVNqdn6EAGYCeELfWDZ4tv+yUO05UyfZrgN/Lvv9pPvrx55HVklUz/Aks9CQEzL+8vsWY13SVYvzcWs5a7JkG28kPXa5fWSKznYZaRiZIBWATQp4ykRRB+RJdVXtXrEKuotkDF5xFJm9zFnnJnD3/p7+70d5FjtfuVxk9YAY1umZnXzw8IORPu/AjBfYzDqcrRaGn9M70sQOdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnGeXiHXIDBm7s0zSh+ex4FGI2w1k84IOe+fdQrfUQc=;
 b=cbnGmkzgve2FUitgBvD8AdS3aak4+91PnRIE3x4dIzE9rkATVpCLZVkkdD3GefVS9fCspF2huNoFpVV47wbjZQYrvn12kq60IGfXCviAOIlD/+p16FnVc+NrTGVa0j6GW5eKNOaxToKaeagbZdfOZpqH8P/TPnR4c8YaJZPOmYmSlOO01Vdhp0LfPwNKcQv5BGhrymN/njddRqh30OLEZfzUrbkd1HDn2AFGSdpnvShp1aUmF6BtgvAm2cDm+vHu683ECv2wRTEIze3hqOqluqrTutb4anDHpAuZj4nl7wsKfY5BSV6erE1XD1j5s9ARrDgr6lOYG2SXoVNnGXOi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnGeXiHXIDBm7s0zSh+ex4FGI2w1k84IOe+fdQrfUQc=;
 b=d9vYQWTtuSUvJ3Cc+ToihoGfgttG1ppFD+9pKfp7IW4zlxzR3pZvTpS6sLqezLxk+MmMJ6ywv7lzzBvs/0RLyAuN8WsE/xZCgUD4z6BnNvNMKV/JInkgRdlyg1VEqoDDCF5I78TzYBgpdEph5V6TqML0QH7ApFvcjw8L/NQHe/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8257.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 15:25:39 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 15:25:39 +0000
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
Subject: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
Date:   Thu, 27 Jul 2023 10:25:03 -0500
Message-Id: <20230727152503.2199550-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727152503.2199550-1-shenwei.wang@nxp.com>
References: <20230727152503.2199550-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM9PR04MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 2406c8b9-6464-4d13-73b7-08db8eb5bb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HzAltImfwT2KWSEyKjTvWw93tLTtwwvGXKhw0yyubT6Fh4A3EP/pofhnHUqpifCqw2SE/+Z1osEhJmBLKZVrl4GTJrabRWkUzv9asLUilS3n9bJNoT5n9+3G54GPkYTFl2OUiGhzN3198xTGipXHD2kT++CrEganp+t3hyoaeMEjs5H842P7qHS5lRXa89LveH+wYLANUoQ1Ivtv8TtMW68yapKeW82n8Qo8nRf79XK2aU9xX6QwAUFdxRA1qE+ghvCg4iroXl7qoKVg8o7ycacGosi+s0mR+mNmL6V0SHjdRy54xV2ble2ezq+5VSERhqtsT74e8LbHJe/81b9iBOKZx8y7zFvPvyRpIvju7dk3pXUXJgyWm6za+/XKTJkkMAr57NDEBYuQ6Sq0ZGl4pcNSqKfQcPK6/nJ5JLia/FB0jkds3G7HmmJSahUP1yvd+HgxIq8uiuvjO4kkRpaotMH2D3kXHi0gFk+zEYOdzhF8GxsAZju9yxMp1U9ksUMIn46rLxMB4u/LhVMXYop2bEOuPV721iTkjP/+hghttSwGhW1nxaTMY6FlzYVXIEuTUtYqzA/gEwjYjOx9bwTA1U7Ag91uTm1lxIce7xmz42Nfw95QczzwdDwAxrgcP8X2Uzyrw5lP8cC6kiZwSGTtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(316002)(2906002)(8676002)(8936002)(7416002)(7406005)(5660300002)(41300700001)(44832011)(36756003)(86362001)(6506007)(26005)(6512007)(1076003)(55236004)(6666004)(921005)(478600001)(52116002)(6486002)(83380400001)(186003)(2616005)(4326008)(66476007)(38350700002)(66556008)(38100700002)(54906003)(110136005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qiWK1I4S9TV3jFnT3UlhNIfhqxYTgRO2uJ32epQdKzr7vdvJi8Tzik2CmV4Y?=
 =?us-ascii?Q?l/24b600tFS0AF5RNGYkMM/pyq+gp81CTSKYwlWfr6t+aO+asRMxw/mow+am?=
 =?us-ascii?Q?JVt5fpmWBtZPCiK+pTYTsNR8eRa1zE/Uig2Kl4iqh7iamZrxIq3t917T5nXl?=
 =?us-ascii?Q?o/tCUhGGVZnAX6RKbl0xFy22bl60tw9J1Z1jakt0AaEoji97aBREHIjfQkIA?=
 =?us-ascii?Q?qCRW7okx1nKajS6unHddfvsbp8Ur6zdhGXG06zrhaJfSJ6OmjSHKQ5Ucu+0O?=
 =?us-ascii?Q?xoszgjxz7JAnLaINg+kUIDU/oZxjF6X6j++a9Jl8llLfCK0kwsT14u6W3EvH?=
 =?us-ascii?Q?LGMJn5JS9qxG5kZvVmMHQcHHVPguVtwz5RCDwxyUpB+3cfy6pGyjgrsaSHmT?=
 =?us-ascii?Q?AUirMm0brqifcrhghaKo6MmZ0s26tP0ZrOIubHHr3bf/j+w/od+IPK619kvT?=
 =?us-ascii?Q?GCDUHLRoefa4VAhjRmG+WcbCYYrWR9QL8sm0waAUZJa0IGpCtYTTNTcmFOsw?=
 =?us-ascii?Q?/bj7AreVVG1jW9/Lwt9CPKTmlVzCdBdYS14yo1av/7/7XocHVAGRFyZp2NhJ?=
 =?us-ascii?Q?teUdWQwgEo+z/iJvj3+UTs0+I+MY/BFEqf5Yd9l7AJ2FhEVUe3dEA2DxLulE?=
 =?us-ascii?Q?mumdDFbrYNvF29SgWQzZ2/W9PQMu0DDvF/3c5V0KkLkQuSnHeEwR+ZD8+oo7?=
 =?us-ascii?Q?/RzQGCsywabElxLjE0NKufKDWmKgiGCAfvWqqwVOsx87m12uqFLUgOZaDItL?=
 =?us-ascii?Q?l9TNMJkjE84lzIZyWVZKBMYi6+j9veX+bMZKjaqudU2I/n7MUfVOW6BFnWE4?=
 =?us-ascii?Q?gSQpPtOI+n3cY0OUuXr78ee9XHnqHeWhmq/cD0zfJ8mzcB9RLzyooKi/ow1c?=
 =?us-ascii?Q?z75ADkslTVZPmH/C2ig1ME7WPuZTKnUYBxMGoXsjuigQIxYn82qxLNFZo8XY?=
 =?us-ascii?Q?p7KdIET06HlQ5WLsJ9QHmOiQ7TLrJKrDK0I6H+1aA1oWlnPqeNHG+v82p2Tj?=
 =?us-ascii?Q?Ni4DrA4ioHaDF3mKK0Z2TF5jMGZLSFjoIqOKx32/S8+j/FfsKEj/uYxj+7Pw?=
 =?us-ascii?Q?aQsK/lupW4b/CY3sIQSzskzvb1+cDgVehS3UBVtJcW3XGIR5R6nuUD2RJS+x?=
 =?us-ascii?Q?7WprR1yFAxyBNBXrRkFoPB3YxDMJLY7ecnJYzQvR6xAQoquTJMNcMBO+fAtL?=
 =?us-ascii?Q?CymIz6DejAgvr9wjmESuHybjKrpB/bgt+tW7efetA3PkHHI4MQHFN9D+DIGZ?=
 =?us-ascii?Q?MPPXzeDNZJjxrPGpGjeAfFxo4qVyTUgdMipp68nhergjmKbbzI53wfh9QL/a?=
 =?us-ascii?Q?hNRJBgYoYRXu9Bk3W2E8mqPAAiAg0ED0F3Ra2FOQS0TxUwauADp1OlnABjxe?=
 =?us-ascii?Q?MtbkmQSCW4SCLlra369WeJkQkJ0I3/pyPryIcdMT6O0A0cPUgUvM3D8IUIjc?=
 =?us-ascii?Q?Qqb0uU2GzpZXZUwfMZkvosGQUI3soUOC6A6igJvxCor43EcWNzrRlZZEi+hx?=
 =?us-ascii?Q?GVLCrV5FnRreDb85d3OmouGO/CUSI41fVLLp113anLbYG5uiuauB2keQkrIj?=
 =?us-ascii?Q?6GxQeN4F3IrVGBqgS7LW+oketmrhEJSoyM7Qyy1D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2406c8b9-6464-4d13-73b7-08db8eb5bb6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 15:25:38.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZqQqDflAO/+LocWExD9G9Fnw5JoKJCmrjMOtwBNuNVYSovyGQDgMJcLuhHNkafG8j7VQhNzYaE3ArNfiN4Z+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 53ee5a42c071..e7819960128e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -40,6 +40,9 @@
 #define DMA_BUS_MODE			0x00001000
 #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
 #define RMII_RESET_SPEED		(0x3 << 14)
+#define MII_RESET_SPEED			(0x2 << 14)
+#define RGMII_RESET_SPEED		(0x0 << 14)
+#define CTRL_SPEED_MASK			(0x3 << 14)
 
 struct imx_dwmac_ops {
 	u32 addr_width;
@@ -56,6 +59,7 @@ struct imx_priv_data {
 	struct regmap *intf_regmap;
 	u32 intf_reg_off;
 	bool rmii_refclk_ext;
+	void __iomem *base_addr;
 
 	const struct imx_dwmac_ops *ops;
 	struct plat_stmmacenet_data *plat_dat;
@@ -212,6 +216,44 @@ static void imx_dwmac_fix_speed(void *priv, uint speed, uint mode)
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
+	iface &= MX93_GPR_ENET_QOS_INTF_MODE_MASK;
+	old_ctrl = readl(dwmac->base_addr + MAC_CTRL_REG);
+	ctrl = old_ctrl & ~CTRL_SPEED_MASK;
+
+	/* by default ctrl will be RGMII */
+	if (iface == MX93_GPR_ENET_QOS_INTF_SEL_RMII)
+		ctrl |= RMII_RESET_SPEED;
+	if (iface == MX93_GPR_ENET_QOS_INTF_SEL_MII)
+		ctrl |= MII_RESET_SPEED;
+
+	writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
+
+	/* Ensure the settings for CTRL are applied */
+	wmb();
+
+	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
+			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
+	usleep_range(50, 100);
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
@@ -317,8 +359,11 @@ static int imx_dwmac_probe(struct platform_device *pdev)
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

