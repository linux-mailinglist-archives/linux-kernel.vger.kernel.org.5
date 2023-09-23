Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB17AC287
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjIWNuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjIWNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:50:05 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCA5CF1;
        Sat, 23 Sep 2023 06:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni9bxzrNJrhDkfYC6+t/nReANzgz7lmGWKK37eT8/0eqf4XkBeUicH8YyXfKt+y3yn31ECp83AK0dj//++jID4yJGHF0b6ACVO1Na91uMO1SGF+paWZWUK0lSapsRnAcmdHpeWMq8BKIlLrPloWUVhVKuqyrU0PKopGsiIInqBRNVND1hG4x4oveH2ikyfT4x7Uaq4iwYaGSMfuwxAEPBfFD7JEdfetIiwyQ5oI2NQEJTTGwrxIJNCUSWLNU7HiRgj+ikuUvSQkJpWuikSBpbvncovePfYFa4QFG32aEyc7qNRdtcTZ5SQ73KW901Xx3oZcSFsZV7740nbmBfE8sIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsPLlrLnEi/DL0vDxMpT7yQn5nNjqHycisJ0DsF6O/Y=;
 b=WwxDEGf9mon4O0EjzNDmZ8Yv4RRcLe7XXPucokm93R3CfZk72wbYaJW15N9ZtSdlHUfle+swxd7AGSJ5b1adtShByCuE2kniZm5CyGQIfO1cY6yQFYos91g4VaKz6J43T/a8AeHRuDBXSRzNA+2saKLsX6vVPDvTb/zbWTQgN6hnn4/21/UVbhNuyUnaD22bP+CdJkZIktv9geELcD47fAxNrdxaY7r/kYUzCx7g2wEi7ubnBxphsAhVoxs84azhCcAfC5EMVMWvXqhTbb6gPxteQh4ejA/3exs04zuv2rWsS9aY67NR627S6lQCXC/TDDJCWjlVjcLYuYqDFmAi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsPLlrLnEi/DL0vDxMpT7yQn5nNjqHycisJ0DsF6O/Y=;
 b=nTypnb0fJPlqwvhLGymrjMZY2r5+0IbI6NMM2f0jU8mR9jRAEAyVw8tfcuOy+oR3UwEW2f2NwO6iwGeD32TksE0hHwrxXsfECoZLJ4wABMDOqO60dDyHVQBQx+VtM8FAF6ezI9ys29M+hNxo0UmbbYVTbmWln2Je5G4wXx78aEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:40 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:40 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [RFC PATCH v2 net-next 15/15] net: pcs: lynx: use MTIP AN/LT block for copper backplanes
