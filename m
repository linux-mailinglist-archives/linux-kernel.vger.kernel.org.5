Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B65F76B77A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjHAObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjHAObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:31:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647903C19;
        Tue,  1 Aug 2023 07:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAcaEnlCZbOQzdtlr8i9OHTG2KCA3kGFYj/A1DGsRbaiNtZigwL6gvaqxWUC3supez1NsPchaz/vy/Qk4yr0vPpcPdCxo6uxtCCOr0YEWjtsLLP0JpzzEJxunSjW9JGAzrBaXjlD+CIZmk4wLC7+JsQn992lgNLOiQm516YvEYyZOV6XfQE+BHRE9pz1UYbOZKE/s0CcL+wUQLFgwe9EOINscZyofXxRLcGodSJ2+i3p6SKKmHN/ry6R5OCXURAcP+g9B4u95DmH6nBVbowDgepKURFrRjQJa7lXi7wA9ti4HKzkW7FZCE/oL0DTKjxtlZXs86p4COlSmVviOAeg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n64j6o4cj4g9qgaV0wW1MYChC5igOKRV6/Lh8EsK48=;
 b=LPGBQT8VQgWJ/OtbaedVkQDHVofS1R1Oe8bCXwGME5UEseFlP/ijxd724+px8f41oGuBj0IbevYrP6X9cJ3YPY6uCfpPL/LbCNugt8i/ZSvWUeUBdbqq46KIr8H1D/YM9j4pi10R7LboYRhXL3caEY9R94GG+XV/FWO5M9nkBf/mRjA2F4hiJrY+dEA+rJb34Rb68AZnPlzd/fDAqYhmjyOiWvp3of+hLQUaiqR6l/dxzDzAiPIMmqbt0fcSO+KGiQy8HO/cUDxO7CEHXW6lZZqHOJkJxipllTVoHyp7a6v3FGm7bdrcfz/r/aS0ON2VXzOr91354y2XK3983oJbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n64j6o4cj4g9qgaV0wW1MYChC5igOKRV6/Lh8EsK48=;
 b=VwHF9bR9EBz+1c7dfgmdU84gLjoBgbiUQ96yfODGUDJqx0nTYz0sbxdCeGVXG8VJSZzgO/d/EZqIZY+aYlVMR0OP7jB6ZZZgAGdqsuXvDhzTXBzY9SWjPNpIbY3rVkYY7D0lZ3cGrHYFDl4Do3SRpJf7bYujYno0FshmNKvQYLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:46 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:46 +0000
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
Subject: [PATCH v9 net-next 12/12] net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from converted drivers
Date:   Tue,  1 Aug 2023 17:28:24 +0300
Message-Id: <20230801142824.1772134-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
References: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:208:122::40) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: 6174c0f2-5956-4032-d3fa-08db929bc0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kH7yFCFORTRHs5cMy0YARXe+jeE8ktiySsfs0uZSaXJROwNnwvwL9rQBK86O44XZhIYp5/WCHPhY+RgHUbYm9FQDY5qtrC78QvcsuqaUZdefzslPy4SMwr6MWXb7atcjLZzY1fp1kLGpz+tigcN2Lx4vkz0KrxF1lr1s5AHo5DoMQGQZBfKyD28J0T/R2zWgCGDt/V1Bfwrj/Jff4SIRlJh4Y5IHIjAi7Gl7faOFfGibdJd87yDa4BXpqhe0nNIGWCQB68iljYYBDuky7lX0G6SVtOjjjbJ9EzeIho8DbgiqHt+X/cFLERj6PhCzNSkl7b/9WGFERyOauuSXf3JqEwgAcj1H78VskVo/35oC8tHvw9v6VCo8QswzaSbZ8VpicqELDlIbe5JINi2EzVkh5t1V2Te8qrxAUjA6FtKvav6F11oTxv+NIsylS9ssQHK7fglPMmll6z9PMmmDlqzAWx53u5JfhSFQ7qIemXSjnC4oSa3DcOOfgnZyGvWpnC8JKoBgW8MBp4C7S2+Qh1rM/RGRnXMmbhkGILuOcxhh4DoYACStllHRK9jTq0ZwTTYqIREUs2sOSLBIO/XdEHqFdCrxZiMEr5prV7/wafltUDsj1qu/951zcwD1QdRbUa5L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(30864003)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eFtoCavEKA8l3Txev3M0my2Ft18LSPrgaylNB4kHjA7dXtCPKb2os7+2ZGGM?=
 =?us-ascii?Q?DUZeP8daQLs8nqb5dFCt8U18xrCavPb+QqjImiJ1im0KL/ACXTGhoF4lv3mv?=
 =?us-ascii?Q?/qrDIpwUhDLNI7J51MR9IA0WyziVSeMUyl/GSaPR7CW3Ewgwy0C04Ao88LbY?=
 =?us-ascii?Q?TZRavHKZV3whR4q2Zn301JxdMCl+2esDP/SHTxwL9PiwDdr/M5uf3sSVIx8f?=
 =?us-ascii?Q?BtTyHL54rJt/TGHIW3Ph+lOXvnS86GYEEIpzlzI0lwxA7Lq2KVjubyBZP3TQ?=
 =?us-ascii?Q?/d3xs11vBeM6+9XI9h0Gb7IeyTPqjRhOeo633rAntYoi5tTMqvz4SgrR+NDP?=
 =?us-ascii?Q?cbfGOwhf+8ldEb7DQmkKCX4Qmlh8AdzoIENownRJhsaSC5+vOJM6nrfM2xNV?=
 =?us-ascii?Q?cGW/WP5u55F3GFZVXq5KtcY6cS0xZzxr2VhoTZkEmM5ggNJRRfR09614mMDs?=
 =?us-ascii?Q?AuDE8JRv4ZKL5CAffIeVlqRXvfhVMeDSr+6lxkUZT5ixdJZFPnsPR205tQ7Y?=
 =?us-ascii?Q?Rg+RvMZj4l4YJTLqnT0V74HWjZicKmXbD9cwsWZGyABi9ny2UTazLQ3sokC0?=
 =?us-ascii?Q?hVDkIkY5NKg7QRbIlrC7RqA02xvMkPYUV443D8mZpJVcDsCoPEEqnP1QPAGZ?=
 =?us-ascii?Q?MG26yPoIdejv+GUI+hEmmY7TQeaQz0e88MtOAz1pMjvMJkbamMbAXPiKeLwN?=
 =?us-ascii?Q?jTQMaCRqOQN1luV5izxjFlGibP+1DZpPaLPme12NAjGtIKqCzOTV/+sg1zUb?=
 =?us-ascii?Q?9O+/763Bffcyx7jMoxLMM2gyVJbSO7L7nelqXxNqDKenKqetclrC3y7zcj+m?=
 =?us-ascii?Q?2aC4783djoZzSthaXb8oxSgxby4Yn+7hMYRq5CG6p95khpaFQlSrESfFOwrw?=
 =?us-ascii?Q?OzXzgqQl64yn1YGmmBAgxN0KwYtPFUcF/dMAJXTMuonUTo4ARFtJ5o2SmA+x?=
 =?us-ascii?Q?c/nI8fMhv/yiUzQ6twHLytyFsKkdISLeRSVUkk6oQqqWLJPTf3QwgP13yebw?=
 =?us-ascii?Q?wfISMC0iYExXi3CNvkTnPXYLh7aqvEpWWR2gJDEACRb4uNa+CpLMdbF3C98A?=
 =?us-ascii?Q?USYLTCkWVaSUqLLURIl0HS63OVDgvnvSp99mxke7QT/GgBEqLGMQDxgkKlxp?=
 =?us-ascii?Q?zzrTvlY79p90kvA/3dUJsRoGmAQF1uCgIh2ezU125KkCcWvkTqsf+YpL86R3?=
 =?us-ascii?Q?IvOnTZ5dnolwl39JRMiWprHAAFSqyuDt3MsDGzIRlO2tPZvHkYRuYqj4m44m?=
 =?us-ascii?Q?s+75u4Ak89nsoYg+EnKkssfIZqVeHU2zGdbHbYAbHKlTJQckpclZc54ZcEu5?=
 =?us-ascii?Q?qpuljSsRZ+rTvfN4mroIAqhc8b5run1O+4si1FRk9JmMxlDaawggknJgKBeT?=
 =?us-ascii?Q?VW0hb528e2lhD57/Fl8PXYbi7yvjGQ4WNHeZRwuxeIq4NE1SYAraOehpEK4+?=
 =?us-ascii?Q?xINJu0IDqGhc70mkUgZ1FX29PUzoVz8uVXx65tCw1PlUWsVS4BbzdgQgDzs4?=
 =?us-ascii?Q?1kZRnPAZtqkgMWGu58361y/5J6P+0BKxrYWGzvymLmv4DYX6tSqJkH9vw0Jm?=
 =?us-ascii?Q?nKJZeuOA0g6W5rPPrJp/wrcFYTOFyiCnWXgoReGAtWwo8EO+xatCypNkut92?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6174c0f2-5956-4032-d3fa-08db929bc0fe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:46.0566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+AeaIDz2V5voq0/Q5xztZ7k0rrx34vc3rvdRsfIze+tRTrIVFfiWM59al8JYXt+w1elPMQFwAlpaNzFk5jKig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v9:
