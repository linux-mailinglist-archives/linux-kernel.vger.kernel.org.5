Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92118772F01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjHGTii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjHGTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9A1BD7;
        Mon,  7 Aug 2023 12:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbwTMNOwmjEocb36i1eD5mehWn4bODRtDOhaJtSGi2VzZ6jjUqIsnusbvU9lmYvy4oiDaxZMnowu4TLyb1Y0XJTw+EKwlJSh8lXJUiLdBRU4ZOjt1fHmztmQ2RtccT6LJy8kMnt86lI+ELOSrFIg9fQ7QKTd0SZB55cHXA4/rIIy8XeOhvBUhqElG6r5UXdLBMdHYFmWqnDMkHqNRTfSqCSp3brk2lSObX38yznV0s9rsL0YvJd7i5DDRA5UcA8029vF+rUXMCAHhMep7eEpEzOdY3dQ3xOvyXpu+/w7vaM5bx7VEiV/SoUd5hdP+hGw3NpmzMJM769qmtA2sDUkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfJPKgZjo6ilxMpG0/qkczuBn9OzDPEQf75G/MfVZSE=;
 b=BI5FI/TaI+GGDEmapgckz+ztJUWxJ8nutPx/aQJEM4VST0tTDPjC+fOyxxiYPON+cqxaJIKbNwDq4KFd20fD3oX9qQhdlrtGpO9m1yx9vruYYoCKbmZCdKAiLxgXMqrAUldpGsN046ksy1TS9T8P+YJgLVFusn+vV+xsoq2/FG0zEwUSsfqIdqzpVQhbIkKQHWl8RoJjAKDHa/VZ48HulT2hl14XM/ORmhWYHp1K7KhKlblhgHTbKNKJtr9L95y1PCDJBaO+yUgqJvll+q4cBMby1CbXp8tmuo7X6fo5JgJbYdeyES38VLMLmaxUO0HJEata0305yiwRtdLax/kklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfJPKgZjo6ilxMpG0/qkczuBn9OzDPEQf75G/MfVZSE=;
 b=B+xHM59KM8p1Gtwk+0axclzkwJ0rz1ak3TZ5XPUU8dRs5qg3i63lNtM3B+5KLM/w4ZhfV529UDPmBbRLKy5bNyQhNScJrsp1J5iAre5IUaQFhhAHHnHBgqZgeRmgDBPiL7liqd4sYKHrSNjDYvNFrGxdpNTAhVqGm3FyfcAVeCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:40 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:40 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: [PATCH v4 net-next 07/11] net: netdevsim: use mock PHC driver
