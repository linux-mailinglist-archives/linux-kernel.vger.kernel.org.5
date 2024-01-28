Return-Path: <linux-kernel+bounces-41921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CDD83F99B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C601C21621
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143C25772;
	Sun, 28 Jan 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L5FiS1Fm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED13C48F;
	Sun, 28 Jan 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471954; cv=none; b=bUUYSwGlFonzkbZCWow95RN8mmbrfYNHcuYmjjGbTePoAKDji3F44MC3+e5le959Lk//2rIHRZ5sTCrZs8l1snrjoLwwZGjl5nUxDaV/z0vungQ+5zQNnhSYC2ORX8xbTWgTPICbD036AwszBNqETqr1MeY/DG7C5q2emMTSDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471954; c=relaxed/simple;
	bh=nRcNqmBon+kQBI7q2Pqwiddl5KFQ2+3C0N2v7bv9oIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADgcOgyAreIOAN+h4eT87tGGZGsCj1M3cqCFF3zN1o0H4o1YMUYPi+7rSeXnkzBUQHyrZl+HKIOb3SYxvcotbK86353wIYUSlk5PYzgsgb2K5RE4TLbaa/Ag4cfQB22gw+vMLQYHZALKVUM21IZu7o0syNw/3uEHtCaOiCcjhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L5FiS1Fm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40SFWAuW018738;
	Sun, 28 Jan 2024 19:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aAvGPWexv33Ic6RaT+kurh2+S+cJ+Jft7H9B2hhNlZ0=;
 b=L5FiS1Fmcud1c7xM8cmIjS1UnK4glAIUshlWJwQYqhFE6I4z7Zg1iQPXbnLVOrBxbGZc
 M/MeZ7EW4sM83GY3TdBtzjWVem0AKC1ijW5lMH6HZzRDKvVjpowpuTlLQLhdDpjv9K4X
 HtYWRW9dM78EcE5tg/cQlDGk9VDPcd3ZG3609B5CK/2+pQ+1LhdY6lNjHpmbk1ncMmHJ
 4BPAsFKOnCO9WzT0+NGhussuvACqHo+wFz1ultb6+ZiJMIpRRvFW15L65dyTMFOXxJMo
 c8w7jVOWAJMteSi1VU2MKoAkol3XEHGlHYJILX7a36oUr9mpv7ajQABaO6SIrA/pgH2W IA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vwsnb37je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 19:58:59 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40SJfuWp017772;
	Sun, 28 Jan 2024 19:58:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchycdj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 19:58:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40SJwtLH197250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jan 2024 19:58:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 053AC2004F;
	Sun, 28 Jan 2024 19:58:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5F032004D;
	Sun, 28 Jan 2024 19:58:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 28 Jan 2024 19:58:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id AC026E0788; Sun, 28 Jan 2024 20:58:54 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] sched/vtime: get rid of generic vtime_task_switch() implementation
Date: Sun, 28 Jan 2024 20:58:51 +0100
Message-Id: <1f519a8c86cf13bc4acd18ed5d8d1705d1554083.1706470223.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706470223.git.agordeev@linux.ibm.com>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jVsGMArMDf6g_jru9SgAUNE_2wp0z2K0
X-Proofpoint-GUID: jVsGMArMDf6g_jru9SgAUNE_2wp0z2K0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=649 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401280151

The generic vtime_task_switch() implementation gets built only
if __ARCH_HAS_VTIME_TASK_SWITCH is not defined, but requires an
architecture to implement arch_vtime_task_switch() callback at
the same time, which is confusing.

Further, arch_vtime_task_switch() is implemented for 32-bit PowerPC
architecture only and vtime_task_switch() generic variant is rather
superfluous.

Simplify the whole vtime_task_switch() wiring by moving the existing
generic implementation to PowerPC.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/powerpc/include/asm/cputime.h | 13 -------------
 arch/powerpc/kernel/time.c         | 22 ++++++++++++++++++++++
 kernel/sched/cputime.c             | 13 -------------
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 4961fb38e438..aff858ca99c0 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -32,23 +32,10 @@
 #ifdef CONFIG_PPC64
 #define get_accounting(tsk)	(&get_paca()->accounting)
 #define raw_get_accounting(tsk)	(&local_paca->accounting)
-static inline void arch_vtime_task_switch(struct task_struct *tsk) { }
 
 #else
 #define get_accounting(tsk)	(&task_thread_info(tsk)->accounting)
 #define raw_get_accounting(tsk)	get_accounting(tsk)
-/*
- * Called from the context switch with interrupts disabled, to charge all
- * accumulated times to the current process, and to prepare accounting on
- * the next process.
- */
-static inline void arch_vtime_task_switch(struct task_struct *prev)
-{
-	struct cpu_accounting_data *acct = get_accounting(current);
-	struct cpu_accounting_data *acct0 = get_accounting(prev);
-
-	acct->starttime = acct0->starttime;
-}
 #endif
 
 /*
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index df20cf201f74..c0fdc6d94fee 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -354,6 +354,28 @@ void vtime_flush(struct task_struct *tsk)
 	acct->hardirq_time = 0;
 	acct->softirq_time = 0;
 }
+
+/*
+ * Called from the context switch with interrupts disabled, to charge all
+ * accumulated times to the current process, and to prepare accounting on
+ * the next process.
+ */
+void vtime_task_switch(struct task_struct *prev)
+{
+	if (is_idle_task(prev))
+		vtime_account_idle(prev);
+	else
+		vtime_account_kernel(prev);
+
+	vtime_flush(prev);
+
+	if (!IS_ENABLED(CONFIG_PPC64)) {
+		struct cpu_accounting_data *acct = get_accounting(current);
+		struct cpu_accounting_data *acct0 = get_accounting(prev);
+
+		acct->starttime = acct0->starttime;
+	}
+}
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 void __no_kcsan __delay(unsigned long loops)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..aa48b2ec879d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -424,19 +424,6 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
  */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 
-# ifndef __ARCH_HAS_VTIME_TASK_SWITCH
-void vtime_task_switch(struct task_struct *prev)
-{
-	if (is_idle_task(prev))
-		vtime_account_idle(prev);
-	else
-		vtime_account_kernel(prev);
-
-	vtime_flush(prev);
-	arch_vtime_task_switch(prev);
-}
-# endif
-
 void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
 {
 	unsigned int pc = irq_count() - offset;
-- 
2.40.1


