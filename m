Return-Path: <linux-kernel+bounces-150010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BA48A9909
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5F5285000
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD115FCF5;
	Thu, 18 Apr 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KHGz7G+9"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75615FD15
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441004; cv=none; b=fjDY9UO/dD/3oOz2xRQ4sWTpoKWqY3VHve65DvrG602Ap1m7QY5IW7Gt6GAl9QHnRf/kx9orSlmJbJbENRBIzxROFWGeuZ5EhqkEWFjTsdSSdc26zdDJONmIm6Fwac+z8hrzt+Q7catOAs59P71dVBNZVRpdTrRFsasWTWap00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441004; c=relaxed/simple;
	bh=QWYvIaZ/l1aoRggZiFczg8Abq8R4L6b5OCiLksmTXyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qu1OqulHqsaqLlDcZv1DWuZgAgq647x3vO9doZANKPpLZYddGk2Bs7zVbbD1etcfVx0/4lsyedCM4JS/OWH9vgDGroUWaLx1LDJCjKxMpvyuPBgk54KPp+D+9PLZxOVqnkYi/J7D0y2iDffUJ3IwbYOX59mNEtn3aUrlBCQ2g7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KHGz7G+9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so420324a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713441002; x=1714045802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm558O2QVDPk1eRrVljSEfZNVakmWiw+kO/s+2oVqPM=;
        b=KHGz7G+9KaiXhfNYQL4ALvlu9lVTsbRj9eDpfKf2aNnVK8OFVnmVWB9A0NOQRAQ1Zo
         pjArrzBh3U228YM1zgfNjP0NMYL2JZIkD2k0Pee3/jxlXc7LgjYCyCl1Yq0G7AZoe0v2
         VyHmEcJATrPBIiAOHLfiaUV6lDooy1gS7XgC0DmgelRyK1sCYBdHVHWOvG+d8G8+9r5O
         DFdGDS0eGa1jq4pf0rpOi0P3/ufYZpqKwTkoguAigeiXVTUbpUi9QFXqkIkuhC7+QGbo
         wOjMYGeZ3/inxoEI7z1YzAkiYLit/ArLVDxYnYgcgmyiKMGRYqU3SNFbVVQBjbfIkkIJ
         /h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441002; x=1714045802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm558O2QVDPk1eRrVljSEfZNVakmWiw+kO/s+2oVqPM=;
        b=IDWhXZXi3q167jOOxaupkypoPu1+O/3MX9vlC1+28hNWcEg8URV/6a3IUW3+YNMgMp
         WleIWBlcfJ9nhSgM35CyYlUKgDOpB3+dSpcb8p8OvAyxsaziw/RSOYU6h+1/+c70FKk6
         eLXKJ95OvhSDzkp+uOwdrfibGKy/Fxlw8QxBIqAZVSUEbku+sZa7UOsxXytljjAn63wq
         eU3+FQZjfazxlcttXDCd81ohT/AVDLeCgpOfN8el9f4ImetYusGySr3uk1JUlmgZvzaw
         aOQmUeI6brdhk5viDHFwna3rgxKEaZpWh/py84yv0HuIEYcpMQdhpdSChIWXqp2DwLdD
         eIRA==
X-Forwarded-Encrypted: i=1; AJvYcCVUva8TIFeprPlXeYmF5jMITTIH3Qf4TuyCJ4sEXFAmYk55qp6nqMPkSpCZrpi42cKq+n/9csuuzDDP8Ycmbmva7wkufv74WWCyc5AJ
X-Gm-Message-State: AOJu0YwvavcbAAkVoH/I+OCpcpYVy7zdk3k/FgFYRqNS+/P7tgVev8bJ
	ATVasKbm10PNZm7wPBs0tiuCiq2L/VXFLxgfHJ9UH1pIPUU1QCRQQMxdnK9NM7Y=
