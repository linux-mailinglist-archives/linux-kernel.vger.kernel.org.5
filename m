Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974E4772EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjHGTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjHGTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:17 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D9172C;
        Mon,  7 Aug 2023 12:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+tpPBEcHyaljTpIswF8fNpDS5k1LZsjp+y6OtHvJZ3MAblGg3Cpk2CHm183MhvEDUwXR7pYRgg960xQtNeyQU57jfVh6MOI85tNQHngle5K3D5g3wbb75aeuRBpYpBrnFjPZW6yDJAwEJeVJ2jpYLgVPHumzOxt17eaBkwDi+T6J5Loe1zW9fq6m7fcZqVUvxY9AnRpv3fG86GGnI51te/gFgfLyVqMEp4+ehMHNsxGlI4zDAGfwHNoxbB2Cxw2wzuqID5V8NhaiR3WKkQNhZvlS/4Ba2u8axHMbK1K94lnMz3CSeVIYOimUIAV1rRbznEDnVC3vjrvPkTFcXz/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsF/yoN2msUZ792uUMQYCbZxXSYWf9JklEycafTispI=;
 b=Zmfw2/KMMH7RA3cqPljYAoSBo1OwWs4EWwkBXI1iisPBFfKFPTZ+vfhHjo5q1Vs3qM337Pw7bszXi5ClGUQKgY2nWJ5qwSMUxikJ7vjLlaM5quAOl64aHrj+AuOrMfTDEeT6J9TTD9uubzoFR4nBOlQw/Q3W8074Xzs6fN7vpGV4Dx1e8+yGkfoWGryhGLqBdvuj+Hhcr510VWQxM8PAdAqvG/L34jpBHgEzEIa768yyToFQycHD/uXyNzFYehD+ukez5R6KTFMKOlDmkk1TmMLlh39tvks97PPkBoLEhuhu1fFc7LcKn+IzUIs0wufIYQfXOgeQfWn0Gpmnk2O+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsF/yoN2msUZ792uUMQYCbZxXSYWf9JklEycafTispI=;
 b=s7LJBJwEaOeqbXQxqaPx4XOus4V+mOxSktm0Uo5XnE7afyIC/knyG71B68EmeFvm0HWTWtvfMdaXXaTI8IOVUwJ80kF4zeskPHYQ6IMdXKTyqo6VvS5h4noSqvh1PcBTSDFiBwdj8O3/e+NB6T+keWr5EaOG5oGFketZmIvBLnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:38 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:38 +0000
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
Subject: [PATCH v4 net-next 05/11] net/sched: taprio: dump class stats for the actual q->qdiscs[]
Date:   Mon,  7 Aug 2023 22:33:18 +0300
Message-Id: <20230807193324.4128292-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 73414922-1a09-48fe-e391-08db977dc1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydAQHtQFHDe7DP0eBJ0nmxuhJzR8u/XPA+7JRJJS8zm0tkxwNnX6OSio8P0hDywFEbLmcXXwwtUCjKmS0yrLOkifkwqSRqO01S6otqnPz3Xyo1R8yWaxk3bWmJX4knSgYn4oHCejWtMjufdCOjeJ+hVtaAZ1T1W/BSuK5BQ+zoEvv1qvHGaQS/ROEt3QtxZU6NGRg9uXK92/H1ak2w6IiHasoGcZ+p0U3bJe0ZUlFktByXq7p0Esb35JESBetGecUzt7aI65Gq4zh3sdRSJsoC3b4aKUng5Crjf/w76H19H0BMoMG+91jVKLuUvSwhH3vgdNlLXYEN7aWfSkzE6IWZ03X49z2ffPLnbzhCncJ5BeCgsVga50AN52ampUrM9IP4EDZtNrXB6AN2RI2cUTpiJaI9BnNto17BizzxDT+5VmEymezgybwSJuf9hTrCoW2t/7pXJV03NuswUq5muwufy9phpWMfnuPM1VElsehYUXGqQLcedYi/ZRVBBlixMQosYhYEAk0tzl0trKmY4hAD2B6UVwsKfHWhbYMAV6V89xSIMH5o88PO03b/ImiEIpdwkeg9lV0di5GMYNSKfzTv4m8ZTl7ZZS8EUGWfovKi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(966005)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CK1nuBlQBTroKeocsvb5MeFaXapb4WjLyXyYLVO26YY22zmSD94EDQ2L+Mzd?=
 =?us-ascii?Q?ddjejEgoS5R26noGAZ6Lti7JdeRrlq35zqPiHuqkV1BoRfV0ljlqo9F7c8mW?=
 =?us-ascii?Q?wFJps1ERpGtKuWPYE0302Aa3REhExbkRDGOhUt0dDYEVott/dZxLnMrPuTtk?=
 =?us-ascii?Q?cVH6jupIC0Dqwy8+106quqbkkvyv/iIe9kCn14Y1fmJSn/cn9X40XPMpq3Yg?=
 =?us-ascii?Q?+iBNNmJFs/za5g6Aj2RVNpNhsD34GqDYFyBCy9M3DsDzUQtehEHHtY03qGgU?=
 =?us-ascii?Q?o7f+SfDuGUZZf7MmY+tOWxrnuyHyod3b16q6tQqHl0YP7iXLVCmsJxPA/LM2?=
 =?us-ascii?Q?mtc7U0o7IUTwYvMqJUWP1JqzpWP1klxIMv7g05Fjdien9sNUFmY5dtNOQ3UM?=
 =?us-ascii?Q?v0mWdeY1652FGXGZfWvLtM8e6AHUrbRt8vilovenrZugJnqM4MSsbilGtJs3?=
 =?us-ascii?Q?Z9uA+U/YCO7DnHL2+0uheRFRf0RmJeAy6gLvDoSAKpVidDGRIqxdUj/d7Tw0?=
 =?us-ascii?Q?403JNGPfdIzWFFUxAUiLL7Jihyu9ScKIstAqJwLytzGx5n8634PsnrE9kwve?=
 =?us-ascii?Q?TuzXeCUckVvSs0c8w2GmrnMoUje6Gm3pjDhQEY1qFRWKyAfzD6TcHRTajxIz?=
 =?us-ascii?Q?EtaTaoa3mdU5BKjAsvjujW7NZuacNJc0SEJb+cyGAbWEdgqThO0/9HhXCOcp?=
 =?us-ascii?Q?PX+RubKe1BnHQA7hTrV5F7V9ZLA4TbzZIAR56Fkq+Np/g9nblDLkiWxqCKjy?=
 =?us-ascii?Q?PUOUjGBbFutKSFM8AIOK6P0yhuva9njxkpQnvdjbbNCeHc5s1S3+VxbHGcdL?=
 =?us-ascii?Q?QxWNk9UlbeUQOTBd6jgaA/UbNIOcpjfS2vrEjH+yRLPT4Vuft2gr692BTCAO?=
 =?us-ascii?Q?N7ibP/ylieL71B9lJSMgGJF/jrScBGbbGEIu1TxT4yrjd/kSsttgDY5JYJUd?=
 =?us-ascii?Q?SJCIYLy8aKHSLjLjA8ddwRQ7FOrP/MZHf5owpOix3oUOtaQKVuKp6ymrJzrs?=
 =?us-ascii?Q?0sPx6oMVfxEaMKM5zsPytLOMly+xM2Hn1bRwJoQqpPOv2o78xikO3y9GzKbp?=
 =?us-ascii?Q?jhdngyzTa0oKVBIiXfn+ZRZJ+/gbr2jwWcgF0THDXaiUiFhe9CjBVHEN5oJP?=
 =?us-ascii?Q?ncMszTX83Bl8onzJDlwv1Z53nCKjqhbtZBIw8wkemDSHBMbeesZfBg8hPa2W?=
 =?us-ascii?Q?m5W/Nc5FjIG8RG2bF/RJIluR8TLYFvOduV9zLvqIRaBkf3VqHt1hSgXMU3qI?=
 =?us-ascii?Q?N81vFsFqlME19KxKIsbKT/Y4ICXbKtUqD4ElsNRs4jXkqzeR+zcW7TsdbBWW?=
 =?us-ascii?Q?V78+vf+ylJuEIYJmCno8JCcY1k4tSvgQAq6Q0/4mJyk1pFb8PKXE6amoTm7h?=
 =?us-ascii?Q?H0Qp7hwNgg6eRUyRq3MRWedKTCu67oB/lWQjAOTAGYx00pONm/gaeU2yZgw9?=
 =?us-ascii?Q?nE4LkqTvvzwe+nuBsDd8intFs4ccqPJtRJ8tQyL8/YjWjssBN/jnQlVy+GHD?=
 =?us-ascii?Q?4d8xWfYB5xqugoxsJ9ooE3Dym8JjRKOQMO34gtV//Xn4NYfcMnyS6++8N2CG?=
 =?us-ascii?Q?I/1HvwWq2n3wnPpVGmIo9gamyiuGZzmdw59m2spmu2dRr7xD1wzZzJIif1Ty?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73414922-1a09-48fe-e391-08db977dc1cf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:38.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsH6KcAfiwllaFJE06jZfpufs8Zf4NOTxJnjomEjr2UkN3RRGNfLjBxIpQmw7Vr0c3FzzirsvlHyi3J0Gn5PaA==
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

