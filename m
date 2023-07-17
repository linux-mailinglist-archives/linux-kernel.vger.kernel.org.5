Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9891D756802
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGQP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjGQP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADFC1710;
        Mon, 17 Jul 2023 08:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI2rUfuuJjNpVoTbLC/T7Y1GLK2i54VReUK9DNrIUscasmSPoBKfXJQPW4a2EeeOQAzl2kc3t5XnZTI+UDdJNHLjaLSl2THo9ZIxzN01JZTdQ5RMHcfo9aBRVkYpB1Px+HBJmBeAt7MYqPeQurwuViM0jftJ7v0Fe39tRAg9R84UTom5+wIVJEfB3H1wLbdZ3nsaYq5lydn0VwqeSjSY8zvRMTMYruO0ED+uoIbSWw+K62lutyZuydU/fA2zj5Z+JW3x4YE0G+PoIol9CEhFEW49azM18rv7MnmJeHZ84fxYlm+noqwsMswjZtRaks8b1LyBBO1bv/zIp0plqhJhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUgpC8b6GWi5ys60SQGjyFsEvn/6TqMCm35reK7DuHk=;
 b=MRLQ6n07TgdEyp4glYe3NrBNk1mjj0AcqsPW9UqmBpAQxkNsAHeeUj1xvv40iWPxH0VT5S/uyQYZU6XVLahYTc7iG6q79WjdyTP4NNFEkHqoKmu0pmCVhjpxecEKqpEenTnCdxeIzblpFejgPdmVMTwzFMy6RCxyr1s8umaPH6lP+DXwB6d+ZzY83jFucAGeWZDCkBC/BLuCbDYOKFwTa7RSzrpRm9oZbB7hbyILpzL0PcdnYMFaiZOzknk9L2vtrJbD/U6S40cDHb8DsmMKdbjv3Ukh0622xKEuzsVvcMwqokQWwoTOYstp++A2hstiRJ3dZhJ5LLlgiFI7hCoiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUgpC8b6GWi5ys60SQGjyFsEvn/6TqMCm35reK7DuHk=;
 b=eNVvw6jxfNYakjlbs1ywUbODZ+TVCr4NhdjdY2Dz4Yc3r47MwCFPbJPz3SeIHIUnY6jiDe/E9/bQ/WCzkHCA0/MITCRj9vnc1DvJcA+uY2WGntTGzKPpDEtSMNwd9W28vaNUrqam0hsKjj600kdLf6H5u0rOgHqGf3FIC5OW5Cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:45 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:45 +0000
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
Subject: [PATCH v8 net-next 11/12] net: phy: provide phylib stubs for hardware timestamping operations
Date:   Mon, 17 Jul 2023 18:27:08 +0300
Message-Id: <20230717152709.574773-12-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 666d5023-6d35-4b59-7eab-08db86da5ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omQ6S65nEhHvDXqAwrNp8Fps0V/N8rjJ3mBlv6DbBUCwluX60yuULmflpmofl/uEwsjIj2++92+AEN9MxsgdGuD0Xlx4V1YTVnAfokzAT8ZuFqHqZVhIcLAsCu3c4+FJpuSpxIP86wsZ3PjDaGUr8denIh+5KwplPmSuLs5DNavKLIFL1cKxjDyItQBY9fLE9JpJJu557wFhkNYyoTiM0SKgw3ipXnoicYhR5ExaqFPjt9qTIoL9UK14FqdKrt8zCB1USR3KigdHlwNqOkJzV+cMOCuh7lS4BVhu/kTJ5g1o+hvB3D1dwGk6QtUoSw/+MZAEjgrwxs663XLI8Wfo4HRoD3OkUS+zENR/VR0H5phi3xL8THg1YnIjNe4pHjobm3UNAUNywsTf0TmnS93vvx+YKLoXf2zRc73sKLoLAVEOhGMj7lUFwvlOd95XeHo196l1bLJ8Vn/m7lJ8mh26ZLYjgikn2RN1DWOU/0fFFrw66P0i4djPsX7PS/YYxGowaE/4w5hcaE/IY3UuhIC5j3N2hX8yTgmujBZKt6drazpokMEfYcoDBkAJMLE1cl5Zdmqo8FaOxPWfgLOcRQJkg4lM3dVU/ZvWDj8vhizxmdjrtRIYs/fjVzsVGAtnLQZ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5m7JCTKAcmPMCJRik1F+pWivERBAwWU8Jm2llUAv5XiTfNq/h+io5U/AaHPf?=
 =?us-ascii?Q?9Z1HEFWxjFp4ekU6+6SHlgHYpIuAlX9cfsE3l62S4/okmBtTue1dTjDeXbCn?=
 =?us-ascii?Q?TXgDylV466wC2k+B6zlM7jqBGl0NtyWRvOhzi8BvTVoiZIZN6F7mX6kbW4y3?=
 =?us-ascii?Q?/qOrQ92tvTfaMYUVelrXFT7ucyI+78iuC1DHFe/unXDHQMWdA/Mn7U6KbxEJ?=
 =?us-ascii?Q?W7o5XWg25V4NJjiU6N3I1t+6gdxluRnmnWEK+C9I3Dddso48relfQDvcvk4W?=
 =?us-ascii?Q?XWWfQIzIBSPT8V/o7avQKQxCg43CRhbPFCymvZilYrAv/0Ea+6DZfoSRuXcD?=
 =?us-ascii?Q?9IS+IKplh4gU4ppGTqWCeoFAI1m90dWibqU/nqZ6ikQI5keqGj0uZv4TMk+w?=
 =?us-ascii?Q?49Iq3ZnK/TIse7aLstwMHEe127gcB8qBt/bJv87MxQVXaFdK11DSdzCd6I7q?=
 =?us-ascii?Q?x3Mbt3IboeDPhizL7kt7tc0MqeSWXml0EY/FkkThwSQ6Uu4pG6tv94Ln5kIL?=
 =?us-ascii?Q?aDTLdWJGU2I4RlYMhBu40CSQ6OuGiyV0T/vKI9MYqFmHuXcILdZbfxaIo4Bj?=
 =?us-ascii?Q?xr4Y2BCUwqo+pZnJ2FA4iplhVJ3utvoO+NXCCUH3gi69oYA8LEE/PoNj+52k?=
 =?us-ascii?Q?79VLp67BxajxuimncLY0ErKVroIr1j3UlODofJr8ZG04APMVTYKlqD1dwlkk?=
 =?us-ascii?Q?6REWzjvj/h+Ms8+OYuBVaA/AkuJI8rf8NgKrlV8M2JBck16feq4Xyyo+hy/x?=
 =?us-ascii?Q?RYsgi1lDozwzbBdhvRKZIBdi3lv0uvHOIogC0nGr2bf9jTpoY2IiuyFw5FrS?=
 =?us-ascii?Q?q/pZSiDs4nZ3gBoTH3+11LHK7TVkJCVC+fgaP9I+FuaVuTIsQFfHec1mdPeG?=
 =?us-ascii?Q?cZNlyxrrPpokfKbw9w+s4X+To1lLTsovgdrEi3SZ7/hARk6yaWh9PJYivNHN?=
 =?us-ascii?Q?RcpvsRB1UyaV+1rGjdQOiGkFe1wlvgAVziaMCKKSkZ2qIUYRsrYhkJrkGYe5?=
 =?us-ascii?Q?DxAiyLBfoJt44qs/B4z6NW6TSdwV7JHcrVYtgObEUP6dzJUqNbkqBh1qYCmE?=
 =?us-ascii?Q?O69FBkrjk3lLNg5yopVilDzL+G2fknyiXEgQByLCWdzLZ7aGNgzhxwojJ5qW?=
 =?us-ascii?Q?uW5IPuzJPzbTSkC6aXQh0x8QriOWjfe2NDeWYedHON3Y8Ld/U3OeJhCEffR2?=
 =?us-ascii?Q?bzS2jfbSVHdIRB95m1Ij7rl8XKRJPLL9gX1Hg8WVwV9fnvrQQs1jbonroZZz?=
 =?us-ascii?Q?z3y1r+HDg1NzAptbcjETPiyliran0SuKi+GeXrko1Xr5fzrsA+iGdoH/sKEN?=
 =?us-ascii?Q?CRGbws1r6+71DzO7uc8kFkj/LhmKsaczPgs4tDImLHP6UoYQTOYDqvPcwnk9?=
 =?us-ascii?Q?6J8hi3FFCZeLRIcCBnE51rZxKnbcTH/CUdbX4PRm16cQz3LYa0x7crCbRBMx?=
 =?us-ascii?Q?ahR2iIWh6ZwK8s3RjaxLJcXYBuQKtSs/PdBO/XlQDajl+JE6pQfBSsv/I4P/?=
 =?us-ascii?Q?NWa8DrNetgH7wKd0XQeuyMLkdeiJuTxWp0JciKrGrKyVhnegPx8lt7Ja/lAY?=
 =?us-ascii?Q?i2TOyfF/gemYnmpoNToOW75VfteTRJLaxNm2iOtxKwjzmNkkovIMN5VhmD+O?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666d5023-6d35-4b59-7eab-08db86da5ed6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:45.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jHGc42/uE2DCy6w0i6c1wepS0FXzodMv85BX0qMd4SwyUywNVhozWldt2No/Ej8jzc/cebKTCZsYKU/VpAfHQ==
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

