Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6B770371
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjHDOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjHDOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:47:44 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07248AC;
        Fri,  4 Aug 2023 07:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBplbzBhJ/o116CkDZooSb4nLJcVef5qmySPN9rjV+hi2ggScu2dmMnq4z1f5TlmoaxmUzcTX7OmJa5nImC0Qp6C6w2Q8leTr9HDhN1VLyQHyeDvHnH0DXlPHR7rKRVVhFO7wem+lOM62p9H+fK+4GR0WLWleEUrxIDeebPMalJDo9XxugYOvS0SiIH/2aRI1qU/mo6g9/qqxpbicxNzQL5w0uJdBzRB7GCJHseu8cfPUL5nlx8PzhfjiLJxAhb5sYCtmfArYBMCar7K0oOLMtwjs6ApFwW3cUkh6zzI9y51f/5XL5v/RCXMHxZX89TMTrbSF7Z16FWR9NzvqEwMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbHLflmYTnsmhn7a9pTP4lSQZfJUBGb206GrBvpfbS4=;
 b=Y62IEYa0ay91aGNyodZd6QZbVqrZqtury3377R7svC8DkLpMLWUxu7Ys87vJfy5bz44K9xKIJdm6r4NgajSNDUe+1DayifxLvADIIfvnat/abgLGDOfj6WnKibO2InpB7SOUJgJ7JExy+99m4kZKlVNOwPvpU4R70vxUN8OKGFx3dtCPOkN32sAk0igWlPsr0STSl10vQP2zQoF+J40W6GPYKxmeOeGyv0y1DXhge1kY6OODy6at0Q/0ZbNMD+bHi+CZCVqSozjnKA0ohHz7ZpWsioIn+6hBsG7cSEfIc14OfcNNYHSrNcLwV3e3oCDabMwciDKwSsM2G+rO/9kTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbHLflmYTnsmhn7a9pTP4lSQZfJUBGb206GrBvpfbS4=;
 b=aAdThvQQLk0/VOhvYbfGcTb/3Y2epEa/dAZdnKMU9vz7CQ9MdWHNBWzldYP2fMNjcPgEpeLtzoDUxSOwHv+3+Q+ZlAswXqG478l8ncbVS0aJPKe64Fyyt0/69ZDuPPrr+vTbq1Tgf8qiTjQP0+RI0V0Es8PvKCe9NYO/FI6foC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 14:47:40 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:47:40 +0000
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
        linux-amlogic@lists.infradead.org, imx@lists.linux.dev