X-Google-Smtp-Source: AGHT+IG08hqpF8uwiPrN1zWB27zGM+lpl666QMpL8Ui14+w3YozU4FioSKQ64+ALHNkfMcQdGOYAQA==
X-Received: by 2002:a17:90a:fd82:b0:2ab:9c0d:da69 with SMTP id cx2-20020a17090afd8200b002ab9c0dda69mr1994655pjb.49.1713441002289;
        Thu, 18 Apr 2024 04:50:02 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090aa40700b002abdb19f499sm1032293pjp.26.2024.04.18.04.49.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Apr 2024 04:50:02 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lihangjing@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 2/2] riscv: Use Zawrs to accelerate IPI to idle cpu
Date: Thu, 18 Apr 2024 19:49:42 +0800
Message-Id: <20240418114942.52770-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240418114942.52770-1-luxu.kernel@bytedance.com>
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending IPI to a cpu which has entered idle state using Zawrs
extension, there is no need to send a physical software interrupt.
Instead, we can write the IPI information to the address reserved by
target cpu, which will wake it from WRS.NTO. Then the target cpu can
handle the IPI directly without falling into traditional interrupt
handling routine.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/processor.h | 14 +++++++
 arch/riscv/include/asm/smp.h       | 14 +++++++
 arch/riscv/kernel/process.c        | 65 +++++++++++++++++++++++++++++-
 arch/riscv/kernel/smp.c            | 39 ++++++++++++------
 4 files changed, 118 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 1143367de8c6..76091cf2e8be 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -172,6 +172,20 @@ static inline void wrs_nto(unsigned long *addr)
 			: : "memory");
 }
 
+static inline void wrs_nto_if(int *addr, int val)
+{
+	int prev;
+
+	__asm__ __volatile__(
+			"lr.w %[p], %[a] \n\t"
+			"bne %[p], %[v], 1f \n\t"
+			".long 0x00d00073 \n\t"
+			"1: \n\t"
+			: [p] "=&r" (prev), [a] "+A" (*addr)
+			: [v] "r" (val)
+			: "memory");
+}
+
 extern phys_addr_t dma32_phys_limit;
 
 struct device_node;
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 0d555847cde6..2f27fd743092 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -19,6 +19,20 @@ extern unsigned long boot_cpu_hartid;
 
 #include <linux/jump_label.h>
 
+enum ipi_message_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_CPU_STOP,
+	IPI_CPU_CRASH_STOP,
+	IPI_IRQ_WORK,
+	IPI_TIMER,
+	IPI_MAX
+};
+
+int ipi_virq_base_get(void);
+
+irqreturn_t handle_IPI(int irq, void *data);
+
 /*
  * Mapping between linux logical cpu index and hartid.
  */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 9f0f7b888bc1..7d6bf780d334 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -16,6 +16,7 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
+#include <linux/hardirq.h>
 
 #include <asm/unistd.h>
 #include <asm/processor.h>
@@ -27,6 +28,7 @@
 #include <asm/cpuidle.h>
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
+#include <asm/smp.h>
 
 register unsigned long gp_in_global __asm__("gp");
 
@@ -38,6 +40,8 @@ EXPORT_SYMBOL(__stack_chk_guard);
 
 extern asmlinkage void ret_from_fork(void);
 
+DEFINE_PER_CPU(atomic_t, idle_ipi_mask);
+
 static __cpuidle void default_idle(void)
 {
 	/*
@@ -49,6 +53,16 @@ static __cpuidle void default_idle(void)
 	wait_for_interrupt();
 }
 
+static __cpuidle void default_idle_enter(void)
+{
+	/* Do nothing */
+}
+
+static __cpuidle void default_idle_exit(void)
+{
+	/* Do nothing */
+}
+
 static __cpuidle void wrs_idle(void)
 {
 	/*
@@ -57,10 +71,42 @@ static __cpuidle void wrs_idle(void)
 	 * to entering WRS.NTO.
 	 */
 	mb();
+#ifdef CONFIG_SMP
+	wrs_nto_if(&this_cpu_ptr(&idle_ipi_mask)->counter, BIT(IPI_MAX));
+#else
 	wrs_nto(&current_thread_info()->flags);
+#endif
+}
+
+static __cpuidle void wrs_idle_enter(void)
+{
+#ifdef CONFIG_SMP
+	atomic_set(this_cpu_ptr(&idle_ipi_mask), BIT(IPI_MAX));
+#endif
+}
+
+static __cpuidle void wrs_idle_exit(void)
+{
+#ifdef CONFIG_SMP
+	int pending;
+	unsigned long flags;
+	enum ipi_message_type ipi;
+
+	local_irq_save(flags);
+	pending = atomic_xchg_relaxed(this_cpu_ptr(&idle_ipi_mask), 0);
+	for (ipi = IPI_RESCHEDULE; ipi < IPI_MAX; ipi++)
+		if (pending & BIT(ipi)) {
+			irq_enter();
+			handle_IPI(ipi_virq_base_get() + ipi, NULL);
+			irq_exit();
+		}
+	local_irq_restore(flags);
+#endif
 }
 
 DEFINE_STATIC_CALL_NULL(riscv_idle, default_idle);
