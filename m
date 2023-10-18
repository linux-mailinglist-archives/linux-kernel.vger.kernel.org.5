Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5376C7CE1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjJRPvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjJRPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:51:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3F2118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:51:37 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IFnbhj010839;
        Wed, 18 Oct 2023 15:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YqEAXhIbrZO4p/9m5sqSlbZgv6nkuUCB6eyMpurijrg=;
 b=FWq+jFkDCm5XlUxZ+WLQAHhcKEYpE4VA1NdAlT3+x52dt0uC3qmiC5+nZzXblNyb6sT/
 IBb8GkvTLMa8UGjz3WrO3+gHKSymFNWo2fl5LqObNuXvS+VWAS8g7B6wGWpz04YP5YwT
 3r5UNUKUoEJEDADF7yBydmT3Z+KkNUskm5OC7N6zslmqqGmJ/c/PhoklgqlnAcPFiPE6
 1N10szAakH6TaAxb/oQ0qHB4J1h6fuHOIa8nKlIJDLm9tBOLdqfeTEo2qmzQn65eQMJh
 DjUVhoyzpANGRomA2B7iegVFx6jhdENylwqblTnGFNaaL/Sin8jOU/f9Bh39Tlozt/R4 pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttjbg02hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 15:51:10 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IFnmAZ011098;
        Wed, 18 Oct 2023 15:51:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttjbg02eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 15:51:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IFnLFS031142;
        Wed, 18 Oct 2023 15:51:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr7hjsa6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 15:51:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IFp6Fx15925890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 15:51:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 127932004F;
        Wed, 18 Oct 2023 15:51:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1598F20043;
        Wed, 18 Oct 2023 15:51:03 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.43.47.66])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 15:51:02 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH] sched/fair: Enable group_asym_packing in find_idlest_group
Date:   Wed, 18 Oct 2023 21:20:35 +0530
Message-ID: <20231018155036.2314342-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DV-vLiv0mu1yWIaV3yrjhV5iCunaLvup
X-Proofpoint-GUID: 0FNOajdg9yX1a1BNOmfNOV9nZiG7JcwF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_14,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=914 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310180128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current scheduler code doesn't handle SD_ASYM_PACKING in the
find_idlest_cpu path. On few architectures, like Powerpc, cache is at a
core. Moving threads across cores may end up in cache misses.

While asym_packing can be enabled above SMT level, enabling Asym packing
across cores could result in poorer performance due to cache misses.
However if the initial task placement via find_idlest_cpu does take
Asym_packing into consideration, then scheduler can avoid asym_packing
migrations. This will result in lesser migrations and better packing and
better overall performance.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb225921bbca..7164f79a3d13 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9931,11 +9931,13 @@ static int idle_cpu_without(int cpu, struct task_struct *p)
  * @group: sched_group whose statistics are to be updated.
  * @sgs: variable to hold the statistics for this group.
  * @p: The task for which we look for the idlest group/CPU.
+ * @this_cpu: current cpu
  */
 static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 					  struct sched_group *group,
 					  struct sg_lb_stats *sgs,
-					  struct task_struct *p)
+					  struct task_struct *p,
+					  int this_cpu)
 {
 	int i, nr_running;
 
@@ -9972,6 +9974,11 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 	}
 
+	if (sd->flags & SD_ASYM_PACKING && sgs->sum_h_nr_running &&
+			sched_asym_prefer(group->asym_prefer_cpu, this_cpu)) {
+		sgs->group_asym_packing = 1;
+	}
+
 	sgs->group_capacity = group->sgc->capacity;
 
 	sgs->group_weight = group->group_weight;
@@ -10012,8 +10019,17 @@ static bool update_pick_idlest(struct sched_group *idlest,
 			return false;
 		break;
 
-	case group_imbalanced:
 	case group_asym_packing:
+		if (sched_asym_prefer(group->asym_prefer_cpu, idlest->asym_prefer_cpu)) {
+			int busy_cpus = idlest_sgs->group_weight - idlest_sgs->idle_cpus;
+
+			busy_cpus -= (sgs->group_weight - sgs->idle_cpus);
+			if (busy_cpus >= 0)
+				return true;
+		}
+		return false;
+
+	case group_imbalanced:
 	case group_smt_balance:
 		/* Those types are not used in the slow wakeup path */
 		return false;
@@ -10080,7 +10096,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			sgs = &tmp_sgs;
 		}
 
-		update_sg_wakeup_stats(sd, group, sgs, p);
+		update_sg_wakeup_stats(sd, group, sgs, p, this_cpu);
 
 		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
 			idlest = group;
@@ -10112,6 +10128,17 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	if (local_sgs.group_type > idlest_sgs.group_type)
 		return idlest;
 
+	if (idlest_sgs.group_type == group_asym_packing) {
+		if (sched_asym_prefer(idlest->asym_prefer_cpu, local->asym_prefer_cpu)) {
+			int busy_cpus = local_sgs.group_weight - local_sgs.idle_cpus;
+
+			busy_cpus -= (idlest_sgs.group_weight - idlest_sgs.idle_cpus);
+			if (busy_cpus >= 0)
+				return idlest;
+		}
+		return NULL;
+	}
+
 	switch (local_sgs.group_type) {
 	case group_overloaded:
 	case group_fully_busy:
-- 
2.31.1

