Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC38752123
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjGMMUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjGMMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:20:20 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC5B26A5;
        Thu, 13 Jul 2023 05:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYN07h8fU/HlFd+/X7Y1mund7TJCa7xSIHaftfNcnrk3MmCcc+Wn+tTkrBu49ZH16isS1O6htkNJGOE78kiTCT6NS/46ssA6XGV14c5+8RNTmblNVgZANu2bBoHxAeQWt0p3/2Blt0doRl0otErhPEbm7BjY8IJ59BdQo2XuuXzWwkiDKc90koZV//vTgSwznKMqSguKJbhm/YE8ZiTzxQW+zz299Yz4d3we6qQCb+8mC3Bzjn/rYpE4i9NWXEvXBYltQ074X5DAsz/z3rqJ3J4cO0xE2JZiRwhoyxNs5+2tfATSudyTWwuLxhksNagr6m5dZm3VY+qQl0mum+4HSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtEZXWH40iTCJjTrtnzMzW5xGDiQeL/VMCcTYWylmyU=;
 b=SGOsl32BOCHHhQ5aGmoyGVuUTQIxX6uo+SJ4rv0ZwU3akn6oqcfzExw4UGAV43ojYZ/x62JMiOshWbZN0Za4AS7vNOhWR5OQHtPey+eyGhy/afnGa6NEOsMCKwmu3SM7eTDscvQzhgwWqKccej8dbiCa3ywkuc6isS7vXE7qQlp0aMwkAlyZzRYycllYafMykqO6LQcUnLZvhagKD+ENwdV4HVew/6CEBoBqT252YHsIXL3hv81NXRgbvBmOnwIE7eWRPYS4LUXlJnSSK7OOs5dLqEvGwkQZ+MxtWM1D0nNzbqbdEmRMj8KeozoVIsH6SmyvP/X17g6i5Nc0GWP0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtEZXWH40iTCJjTrtnzMzW5xGDiQeL/VMCcTYWylmyU=;
 b=OvIU8z6LMN9o+EUjH0YObpsv4NUbv8mY7DoRPR/6nUmvaCk8yfBIK6La5z/TuDFYV7qtSyBn6yGiNbB3W6l2XWbex++KzDlO5pBbjNjBH++PykHTPm/h3Numlzc342DJrusI4QWgUcmWgp2LoOjV8OaoXPdfhwihuzgmmb30IR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:47 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:47 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 net-next 10/10] net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from converted drivers
