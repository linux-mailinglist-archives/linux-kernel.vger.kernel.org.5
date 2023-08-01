Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA476B777
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjHAObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjHAOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:30:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE730F7;
        Tue,  1 Aug 2023 07:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9iJJopknf+jBY6NT2Nddlk/LhfjA70MT9qZvQo02XCP8dtEwsOIfwzqwtCaRd543gdOQUeIGTZRDEFvMBRUCeR5TT8tXSEkwi3j1UoYN9xkG7cQnGxV3rJXGBe+2sU0rfwkMYalnu+foDeB4xdqyk+mlgnSvVp8USO92xqxg34wONJTaIRHiVXCVPJ9WVV1vje27RmUkD+S27IqvmBN83Pavi3p6BLGDDe/bonUGVEYFq8V62dfKrV+T5roK5cgJUUoYmytS23eUud0DGwULkI2eUfFlmObg8+W9bU7sCKfZtvpzMYoDx36V/GLXaqdWVfWx1hbMeDUmWW2wqf2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6/qRrCi6wl6NmsjgBr8nqHZOT67YGTyop4LMMkF8DQ=;
 b=mxCvPa0YJ0/djKhXkogmoInPNjTDAPB23lyltInrhvmNqXh/poyTCuF1uXiLZAwQI+P6MvCobOag5X7AtWvS1ZMsyQOya+siqD3QmBiG/ZagkiJYlyJnOBp4PGrCPFpSR3NPZxQBnJF7bDhXOciF0fOQQu6ca+7IQpi7+wlY6Lcn3yJvgswasE6sEGgwCn4/QB6AwRzYlCYrZo9vwPSXnlDo4k3g5kzKr/x98zchaTJ40EsMB4+7YvoygvtBYzofcT9rJqhNs2kFJN1RZRThjulfKC98GXGuJkeV3yGXg94KZPY9+uohytsMykvdlYLJcFijiyGxRtKuF0ZckaotYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6/qRrCi6wl6NmsjgBr8nqHZOT67YGTyop4LMMkF8DQ=;
 b=NLKQnLBG3x6M3HyoLfkod4smzpcq90jz8+D3Iu28g8HtlpKr1JQvHlsKF8Y+t6FVmTPgDlPjuCcFXa8O/aITVio+WD96551LYw4Objp7Sk0LgYlX3Dr9R3upRQ1sB6gCRLU4UdES0Whw8bsyLc5/Sq/V099PlO6CZmCFZAY3zoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:44 +0000
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
Subject: [PATCH v9 net-next 11/12] net: phy: provide phylib stubs for hardware timestamping operations
Date:   Tue,  1 Aug 2023 17:28:23 +0300
Message-Id: <20230801142824.1772134-12-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 627aa17a-90da-495a-e627-08db929bbfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uciq3/rDc0iZc4uY9rZtfwgGxLFcfukG5A6QGiYIycpcdSzb89kOKp2RbWKDx4x66bN4RCylT0fgBlzsvmJWWL992fqgxOevN9Ok22nV0T/wGvpIOlFqotFpc0tekSRGjZKNgiSnHysQz/3vR0QeXQ4cd7JOWVFERnnSUOCDYnTShEEWuhN7CNkmOO8+eFo76DkALyBxFfKE2LFXokxVWyOUNMMhs8aLLuVPnIia7+04vXfD48ulzDTdEwXNVnJiw2q1rgVJEkp1KHWIbco24VwL6cIlZcKJyZOn+AZb7/dyIdPWIOn4nXa/BPeTA9XUANiZWY1gfJuTEGNnhl/O3KtB2Mrou/GqGl4ioO2RKnz67qdoIwo08jzvUwy4Nv2pX8xXZDgHDOr3DNONirBQb7EUSv23p1FR2S3ZzsrEh59jFYnr/wozzfg2kuyvEz7PMCEE4z6o44BMCqcFLxDHG9v46QuhOK3nHvErVwZyrSO0hJmTbep7gLf3FacVO/malHisYYX+4VWMWR66KCcjg1DHZyDclA0kctxpIzLL6QNDIyT3rztVMtwGM7B7jcH4Cu+dx+jSE0Qi8aBNpC8QCY/sgKXyMfS8GklZqUAdhOqjxDHi1GcAhMtto7F8nYFa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rJFGh2kHA7XBYNPlTpc/VYTdSXavtoLPGilM2LrwQT0IjftOb7XHqWaRpQpP?=
 =?us-ascii?Q?QNMWmkIAWo54ybLzWVhnUbjMydq7xEzFNFNRuOIy8x8qy1eVKrHI/yXuZghk?=
 =?us-ascii?Q?eN7tiGSh7qe13SlfDdfw1w4e+MuWj1VnqNcNNgZcdx7WIAyzxhxqUidI/XG9?=
 =?us-ascii?Q?nL8o/1AWDLKRtchW/tfB8RBzvvzez7MZ8uTq0LTlpG26NzON885+bLWx5SxU?=
 =?us-ascii?Q?C/j+5A/r7ue0UnBlNWfzwiV/CRwhWFPX49SfBbE89R9fR2LxqYfreCXk240a?=
 =?us-ascii?Q?vf+bU2mWuEpT7NxQcZwB8gZVYwdCSxFtI5eYNFLK0iwDcLZYDR8zj2WXfA2u?=
 =?us-ascii?Q?PXEHOfT/vMtaoDWtcDh4rFQktQG7v8He6B+EVn8+EP5kYxckiH2QBdyie34O?=
 =?us-ascii?Q?ovUsj9OHQha9JTUxh1to6xpa0f0pmPzvTBhbxHj3bX5ke1/xUCUkspH9h5FZ?=
 =?us-ascii?Q?Z9O85UotunXwVEA/Mwv8iozk1DZTXBhHq2leLZO/3sGMQUB+4tkESz6enr5R?=
 =?us-ascii?Q?2obkNX6kbwxO03ig5e1anjyMZfafyOZ8gPFcFNP+5h7FWSX26bddNRrxjP5x?=
 =?us-ascii?Q?jen4tMuMGvDniiyNgEfJNKky4MqxCQS84eSN8L5/yxFY83nX26pj8BXxWkn/?=
 =?us-ascii?Q?44JtNjiVsw67AvZ/1x+g+PIOai8lbOIOnbAitvXwkoUWTEMMzzQPMkxqs3zk?=
 =?us-ascii?Q?efmwLCILzBlUh1PvHBOh49W56auFLYfLcX8aqIDGymx4nyjgDEKbYpZIPXUj?=
 =?us-ascii?Q?6x8yTnnlEgnt7vsBbya8EsP121N0sgzZnAUrJJZ3YSZzetlepnF3y1xiRVQa?=
 =?us-ascii?Q?lGfu4B00DnZCDTcKGIBSPQLiYrmHApYjdQ8rk8lw2sIP3Sfp1PFQvKkpV8sO?=
 =?us-ascii?Q?89Ayk2OsoE0pCht6Dq0cewQF4x8hsh2D3XfL4utd3xPxasWFXjtUts9e5pD3?=
 =?us-ascii?Q?mV4fQH/ewUZ3OkAgAd9AyBJAiCacoYk3khcZ2tLH28QDKyAyxab+qY6K5PaG?=
 =?us-ascii?Q?5b6VqD+3nkVsasfRgOcq51HdueykKVcfNXEHtTZ70R4Oc58eA3GgSN9XzwiO?=
 =?us-ascii?Q?l+e6qqy7CFr9vnrhf5eMFSuN7wfYSGneenjGM5lv6CXX2rk8U3djCI/LzvEr?=
 =?us-ascii?Q?8BjhZ5ryedqOsZmXbhW1i4nOk04Dj/eJ4RpOw4o1Sq5DeYC0/uMrWW2pNfDy?=
 =?us-ascii?Q?IWDxdHcUCAMhfz0xqGmniAME8X+n9MnqoRpTBjUdqi9OxGiy2JfyNQzAHomA?=
 =?us-ascii?Q?sJSGF1eqpf0lh9gyt0bjbdSL0mxv7rkDHN5WGKPcHFyinNgFZmaUa/v0VIsB?=
 =?us-ascii?Q?ZgkNAC8Vu91o8jlsuhjqOrjH1SVKOGEgxbgeq2UsJSr4IFkH4xbA4GxjJT+N?=
 =?us-ascii?Q?28k41w5DA2yHSNpPiGjBPLkUxQlruz1ukczHrmdKjGOLsmtO9J8ASPSaiyrR?=
 =?us-ascii?Q?KfZPelWu2WXXcySiWeXTSOEKl/6j+IXoMI7P7wAGMevFqx8hKDwYa0V0S6VM?=
 =?us-ascii?Q?HtDZMN8MPXc1wzMq5XiMeq+c/uMUSs7sYHgrPMF+bnbcyxOTa9B0+/fYfmBu?=
 =?us-ascii?Q?bICv+J3EikTe8t9/ZXTlG8I62s+4olDESKHwVFnKgcaT4EVisJePCr1OM0by?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627aa17a-90da-495a-e627-08db929bbfc8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:44.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMDJfWDHFrM8smM5/DwFqEGdfpdoqkGgZn/zklwRegV2eh095BBG8z5FfIu6wCscL/xD9AEvFRGzQOmk1xjuRg==
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
Changes in v9:
- Add MAINTAINERS entry
- Add missing include/linux/phylib_stubs.h
- Add missing drivers/net/phy/stubs.c
Changes in v8:
- Patch is new

 MAINTAINERS                  |  1 +
 drivers/net/phy/Makefile     |  2 ++
 drivers/net/phy/phy.c        | 34 ++++++++++++++++++
 drivers/net/phy/phy_device.c | 19 ++++++++++
 drivers/net/phy/stubs.c      | 10 ++++++
 include/linux/phy.h          |  7 ++++
 include/linux/phylib_stubs.h | 68 ++++++++++++++++++++++++++++++++++++
 7 files changed, 141 insertions(+)
 create mode 100644 drivers/net/phy/stubs.c
 create mode 100644 include/linux/phylib_stubs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c4f95a9d03b9..069e176d607a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7752,6 +7752,7 @@ F:	include/linux/mii.h
 F:	include/linux/of_net.h
 F:	include/linux/phy.h
 F:	include/linux/phy_fixed.h