net/core/dev_ioctl.c (built-in code) will want to call phy_mii_ioctl()
for hardware timestamping purposes. This is not directly possible,
because phy_mii_ioctl() is a symbol provided under CONFIG_PHYLIB.

Do something similar to what was done in DSA in commit 5a17818682cf
("net: dsa: replace NETDEV_PRE_CHANGE_HWTSTAMP notifier with a stub"),
and arrange some indirect calls to phy_mii_ioctl() through a stub
structure containing function pointers, that's provided by phylib as
built-in even when CONFIG_PHYLIB=m, and which phy_init() populates at
runtime (module insertion).

Note: maybe the ownership of the ethtool_phy_ops singleton is backwards,
and the methods exposed by that should be later merged into phylib_stubs.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v8:
- Patch is new

 drivers/net/phy/Makefile     |  2 ++
 drivers/net/phy/phy.c        | 34 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c | 18 ++++++++++++++++++
 include/linux/phy.h          |  7 +++++++
 4 files changed, 61 insertions(+)

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 2fe51ea83bab..5b5b0d300220 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -14,6 +14,8 @@ endif
 # dedicated loadable module, so we bundle them all together into libphy.ko
 ifdef CONFIG_PHYLIB
 libphy-y			+= $(mdio-bus-y)
+# the stubs are built-in whenever PHYLIB is built-in or module
+obj-y				+= stubs.o
 else
 obj-$(CONFIG_MDIO_DEVICE)	+= mdio-bus.o
 endif
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index bdf00b2b2c1d..8aec8e83038c 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -455,6 +455,40 @@ int phy_do_ioctl_running(struct net_device *dev, struct ifreq *ifr, int cmd)
 }
 EXPORT_SYMBOL(phy_do_ioctl_running);
 
