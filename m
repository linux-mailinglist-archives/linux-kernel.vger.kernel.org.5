Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6457567F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGQP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjGQP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24891704;
        Mon, 17 Jul 2023 08:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MizlmyA6xQx1ai2ajNNjKSCHaU6eWXcu/fXD6sOg3Hw7OVcDZzr/6OwKl8gfbPEgs/rabo2QKtqQz3/GIQ7oEfaE9FxNWAccUNFwUC/A02cC2mBXfAR0dgSIid0xrWo1B/pTBVeOuziGpwG4tlp2rP5P+WnSIHDwgVVQN3KhEp4CoiudsmbxPfZZXTSEtrq1HTIZ0ddSyyuNMhPTFMC2e3KePBcevlmLc6V5au1imqAlQY5TcKuGwWsYb28oTJV3qOIm14a/kSrRVHkwJeyIuw9uI8Ig8/zRscMaYdmLm8ZoTmcSAdDBi1LrryEt4yk/qgH4CYPHY7fVOvmewUrPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o47KaUMkf2K17437PM92Lmueuo24U0vLwPfJrAXZu3k=;
 b=b2heMhbTvy1A1+ft147f31WfC+ZWsD4LZ0e5R2xGX0YrUhylWnZrkTknREi2n6DBFA7QiDJwMYpu1nzkT79cOPFtkm67N1uu4VBsEO7hg4bKhXiJ+QbM5HNO8yVvl+suDUTIpyzEiRzDxY10lZA3P71kolkfBKZhWlEPDiedz3gjjlbNLRvuK2KzVdSfz2R5FHxYcu9AChFcUl6Fq6IBRkTvUe65I/WHOV21H1jjnmM4iG3QysWunPXtStlzfXLdSnXIyH+QzWmsviq5iKi1UssfIOkFEE0lV/cMLQzGat0WTVJfzbOdHSDuUUqPbmXyIDR1EgHB/Ym1069Hhu5xZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o47KaUMkf2K17437PM92Lmueuo24U0vLwPfJrAXZu3k=;
 b=oIRE3KdihC7JgBt9jLbAst5RDuCea41C7NRZhfZ4H5DABr1JZm/Z/ECiQZAzcR9AI1sezbAeMozrtiwTHzO3eWNAXPHdYXPHg8jRKLhIFBXm7PXB70awB+KtCvHCI+mWy1rQZSlTVzvXh10FKSbQ4Tp7rNqqlc0J0zQ9xKW6uhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:48 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:47 +0000
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
        Michal Kubecek <mkubecek@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 net-next 12/12] net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from converted drivers
