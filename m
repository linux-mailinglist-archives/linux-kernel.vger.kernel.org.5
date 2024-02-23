Return-Path: <linux-kernel+bounces-77889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8642F860BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F501C237EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F991643E;
	Fri, 23 Feb 2024 07:54:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C813AF3;
	Fri, 23 Feb 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674867; cv=none; b=Tc3jjrSeJlFYGkfQSYMZe3nvlaX5Xjj6wOv2pCySfWs/lpZsIDQ4WIopC0bnXwySfLv4OE0q2gOIFP4DNx9iYRAbrOswk7YI9oK0HZcze6jJyLFjuFOX3MWnTu0irJfTUkQS3aXGXMuFI8t/qbl+8km3jxRcW97kmaPtlHZKMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674867; c=relaxed/simple;
	bh=s9WEmS1JeaRfuBaRo5YOQgJKXJEVSk9vt5/AjGo1kXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odph0DwtgRwmQwypJdH/FN/yJQn7FC6wtq30WdIJ68DtdjEG9jLUQmZC9iax1cM5c/1rd7da/XnK299HULYyVXNPXjpMNCRkBAocgRQQzCcM7sgdRbkgf1dAQXMW1oLi/XX6JyIo/jX25qGghU0MSkRFmC92Vk+PjKgHnJg/eMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9DBC433C7;
	Fri, 23 Feb 2024 07:54:24 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Update cpu_sibling_map when disabling nonboot CPUs
Date: Fri, 23 Feb 2024 15:54:04 +0800
Message-ID: <20240223075404.1550127-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update cpu_sibling_map when disabling nonboot CPUs by defining & calling
clear_cpu_sibling_map(), otherwise we get such errors on SMT systems:

jump label: negative count!
WARNING: CPU: 6 PID: 45 at kernel/jump_label.c:263 __static_key_slow_dec_cpuslocked+0xec/0x100
CPU: 6 PID: 45 Comm: cpuhp/6 Not tainted 6.8.0-rc5+ #1340
pc 90000000004c302c ra 90000000004c302c tp 90000001005bc000 sp 90000001005bfd20
a0 000000000000001b a1 900000000224c278 a2 90000001005bfb58 a3 900000000224c280
a4 900000000224c278 a5 90000001005bfb50 a6 0000000000000001 a7 0000000000000001
t0 ce87a4763eb5234a t1 ce87a4763eb5234a t2 0000000000000000 t3 0000000000000000
t4 0000000000000006 t5 0000000000000000 t6 0000000000000064 t7 0000000000001964
t8 000000000009ebf6 u0 9000000001f2a068 s9 0000000000000000 s0 900000000246a2d8
s1 ffffffffffffffff s2 ffffffffffffffff s3 90000000021518c0 s4 0000000000000040
s5 9000000002151058 s6 9000000009828e40 s7 00000000000000b4 s8 0000000000000006
   ra: 90000000004c302c __static_key_slow_dec_cpuslocked+0xec/0x100
  ERA: 90000000004c302c __static_key_slow_dec_cpuslocked+0xec/0x100
 CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
 PRMD: 00000004 (PPLV0 +PIE -PWE)
 EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
 ECFG: 00071c1c (LIE=2-4,10-12 VS=7)
ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
 PRID: 0014d000 (Loongson-64bit, Loongson-3A6000-HV)
CPU: 6 PID: 45 Comm: cpuhp/6 Not tainted 6.8.0-rc5+ #1340
Stack : 0000000000000000 900000000203f258 900000000179afc8 90000001005bc000
        90000001005bf980 0000000000000000 90000001005bf988 9000000001fe0be0
        900000000224c280 900000000224c278 90000001005bf8c0 0000000000000001
        0000000000000001 ce87a4763eb5234a 0000000007f38000 90000001003f8cc0
        0000000000000000 0000000000000006 0000000000000000 4c206e6f73676e6f
        6f4c203a656d616e 000000000009ec99 0000000007f38000 0000000000000000
        900000000214b000 9000000001fe0be0 0000000000000004 0000000000000000
        0000000000000107 0000000000000009 ffffffffffafdabe 00000000000000b4
        0000000000000006 90000000004c302c 9000000000224528 00005555939a0c7c
        00000000000000b0 0000000000000004 0000000000000000 0000000000071c1c
        ...
Call Trace:
[<9000000000224528>] show_stack+0x48/0x1a0
[<900000000179afc8>] dump_stack_lvl+0x78/0xa0
[<9000000000263ed0>] __warn+0x90/0x1a0
[<90000000017419b8>] report_bug+0x1b8/0x280
[<900000000179c564>] do_bp+0x264/0x420
[<90000000004c302c>] __static_key_slow_dec_cpuslocked+0xec/0x100
[<90000000002b4d7c>] sched_cpu_deactivate+0x2fc/0x300
[<9000000000266498>] cpuhp_invoke_callback+0x178/0x8a0
[<9000000000267f70>] cpuhp_thread_fun+0xf0/0x240
[<90000000002a117c>] smpboot_thread_fn+0x1dc/0x2e0
[<900000000029a720>] kthread+0x140/0x160
[<9000000000222288>] ret_from_kernel_thread+0xc/0xa4

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/smp.c | 121 ++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 53 deletions(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 87b7190fe48e..aabee0b280fe 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -88,6 +88,73 @@ void show_ipi_list(struct seq_file *p, int prec)
 	}
 }
 