+/**
+ * __phy_hwtstamp_get - Get hardware timestamping configuration from PHY
+ *
+ * @phydev: the PHY device structure
+ * @config: structure holding the timestamping configuration
+ *
+ * Query the PHY device for its current hardware timestamping configuration.
+ */
+int __phy_hwtstamp_get(struct phy_device *phydev,
+		       struct kernel_hwtstamp_config *config)
+{
+	if (!phydev)
+		return -ENODEV;
+
+	return phy_mii_ioctl(phydev, config->ifr, SIOCGHWTSTAMP);
+}
+
+/**
+ * __phy_hwtstamp_set - Modify PHY hardware timestamping configuration
+ *
+ * @phydev: the PHY device structure
+ * @config: structure holding the timestamping configuration
+ * @extack: netlink extended ack structure, for error reporting
+ */
+int __phy_hwtstamp_set(struct phy_device *phydev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack)
+{
+	if (!phydev)
+		return -ENODEV;
+
+	return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
+}
+
 /**
  * phy_queue_state_machine - Trigger the state machine to run soon
  *
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index ab53d10f1844..08c162b7e6be 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/netdevice.h>
 #include <linux/phy.h>
+#include <linux/phylib_stubs.h>
 #include <linux/phy_led_triggers.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/property.h>
@@ -3448,12 +3449,28 @@ static const struct ethtool_phy_ops phy_ethtool_phy_ops = {
 	.start_cable_test_tdr	= phy_start_cable_test_tdr,
 };
 
+static const struct phylib_stubs __phylib_stubs = {
+	.hwtstamp_get = __phy_hwtstamp_get,
+	.hwtstamp_set = __phy_hwtstamp_set,
+};
+
+static void phylib_register_stubs(void)
+{
+	phylib_stubs = &__phylib_stubs;
+}
+
+static void phylib_unregister_stubs(void)
+{
+	phylib_stubs = NULL;
+}
+
 static int __init phy_init(void)
 {
 	int rc;
 
 	rtnl_lock();
 	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
+	phylib_register_stubs();
 	rtnl_unlock();
 
 	rc = mdio_bus_init();
@@ -3483,6 +3500,7 @@ static void __exit phy_exit(void)
 	mdio_bus_exit();
 	rtnl_lock();
 	ethtool_set_ethtool_phy_ops(NULL);
+	phylib_unregister_stubs();
 	rtnl_unlock();
 }
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 11c1e91563d4..6710508e8c97 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -298,6 +298,7 @@ static inline const char *phy_modes(phy_interface_t interface)
 #define MII_BUS_ID_SIZE	61
 
 struct device;
+struct kernel_hwtstamp_config;
 struct phylink;
 struct sfp_bus;
 struct sfp_upstream_ops;
@@ -1954,6 +1955,12 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
 int phy_ethtool_get_plca_status(struct phy_device *phydev,
 				struct phy_plca_status *plca_st);
 
+int __phy_hwtstamp_get(struct phy_device *phydev,
+		       struct kernel_hwtstamp_config *config);
+int __phy_hwtstamp_set(struct phy_device *phydev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack);
+
 static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
 {
 	struct phy_package_shared *shared = phydev->shared;
-- 
2.34.1

