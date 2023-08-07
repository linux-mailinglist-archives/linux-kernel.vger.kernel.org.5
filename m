Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D44772EF8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjHGTiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjHGTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:09 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ABF19BA;
        Mon,  7 Aug 2023 12:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amxkys2ghYlEpfdpmcw2DLIzkBHfBBQ7doAz8aKm5ucxLWDw1hP9OTFHmz3JFygokfLwilPONvCyYBT1Y9Yw+uPwb0z7/deRzUVhImANnnzxq5fbDp4AcSEwRr6i+53dJjSREm9aG+Z7ANl8enI/tsZBYklF4LGJ7SlXOWQZ4vAfhA10xgM29vdpbtV6Nu1gqLus97Xbliq5JNbBNtnAogkINqNMkp/CPoawr8N2O1xOcKujHpqqBZfF7mX/0ZJtPrBQLUlkCr2+0wflfcJOOALpM0cRnJznhYgpCAe1MIqsupTh5w3MLXGKpQ5KH1nS5BpIJOX/295KmLGw7Jz4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb4g2bn2KbeapoZ/NtR22nKdzSOsgjXCn/w5rivG9Ms=;
 b=N2sx4oq6YeA6J8li278LyNeXKJqod9pR0TQfg8OcQodDRWOJO/ToUhzW8CWNiHgpSX0ch+jyap2wvAFftVCpB9BhNF7Tj0KAj1qACaO0Jd5cUZkf+hutYPwRjlBr0M3Mo73VyDL+QemuMNP//e1FuF4TGskeiAPqwjAGoEUGO29JLYoWZymi3bDZYb9tKMyYE+rLINWhaF4/kSOohgyKXg6QR6rReCBv9/4aKHNHqGZPZ65BdiKybbCnwG0yyUd+APWzyPoEAs4dfgpnEXB/0GS3OMMzXOxi+Mx7/5Ef98VMOaTB/qV08+ULB0N/ago1ZaZxeOXvDbzlTr38nxFdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb4g2bn2KbeapoZ/NtR22nKdzSOsgjXCn/w5rivG9Ms=;
 b=ORiJbAPQ+fcS869mb/BvopIEMSGCw3aAPM/jTkXifLN1X7CjarY6nMB8esLvsIGwPz0greIL/UHhP0VwklFvU6vC/gYg9+LWI5zZtHCpkNc8mphxh1K/+PBtloEng6AHVonRV4DuqLUUkqn0uRl1fm1j7OQN4WpxuJkYia6Bu+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:36 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:36 +0000
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
Subject: [PATCH v4 net-next 03/11] net/sched: taprio: try again to report q->qdiscs[] to qdisc_leaf()
Date:   Mon,  7 Aug 2023 22:33:16 +0300
Message-Id: <20230807193324.4128292-4-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 76ac0363-ce45-4345-59df-08db977dc07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGn3pXoLmke/LBa3eEo9ud/ZhBwAzxmjoaUBCF5omhpuzS502L9hgw7YZcsmFXylLqOVe395n4QuLQg0kB3/3/qG2rcdtUWAYHccm5C2heWfIodXj91bPvcLpkDjkL75eA+wQF1ljIGgwUJADFZYKaZWQMNek4UeSE3PhxWvLcj++IrK0Xy1OvOFQ3bXPr+A2SbiCNaeLfzUH9E6MsMO0kBebnIZC9kKjov0KP+TlO5ATU3TEinbcLvqBr9+RmnHJf7PV0IcgOepxtFvLDYvQWFb2rKqdEYWhXWrJTZVY6nJFYb0eQjWcl9GuFjKbXktww7bHag6AEK8hkdGooNCEDjdcIOOFoXCaIxF17FrUeHjfEIDt4aZRx3SxZ8SRF0UGFEcHFCXzQqtER0vsXisacmtG/1Evh7QbCxfnU4PPRvX4VPlkOH+o1QWbpAyblMvaxapU2/sRifiB5R8Ziqxta5JExNuRVl15n2eDCPGvzl2kn7a8yBeTXBwsiEkO012TQgl6l7wnP95eqMneB2FcD3MdQzxnQ84LUlPMrHs0MURdqQN/lle0zwQ/0VhCatYQcTkuMYYQnwM394orzSTyhJ6+OUOkDIOmLzw6O+uQziMVgZSZlBeQQb7mtMX7Zoj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?939Iat91FbZIpcF0ORkUfb3H8WPikun7l/ndKj3eMCxtTTe9d26k7+K8N45S?=
 =?us-ascii?Q?eikeElJsUkqa8lwW1n3G8flYNLvwNEBWXNF5gQIF4w3eolZcXtFP0mVmKndN?=
 =?us-ascii?Q?+iHmi8dsrywymrs2C4dsBrSknYWrskQSECJgTyOelNzV/qWXz8qIlZUXnLzJ?=
 =?us-ascii?Q?4ykoU/k3G86S0q7H4UTEetqqyzdTqisktTCkmtZr90V7nzOJyWm4dwC9IY6/?=
 =?us-ascii?Q?34EWYfirM/xrLKifxQIdeT8tWmIx9WZ35FBTroC1169g+KTnzYIh8amUkS2O?=
 =?us-ascii?Q?3dwBoA0sFixJ+ic+3/K5K+t/SxvNCLfWpA+wf8S99AXa+5TxNooPTJaA51tC?=
 =?us-ascii?Q?3E2j6kr5g+oiORUC1UCsLdbMEQnIdSRLgxohUHJKaO/G3AG4LpNPf+UfhE3k?=
 =?us-ascii?Q?MAVaySpzgWrUoeUnuGJZfrDc5ItEOtstczFrde87P1BoVqWBx0QAztc+hRDd?=
 =?us-ascii?Q?dX0V+hfDBK869OCTNg2nBtCDXnT6T21ZsSkasE8lsHhTs7p0tR0TA3dWwHPU?=
 =?us-ascii?Q?KMRhKs2fKhW7ojbSNdLHMxOQJqqeXgxixE0ck0baI4hioQZT2qJPlWEe3Z8+?=
 =?us-ascii?Q?xyv7vKigWXWuZsSVdMZdyvFZ+Q3SYJ6cXRhLJtbvmtQG/vy7vVCxjrC1eaEP?=
 =?us-ascii?Q?e9gy5EG8PsEF15CG4U7qhgREe9/Q9+tcSt42mjhIJVSHJs4fvSSepD+kNgV1?=
 =?us-ascii?Q?q2ceXhHGgThlUvbKsKzuspLDxedy3I/x8q+FPYhOqELMAFvOpOzTH5AlVttK?=
 =?us-ascii?Q?+jgKICP2S0rDFE2aq4seCmdQ6/ZDWXCXNK8ADSGrkyLdipzaxCT5060tmWsn?=
 =?us-ascii?Q?T1tIn/9bBndp7o5uinZn8H7BKlB6buldGh2/yCGE5FZCOqV9zyb5NPmMap8R?=
 =?us-ascii?Q?AJOcmpSKE0xVgeJ15R/IwxM1ZDgfTA9e01wOQspls6JOJjx8hiQxW7ikwPdy?=
 =?us-ascii?Q?M6Ss0HFAP2MlzTACDlXH7gEHBVuxYVvNPCBHBUlqecvdgd15+WocGRpNNyyf?=
 =?us-ascii?Q?O18QKYvAgUY1fM+llD5izb47NPyfy+eXdGftFV19NocjVys4KITp5aWKLNOS?=
 =?us-ascii?Q?JqsuHzBnRfHyjen91G2SctW7UzUhGGy8al5HWjBpyfc6+aV5dMB/gcU4j5Ws?=
 =?us-ascii?Q?L0JBWg/Y0ETeWaSHw7b+KhK62K6XnQQzberjZmKaGSqvkQQ/MN+8/6ALlIR2?=
 =?us-ascii?Q?zxBzuI6ElgMVSuvY0JCvcEGChupA98YvAoCfhKOIvC+nekESNXxkvGGLe9YJ?=
 =?us-ascii?Q?8/CSklXxeB/jS4GdD4JP4nGleb4bwez2b4hJbtyAHu+7Ko5HynzL4bbX0oL7?=
 =?us-ascii?Q?IzzHwKTZ60jIswJoNQcZwTOOgJv3PfQrH7XW6DSfyUwh8vqVeFDvAh7WIRJa?=
 =?us-ascii?Q?EB6oO9XpHmFZptl7DmqEIcZqe4yWGDEGDp8nk3U+TUk/u8WzZ4KyCZxsBkq+?=
 =?us-ascii?Q?+gU14J/oC+Rpt8wfIgkfXVTDpr1DUPlT5ozIPXsd6G1L4u6jpFziutZhsRsk?=
 =?us-ascii?Q?sc/AtiEyKA25nUcN5tCH2w/+ta8fnW/1I2w2FvMvveudfB/qrx7D5GhLRRCi?=
 =?us-ascii?Q?2+zABRwIKniFqHpGR6eFbtntO/iX1HJ19Vd3/QsCymo1DpB76BWP7j644XzQ?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ac0363-ce45-4345-59df-08db977dc07d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:36.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDpzV8BmLeJiRf67jpojMSmJDBQh0Zk3lnYedW2SEFYTc3lKrIK1jZB3uvMUWkzNJxylfwGmuMMpOA0xHiBWAQ==
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