Date:   Thu, 13 Jul 2023 15:19:07 +0300
Message-Id: <20230713121907.3249291-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 7504661b-f009-4df4-fc47-08db839b7296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXl7/eFXc+WVdiH7Jl7/FEu1SGpSQu3dexTEN3xZPod4ruNAkvvy52wDOo1kEgn21UW7iBu9vZGmqpGg5wYcpmcloirzX213icMsHK38pB7mrl6lMJHD4Fj3yWCvs4tb2tkStCVSmZaBSIzKlWqxthVOkxc7Ho4IVr5PUDt0lHueWvN2m3/sI+atmVRTeyVId6uX9fOtGC8QfNs6RueRbe4cdrD5xPsDT7nf188+Tzlk6pYILLHxKHVi1oMpuU3b761KJjSy9Vv74E8c/KatxnLqoeacfLYvlxT59q6WJTJ7SdPlnkUfFyxCDRKgSjwcMmLSAJL6BsngiiiroVSSSDw5B8uU81klplgiOwlRaG23+j340xgHUR0TikufDcg4VAaD+lmFaaur/c+xB6RLHFlUJ1+6sFXWgU0ivL2BSUHjy5gVmZufndLi7VIMsL7hixnVfNoGrcvimKPCcb9ZjPoPV4T3v/8UMnXVGw51uxSEAgJwKuoDk6t8xMNfpURE1vCnePy2K82KQguuV5qhKhcIXesZ0vFTL6k2R9mwjokHkbKsVnRUNtuDCF2PZJ8+3ZjgMdAGtkWH65iFaWQ83rQbOl2Zl1FOYsrzd0RIjmVJ48YME1jUkaDV8YEAp8q2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(30864003)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mKcPrP35ZFhj5+EBtper1GvFtudJnBXKPw3jyEzwliMhHPtWwJg5We00bg8q?=
 =?us-ascii?Q?Qb1aefv2ryUZu3u1w0GbmUbUl5CQFFvJjHePbmy5jDeYcvVvFfiDJm9fyTQ2?=
 =?us-ascii?Q?h66yTdeeMluapqcaGr70DKvQsojNnzm/79xAshGI+KfthPJpmy2dZ47AmTKs?=
 =?us-ascii?Q?NP9Hp/34ZDQSO18JPOvqois02P12oVEPZPRn9Wf7kZI6gqNqUVM+Bujfm3AH?=
 =?us-ascii?Q?QZxLIbUNqXQ3V5IOap5bn41DhM49rKFt79ItevCxONORcwv99qaN/b9U75/4?=
 =?us-ascii?Q?/Tff/VrPRDhvGK9xqVK9uYOQdGdPIOxRkP4z3bVkVd+Czq1M3MW9GtEhwXKl?=
 =?us-ascii?Q?Jca9tTEOhYbGXDEWMbAmXP47ImJ9tXCcHsJmUa58QyyGyOtwh3lam1px20JP?=
 =?us-ascii?Q?3ml8t3HatS2LGipikna0OWBAA9a5hRRFocTuGRimGTBAFwQ+2PuxisenxYlh?=
 =?us-ascii?Q?0IJDCoNDTHN0nJHqSLBAi6JmObXLW0iutX6T5S1D0Ni79eAIgEaGaCgcVODK?=
 =?us-ascii?Q?O9iQV+Qix+8oRu6aEbKStcXrqiTjqbxANv+GhB45s4qef+EF8OR35FuDGA4v?=
 =?us-ascii?Q?TSeTrAnX9K8jgOtFpJAAPf4gfYPxKyF+V9grGrU49WsQAyxMU3MwyOOKXh8w?=
 =?us-ascii?Q?0vdRj4lR4V68hW5I/tNoArTJno8pJ1vxZU/P7i9Pq6+leyYdOvJNp2eBIc27?=
 =?us-ascii?Q?YN5Qje6jfEt8+Mj44c3aZ7oALkkddlyyeZrR3StGgCRe4YbgcFjgDgfEwBXs?=
 =?us-ascii?Q?53BqgxOaLrtALuiKHQvFxCOt2e4jmtTrIkegL/I4rPOyry58jsjLVHYes1M9?=
 =?us-ascii?Q?QDquhVeV16d4qgJY7Lihz8kGcMKsQoNW98lE012FMcDyInkKcoBa2U2GpNJq?=
 =?us-ascii?Q?CMuZQuy7iMw3sXXKjw5xZ0OLxet0nnUhbnbmJlDhx0Vdh4Z93Cepsm0YfA/z?=
 =?us-ascii?Q?RtpLI7+P6T0lrvRtthrU/Rz6LsgBoS0Csy32Ofa9KcRjRzB6gP3rQFyzCImX?=
 =?us-ascii?Q?k1EqiSLPGBSzheZalszm2hnWuea4WSJVl9a5tLGhpfooS40J82vRTi8ixxQY?=
 =?us-ascii?Q?uBSDCZdcXkhIvjzVgJuE0bxw2ymc5Ble66Hk0yNK8nKjYmjHZSgFzRTjIrJg?=
 =?us-ascii?Q?IZkInqGxkCct87/qBfC5vQ6NboP1cqkGg312Weagu+3AtyX+DHspu3jZvkGC?=
 =?us-ascii?Q?Qh/8p/OXwPibunCqBRETToqwTPHOxaEldShba1qNMp9U0ithLiTjvI1shcwa?=
 =?us-ascii?Q?yiWqvx4fMGMsnURKBxSzLV+zXwdDGkVWdblxwwUtYr2IcA5900BB0Mv5Znlf?=
 =?us-ascii?Q?u+Q0s5Qne9exaGFs6Wd1VnDuyR6J0U107cvuDrWxahiaSvDfKBVz11yAsTIP?=
 =?us-ascii?Q?SPnbjytVQyhYNlvM9rEs4l+mVVVXt1C+Ybdct7upM4hIJ2mKyNUAagB0N+4s?=
 =?us-ascii?Q?lMDfMXQXztJazvCzRMcx8wFvDhAdvQUXjvupDjgfWpzDNaKCWZrJEAT+kXUZ?=
 =?us-ascii?Q?4mMhZnNFGV1QwQ7A+DOUoUu5l+BY0HDEfWWyHLR7YqtaCKXXWpAspI+Tkr6U?=
 =?us-ascii?Q?7GEC+F05cYoQlt/82RihhzvaXnUYba4wU/GHxdC8PhoHpDYOt7rv3FNCa3bL?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7504661b-f009-4df4-fc47-08db839b7296
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:47.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwRjC23kV8Onul9aatQlCBqqbZsTBy30YniXM+DWH4kOCCi7YsKd0/w0CtuJ7QqmC1RaZoxMf93YIvPzeWUYOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is desirable that the new .ndo_hwtstamp_set() API gives more
uniformity, less overhead and future flexibility w.r.t. the PHY
timestamping behavior.

