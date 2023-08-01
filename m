Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A459776B775
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjHAOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjHAOaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:30:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5833F2D43;
        Tue,  1 Aug 2023 07:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8FWlOifJxbYOaufSY9oiJpNPbOtKD9OIQTFh5PvPF9wGnA8TEVbIxKOYDo1k86hS0dsWwT/P5Iw+iPyev2rApfeXODPwu40lLYb6lyTelmPyNtzZcR2nCEvx4GIqMxQZewcU82gAqptVVAO9vlc2MiWiQJDfwrlX1KWRd+ifDui+YVzEVD9riEXzao32R4HrwbqW7bJV7EbmgOL90RTUSkJNLVoRu8OnCgGvILT1Ru7C2gn2ZFubgmNa06V3TKVk4WOAYyqseYhvVJ2gDdPp6xZ7JuV1tTcpe8E6bO9m9Zhe06jpBds8G2E1TD4jEz5Om+zHRGyPGquqKbIIs6jHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63i4RIO0hRqAdpqxIzyNOwO1JsLOxgr196bQsQPuJ6Y=;
 b=M/m53WsJay9vg/oK8lm/lenDB2P6TKICfnUSs/0Jzjtbl3YZig/ebZ4vIN3BRCBMAGld2+mVNcnaTbsxi0R8v96hrF5D8hfcY+9RQuZ/kwElrdhIS49cOUsoBWndSc5JvaBjvn9l22RFYR4dtROh/ChVmUZsE0eD8RZAx2KtBkgdm6tCtDoz0YOPJDEBJbPMKXt+Dkvvit7jjLlIDi8nY/JOe8lbf2WDQrz21X5geAjR4imHv4xd08mxJXh+75Fhvby5CY01R7qLGueawRT4vYWmsGTbtEJFVgy9D6Hql1Ad76jol5FLq+KgDxh2rattyve2bWVhlqwjsySP+pnAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63i4RIO0hRqAdpqxIzyNOwO1JsLOxgr196bQsQPuJ6Y=;
 b=n7kIw30rsNXjn8Ev71hmQsQfbPw6b3ueaHxi1y6ACT7C2ggmtoTWEw19PMV3B4tTIIJCGtLgP4YhRvtEbOO5wF7QoKJX2z2F61/wYdKglk3PNBQSvuwuUKykzDVmtqDgUKSoPSXQ74CPFEEgkEBycPk99c7Y6DPaMbbhaWIkq4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:42 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:42 +0000
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
Subject: [PATCH v9 net-next 10/12] net: transfer rtnl_lock() requirement from ethtool_set_ethtool_phy_ops() to caller
Date:   Tue,  1 Aug 2023 17:28:22 +0300
Message-Id: <20230801142824.1772134-11-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f42c4530-c5c8-45e9-f855-08db929bbe92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9lyGaZEldL6SJA0qHzRwa2XzBbdNtY1PqR+uCiBKJ3MDT37Rig432T1tdWmYHtaPfeWo1+6c7NiRJRfq0lIP9BNCz1oS5ZVGI0qCZpXLpfCU3iACaYiT0ifIzJijnTezosJV6XsndS8v3r89D/7KB8mKn9WFt+nQHyspaxTi0fG/96Cb5VOhLHhQfyEaBT+WgkHMIXrmvBGbeFvl0lO0rM9VfIYJvUnlz9cUR4XUiqCI43kmlf4vIWTdOrqWzl+wlogM47GLokGCcCg2WTtVAr8YfoUsZd5Qk0T40B2ndxh4GQus8Z6ek0tDy5wY/FuqBli+HxDOdmKQgQW3uDGvjvR2/p5zOo2mXHGLnvVJ+TR39aJwPh5nP4HLGI7sMefXu+Fv/HhZye1GR38esTZvzALNmgSmG+YqcZcoAiZna0Cy/x7qgKmxR1M8npDbtuzQIeoaRqomqRARk+w9F3z3bVq1L1c0oq4HgF1NcyewcTlPXwmp3/U1VKs/di6Pe6Uj+wzvNabcub5PjFhFcyyLp6N/wPyvlCwXz43k9TOZwv9J2uRGhLCgfHwfN73iUEUiZGvZnNynmifFFmvz0ypgFgHmIX9cKjXlIxxlz9q52Z9mZOze6yn0/JE9QaT2y7s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7TS74d4mUtkRc4jqGMZufG4sHrqlqKmtR8mciPa9S1cMNoPkMO2hhNe8qgV5?=
 =?us-ascii?Q?gtDgXprgxT9JwjzkaiV6n2KRyv6F+H23Sz9EF35Ohamoge5BIilwCMEWbs56?=
 =?us-ascii?Q?wLcHiwR8wkkr7e+1LM1Up6CzgUWSdSZ0sg0Fw6UJFaHp5tZZ6FdOHPagiU04?=
 =?us-ascii?Q?XcQpwT/FCut/6ks/0S3vrOVKp4OO8Xz1+v2CILKTGjORD5ZKDafrImoIS9Wb?=
 =?us-ascii?Q?rBK/hlK38qMvztjKjgBdpkGT+5dVle1XbLx8Lblgh10gNQkiShOTwqas0oeA?=
 =?us-ascii?Q?uaDd8X/4asgKpFkcW5xbUUR4WaSyezhu84KkuVUvaxQGYbJDWPsAkOpVCMvR?=
 =?us-ascii?Q?1M0P1zxb9vyuCJ+7vivh5MANs7CPcrWQVF+ch4MxM2RfY0GMbYSYAqiApkCX?=
 =?us-ascii?Q?4VTNiNpEkfB1v8WZQ1tEXagk0uCYKLpwixDG9ROBj/IS/pHtVwxl2Mh87Uqn?=
 =?us-ascii?Q?VlraeUvB6yVSKceLWPbUpeqqYStgW4fqRuH1XFck4vQkkd2RbTTDvsP1BT14?=
 =?us-ascii?Q?m0edkA5nRrk04FjDbBKEUBIagWeA/leXw7YVoBLBrl/EAK647VnmIYc9MP5o?=
 =?us-ascii?Q?iK167zPqySTcFVs0NlTl/oJEKuOl6aW0U+GAN35oIeo8GakRWVg4oKZezoq6?=
 =?us-ascii?Q?hNH1dlzXHDEG2qVo7BeE8JziylGgM9KEws1sF2S2h62Vv+QfqN5bz88tWjg4?=
 =?us-ascii?Q?DBuX79M2C3W65f58KBzE3eCNLeYpZWiPGSIbE9nhf9NbH/txfF8CVrsuMMAa?=
 =?us-ascii?Q?WYFw5adCkGaWBrPZA1w+qw2e4O+o4yPetNAWLnLuNtVzntAEI4PAJEEtdf60?=
 =?us-ascii?Q?JhGUpESg2c1laPjeN78ZK2y6cuJBOfFh1qa0suygxeusj3p8759qxUWYdKWh?=
 =?us-ascii?Q?kJkZ3Kpej4mD10b1TPaSQVmi7vd0qf1bl8/S25HSFq6IXxGQaFFzPwsO9idL?=
 =?us-ascii?Q?QVAm8GK8SV8VsTwwh/06I7Yb2qnsIvF0cgjos/XtFHegiIH+8BeJXpMoXDaX?=
 =?us-ascii?Q?QPNJ5njUSL0tFUf6YlgFnxc9qHrxJNi1LlRRSVX0XxK5IFS5ZVReCXAPNip6?=
 =?us-ascii?Q?o4IcIN7gnkzRrOQ16M4ZUjgADFjhFSf0U8H1IeZTD9QQaNMJxCwhQHDdbcix?=
 =?us-ascii?Q?PVCBUgE1S+imhPuPB/UUaBcfrhp2sEu9nuC7bT0ElB1cHbKiDZG9Ud7bxGxV?=
 =?us-ascii?Q?y3vDEpa6gC/2tf8GrcH4ET30dg1ave8TCWEnyZjmzRzimdiuPGRXoosZfgE9?=
 =?us-ascii?Q?BoJjHWEo72W6iQsji93Zp/6ZjDF3M3jeRjxamIYwv0XpEyLwePH3BybX5Zka?=
 =?us-ascii?Q?FseH+d//KPSrk5umETcb8hv7LhXexyBrgshN/A5A4o/YjTveJlUKVS4sgtnw?=
 =?us-ascii?Q?clkxyvWu3NVoD7XIwsCY7EyGONYWPkAnd+hJX8x1oXGyCQacSH9fa8On1Ew1?=
 =?us-ascii?Q?6iA7XmTp+1JTSBgs194JWXayWQxk7I1IqrB4vMfN4zUPujec0iFTMNb8URDP?=
 =?us-ascii?Q?wN3fR4AN6SJyX9/gblaqAeAH+1GbPTt9ymE2+eG6TUlIGYOtohkDiS3MaMK9?=
 =?us-ascii?Q?oN+sDICOPb4RS9nEphrAq57bHmwkY1OFXhFd0o7Q4Zu5CEO0jwHBNBWLiyB6?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42c4530-c5c8-45e9-f855-08db929bbe92
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:41.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ/dKAaceddiaqDhbVUGwSb/K/ORzdXN9SH3uOFYuwhwvh2YE6YHB0lFLvh/Q/K9X8QccM2Q4QNLupVW+le0Vg==
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

