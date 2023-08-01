Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D6076BC5C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjHASZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjHASZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:25:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3347D26B6;
        Tue,  1 Aug 2023 11:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2fBZpbgsydlYtemAGgAlKC+8MRVNutWKBh33baEhBpC6wrKAuP60B1XASgvUrnnB25TKI/g0eKRSTkGV3DwUXOwGN7zV/PwOVhXXYUnP+2ZGMb29DkvxvK685onSQlpWsRUMxchhY00+i59DXTMe7tNWAl6nGI61cNIwmAsZ5mxLEdQUSOzSyVGjH9CXJPWMBn4u4vJpjIaEZW9ZJfMuWHBsmGYducywk+T+PCLEIQrLLeVPFnVMH3U8eeQJ35+wpF8DqYlXYjeyE3yCM6wFKvNrO6N4qzxImWn9XmtI5e0EhIpjjBmjpvz8O6cXt6LG+HjVfXgW9MXvP2kKsw+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb6YYObRRKn19OUN2BCcwSodsdYT0N+nUrwxHMRW3/Q=;
 b=eEjdLB1siuN6AeeRRAgA75UYRGhTDVLYBjzFtXaXZNxyr/giV1JTdJlj6+ejvW3X/wJByEmsMGT1K+fTNr4BopFoDt0vzHNeK/RJ6psEkmgUFZFBoQwoSrc4bYKaoG9heOYh4bR+vYNYDC2vvWS7/caO/i8KwS1VMBx3zMfG+vodkMHxfWVYnw/iGOr8nhi2I1qosC4ul29c2UWMeJzP68pX6YubISpiCkQpyN5+jjfonLiOJP5XmnWrKzZ6Zs68+/hsK9ker4HuWUiH/2wr7ffYGmDqNex2utuBUmC5MR65F/CrlNx+I4tINnZhX/S0zmEOmrnEAw3lw6+1UvAAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb6YYObRRKn19OUN2BCcwSodsdYT0N+nUrwxHMRW3/Q=;
 b=dn1j+pBzXU3KYzSh1IEaky14fkOGvzUxOSV+RU6DWGRiLDB6juIlSyoV3ezR8/OeakIQ00nv4hsordwcmDrFG1FmNwKq/7x9xbyj9SsbGegmKEYZWQzDim2EXQUdWVZKqv+L7ALWR6twQyJgQfkcQ7jWVqoJJCI29+y2rjGulMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8796.eurprd04.prod.outlook.com (2603:10a6:20b:40b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 18:24:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 18:24:52 +0000
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
Subject: [PATCH v3 net-next 07/10] net: netdevsim: use mock PHC driver
Date:   Tue,  1 Aug 2023 21:24:18 +0300
Message-Id: <20230801182421.1997560-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0030.eurprd03.prod.outlook.com
 (2603:10a6:208:14::43) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3480c7-d04f-4705-1aac-08db92bc98ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ek54nCvBYx/+NbAreLjZou67o2qeDJm301MeGjcVHXXj5DUxNGuP7zWtTNjIhv6YeKFTeRelnL/CrbA6B82pgzpxdV+OyQAD1C47hvR6x0h1ssY/P35C5hKLueDEEnKBn+rvicqIe/nOqPRuAsYKK9fy0lMek6Ntws2qBuiGWQToCIjNC3YLv5DFA1IJ++tah1W3bdf7Uu59XX7WRhaHyMQztwubvIFtJX/uQ7ipKe+/dsuvlNcHlSus4e9HUJnd2EzuQ2KOJM1uQHIG4XgeUDEb2TmphIc76af951XzfivCsIt4crVXo7rdh/UAo2FVJoUy2HUm0++nOGltQH6d0vKT5hgUGzCiNCXnfQbMZ6Qpv6rccPeGc9zKJr+uoPa3tsONek+il9MR4CZnhBYQgPFbw6JgalDTV34GDwFzC4OLyi8K7ZUFxaXxWICpklaQZC5XryFGOd1GU8JTl6btMNosTkKgerkQaKbPIWj/uCtShGZc2DD4FxzkyBBGrr8gEqZRhDH8sCR7t2DDPx35wx9sx7XR+eY2hdlR3d5dilAKSDrr25SQ0Hl5aL37348Z7XXcPobpZEWkbDtTzCx+OcnGyeVCLN9vmA2/QPnd0eAsYpSa+1OFUgxrrId/c/Eq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(38350700002)(2906002)(1076003)(6506007)(26005)(186003)(38100700002)(52116002)(316002)(83380400001)(2616005)(5660300002)(66946007)(44832011)(8676002)(36756003)(8936002)(6916009)(7416002)(54906003)(41300700001)(478600001)(6512007)(6666004)(6486002)(4326008)(66556008)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iNSwUsYoM/G4TZ4gNNDnYEtZaZWAryNx+4rrglMhgd1aT6s+1AyTNi2xmLMO?=
 =?us-ascii?Q?5CK21hbEPV11wqMkeV0yw1Uo0J1gvcTpYh7Pjl1Wk3FFZyLigaIuhMo9ryUh?=
 =?us-ascii?Q?qFfqIHu9Mrj1/7qlAXvnijZ8Gh3rWJzHWngE3HKxAk23WzbGW1181f9LJHVr?=
 =?us-ascii?Q?Vyv6myygoI9SPvueWQ7T0xvSJIUTb8iRH8UtVv5eB7YZ2G7wO/pnqA89gKBC?=
 =?us-ascii?Q?3sPGByZyQSBJmhp7ki/GejFDedlSxYeoaqXSo11Dux8t2FXHo+1deK5zj9/i?=
 =?us-ascii?Q?ntIEAnyDr3e2VUacELyP5pKy8tLd62MUtn1OyvBJNKjdO22I827vJtRgeJ8D?=
 =?us-ascii?Q?e7WscOUQWtKnqTTLimOGeyERHlpOBM4/uQYn2kQwQkf5QghKive/6ayHe6qv?=
 =?us-ascii?Q?qtHdh+4fJQhvlgEZVmzp1V2sPb43GiNXaNW7T3TGaLm6s17DiQ2ipc42Bpb4?=
 =?us-ascii?Q?v93I6zChIcsCX2oOXo6lQTSfpRbRPJl9ubsOGjljC4M8mSbnCrDlDOmQccjK?=
 =?us-ascii?Q?+CC/rm5UevNbgZTT6R6dzC6ue5xWqLRhJVOkK5z3Yy7Fa0LsOLwXYm8FnLHw?=
 =?us-ascii?Q?D25FBBOAFClGxcvgNNmDs3LON2ARh99P3wSeBWLHaYLRvZsUxWkEmXOqVE92?=
 =?us-ascii?Q?aFSbLEKd4YHlYDvYWr621jfU12qTszAIefG0Xv7Vy9lrafs6N/vV56gglar4?=
 =?us-ascii?Q?XMzUpw6nP/dGt9yIM6nQbfzi/1SLZn48ipMR+f1Q/wlqDbWrgyAzriOYFQtr?=
 =?us-ascii?Q?AmYxQrwljEbLpx3PjV0IZnmQbFoyLr3M09Gfk3R/Ig+mm90dw5ZYIbTBtO9A?=
 =?us-ascii?Q?JxOBnI3jnp8EiWyIvLdSM4l7/SXHY3S7aSWbMrBlvqia9iXYcIGItyXz/NIx?=
 =?us-ascii?Q?1VOb0vvTM2xkquIWSw7YhhFFI87GfnmPdNWCDuyPUTDtt3LwaoslflCyVP2t?=
 =?us-ascii?Q?Wj3BCVuLwnEUpfM7sm9yUys/RXxHGjB4y00ovQG6W/MR4RLRZuWJZ6AWS0i2?=
 =?us-ascii?Q?vKi46nkc3asEq1XgeydZHDbcK1Fd41n7Z3ZWdemLAX5rN3HtNf2UojNgbJ8j?=
 =?us-ascii?Q?jJ/YtrskQ+GGwu7aOgWTiPQcxrp2E34Tlga9hRJJUbXRz2qshJ6Y7gfWla3s?=
 =?us-ascii?Q?2aUOonyfQwRjLkqh0lo71DhPoge9uqc2j4c5n1KI6dZIo9uZAwWd3rtJl22r?=
 =?us-ascii?Q?mQ1a1Iag3sHNVEwCjTt38hChfUQel8+pwxXPtHFET/FLLXedDQPuF+CjSawd?=
 =?us-ascii?Q?QI7eyaGjoxZ3jd4tkGiY5elllgZW77oW2cEBXCUjhwnDNU1/vy76MTZGtYl0?=
 =?us-ascii?Q?9AlxfWcmbqVWJR2dhxsFGBcJXBI4UtflNqp7w7Gz2B+caVUwd49PPsl61pf3?=
 =?us-ascii?Q?4zw09T/3izqUwFcNd/bW6iu0ULT0vVTspHCmlW3nqkvSNZPRS/4QRB6jdJwf?=
 =?us-ascii?Q?CM6d3WZUIMBHmrUnM0PASwNJDqCA/AZfr+ip/FTykgTRjYm0pWefgTnU5M8S?=
 =?us-ascii?Q?uTZU6+Sliupq0cZG4aqppGl5fNgfcHul4Z7fsdtN215v7jXhTR4eJ+RGkp4g?=
 =?us-ascii?Q?dM+nf6suhSyR8mJ32qhHG7q05E70x6G9YX5CGncL8iyqLa6VzSi/+bVjfELl?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3480c7-d04f-4705-1aac-08db92bc98ff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:24:52.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzszChd2bFIBDo+SmpH/CFO37gd6eyIST4GGBuHv72HoekJHcAAur7MWa50xPB98LrYtcfKbhdoHMFvkdO1Mwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

