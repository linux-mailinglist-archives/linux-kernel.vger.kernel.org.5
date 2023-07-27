Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CDE765779
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjG0PZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjG0PZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:25:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1E1FF2;
        Thu, 27 Jul 2023 08:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU6mrGjnWhAIbfKemAP6vF1HuHRZSo1BpqgtMkscIcz4nRZqVffEWPjylkl9FtVXuFZDVUnyU7wyFWmT05n2DmC99YVszij5WGlywaK9/nn2+iFD2E4d5y8GMfocOUtkWbdURFQdT6KXYnh1FAuGVyfh0AkDYPnC3Hy7YbHvO35vL9QZJwZLT2R8KfdN4gVUHj1e+kaFJh3CZyfJbgbKfOL8VOPn29lHrGOsoZ0TObPUqJUy6lDwThOSmCteyEHou+zNts4uexLSkO8R2lwwDeya46kgPWncYfubx53QabSwNk4K62ykg6TaJDxKm6CE+cIzLtgrX3riGKH7eILIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP8K4U0XbheJwOOt6iLmL15KMT5JTdY6p6SMOhAbBT0=;
 b=MA+AX8h0zND73/j7bcfAnGhHzDSggZFqN5THK88SwxK9kCC3xMxZ99BSTkYLDyOK+/V+mWuslpTQxb3P0MqgFAAsxnaK/l+0MrchwItvbI3ZWq8q1CLybZYDwkZsApLebASmyrDGlPWBVYJ9UfF82MQpk7fAJ3mRkVK2Tsnhg5x9u5NhvH+U2rdG0ekbis5wyHGPJ0m6Ubu5a+/a0onkrY5PPz4e48F4Is2puaaQgk0pqEPDqZi9pl7Do984/SYxVwBuDmW4u3AIpM5aZLWlj6St7fm6kJQvkG0JTcrwTBzeOO3jBJVnTjPEbFQka4jZd8Uy5UCawfoVM0qwnD+2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP8K4U0XbheJwOOt6iLmL15KMT5JTdY6p6SMOhAbBT0=;
 b=Ft0uXvd1D2h3Q5r2dI2kfnrWE9EGoxY7LMCyA6HcSv75Hx1ovcN8clmhnizvvBqVo8YCmuRgGNzZyUhYxg38NYBPU2wLelUfOp3iaOpP7NbLpxWXVo3eVF1m1ve+fKFBcvoyBeC6GZG1HmtWTgxl8/T3d7Na9G8zQJjRhGlUFA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8257.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 15:25:32 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 15:25:32 +0000
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
        linux-amlogic@lists.infradead.org, imx@lists.linux.dev
