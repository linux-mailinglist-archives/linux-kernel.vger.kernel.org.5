Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF5756801
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGQP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjGQP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BBC10DD;
        Mon, 17 Jul 2023 08:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O03xGqhpvLZhOkyPM0bBiwgt44x9z3zEKmI9v8cKh7QVuBfLWPIUt1K7tKm2AERUILLkgkB8G+FdbEq0LAmYowh9JFQuwHEZzeiVEvK33SbrHShEIO++BoRvsLkDnk7N65GG1I61StGxnN5+rmqgecP9H/4o2BXPPV6zQT1G5xfLzEcWCteSw1uzq/EHiRr4SG1Wz7UvQStkviEHvAUyz3uE2mw4bw0mLp8CFnXPXqzNOvSSzxjXZUFs1pxX5D4cE2NHkAg2ENArdOh7YO2kkLRtQSyi5lZfOVEV3TmEExvwCE44gRcq8WTTb2enDl6mHgMdaZz1GjJ7wYcaaN0xUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUtSGkapv7OUjcIv8IKaB+k5i8nfs7VHcZWEItKQ6/c=;
 b=JdevS0XXrH3ML4QWFrzj/NxMOtUEQloILfZYCne1c4NPRDPC1Pyj8eZCbEWGU7vE2sZsvlKOcGnFOzVvc4SOOqmhk+AOXNiHwT/HL4lY847/XseyEml4P8h8gyaCPbRI+PNSeI6IA888eoigwNjbHbRRFXfvvytdlmTCeCaMSXY5c6Qli7nlpmOZUoU1W+9AfbVanFugqiF1/REqDwmgYTT+8dEX/UMzExDqD3K+OyyaF3JgrbwZCHQNuJRvE97AbEJQ2e0HPscL8JQ7IzOzHg4/Mzv+JKr/M9F7sGne3h/Tb/aUmIhXsL0P0cMVgzlbUd3NAIwpAd22mG6Gi9lx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUtSGkapv7OUjcIv8IKaB+k5i8nfs7VHcZWEItKQ6/c=;
 b=iTaG05ZOBDudjkPkz4GyLJdWoyDK/2EqNCv+RdiWldci3Zv/mfHXcVkI6Yy0/7VUyApQxtgFPUcPlSjgecx9pUKWF77ODrNGadw2N1+cJw0q3Mus0cAyrKZECiu5gpomgEkKk+mCAMoun6iC5TTtGTpHx/2TNECFD96ksOnT8uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:41 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:41 +0000
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
Subject: [PATCH v8 net-next 09/12] net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Mon, 17 Jul 2023 18:27:06 +0300
Message-Id: <20230717152709.574773-10-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 744c6b5b-5794-458b-5378-08db86da5c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEfZGwZfll5NHXNMrV4OiE1lXvUPDu8+MT4TTnVlYDxb5lQzDQHt/SYMNmD1Xy4oFLlxbIag7Ceh4JkX668uCsD7xmxe9A4DxJUyPgnsRVVHb+UIS6n25BCnYcf/UBGCmFuqK6trC+rrQWX687qWF/jDf05P4Vr3q4npVA0JAQC4yDW2s4V+u/TqhNRCngqLP9dxpR2/7JxPxbkcsdJ4sxBMPf0jjCPpZkFEKYRrCiMrRLPjmLu8scQew/XUtJXW2NB9i2UW3hiGPYBzUJYFYfp8w6fwNiw308nl1DhvXybL+uQ7RNA3W2oO6TSZ/XWwlzMADC0NbRUqz0FToj+OukHyvKry23cWLP/GY6mVZzFXX+POaBwCF2ioulQWxikeD4l0kEbCxwHwv/I25szhokSOOWitvreTWwAPd6fC/ZrCuYl7V6ee1H1BW3BtZw7Sb+REhs6iov/htMVeZbQPJcs2lDrxKjjmXfJlRMfKvgJBwV95CtS8ZWxx0ycPsErOBafHrzHUhBTt9kdNN9FrHw02DZAygXX98L0GRuGitYSdFXWKcMk2dDzWoTLPy9F1H8ZQJiIauhtsZprOv51cA2EQfxu4P1iIPFJA4dpQJSN6UnJZu4anziq+u9EKWIuy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0PmKMffhpfpuV0cmRZohLDTMY3T6yEhQLxuTCA9qWAb8gEqRoaJSTRqunHP?=
 =?us-ascii?Q?U/uefAZlE4H0rtPNfG2dhn0ULHnn2pBtFyEGnY3SRpF9WtEXpuRY0/CLlUWG?=
 =?us-ascii?Q?aFQS98NW3WkC2Sljr43ADAFcGh9KQbzo+TzuN5jJbzSXRsst5FFQcUddRWEb?=
 =?us-ascii?Q?GrtNpeo0Ri+PeYNjtzm0mdiUrFwRfUh+2wtxWoBlifw4/6zelWfcVMa7OL5p?=
 =?us-ascii?Q?tCAEFsSqlmKRzCEU/7mo+T9ETqqnTjOGmSUUOJw2oWQeZ4yqk9GY4hHH7Z/j?=
 =?us-ascii?Q?SC4qEfmomqPQ7Xu72UdHeHQ+i+nBgCkKw9y0+bstrx8oveaSnY+azJWbEz84?=
 =?us-ascii?Q?fX6QOsBqlQZwn3xhmHJMtBziHcMRGGjMlVzqgNjVnuy8qYUmsOTPDnw56gIW?=
 =?us-ascii?Q?Dge3rkCxFXqQPEUOclgh4RWwAVzBjAfR3dj8dGvaDmw55g9JNxt7KfIypPs0?=
 =?us-ascii?Q?f3O9EIF/ODfnIM4avm052q08OfxhxrtYg8vnHxFj9GVvtzvu1BZBeY4g3A5l?=
 =?us-ascii?Q?G4Ew6YeLj9kzsV+FLlyVug2ZZlYGXHAW/Hk8rOI9CkDfxvn3FT0cyEekcpyl?=
 =?us-ascii?Q?hrZYqOC8BW4I39R2AleSn/ZHyrHQdDl+UwjWUQ3/5g5HpFMNBDnz62NUMXH6?=
 =?us-ascii?Q?Xa9LVyf3FEmctvM3/ijo2pBAupE36kQgLIWNOeU/QGH0gt+dt91RNP/F5Zkn?=
 =?us-ascii?Q?3WVj3tfF2TwdhGMeu6MZnyHv3L6Qy4iA39qAq6Smx94wIW+FATLDrms21KhJ?=
 =?us-ascii?Q?ftdZE1G6QpIpF+YgSyEFb8+SDkmSEnBfo+27TbFpEsnBoaQJMiea+VInlpS1?=
 =?us-ascii?Q?KuQZVpkgRpHJRTrtAIXUA7jFt9ekZNu4dDsv1Y9uQaWB9+T1lrSDTWhKHALl?=
 =?us-ascii?Q?rjvh/AShy7yQwJfdK6l2NQNx/aQlFmvPPTTf3CPxvMfJGydK/jJ2CP7AfSK7?=
 =?us-ascii?Q?JSUB1LXCZpYTKvPxBIIu2aN+ekSve+FWOQsHBDxm0msoyWVbWsFEdBBTfA/1?=
 =?us-ascii?Q?XnLI2jGkqtweJdUEb9DNH2jNdNZFUoWA+1CbdTihGtoGlxGyedwMI9QV0b2M?=
 =?us-ascii?Q?b5MaVDUUDIFH4+F0IrX3zsby8QPdUVzIw0CWGZmBz364mc8YzuLQdgoVtSt2?=
 =?us-ascii?Q?YHhcwmehqXZVqj7guML+heMl9xDu6OWt+n4JiaCnq7xGkzvyBakzpPGtrwe1?=
 =?us-ascii?Q?bLJM7XeeRgEmJKzL97sQhW2pAxp/mstXeyTz9KycK/u/4w8qgFdZwtMa211D?=
 =?us-ascii?Q?XS3ST3BQRdld7CcxSHkCFlFN320clsp1XKl1TOp7s0CfHDJvw8Bt/UtED2Rn?=
 =?us-ascii?Q?XpeRbpgI3GdvQY8XuF7ka1ClHQ0K3/Pm4u+bS2TaL9f+Z5UIOe4QKSTNkwXW?=
 =?us-ascii?Q?hgp0lLWYaYYbhBuhjBqXLr+UnKxBX1c8EOfT5EbT+knabxjw0f5l0KjKmBN3?=
 =?us-ascii?Q?LrSBv/n7qHiyhxI4TkVVVQToRk9ocGbAw5Z7xUx42CzEVMTcCt91f5f8RVeB?=
 =?us-ascii?Q?0qUfpIndwdJlFcKGWozxU8S/uITv+0zol6XbpOfqp0JHCEkYCC4uBsiWdNcv?=
 =?us-ascii?Q?Fib2XicB0s0qF1PiBB0Ukoa40laeqSXdiCs94IaJWqBMaOkCoXMj2XWtbVzB?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744c6b5b-5794-458b-5378-08db86da5c7b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:41.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEd4qtEQ7MwGZDBW1S08zRN6x+IMiolB71WEogLsgsPUl4CqInIZqHzNVuGipYGnejLEO71wsvkElGMaBHyv4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware timestamping through ndo_eth_ioctl() is going away.