Subject: [PATCH v4 net-next 1/2] net: stmmac: add new mode parameter for fix_mac_speed
Date:   Fri,  4 Aug 2023 09:46:28 -0500
Message-Id: <20230804144629.358455-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804144629.358455-1-shenwei.wang@nxp.com>
References: <20230804144629.358455-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB8PR04MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: a99375e0-85b5-4eda-71bd-08db94f9c088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nn3LE4lDsiuPaWedk9ijQLZmG0CoYg0Lj+bP3Vzp0n3Q/DPKxwnbUKUmLeU3jFaHw81veQFG3K1YP53q4vuHS/+cEYgI2fHd6syAZjDHk7l7U+lHsVCU9l0BaVKZkzyCZ8iOzEETOLvM47BCK7U2j9qgjsar9iy4fZZmTQ7aWikWZhe/GQ0otIMHlpYXUdalTM00xarM++S7P5lQdkprHhAKVsGzOIm7EbASf7p206s80PlrslJSDOhY2q7GIYIIcywEki6P0FZ/KO8LbokpxF6+C/ok+ktUNJwjLV1C0+K58UoYQoVJ6CWwrGBu2sbFyDzJPxseL9LnxswJsneqUh+flg1zjRlyEKbG8haBKMKc6OXvJzmGdYERAIflmQXeW878QWLTCYWrqKBDVznGx9XrznDiYUdA9N8QauawDJrgCxXPsmtpGvdXEcFhLR1GUbw6Kbw1ZzKJOXPQcAzKiYScTICysl7Xu3jOJzTeJHRVpmwB3buhMNJUutJM+ZbFFPlHi9DFHEyMWnt73FBvZnwtCorBK84FwxI46/bgHI6lsQzutgypE1csaS0KsAxvg4glm4XfOTgXdGBKzxZxdgZhVafwuuT+cNZEuXRI6dl/YdhuVMSHEWpuEmRISqp7y3c2Zc042bL+57dnJnk0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(1800799003)(186006)(2616005)(1076003)(83380400001)(55236004)(26005)(6506007)(8676002)(316002)(66556008)(2906002)(5660300002)(66946007)(66476007)(4326008)(44832011)(7416002)(41300700001)(8936002)(6486002)(7406005)(6512007)(6666004)(54906003)(52116002)(478600001)(110136005)(921005)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?00Gd+tLkoGx0fuRFqL9U7A0UWVuBrIbuEG2b9vQ+i5cbg3PM4jL8Ks1tB7G5?=
 =?us-ascii?Q?qKowdJWEz1gpE7C0/PaL4+hwhDri72S1iDNEKLUBKIZNVx1sTDzgw3lGC5PC?=
 =?us-ascii?Q?F5IlCdd1t2CUpvdw8qbVjNZ0t0EcrKstdYW+2I16a2XTOa3HoRA1eBEwvJ28?=
 =?us-ascii?Q?d7AecuPL457t/XoJ5+MApAwmGCRTQr/50NdNyOcICywhL6sarkbsECPBM76d?=
 =?us-ascii?Q?adHeEQcrC3ZdYIj6Zh58DGqBsUhmFCuzd3lx8EeIY8BAObRWGSMZuY1u4ehR?=
 =?us-ascii?Q?D4HOKDv8VioUkQfiUM8pYxt97jCGNXVtsw5AbWDinUY2Y88ItuVaogg9CU87?=
 =?us-ascii?Q?6wOm1J2aiZukorKxDZgz6K9zgbKWCeRAH0QYVRbHTk+tdIQHkO3CPYHqy1Wv?=
 =?us-ascii?Q?2wYMG1z+voB6e03fU96kcm3sovOoG0fmYnF2oVHjowtxe8qskhpxrP1872eh?=
 =?us-ascii?Q?4yp8dXeslpEIjv2yF/ra9MlEPvr64Z9grLIius0rhhDeSlvdMiPkHNxTkD9S?=
 =?us-ascii?Q?P00TdocM1DptV9Zu2vVQGcCG4Qohas7Tf5GGvWUseky8y7VTyfLHiz01HCkl?=
 =?us-ascii?Q?yYI16Iw1w0OFEvxLBjwyjJiQpyNJXaKL0By8dpnYac7IJBFKNMyutYTguDTS?=
 =?us-ascii?Q?CrKKrUybyxGiiJwjBrnkGbojyoVrPaNkQjN+WEGzoG+0xO5LvhOGVKlwqXrq?=
 =?us-ascii?Q?QYIJIwyvfKuZ0gLbd14bLZKwWVvhR2JcdO6MoXQUB59WOEDS9903AWl+nCmz?=
 =?us-ascii?Q?F75U9GRT1yKAC45QYBXSgINAhJ70KCvNYf2ql/NiR7DrFliocvt4a8odPbTs?=
 =?us-ascii?Q?urtW0ty+kcwOCk/eMtW/5JxwCEKZMXM8LPVKogAeRBmHSzpj5FkROBIARMXA?=
 =?us-ascii?Q?oAEo0BjxrNXmbNGVM5DdDqYRT9PXQYT5seUhwycG7b7dgX3oqIhXA3fefN0U?=
 =?us-ascii?Q?kLniWP16WYheK2auLfSJGdla7oy0X2KQAxT4gl+WlYBh3hlm0gWyrqkp7UdL?=
 =?us-ascii?Q?b7SGlGSIjtmd9RCzDA3sFgpwEBgIl15K4zoVAB5qKjv573hlepmgEBb5KZx+?=
 =?us-ascii?Q?8eKBPZq9/QlfPkggBvWb4Q7NG4NSZ/nu5xvf4kl/KKydpfgi18Vp4J39Z5b2?=
 =?us-ascii?Q?9gz3pNvL3C8Kkn4NUopRH7sqVA1cwtPdMSopAE799bBloVqLZu9pkB0FW41k?=
 =?us-ascii?Q?4bRZueAFNbEY67SXDT2y+re9vdsl3HKWS6waEnRIjiXi/gX+VSKiw+LUk6s5?=
 =?us-ascii?Q?nEFf9INube+hwcWaaKS50fmK205ErXxA78Y1ZRcG50K+cOw1YBQaB4tzWpu2?=
 =?us-ascii?Q?DCjZkhZUmI8gDl9cPAu6b6nsxl1v+PrTakLOrRWwn/9wHV2MG8V+o6lYcYOt?=
 =?us-ascii?Q?p12hz9qpVymJjRjAMbUdYpZoYZDZTEwZH/0yp+5Rvd3hM+zsBuEioZVZhZvT?=
 =?us-ascii?Q?1dq3GiLNhw7V61W1UKE/qQsKCcuN+OPtpOCsZs/ep1AZJIGD+my/JX7KSon/?=
 =?us-ascii?Q?KCDl/F6vu3DEGRQMR8qRWlO6IsKJ/2PwdaKbDTQiskaUMnzN8uTOLun6SCLE?=
 =?us-ascii?Q?cZNciPc9M1tfbKbqkklOsIBNXXH7Ted8aLO+VSSo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99375e0-85b5-4eda-71bd-08db94f9c088
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:47:40.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrE3ljJ9els8bA/SH0JZ+0yaAdaFfgIGDu+29Z+ROOKxp/l3N/g0vAF0Uo/wv9uELD9U+hkYVZCpZnN+pDJ/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mode parameter has been added to the callback function of fix_mac_speed
to indicate the physical layer type.