This makes a difference for the software scheduling mode, where
dev_queue->qdisc_sleeping is the same as the taprio root Qdisc itself,
but when we're talking about what Qdisc and stats get reported for a
traffic class, the root taprio isn't what comes to mind, but q->qdiscs[]
is.

To understand the difference, I've attempted to send 100 packets in
software mode through class 8001:5, and recorded the stats before and
after the change.

Here is before:

$ tc -s class show dev eth0
class taprio 8001:1 root leaf 8001:
 Sent 9400 bytes 100 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:2 root leaf 8001:
 Sent 9400 bytes 100 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:3 root leaf 8001:
 Sent 9400 bytes 100 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:4 root leaf 8001:
 Sent 9400 bytes 100 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:5 root leaf 8001:
 Sent 9400 bytes 100 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:6 root leaf 8001:
 Sent 9400 bytes 100 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:7 root leaf 8001:
 Sent 9400 bytes 100 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:8 root leaf 8001:
 Sent 9400 bytes 100 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0

and here is after:

class taprio 8001:1 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:2 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:3 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:4 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:5 root
 Sent 9400 bytes 100 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:6 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:7 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0
class taprio 8001:8 root leaf 800d:
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 window_drops 0

The most glaring (and expected) difference is that before, all class
stats reported the global stats, whereas now, they really report just
the counters for that traffic class.