Convert the lan966x driver to the new API before that can be removed.

After removing the timestamping logic from lan966x_port_ioctl(), the
rest is equivalent to phy_do_ioctl().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
Changes in v8:
- Use phy_do_ioctl()
Changes in v7:
- Patch is new

 .../ethernet/microchip/lan966x/lan966x_main.c | 59 +++++++++++--------
 .../ethernet/microchip/lan966x/lan966x_main.h | 12 ++--
 .../ethernet/microchip/lan966x/lan966x_ptp.c  | 34 +++++------
 3 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index fbb0bb4594cd..b0f614fbc5db 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -449,39 +449,44 @@ static int lan966x_port_get_parent_id(struct net_device *dev,
 	return 0;
 }
 
-static int lan966x_port_ioctl(struct net_device *dev, struct ifreq *ifr,
-			      int cmd)
+static int lan966x_port_hwtstamp_get(struct net_device *dev,
+				     struct kernel_hwtstamp_config *cfg)
 {
 	struct lan966x_port *port = netdev_priv(dev);
-	int err;
 
-	if (cmd == SIOCSHWTSTAMP) {
-		err = lan966x_ptp_setup_traps(port, ifr);
-		if (err)
-			return err;
-	}
+	if (phy_has_hwtstamp(dev->phydev))
+		return phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCGHWTSTAMP);
 