The mode can be one the following:
	MLO_AN_PHY	- Conventional PHY
	MLO_AN_FIXED	- Fixed-link mode
	MLO_AN_INBAND	- In-band protocol

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c         | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c  | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 2 +-
 include/linux/stmmac.h                                  | 2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index b5efd9c2eac7..55162d798319 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -178,7 +178,7 @@ static void dwc_qos_remove(struct platform_device *pdev)
 #define AUTO_CAL_STATUS 0x880c
 #define  AUTO_CAL_STATUS_ACTIVE BIT(31)
 
-static void tegra_eqos_fix_speed(void *priv, unsigned int speed)
+static void tegra_eqos_fix_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct tegra_eqos *eqos = priv;
 	unsigned long rate = 125000000;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index b9378a63f0e8..3eb6b4457494 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -178,7 +178,7 @@ static void imx_dwmac_exit(struct platform_device *pdev, void *priv)
 	/* nothing to do now */
 }
 
-static void imx_dwmac_fix_speed(void *priv, unsigned int speed)
+static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct plat_stmmacenet_data *plat_dat;
 	struct imx_priv_data *dwmac = priv;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index a5e639ab0b9e..d352a14f9d48 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -22,13 +22,13 @@ struct intel_dwmac {
 };
 
 struct intel_dwmac_data {
-	void (*fix_mac_speed)(void *priv, unsigned int speed);
+	void (*fix_mac_speed)(void *priv, unsigned int speed, unsigned int mode);
 	unsigned long ptp_ref_clk_rate;
 	unsigned long tx_clk_rate;
 	bool tx_clk_en;
 };
 
