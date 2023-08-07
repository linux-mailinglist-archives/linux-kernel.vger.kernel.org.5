Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE36772EF3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjHGTiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHGTiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:05 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC6199B;
        Mon,  7 Aug 2023 12:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idP3zYQUSjq2Y+wERmbFR16kfTQ6Txm23O5lAdzdr3ccMHVzoK37yom255tFNLEQImxN5EWpTQ8VM3QpS+4+ZIz8c8bQVbI84UgMstSk7RnJYPo9cskRY4GOAL8Ep5xzTargUjq9NMo8ZvmPZcoSKbR8r1GSuifc/voUJYpq9nDqUY5p0+beLO88MquLQNOusLeOSODlWYUpp2QRsvdOsz+YZKzvYdwO7H5LSfq5qoUhR+hNiTWoGwZTFX/FS8ugKFIwHIWj/lOw/OF3AQpAAWPfG06N2lANWGi8dg3GTmS56/EjDfodzl+p9mLsEswTSx1AHuMjZfqS0vkBAu/9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLrUkw55ki6hrR4d8Q6Vef9ZHs/RcJuIxgE/ZmBSc7A=;
 b=ApZ2CsbqHetmXt6vo3Pi+TQtnUCOIogtYr7hTGE38/BEEqtq292vfnddgoPUHNW5RmX4N3C98phClgB3RKw7uYeFbJyHTsj3HDOOovMHKEqmIiawiXGE5abB8eaxqddbel3EsTArb2BlukVLz0gL7j2Z87WkS05PdWgcI/mjWBSShrkyzQk/3xLBZbTMDgFiGVhroAbTZ/8obgRfsRrMWKYLRM/H6bwelKRts52xMtwwXOa4ljRfom7dJ6OXFB2z8W/FFhgYiKEC6jZuKJUA9Us3rW9Ls4DGNVYbLkrs4fl9KthdYBeIQVvqSZzKn9cbFsK2j21Netyonwl5MaY5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLrUkw55ki6hrR4d8Q6Vef9ZHs/RcJuIxgE/ZmBSc7A=;
 b=YpgyiGFH64BYHn78eUchfdOYmXmTaYIBYB56jjtc49MyynXGx4VIU9+FCDVK150mla+zRRimwcJgbYp1grJEwvCcztrqtjPoXXIf8R9DW1WZDLuUJ2YHHhnXht5oRHb0LcPKCtfo+oPrWQAuqHnPK4GEqCjZihfD9gY/qqbHHCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:34 +0000
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
Subject: [PATCH v4 net-next 02/11] net/sched: taprio: keep child Qdisc refcount elevated at 2 in offload mode
Date:   Mon,  7 Aug 2023 22:33:15 +0300
Message-Id: <20230807193324.4128292-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94970e8b-63a2-403b-296d-08db977dbfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BwNYeZUpM6ahbN8YW+CJ89CMccOqZB8e547Fai7VfILfrMIDfEQoqNav4v2KA8RcmncZuWFk3slZpKg9jIwY3RqEoc/k5Sc388l/3NtI/uNbJzrmFhoxs8MGvl4bl+dIH3Y6tFaoO0Oa0gWQrqNHQLBPRH3cDCIigu78IT+b9mUnh3aYxz8cgpy9D9O+gxbZixjE7Bl9oeB7z1EUpYRSInK5Al2/WSbUF7nxm8MsLb6aZ3Yrf/Oar/+tMHfH29ZHGpDEaydalRqntntF1FQBqaYOhXFetYqgRgh/Sp7rzJwJ5lCbY7NBEeXlQIub4YjG4vFid3/SewxDhvEeXiTtTaSHLEsV+0D/g89si0LEj0I6YDxYW8PZVeN98jcmyLNAmZKnab7W/YCC/LCtwQVBPQyYePTG5xEBOn2Wfy2+1CoO+t8sEiEJR+b7rWEFUcuPqs+buvrkbTg54c/KGpXoIuFj6yr22wCaaL3I2ndq/NonzbtoOKtrkykj9ihUiu4t2Er9EWQ8VQOq6moB87girM2SZGc0VGK22FNDerPQkr9gpFXljpgcOg1dZom5gl73LzYMJO0V6fk1sAr5ubRi5GFu6Pk8dlEIjOdXidk4qE8QUpg0yGqiCFE9r+9vv/n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rExyUs2J32Z8mT0/vfFjVjvNWIppMwlb4ZHKQmccNyWvfp8aX8CQjt5JtliK?=
 =?us-ascii?Q?uDyYGa7zaWIX7yWWbQn26TW3b6qt6yQJy/2rxAsXBPdgoqqIC6eh1jMEd7un?=
 =?us-ascii?Q?kzA669nG6WFm572+vQhTXQG4ufg/M39zBDee58E0VJxzkV65YiMyU+0ArcSl?=
 =?us-ascii?Q?a2BvbnQWIXDJa8pYIqpJkUHxIf/wjuPdCP4XLSazBa5N2DnrpLdaL0tkIS53?=
 =?us-ascii?Q?jrqwd+qwre6FfqwwaV77EpUDlKv5/o1SeJ047AAa4+tS7uQ5CORDWLmKh3wK?=
 =?us-ascii?Q?GFa3ByLuFkjoXqay7fN2hIjqsGvHKzeFB+/eLAlrMAOBu21lVJg9gkexeMAd?=
 =?us-ascii?Q?x+/qZcgt7uWpaIkHGXp8Fa79uUoorp+D4hMNdEwH7lZLbCpiLztHR46jeEy5?=
 =?us-ascii?Q?JMNWknuK7bjSkzkYftgQJfxXjAXanFxp9wf+R65d2cAOzK6SmFeFIsHxftbv?=
 =?us-ascii?Q?jGahC48NWykcyhqCCVMe9S3EYX3LsVmhKnipUh6O6h9NACzl8MSRzjZuzQYw?=
 =?us-ascii?Q?mOJ6lhIkUrjOUOJTx16Gpd4oYv3CZdTTE/mEZ61L7NziNr5RneVeGmT4VAAD?=
 =?us-ascii?Q?OlG1PC45GP6QqToyHbm7+Fzn7IDJnnAErHWJPzq5hhTahL8FIFtdAFeXjmcB?=
 =?us-ascii?Q?J5MOMAxLT6lawHD6wARPiB2WA5Y/bBL3rIcLAoZ0eWgtlHTso0+CzRA/farR?=
 =?us-ascii?Q?mKXaptKSrwS69dVot2DaycnvdLk59K3fGHvfw45eRthT2yKV2OClAP9mNBgs?=
 =?us-ascii?Q?npGrx2TRFQ/wGFmTmvLB/oGaggfEYGOgG01wjoE409jPTPgm5UB2AdltNHvb?=
 =?us-ascii?Q?hT5dDES5FqFOzWLN8NiXLT/w356nqO4d4AmPzsVvZwAlt0eigE6IDF3/VXoN?=
 =?us-ascii?Q?+l5WJo/X/zLu4bgpq0vr3YHg69zySKwfcvSeKnwGYTzYq/dH/PabsQDlctf5?=
 =?us-ascii?Q?R1LagN0z+A7SkDah+//CpwTLJ8PvfB8S6egxNiLpqIx4tPXlR7czqbESeDk7?=
 =?us-ascii?Q?/glgYgPpGeOMroKpEdRa4/rFcTdbIi0vM5M1Hug1q9/8GQH+peRaFY8qp0C1?=
 =?us-ascii?Q?CynhKZVjn/Zk3awj9zL52HOMmcHsI8TwLBFsv+n9+rylzSPAZAG7OnYHRk7F?=
 =?us-ascii?Q?MDMhUmKrA14ncnAQK+Gt2n0+LfNrBUp1WDnhZm4eZHihd8ina7IgTGMUWG2F?=
 =?us-ascii?Q?stOgzzKf9/UXDQqFs0AoX5U0UQBup61xauUhltWxTdB/O+kKJSMzkfbXImAW?=
 =?us-ascii?Q?7vNaIkUJb5hm8+j9+ThkEvQgHqq39V4buhyUEa2DOIkq6gVFaP/3d5H8ubiM?=
 =?us-ascii?Q?uensaeOFdnT8puyW7Fov2zHBI9v7lRA0BO565TTC/knpZxmQrB3yJjoLrxwa?=
 =?us-ascii?Q?XtwVSYuCGMcB6uwqmC9Pmu5G36fIQDC4YNgpZs57nz8By845g4LGTOS9qICP?=
 =?us-ascii?Q?F1FrY0FKdFXHNYhakDmVX0ChadiE/qEgfgQcgxxkA/E1sv2UlGsDPxzuY7bw?=
 =?us-ascii?Q?38REBnVtlE+megJ0MqsryBLYiNVZ0QrEYDWdwNgCeLQ1cymlI302dpwaPq1C?=
 =?us-ascii?Q?+y9hSSZaRAZR6VStinW7RP43EPrhuVtO86Y1tHTiRWy/0bK28MvoNfT/KftK?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94970e8b-63a2-403b-296d-08db977dbfc8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:34.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4tTKBA01Bg0pGjMm0BBRfnTZ74XoeHRbcOWEkIeFw4W0vCkx5zuvDUV/jmS+cCgJInjuEMRMBymsxvdhUQz8g==
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

