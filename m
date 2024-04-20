Return-Path: <linux-kernel+bounces-152149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3868AB9D9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232E21F21421
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B71A1401B;
	Sat, 20 Apr 2024 05:17:09 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4130208A3;
	Sat, 20 Apr 2024 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590228; cv=none; b=p0zd+rUEqTUCto+3s6SHn4zNCPbWFZNNr9AzRNXeD0V7cNmcwYlz3NUlQQcYlGiBknZ1FUwj8QhYlfnHp3vsrOSKz0XitT0YA3jfdftqd3pl0+NZqULguQIpJKsUX27FtrbVlxAnLgmwPSG8cZV8hJ4B/K7yFMRyYQQWCuba1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590228; c=relaxed/simple;
	bh=3dgA1lID60LmbCnzBP9JsvU5Mc4ui3cakk0foe6t9eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6O9p5ZQ+GBSnSSAZcitDTgLv6/2GjjPNivPn6aG3vGna8ltJzsB9iQIBv8hpNefu1wMsg/KLYW0EHXu2ioyaLsDavhMbigqopEfo+mX5Tv/GfK5eqaBP4Q7JSLxwLAcIcNndKSKETSi/RSg6x9AMwnbFr3WgVwOfP75cbPSpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp80t1713590204tn4lchfu
X-QQ-Originating-IP: Pqo650+zqqf/lX5qSgW/Py8QatIBaphqDT9dCcdp/nQ=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Apr 2024 13:16:43 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: KdN0SWBFoH5g57I01NPcKiJN+8WNEmlH9ZWI9i/KHAoU/NtBUcSfBueYbY48I
	bq66ozRf67BXBl0nBHEL3VugORbLGVCJCxwhhkxK/8NR1K03ESv375NEEqm9W0skZuxRUMd
	FTgkLyrTucfqEh2J/iyjx0TblCA1aoU3wk+kb+V8zFtGmDTgXDGbvLFERkMgGaXdeB1LYlS
	rV6+lSgEYw8BQAWlNJ3TIxbm+z6q7r0RcssNufl+lIt/PDhTFVPGK9HjBVc7ZnkkpriGj34
	rkRc8Ny3wGoN6kPwdGzI6WK9KmfKJHXFt764+oNI/P7BL472NUDBcYGLS308lXS+QRI9cS2
	IsSRwUxuB9KkRFXfuhrRcxzEyPUX8EliiOM2Sk51HKrX0G9TqUowSBnqB1vwzVGYO3LAMF9
	3azSv3wKN9dEjZ6+5Dvo5AK2OGL1qyA9
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3589547492236992514
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 7/7] sparc/smp: Remove on-stack cpumask var
Date: Sat, 20 Apr 2024 13:15:47 +0800
Message-Id: <20240420051547.3681642-8-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240420051547.3681642-1-dawei.li@shingroup.cn>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

- Change prototype of sparc32_ipi_ops::cross_call() so that it takes
  const cpumask * arg and all its callers accordingly.

- As for all cross_call() implementations, divide cpumask_test_cpu() call
  into several sub calls to avoid on-stack cpumask var.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/include/asm/smp_32.h | 12 ++++++------
 arch/sparc/kernel/kernel.h      | 11 +++++++++++
 arch/sparc/kernel/leon_smp.c    | 11 ++++-------
 arch/sparc/kernel/sun4d_smp.c   | 10 ++++------
 arch/sparc/kernel/sun4m_smp.c   | 10 ++++------
 5 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index 2cf7971d7f6c..9b6a166f6a57 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -54,7 +54,7 @@ void smp_bogo(struct seq_file *);
 void smp_info(struct seq_file *);
 
 struct sparc32_ipi_ops {
-	void (*cross_call)(void *func, cpumask_t mask, unsigned long arg1,
+	void (*cross_call)(void *func, const cpumask_t *mask, unsigned long arg1,
 			   unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4);
 	void (*resched)(int cpu);
@@ -65,29 +65,29 @@ extern const struct sparc32_ipi_ops *sparc32_ipi_ops;
 
 static inline void xc0(void *func)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, 0, 0, 0, 0);
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask, 0, 0, 0, 0);
 }
 
 static inline void xc1(void *func, unsigned long arg1)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, 0, 0, 0);
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask, arg1, 0, 0, 0);
 }
 static inline void xc2(void *func, unsigned long arg1, unsigned long arg2)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, arg2, 0, 0);
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask, arg1, arg2, 0, 0);
 }
 
 static inline void xc3(void *func, unsigned long arg1, unsigned long arg2,
 		       unsigned long arg3)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask,
 				    arg1, arg2, arg3, 0);
 }
 
 static inline void xc4(void *func, unsigned long arg1, unsigned long arg2,
 		       unsigned long arg3, unsigned long arg4)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask,
 				    arg1, arg2, arg3, arg4);
 }
 
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index a8fb7c0bf053..36747e8f7e36 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -4,6 +4,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/ftrace.h>
+#include <linux/smp.h>
 
 #include <asm/traps.h>
 #include <asm/head.h>