Subject: [PATCH v2 net 1/2] net: stmmac: add new mode parameter for fix_mac_speed
Date:   Thu, 27 Jul 2023 10:25:02 -0500
Message-Id: <20230727152503.2199550-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727152503.2199550-1-shenwei.wang@nxp.com>
References: <20230727152503.2199550-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM9PR04MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed44756-42ad-4472-114c-08db8eb5b74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8N+qRk4ONEGgwOC3wRqttqa+cpBCIwYvKxWh52WTOoj8NWSTeO3joqlq7E8QpijgkDplSGly8qv+WYuOgioGGfpCb5N4TEktWuQvPQgOmjckV95hKdb3rCt/zIPttpnuzRyzGAHPrQPg79gAFmdE4h4ELfE7LmtTfiagD6zjKyzSXyWZKD4ejPThcMF1J6R0B1gijOaKonyy+nLwGmH95JBxoFQE3+DtcV3n+csqAFFVqPHmmhoalkIp7FlxpPkxCpzpHambenw3ZwIy7zZ8qRaNYQO45OEBdC/d22D084XUGxvM2hRJwxvIsAPtXHkMuqPiH/YOc76fQQTOxUTeaMdklGzyAQawlbbL/qQ2BodxLyY9qrbfoq9OutQnupzQ+8sXkfblTuTWHDqQQmKxdpYptisrzduZkW16Zf6r6PkZ7LPbYZGHfBxjh4nQb5yESMUJ6esQR71yQvACypkH26oUHmmVQu9UD+KhA+rbzmpoHHYLIhi6MHI/LV4eYo9fMGnlUSRL6/NCbX+DylfbqAiqGAvB5PPqvA/im9T1OnJt7UffAm2TSC2gmBYoNkJrNIT25ZR4SHMH/ht2NeTVLSP12+CW8yNHfxGBxhtpAbNRI9l613cmZ8wj7nML023xTcmaJ6UmZUwraZkPjSZoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(316002)(2906002)(8676002)(8936002)(7416002)(7406005)(5660300002)(41300700001)(44832011)(36756003)(86362001)(6506007)(26005)(6512007)(1076003)(55236004)(6666004)(921005)(478600001)(52116002)(6486002)(83380400001)(186003)(2616005)(4326008)(66476007)(38350700002)(66556008)(38100700002)(54906003)(110136005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+waNRqJApWxCkmk92lFN0+Vutj72GHr2AuzS3FPGzTfpVHOMP2MEGgMDGmP?=
 =?us-ascii?Q?U7RxZR0IbTD1b9IW2yxIji02xg0vP3WmzMEWyJw6LUNmW5WbpruXaTwNcDWH?=
 =?us-ascii?Q?dt8hTDMCuGmL7wyfsSVpEVYZyIGjej2Hm7dYs7pEsgwZ3ApKCMQKL5nPynSR?=
 =?us-ascii?Q?Y01say1068bVOWZbgpk4fE41wtOBLBqKCig2G9d3EJNg6CazERBxxO2Ar66P?=
 =?us-ascii?Q?FSMNEp684hQuUQDppiuW5GHz+qBnQQZLzxBY06nL18Qx4zyj2ypQDKT8De2b?=
 =?us-ascii?Q?PNXdPR4UTx0JiG9ghPgYgvurEolrnaPPG23Ok0E8EBgudLSOvCCPqF5pKYYZ?=
 =?us-ascii?Q?O2O0sdxE8+MmFgNg3iFz5WGK+3nV3XfupdoUku70FZllz52L+RMgmHj6LORM?=
 =?us-ascii?Q?3UgoETtiLB09744nUWSyBCGJTs4zkLJP3D8m/iaOObzHusj62IGta4f9MgD5?=
 =?us-ascii?Q?b6HMcm2SNzLnQRAatUM7+owy12I8jss3SEIUlSNEN7cnvGJO7Z2t8de8WxQW?=
 =?us-ascii?Q?WBLuXJPEJZ+j2x18/sWOn2zfYveqAU8TbrjHBuJKrBLIFwU8om9PCHEuUpgk?=
 =?us-ascii?Q?ZQzZNqsbURJE0yuDpoAe3hBrgj9lSA2HoUa/pMStib9LcsT8oVlkccSvm6AP?=
 =?us-ascii?Q?KblPRCNsdBwaRP0/baIZ9I95lPuGfr/mPMzhrGXYltS6xcm+FppNgEkHI1NN?=
 =?us-ascii?Q?EfIuem+ceftTwY5du0ydphIyqFmbTwnsNCI6GZPZplGSuIM80T8P9qbkCrZn?=
 =?us-ascii?Q?Szr8BDCAq6nXu9ZUWmthv3njZ2oG1oaL7rDxosrnmGet7Qb2QmccqUlxWgiS?=
 =?us-ascii?Q?qvjPYpxgIIa4W1tg8ShrlCoyegWUhPBxp5JVMN9hRgCxGt3vd+xRzy0mInbM?=
 =?us-ascii?Q?eQVa3bQu9XEPTB81tYyVznzBzoVg3SdAkM8p32xBgbBP02nmrOyjhiwOzMZk?=
 =?us-ascii?Q?6c3OWki3iPJ8CV5DZKCVuM4fl11of11Ebty5PgJeei/vFwxQXCkjC7yKqS7Z?=
 =?us-ascii?Q?hw3xepqBFrWmtiazy9pBWDLad0RoGwdr4LF+97SB5bgyAHCncxS2sqbsGrTa?=
 =?us-ascii?Q?8Wsn/p70g4Hk2T5oZLWt1MgkRS7HLtRsOxYSL01PT/v3Y2jBDMZ819pq6NqC?=
 =?us-ascii?Q?HNs5neIWjHhJCOEyT7brYeb24PwIS9ajmJIqrwW0iOW2CMLQf++dUMRS9q03?=
 =?us-ascii?Q?NPOBDv0RdTWAqKCk+4LS8IevMYFwYtHKOxnrRMhemSURi6zp+YdmIKd76u1h?=
 =?us-ascii?Q?WcFO9+QGD6nUeu8oE0/bwo9BW7hNfW/5dDAdINpMZIJy1iKErco8xxoAwh3H?=
 =?us-ascii?Q?IF5uK0P4zy+5F/jH95K3R3AbMhFOJbToPma+v9OKohXyyHL/OiL1XM3VU58j?=
 =?us-ascii?Q?dtghf/WIpYnvaUpKOvB4HEeCx/Rdp/aNb7JtrTu2pOoAE3z+fYTPdoReRPBo?=
 =?us-ascii?Q?0IlB1uSylZNYLpsMQmf3mHvmV+v5mXKpmUkAnFE5WUiqyP7JDz8FZRaGynBv?=
 =?us-ascii?Q?oTDT7oGuLjfjHRb1OZhHMu7Ymsj2MkvWNNWSqJcX/oW/qmNQii4LUZ7L5div?=
 =?us-ascii?Q?wsBeBTyaiFM/YLvVTXvUZHzwh/yxNXi0PuZ11aYC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed44756-42ad-4472-114c-08db8eb5b74d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 15:25:32.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK8dvVbn180E1T82XiUJ88oo8Vd6EwcjNjkGnPI5oL8Z7iyY2tOTv47w75dhqAfZoAoE8N/VeO6SlFnMzFRuLA==
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

A mode parameter has been added to the callback function of fix_mac_speed
to indicate the physical layer type.

The mode can be one the following:
	MLO_AN_PHY	- Conventional PHY
	MLO_AN_FIXED	- Fixed-link mode
	MLO_AN_INBAND	- In-band protocol

Also use short version of 'uint' to replace the 'unsigned int' in the
function definitions.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c         | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 2 +-
 include/linux/stmmac.h                                  | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index b9378a63f0e8..53ee5a42c071 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -178,7 +178,7 @@ static void imx_dwmac_exit(struct platform_device *pdev, void *priv)
 	/* nothing to do now */
 }
 
