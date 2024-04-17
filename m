Return-Path: <linux-kernel+bounces-147943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9508A7BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68190282D08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D81150A7A;
	Wed, 17 Apr 2024 05:07:26 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9713BBF7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330445; cv=none; b=Zsj0PqjB+IymIKl6t/iFlxRUcJxWw/8SpDYDCF4ULCwUetqDxmtiYY/T+plS60rVTDwysQGWpnXgFaQ+whC0x6dqkx/711a/Di5iILGuGDHKgKHKG0kyUkEV31eYZslJibmZ8u/whLpgLCp06EFu7kMJG5uuVSB8Rcs1PlJHTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330445; c=relaxed/simple;
	bh=u8g8jf8vEHRXJCv4Eu0yvYfyUal6Ykec8xCukP0lgQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rz6/YbknZUJE8t4L8ZBxz4jMS6p4lZHxDZmLEdZZDqSUskVEYe1R/EEPBnml9GM7BbjydHqQDDYwTcrhVUq5aZ1jVQ+Zu1K6oUQYTYc9aJQU4al1EZlY2G6Q89sFAK88pNRth9nUGYoYycWw+3d5bUJ27enzruKBMyhhjqhO3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id F2C4CA98A0;
	Wed, 17 Apr 2024 14:07:18 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GzZjxqzI91Bn; Wed, 17 Apr 2024 14:07:18 +0900 (JST)
Received: from localhost.localdomain (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id C95859F6AC;
	Wed, 17 Apr 2024 14:07:18 +0900 (JST)
From: takakura@valinux.co.jp
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	apatel@ventanamicro.com,
	bmeng.cn@gmail.com,
	atishp@rivosinc.com,
	daniel.thompson@linaro.org,
	arnd@arndb.de,
	sfr@canb.auug.org.au,
	akpm@linux-foundation.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com
Cc: taka@valinux.co.jp,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH] RISC-V: Enable IPI CPU Backtrace
Date: Wed, 17 Apr 2024 14:07:11 +0900
Message-Id: <20240417050711.41930-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

Add CPU backtrace feature using IPI on riscv.
Currently, riscv doesn't yet support the feature while other
architectures do. As IPI multiplexing allows to handle 
multiple IPIs, I think this feature can also be enabled 
on riscv by adding IPI.

This patch defines arch_trigger_all_cpu_backtrace() which triggers
the IPI for CPU backtrace.
It will be triggered in the events of oops/panic when options
(oops_all_cpu_backtrace/panic_print) are set accordingly.

Below is the case of oops with the oops_all_cpu_backtrace 
enabled.

$ sysctl kernel.oops_all_cpu_backtrace=1

triggering oops shows:
[  435.716754] NMI backtrace for cpu 3
[  435.716893] CPU: 3 PID: 621 Comm: in:imklog Tainted: G           OE      6.9.0-rc4 #1
[  435.717086] Hardware name: riscv-virtio,qemu (DT)
[  435.717182] epc : fallback_scalar_usercopy+0x8/0xdc
[  435.717300]  ra : _copy_to_user+0x32/0x58
[  435.717391] epc : ffffffff80c33d88 ra : ffffffff80598e3c sp : ff20000000e83b50
[  435.717544]  gp : ffffffff82066bf0 tp : ff60000091fd7000 t0 : 3363303866660000
[  435.717711]  t1 : 000000000000005b t2 : 3363303866666666 s0 : ff20000000e83b60
[  435.717874]  s1 : 00000000000001af a0 : 00007ff74d3df74f a1 : ff60000082cdc800
[  435.718040]  a2 : 000000000000003c a3 : 0000000000000000 a4 : 0000000000000000
[  435.718196]  a5 : 00ffffffffffffc4 a6 : 0000000000000000 a7 : 0000000000000010
[  435.718333]  s2 : ff60000082cdc800 s3 : ffffffff82066910 s4 : 0000000000001df1
[  435.718475]  s5 : ffffffff8206a5b8 s6 : 00007ff74d3df74f s7 : ffffffff8206a5b0
[  435.718616]  s8 : ff60000082cdc800 s9 : ffffffff81e26208 s10: 000000000000003c
[  435.718760]  s11: ffffffff8206a5ad t3 : ff60000082cdc812 t4 : ff60000082cdc812
[  435.718909]  t5 : ff60000082cdc818 t6 : 0000000000040000
[  435.719019] status: 0000000000040120 badaddr: 0000000000000000 cause: 8000000000000001
[  435.719191] [<ffffffff80c33d88>] fallback_scalar_usercopy+0x8/0xdc
[  435.719330] [<ffffffff80094eee>] syslog_print+0x1f4/0x2b2
[  435.719446] [<ffffffff80095e10>] do_syslog.part.0+0xb0/0x326
[  435.719594] [<ffffffff8009692e>] do_syslog+0x66/0x88
[  435.719816] [<ffffffff803a1a80>] kmsg_read+0x44/0x5c
[  435.720017] [<ffffffff8038ea92>] proc_reg_read+0x7a/0xa8
[  435.720251] [<ffffffff802fae20>] vfs_read+0x94/0x264
[  435.720478] [<ffffffff802fb906>] ksys_read+0x64/0xe4
[  435.720709] [<ffffffff802fb9a6>] __riscv_sys_read+0x20/0x2c
[  435.720880] [<ffffffff80c43ea2>] do_trap_ecall_u+0x60/0x1d4
[  435.721236] [<ffffffff80c4f74c>] ret_from_exception+0x0/0x64

Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
---
 arch/riscv/include/asm/irq.h |  3 +++
 arch/riscv/kernel/smp.c      | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 8e10a94430a2..ed8f76879270 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,9 @@
 
 #include <asm-generic/irq.h>
 
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+
 void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 45dd4035416e..6e297b9eb641 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/irq_work.h>
+#include <linux/nmi.h>
 
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
@@ -33,6 +34,7 @@ enum ipi_message_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_IRQ_WORK,
 	IPI_TIMER,
+	IPI_CPU_BACKTRACE,
 	IPI_MAX
 };
 
@@ -136,6 +138,9 @@ static irqreturn_t handle_IPI(int irq, void *data)
 		tick_receive_broadcast();
 		break;
 #endif
+	case IPI_CPU_BACKTRACE:
+		nmi_cpu_backtrace(get_irq_regs());
+		break;
 	default:
 		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
 		break;
@@ -212,6 +217,7 @@ static const char * const ipi_names[] = {
 	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
+	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
 };
 
 void show_ipi_stats(struct seq_file *p, int prec)
@@ -332,3 +338,13 @@ void arch_smp_send_reschedule(int cpu)
 	send_ipi_single(cpu, IPI_RESCHEDULE);
 }
 EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
+
+static void riscv_backtrace_ipi(cpumask_t *mask)
+{
+	send_ipi_mask(mask, IPI_CPU_BACKTRACE);
+}
+
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, riscv_backtrace_ipi);
+}
-- 
2.34.1