Normally, Qdiscs have one reference on them held by their owner and one
held for each TXQ to which they are attached, however this is not the
case with the children of an offloaded taprio. Instead, the taprio qdisc
currently lives in the following fragile equilibrium.

In the software scheduling case, taprio attaches itself (the root Qdisc)
to all TXQs, thus having a refcount of 1 + the number of TX queues. In
this mode, the q->qdiscs[] children are not visible directly to the
Qdisc API. The lifetime of the Qdiscs from this private array lasts
until qdisc_destroy() -> taprio_destroy().

In the fully offloaded case, the root taprio has a refcount of 1, and
all child q->qdiscs[] also have a refcount of 1. The child q->qdiscs[]
are attached to the netdev TXQs directly and thus are visible to the
Qdisc API, however taprio loses a reference to them very early - during
qdisc_graft(parent==NULL) -> taprio_attach(). At that time, taprio frees
the q->qdiscs[] array to not leak memory, but interestingly, it does not
release a reference on these qdiscs because it doesn't effectively own
them - they are created by taprio but owned by the Qdisc core, and will
be freed by qdisc_graft(parent==NULL, new==NULL) -> qdisc_put(old) when
the Qdisc is deleted or when the child Qdisc is replaced with something
else.

My interest is to change this equilibrium such that taprio also owns a
reference on the q->qdiscs[] child Qdiscs for the lifetime of the root
Qdisc, including in full offload mode. I want this because I would like
taprio_leaf(), taprio_dump_class(), taprio_dump_class_stats() to have
insight into q->qdiscs[] for the software scheduling mode - currently
they look at dev_queue->qdisc_sleeping, which is, as mentioned, the same
as the root taprio.