Currently there are some drivers which allow PHY timestamping through
the procedure mentioned in Documentation/networking/timestamping.rst.
They don't do anything locally if phy_has_hwtstamp() is set, except for
lan966x which installs PTP packet traps.

Centralize that behavior in a new dev_set_hwtstamp_phylib() code
function, which calls either phy_mii_ioctl() for the phylib PHY,
or .ndo_hwtstamp_set() of the netdev, based on a single policy
(currently simplistic: phy_has_hwtstamp()).

Any driver converted to .ndo_hwtstamp_set() will automatically opt into
the centralized phylib timestamping policy. Unconverted drivers still
get to choose whether they let the PHY handle timestamping or not.

Netdev drivers with integrated PHY drivers that don't use phylib
presumably don't set dev->phydev, and those will always see
HWTSTAMP_SOURCE_NETDEV requests even when converted. The timestamping
policy will remain 100% up to them.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v7:
- Patch is new

 drivers/net/ethernet/freescale/fec_main.c     |  8 --
 .../ethernet/microchip/lan966x/lan966x_main.c | 25 +++---
 .../ethernet/microchip/sparx5/sparx5_netdev.c |  6 --
 include/linux/net_tstamp.h                    | 14 +++
 include/linux/netdevice.h                     |  4 +
 net/core/dev_ioctl.c                          | 90 +++++++++++++++++--
 6 files changed, 114 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 08744e8164e3..fa81e70eb2ab 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3858,10 +3858,6 @@ static int fec_hwtstamp_get(struct net_device *ndev,
 			    struct kernel_hwtstamp_config *config)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct phy_device *phydev = ndev->phydev;
-
-	if (phy_has_hwtstamp(phydev))
-		return phy_mii_ioctl(phydev, config->ifr, SIOCGHWTSTAMP);
 
 	if (!fep->bufdesc_ex)
 		return -EOPNOTSUPP;