Date:   Mon, 17 Jul 2023 18:27:09 +0300
Message-Id: <20230717152709.574773-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717152709.574773-1-vladimir.oltean@nxp.com>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:803:118::24) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a7bed6-d3a6-4f44-933a-08db86da6013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3Ou4e7AUfuBqfYlhykos3XyhL1iWGjsX4Ld8oFf+kK6p2IPJENu5uorB/EQn/HHj6Pp3oE26YJWE7k3zOirzpvYQjNk5XsIpLLPE6u0BDZqNnqfZst2oIiEyzC7cQvQw+DFQGolrZv6165YTylGn5qOvAXUznrHq93wZ84vokMGeowdrAw/m9fDYv/I4xxLoJzR3UM0Owhj3d+XYciVXY25+CA0VEU0dyEB4pOvqGW33kPGxvDompi0zZo4/0MbggKbR4+hnGyZWgL8alygtYA//rLqqPdC7S0zx/aAqWbBClF0XmV6kR4RhsBfSULZBa8gAziQm6tJd6z2iuP9TGzPAtZ9zBzIfmUQsL8SUSlCgapY6Cfcxiiwu8HZ3W1++RdFZrp7sSEFxE5gDTrB8yLNn1GJe2pGjLc98iqv3QcS1PUdLAmvhfar5xvelIwH67peG8L6o/kssiM3FC5VgmYnJfMhIVktgfbSCRRSYmWRpg3xuqhigxU84RWLtNEmMrif4MtpD/20Ya1M7xEDRPk9aGRLKkI0veDZ+Vq5BXYCVVl7tnyqIW9z1iBqlM0L4X+08EjWNTL+kRdcbCwuPHEk2p1tv5FgxTAf6DfOkZ8TExQzD4+fIXSQwyTcxBuN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(316002)(6916009)(66946007)(86362001)(4326008)(38350700002)(38100700002)(6666004)(6512007)(6486002)(26005)(478600001)(8936002)(44832011)(8676002)(7416002)(2616005)(7406005)(41300700001)(66556008)(1076003)(66476007)(186003)(52116002)(6506007)(5660300002)(54906003)(83380400001)(2906002)(36756003)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?++TndgQloDDO+VZvXDe4WDj8lzPfDa9WvR9Pzi9gqu+Q6nQtvO03iOL/wOEp?=
 =?us-ascii?Q?DsxTdLOPnK8dn5iBRQOr5PTi5tijAiSabS4t65bKHsgLAw0XMssD//p4p7LO?=
 =?us-ascii?Q?33CyR9Q76kh1FQYO53A+BRY0HxqktI/FbBGTG4vvvVA7faFOY5RemCymSVVg?=
 =?us-ascii?Q?KaZY5oPGoFI1yUF8SsuA+xUbuq//TiX0Qxy2NmvtS/hDp7hussxxt3WtxaEM?=
 =?us-ascii?Q?rEO3uWIVJMipb/HmPJXGGko5MQ2lWiLqC87lDE82fXrmvdQdZhgGoKKJGSR4?=
 =?us-ascii?Q?h8/vv/5UzgLXLelV/htFhqTF3X2Hg7uI4y0gM8eMzHKIM4rbO68coXzEVJGz?=
 =?us-ascii?Q?loYBCg0qLpcZfuU753BRA5zShHfMW4CWVd3RDujdliOiAmORhzI7h3vLnlP/?=
 =?us-ascii?Q?sFKVQB47T4en4v2/O5uvwj23WJLC52NdwyNNddSG7b/bi22Q7y4yAjEonw1N?=
 =?us-ascii?Q?zTVoB0IziANCZEQoRvFgZkH0QS4PvMT2shqjbuzhAY7H+OYO0BFeYj2ORBR2?=
 =?us-ascii?Q?107IIe7A0pPEzLwDOUIYbFIilavq6+tCLTSbxFGTV7uiczxXMHkgVIhi9ZSH?=
 =?us-ascii?Q?ENY51dk9vDaTYparL/NUuPECgPMRKRghsHl5MTcNuQiyVRTo5QDCXz0DB63p?=
 =?us-ascii?Q?WXmtQSA+ALr74227onwJTy3tJqHWxMxLu2fXAqZnitjAkg8eUIsC69HdFpUR?=
 =?us-ascii?Q?xE7cr9RMxy5xCECM43XUEdRsjnOe4KXf4mzPRqyK9vPLIT/d4rjpkP2bdMjj?=
 =?us-ascii?Q?jUd5yEhZW2TMNBC+hWwzEhd0H5yFIcgoZiqle1uWM97FxWE3V7ttAjrO2ErV?=
 =?us-ascii?Q?khhBny79z9hLJEy6o4hky4gxtHKX1pbKzx/+XcspXUfsT95j60m4A8lyFG4P?=
 =?us-ascii?Q?DgGQtJMuBDkC6Ae2PDAsPY9DQSxg710MWVymUH6FpJFkns3tJfjMrV2tWyva?=
 =?us-ascii?Q?dPPHIYkAdUvo4DmVOTJye+c1G278g9MUeG46raBBbzLBV/ONhmVQlpwxoQts?=
 =?us-ascii?Q?P89RU02RfPZP/AST6Nywv+vcw7MNLPI0ttEQY3hnbmkBv5s70HvKnO73nKkR?=
 =?us-ascii?Q?kP+RShHW4v7yeWabh57uhvqbuoRSnassYJ6Sp+UcKIcvvzu5M76hzpQZy+Fv?=
 =?us-ascii?Q?TUKuX1k0Efdjj3XK71Uh/Vjyp7rhwNLmGr5hHdAQ43u2Wfhtxd4FSXui3JiN?=
 =?us-ascii?Q?Hf5KeF5iAoP1jjA7lzTy2AJDt9JKU2daYHLnviPSxJkFBYvcMAIVyrwBKYEo?=
 =?us-ascii?Q?s4l5pTV+SFuo4Bv1XgNQeNB8iPs0AJQhEV8kDr59ZagOKxKffqM0JBa5qIfc?=
 =?us-ascii?Q?sg7vye/ijEuEHqyotpiXs0VVyt1fFB0z8iogsyLZyutm+zEsRQGnfFisdn4T?=
 =?us-ascii?Q?d3diKRXRM5H+rpYtPT/CmnJNXPneanF33gZWHqWzW/jqUp2Kk7we0O05owE/?=
 =?us-ascii?Q?nJzsQIgnSZWZ/HD9HdJYM6tXVsbreXxR0K0xZReR0I3nApE9r3Jd8NeIHExo?=
 =?us-ascii?Q?NkIUsuY1nwTiQCLIJJed7mNbuZlfeNOCOfEM1LxlSVGhjNdldnsIAEbGROlQ?=
 =?us-ascii?Q?zM3o4Qj4VvLNP6rarawxcTBEzhDEMnKrFQkpER+UqAtFKLrEqP3QZAqnjvj5?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a7bed6-d3a6-4f44-933a-08db86da6013
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:47.8075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzHL8muEAA0Hr9AM1kJDg3jV8DYo8oz3LtE+onjPn3k+hGQI979jImOsJwtaNGJsxNznlwdYi4jZv/4j9U3L5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
Changes in v8:
- Replace direct phy_mii_ioctl() calls with indirect phy_hwtstamp_get()
  and phy_hwtstamp_set() stubs.