@@ -75,6 +76,16 @@ int sparc32_classify_syscall(unsigned int syscall);
 #endif
 
 #ifdef CONFIG_SPARC32
+
+#ifdef CONFIG_SMP
+static inline bool cpu_for_ipi(const cpumask_t *mask, unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, mask) &&
+	       cpumask_test_cpu(cpu, cpu_online_mask) &&
+	       cpu != smp_processor_id();
+}
+#endif /* CONFIG_SMP */
+
 /* setup_32.c */
 struct linux_romvec;
 void sparc32_start_kernel(struct linux_romvec *rp);
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1ee393abc463..291884c8d82a 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -372,7 +372,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
+static void leon_cross_call(void *func, const cpumask_t *mask, unsigned long arg1,
 			    unsigned long arg2, unsigned long arg3,
 			    unsigned long arg4)
 {
@@ -403,14 +403,11 @@ static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 		{
 			register int i;
 
-			cpumask_clear_cpu(smp_processor_id(), &mask);
-			cpumask_and(&mask, cpu_online_mask, &mask);
 			for (i = 0; i <= high; i++) {
-				if (cpumask_test_cpu(i, &mask)) {
+				if (cpu_for_ipi(mask, i)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
 					leon_send_ipi(i, LEON3_IRQ_CROSS_CALL);
-
 				}
 			}
 		}
@@ -420,7 +417,7 @@ static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 
 				while (!ccall_info.processors_in[i])
@@ -429,7 +426,7 @@ static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 
 				while (!ccall_info.processors_out[i])
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 9a62a5cf3337..7dc57ca05728 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -281,7 +281,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
+static void sun4d_cross_call(void *func, const cpumask_t *mask, unsigned long arg1,
 			     unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4)
 {
@@ -315,10 +315,8 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 		{
 			register int i;
 
-			cpumask_clear_cpu(smp_processor_id(), &mask);
-			cpumask_and(&mask, cpu_online_mask, &mask);
 			for (i = 0; i <= high; i++) {
-				if (cpumask_test_cpu(i, &mask)) {
+				if (cpu_for_ipi(mask, i)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
 					sun4d_send_ipi(i, IRQ_CROSS_CALL);
@@ -331,7 +329,7 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 				while (!ccall_info.processors_in[i])
 					barrier();
@@ -339,7 +337,7 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 				while (!ccall_info.processors_out[i])
 					barrier();
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 056df034e79e..3f43f64e3489 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -170,7 +170,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
+static void sun4m_cross_call(void *func, const cpumask_t *mask, unsigned long arg1,
 			     unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4)
 {
@@ -191,10 +191,8 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 		{
 			register int i;
 
-			cpumask_clear_cpu(smp_processor_id(), &mask);
-			cpumask_and(&mask, cpu_online_mask, &mask);
 			for (i = 0; i < ncpus; i++) {
-				if (cpumask_test_cpu(i, &mask)) {
+				if (cpu_for_ipi(mask, i)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
 					sun4m_send_ipi(i, IRQ_CROSS_CALL);
@@ -210,7 +208,7 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 				while (!ccall_info.processors_in[i])
 					barrier();
@@ -218,7 +216,7 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 				while (!ccall_info.processors_out[i])
 					barrier();
-- 
2.27.0