@@ -3876,10 +3872,6 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 			    struct netlink_ext_ack *extack)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct phy_device *phydev = ndev->phydev;
-
-	if (phy_has_hwtstamp(phydev))
-		return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
 
 	if (!fep->bufdesc_ex)
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index c8fce4e79c63..5185691e10c1 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -463,9 +463,6 @@ static int lan966x_port_hwtstamp_get(struct net_device *dev,
 {
 	struct lan966x_port *port = netdev_priv(dev);
 
-	if (phy_has_hwtstamp(dev->phydev))
-		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCGHWTSTAMP);
-
 	if (!port->lan966x->ptp)
 		return -EOPNOTSUPP;
 
@@ -481,21 +478,26 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
 	struct lan966x_port *port = netdev_priv(dev);
 	int err;
 
+	if (cfg->source != HWTSTAMP_SOURCE_NETDEV &&
+	    cfg->source != HWTSTAMP_SOURCE_PHYLIB)
+		return -EOPNOTSUPP;
+
 	err = lan966x_ptp_setup_traps(port, cfg);
 	if (err)
 		return err;
 
-	if (phy_has_hwtstamp(dev->phydev)) {
-		err = phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCSHWTSTAMP);
-		if (err)
+	if (cfg->source == HWTSTAMP_SOURCE_NETDEV) {
+		if (!port->lan966x->ptp)
+			return -EOPNOTSUPP;
+
+		err = lan966x_ptp_hwtstamp_set(port, cfg, extack);
+		if (err) {
 			lan966x_ptp_del_traps(port);
-		return err;
+			return err;
+		}
 	}
 
-	if (!port->lan966x->ptp)
-		return -EOPNOTSUPP;
-
-	return lan966x_ptp_hwtstamp_set(port, cfg, extack);
+	return 0;
 }
 
 static const struct net_device_ops lan966x_port_netdev_ops = {
@@ -823,6 +825,7 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 			 NETIF_F_HW_VLAN_STAG_TX |
 			 NETIF_F_HW_TC;
 	dev->hw_features |= NETIF_F_HW_TC;
+	dev->priv_flags |= IFF_SEE_ALL_HWTSTAMP_REQUESTS;
 	dev->needed_headroom = IFH_LEN_BYTES;
 
 	eth_hw_addr_gen(dev, lan966x->base_mac, p + 1);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 573662d2e01a..48f7022d3fb7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -222,9 +222,6 @@ static int sparx5_port_hwtstamp_get(struct net_device *dev,
 	struct sparx5_port *sparx5_port = netdev_priv(dev);
 	struct sparx5 *sparx5 = sparx5_port->sparx5;
 
-	if (phy_has_hwtstamp(dev->phydev))
-		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCGHWTSTAMP);
-
 	if (!sparx5->ptp)
 		return -EOPNOTSUPP;
 
@@ -240,9 +237,6 @@ static int sparx5_port_hwtstamp_set(struct net_device *dev,
 	struct sparx5_port *sparx5_port = netdev_priv(dev);
 	struct sparx5 *sparx5 = sparx5_port->sparx5;
 
-	if (phy_has_hwtstamp(dev->phydev))
-		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCSHWTSTAMP);
-
 	if (!sparx5->ptp)
 		return -EOPNOTSUPP;
 
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 03e922814851..f4aff9137724 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -5,6 +5,11 @@
 
 #include <uapi/linux/net_tstamp.h>
 
+enum hwtstamp_source {
+	HWTSTAMP_SOURCE_NETDEV,
+	HWTSTAMP_SOURCE_PHYLIB,
+};
+
 /**
  * struct kernel_hwtstamp_config - Kernel copy of struct hwtstamp_config
  *
@@ -26,6 +31,7 @@ struct kernel_hwtstamp_config {
 	int rx_filter;
 	struct ifreq *ifr;
 	bool copied_to_user;
+	enum hwtstamp_source source;
 };
 
 static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
@@ -44,4 +50,12 @@ static inline void hwtstamp_config_from_kernel(struct hwtstamp_config *cfg,
 	cfg->rx_filter = kernel_cfg->rx_filter;
 }
 
+static inline bool kernel_hwtstamp_config_changed(const struct kernel_hwtstamp_config *a,
+						  const struct kernel_hwtstamp_config *b)
+{
+	return a->flags != b->flags ||
+	       a->tx_type != b->tx_type ||
+	       a->rx_filter != b->rx_filter;
+}
+
 #endif /* _LINUX_NET_TIMESTAMPING_H_ */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ca3bcf2257c0..0d8a7ac67cf1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1724,6 +1724,9 @@ struct xdp_metadata_ops {
  * @IFF_TX_SKB_NO_LINEAR: device/driver is capable of xmitting frames with
  *	skb_headlen(skb) == 0 (data starts from frag0)
  * @IFF_CHANGE_PROTO_DOWN: device supports setting carrier via IFLA_PROTO_DOWN
+ * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
+ *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
+ *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1759,6 +1762,7 @@ enum netdev_priv_flags {
 	IFF_NO_ADDRCONF			= BIT_ULL(30),
 	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
 	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
+	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index d0223ecd6f6f..caaba0db8cb3 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -252,6 +252,30 @@ static int dev_eth_ioctl(struct net_device *dev,
 	return ops->ndo_eth_ioctl(dev, ifr, cmd);
 }
 
+/**
+ * dev_get_hwtstamp_phylib() - Get hardware timestamping settings of NIC
+ *	or of attached phylib PHY
+ * @dev: Network device
+ * @cfg: Timestamping configuration structure
+ *
+ * Helper for enforcing a common policy that phylib timestamping, if available,
+ * should take precedence in front of hardware timestamping provided by the
+ * netdev.
+ *
+ * Note: phy_mii_ioctl() only handles SIOCSHWTSTAMP (not SIOCGHWTSTAMP), and
+ * there only exists a phydev->mii_ts->hwtstamp() method. So this will return
+ * -EOPNOTSUPP for phylib for now, which is still more accurate than letting
+ * the netdev handle the GET request.
+ */
+static int dev_get_hwtstamp_phylib(struct net_device *dev,
+				   struct kernel_hwtstamp_config *cfg)
+{
+	if (phy_has_hwtstamp(dev->phydev))
+		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCGHWTSTAMP);
+
+	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
+}
+
 static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -266,7 +290,7 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 		return -ENODEV;
 
 	kernel_cfg.ifr = ifr;
-	err = ops->ndo_hwtstamp_get(dev, &kernel_cfg);
+	err = dev_get_hwtstamp_phylib(dev, &kernel_cfg);
 	if (err)
 		return err;
 
@@ -283,6 +307,59 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	return 0;
 }
 
+/**
+ * dev_set_hwtstamp_phylib() - Change hardware timestamping of NIC
+ *	or of attached phylib PHY
+ * @dev: Network device
+ * @cfg: Timestamping configuration structure
+ * @extack: Netlink extended ack message structure, for error reporting
+ *
+ * Helper for enforcing a common policy that phylib timestamping, if available,
+ * should take precedence in front of hardware timestamping provided by the
+ * netdev. If the netdev driver needs to perform specific actions even for PHY
+ * timestamping to work properly (a switch port must trap the timestamped
+ * frames and not forward them), it must set IFF_SEE_ALL_HWTSTAMP_REQUESTS in
+ * dev->priv_flags.
+ */
+static int dev_set_hwtstamp_phylib(struct net_device *dev,
+				   struct kernel_hwtstamp_config *cfg,
+				   struct netlink_ext_ack *extack)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	bool phy_ts = phy_has_hwtstamp(dev->phydev);
+	struct kernel_hwtstamp_config old_cfg = {};
+	bool changed = false;
+	int err;
+
+	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
+
+	if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
+		err = ops->ndo_hwtstamp_get(dev, &old_cfg);
+		if (err)
+			return err;
+
+		err = ops->ndo_hwtstamp_set(dev, cfg, extack);
+		if (err) {
+			if (extack->_msg)
+				netdev_err(dev, "%s\n", extack->_msg);
+			return err;
+		}
+
+		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
+	}
+
+	if (phy_ts) {
+		err = phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCSHWTSTAMP);
+		if (err) {
+			if (changed)
+				ops->ndo_hwtstamp_set(dev, &old_cfg, NULL);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -314,12 +391,9 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	err = ops->ndo_hwtstamp_set(dev, &kernel_cfg, &extack);
-	if (err) {
-		if (extack._msg)
-			netdev_err(dev, "%s\n", extack._msg);
+	err = dev_set_hwtstamp_phylib(dev, &kernel_cfg, &extack);
+	if (err)
 		return err;
-	}
 
 	/* The driver may have modified the configuration, so copy the
 	 * updated version of it back to user space
@@ -362,7 +436,7 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 		return -ENODEV;
 
 	if (ops->ndo_hwtstamp_get)
-		return ops->ndo_hwtstamp_get(dev, kernel_cfg);
+		return dev_get_hwtstamp_phylib(dev, kernel_cfg);
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
@@ -379,7 +453,7 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 		return -ENODEV;
 
 	if (ops->ndo_hwtstamp_set)
-		return ops->ndo_hwtstamp_set(dev, kernel_cfg, extack);
+		return dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
-- 
2.34.1

