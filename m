Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107D7769C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjGaQUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjGaQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:20:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF7172D;
        Mon, 31 Jul 2023 09:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU840gjplyiyEwtwk/QqeAczK5RBT2Rm/eK5uti1Xvq3uyn2w8rhItunc8zojc0bBEIR46nZssfACRUb+yL+5G0wbiz6FD0VFIuqRvfqdMEawRxxrWOa+sSr73cpw37OLhcxdcAnq47BL48USkhzx6zn3KIKZ2jTpfjFqTJDM5chRCvFb8DgT0rJdVRzQEIvt//JC3hTxr85TfF8cPARgWlOG33fE+OjxCNQjUWIPtYTqXzA34+8py/9ti/vQlE6Kj64PoWkWuBe86mZbR8FyuO3QeF1jNNKUZJipYUrNjJFIAH8r1xjzGyajAntKhfcEtJnjzN/uXBjQEhVv3k6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjg3dU+13w6Y0hZZWT4LuqJeG4xMZmKR55JNjCR6oA4=;
 b=WjfusY7NJ0ZuwRynFG46EbcoqVvlRH6aSCV3Jv3JvsrfelTFlLas/cM9FJfMEeMQVM0Kq5yecF+516LUtI9zjz0hriNsj3z8sgVZ/Nznj6besH4lvjFPNhSL814G1IHUqvOk8zXfVCH7ScYG5gOjf+0AR8vEP088oFgcJ1TaI3N3Fju9VaJMu4icVg+MiLdk491HLu8/N6aq9flDv0dhGQaaJMTnyN59UAIq06mlXh5UdrpbJieqlRbMYWxI3HYv8iKpUaPpW4bjXdHlW/ra86kJqfiOc/TIZiTfKVZtXqJ8r3h9MLLSZrtuiQViBfUTtAvaj6yUmXdamlOD0Ckz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjg3dU+13w6Y0hZZWT4LuqJeG4xMZmKR55JNjCR6oA4=;
 b=oq8WcYMgbPL65+JPC5P17aSpibFP8KE/22Cxb5L3hfCwpa5FSEKGAQ2pYcV4cTkFduySei5cjg5WBJk8qS+BPsPOiSpSNrnOAt6MSOiro+61eqBJ31pcXbbXUy+Lx4ez9JNhtdSN1twWpY8uW2oz/N9qJKImJXS8xPVzD0Lgeio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 16:20:21 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 16:20:21 +0000
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
Subject: [PATCH v3 net 1/2] net: stmmac: add new mode parameter for fix_mac_speed
Date:   Mon, 31 Jul 2023 11:19:28 -0500
Message-Id: <20230731161929.2341584-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731161929.2341584-1-shenwei.wang@nxp.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7543d6-ca36-4419-f026-08db91e209a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tp4/zUofraKOWiXC/I/MhdocMK3ZmbZ7z44m5dOA4NaEA5UfYbh3nY6DAss0nawHKqtETnmsWdfhL9CpjmyfHqIGlspZVZRprhVg/K22pyvpLIF9Ms9k+nsTQamVaBOvl6LpA65ko93+gen8OVPJrWj1EbhbaA4AxpunZ/gIQVbg7prVa7zsnGoiogqRvn8BBHj0gEo7LLrnZbRWcihfHZqoq8IpZfMIZO3C5Gqfg7nwsLulgUmHdDRsWoh1yxDLdtZZOA5UDUzOlS3mF2JsazEMBzrVtQCK4nBTBL9KABaYMNr3DH+aiOsj+GuKaJtflPdCDIe7+YFRUkDsmZmAtBsWLxoBwnUTyK0x+Qa+pUgv8pFbZ1BolUtXNF6g64qIzTb+6kaNCtzc283P9PaWWw/t92NphB0tL9YGmCHGGUCETWE55PyxpihXv5XemX+WsdayjNzX0v9DMUYLF1Q3Gf8IbqF1lWeoPITxyoGeM4MeekzTae/AqrdwMJt68Dr9bU0+0J5AqWgU+y0catihiBG7OIYK0nqUx5Xbs1qI7HsR7SsY8QO8AaBfBu3C5qJwvvZiBM9BNfL971G3JfWQJmHJzDJS66pOV9qyQ/rlh383wQ8NByQo64sEx/d2bbHf9gdQdI4v+IqaZld/UcuVSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(6512007)(52116002)(6486002)(186003)(83380400001)(2616005)(36756003)(86362001)(921005)(38350700002)(38100700002)(26005)(1076003)(6506007)(55236004)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66476007)(66556008)(2906002)(7406005)(316002)(7416002)(478600001)(110136005)(54906003)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H71VE8OI5O1DkM+plZ116PbcZVtcgi1gMfxmpENLBmVEgdCWw57xjHfFwRkt?=
 =?us-ascii?Q?G5LIMMrFGfFWP/hf3rkd2xAS/fTfIMLc1yDYl3HfFTtP5WI25OLU/8Cl9CW1?=
 =?us-ascii?Q?JEUSc2AbUQpmIP4XvOkrA8C3QdaxEfGOCWMzt7HiWq+81GJksJGRyhb/ZWFh?=
 =?us-ascii?Q?qyzaLzlRBvqF88eLWPXUC1SMpBKjbYTw41YWnJDOdsdC7WT0cMVYQYS9OZfP?=
 =?us-ascii?Q?jBY05ISCvDkt7o5A0rNP7fuSfK/9Pn+xED62BWqjkQgLKm0G2lcODzgDugQv?=
 =?us-ascii?Q?/xAlFhbOL0kNmzhNLH1A7aSxKKAZbmwNbPb1/sjKyKTCv+q62VMR9CzZJcg7?=
 =?us-ascii?Q?7swqZHJ0z+LEKShQZLVI5DXDSMmMupcHumMWEAKKZg9mu0MEwid3LRGL0EEl?=
 =?us-ascii?Q?VmELeQWZ/UuaXqVhrYhEkcWl9aB0GB0rL/ToLH8wuCxQ69WnHkONa3ShcBPL?=
 =?us-ascii?Q?LzRirxqS7rrrY9ekzXUerYd+aUpkziWOqe3+oRRuKeERJy2QSCx71tGrRsxP?=
 =?us-ascii?Q?so5OhAUg1PSWgSu/m/1bFfottqe/W/Q/D+j1bGtjhg61blySQtUM8shJg0jV?=
 =?us-ascii?Q?dXwBwOiiNpeFju1wNYT7EIScwecXxi7lHv6GwpDaQe2zDwco7oP+QYq2vi1U?=
 =?us-ascii?Q?vJDl2GFULPYFQMH9G7BD/2HfHeXmd9zpLyB0aTAt1LWW6KRIPI1JoAGNsuVZ?=
 =?us-ascii?Q?I2fmI75Z3WioOA6jazPK4r1p2mXnewVR6hPWQdE8rF49wHoBgllLyfjy4v+m?=
 =?us-ascii?Q?4VSMiAqY7YOeyTDnF9VLlWalJCAIxlRZJo8rh0ko+PD/KNNJ0b/m7wGPmA5Q?=
 =?us-ascii?Q?v6FHnlU7mADoBqag2YF+z4ReLg8Ito89gejkXvB400FKVLbzEkO0irwbYsqH?=
 =?us-ascii?Q?hU/26rXCcT0KVEXJGeEAna2X5Xn8o/gnhp/2f6K18Fu5ou4RkKb5CgGWmQj9?=
 =?us-ascii?Q?X4Zu0fcgrKjz57kANJJZVhq5zyDRU6zNoYF7uqnFw2ldp0mI+q+tmETo4cFi?=
 =?us-ascii?Q?+BGEMuwbvOQw3HQGUUY6UL5CzlOkTfELI1iSAMOOlrut/8wV6KDKnWG24ND9?=
 =?us-ascii?Q?Yn9Mxf2X3WAjriOZ/rfeCbGVitDJnu658F6gZmwqHPSLTYQXhespupTU4ydn?=
 =?us-ascii?Q?Q7cwCq8f4xYjvVztwoazUtDbeENRJ8oOK3Kti9DDvqqMbJvRG9Bpc5sbx6Q7?=
 =?us-ascii?Q?iQaTveKJJjkNgLVe9n9Ung+2mGI5YnXxSygO1HMxWENX/UMkFZC5r/gaa6J5?=
 =?us-ascii?Q?e+R25Rt+HFLIWG0vQq0Kym3vEWgZ/Qxeqaa6exuj/0HXAdEM97TYOC6dwmQy?=
 =?us-ascii?Q?YmxkL2O8fAHVVkvDDPG93U6SpwWJYqjpn1EK/JXV8LA/nuHMkwXVBH6Xagzo?=
 =?us-ascii?Q?yAB7xh8VANOB3Ut2Ud/AUSUOQyKffLO8luFaWi3/g5pYn7RehBb4GaVMlqMu?=
 =?us-ascii?Q?t9BGqtEMU05tAAFRwIhnd2Xb6PYVlqMKowfZaZcKXA4VELXqQcLCyjlk4FJ2?=
 =?us-ascii?Q?iIAYCwHT/I5WO4huElqtdMQPdAfqOVFmREj0qRzr7wG3TnOVDgCB/42hMyBh?=
 =?us-ascii?Q?8sdN0dSre1KHa5CgtJ0sHFnymTpt1aEiG7jQBfQ8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7543d6-ca36-4419-f026-08db91e209a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:20:21.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsBY8pWQPjZza0rDcGrFp9eKhRxq4Yep/0dGk8sFAKtuC9hBmPzC4ExsHKn0WAfb69WAXfAMAji525PuO6CL8A==
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
index b5efd9c2eac7..7e45cfa9fc2c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -178,7 +178,7 @@ static void dwc_qos_remove(struct platform_device *pdev)
 #define AUTO_CAL_STATUS 0x880c
 #define  AUTO_CAL_STATUS_ACTIVE BIT(31)
 