Date:   Sat, 23 Sep 2023 16:49:04 +0300
Message-Id: <20230923134904.3627402-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS1PR04MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 460eb46b-a7ee-49a9-69e9-08dbbc3bef24
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwTKE0k6ZRHcRwGh365N5UKFWpIIIDb9WB3IPSKNU3U1lStmmLbLwWRozsFecGLbkvBhIO9YR4CwIjpgKIyQD0GN7y3pzNibYn3VngCpXFu160h/b3wVX8H7fZnP6YgwDkkZGiUymVAaEijYIBjdWzLbibblCo+wEiQS1+Kg5c2Jl8fOJ32dG1HzQoSDP1hHnbNra4SEocEolq6/uw0xWn9D75s2g0DCfMpiwU4CckedIiZ0k46HU77HZwv8NVrPY3uyMh0STcYTf/38yFo5Uv0Vtmt6Pj7LcEbropfbf6i/t+CamlkmM0hFmt32j7DYSMDyj7NR8Umkf81atOWZJTrHjzd+KyzdPXna/x29BxUFSWCiYwyU2P5dDjxgRn0Qhbt3vdVNdFLvhX61TXRZeeZVsHaQrCPfw2+asa+6engORTzFdFjQnNgttg8QWX9EnW+5yz6p/mMT9/sWAViIiFeTXCG2bgRHYypu14riqogHpihesCOL7uAQS8AcawtL4sZvkls4+1KTXhbHOxnEi59oiYLuGqpjqkgwukv8bl6k4sU/lROOzuSniL7BHCrymXO+NyB+PDm4PfZE8rrpb873X3SW6ABRfu99w9qaJ/dV1Tla5LojdhSf7CfxxhOm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0eMDlAhN2Xj3R4Hc0lEzjhXo/bR99xJ+wzYQaq+dku3eQZMCbwY/enzhTL2?=
 =?us-ascii?Q?FMBch8VdBtpuHCe8bU/tCHUZ1SIOe9qCvJFfSbZnTlWoNfIpc2sTKwpgnAAg?=
 =?us-ascii?Q?FvOWF6zKCM+JYH9lc3b8QZy/Pzr+hprxxAW5M0Y0x4h8u61HiSb9JbNwYBmG?=
 =?us-ascii?Q?KrNYh/ze8sQM6YGYvG5mTb1D6qhcb7fw4dbkC5CcyG2Ug//QTRg2KrzwwBJM?=
 =?us-ascii?Q?0SsQ3N3ViyPVkzLawDUV0Uwvb89fb2IFhibKDtce+na6shPgUGVqferbx3CQ?=
 =?us-ascii?Q?I4ZBDu8HCDBzZWyEAQBjaEzKythlX/3iQdft2D1JeNkZYVsYIDgpoG7OpL3C?=
 =?us-ascii?Q?LzR2pR2o/EGsVZVYy2reiV74XqvcOWy9DrvVad/HR2cG0y3qRjmh/e3UvFTl?=
 =?us-ascii?Q?LN9KA+Z6p1oYKvlv7HYnz5rDlmJcmG2MK/84EGLvGW2bniTl6n7Rapv5HUzj?=
 =?us-ascii?Q?kvawbNW5gkZ43wve92ju4iT1uHVK2XWbja+CyWpLon/APeZJrzA0N6ETqNel?=
 =?us-ascii?Q?udB7qN4WmmR7J67KFHWkvloBlTmgi38138T31IBE82BN9U+3kW/YdD4E2fpe?=
 =?us-ascii?Q?8bgXvu8T3f7o8td1wwtyOvW93vquz4ko4XQRH+b6M+UY3MrD5U45njDh1owc?=
 =?us-ascii?Q?Xjh2D+P2jrXtjlzend5FZfGGhZc4tJUtfmTEyXPxi9PhJqejdonP7H5pafDR?=
 =?us-ascii?Q?nMizxFmr+bdDKuion7Dx2A8j/YnYRIA0sC241ihkPvf9S0OTa652W38qAYBS?=
 =?us-ascii?Q?uripA6NNGzXgcEybYAtyOoD72tVwE8Sey7TChvv3fN+kH9vMzR4+zeOBKp+v?=
 =?us-ascii?Q?n0gFUgq+MvdgnqUNmDVkhH93ZTveN6PGh8UclJu2w+zTR1qFgR8CGMSUI9ca?=
 =?us-ascii?Q?7yPSZ9XmgT+AYiut6YEETAJkJs0jZ3rkCvGvmMf7zFIPk4QwsWwP1wOGWirZ?=
 =?us-ascii?Q?e09txMtOVoVwz1/oA1ziOfLVkUUv+VCUw+TANGameHizxk6C+lQjtQEN2uJ2?=
 =?us-ascii?Q?J+tyFIbePBHdJOPR18kPNznGh8gXn2rriO5uRWB4xekn1PFa/p9tWlk8NDUj?=
 =?us-ascii?Q?ms0JN9CKo7WjhOYUbrdKNmTck4Qmwf6HvaIA0108NOZiCn7roVarecZrRADt?=
 =?us-ascii?Q?yw1jKHXT/UKN4qfDNlMB7pLbag0ekWEy3hNdXHRAZcnvtFqAUkKPMgnWzUmQ?=
 =?us-ascii?Q?mvur9D/hLD6E5D8UO9c5YCaKqIwo1WZ4ts8zqWy8xj0xyRcLks7QCtc4AUFD?=
 =?us-ascii?Q?L/v7fXqFQ3P20uvISb4Nygl0T1QXfPU1cPnhyew7n2QbMNpq4KmockANwZdd?=
 =?us-ascii?Q?szStA7aPS2VIXmQIso05ycv77xqsfL1vPVjFclNsH0gQthJTbB7b/wYdL6le?=
 =?us-ascii?Q?uSYs7MwdRzuisWaTyxzO6RoUWaA5EC9idwb/NuNeld88BWAQSq3uIlLWw8a5?=
 =?us-ascii?Q?e3yFdPGA6PrK8yoWuqXTt1yyIRLvjfQyv3cFFFmIkznjtXF5cXsVLYI46QWd?=
 =?us-ascii?Q?2zWhVBaTzKKFoKpRY3S6KZCrOFn7kVhyeCIgjkFhB33t4N8BCFJGAtNfaoCy?=
 =?us-ascii?Q?8VnvBWplRTaHucRjWIqftGmh8uC40hLx1cmUidWtjBCigjNyyEVnovyc0BU+?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460eb46b-a7ee-49a9-69e9-08dbbc3bef24
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:40.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMIqtdpsKG2bR6a2VejghxXFaTzd7qflHqZpZqj+qjTFsDgR12XJzZ8Jewed8rofypDvu8j10A9JV7G2K54dVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the fsl,backplane-mode device tree property is present, then the Lynx
PCS makes use of the AN/LT block to advertise the supported backplane
link modes using clause 73 autoneg.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: code is new

 drivers/net/pcs/Kconfig    |   1 +
 drivers/net/pcs/pcs-lynx.c | 135 +++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index 24a033e93bdd..be561c465b4a 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -13,6 +13,7 @@ config MTIP_BACKPLANE_PHY
 	  SoCs.
 
 config PCS_XPCS
