Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8717AC27B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjIWNuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjIWNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A3B1B1;
        Sat, 23 Sep 2023 06:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPcg5s3pWll7T0xmKYK7A1driEbtAJwf9kGBSbueWXW5yx7eZQkQsWR6fPwgLNOWBju9/mwpyZI2KxUFFW4yef4ROQ90S0YsvkWvTMmXXkLbJ+m5uRacUbd306a9O3tXHU2jmy4J9N1yiLs4oPD5ZZzc+SU0PG0TkI7D0lf+3FuDSphN0pL3VeY6AbfTWmbzV1WcJ0AXHL4MrKf9CfOaPb38KPh+rXuSQhN3g3XDeYAKQHTn7SNkcxoJNxCjFEBUHNj7z4ilYffjA828rJjgAA4c6xrUilkfE+1sJN81WLrA5tivvnlXKYOTGkB0clmiUsHyEh3lU9Y+UWchADJr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLdZ3Q+/1tKzmXbcdN+NWqFouUwTh+6/uQGHuEziuRQ=;
 b=GwoTDfzNFhRxm14pnMCJQRQ6eaOfZoxKkfGWxtBB+0yTjDX+qJEmjfFLchAynU/9RN8jZgNBixHWblnKf2kEJjBEU/O+qsaVY2rfJvZqQpHu6LP8ZdE4jB71clXiIkVQoUbviUvOTxkpF5zYxiT5iaXi82LEruNEnx4vm3gENn1aYA9/s+wbJgpBmO04aZB/2na8IUGG6K9QpctloiEtZvsuy+PMvRANbcK2QdeFLCQJ7C7os2xCvsqY7uGvjw7bGkW1o2UKQQn9psdEmVgwR2CGm3v4HbLQY9QzHdYgb22G8XLuB+x2QgA6V2cSNth/YGitBun+wTwe1Fasozgukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLdZ3Q+/1tKzmXbcdN+NWqFouUwTh+6/uQGHuEziuRQ=;
 b=Bq40txfnjAsdZ8yJdVh/rcomyIt4S+Y/AgvbHcXVhTbwU+ZaB5cOA6RiY8dD7ImJFW2UCjxnyU76XHuditMphGCvbRb894dqHH5b+tBaTYEV1pOG6KTsRkxDhNCUwOiSlTfUhT0XOPGDL2PBV5qTTXiSub8D5IXKK1SJAEYMe/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:30 +0000
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
Subject: [RFC PATCH v2 net-next 07/15] net: phylink: centralize phy_interface_mode_is_8023z() && phylink_autoneg_inband() checks
Date:   Sat, 23 Sep 2023 16:48:56 +0300
Message-Id: <20230923134904.3627402-8-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8db5e03c-3d2c-4f06-4c3e-08dbbc3be93f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xibz12cGhe/hmq/lCbsgqclsp6+eFD+RXPJmdUJq1PLjg8iTm3d79qVSYKj18+1lE926br/b0omeABRl/O+AkqiMHgfbt65n5qcsfT84reRpJfHIUXi26hZkj/peTe+sl5E3u17QDD1AnqzMobvIu36/6MJcEgxB+Zlku9hEhMrzX9dAn136LgumM37PHt72V9DTUzAS42rfuzuK+RuK32yXb5drxIff6iK6iUWM8l7bdNJPLXcEWgUWUX6l8XD/1rbxRvCBwSflVRyLEw4MkBcxWe7Xsu0JqdD014XiT9NY9ZAdohXzbatceUHagyzlOb6cmyCYuSEUn1yplvCIouBLU0bps2lPnnY7gUldVi7F+d7V1TUp+vbFANWELjUF37PAWPUXhOxLeqMQ6B2xPtfm211gbeTMYUTrqA2n2S42xFachNkJx9DfC7hR3j4T1AChEXd0WI3zKg5dVXsrARWCtBslDywDpBVD+k3ULq+iJ6MzjkxRc9GKYlCaj3uKiii0BkykW/8oax6z0UUIZ0ZH6Ym0Q4hST2+8aWJ5KWtEO1cPoWP/ysYEe0lB9yu8rlhUUqLR5oSKDl71nAFkzr8uU8WsBETmij4hN8W6Gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeqYSwm6zItu4Aa84ZABUciLVTEqlXyNqFDSd4F2gijpfhhFAy7FoQuM8kt7?=
 =?us-ascii?Q?nNAKXum5gS0Atciy3a4QqLc1XXboNO2ddI/OUae4vq0rCrOKD3uhZP0+9uS1?=
 =?us-ascii?Q?xK+dK1tlD6zYEBJQ97RnhnmeOrMf+b3o6vOcTp8w+s3LhBuzUH5Cfh04gIkd?=
 =?us-ascii?Q?9TSEa39mL6QpjiE6OIy8450HsE5WBHkRvUAmbeOFYzQiyPWk5QeGKh5Hn9gf?=
 =?us-ascii?Q?kBmkbJyajQ2q7biTdzAq0FdpMWEtL+etW+rXyzKxbef8LJfsJ7sSlzOQaYs0?=
 =?us-ascii?Q?cpJM9UkjDBi/yohm7yVOCHDjjnQ4bjC+lN8ma2JU3mpp6gck7WT60ZtykI5Z?=
 =?us-ascii?Q?JWroe+9pXAu0Xf+IrDvRBjk5alTW+vHlRFbAmJ1ncjzakSeMa3T/Dn2o0NeL?=
 =?us-ascii?Q?lkvxTBibYxrP6IvNQMKdNwH1wrfZfnw74UXnrKYSI2887lLDWe1gzCk/YJSD?=
 =?us-ascii?Q?CK/uFISl6TZsCZjuArELV1XYVh90KwA1XvY3y3QC+Yx/0lrnDhrSpqs3QjBI?=
 =?us-ascii?Q?/Lvv0EUE6rNKdcBX16n6X8vZQWmgEUrYWTBr4Hl9ukY7bjjzXY6F1KAabOt7?=
 =?us-ascii?Q?+ZUXh5yS9ecsqu6SS3nc5eP3S9DMXYg9dC33+URv4WXgJlDzVjEnlgYZhY/O?=
 =?us-ascii?Q?SZ9UCJElWYrbJs0TvvjDiOBAaSAnlnWqlqWTGGcfwFgkEPdqJll5wP7L7Mki?=
 =?us-ascii?Q?JE3hUFV43gfsdReXlw3b30kefQmsdCJ1Vkz2k2Cfy6l20dQgJ0du+HlzbpPu?=
 =?us-ascii?Q?rvh6k2oQWis5ozgTyLGaPK74n8k5g2xUdT6GN+X5lMt6FcnAiO6+cpJ+vtU1?=
 =?us-ascii?Q?B2/uTh67VRKLm4Fe/wvx5WD0uNuHaO6Lh2aCnotN4IBwglqkHy+S5Xzj+N8H?=
 =?us-ascii?Q?vLdOjUhlUL2neAwflDnGyJdAZ+22UzI0q8ZVwhPwO1G5K0VkxegMytRtgkvq?=
 =?us-ascii?Q?s5h6MIAM5PlKL2NP1VHyKvfAQceDDTz/RfTpG53kAoGa8ptVnyhds158P93z?=
 =?us-ascii?Q?Fl24IVkDe+cEa2+GPkc6PoJsD0PvZJ27pZLQ49Kf3mwysYh0SiEIDXnGgWYB?=
 =?us-ascii?Q?MYfWTWoNylaNi7eHOkJZ+64b2e8iZld/iT1j+LbTHnCLquTVMkBR78K7SnPS?=
 =?us-ascii?Q?kqrDSfJ9GwqIDEj9VPCWKo3bfGsBwIe6/9o9xsIJX3ymMiS1m0oRwLBfrhKl?=
 =?us-ascii?Q?mE0s9xfOXzQiob3dC9hgAFOBnsq0SdhC1jV7doG7WjyPqO2sMCLn5bf40RsZ?=
 =?us-ascii?Q?Kd+N7/25vPSwyrtfoFwr7A6dRqyc+p29ZFrEE9BGhok+gSAHpm2g8EcAhbvx?=
 =?us-ascii?Q?29b5gSiNW+E48MdYd3B2hSOZB543noc3alLS2Jjw+86WKLRWrDS5llAjvdqC?=
 =?us-ascii?Q?NWiXpffV41KAk4EBu3TNeypOzNqL5lt5GN4P8RfV6g26lJZQTN3nkjxRFxsd?=
 =?us-ascii?Q?mGfhU+zEV6tN0H0kY8O5pgCT5RUHMnNChhSTIujBr41sc4UjpV5kLMVWlZl4?=
 =?us-ascii?Q?Wik1+lEH5pHsq25vtf1ucP2ONK1x1HagELq5lLS3tm+w7WC+m7XfcPlkge/5?=
 =?us-ascii?Q?qvheJgb0LuFGKwvW2HimDcKby0VINjf78FKB5+ZmOyNIi0MyscE8gtTq5rrJ?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db5e03c-3d2c-4f06-4c3e-08dbbc3be93f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:30.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJ4yQptNNwTefbm/F1mO6Ha2GaVXDwRFzxHo2vVqko7Vw7vVEndbs2LxwC8HZOVvQ/IbAA0+LnjWYnKlhY9s3g==
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