+F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 F:	include/linux/platform_data/mdio-gpio.h
 F:	include/trace/events/mdio.h
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 35142780fc9d..c945ed9bd14b 100644
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
index 98b8ac28e5a1..e19c4fee8d22 100644
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
@@ -3478,6 +3495,7 @@ static int __init phy_init(void)
 	mdio_bus_exit();
 err_ethtool_phy_ops:
 	rtnl_lock();
+	phylib_unregister_stubs();
 	ethtool_set_ethtool_phy_ops(NULL);
 	rtnl_unlock();
 
@@ -3490,6 +3508,7 @@ static void __exit phy_exit(void)
 	phy_driver_unregister(&genphy_driver);
 	mdio_bus_exit();
 	rtnl_lock();
+	phylib_unregister_stubs();
 	ethtool_set_ethtool_phy_ops(NULL);
 	rtnl_unlock();
 }
diff --git a/drivers/net/phy/stubs.c b/drivers/net/phy/stubs.c
new file mode 100644
index 000000000000..cfb9f275eb18
--- /dev/null
+++ b/drivers/net/phy/stubs.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Stubs for PHY library functionality called by the core network stack.
+ * These are necessary because CONFIG_PHYLIB can be a module, and built-in
+ * code cannot directly call symbols exported by modules.
+ */
+#include <linux/phylib_stubs.h>
+
+const struct phylib_stubs *phylib_stubs;
+EXPORT_SYMBOL_GPL(phylib_stubs);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index b254848a9c99..ba08b0e60279 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -298,6 +298,7 @@ static inline const char *phy_modes(phy_interface_t interface)
 #define MII_BUS_ID_SIZE	61
 
 struct device;