Date:   Mon,  7 Aug 2023 22:33:20 +0300
Message-Id: <20230807193324.4128292-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
References: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: d79afeb3-33ae-493c-f6a0-08db977dc32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dpqiaiEwORhhPRtL1De0sBK5PQTRNQKyPjYOdNxs2ORzSm/ir8MsalXwo+rVntgiUEr5VvwBT9BS/ARjabVpucFcXgV6VjM/mkpQ2k7wdxij6CNe/DX+sxiCj+CpR5ZkCIYWbSYrK8/TT0XHfEdWd8As0pUJM3yjvIDx9ClL9/YyhAi1RIi6znKCbGyfDGQwV7C8RmbAlr3FaELhR0bcaNfYg2P2nUGbRdzro+vHRirCQzjErSjs3qU6jXm7wN013qy1FSVHNFHZE+vQrXPYqju2sH9EaCxsdPvQy7q1XK6GleFhrvIOcK4Mk+zRlfEtAh9qrU+5O/xjTGyv1CBCJqEP8jxOSsc7mzfFy6XEbej4TH5pqKn5UKiLXLyiaTMc3tYyojYGUycl0ScfQKAyM6HVSXmwmFNzDj88I6RqfrUdo9xhe9+BUUvDGctC1+56Blnr8PuAW5xdOeFmPxKXgsJdp8v5yf7jnJ5BoUZzCmrLcKra6t4V4c3eZiVSSQKVAbKZX9HlYH3J9QIM70pY3GikXRm/z+hp2/NCP7ist+TZFg5JVo4gOAwj/4t7lw4DdjwsrUxGBoIL+WM8uRJlvH21udfukqYeNGZNtcwc9zlLx4EpU/uNnGJcmmXFYZr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6Nu/jo2Z8Dv77LTISbxVb9rOoMCq8IfetPy23/n+Ohhs1oihbUhcAsx6Ki9?=
 =?us-ascii?Q?PvFNh8+QYIab6DMpYPZrX9SuLJGJjBps+uZmPVVPUdcsCleSBPQtSEOg487G?=
 =?us-ascii?Q?kzDKI3mbhtnyxXCs8oW1Cz0YSUpBNK3gNlq9S/KzWWmIK2s59/twCzgV5+UJ?=
 =?us-ascii?Q?6ftA3hqDg/blshe8P/eHLXZrZixiV5sgLXffdmQiy1BMHPsgU3XHXfKJ9m+S?=
 =?us-ascii?Q?RpvkqFMLBuI89NymvTPQovEXhiwviQyXMGiI84Rd7XuVLEz9P1RjHOEnLgDj?=
 =?us-ascii?Q?xL7bxlQ1q70syUKIYeO0hOgWVqcCDFLiNdRHHKgKYNSh96VxeouYr+eq85U2?=
 =?us-ascii?Q?JPocKrm2jnd8cMqYsvG7ZkfKYHG2XVcXGJ1fdC9c7eTz58t9nvkZzYIAyNaA?=
 =?us-ascii?Q?mcdauAWpahJBhQMMEHJnuy07vr2VgCdiK6D1QULG3ARjRjrMP+807qSTJLgb?=
 =?us-ascii?Q?rEYrvPAZXVMzEtwDOwDqQR3c/qeYAoDOb10pLMjaLVoD4OsKHW1IVQOhMJYD?=
 =?us-ascii?Q?4Sd6w9kep5nasDvQGBU7ZhS4V5x3wyWZ3lZTePE+DwQckO9hZo1wCVwKlU/C?=
 =?us-ascii?Q?5kX/mhU7nZaibAnBWn5uuAiX6s2y9Eb/6fueIMWR0d9JaHIAb5cshnM00p/z?=
 =?us-ascii?Q?jrfsMwlIXiXORE2/gykAs/jH/og0giwXIz/gnBnb/tIXOh+UvRBFgru9IwkY?=
 =?us-ascii?Q?cU0nemNbPTj2GZ6Q395ySAAhZ2yrcLg2O9BZDu5S9ZnrHNCEp+1GaXurVdFj?=
 =?us-ascii?Q?uvwR6AHoHAtUzdHq5iFCtWoKK/vqu/qYjt5MrpPx7dUzZ677x2ZS8atEDOPu?=
 =?us-ascii?Q?61A0zsBc2R09/TWzoEQKQJrhDcYsdm8RXJignW6HvpM5PTW0/mu7ZkRzLoXo?=
 =?us-ascii?Q?MyiICuBPuXvaT0izguavAkjY8+o9t6l6aeDzI1lmEaROG9TnniW1GUkAM3ng?=
 =?us-ascii?Q?PX2LrXPttR/wdMf7EBR+UUtS/jGIO8WkuEOmIFtnQg9fTZUrAE687VX+anOE?=
 =?us-ascii?Q?9hJ5OibsLoNQkQEKfMC4BknFkze2KPenMH3MzMgLbNdKPI1xAqc9YceFKt6u?=
 =?us-ascii?Q?O45dN14GgOcsf6T/J9GEuyIrXusMeEQz0hX5+md5tbYfR+BGaOe/gyVRoCHd?=
 =?us-ascii?Q?KN8A3veBrSHlxrQqyyC32gnXBDnn9eRG658ah90iJ20KlWjHW9Peyf5h/n7O?=
 =?us-ascii?Q?s1KSW2gPxSbmWJ2xPC2u3Zr3DEKuF65mlpXvLELhMzFljegPhYCnbWaJJ1tw?=
 =?us-ascii?Q?GLe6dX+pmb6REX4c55VvkvMx229Kqv2NHTeScCzgrXyaf9l/HlitC73Sj/iG?=
 =?us-ascii?Q?/1ceH6AM1PJziDgbkEetVfU81/jmGxHyPWeGcz2IElPkF9hdIHXCk3Ll7/mb?=
 =?us-ascii?Q?aZoaK2/jze3I0YD38hWyfRKeKKewb2iLWdAKtOASrP2B0cguExQOmjajsqf6?=
 =?us-ascii?Q?8ttOUXCZvp9iiGyyYEfCZ325FI8lMLJxQ4t6Bcb3zx2Z1swSdMeHdWv4Ft7X?=
 =?us-ascii?Q?R0myw5hjrEHVjQgfnH6Hd0FPmUP0WsBX8gog/8lqrxVWe4aWtox428TyEKsw?=
 =?us-ascii?Q?S5M3k6fCmc0M9WtlHK0a+/2IvNmbo52ZBj5hqSzvMkARRDz290Aw2yUGXcOj?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79afeb3-33ae-493c-f6a0-08db977dc32b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:40.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnKInOcUNR5KtnqC8+yAlfBIhU8HoEM6/qeof39WqLpUAtb/Q8sDMIuEyf58MMXFOIq7822gxVjyKFzqLXBKMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to make netdevsim offload tc-taprio, but currently, this Qdisc
