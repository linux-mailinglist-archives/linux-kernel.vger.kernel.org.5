Return-Path: <linux-kernel+bounces-140428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE138A144C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E501F225FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45C14BF8B;
	Thu, 11 Apr 2024 12:20:01 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547114AD35
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838000; cv=none; b=K3/YP07utagHM/KGCDM9nTe9ikn4TOhqhUmpuFQtgGBo9gTnHV4fVL4yjB+lRtqduqMXzQRy9Sa3IX9r8FT0NLKMrGEop9O+H1GfZ9VmDlI5Mu69lBOBgYX3xPlEXo7PCYfaqEdmmdY9jl9I5jmPYYevAUkkS6UqJRJTddVAcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838000; c=relaxed/simple;
	bh=CfV54zs3ZTSh59pbZIsqCLI5u5wOBkvUuECrNExEESo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JLXiLr3iTZDwUh3TFlXF8LFpeop6PqTA7Sq5o92texseV/fwh/sMt54MTkL9BI7MEtGq2ZCQEsK0g5aDRqkSe1/wMm1aDCW5QrrOT4TFv6OnYYmYSF40tLgjl5kwVHnwUcg3XyHqBuQJ1cpOYGF8tQyjjJblZx2VNAA0Nydi2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VFdws5Xwcz1RCL6;
	Thu, 11 Apr 2024 20:17:01 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id E745618001A;
	Thu, 11 Apr 2024 20:19:54 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 20:19:53 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH v2] sched/cputime: clean up common vtime APIs
Date: Thu, 11 Apr 2024 20:19:48 +0800
Message-ID: <20240411121948.2154391-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

This removes the vtime_account_kernel() and vtime_account_idle() functions
in generic vtime accounting. There's no common vtime APIs now.

Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
v2: also remove vtime_account_idle.
---
 include/linux/vtime.h  | 11 +++--------
 kernel/sched/cputime.c | 19 +------------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 3684487d01e1..005d0870e41b 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -9,14 +9,6 @@
 #include <asm/vtime.h>
 #endif
 
-/*
- * Common vtime APIs
- */
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING
-extern void vtime_account_kernel(struct task_struct *tsk);
-extern void vtime_account_idle(struct task_struct *tsk);
-#endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
-
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 extern void arch_vtime_task_switch(struct task_struct *tsk);
 extern void vtime_user_enter(struct task_struct *tsk);
@@ -52,6 +44,9 @@ static inline void vtime_flush(struct task_struct *tsk) { }
 static inline bool vtime_accounting_enabled_this_cpu(void) { return true; }
 extern void vtime_task_switch(struct task_struct *prev);
 
+extern void vtime_account_kernel(struct task_struct *tsk);
+extern void vtime_account_idle(struct task_struct *tsk);
+
 static __always_inline void vtime_account_guest_enter(void)
 {
 	vtime_account_kernel(current);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..353b3b4c19da 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -709,18 +709,6 @@ static void __vtime_account_kernel(struct task_struct *tsk,
 		vtime_account_system(tsk, vtime);
 }
 
-void vtime_account_kernel(struct task_struct *tsk)
-{
-	struct vtime *vtime = &tsk->vtime;
-
-	if (!vtime_delta(vtime))
-		return;
-
-	write_seqcount_begin(&vtime->seqcount);
-	__vtime_account_kernel(tsk, vtime);
-	write_seqcount_end(&vtime->seqcount);
-}
-
 void vtime_user_enter(struct task_struct *tsk)
 {
 	struct vtime *vtime = &tsk->vtime;
@@ -775,18 +763,13 @@ void vtime_guest_exit(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
 
-void vtime_account_idle(struct task_struct *tsk)
-{
-	account_idle_time(get_vtime_delta(&tsk->vtime));
-}
-
 void vtime_task_switch_generic(struct task_struct *prev)
 {
 	struct vtime *vtime = &prev->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
 	if (vtime->state == VTIME_IDLE)
-		vtime_account_idle(prev);
+		account_idle_time(get_vtime_delta(&prev->vtime));
 	else
 		__vtime_account_kernel(prev, vtime);
 	vtime->state = VTIME_INACTIVE;
-- 
2.34.1


