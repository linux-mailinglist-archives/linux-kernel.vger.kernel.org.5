Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0403B772A26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjHGQIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjHGQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:07:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C50E76;
        Mon,  7 Aug 2023 09:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwsyQB3g+YjyhAf6hQ/RoFa/zVn+oaEzQcFm9AEA+BNnuvtvOBwTRe4NnCpzQ8hUaIQb4QuJfGQyqsG47L3jEN5hY5G/hW+Ri4FsHbBW5AxfTdmOn1Vw2FX7jaLlafn21s7PwWanaYz8c9b4NAYov8D4H/z8n9B9SfEf0XmaDeDdDFwUp5MDHap4YV02M0WW79br6Yl6xRJ1fK3MU1mW7ed7VkNOHnswB3Ff6lPSUGT5tZ3heUie8leJks+5qZC4G/fTXcTY/Pqyjrfo5t8kadpjfFhq3S0TJ3DrInTqtGHXoQwsRXFLClBQ462/WWVtbHaAulJrsgu6grslJN3EZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJHNcttfzLVG38suNVLIrHaSeK8/UYAGA4te8F6Bb6A=;
 b=Ffyr4PdBCg+9ArLi4ibZfEfVJEsgbXTljFLtmhEhSgCClvvS8wKKig+NoDq8l4+//JKc9UjD4Zvu0ak0d8k8P0XaXiX448mRyEPtP1xJLPcxAZy/jn3MDDmshviWz+JJWux/id9JND0ILHACRkJsfsICurj83pyU+LKWMiCUJfzkqFscNPrHLVdQtOyYDc2LS6yddlBwHQh28xjh//HZQ7DPLSAlt2wVN+IRXuG38GFq8CdlD5B4eFDFzk2y+RcCMdF08zo1ya+AdxElC6ceZ8qpJrWIxPmPUkr6ywmuUnrn4aID/WIWvdH8WZ8SJW6gFJBwL15Moz0pNQOdCNuQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJHNcttfzLVG38suNVLIrHaSeK8/UYAGA4te8F6Bb6A=;
 b=UgDTiFvm8wig/cPJ/MmzFvK/D9LiNW9W3C1MDTYTyBJeV0e+koMw7Q+JFfDKdBUoh5tq2HqcHytupyBw0SpXgx//MF4toSWo42o2sptLvnj7PkALq3QuPmJl00jfG2TCu9RkOku4wunDuvaqcwquqxEfrb8mkBksn6Y3OZTSBKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 16:07:50 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:07:50 +0000
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
Subject: [PATCH v5 net-next 1/2] net: stmmac: add new mode parameter for fix_mac_speed
Date:   Mon,  7 Aug 2023 11:07:15 -0500
Message-Id: <20230807160716.259072-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807160716.259072-1-shenwei.wang@nxp.com>
References: <20230807160716.259072-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: ed99738b-b9a8-48dd-eeec-08db976072dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwN22Xt0a8qtTIK8jjoHbHA2Itf2VzjSUL3PyCZ8Z1JxWvnKETr3qXC22XbctWQ0fl2X7omTdyv+fTGNeDjw72wYGMcs9RMAwPL2zfK+SoP9JdvdfdnWzRYgH+/anuOdMLlQHxHOF41pG1J/Qvj3IKqzOaKI/eQsK9a2Wn9Jl9dgmsYHPJ5jbWzlqFzGquswrx2HVTclz9ggJlxmXh9KimPGofRx1p8td4HpN98TRe2CboUJecgHUv4MRhpZRwN+el1gZmvRciW1y5wjUl0a/nl4XMeBK6YL0UE3rwY4u5vhi7uyfLu/yGj3pqOGHf+U92D7FscGcWWQScqeooxrcPZM8SRvhnljYOIzeTAb4ZqQEHpjmNqeqRjoRjM95k5gLAw+K0Q1xspCshRAtHpth2ZT5wEuCYE1qs7aDxHi8QN08eRFjPhPF8N/3qFx8YhwprJ6k6MXHf+dOHCE6pBJIepwJ1N/p6DyZ6Oaa9BjcAVr/Wmmj5cdy5cTvVCLWM83tCix3R4Ntfb9q6A6Qzl50BZZhNXnUZr8Hyvwd/tAkswnxbQdIdYvwrQdE6BPl5C+cr1WwOjUTqgH7vqHVc056XKXwna7NA/n4TBWbPn/N4zVHJDP8A6JKeS5Pr6guTFHZ56I4WqpfQe1j58EX4oaRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(186006)(1800799003)(451199021)(83380400001)(2616005)(921005)(54906003)(110136005)(2906002)(38350700002)(4326008)(30864003)(316002)(5660300002)(8936002)(7406005)(44832011)(8676002)(7416002)(66946007)(66476007)(66556008)(38100700002)(86362001)(6512007)(478600001)(6666004)(6486002)(52116002)(41300700001)(36756003)(6506007)(26005)(1076003)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+N98T2xhZNv5lPwiswFaNk8v6zzJLfO3mU5U4Neebhr6zjdUgtuhtE6wRL2?=
 =?us-ascii?Q?g1OaKz4zrJBxV0v5mYQrTW4tS/wFGXcCdWrbmsRfj4nzKKVHp4Tt5piVj89Z?=
 =?us-ascii?Q?gOBbC/01Gfd/cm4UO+SUQDnx1+csXWhNn/XIgD25TdOjDL9uZroZujB4W4+x?=
 =?us-ascii?Q?BUgffVnNm6ij9uhD5sB/AsP89h0NCekOJv1gyrnqWX9W6Dg2XRodvDpA0XwD?=
 =?us-ascii?Q?la95Htr1SBl1uZNXNN/G5T0p40tPlS/7InG0D78iUfdGjbMQjySs2bLchgG+?=
 =?us-ascii?Q?g1QGjNyHoH2Ft27sg/RhzS3dCfpxV2lML7POetY+bIIP4qSoEwHtuCAOHWgY?=
 =?us-ascii?Q?+iv2uUY6jcG4hkeSskls+UatvcktLoTn9+yALQ4zqDACf2UXCikZxIacadIH?=
 =?us-ascii?Q?P9ETkyACXqDrwqO8st4c1+c4IgVdN14kSyoj69NOIWm9vcBq8G+HmzmGfOmx?=
 =?us-ascii?Q?W7XzIYMLS+YYpiGnUTW9P66UGLuMzPbTYcmk6kPB8NjP+1vkFV219oyuxsRk?=
 =?us-ascii?Q?r9hByv7fuyl6Quz4+Kup35FwQWG/KRr6vb6pVqxgIVRvM7cy34/pS9WINGvl?=
 =?us-ascii?Q?rpXcXpyyBf4uAgceLlfA83nrYoOvFvohQbKXeVg11kUlcoPUq5gv4tDsfbSn?=
 =?us-ascii?Q?sr/KhUsUAdSbkbkxlNCqXNwq1zT+61389nCumUORaA2WB8Ue5CIQNVVZrRPQ?=
 =?us-ascii?Q?DvrQ/+xApVnkUd7IkZi6MRUZ41to01RjT0aTwp4qmGzgdfHfZ342X582Q4CA?=
 =?us-ascii?Q?FX6S01yvroz04rx8bQYDLvBZapaqIjzCMyrPUn6r+a2nF9oT2s4BlWQD9chh?=
 =?us-ascii?Q?WE+IzvTB48KQt0iH6YhosayA11bFb92pItLe8JEfepj/h3jGyymRw7zWDljv?=
 =?us-ascii?Q?nBSXkSP708q1+jEXfZiXK3XO4dvf59X6j4Xd/1bgC8gDl/B5RMxSFNrfUdyP?=
 =?us-ascii?Q?AmyEMcXXamd7TGP93pRQzobbWD75NRzV3Lr1cpCJrAWUc9VHdosuwUDrH90g?=
 =?us-ascii?Q?cvE7yW/jFr4kj4c/zFPy+SBa35mxns0GgZtEyKgBDXpLPskc1x9ucIv9iCdA?=
 =?us-ascii?Q?D8FQuZFCdGAJH/aUUqdFRvldwqj9FX2vougCSChWDt0KV5OZfhgMCs6aBNsJ?=
 =?us-ascii?Q?4lsXNX4vufLGeY+OX+HySim0L/wutCZZuP3zz8S0hR/FEmR0ZAbDUaoGteY3?=
 =?us-ascii?Q?EZGwary6e3ITnivDFwq8QwEHuBcWBfd2KeRn7v/P5oAsemZ9JXf7YVpORreC?=
 =?us-ascii?Q?H5R41p1puqRc9MekJjmtPBY/xL6ElADi2XT7WwKu+bdZEWeiqd4rfFW+5bDw?=
 =?us-ascii?Q?aVXUmoSTQ6U9S6u4vEVku826U1OpNd1k5yWEfVkQE2yuNdsPesRZTpWCwnQ3?=
 =?us-ascii?Q?LZLNmY8nrdd+nbPJj1ov2JfPjLDyPngezDXNfn2PC7qoHI3EbmDCHelhVxF3?=
 =?us-ascii?Q?ll5tZAgGSNQF1xyWh9GBEcQ+zlhRuM2bE2bpwuvqzMTsAGongkwBe5KuZ2yT?=
 =?us-ascii?Q?Yo3/7eLfE9lsY3PS2BTOuL0prqUsgXwGPLDx8WMgkQw7o0Kx9BSYPaXjSWxy?=
 =?us-ascii?Q?YA7cZ2DqFPSw2pdcv0TwULXilS2dkz0fKr9GwYE3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed99738b-b9a8-48dd-eeec-08db976072dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:07:50.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOpGBWG0krikuoFIcfwodYB3Y1uysURpVJdn4KTl6r5F5Y970QBQZNKrxo6MQUaDR1YKQ74SoGQlElFp4BzSGg==
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c         | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 2 +-
 include/linux/stmmac.h                                  | 2 +-
 14 files changed, 18 insertions(+), 18 deletions(-)

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
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index dcbb17c4f07a..a7ea982bb81f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -104,11 +104,11 @@ struct sti_dwmac {
 	struct regmap *regmap;
 	bool gmac_en;
 	u32 speed;
-	void (*fix_retime_src)(void *priv, unsigned int speed);
+	void (*fix_retime_src)(void *priv, unsigned int speed, unsigned int mode);
 };
 
 struct sti_dwmac_of_data {
-	void (*fix_retime_src)(void *priv, unsigned int speed);
+	void (*fix_retime_src)(void *priv, unsigned int speed, unsigned int mode);
 };
 
 static u32 phy_intf_sels[] = {
@@ -136,7 +136,7 @@ static u32 stih4xx_tx_retime_val[] = {
 				 | STIH4XX_ETH_SEL_INTERNAL_NOTEXT_PHYCLK,
 };
 
-static void stih4xx_fix_retime_src(void *priv, u32 spd)
+static void stih4xx_fix_retime_src(void *priv, u32 spd, unsigned int mode)
 {
 	struct sti_dwmac *dwmac = priv;
 	u32 src = dwmac->tx_retime_src;
@@ -188,7 +188,7 @@ static int sti_dwmac_set_mode(struct sti_dwmac *dwmac)
 	val = (iface == PHY_INTERFACE_MODE_REVMII) ? 0 : ENMII;
 	regmap_update_bits(regmap, reg, ENMII_MASK, val);
 
-	dwmac->fix_retime_src(dwmac, dwmac->speed);
+	dwmac->fix_retime_src(dwmac, dwmac->speed, 0);
 
 	return 0;
 }
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