-static void kmb_eth_fix_mac_speed(void *priv, unsigned int speed)
+static void kmb_eth_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct intel_dwmac *dwmac = priv;
 	unsigned long rate;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index e39406df8516..9b0200749109 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -257,7 +257,7 @@ static int ipq806x_gmac_of_parse(struct ipq806x_gmac *gmac)
 	return PTR_ERR_OR_ZERO(gmac->qsgmii_csr);
 }
 
-static void ipq806x_gmac_fix_mac_speed(void *priv, unsigned int speed)
+static void ipq806x_gmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct ipq806x_gmac *gmac = priv;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index 7aa5e6bc04eb..959f88c6da16 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -22,7 +22,7 @@ struct meson_dwmac {
 	void __iomem	*reg;
 };
 
-static void meson6_dwmac_fix_mac_speed(void *priv, unsigned int speed)
+static void meson6_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct meson_dwmac *dwmac = priv;
 	unsigned int val;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 735525ba8b93..405ab645f1cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -631,7 +631,7 @@ static int ethqos_configure(struct qcom_ethqos *ethqos)
 	return ethqos->configure_func(ethqos);
 }
 
-static void ethqos_fix_mac_speed(void *priv, unsigned int speed)
+static void ethqos_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct qcom_ethqos *ethqos = priv;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index d81591b470a2..91553475c38b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1785,7 +1785,7 @@ static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 	gmac_clk_enable(gmac, false);
 }
 
-static void rk_fix_speed(void *priv, unsigned int speed)
+static void rk_fix_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct rk_priv_data *bsp_priv = priv;
 	struct device *dev = &bsp_priv->pdev->dev;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 6267bcb60206..7db176e8691f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -61,7 +61,7 @@ struct socfpga_dwmac {
 	struct mdio_device *pcs_mdiodev;
 };
 
-static void socfpga_dwmac_fix_mac_speed(void *priv, unsigned int speed)
+static void socfpga_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)priv;
 	void __iomem *splitter_base = dwmac->splitter_base;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index d3a39d2fb3a9..9c700590bf25 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -22,7 +22,7 @@ struct starfive_dwmac {
 	struct clk *clk_tx;
 };
 
-static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed)
+static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct starfive_dwmac *dwmac = priv;
 	unsigned long rate;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 50963e91c347..beceeae579bf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -72,7 +72,7 @@ static void sun7i_gmac_exit(struct platform_device *pdev, void *priv)
 		regulator_disable(gmac->regulator);
 }
 
-static void sun7i_fix_speed(void *priv, unsigned int speed)
+static void sun7i_fix_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct sunxi_priv_data *gmac = priv;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index acbb284be174..ae2a0ff664c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -53,7 +53,7 @@ struct visconti_eth {
 	spinlock_t lock; /* lock to protect register update */
 };
 
-static void visconti_eth_fix_mac_speed(void *priv, unsigned int speed)
+static void visconti_eth_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
 {
 	struct visconti_eth *dwmac = priv;
 	struct net_device *netdev = dev_get_drvdata(dwmac->dev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e1f1c034d325..1c26d60886be 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1060,7 +1060,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 	priv->speed = speed;
 
 	if (priv->plat->fix_mac_speed)
-		priv->plat->fix_mac_speed(priv->plat->bsp_priv, speed);
+		priv->plat->fix_mac_speed(priv->plat->bsp_priv, speed, mode);
 
 	if (!duplex)
 		ctrl &= ~priv->hw->link.duplex;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ef67dba775d0..4876735ebe41 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -253,7 +253,7 @@ struct plat_stmmacenet_data {
 	u8 tx_sched_algorithm;
 	struct stmmac_rxq_cfg rx_queues_cfg[MTL_MAX_RX_QUEUES];
 	struct stmmac_txq_cfg tx_queues_cfg[MTL_MAX_TX_QUEUES];
-	void (*fix_mac_speed)(void *priv, unsigned int speed);
+	void (*fix_mac_speed)(void *priv, unsigned int speed, unsigned int mode);
 	int (*fix_soc_reset)(void *priv, void __iomem *ioaddr);
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
-- 
2.34.1