- Add missing kerneldoc for kernel_hwtstamp_config :: source.
Changes in v7:
- Patch is new

 drivers/net/ethernet/freescale/fec_main.c     |  8 --
 .../ethernet/microchip/lan966x/lan966x_main.c | 25 ++---
 .../ethernet/microchip/sparx5/sparx5_netdev.c |  6 --
 include/linux/net_tstamp.h                    | 16 ++++
 include/linux/netdevice.h                     |  4 +
 net/core/dev_ioctl.c                          | 91 +++++++++++++++++--
 6 files changed, 117 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 28c5f8f8106d..c66864f9d9ee 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3904,10 +3904,6 @@ static int fec_hwtstamp_get(struct net_device *ndev,
 			    struct kernel_hwtstamp_config *config)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct phy_device *phydev = ndev->phydev;
-
-	if (phy_has_hwtstamp(phydev))
-		return phy_mii_ioctl(phydev, config->ifr, SIOCGHWTSTAMP);
 
 	if (!fep->bufdesc_ex)
 		return -EOPNOTSUPP;
@@ -3922,10 +3918,6 @@ static int fec_hwtstamp_set(struct net_device *ndev,
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
index b0f614fbc5db..ef23153a48f1 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -454,9 +454,6 @@ static int lan966x_port_hwtstamp_get(struct net_device *dev,
 {
 	struct lan966x_port *port = netdev_priv(dev);
 
-	if (phy_has_hwtstamp(dev->phydev))
-		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCGHWTSTAMP);
-
 	if (!port->lan966x->ptp)
 		return -EOPNOTSUPP;
 
@@ -472,21 +469,26 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
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
@@ -814,6 +816,7 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 			 NETIF_F_HW_VLAN_STAG_TX |
 			 NETIF_F_HW_TC;
 	dev->hw_features |= NETIF_F_HW_TC;
+	dev->priv_flags |= IFF_SEE_ALL_HWTSTAMP_REQUESTS;
 	dev->needed_headroom = IFH_LEN_BYTES;
 
 	eth_hw_addr_gen(dev, lan966x->base_mac, p + 1);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index e01d3b1e17e0..705a004b324f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -216,9 +216,6 @@ static int sparx5_port_hwtstamp_get(struct net_device *dev,
 	struct sparx5_port *sparx5_port = netdev_priv(dev);
 	struct sparx5 *sparx5 = sparx5_port->sparx5;
 
-	if (phy_has_hwtstamp(dev->phydev))
-		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCGHWTSTAMP);
-
 	if (!sparx5->ptp)
 		return -EOPNOTSUPP;
 
@@ -234,9 +231,6 @@ static int sparx5_port_hwtstamp_set(struct net_device *dev,
 	struct sparx5_port *sparx5_port = netdev_priv(dev);
 	struct sparx5 *sparx5 = sparx5_port->sparx5;
 
-	if (phy_has_hwtstamp(dev->phydev))
-		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCSHWTSTAMP);
-
 	if (!sparx5->ptp)
 		return -EOPNOTSUPP;
 
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 03e922814851..eb01c37e71e0 100644
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
@@ -15,6 +20,8 @@
  *	a legacy implementation of a lower driver
  * @copied_to_user: request was passed to a legacy implementation which already
  *	copied the ioctl request back to user space
+ * @source: indication whether timestamps should come from the netdev or from
+ *	an attached phylib PHY
  *
  * Prefer using this structure for in-kernel processing of hardware
  * timestamping configuration, over the inextensible struct hwtstamp_config
@@ -26,6 +33,7 @@ struct kernel_hwtstamp_config {
 	int rx_filter;
 	struct ifreq *ifr;
 	bool copied_to_user;
+	enum hwtstamp_source source;
 };
 
 static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
@@ -44,4 +52,12 @@ static inline void hwtstamp_config_from_kernel(struct hwtstamp_config *cfg,
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
index d0223ecd6f6f..72e077022348 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -5,6 +5,7 @@
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
 #include <linux/net_tstamp.h>
+#include <linux/phylib_stubs.h>
 #include <linux/wireless.h>
 #include <linux/if_bridge.h>
 #include <net/dsa_stubs.h>
@@ -252,6 +253,30 @@ static int dev_eth_ioctl(struct net_device *dev,
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
+		return phy_hwtstamp_get(dev->phydev, cfg);
+
+	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
+}
+
 static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -266,7 +291,7 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 		return -ENODEV;
 
 	kernel_cfg.ifr = ifr;
-	err = ops->ndo_hwtstamp_get(dev, &kernel_cfg);
+	err = dev_get_hwtstamp_phylib(dev, &kernel_cfg);
 	if (err)
 		return err;
 
@@ -283,6 +308,59 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
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
+		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
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
@@ -314,12 +392,9 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
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
@@ -362,7 +437,7 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 		return -ENODEV;
 
 	if (ops->ndo_hwtstamp_get)
-		return ops->ndo_hwtstamp_get(dev, kernel_cfg);
+		return dev_get_hwtstamp_phylib(dev, kernel_cfg);
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
@@ -379,7 +454,7 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 		return -ENODEV;
 
 	if (ops->ndo_hwtstamp_set)
-		return ops->ndo_hwtstamp_set(dev, kernel_cfg, extack);
+		return dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
-- 
2.34.1

