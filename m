Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9368776BC4C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjHASY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjHASYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:24:51 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825AB212D;
        Tue,  1 Aug 2023 11:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O42baUgw7VgAFqBgVbXA2jXd/mBt4HoHaC0raHKgV5luQ5XU9cV65nJXIS7wKF5LC9jviwJN7txzGnJOBJH0SmXe9vMKD10gLudC9PD9rdbNCnUqe76w3QOHqr5WqYbh8adZ+NXkh5HbglWvclVujfiDdl2uRfS+yTy8IuKrPbMURaUGvdfOi727UXwjgquAh8mgDVboCIal+PoClUvWOiqEDnghYdxmsGCTwOBmSrVrX4yWEX2t9vw1zI3Gc/KI0Fvui8CXP1wlxDAxtPniNMXxzijPMcLKFdz+IXYiIAVatjm7yojEEr6LdQgFsZpVVyfb4Fs6muJ2sTBJ95+kvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFZ6mGQKixAu5FPLwqzf+DqPUKqwfxELlJHcSmh9gZI=;
 b=R/Ndt/WqxPRS9JSJixE0RhhO7UeFliW8Zk+jGYOQiMQluF6kSFodSqzXKhK+ZsHAjlXTyj7YDU1BY8tT44uNDoIFs1rdfiFEow29u6HsXG034Wa9sHuASFquBmRofwKbhxjD7NECbWD+h/iPSB17i//67mPl36Oa88mtDju0Mj4b2Hie7Jfvb1zoeoJ+6614buwgzPXIrBBFqCw86eVJl6xIV7BoJ2JRibXC8HmOwLWwv+oG+PnEeiW7z9P5TgV1PQNF2JVeBmmxA+MiA6VLcKr/gGIwKYkduRZTRJ7bPs6zB2CNOXTdhpLlXgrLW7fdaVX4L5P4YFLGNj6Oepv28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFZ6mGQKixAu5FPLwqzf+DqPUKqwfxELlJHcSmh9gZI=;
 b=OeUICsX0ohmV2YyrxB8mbk4gHs5lceIqHjcjvbvonnfAUXCrr6OVgNuPEg6KmuA84Cxu4trYKFhTMvoNTmoXHIcyVQgVSVnKicHwhV+uJC1Nyc689YMvBKZ7VoHAwC/pghdZtqMgqCoIMqEyXyvz7f0ofwEmkrh+JpDR+Q/DrT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB6839.eurprd04.prod.outlook.com (2603:10a6:20b:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 18:24:46 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 18:24:46 +0000
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
Subject: [PATCH v3 net-next 02/10] net/sched: taprio: keep child Qdisc refcount elevated at 2 in offload mode
Date:   Tue,  1 Aug 2023 21:24:13 +0300
Message-Id: <20230801182421.1997560-3-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: b807432e-4a75-47ca-746f-08db92bc95a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ie78BxTC4kUo8N7dleRfeGNWmC+iVlaXUyM2K89Ok3S1FTwE1HXrqA5Lp9CWQGVWYtmOm7AdWibRXDMknVHl87MuD5GVxXhpUvVzh8qp+Oq/5GRt0TMHZnvEewkWVkS2NVBPXo/T05DNb1JcoPHNJd1G3fZvbdoe3MoZzq7aWEPEGsMUZRLr+BPpMGE+r+TEapp4CEA705V60Ie6c6NommW9oiU9x60xGA14hZH/WBEoxws0QQCiv2y3P5V4yZ4GG/pGEcmYteRQbraM7Njtsdtj/tE9KDMDouZfIhnwYRvMhsTlQ7bibswrw7nGvukWH3JC41k9buD/5+JYr9f4VdHEHbtEnK9ivMEHzmVbIL9PJE40qePZjc3TH6cK3pKHhF6VFUX0NGJrd/KqbUVD62NH7tgea/WDDWCflDz4A/02NDa/wmndnQMnQ+nboE7R1kzo9GvvtqKk2Yoh8I2hvcmuWBoAguBd0MMBZNFaFJWhsFpdZw0J72xdzIBvsdSlgbPUMLhnvXlShQoLagV8txVuZUZdFXrDZL/YeNzbTc7qfgnrs3zvPwIEd+73kZxkiaIEeBsNvkJjmd8eC1RhT7b7U/JntpmSq2BEWRs6EkOGiug604jxB11jLQ9eaSNd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(6486002)(52116002)(8936002)(8676002)(478600001)(6666004)(54906003)(6916009)(316002)(66946007)(66476007)(66556008)(4326008)(83380400001)(6512007)(38350700002)(38100700002)(41300700001)(44832011)(186003)(7416002)(26005)(6506007)(5660300002)(36756003)(1076003)(2906002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1taYLr+/0dt39e5v3Uk98ItStQQWI1iZxZCwqMWkGFB9Aifh9MMYKG5bXQYN?=
 =?us-ascii?Q?bqt7VYygb5eotwhAxJnY8w8g6za1uDC8PjLZBZoVwhXheKUwkin10ScErLVr?=
 =?us-ascii?Q?7HEh7sQZLdrwB4+E4NcedlX2azuJcsypijaA8kLYISeqHsaoAxbGAgtdnM/3?=
 =?us-ascii?Q?Kuw0WTgu1TtyVeDqAu1UQsYeDSEiKl2alZWMrJauYKJzIPNUHz/rE75jL9aE?=
 =?us-ascii?Q?t4z/x4TPU1G3HJLUgm2oD2YkIIB7bQm4waPR52b+tmcnwyuzlo2kIarNxSwO?=
 =?us-ascii?Q?llTZtNO+DoGenrVfxFk3ulnNXwZSoG14HoXnw4fy5YqI3X4l5+E9OmsiPWZC?=
 =?us-ascii?Q?SQHC2ZQSUnfPqQMz07RLSQUmhoPf9Ri6xgPjrdb43naznT7sGPOZj7tMRHXz?=
 =?us-ascii?Q?gxSu9ShX/+dM9RIBDwiYeo8edjC0iWhbBqOI/sBVBtNssBdcOqD/bCKvoKvw?=
 =?us-ascii?Q?II97U1/Er23jkP+YGbHn/0UoAuBAgtYrqISVLRmaMLzQJSPk1y5GTwG+h9Qd?=
 =?us-ascii?Q?Hn83dQZ632JhGHIt3qarlSGu1QAox4sYA9H7NirryDURbbBuMHu1eptvQQFu?=
 =?us-ascii?Q?om08FyDwAcktVYi8fzMfSIeALYnd9gjGj+ZEMazxbpaR8ryo1zJcsFp1I9RE?=
 =?us-ascii?Q?S7YdtSIUQ2B44t0AVvSS7VS7FTC6xT+MR0cmwgqDlW5gbWfwAhm4yOs6vJsJ?=
 =?us-ascii?Q?n/xsQy4SbVeN2abSMknJh2yceZpuskbAK4dPfctfO/4qLLt16Y0VyOQc5h+u?=
 =?us-ascii?Q?uZty4+0qv6rXTcu9cie3bYnmXkGBmiMIXSwKsIckuRIi8K14jXBszLqKrmva?=
 =?us-ascii?Q?qsz83JzaZbUteHRlH0YUZctG8ntEraep6U1BeK+Eu7LHa1+XXto+zdfNbj2J?=
 =?us-ascii?Q?cMFUgLDkNoLthWxW1BAriUHqopkOzSLhLKoQrd3u5AS3yfrng231rj9nELXR?=
 =?us-ascii?Q?NS4qCdPq/cpenpfzRgJrKOKcJQNJ/DljoZoT81pbCv70VV3Ykohm2YT/K7D5?=
 =?us-ascii?Q?nuWGAKMICam8PJ26+IV1Xt6wkEMrEzgFW/S+rS0F9mZPIt0yOmAdLZTe5irR?=
 =?us-ascii?Q?6elVs4/aCU+xBv9dCwQ8QU4I/05r9g9PkbrMuFzOGnZ/QnxGYjRoKTqpdtg+?=
 =?us-ascii?Q?fCbvlrLhKuEbxC4JmdCGrS+i8yLT9Okr9F4wEXmiidoA9tUD39k0PnGKSmhQ?=
 =?us-ascii?Q?UPQqUA8ehBuPJ3oiS5cJ87XrZwtlP/Jjr/OriMiPEDU5PLKsZnoZ/qvrlJwf?=
 =?us-ascii?Q?nrU7mFygvrdHr8DAxx+H25jMB4K5dp+0kWIJg491XFRwvSuHsczAIfCc/g7A?=
 =?us-ascii?Q?keiajPdVNpw3ODfFBwI8sL97xRMIbcSSxVwWgycw9BEuL2qs+gHRWPEqFGkQ?=
 =?us-ascii?Q?KNNqDcue40RbhtxGFx/Pbnv1NBTdxk4MdZrYFs5kggrYPCcdh4zlQEN2WrY4?=
 =?us-ascii?Q?SS0T1Ct+9vzQATfBpK60imu8sPM/z7G7p4RSqW2/k9ivPOM3SrVDDW7wixNS?=
 =?us-ascii?Q?JBzge/4EkJ4ZFSjGRHRwyDWZoPr4hUCLO6bfSMlaaitFUCwqWG1BZb5utWzC?=
 =?us-ascii?Q?ZZ3cqTyhmuQSl6qx78k9lM6ZNfPlqPbVLt4KAWKZRHhtUk9Q7QMZeg10MoWv?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b807432e-4a75-47ca-746f-08db92bc95a2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:24:46.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBzlEzhdG0KJmpwfNV+GSRi+CqZTC7xzUGjYy0ySgkS7hcBdztCSHCXbzbv0CNoMscgloaQUhQfYy6Fn5jTmDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v2->v3: none
v1->v2:
- fix refcount not dropping to 0 after a graft operation - spotted by
  Paolo
- slightly reword commit message and comments

 net/sched/sch_taprio.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index d9ff75a08e12..41944197876a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2135,30 +2135,31 @@ static void taprio_attach(struct Qdisc *sch)
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
@@ -2187,13 +2188,23 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
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