-	if (!phy_has_hwtstamp(dev->phydev) && port->lan966x->ptp) {
-		switch (cmd) {
-		case SIOCSHWTSTAMP:
-			err = lan966x_ptp_hwtstamp_set(port, ifr);
-			if (err)
-				lan966x_ptp_del_traps(port);
+	if (!port->lan966x->ptp)
+		return -EOPNOTSUPP;
 
-			return err;
-		case SIOCGHWTSTAMP:
-			return lan966x_ptp_hwtstamp_get(port, ifr);
-		}
-	}
+	lan966x_ptp_hwtstamp_get(port, cfg);
 
-	if (!dev->phydev)
-		return -ENODEV;
+	return 0;
+}
 
-	err = phy_mii_ioctl(dev->phydev, ifr, cmd);
-	if (err && cmd == SIOCSHWTSTAMP)
-		lan966x_ptp_del_traps(port);
+static int lan966x_port_hwtstamp_set(struct net_device *dev,
+				     struct kernel_hwtstamp_config *cfg,
+				     struct netlink_ext_ack *extack)
+{
+	struct lan966x_port *port = netdev_priv(dev);
+	int err;
 
-	return err;
+	err = lan966x_ptp_setup_traps(port, cfg);
+	if (err)
+		return err;
+
+	if (phy_has_hwtstamp(dev->phydev)) {
+		err = phy_mii_ioctl(dev->phydev, cfg->ifr, SIOCSHWTSTAMP);
+		if (err)
+			lan966x_ptp_del_traps(port);
+		return err;
+	}
+
+	if (!port->lan966x->ptp)
+		return -EOPNOTSUPP;
+
+	return lan966x_ptp_hwtstamp_set(port, cfg, extack);
 }
 
 static const struct net_device_ops lan966x_port_netdev_ops = {
@@ -494,10 +499,12 @@ static const struct net_device_ops lan966x_port_netdev_ops = {
 	.ndo_get_stats64		= lan966x_stats_get,
 	.ndo_set_mac_address		= lan966x_port_set_mac_address,
 	.ndo_get_port_parent_id		= lan966x_port_get_parent_id,
-	.ndo_eth_ioctl			= lan966x_port_ioctl,
+	.ndo_eth_ioctl			= phy_do_ioctl,
 	.ndo_setup_tc			= lan966x_tc_setup,
 	.ndo_bpf			= lan966x_xdp,
 	.ndo_xdp_xmit			= lan966x_xdp_xmit,
+	.ndo_hwtstamp_get		= lan966x_port_hwtstamp_get,
+	.ndo_hwtstamp_set		= lan966x_port_hwtstamp_set,
 };
 
 bool lan966x_netdevice_check(const struct net_device *dev)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 27f272831ea5..b538d496e8d7 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -298,7 +298,7 @@ struct lan966x_phc {
 	struct ptp_clock *clock;
 	struct ptp_clock_info info;
 	struct ptp_pin_desc pins[LAN966X_PHC_PINS_NUM];
-	struct hwtstamp_config hwtstamp_config;
+	struct kernel_hwtstamp_config hwtstamp_config;
 	struct lan966x *lan966x;
 	u8 index;
 };
@@ -578,8 +578,11 @@ void lan966x_mdb_restore_entries(struct lan966x *lan966x);
 
 int lan966x_ptp_init(struct lan966x *lan966x);
 void lan966x_ptp_deinit(struct lan966x *lan966x);
-int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr);
-int lan966x_ptp_hwtstamp_get(struct lan966x_port *port, struct ifreq *ifr);
+int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack);
+void lan966x_ptp_hwtstamp_get(struct lan966x_port *port,
+			      struct kernel_hwtstamp_config *cfg);
 void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
 			  u64 src_port, u64 timestamp);
 int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