+	depends on MTIP_BACKPLANE_PHY || MTIP_BACKPLANE_PHY=n
 	tristate
 	select PHYLINK
 	help
diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index dc3962b2aa6b..1352f08edcf3 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -4,10 +4,14 @@
  */
 
 #include <linux/mdio.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
 #include <linux/phylink.h>
 #include <linux/pcs-lynx.h>
 #include <linux/property.h>
 
+#include "mtip_backplane.h"
+
 #define SGMII_CLOCK_PERIOD_NS		8 /* PCS is clocked at 125 MHz */
 #define LINK_TIMER_VAL(ns)		((u32)((ns) / SGMII_CLOCK_PERIOD_NS))
 
@@ -20,9 +24,15 @@
 #define IF_MODE_SPEED_MSK		GENMASK(3, 2)
 #define IF_MODE_HALF_DUPLEX		BIT(4)
 
+#define PRIMARY_LANE			0
+#define MAX_NUM_LANES			4
+
 struct lynx_pcs {
 	struct phylink_pcs pcs;
 	struct mdio_device *mdio;
+	struct mtip_backplane *anlt[MAX_NUM_LANES];
+	int num_lanes;
+	bool backplane_mode;
 };
 
 enum sgmii_speed {
@@ -100,6 +110,9 @@ static void lynx_pcs_get_state(struct phylink_pcs *pcs,
 	case PHY_INTERFACE_MODE_10GBASER:
 		phylink_mii_c45_pcs_get_state(lynx->mdio, state);
 		break;
+	case PHY_INTERFACE_MODE_INTERNAL:
+		mtip_backplane_get_state(lynx->anlt[PRIMARY_LANE], state);
+		break;
 	default:
 		break;
 	}
@@ -168,6 +181,17 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
 				 ADVERTISE_SGMII | ADVERTISE_LPACK);
 }
 
+static int lynx_pcs_config_backplane(struct phylink_pcs *pcs,
+				     unsigned int neg_mode,
+				     const unsigned long *advertising)
+{
+	bool autoneg = neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
+	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
+
+	return mtip_backplane_config_aneg(lynx->anlt[PRIMARY_LANE], autoneg,
+					  advertising);
+}
+
 static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 			   phy_interface_t ifmode,
 			   const unsigned long *advertising, bool permit)
@@ -193,6 +217,8 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	case PHY_INTERFACE_MODE_10GBASER:
 		/* Nothing to do here for 10GBASER */
 		break;
+	case PHY_INTERFACE_MODE_INTERNAL:
+		return lynx_pcs_config_backplane(pcs, neg_mode, advertising);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -204,6 +230,9 @@ static void lynx_pcs_an_restart(struct phylink_pcs *pcs)
 {
 	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
 
+	if (lynx->backplane_mode)
+		return mtip_backplane_an_restart(lynx->anlt[PRIMARY_LANE]);
+
 	phylink_mii_c22_pcs_an_restart(lynx->mdio);
 }
 
@@ -306,16 +335,111 @@ static void lynx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 	}
 }
 
