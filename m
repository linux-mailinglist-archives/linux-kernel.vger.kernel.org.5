Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFABE7567FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjGQP3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjGQP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015BF10F1;
        Mon, 17 Jul 2023 08:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr2WcPMui2vtcw0Iyuijimks+bAvVGLqJVFPckQaHvUmZjkQ5Qbud1djkxR374AgPM9laY/PpjvI02pSsA7/NuXom6MTNO11PGDzPKa7R2YhlAJh63lmvyLsBiAqO2iu0kC/3pT6aIQBd7Ywkg1Zj+RbKzwnXp/q7yBYKomBCdll0RFoVOVsL7G1kca4/XGonqxy79c6CuX5WYUPZib18WrH/BwsA90RZdnWEVHRxAdwtmrdWxzlZjBcURthAyj2uTCGa5Jk7O/a+bDe4627kVdVXSPW+9n/BFkBidH/SXsIEzJHMPRDtC2ZPiT6818RlPZnsq4ISaWy1BNXGOHoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzc7E6CfYK2zrLX0w9MQWTufyjGs6lAs5lxehq134N0=;
 b=ZgyQdC7JMwEVUcR39tlyJLZ7M+VCRUN343Ay6N5Af8lzz6dazwk/rSKU5Zz8BDZawUxsDtqg4vN1B/amWKfzSy4JR/dP/z7Df4oz9Skf+Rc2DEvjwCVIcAoWuzDzbvbIXOTvqVyvNR3J9pstnlW7A+z3SB1Op5UXXtSCcZPN1u5ReN1AMdP6Qecm9O4HRZuTqdNctg8gl0HAmKfCJisdzeBYlFWKrrP1wKSh261lwuUssliJ8RN5utuA9J+dsOEYd9rl1fGI04JtfuC4pOxBQrRrKYwMeI4MEW+wSy5rNUt8+dip/SHo5CcuuLg1lrE3jvkAt+6o5pto6enfGeibMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzc7E6CfYK2zrLX0w9MQWTufyjGs6lAs5lxehq134N0=;
 b=QzdivViPK9znGAsSR9Tdb3vgdeT9KGZJZJvi6jWGo6N/E1tah4TUUpetex6pAlZdiyUBoR/ncJvU+s1nv08yE0b0WMln5zDAl0CfZk/DZlVfKVgmstNj15TJRDR/iFjBIc1faGrJa7MDY6kZnhAqUQqP8lpOc+ra/9XwkDzNq7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:43 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:43 +0000
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
Subject: [PATCH v8 net-next 10/12] net: transfer rtnl_lock() requirement from ethtool_set_ethtool_phy_ops() to caller
Date:   Mon, 17 Jul 2023 18:27:07 +0300
Message-Id: <20230717152709.574773-11-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab8b09c6-9f9d-4860-f33b-08db86da5da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNKNeyk3KvtwhfV1WFaF/8uhAGxov6c6Xy0IqoMc8j8qEObksh+mdZKHWEuHKRp83W7EcUg7tmUS1NDdR/siQ4gsXWuz6JI62SoUnBMRoH3qfeqrn9Ni6m6qte7JUtWvPQ4octiyG7QozMHDkdw09MKdUoqpTytlI10AM3xeQ2u4L26yhhX6sAvm2bE6jAnNvBlKr+LMvI7sqO6mVfbf6FlC0mh4MSdbLtY3lWrLAVE3lsECjcDNGhEhPH/rCCBUS0CN02r2uUuOMUhso/ehdt+EwOvHhZRL6WrZ3a5XGrtUgKjCxw7+L/NhyxBl+NgyujSceXZHObSuKKMQ8NO2+FF0QV/ilXQ4gg9BQLtMqeF2Ao4DXNBGJvRljwmFMMdCcESY4vIshiRDvBNvm4jGThdY1OXikFjTwDGlS4VAt/l0YLiE80VqzHkR7xGvWQp5aJSgghVpavEhlNRLNbyWWgQikZ9Sr1bVdwrG4itozTXwdgNjFnyxMoAeeE+Wj8mp0AttWoccXNFnH+Mz1hLsxNd2qMMt80RlpW5zSXLOuSCtiyrGDTxXncrIuQHCPCJRvUiqjxYqZ4a8r22cEdxTH932mlTmzypfa9NJ+ZjOgxlG1xQi//X1Kuh4FkTBJC96
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTLYsPvzgDE5o6bMJ7XgVJ3gLxbb3r0eOCCqrdPqvqHZLTwsCBC4S/f8VCgF?=
 =?us-ascii?Q?GCGQKqnNeF2LaWxepyFtgbCfJ7Me6azBrhP4iO+39ErTU1NmmwD5WXCLD5Xb?=
 =?us-ascii?Q?1qgVryqzELmeixO4x5h/gas0GSpgGJuajpY+UOvRDnveJIgBIlWJh0auBtpH?=
 =?us-ascii?Q?0JPnvf2pIUtbAyKjoruXcbQkr3bivRYmVXUjjpf6ZdB/LTEW8rcokVijtc51?=
 =?us-ascii?Q?uYprnEPRhpWcwTfYtPqOCOdgs+rT3KbVA+zLTSjxM7SVUC4h6gMYIslLGoPq?=
 =?us-ascii?Q?FdEBAEmU4UbjjfL8fV8QfbH1ZTp6NyghOgVEPZ9DlpIBiRXxnVj9tYr3KaWy?=
 =?us-ascii?Q?eVbVBNFDF4wz0NNKiy1jTFy2mAX98//7HOALb27k+JRs+sxaKKdq7EGnpX3C?=
 =?us-ascii?Q?gXeSJQ96hjezbdOu51IJnfDoBJnK2e0kdreKVftRsFUpZHn7Gi+IXdv12US2?=
 =?us-ascii?Q?5PxVL7eNkmPTal4FV1yMS8JPZH2+s5d+RSg7hzOLJ7djy/19gcVeNLIZQp+e?=
 =?us-ascii?Q?+vA9AjyzXhuLuMKGgdYAlbruTGI5YjTs45cS9dsMARSvVqDFi1bSgUVbii6y?=
 =?us-ascii?Q?KJZcPSyhIvoEHjwMCxGyZuRU2Vjzt3PhCtViF7zHi4lwkzuGbGQntEz3GtWo?=
 =?us-ascii?Q?YH5k3BwmXeVyPKySBeG40v2YSkeklDqf3LXIV23Lv+Hb/MDNtCAAUh+VaV3X?=
 =?us-ascii?Q?Pmuh0tnMmatTkEoSEn9SIsKX0aMVgL4rBFvII9Rz8YipPrHkqh/qHB6BPsmd?=
 =?us-ascii?Q?qtSLYTi1QCoIoxxqxWPVH3FUFs4U0T8iDtELkmxExh3o3crKIeP+qeSWPr1T?=
 =?us-ascii?Q?kFbNOf4yC0MkedxusEJXI/MQJJftmONs5MtqLiud6SazW9UtNcYT8JhXePzr?=
 =?us-ascii?Q?oOVAHSopiREUzl+8BUoCLSzVG4fM0MfA3mnvwZ/fmS+4jgH3pjJl6PcVT1xp?=
 =?us-ascii?Q?ldN/fvXEOkoLdU10SbwxWi5LSC7wIuP//ZV7LMrTBU3Zv3qPCk7XTOP5SvoQ?=
 =?us-ascii?Q?AmNDeEpoxEVQ/wm8UclnQnkt0CDHe9STfLsoddGzo84xe8rU0ICfoEsP/Dge?=
 =?us-ascii?Q?cZARyfDKbsdgkeymbQ2lPu4MuIM1uWwba4JnyJQTIl/DZTqfxavYbXyIO/u3?=
 =?us-ascii?Q?Kc2s+qVD06SdKvSW2O1k0JJBR6f8FF3hqXoA8plwccKY8ic7dSTAr8DHIEaz?=
 =?us-ascii?Q?nB659yvZyfJInRFOQo68+RjQgv7OPcY2uxkNL9l+h82h1iSRN7JSzJR6Q4c/?=
 =?us-ascii?Q?OvPG3OO/nloPlIO4blX776Yh3odo6xMM03Buf5wTKXuzhVGi/m6bz82RNT0t?=
 =?us-ascii?Q?OplgWIVlS98nQxMskr1SS120mIkZfxp9NWXp0oG62Rl4zVgVZGokMm2sychs?=
 =?us-ascii?Q?CK4WnX9LG3SO9D14sLBTBw+952yqZPgbC7ugbDz/TruLUJnAc2eZFU7qWxfs?=
 =?us-ascii?Q?GuiIn0QjAHHNo39F79xLbowIQlEQnKhaQk52QUCSvOHxgltR5aLMnJemsLSJ?=
 =?us-ascii?Q?o1s0opE5gHddzpqBcvv4Z7ffX1DFzzE/DWqETipYCdnPY8xMLIEMp1w+Mnya?=
 =?us-ascii?Q?C9gJa6Md/dLL9hPkhn3tLKnE5q4XbNP1hlXRw3c7kr0AmLmOOBkeVVSkAW5x?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8b09c6-9f9d-4860-f33b-08db86da5da2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:43.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5R5jCZdD8wkPjSWjau3Pjmh3FisCrNXLD1yx4ySLZEwG/gWy4NDIFu59y2pRmBnTNQFTDBeZEFxUJJ83H4J4gQ==
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

phy_init() and phy_exit() will have to do more stuff under rtnl_lock()
in a future change. Since rtnl_unlock() -> netdev_run_todo() does a lot
of stuff under the hood, it's a pity to lock and unlock the rtnetlink
mutex twice in a row.

Change the calling convention such that the only caller of
ethtool_set_ethtool_phy_ops(), phy_device.c, provides a context where
the rtnl_mutex is already acquired.

Note that phy_exit() wasn't performing the opposite teardown of
phy_init(). Reverse mdio_bus_init() with ethtool_set_ethtool_phy_ops(),
so that this is now the case.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v8:
- Patch is new

 drivers/net/phy/phy_device.c | 8 +++++++-
 net/ethtool/common.c         | 3 +--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0c2014accba7..ab53d10f1844 100644
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
@@ -3451,11 +3452,14 @@ static int __init phy_init(void)
 {
 	int rc;
 
+	rtnl_lock();
+	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
+	rtnl_unlock();
+
 	rc = mdio_bus_init();
 	if (rc)
 		return rc;
 
-	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
@@ -3477,7 +3481,9 @@ static void __exit phy_exit(void)
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

