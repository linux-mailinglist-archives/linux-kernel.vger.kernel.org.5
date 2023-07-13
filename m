Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0175187A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjGMGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjGMGBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:01:45 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5821FDE;
        Wed, 12 Jul 2023 23:01:44 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D0bWCT029333;
        Wed, 12 Jul 2023 23:01:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Rder2OAzgtZd3D78Lyy1oE9ERfYSQk2vWQvPHgIJsIA=;
 b=HoTPrllEUWetgqBrczDd+JpdueAm0EjUHttCtpHjCW8nNg0Tgg4MElT7l3b9JdVB5Zop
 J9XhDO0V/3KHcG6dMpTVoDLUbM7DDrthXP3dR/nuwuIAcVS8z9tI5dPJe6kaVXyVM0Dd
 pPorGm9wfqZePKaGYKe47OGiYWh341M7M9SHlEbsztJGCdGAGUr8y0g/hBimtUfy1Ljj
 14BO75x3NYfLUK6kGiqjKmak+bDzri7TG0sYoId4DOOOG5MgMwm8Mslp2WVB/6AOSk8m
 LMNiDbZR6sA3dZgS7UOfVmnIvbjyqpcxXruoBw/oedd4OL60ERWA+rhifnEw4Ug9zFqM 5g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rsb7rf074-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 23:01:32 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 12 Jul
 2023 23:01:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 12 Jul 2023 23:01:30 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 1D2D13F7075;
        Wed, 12 Jul 2023 23:01:24 -0700 (PDT)
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
Subject: [net-next Patchv2 2/3] sch_htb: Allow HTB quantum parameter in offload mode
Date:   Thu, 13 Jul 2023 11:31:10 +0530
Message-ID: <20230713060111.14169-3-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230713060111.14169-1-hkelam@marvell.com>
References: <20230713060111.14169-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: _OCsBrhDtcJMOJ0pTtd4cYwV_w4EVb3P
X-Proofpoint-ORIG-GUID: _OCsBrhDtcJMOJ0pTtd4cYwV_w4EVb3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_02,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