+struct kernel_hwtstamp_config;
 struct phylink;
 struct sfp_bus;
 struct sfp_upstream_ops;
@@ -1955,6 +1956,12 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
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
diff --git a/include/linux/phylib_stubs.h b/include/linux/phylib_stubs.h
new file mode 100644
index 000000000000..1279f48c8a70
--- /dev/null
+++ b/include/linux/phylib_stubs.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Stubs for the Network PHY library
+ */
+
+#include <linux/rtnetlink.h>
+
+struct kernel_hwtstamp_config;
+struct netlink_ext_ack;
+struct phy_device;
+
+#if IS_ENABLED(CONFIG_PHYLIB)
+
+extern const struct phylib_stubs *phylib_stubs;
+
+struct phylib_stubs {
+	int (*hwtstamp_get)(struct phy_device *phydev,
+			    struct kernel_hwtstamp_config *config);
+	int (*hwtstamp_set)(struct phy_device *phydev,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack);
+};
+
+static inline int phy_hwtstamp_get(struct phy_device *phydev,
+				   struct kernel_hwtstamp_config *config)
+{
+	/* phylib_register_stubs() and phylib_unregister_stubs()
+	 * also run under rtnl_lock().
+	 */
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return -EOPNOTSUPP;
+
+	return phylib_stubs->hwtstamp_get(phydev, config);
+}
+
+static inline int phy_hwtstamp_set(struct phy_device *phydev,
+				   struct kernel_hwtstamp_config *config,
+				   struct netlink_ext_ack *extack)
+{
+	/* phylib_register_stubs() and phylib_unregister_stubs()
+	 * also run under rtnl_lock().
+	 */
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return -EOPNOTSUPP;
+
+	return phylib_stubs->hwtstamp_set(phydev, config, extack);
+}
+
+#else
+
+static inline int phy_hwtstamp_get(struct phy_device *phydev,
+				   struct kernel_hwtstamp_config *config)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int phy_hwtstamp_set(struct phy_device *phydev,
+				   struct kernel_hwtstamp_config *config,
+				   struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
-- 
2.34.1

