Return-Path: <linux-kernel+bounces-25673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970BE82D476
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A23281512
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530A3D8E;
	Mon, 15 Jan 2024 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KJEDuj/R"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5B3C0B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28e4fd9e352so458206a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 23:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705302772; x=1705907572; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOtRqa7rEwU1R9Xcu357qtlvryd8Tx4xNbEfyiqNWok=;
        b=KJEDuj/RZU5IeT4OERKXKJhrZhgOwuS80GX7F1Js4g2KvBx+danStsOLdWBpuFyI5v
         6/0JvCLUpo7kyGXQXeDylyW6UJFPD+2+wPVZG5cQBkrvYMOWityp7MRfYx22E8BhNbFU
         sNTfspOZdb/y1nFw/5vvLmTE4F1JcPFvfNPj1S3e7iaQ8Oc6FJQLTNRLcrGov7d7VlW5
         MuGjpjHPFAJWe8jJNthNqJwmsAS3Jo5Di2JBWV2GGcH3OnVvuzvBSxA4MxG3en1l+Wk/
         e7S6hmW6ZMmduAxoDGdxFPJn+DR5ZTf/BptZ5S5pX7/pRrLr0RiJOAtQ0kDf83QRW1jU
         8njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705302772; x=1705907572;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOtRqa7rEwU1R9Xcu357qtlvryd8Tx4xNbEfyiqNWok=;
        b=UPMRmL0HSEN2e5jEm6P4qJ6RV5qeT5C/ZsdFOw7sQN2HtBavYS1cOHVlKbrp3Q730d
         4c7K59pdI5KtbAhPbkQq6nEWfHlQkpAzd0nGBVadHiAbXbWZAb+8XAwL2eeowvRgIjQJ
         JIh8v3pyhId0vWvUTEZZQpnYzYl20G/g0a246Uhlh73sIwlYoWkGUR4GoP3YEndbZfjB
         llUB8fwnzaVwBp3BX4fsjXKKgp24yiD9TmvA4gv64lBIojkK/SwBPiO0PlpEGiSdFjiC
         y97a4V6ob6m2y+IIgStRDZao/KyFNt2xuozfLPo7sLD4/rlWQWqEkX5EAPr5+HvvwHf+
         UMPQ==
X-Gm-Message-State: AOJu0YzVeeEf0E0hSwxCH4QRoCy4m3ykiq84GPi/BTQtCd7IBJMSkgqO
	gs0NfF+i+2uayBhMeKOCw0Q0gwvgK7URkw==
X-Google-Smtp-Source: AGHT+IFn52n0aTLVx0IuHopQOFwKNNIX2e3zu7DgcMUSmIjqFSbJEWZdITvqr7wz6RoFDLZ50Pkb/w==
X-Received: by 2002:a17:90a:fa8b:b0:28d:4db8:6d52 with SMTP id cu11-20020a17090afa8b00b0028d4db86d52mr3390977pjb.9.1705302772239;
        Sun, 14 Jan 2024 23:12:52 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id pv11-20020a17090b3c8b00b0028e5fe0115asm458214pjb.36.2024.01.14.23.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 23:12:51 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Marc Zyngier <maz@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] RISC-V: add IPI tracepoints
Date: Mon, 15 Jan 2024 07:12:40 +0000
Message-Id: <20240115071246.32675-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The strings used to list IPIs in /proc/interrupts are reused for tracing
purposes. Also slightly clean up the code by removing send_ipi_single().

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/kernel/smp.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 40420afbb1a0..32c653cd3433 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -26,6 +26,8 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 
+#include <trace/events/ipi.h>
+
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
@@ -36,6 +38,15 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
+static const char * const ipi_names[] __tracepoint_string = {
+	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
+	[IPI_CALL_FUNC]		= "Function call interrupts",
+	[IPI_CPU_STOP]		= "CPU stop interrupts",
+	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
+	[IPI_IRQ_WORK]		= "IRQ work interrupts",
+	[IPI_TIMER]		= "Timer broadcast interrupts",
+};
+
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
@@ -96,18 +107,14 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
+	trace_ipi_raise(mask, ipi_names[op]);
 	__ipi_send_mask(ipi_desc[op], mask);
 }
 
-static void send_ipi_single(int cpu, enum ipi_message_type op)
-{
-	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
-}
-
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
-	send_ipi_single(smp_processor_id(), IPI_IRQ_WORK);
+	send_ipi_mask(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
 }
 #endif
 
@@ -115,6 +122,9 @@ static irqreturn_t handle_IPI(int irq, void *data)
 {
 	int ipi = irq - ipi_virq_base;
 
+	if ((unsigned int)ipi < IPI_MAX)
+		trace_ipi_entry(ipi_names[ipi]);
+
 	switch (ipi) {
 	case IPI_RESCHEDULE:
 		scheduler_ipi();
@@ -141,6 +151,9 @@ static irqreturn_t handle_IPI(int irq, void *data)
 		break;
 	}
 
+	if ((unsigned int)ipi < IPI_MAX)
+		trace_ipi_exit(ipi_names[ipi]);
+
 	return IRQ_HANDLED;
 }
 
@@ -205,15 +218,6 @@ void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 		static_branch_disable(&riscv_ipi_for_rfence);
 }
 
-static const char * const ipi_names[] = {
-	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
-	[IPI_CALL_FUNC]		= "Function call interrupts",
-	[IPI_CPU_STOP]		= "CPU stop interrupts",
-	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
-	[IPI_IRQ_WORK]		= "IRQ work interrupts",
-	[IPI_TIMER]		= "Timer broadcast interrupts",
-};
-
 void show_ipi_stats(struct seq_file *p, int prec)
 {
 	unsigned int cpu, i;
@@ -234,7 +238,7 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask)
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	send_ipi_single(cpu, IPI_CALL_FUNC);
+	send_ipi_mask(cpumask_of(cpu), IPI_CALL_FUNC);
 }
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
@@ -329,6 +333,6 @@ bool smp_crash_stop_failed(void)
 
 void arch_smp_send_reschedule(int cpu)
 {
-	send_ipi_single(cpu, IPI_RESCHEDULE);
+	send_ipi_mask(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
-- 
2.17.1