@@ -590,7 +593,8 @@ irqreturn_t lan966x_ptp_irq_handler(int irq, void *args);
 irqreturn_t lan966x_ptp_ext_irq_handler(int irq, void *args);
 u32 lan966x_ptp_get_period_ps(void);
 int lan966x_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts);
-int lan966x_ptp_setup_traps(struct lan966x_port *port, struct ifreq *ifr);
+int lan966x_ptp_setup_traps(struct lan966x_port *port,
+			    struct kernel_hwtstamp_config *cfg);
 int lan966x_ptp_del_traps(struct lan966x_port *port);
 
 int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 266a21a2d124..60bd0cff6677 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -248,29 +248,23 @@ int lan966x_ptp_del_traps(struct lan966x_port *port)
 	return err;
 }
 
-int lan966x_ptp_setup_traps(struct lan966x_port *port, struct ifreq *ifr)
+int lan966x_ptp_setup_traps(struct lan966x_port *port,
+			    struct kernel_hwtstamp_config *cfg)
 {
-	struct hwtstamp_config cfg;
-
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
-
-	if (cfg.rx_filter == HWTSTAMP_FILTER_NONE)
+	if (cfg->rx_filter == HWTSTAMP_FILTER_NONE)
 		return lan966x_ptp_del_traps(port);
 	else
 		return lan966x_ptp_add_traps(port);
 }
 
-int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr)
+int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack)
 {
 	struct lan966x *lan966x = port->lan966x;
-	struct hwtstamp_config cfg;
 	struct lan966x_phc *phc;
 
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
-
-	switch (cfg.tx_type) {
+	switch (cfg->tx_type) {
 	case HWTSTAMP_TX_ON:
 		port->ptp_tx_cmd = IFH_REW_OP_TWO_STEP_PTP;
 		break;
@@ -284,7 +278,7 @@ int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (cfg.rx_filter) {
+	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		port->ptp_rx_cmd = false;
 		break;
@@ -303,7 +297,7 @@ int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
 		port->ptp_rx_cmd = true;
-		cfg.rx_filter = HWTSTAMP_FILTER_ALL;
+		cfg->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
@@ -312,20 +306,20 @@ int lan966x_ptp_hwtstamp_set(struct lan966x_port *port, struct ifreq *ifr)
 	/* Commit back the result & save it */
 	mutex_lock(&lan966x->ptp_lock);
 	phc = &lan966x->phc[LAN966X_PHC_PORT];
-	memcpy(&phc->hwtstamp_config, &cfg, sizeof(cfg));
+	phc->hwtstamp_config = *cfg;
 	mutex_unlock(&lan966x->ptp_lock);
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
 }
 
-int lan966x_ptp_hwtstamp_get(struct lan966x_port *port, struct ifreq *ifr)
+void lan966x_ptp_hwtstamp_get(struct lan966x_port *port,
+			      struct kernel_hwtstamp_config *cfg)
 {
 	struct lan966x *lan966x = port->lan966x;
 	struct lan966x_phc *phc;
 
 	phc = &lan966x->phc[LAN966X_PHC_PORT];
-	return copy_to_user(ifr->ifr_data, &phc->hwtstamp_config,
-			    sizeof(phc->hwtstamp_config)) ? -EFAULT : 0;
+	*cfg = phc->hwtstamp_config;
 }
 
 static int lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb)
-- 
2.34.1

