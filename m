Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E36E799272
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbjIHWvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbjIHWu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:50:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D634A1FEB;
        Fri,  8 Sep 2023 15:50:54 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388Mog7D028246;
        Fri, 8 Sep 2023 22:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Z55Ngw5xTpzSsoj7Y26jds8w0rVV/0ec9ylNE7GINhk=;
 b=jv9+dO0C6X85KKgNvwfzSt0AaReQaqN4kQ5Zbo7PMgqzTQ1z6EM1dOaClf6o+4SvL1jj
 5uETzmBXpV2f7N/aiNopSY/s+aevPrP1IPS4b41nqkaq6IPxWAT5TQ2ge2Ye2rsenxxD
 6YV6lh+oZLEKnOYigKE7c9m3JhI15o1TfWjRLcQRHTIb98EgP4KAtX3YOyxEOTi5ex5c
 xGHsfUAFQJux/SvZ7r/vEfMXmGk92nT/P8LgAFYLT8a+eDhYyQH5EjPsmFOXm0t0Nn2i
 Rcu88jfMdzA605xuff1uQWVWVoAHcYXG4+wtfHs2kf6V0BfjH4nToz2FkZpn/aNU/geS Nw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t023wsj44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 22:50:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388MofIS010603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 22:50:41 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 8 Sep 2023 15:50:38 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
Date:   Fri, 8 Sep 2023 15:49:15 -0700
Subject: [PATCH v4 1/2] sched/core: Remove ifdeffery for saved_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230908-avoid-spurious-freezer-wakeups-v4-1-6155aa3dafae@quicinc.com>
References: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
In-Reply-To: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     Thomas Gleixner <tglx@linutronix.de>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hzGfnqt_xYlvVJstTZOQcLm5PtEBGO2w
X-Proofpoint-ORIG-GUID: hzGfnqt_xYlvVJstTZOQcLm5PtEBGO2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=892 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for freezer to also use saved_state, remove the
CONFIG_PREEMPT_RT compilation guard around saved_state.

On the arm64 platform I tested which did not have CONFIG_PREEMPT_RT,
there was no statistically significant deviation by applying this patch.

Test methodology:

perf bench sched message -g 40 -l 40

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 include/linux/sched.h |  2 --
 kernel/sched/core.c   | 17 +++--------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb0..14194a62294f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -745,10 +745,8 @@ struct task_struct {
 #endif
 	unsigned int			__state;
 
-#ifdef CONFIG_PREEMPT_RT
 	/* saved state for "spinlock sleepers" */
 	unsigned int			saved_state;
-#endif
 
 	/*
 	 * This begins the randomizable portion of task_struct. Only
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..58921ab7442b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2219,31 +2219,21 @@ int __task_state_match(struct task_struct *p, unsigned int state)
 	if (READ_ONCE(p->__state) & state)
 		return 1;
 
-#ifdef CONFIG_PREEMPT_RT
 	if (READ_ONCE(p->saved_state) & state)
 		return -1;
-#endif
+
 	return 0;
 }
 
 static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
-#ifdef CONFIG_PREEMPT_RT
-	int match;
-
 	/*
 	 * Serialize against current_save_and_set_rtlock_wait_state() and
 	 * current_restore_rtlock_saved_state().
 	 */
-	raw_spin_lock_irq(&p->pi_lock);
-	match = __task_state_match(p, state);
-	raw_spin_unlock_irq(&p->pi_lock);
-
-	return match;
-#else
+	guard(raw_spinlock_irq)(&p->pi_lock);
 	return __task_state_match(p, state);
-#endif
 }
 
 /*
@@ -4053,7 +4043,6 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
 	*success = !!(match = __task_state_match(p, state));
 
-#ifdef CONFIG_PREEMPT_RT
 	/*
 	 * Saved state preserves the task state across blocking on
 	 * an RT lock.  If the state matches, set p::saved_state to
@@ -4069,7 +4058,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 	 */
 	if (match < 0)
 		p->saved_state = TASK_RUNNING;
-#endif
+
 	return match > 0;
 }
 

-- 
2.41.0