+DEFINE_STATIC_CALL_NULL(riscv_idle_enter, default_idle_enter);
+DEFINE_STATIC_CALL_NULL(riscv_idle_exit, default_idle_exit);
 
 void __cpuidle cpu_do_idle(void)
 {
@@ -72,13 +118,28 @@ void __cpuidle arch_cpu_idle(void)
 	cpu_do_idle();
 }
 
+void __cpuidle arch_cpu_idle_enter(void)
+{
+	static_call(riscv_idle_enter)();
+}
+
+void __cpuidle arch_cpu_idle_exit(void)
+{
+	static_call(riscv_idle_exit)();
+}
+
 void __init select_idle_routine(void)
 {
 	if (IS_ENABLED(CONFIG_RISCV_ZAWRS_IDLE) &&
-			riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS))
+			riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS)) {
 		static_call_update(riscv_idle, wrs_idle);
-	else
+		static_call_update(riscv_idle_enter, wrs_idle_enter);
+		static_call_update(riscv_idle_exit, wrs_idle_exit);
+	} else {
 		static_call_update(riscv_idle, default_idle);
+		static_call_update(riscv_idle_enter, default_idle_enter);
+		static_call_update(riscv_idle_exit, default_idle_exit);
+	}
 }
 
 int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 45dd4035416e..b5416ee41967 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -26,16 +26,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 
-enum ipi_message_type {
-	IPI_RESCHEDULE,
-	IPI_CALL_FUNC,
-	IPI_CPU_STOP,
-	IPI_CPU_CRASH_STOP,
-	IPI_IRQ_WORK,
-	IPI_TIMER,
-	IPI_MAX
-};
-
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
@@ -94,14 +84,34 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 }
 #endif
 
+#if defined(CONFIG_RISCV_ZAWRS_IDLE) && defined(CONFIG_SMP)
+DECLARE_PER_CPU(atomic_t, idle_ipi_mask);
+#endif
+
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
+#if defined(CONFIG_RISCV_ZAWRS_IDLE) && defined(CONFIG_SMP)
+	int cpu, val;
+
+	for_each_cpu(cpu, mask) {
+		val = atomic_fetch_or_relaxed(BIT(op), per_cpu_ptr(&idle_ipi_mask, cpu));
+		if (likely(!(val & BIT(IPI_MAX))))
+			__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
+	}
+#else
 	__ipi_send_mask(ipi_desc[op], mask);
+#endif
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
 {
-	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
+#if defined(CONFIG_RISCV_ZAWRS_IDLE) && defined(CONFIG_SMP)
+	int val;
+
+	val = atomic_fetch_or_relaxed(BIT(op), per_cpu_ptr(&idle_ipi_mask, cpu));
+	if (likely(!(val & BIT(IPI_MAX))))
+#endif
+		__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
 #ifdef CONFIG_IRQ_WORK
@@ -111,7 +121,7 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-static irqreturn_t handle_IPI(int irq, void *data)
+irqreturn_t handle_IPI(int irq, void *data)
 {
 	int ipi = irq - ipi_virq_base;
 
@@ -332,3 +342,8 @@ void arch_smp_send_reschedule(int cpu)
 	send_ipi_single(cpu, IPI_RESCHEDULE);
 }
 EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
+
+int ipi_virq_base_get(void)
+{
+	return ipi_virq_base;
+}
-- 
2.20.1