This is another stab at commit 1461d212ab27 ("net/sched: taprio: make
qdisc_leaf() see the per-netdev-queue pfifo child qdiscs"), later
reverted in commit af7b29b1deaa ("Revert "net/sched: taprio: make
qdisc_leaf() see the per-netdev-queue pfifo child qdiscs"").

I believe that the problems that caused the revert were fixed, and thus,
this change is identical to the original patch.

Its purpose is to properly reject attaching a software taprio child
qdisc to a software taprio parent. Because unoffloaded taprio currently
reports itself (the root Qdisc) as the return value from qdisc_leaf(),
then the process of attaching another taprio as child to a Qdisc class
of the root will just result in a Qdisc_ops :: change() call for the
root. Whereas that's not we want. We want Qdisc_ops :: init() to be
called for the taprio child, in order to give the taprio child a chance
to check whether its sch->parent is TC_H_ROOT or not (and reject this
configuration).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v4: none
v1->v2: rebase on top of rtnl_dereference() change for txq->qdisc_sleeping

 net/sched/sch_taprio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 7c1fc3dc3e55..831e6f3fda2a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2453,12 +2453,14 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 
 static struct Qdisc *taprio_leaf(struct Qdisc *sch, unsigned long cl)
 {
-	struct netdev_queue *dev_queue = taprio_queue_get(sch, cl);
+	struct taprio_sched *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	unsigned int ntx = cl - 1;
 
-	if (!dev_queue)
+	if (ntx >= dev->num_tx_queues)
 		return NULL;
 
-	return rtnl_dereference(dev_queue->qdisc_sleeping);
+	return q->qdiscs[ntx];
 }
 
 static unsigned long taprio_find(struct Qdisc *sch, u32 classid)
-- 
2.34.1

