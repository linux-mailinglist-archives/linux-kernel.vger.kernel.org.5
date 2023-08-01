Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1448076BC4E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjHASZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjHASYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:24:52 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F47B4;
        Tue,  1 Aug 2023 11:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTgT6ZvxTXuinJvM1QIb72enW40Qo4tRz8lz3NCCGlA3E2/l1PHFzPfutrEcSAbDPklTCyZZsD4eDOe+FwAYmi8HynFTF1EtnypwMr1O2iB1XPDpyHNoIqidRSD/8uJR2B+yy2n12rKB7zk4fTddpJ2CwzFnZhFVhnQDODXPBKUuxp/FKSM/rYbseUTr4ahiVraPTBgrjtnRFz06Y2AVaOP+7w9Blp3Wyfq7PCesNUVjJzyFOkNZB2933GuBGWDgCwWQt5YoVGD0BxR0Bpfj6Nm4BdzTP7ct51RprRuoT5obu+f1bA8hBBdgklhUYSRatovC6RS9zQ6JgsKLSty7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSREhkN8If43NRaMXkjqD1mJ8ouZMXM3qQX6xJmoQOI=;
 b=g/i15qz8ZKS0kZMoqzE8haDeSypOybquv9yfOtMGOWa0zuRW+V4nFhMklBThkrIt0qrkDzvwIbn8aVtOAsBsU30Ufnx8jN2oJQivnDstMWmTmV9MoxG/+OpaLoEX8BGDHtRz+w3AcmSwkd9N4LffqyygWS/eje/FOcS1mYFO4Kvbbh62CtU06F5VhfHHNb+ogBHJa/ATtGg9NNOrwlDd0dleT/SHB1X1wQc/kddUeZ05NvnmyR4sH0QFzQteQHNCw5KvNgSVYnGOH2y8FS9FcCCV0Stv4P5fP6gQijqbICEaNWrVoMzjmTKrHKYSkgOv/tl9dwN+8KYXutMmL8eu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSREhkN8If43NRaMXkjqD1mJ8ouZMXM3qQX6xJmoQOI=;
 b=hnpc+jlKQhj4oo7DCysEIAq2xffUpujm7JlVPKK9htMfcHCDDE/5dFA/FZaFZ2PAF5Yac/7U2aQp3sfNl6OQcUMGlWNMoi/TFC6mKYwoJAQSHihruXDjgtNY2LqhVPdj2p9Pq2jOTGUxtf8F1w92vnNNRKGSzGIt3/8H4c6GBwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB6839.eurprd04.prod.outlook.com (2603:10a6:20b:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 18:24:47 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 18:24:47 +0000
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
Subject: [PATCH v3 net-next 03/10] net/sched: taprio: try again to report q->qdiscs[] to qdisc_leaf()
Date:   Tue,  1 Aug 2023 21:24:14 +0300
Message-Id: <20230801182421.1997560-4-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d9a5c17e-6ffa-4f9d-1b91-08db92bc964e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kk3ItbxRH6Nnhmy7BP7tvxHrzuQ0ate42kI+1UEzknoA53Np5JpEyEib0Se2bhHItm0O+0yi34AkAVIbphRH2JOS2HAH85miFvfz7GuPGGo6qrEnw6BJUbMfTAx2kDSt3nCH/rvNV4BdPgsaue5S05cAT0ghAaGdLPKMqkDKSu7pV/U30bptVToMZIG03nnJLyvAtgpt6ihtxUEL4ZeL+20b7ljeGB+8MZ5mU0fIrhq6KX54oEBE9amPktxrQZmv4QDTSXCniZDempS3ZtkjgKtKhXnljWKBnlJuzMScfLokbjd8KmmeI9OAvvXkSKlk++bXFhHkRLwtabX3t/aMZl381CwHZcVAdsQkno/zLGV19516XQXo8Fwcy1zunmrR25Jz34SEAI+tFEhnF+/xeyfcHgg9BPRNTiTdtBu18sjBe/0SIQ1Mdf4Q6mMWwSVF2QNbRnsI9e2ATgXKDUxWwyyLrfC9hfFu1LAUK+aaW9X8QT4sDRCf2NolPa7ZlhFYu18C+HBuRlFGnVddKO9CtiMo9UsQRrL3vhzZs9FQ03gEREoh0pf4QuMJuZLipMrmGSrBsiu4HMszXIPieyuWrAAali3kzzw+oCydbxjKTVL1uv8pwLWZ++BctWqlYk5E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(6486002)(52116002)(8936002)(8676002)(478600001)(6666004)(54906003)(6916009)(316002)(66946007)(66476007)(66556008)(4326008)(83380400001)(6512007)(38350700002)(38100700002)(41300700001)(44832011)(186003)(7416002)(26005)(6506007)(5660300002)(36756003)(1076003)(2906002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ek5dZHSzCGAMEVTHurvpKR34Yc0y81UoSAaxhgAvOr4ac4bznnSn5tzJnXNm?=
 =?us-ascii?Q?8X3feCRiiyJ9r5SpsQbi8ey41RcbY9lNLgpymJfxsdQNdLcPxFH5HoQsJtZh?=
 =?us-ascii?Q?BsBOfAZPJNkoiqInhdDAtceygBqFfZuzPuQqs4NVcL15zk4smRcepGKo0Ad8?=
 =?us-ascii?Q?y8ukus2Lt4TCZMKT2jBNE18HQq6M7ckKypfZM7IlqE3xWC9wZ3tFsTLIKzsY?=
 =?us-ascii?Q?2+Of0Oq1W7iVjDOYaeqGPNiYtA1UQz6ypR9bN2Hkeqjjh1/VfblIT1vXJH7u?=
 =?us-ascii?Q?u6VSXN5euORK4rMbMUd7F5Q3yR6VG24+Gbss8ImTILDPhFBCZS7Fq9HXKwMp?=
 =?us-ascii?Q?Fm/Xt/6EP9UN69gl2CKpf0xI0JIqJ8ueP7Wh20eklJYI10WL7dX4hwuN3c9E?=
 =?us-ascii?Q?ZOkcNksY+WqV+B7NldbgC98ZXA87IgsFrh0CKL+cikU6fdISPePuxuQaWF0/?=
 =?us-ascii?Q?6S++oCq99QdsoxhTcOsj45lKrKYmxj56r1MNsQHzwBwf24wi9m7Kt5IY+6bK?=
 =?us-ascii?Q?LteA0o1oUZaa4oCaDQEb8N56HuZqHDjdcxZny4ImUV9InKtFc0ul6cphCQd9?=
 =?us-ascii?Q?lAigSh3+R+zokJyA6hf1d1YMHAP0pZ9pLvv8Zld8fa+3N/+fWRNpK3D+Q3hS?=
 =?us-ascii?Q?PqVr2OkwW66i/ROelpxEIeBwdH/RleL87lROFlQWRlv8oStE2bqScNHSoMRz?=
 =?us-ascii?Q?n1cdfnM4To4e6ztA55FEDJX4Uh0FRNy8K0EeYONp2LoDLzWqPQcS38vfIkwH?=
 =?us-ascii?Q?sGEIV2xXekg/5NFH6RrseF5ptHwh6hkJeHakgUbM7pWnAYbKW+AKfi+6guuF?=
 =?us-ascii?Q?h1y+DiFSMSw7w21JG3kqt0PQ05GF9ATWQpUbPhIkWXppJ2j5nuYoI4jDOG+D?=
 =?us-ascii?Q?yue4jvn8bB/1J7AbXbBZNcYJojlkTh+6xDrwhvudgW32TCTVbOhE30ye+KHs?=
 =?us-ascii?Q?XuTM/6F4ED0Dl6sAPzbvaXoQMwnLE6n50g/9lFhkx1TEpjt0zr2BYfHtRn6b?=
 =?us-ascii?Q?SetHwMOylLGKRYwLioYT8v+AXoUmCWgxf73WuOgO4ey4FyfR3zdVIcz6bW8r?=
 =?us-ascii?Q?YAG7Rq+Vl8DJHnmF5ALV/sxaOKdTyNxen3MHfW8IBzDp1ln+4qN17DWlCEsD?=
 =?us-ascii?Q?3Oes7XPcL6QNreM4Z1Qxps6qt+Nc4MLh2zkdjBv29YRtAtjDWb7hEsIiA50C?=
 =?us-ascii?Q?jWxLxdXL9A2iiPnbHXkUniPm9DYzxyeZ+UXIWJM83pbco2YHueyJXTi6CTOs?=
 =?us-ascii?Q?kv6Xp/2WvanBBQVl9u27hzsId9y1diBlWhaMYblYc4OViQO4AZ2+IdCTWfFQ?=
 =?us-ascii?Q?bGi7/piEYYzDgU0OcYN5exaOrwTN0SRosc4nrmNm6pCluIyCsVGfQehyqO0d?=
 =?us-ascii?Q?5Xqr4MLIa1IoV3f8lrrrcvTXehYihJ6KU9t/Y/Rh3oqw1Oj4ZwjgqMyTDE3R?=
 =?us-ascii?Q?h2YbwNdnpRfMxEB2gOatdAq7gPVBQYRtGYhQGmZ8LxnrLrei7vkq1ZD3qaz7?=
 =?us-ascii?Q?Smv6kuBRWHzBdH0+F+33gUtc54W8Kg0iIYdjG3d/UWA3QFshCDQ/EnT8rqy2?=
 =?us-ascii?Q?h5kxkjc0BqacEEp7wzKwETq1AfDNWbQeAfLgV2GGL2kNFH/FpgdnxUUIH/k5?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a5c17e-6ffa-4f9d-1b91-08db92bc964e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:24:47.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDm08WgwXSYUqV5wn4ENE11lonhlzm2FxHYOEprGtvTmWu3hdL0azuCP86ExXeB163oy2oojj0wCRTGmtYSZ4A==
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
v2->v3: none
v1->v2: rebase on top of rtnl_dereference() change for txq->qdisc_sleeping

 net/sched/sch_taprio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 41944197876a..c9ad585b5dc7 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2442,12 +2442,14 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 
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