phy_init() and phy_exit() will have to do more stuff under rtnl_lock()
in a future change. Since rtnl_unlock() -> netdev_run_todo() does a lot
of stuff under the hood, it's a pity to lock and unlock the rtnetlink
mutex twice in a row.

Change the calling convention such that the only caller of
ethtool_set_ethtool_phy_ops(), phy_device.c, provides a context where
the rtnl_mutex is already acquired.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v9:
- Rebased on top of 1c613beaf877 ("net: phy: prevent stale pointer
  dereference in phy_init()")
Changes in v8:
- Patch is new

 drivers/net/phy/phy_device.c | 7 +++++++
 net/ethtool/common.c         | 3 +--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 61921d4dbb13..98b8ac28e5a1 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -30,6 +30,7 @@
 #include <linux/phy_led_triggers.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/property.h>
+#include <linux/rtnetlink.h>
 #include <linux/sfp.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
@@ -3451,7 +3452,9 @@ static int __init phy_init(void)
 {
 	int rc;
 
+	rtnl_lock();
 	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
+	rtnl_unlock();
 
 	rc = mdio_bus_init();
 	if (rc)
@@ -3474,7 +3477,9 @@ static int __init phy_init(void)
 err_mdio_bus:
 	mdio_bus_exit();
 err_ethtool_phy_ops:
+	rtnl_lock();
 	ethtool_set_ethtool_phy_ops(NULL);
+	rtnl_unlock();
 
 	return rc;
 }
@@ -3484,7 +3489,9 @@ static void __exit phy_exit(void)
 	phy_driver_unregister(&genphy_c45_driver);
 	phy_driver_unregister(&genphy_driver);
 	mdio_bus_exit();
+	rtnl_lock();
 	ethtool_set_ethtool_phy_ops(NULL);
+	rtnl_unlock();
 }
 
 subsys_initcall(phy_init);
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5fb19050991e..f5598c5f50de 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -665,9 +665,8 @@ const struct ethtool_phy_ops *ethtool_phy_ops;
 
 void ethtool_set_ethtool_phy_ops(const struct ethtool_phy_ops *ops)
 {
-	rtnl_lock();
+	ASSERT_RTNL();
 	ethtool_phy_ops = ops;
-	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(ethtool_set_ethtool_phy_ops);
 
-- 
2.34.1