-static void imx_dwmac_fix_speed(void *priv, unsigned int speed)
+static void imx_dwmac_fix_speed(void *priv, uint speed, uint mode)
 {
 	struct plat_stmmacenet_data *plat_dat;
 	struct imx_priv_data *dwmac = priv;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index e39406df8516..8070352844e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -257,7 +257,7 @@ static int ipq806x_gmac_of_parse(struct ipq806x_gmac *gmac)
 	return PTR_ERR_OR_ZERO(gmac->qsgmii_csr);
 }
 
-static void ipq806x_gmac_fix_mac_speed(void *priv, unsigned int speed)
+static void ipq806x_gmac_fix_mac_speed(void *priv, uint speed, uint mode)
 {
 	struct ipq806x_gmac *gmac = priv;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index 7aa5e6bc04eb..612551c09ad9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -22,7 +22,7 @@ struct meson_dwmac {
 	void __iomem	*reg;
 };
 
-static void meson6_dwmac_fix_mac_speed(void *priv, unsigned int speed)
+static void meson6_dwmac_fix_mac_speed(void *priv, uint speed, uint mode)
 {
 	struct meson_dwmac *dwmac = priv;
 	unsigned int val;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 735525ba8b93..c32549d2fc5a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -631,7 +631,7 @@ static int ethqos_configure(struct qcom_ethqos *ethqos)
 	return ethqos->configure_func(ethqos);
 }
 
-static void ethqos_fix_mac_speed(void *priv, unsigned int speed)
+static void ethqos_fix_mac_speed(void *priv, uint speed, uint mode)
 {
 	struct qcom_ethqos *ethqos = priv;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index d81591b470a2..2fb24c7e1b44 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1785,7 +1785,7 @@ static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 	gmac_clk_enable(gmac, false);
 }
 
-static void rk_fix_speed(void *priv, unsigned int speed)
+static void rk_fix_speed(void *priv, uint speed, uint mode)
 {
 	struct rk_priv_data *bsp_priv = priv;
 	struct device *dev = &bsp_priv->pdev->dev;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 6267bcb60206..ef3be5a3e7b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -61,7 +61,7 @@ struct socfpga_dwmac {
 	struct mdio_device *pcs_mdiodev;
 };
 
-static void socfpga_dwmac_fix_mac_speed(void *priv, unsigned int speed)
+static void socfpga_dwmac_fix_mac_speed(void *priv, uint speed, uint mode)
 {
 	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)priv;
 	void __iomem *splitter_base = dwmac->splitter_base;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 50963e91c347..4bbc9d6888f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -72,7 +72,7 @@ static void sun7i_gmac_exit(struct platform_device *pdev, void *priv)
 		regulator_disable(gmac->regulator);
 }
 
-static void sun7i_fix_speed(void *priv, unsigned int speed)
+static void sun7i_fix_speed(void *priv, uint speed, uint mode)
 {
 	struct sunxi_priv_data *gmac = priv;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index acbb284be174..5c50cebe9a17 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -53,7 +53,7 @@ struct visconti_eth {
 	spinlock_t lock; /* lock to protect register update */
 };
 
-static void visconti_eth_fix_mac_speed(void *priv, unsigned int speed)
+static void visconti_eth_fix_mac_speed(void *priv, uint speed, uint mode)
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
index ef67dba775d0..7d5e178574be 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -253,7 +253,7 @@ struct plat_stmmacenet_data {
 	u8 tx_sched_algorithm;
 	struct stmmac_rxq_cfg rx_queues_cfg[MTL_MAX_RX_QUEUES];
 	struct stmmac_txq_cfg tx_queues_cfg[MTL_MAX_TX_QUEUES];
-	void (*fix_mac_speed)(void *priv, unsigned int speed);
+	void (*fix_mac_speed)(void *priv, uint speed, uint mode);
 	int (*fix_soc_reset)(void *priv, void __iomem *ioaddr);
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
-- 
2.34.1