emits a ETHTOOL_GET_TS_INFO call to the driver to make sure that it has
a PTP clock, so that it is reasonably capable of offloading the schedule.

By using the mock PHC driver, that becomes possible.

Hardware timestamping is not necessary, and netdevsim does not support
packet I/O anyway.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: none
v2->v3: split off from common patch with ptp_mock introduction
v1->v2: patch is new

 drivers/net/Kconfig               |  1 +
 drivers/net/netdevsim/ethtool.c   | 11 +++++++++++
 drivers/net/netdevsim/netdev.c    | 11 ++++++++++-
 drivers/net/netdevsim/netdevsim.h |  2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 368c6f5b327e..4953c1494723 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -592,6 +592,7 @@ config NETDEVSIM
 	depends on INET
 	depends on IPV6 || IPV6=n
 	depends on PSAMPLE || PSAMPLE=n
+	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
 	select NET_DEVLINK
 	help
 	  This driver is a developer testing tool and software model that can
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index ffd9f84b6644..bd546d4d26c6 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -140,6 +140,16 @@ nsim_set_fecparam(struct net_device *dev, struct ethtool_fecparam *fecparam)
 	return 0;
 }
 
+static int nsim_get_ts_info(struct net_device *dev,
+			    struct ethtool_ts_info *info)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	info->phc_index = mock_phc_index(ns->phc);
+
+	return 0;
+}
+
 static const struct ethtool_ops nsim_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
 	.get_pause_stats	        = nsim_get_pause_stats,
@@ -153,6 +163,7 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.set_channels			= nsim_set_channels,
 	.get_fecparam			= nsim_get_fecparam,
 	.set_fecparam			= nsim_set_fecparam,
+	.get_ts_info			= nsim_get_ts_info,
 };
 
 static void nsim_ethtool_ring_init(struct netdevsim *ns)
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0c8daeb0d62b..2a4a0c4065cf 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -291,13 +291,19 @@ static void nsim_setup(struct net_device *dev)
 
 static int nsim_init_netdevsim(struct netdevsim *ns)
 {
+	struct mock_phc *phc;
 	int err;
 
+	phc = mock_phc_create(&ns->nsim_bus_dev->dev);
+	if (IS_ERR(phc))
+		return PTR_ERR(phc);
+
+	ns->phc = phc;
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
-		return err;
+		goto err_phc_destroy;
 
 	rtnl_lock();
 	err = nsim_bpf_init(ns);
@@ -320,6 +326,8 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 err_utn_destroy:
 	rtnl_unlock();
 	nsim_udp_tunnels_info_destroy(ns->netdev);
+err_phc_destroy:
+	mock_phc_destroy(ns->phc);
 	return err;
 }
 
@@ -383,6 +391,7 @@ void nsim_destroy(struct netdevsim *ns)
 	rtnl_unlock();
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
 		nsim_udp_tunnels_info_destroy(dev);
+	mock_phc_destroy(ns->phc);
 	free_netdev(dev);
 }
 
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 7be98b7dcca9..028c825b86db 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
+#include <linux/ptp_mock.h>
 #include <linux/u64_stats_sync.h>
 #include <net/devlink.h>
 #include <net/udp_tunnel.h>
@@ -93,6 +94,7 @@ struct netdevsim {
 	struct net_device *netdev;
 	struct nsim_dev *nsim_dev;
 	struct nsim_dev_port *nsim_dev_port;
+	struct mock_phc *phc;
 
 	u64 tx_packets;
 	u64 tx_bytes;
-- 
2.34.1