- None
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
index 6d81fff0227e..43f14cec91e9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3872,10 +3872,6 @@ static int fec_hwtstamp_get(struct net_device *ndev,
 			    struct kernel_hwtstamp_config *config)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct phy_device *phydev = ndev->phydev;
-
-	if (phy_has_hwtstamp(phydev))
-		return phy_mii_ioctl(phydev, config->ifr, SIOCGHWTSTAMP);
 
 	if (!netif_running(ndev))
 		return -EINVAL;
@@ -3893,10 +3889,6 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 			    struct netlink_ext_ack *extack)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct phy_device *phydev = ndev->phydev;
-
-	if (phy_has_hwtstamp(phydev))
-		return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
 
 	if (!netif_running(ndev))
 		return -EINVAL;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 1baa94a98fe3..4a1acc7234f6 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -455,9 +455,6 @@ static int lan966x_port_hwtstamp_get(struct net_device *dev,
 {
 	struct lan966x_port *port = netdev_priv(dev);
 
-	if (phy_has_hwtstamp(dev->phydev))
-		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCGHWTSTAMP);
-
 	if (!port->lan966x->ptp)
 		return -EOPNOTSUPP;
 
@@ -473,21 +470,26 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
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
@@ -815,6 +817,7 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
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
index 23e335f245cf..85d594460c66 100644
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

