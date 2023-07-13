Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9F752122
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjGMMUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjGMMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:20:20 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C33D2121;
        Thu, 13 Jul 2023 05:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa8e3MPvvtyP0rCmUd0Nwcurk4okdRx74089kDJ/x7SXABH8Eh0XrVt2XOjT1mf7iSTfW2VsFN1G7gPiJNnEwStVeqebkgEVnvgaQrQq6ubwdmX4dnttm4YTHEXbvO+nrpWwh9qQHOM3kUFjEVvWkD+MfWuYoiweCUmJwDpeejAtgMyMhVPHMlMnG0iMWy816E4dLDOnomXFfTfjFDdQJcM4xRLe5iok54R1ajKZe9LF4WvKNsfAAxD/76uXkqJoBiFb+JvsG6rhObqtONy7aQOPA6xZv1uyZ3S4ypQrK6xVYaMduElQeC6goneojkHSeix3v0vbTo0tssiVZOcfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08+LrpSnI8/cBjjmyEuc2nNng6d3fOw9tSpootjuokM=;
 b=RHF98BPEIonmTQATODTS5uju/bef+IEs0lGgl+5SBH4Z5EKuL9ENN7Jpx83mpuCUDiMECe5aNNsKnr4QFu5sY1yKpTWoKsL/vKNs3nOyWHhwJsbgphOSSW92SiZy31HhcZx3rn9eVBArpoMo7Tzg7/fTq/1MVN96DLfwtJGVevFj3eTWUbXmqlwUC5szoYaabRunmiQS9LPuW/gBs3cNunpnmpG6hXhVHaszfaLekjnMUHG4TjvILVhB9WmlraRjcc4upVIToLTkAS8ITPXCpuKQAgCDamJbFFg51b/pdzeg5HWg+mxJHk9Wbseum1qbktBaDvLBD1mNXrSv4VuCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08+LrpSnI8/cBjjmyEuc2nNng6d3fOw9tSpootjuokM=;
 b=Ed82wVlP8Cl7wbn+mLI6eq8uZ0J4WUz6IRYzvC6NBTnpl4sgHsLGRxZ6EoXcTX6NyadFGByYe9ofVl5I2o4sJAQNb/jKqX6SQrj4kI9B0r+ogMWmYPylnyAa4W0zVuzqLhkXqFMEX9SxD4bF0jRvSkQnC26ghbKJJQN4TrEX82s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:45 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:45 +0000
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
Subject: [PATCH v7 net-next 09/10] net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Thu, 13 Jul 2023 15:19:06 +0300
Message-Id: <20230713121907.3249291-10-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4c598c5-4dfc-4671-bcd1-08db839b7190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGJghodX4DvzFnQGUdKQuCuABFbU5ZZmkAnSsKoX5sKYaZxlr4Kf1ZcFjTUQbxxScPe04ZJj6BUe4ieOYuWObyBvgnxmB0wkBn9/G876Y+TLNepXp+i5r6lrgyXtZ+MlmsgzIwl52SwVD0YxTwOQ2GboGLzic5va1JCsVLr/RDWsNWkWsXru6nSQf7GJu6v+8sobewvdDnvuZk5mM+UpOZZ1lcnR0kcCGPhvfNfiSBgTJdCsoTjjYGLlAk1FF8vznIwcjOkeSQBxsXmo+2IOF2gTpPOrMl1LsF8YkuUSbnvy6d42nN7M9n0QRiv/MFp4t9Am3NkNPt3jdGsBvPPfqC42zMv+/WdpXxeHe3K3QfGRUVZ3Q8EWsO0IjXMYbo9zQYCElvQnprJ/D0ViszIn6Thm9jzn9DEci8nl81tuj+zKthRiWijr5khN8lWdBbS52+wQ72MCgUlAYyHyot5ucAc28VMcQmgYXFhljkDZHWReVgCzXbgz7kZjkWWpN4ClLYXaRSz25wZepuRcVZq+fwNrGFlakn6prpNGXpCf9XH4uhju4mPpWlDB2jZValQ1aErjH6JtX/zP1w4hLwh2yTRQzlSN3fgF66ZXTsUKpBtPyDSwjr/HsSwUx0FEg7Tq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SPcBQ0WabC0TUfQGtnmyh21ie19lfqCGv4HwJDyXID6P+HEZZUQcuU09/G+7?=
 =?us-ascii?Q?23EEtFXU3VOs80sHGPmbxYaqIBhlFkSVsr5SJ2AN9etWBlQKxgpaL32Jh91X?=
 =?us-ascii?Q?yrpuFKEVTUYys5pP+q1yzZfND5AgH+DZTNEBt4UXMXDgZrAvjlaoKQFmAG+D?=
 =?us-ascii?Q?73WMtf9g5jP9tlC75jH1Ox1NxdmJbCs98ZHdRHTGwZpycD+VCYwyxwO/CO+q?=
 =?us-ascii?Q?Tiq/02gJSJuS/cZIyg4A2kxJ6oYUyy5bdit/OgcEfbivnTv72x9wWzlv5lIL?=
 =?us-ascii?Q?8xR0HSZt+7xEskf0xSNyFB7HXHwRuQSExmI4mUQ7D+SdnS+emvZNkitF74+q?=
 =?us-ascii?Q?PynrqfvllKHfzwV0EDFRb1BCIjXt89KH8Kq1rxCI2P+kJfCwiz8xCngq+mh2?=
 =?us-ascii?Q?SS7ykGshd9rWsBCxGTWCM/Wdm5R5dWOtFnf3C6QbbamhlNSlDPruEuaVctOX?=
 =?us-ascii?Q?fe69X+lmYpE14BG+nTzWkmWkdcEUsx1KJw5kkFlkI0lkjXdJDsGezUfSw3Ur?=
 =?us-ascii?Q?IWyrBS2UVrMzBhck9IS612Ye82skYSFKt/e177sdo+wRzJ/ntoA7APvqeA+r?=
 =?us-ascii?Q?kXYG+CIkfkmSVc02FdNkQgb9T0a/1PC+UgMCimb/iQzF5TIZviZqRqhDLy6/?=
 =?us-ascii?Q?0qmPAi4ODHGJTDQAFapbQvlYCZczDSja0Do5NF/eqW6GR8xJoJTwWLNwXQGz?=
 =?us-ascii?Q?0tEjUyITOgLVZFBynFl8J5Utsxa+/UxT7JsAt1md/eEkqvIGNYVjBBX40eob?=
 =?us-ascii?Q?P98e9luZl882rJjnqzcMLl1U7eWE66c4S3WVlOK8+LEBkUqDnXKNXJROtPhK?=
 =?us-ascii?Q?oQ5Nnzj+QLU/zURDBynsgVrg8xXDIJnrBYjhQNjNrDlwssMWnFV6aoT0V5yA?=
 =?us-ascii?Q?y/hia2iRJp/3qjrwCk3m5zIxMh2NBR/etgplTuSadFWBsbkD72/UAy1yt09r?=
 =?us-ascii?Q?Ssy5hcEuCLsf5i6WjG0kSRnvw/bUhAxMuCf5vet/mehRVDiOW8GEik2sX7Gq?=
 =?us-ascii?Q?je3vpl4zpD+WQbFzxFHMyiMtnCbYlSXkLvTadnAp1iRTfK37kIlBmgxLtZQZ?=
 =?us-ascii?Q?cp881zk328BQ47+MQ30tRfaplONRUV9+7KGRvFwtGIRBK0OgEgrCn+8i7QBT?=
 =?us-ascii?Q?lF9GGFC+oVRryo6PIBJ/6Cl9gyxW5GLKXTjb6SnevdJ+H6UbvZFZdMUBUxxd?=
 =?us-ascii?Q?vFSG/x07LFfv6Foo90lRCon+5L+hQo1uUb3iZvTrGDHoqVNVX9KIKmAxz8ht?=
 =?us-ascii?Q?UQMZKw6kUKLzbaME1t/SKuVn27C1sL4SCNbj1g6Im2FN7n5bmTJGsXyQI2wo?=
 =?us-ascii?Q?twZBSvGCmF7TgNKpNj6VIPPrvloZjwuf04TKt6Ci4lBo84JKDJNa/7TSFjQ6?=
 =?us-ascii?Q?sGoBnUYKWDU7K+8XXhoWfLtIHU4xEso9rqVQ8O/LeZ1AgzBfoZRvxfRQgsGf?=
 =?us-ascii?Q?U0qzOu+Ll6pxs9MOyF/5bisTTUv7+vR3NBcg/B70Y8QMJqwxRfU6+vraEM2V?=
 =?us-ascii?Q?uRiqyaa+D8Th12bsPVl3zVubU9K8SUyaOGBT2/LdSGbMFY2aUGdPGvhkIP6y?=
 =?us-ascii?Q?mLnFDOOR/NerQUbC1+Dc2vYdj7JfoSRHfzYnFv+EMAJ8K8DjVjtXs4su9+Of?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c598c5-4dfc-4671-bcd1-08db839b7190
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:45.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVIvghoRqtm0c+zqdE4xcrt4SLExnWNTchAXA3sJgHtZAVwyituOA4K0gJGGvxYAupuqN+/HstRAaSy6LTGqSg==
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

The hardware timestamping through ndo_eth_ioctl() is going away.
Convert the lan966x driver to the new API before that can be removed.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v7:
- Patch is new

 .../ethernet/microchip/lan966x/lan966x_main.c | 62 ++++++++++++-------
 .../ethernet/microchip/lan966x/lan966x_main.h | 12 ++--
 .../ethernet/microchip/lan966x/lan966x_ptp.c  | 34 +++++-----
 3 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index fbb0bb4594cd..c8fce4e79c63 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -451,37 +451,51 @@ static int lan966x_port_get_parent_id(struct net_device *dev,
 
 static int lan966x_port_ioctl(struct net_device *dev, struct ifreq *ifr,
 			      int cmd)
+{
+	if (!dev->phydev)
+		return -ENODEV;
+
+	return phy_mii_ioctl(dev->phydev, ifr, cmd);
+}
+
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
@@ -498,6 +512,8 @@ static const struct net_device_ops lan966x_port_netdev_ops = {
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