Finally, Pedro Tammela points out that there is a tc selftest which
checks specifically which handle do the child Qdiscs corresponding to
each class have. That's changing here - taprio no longer reports
tcm->tcm_info as the same handle "1:" as itself (the root Qdisc), but 0
(the handle of the default pfifo child Qdiscs). Since iproute2 does not
print a child Qdisc handle of 0, adjust the test's expected output.

Link: https://lore.kernel.org/netdev/3b83fcf6-a5e8-26fb-8c8a-ec34ec4c3342@mojatatu.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: none
v2->v3: fix selftest broken by the change
v1->v2:
- reword commit message
- rebase on top of the TAPRIO_CMD_TC_STATS -> TAPRIO_CMD_QUEUE_STATS change

 net/sched/sch_taprio.c                                    | 8 +++-----
 .../selftests/tc-testing/tc-tests/qdiscs/taprio.json      | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index d5693bd52e93..1cb5e41c0ec7 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2472,11 +2472,11 @@ static unsigned long taprio_find(struct Qdisc *sch, u32 classid)
 static int taprio_dump_class(struct Qdisc *sch, unsigned long cl,
 			     struct sk_buff *skb, struct tcmsg *tcm)
 {
-	struct netdev_queue *dev_queue = taprio_queue_get(sch, cl);
+	struct Qdisc *child = taprio_leaf(sch, cl);
 
 	tcm->tcm_parent = TC_H_ROOT;
 	tcm->tcm_handle |= TC_H_MIN(cl);
-	tcm->tcm_info = rtnl_dereference(dev_queue->qdisc_sleeping)->handle;
+	tcm->tcm_info = child->handle;
 
 	return 0;
 }
@@ -2486,16 +2486,14 @@ static int taprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	__releases(d->lock)
 	__acquires(d->lock)
 {
-	struct netdev_queue *dev_queue = taprio_queue_get(sch, cl);
+	struct Qdisc *child = taprio_leaf(sch, cl);
 	struct tc_taprio_qopt_offload offload = {
 		.cmd = TAPRIO_CMD_QUEUE_STATS,
 		.queue_stats = {
 			.queue = cl - 1,
 		},
 	};
-	struct Qdisc *child;
 
-	child = rtnl_dereference(dev_queue->qdisc_sleeping);
 	if (gnet_stats_copy_basic(d, NULL, &child->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, child) < 0)
 		return -1;
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index 08d4861c2e78..860b55df0d6d 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -104,7 +104,7 @@
         "cmdUnderTest": "$TC qdisc add dev $ETH root handle 1: taprio num_tc 3 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@0 1@0 base-time 1000000000 sched-entry S 01 300000 flags 0x1 clockid CLOCK_TAI",
         "expExitCode": "0",
         "verifyCmd": "$TC class show dev $ETH",
-        "matchPattern": "class taprio 1:[0-9]+ root leaf 1:",
+        "matchPattern": "class taprio 1:[0-9]+ root",
         "matchCount": "8",
         "teardown": [
             "echo \"1\" > /sys/bus/netdevsim/del_device"
-- 
2.34.1