+static inline void set_cpu_core_map(int cpu)
+{
+	int i;
+
+	cpumask_set_cpu(cpu, &cpu_core_setup_map);
+
+	for_each_cpu(i, &cpu_core_setup_map) {
+		if (cpu_data[cpu].package == cpu_data[i].package) {
+			cpumask_set_cpu(i, &cpu_core_map[cpu]);
+			cpumask_set_cpu(cpu, &cpu_core_map[i]);
+		}
+	}
+}
+
+static inline void set_cpu_sibling_map(int cpu)
+{
+	int i;
+
+	cpumask_set_cpu(cpu, &cpu_sibling_setup_map);
+
+	for_each_cpu(i, &cpu_sibling_setup_map) {
+		if (cpus_are_siblings(cpu, i)) {
+			cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
+			cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
+		}
+	}
+}
+
+static inline void clear_cpu_sibling_map(int cpu)
+{
+	int i;
+
+	for_each_cpu(i, &cpu_sibling_setup_map) {
+		if (cpus_are_siblings(cpu, i)) {
+			cpumask_clear_cpu(i, &cpu_sibling_map[cpu]);
+			cpumask_clear_cpu(cpu, &cpu_sibling_map[i]);
+		}
+	}
+
+	cpumask_clear_cpu(cpu, &cpu_sibling_setup_map);
+}
+
+/*
+ * Calculate a new cpu_foreign_map mask whenever a
+ * new cpu appears or disappears.
+ */
+void calculate_cpu_foreign_map(void)
+{
+	int i, k, core_present;
+	cpumask_t temp_foreign_map;
+
+	/* Re-calculate the mask */
+	cpumask_clear(&temp_foreign_map);
+	for_each_online_cpu(i) {
+		core_present = 0;
+		for_each_cpu(k, &temp_foreign_map)
+			if (cpus_are_siblings(i, k))
+				core_present = 1;
+		if (!core_present)
+			cpumask_set_cpu(i, &temp_foreign_map);
+	}
+
+	for_each_online_cpu(i)
+		cpumask_andnot(&cpu_foreign_map[i],
+			       &temp_foreign_map, &cpu_sibling_map[i]);
+}
+
 /* Send mailbox buffer via Mail_Send */
 static void csr_mail_send(uint64_t data, int cpu, int mailbox)
 {
@@ -303,6 +370,7 @@ int loongson_cpu_disable(void)
 	numa_remove_cpu(cpu);
 #endif
 	set_cpu_online(cpu, false);
+	clear_cpu_sibling_map(cpu);
 	calculate_cpu_foreign_map();
 	local_irq_save(flags);
 	irq_migrate_all_off_this_cpu();
@@ -380,59 +448,6 @@ static int __init ipi_pm_init(void)
 core_initcall(ipi_pm_init);
 #endif
 
-static inline void set_cpu_sibling_map(int cpu)
-{
-	int i;
-
-	cpumask_set_cpu(cpu, &cpu_sibling_setup_map);
-
-	for_each_cpu(i, &cpu_sibling_setup_map) {
-		if (cpus_are_siblings(cpu, i)) {
-			cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
-			cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
-		}
-	}
-}
-
-static inline void set_cpu_core_map(int cpu)
-{
-	int i;
-
-	cpumask_set_cpu(cpu, &cpu_core_setup_map);
-
-	for_each_cpu(i, &cpu_core_setup_map) {
-		if (cpu_data[cpu].package == cpu_data[i].package) {
-			cpumask_set_cpu(i, &cpu_core_map[cpu]);
-			cpumask_set_cpu(cpu, &cpu_core_map[i]);
-		}
-	}
-}
-
-/*
- * Calculate a new cpu_foreign_map mask whenever a
- * new cpu appears or disappears.
- */
-void calculate_cpu_foreign_map(void)
-{
-	int i, k, core_present;
-	cpumask_t temp_foreign_map;
-
-	/* Re-calculate the mask */
-	cpumask_clear(&temp_foreign_map);
-	for_each_online_cpu(i) {
-		core_present = 0;
-		for_each_cpu(k, &temp_foreign_map)
-			if (cpus_are_siblings(i, k))
-				core_present = 1;
-		if (!core_present)
-			cpumask_set_cpu(i, &temp_foreign_map);
-	}
-
-	for_each_online_cpu(i)
-		cpumask_andnot(&cpu_foreign_map[i],
-			       &temp_foreign_map, &cpu_sibling_map[i]);
-}
-
 /* Preload SMP state for boot cpu */
 void smp_prepare_boot_cpu(void)
 {
-- 
2.43.0