+static int lynx_pcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
+			     const struct phylink_link_state *state)
+{
+	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
+
+	if (state->interface != PHY_INTERFACE_MODE_INTERNAL)
+		return 0;
+
+	return mtip_backplane_validate(lynx->anlt[PRIMARY_LANE], supported);
+}
+
+static int lynx_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
+	int err;
+
+	if (lynx->backplane_mode) {
+		err = mtip_backplane_resume(lynx->anlt[PRIMARY_LANE]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void lynx_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
+
+	if (lynx->backplane_mode)
+		mtip_backplane_suspend(lynx->anlt[PRIMARY_LANE]);
+}
+
 static const struct phylink_pcs_ops lynx_pcs_phylink_ops = {
 	.pcs_get_state = lynx_pcs_get_state,
 	.pcs_config = lynx_pcs_config,
 	.pcs_an_restart = lynx_pcs_an_restart,
 	.pcs_link_up = lynx_pcs_link_up,
+	.pcs_validate = lynx_pcs_validate,
+	.pcs_enable = lynx_pcs_enable,
+	.pcs_disable = lynx_pcs_disable,
 };
 
+static int lynx_pcs_parse_fwnode(struct lynx_pcs *lynx)
+{
+	struct fwnode_handle *node = lynx->mdio->dev.fwnode;
+	enum mtip_model model = MTIP_MODEL_AUTODETECT;
+	struct device_node *np = to_of_node(node);
+	struct mdio_device *mdio = lynx->mdio;
+	struct device *dev = &mdio->dev;
+	struct phy *phy;
+	int i, err;
+
+	if (!node)
+		return 0;
+
+	lynx->backplane_mode = fwnode_property_present(node, "fsl,backplane-mode");
+	if (!lynx->backplane_mode)
+		return 0;
+
+	if (fwnode_device_is_compatible(node, "fsl,lx2160a-lynx-pcs"))
+		model = MTIP_MODEL_LX2160A;
+
+	lynx->num_lanes = of_count_phandle_with_args(np, "phys", "#phy-cells");
+	if (lynx->num_lanes < 0)
+		return lynx->num_lanes;
+
+	if (WARN_ON(lynx->num_lanes > MAX_NUM_LANES))
+		return -EINVAL;
+
+	for (i = 0; i < lynx->num_lanes; i++) {
+		phy = devm_of_phy_get_by_index(dev, np, i);
+		if (IS_ERR(phy))
+			return dev_err_probe(dev, PTR_ERR(phy),
+					     "Failed to get SerDes PHY %d\n", i);
+
+		lynx->anlt[i] = mtip_backplane_create(mdio, phy, model);
+		if (IS_ERR(lynx->anlt[i])) {
+			err = PTR_ERR(lynx->anlt[i]);
+
+			while (i-- > 0)
+				mtip_backplane_destroy(lynx->anlt[i]);
+
+			return err;
+		}
+	}
+
+	for (i = 1; i < lynx->num_lanes; i++) {
+		err = mtip_backplane_add_subordinate(lynx->anlt[PRIMARY_LANE],
+						     lynx->anlt[i]);
+		if (WARN_ON(err)) {
+			/* Too many SerDes lanes in the device tree? */
+			for (i = 0; i < lynx->num_lanes; i++)
+				mtip_backplane_destroy(lynx->anlt[i]);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
 {
 	struct lynx_pcs *lynx;
+	int err;
 
 	lynx = kzalloc(sizeof(*lynx), GFP_KERNEL);
 	if (!lynx)
@@ -327,6 +451,12 @@ static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
 	lynx->pcs.neg_mode = true;
 	lynx->pcs.poll = true;
 
+	err = lynx_pcs_parse_fwnode(lynx);
+	if (err) {
+		kfree(lynx);
+		return ERR_PTR(err);
+	}
+
 	return lynx_to_phylink_pcs(lynx);
 }
 
@@ -392,6 +522,11 @@ EXPORT_SYMBOL_GPL(lynx_pcs_create_fwnode);
 void lynx_pcs_destroy(struct phylink_pcs *pcs)
 {
 	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
+	int i;
+
+	if (lynx->backplane_mode)
+		for (i = 0; i < lynx->num_lanes; i++)
+			mtip_backplane_destroy(lynx->anlt[i]);
 
 	mdio_device_put(lynx->mdio);
 	kfree(lynx);
-- 
2.34.1