The following set of changes is necessary:
- don't free q->qdiscs[] early in taprio_attach(), free it late in
  taprio_destroy() for consistency with software mode. But:
- currently that's not possible, because taprio doesn't own a reference
  on q->qdiscs[]. So hold that reference - once during the initial
  attach() and once during subsequent graft() calls when the child is
  changed.
- always keep track of the current child in q->qdiscs[], even for full
  offload mode, so that we free in taprio_destroy() what we should, and
  not something stale.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v4: none
v1->v2:
- fix refcount not dropping to 0 after a graft operation - spotted by
  Paolo
- slightly reword commit message and comments

 net/sched/sch_taprio.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1cbc7fcd56c0..7c1fc3dc3e55 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2146,30 +2146,31 @@ static void taprio_attach(struct Qdisc *sch)
 	/* Attach underlying qdisc */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
 		struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, ntx);
-		struct Qdisc *old;
+		struct Qdisc *old, *dev_queue_qdisc;
 
 		if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
 			struct Qdisc *qdisc = q->qdiscs[ntx];
 
+			/* In offload mode, the root taprio qdisc is bypassed
+			 * and the netdev TX queues see the children directly
+			 */
 			qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
-			old = dev_graft_qdisc(dev_queue, qdisc);
+			dev_queue_qdisc = qdisc;
 		} else {
 			/* In software mode, attach the root taprio qdisc
 			 * to all netdev TX queues, so that dev_qdisc_enqueue()
 			 * goes through taprio_enqueue().
 			 */
-			old = dev_graft_qdisc(dev_queue, sch);
-			qdisc_refcount_inc(sch);
+			dev_queue_qdisc = sch;
 		}
+		old = dev_graft_qdisc(dev_queue, dev_queue_qdisc);
+		/* The qdisc's refcount requires to be elevated once
+		 * for each netdev TX queue it is grafted onto
+		 */
+		qdisc_refcount_inc(dev_queue_qdisc);
 		if (old)
 			qdisc_put(old);
 	}
-
-	/* access to the child qdiscs is not needed in offload mode */
-	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
-		kfree(q->qdiscs);
-		q->qdiscs = NULL;
-	}
 }
 
 static struct netdev_queue *taprio_queue_get(struct Qdisc *sch,
@@ -2198,13 +2199,23 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
 	if (dev->flags & IFF_UP)
 		dev_deactivate(dev);
 
+	/* In offload mode, the child Qdisc is directly attached to the netdev
+	 * TX queue, and thus, we need to keep its refcount elevated in order
+	 * to counteract qdisc_graft()'s call to qdisc_put() once per TX queue.
+	 * However, save the reference to the new qdisc in the private array in
+	 * both software and offload cases, to have an up-to-date reference to
+	 * our children.
+	 */
+	*old = q->qdiscs[cl - 1];
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
-		*old = dev_graft_qdisc(dev_queue, new);
-	} else {
-		*old = q->qdiscs[cl - 1];
-		q->qdiscs[cl - 1] = new;
+		WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) != *old);
+		if (new)
+			qdisc_refcount_inc(new);
+		if (*old)
+			qdisc_put(*old);
 	}
 
+	q->qdiscs[cl - 1] = new;
 	if (new)
 		new->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
 
-- 
2.34.1

