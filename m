Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8125A7593C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGSLFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGSLFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:05:44 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4819AE4C;
        Wed, 19 Jul 2023 04:05:41 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J9jrtt013032;
        Wed, 19 Jul 2023 04:05:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Rder2OAzgtZd3D78Lyy1oE9ERfYSQk2vWQvPHgIJsIA=;
 b=WR0CNPXbJPYXv+0etgl/jTk4pBheic2W5sa8+vlZAu83Zgs4PurbAzAKkTmdJ5d8ucGC
 NZHKm12qnJYFzAK0cwVM9KhGP1aDH2iTzgzMFmnmerc495Y1a4SJBnDEg87t9QMB6Bp3
 B4HrFSFC8vN73NIqGh8XFQdqxpaqxTTT1aLaPWsMfpKrOWm3itxnq/RmcvKRm5BFITzW
 zXQU9wblLM2vp1DDIJ5Wzx3ImZsveVfic36273Z/x5B8FfuqEzlrIBcbrHMPHZsqqFnE
 1LJpjEGJfOHvHX/Y8gYYBveXm4YJv6/mN4HWdJ0OPbh8MMudzWIqfHDYgeaYgomaqMmj Jw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rwyc6jdya-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 04:05:27 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 04:05:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 19 Jul 2023 04:05:03 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id D321F3F704F;
        Wed, 19 Jul 2023 04:04:57 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>,
        <willemdebruijn.kernel@gmail.com>, <andrew@lunn.ch>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <naveenm@marvell.com>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <maxtram95@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: [net-next PatchV4 2/4] sch_htb: Allow HTB quantum parameter in offload mode
Date:   Wed, 19 Jul 2023 16:34:41 +0530
Message-ID: <20230719110443.15310-3-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230719110443.15310-1-hkelam@marvell.com>
References: <20230719110443.15310-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: F2E4IbGbnmpqhJ5q22aeOXWvo0MaXdy_
X-Proofpoint-ORIG-GUID: F2E4IbGbnmpqhJ5q22aeOXWvo0MaXdy_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Mamindlapalli <naveenm@marvell.com>

The current implementation of HTB offload returns the EINVAL error for
quantum parameter. This patch removes the error returning checks for
'quantum' parameter and populates its value to tc_htb_qopt_offload
structure such that driver can use the same.

Add quantum parameter check in mlx5 driver, as mlx5 devices are not capable
of supporting the quantum parameter when htb offload is used. Report error
if quantum parameter is set to a non-default value.

Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c | 4 ++--
 include/net/pkt_cls.h                            | 1 +
 net/sched/sch_htb.c                              | 7 +++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index 1874c2f0587f..244bc15a42ab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -379,9 +379,9 @@ int mlx5e_htb_setup_tc(struct mlx5e_priv *priv, struct tc_htb_qopt_offload *htb_
 	if (!htb && htb_qopt->command != TC_HTB_CREATE)
 		return -EINVAL;
 
-	if (htb_qopt->prio) {
+	if (htb_qopt->prio || htb_qopt->quantum) {
 		NL_SET_ERR_MSG_MOD(htb_qopt->extack,
-				   "prio parameter is not supported by device with HTB offload enabled.");
+				   "prio and quantum parameters are not supported by device with HTB offload enabled.");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a2ea45c7b53e..139cd09828af 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -866,6 +866,7 @@ struct tc_htb_qopt_offload {
 	u32 parent_classid;
 	u16 classid;
 	u16 qid;
+	u32 quantum;
 	u64 rate;
 	u64 ceil;
 	u8 prio;
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 325c29041c7d..333800a7d4eb 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1810,10 +1810,6 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 			NL_SET_ERR_MSG(extack, "HTB offload doesn't support the mpu parameter");
 			goto failure;
 		}
-		if (hopt->quantum) {
-			NL_SET_ERR_MSG(extack, "HTB offload doesn't support the quantum parameter");
-			goto failure;
-		}
 	}
 
 	/* Keeping backward compatible with rate_table based iproute2 tc */
@@ -1910,6 +1906,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 				.rate = max_t(u64, hopt->rate.rate, rate64),
 				.ceil = max_t(u64, hopt->ceil.rate, ceil64),
 				.prio = hopt->prio,
+				.quantum = hopt->quantum,
 				.extack = extack,
 			};
 			err = htb_offload(dev, &offload_opt);
@@ -1931,6 +1928,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 				.rate = max_t(u64, hopt->rate.rate, rate64),
 				.ceil = max_t(u64, hopt->ceil.rate, ceil64),
 				.prio = hopt->prio,
+				.quantum = hopt->quantum,
 				.extack = extack,
 			};
 			err = htb_offload(dev, &offload_opt);
@@ -2017,6 +2015,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 				.rate = max_t(u64, hopt->rate.rate, rate64),
 				.ceil = max_t(u64, hopt->ceil.rate, ceil64),
 				.prio = hopt->prio,
+				.quantum = hopt->quantum,
 				.extack = extack,
 			};
 			err = htb_offload(dev, &offload_opt);
-- 
2.17.1

