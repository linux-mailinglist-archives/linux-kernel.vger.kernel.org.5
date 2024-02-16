Return-Path: <linux-kernel+bounces-68091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EAF8575DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4350A286014
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66F13ADC;
	Fri, 16 Feb 2024 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kYIQsG5i"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D153134A9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064099; cv=none; b=mk9GKcOfA7+ozQ0A0gOyKT4fRqJCJPKQIE66l0ZwXYU7U5VqXdCP/wadIEreOwe1+h1VqaYTbNGiOkCrfq9Ey69YgUxDRpgt28+Uga78NTqaP7k7Jo8PqMNEWoUexi3BLVd2Capd3t3galG9SFrG+PTuDgK26P0x3NTmgi2r++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064099; c=relaxed/simple;
	bh=OKUBHrWTV7A9dH/DIS5/Epz1zBFwN1ZoUoKCQBtaV58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j44mZ3KvBRewpcLa/NquZ3Ux5rY/4Y8Phe5NhtKCk67Zm61RmKA0DJNETnpJnjRPffryM3KJauXKumJ1SGrGHWvGkTt0iQIHJS8H8oQ3gGC5x8Pw0qaL+kBgt053CQfFYmfFWyGnSdr19kbTsYXg7MXT660zPZAPNaSUX7JNiyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kYIQsG5i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41G61mja012218;
	Fri, 16 Feb 2024 06:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=PB+trk+aKjPXReDeK3Ef8zM2cLtbG+YDK9l45jBF0pc=;
 b=kYIQsG5ikuedKXZIXcTZCOQ2Ql8iwA73a/NvOENEPPQd1ZWQuvCuFkuOsVnZeSCh0q2q
 GJ00lmcM+fNfnGzoRnvc5L2vo9H2r+t7WO5+lcKfN3jzpXMtqpuxKk5Hecv8U9PdG2XM
 v7UbMGohR8e2R5jzVsR8HUEOqZhFAKpuSS93K1V7LcB6lx1fTZfMMymxs8ahT/kf2K3n
 VKZ3IDIWR+eoaXKBq9PSgd7ruSbkVDBeC6MK7PPIWSjWrPuO/IOvxtov3A5LlDlsDwyx
 nsnRxj1alW5wOgEj9iIaHl9XDX0VXTzJESZ0TFcmFw4K1dPXGT9ftLDveS9vMuk6XwaK KQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa1xegfmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 06:14:47 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41G5AKaO032614;
	Fri, 16 Feb 2024 06:14:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kfu1s5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 06:14:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41G6EgVs19333802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 06:14:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B401E20040;
	Fri, 16 Feb 2024 06:14:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D772005A;
	Fri, 16 Feb 2024 06:14:41 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 06:14:41 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched: remove duplicate ifdefs
Date: Fri, 16 Feb 2024 11:44:33 +0530
Message-Id: <20240216061433.535522-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: faPieRAo6ltMx6rfzgr_ZdbELsdTZwUr
X-Proofpoint-ORIG-GUID: faPieRAo6ltMx6rfzgr_ZdbELsdTZwUr
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160049

when a ifdef is used in the below manner, second one could be considered as
duplicate.

ifdef DEFINE_A
..code block...
ifdef DEFINE_A       <-- This is a duplicate.
..code block...
endif
else
ifndef DEFINE_A     <-- This is also duplicate.
..code block...
endif
endif
More details about the script and methods used to find these code
patterns are in cover letter of [1]

In the scheduler code, there are two places where above pattern can be
observed.
Hunk1: Code is under check of CONFIG_UCLAMP_TASK in kernel/sched/core.c
from line 1353. Hence the same check at line 1795 is duplicate.
Hunk2: Minor update of comment.
Hunk3: Code is already under the check of CONFIG_SMP in
kernel/sched/fair.c from line 8591. Hence the same check in line 10185
is a duplicate.

No functional change is intended here. It only aims to improve code
readability.

[1]:https://lore.kernel.org/all/20240118080326.13137-1-sshegde@linux.ibm.com/
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
Changes since v2:
- Dropped RFC tag.
- Split the patches into individual from the series.
- Added more context to each Hunk for review.

 kernel/sched/core.c | 4 +---
 kernel/sched/fair.c | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..a76c7095f736 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1792,7 +1792,6 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css);
 #endif

 #ifdef CONFIG_SYSCTL
-#ifdef CONFIG_UCLAMP_TASK
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static void uclamp_update_root_tg(void)
 {
@@ -1898,7 +1897,6 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	return result;
 }
 #endif
-#endif

 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
@@ -2065,7 +2063,7 @@ static void __init init_uclamp(void)
 	}
 }

-#else /* CONFIG_UCLAMP_TASK */
+#else /* !CONFIG_UCLAMP_TASK */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline int uclamp_validate(struct task_struct *p,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..8e30e2bb77a0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10182,10 +10182,8 @@ static int idle_cpu_without(int cpu, struct task_struct *p)
 	 * be computed and tested before calling idle_cpu_without().
 	 */

-#ifdef CONFIG_SMP
 	if (rq->ttwu_pending)
 		return 0;
-#endif

 	return 1;
 }
--
2.39.3


