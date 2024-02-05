Return-Path: <linux-kernel+bounces-52515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B18D784992D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664061F234A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586611B802;
	Mon,  5 Feb 2024 11:47:31 +0000 (UTC)
Received: from out0-193.mail.aliyun.com (out0-193.mail.aliyun.com [140.205.0.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0461AACE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133650; cv=none; b=muhoiyAFzPcM05/C4pgzaK1Suj92RxkGe/yT19OqBVUDpd7+AfU6iKksVcrJNhQMMfGjuANkepst8ob5WFzYuajywjOnLnjR67Q2iZ8LXCZ4LYE5WXZjIKunaKZDYGt7qPov1JBAE5IZgQyvcu/c2Kyy2/gUt+ad9HI1n3BbmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133650; c=relaxed/simple;
	bh=aeIv3sGdCkzoeZ0Sga2roNKU5ZWZgPhlxgVKkJoerUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ot0KaQSIiveJspK9+ho7umyc07K4MH2Wrc/NXGA0XPIrOVY27vxqLmh4qx0nTfPhoVco8TTNLtRA64a52xD4JPQ1/DXIlwVf2UY5Aht+AjQWEmRMvsWybSFO7JynmrRHh97um0CcWC0LqcoqYgActTBZ5t74PuGGLAXNnqLVH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WNt.HmM_1707133639;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WNt.HmM_1707133639)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 19:47:20 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 6/6] um: Stop tracking host PID in cpu_tasks
Date: Mon, 05 Feb 2024 19:47:08 +0800
Message-Id: <20240205114708.25235-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205114708.25235-1-tiwei.btw@antgroup.com>
References: <20240205114708.25235-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The host PID tracked in 'cpu_tasks' is no longer used. Stopping
tracking it will also save some cycles.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/as-layout.h |  1 -
 arch/um/kernel/process.c           | 12 ++----------
 arch/um/kernel/skas/process.c      |  4 ----
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 9ec3015bc5e2..c22f46a757dc 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -31,7 +31,6 @@
 #include <sysdep/ptrace.h>
 
 struct cpu_task {
-	int pid;
 	void *task;
 };
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 4235e2ca2664..1201c1a79b23 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -43,13 +43,7 @@
  * cares about its entry, so it's OK if another processor is modifying its
  * entry.
  */
-struct cpu_task cpu_tasks[NR_CPUS] = { [0 ... NR_CPUS - 1] = { -1, NULL } };
-
-static inline int external_pid(void)
-{
-	/* FIXME: Need to look up userspace_pid by cpu */
-	return userspace_pid[0];
-}
+struct cpu_task cpu_tasks[NR_CPUS] = { [0 ... NR_CPUS - 1] = { NULL } };
 
 void free_stack(unsigned long stack, int order)
 {
@@ -70,8 +64,7 @@ unsigned long alloc_stack(int order, int atomic)
 
 static inline void set_current(struct task_struct *task)
 {
-	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task)
-		{ external_pid(), task });
+	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task) { task });
 }
 
 extern void arch_switch_to(struct task_struct *to);
@@ -208,7 +201,6 @@ void um_idle_sleep(void)
 
 void arch_cpu_idle(void)
 {
-	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
 	um_idle_sleep();
 }
 
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index fdd5922f9222..99a5cbb36083 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -18,12 +18,8 @@ extern void start_kernel(void);
 
 static int __init start_kernel_proc(void *unused)
 {
-	int pid;
-
 	block_signals_trace();
-	pid = os_getpid();
 
-	cpu_tasks[0].pid = pid;
 	cpu_tasks[0].task = current;
 
 	start_kernel();
-- 
2.34.1