-static void tegra_eqos_fix_speed(void *priv, unsigned int speed)
+static void tegra_eqos_fix_speed(void *priv, uint speed, uint mode)
 {
 	struct tegra_eqos *eqos = priv;
 	unsigned long rate = 125000000;
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index a5e639ab0b9e..1f2eabfe79ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -22,13 +22,13 @@ struct intel_dwmac {
 };
 
 struct intel_dwmac_data {
-	void (*fix_mac_speed)(void *priv, unsigned int speed);
+	void (*fix_mac_speed)(void *priv, uint speed, uint mode);
 	unsigned long ptp_ref_clk_rate;
 	unsigned long tx_clk_rate;
 	bool tx_clk_en;
 };
 
-static void kmb_eth_fix_mac_speed(void *priv, unsigned int speed)
+static void kmb_eth_fix_mac_speed(void *priv, uint speed, uint mode)
 {
 	struct intel_dwmac *dwmac = priv;
 	unsigned long rate;
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index d3a39d2fb3a9..66e434cd7124 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -22,7 +22,7 @@ struct starfive_dwmac {
 	struct clk *clk_tx;
 };
 
-static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed)
+static void starfive_dwmac_fix_mac_speed(void *priv, uint speed, uint mode)
 {
 	struct starfive_dwmac *dwmac = priv;
 	unsigned long rate;
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