In a future change, we will extend the PHY interface modes for which
phylink allows the PCS to handle autoneg. Group the existing occurences
into a common phylink_pcs_handles_an().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/phy/phylink.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0d7354955d62..548130d77302 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1107,12 +1107,17 @@ static void phylink_mac_config(struct phylink *pl,
 	pl->mac_ops->mac_config(pl->config, pl->cur_link_an_mode, &st);
 }
 
+static bool phylink_pcs_handles_an(phy_interface_t iface, unsigned int mode)
+{
+	return phy_interface_mode_is_8023z(iface) && phylink_autoneg_inband(mode);
+}
+
 static void phylink_pcs_an_restart(struct phylink *pl)
 {
 	if (pl->pcs && linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 					 pl->link_config.advertising) &&
-	    phy_interface_mode_is_8023z(pl->link_config.interface) &&
-	    phylink_autoneg_inband(pl->cur_link_an_mode))
+	    phylink_pcs_handles_an(pl->link_config.interface,
+				   pl->cur_link_an_mode))
 		pl->pcs->ops->pcs_an_restart(pl->pcs);
 }
 
@@ -1716,8 +1721,8 @@ EXPORT_SYMBOL_GPL(phylink_destroy);
 bool phylink_expects_phy(struct phylink *pl)
 {
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
-	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_config.interface)))
+	    phylink_pcs_handles_an(pl->link_config.interface,
+				   pl->cfg_link_an_mode))
 		return false;
 	return true;
 }
@@ -1852,8 +1857,8 @@ static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
 			      phy_interface_t interface)
 {
 	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
-		    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-		     phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
+		    (phylink_pcs_handles_an(interface, pl->cfg_link_an_mode) &&
+		     !pl->sfp_bus)))
 		return -EINVAL;
 
 	if (pl->phydev)
@@ -1937,10 +1942,11 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 	struct phy_device *phy_dev;
 	int ret;
 
-	/* Fixed links and 802.3z are handled without needing a PHY */
+	/* Fixed links and the modes where the PCS can handle autoneg with the
+	 * far end do not need a PHY.
+	 */
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
-	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_interface)))
+	    phylink_pcs_handles_an(pl->link_interface, pl->cfg_link_an_mode))
 		return 0;
 
 	phy_fwnode = fwnode_get_phy_node(fwnode);
-- 
2.34.1

