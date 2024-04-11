Return-Path: <linux-kernel+bounces-139597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9708A04EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D78B24242
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B3946F;
	Thu, 11 Apr 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="hz1spajE"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51251119B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796708; cv=none; b=oBeTvu7c9JeykJJiRR5SWnmNS5rjzBWHG0Yui5Mwtp2Dv2/u6eMDaJ9+62EwYSWvJ/tLi/EJRrCQhIi8MYBusLswZlPnAT06FJ4/bHSNnWqz2WKt2jdY64Fmj8CHwklw2h8RUwCSPmALdl9Y0iDb1wUYHU+aqhg+FoPdvJO9/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796708; c=relaxed/simple;
	bh=0K4TZBePvBxEpbZMaDmUuVsuBfSttKVJG4yDVJUb46w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KyXvWfAI/hFDdGIzrgHGOAOlFf8R6/wxR3whG7TmZ3CFChGYLbZRVTqEimoUIguXv2JlWc/G3Lg7U/3+eaDz4gfCa403fRW+qQU5UvAO0D7Q1nrkNucZ5FlZW/PTsu7sNTTqL1x95jjzAZCPMVdN0EDahO1e53i6hxEAnl5Ehbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=hz1spajE; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id DBC20425C1;
	Thu, 11 Apr 2024 00:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1712796705; bh=0K4TZBePvBxEpbZMaDmUuVsuBfSttKVJG4yDVJUb46w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hz1spajEMg+3ADUd7G6gmCypE69lWE+6evcxkkEXR5QPC9frxm8fR8hTbo0VSX2+W
	 oRDocscZhWJPBLKxYn5lBn5ZB2YqAYG7vQRPpOWEr8MoRVLqhYDjEAJzqqBjlNiQkh
	 gcoE2W++u8bMDTd3/QECYG3x4dPVjE2OlfDSgl782rl1c7bbV3kmx2mp1FVi5Rr/vK
	 eOewYrvSRxYygENC6IbCw7dXNYtMv/oBLICvNsYDVqRONBPvBaJJWT8gV4ZYmA9Z4C
	 Q4WDteGsrwQgxl6CL1GSLZisEZLmfgX4yuqt1ScTz7eOv1prVATQL/4Lcp4vNWN/I5
	 Aiu0gNFpiZzvw==
From: Hector Martin <marcan@marcan.st>
Date: Thu, 11 Apr 2024 09:51:22 +0900
Subject: [PATCH 3/4] arm64: Introduce scaffolding to add ACTLR_EL1 to
 thread state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-tso-v1-3-754f11abfbff@marcan.st>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
In-Reply-To: <20240411-tso-v1-0-754f11abfbff@marcan.st>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Zayd Qumsieh <zayd_qumsieh@apple.com>, Justin Lu <ih_justin@apple.com>, 
 Ryan Houdek <Houdek.Ryan@fex-emu.org>, Mark Brown <broonie@kernel.org>, 
 Ard Biesheuvel <ardb@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>, 
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>, 
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>, 
 Dawei Li <dawei.li@shingroup.cn>, Andrew Morton <akpm@linux-foundation.org>, 
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>, 
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>, 
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>, 
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Asahi Linux <asahi@lists.linux.dev>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4561; i=marcan@marcan.st;
 h=from:subject:message-id; bh=0K4TZBePvBxEpbZMaDmUuVsuBfSttKVJG4yDVJUb46w=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhjRxEx6F/QufTKyTf5Q0scmR133RpmfxhySmHREz/Nxdn
 TJ72+2MjlIWBjEuBlkxRZbGE72nuj2nn1NXTZkOM4eVCWQIAxenAEykT5bhv1c/75ffmS942dRm
 ZCjZV8/tzJlxLCL/d9VPzpuLr/z7tYGRoUP3lmXFzym1hTP2lD8XrtzBImhu67X9df0GJg+Paqt
 uXgA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5

Some CPUs expose IMPDEF features in ACTLR_EL1 that can be meaningfully
controlled per-thread (like TSO control on Apple cores). Add the basic
scaffolding to save/restore this register as part of context switching.

This mechanism is disabled by default both by config symbol and via a
runtime check, which ensures it is never triggered unless the system is
known to need it for some feature (which also implies that the layout of
ACTLR_EL1 is uniform between all CPU core types).

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/Kconfig                  |  3 +++
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/include/asm/processor.h  |  3 +++
 arch/arm64/kernel/process.c         | 25 +++++++++++++++++++++++++
 arch/arm64/kernel/setup.c           |  8 ++++++++
 5 files changed, 44 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f8e66fe44ff4..9b3593b34cce 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -408,6 +408,9 @@ config KASAN_SHADOW_OFFSET
 config UNWIND_TABLES
 	bool
 
+config ARM64_ACTLR_STATE
+	bool
+
 source "arch/arm64/Kconfig.platforms"
 
 menu "Kernel Features"
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index fb215b0e7529..46ab37f8f4d8 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -909,6 +909,11 @@ static inline unsigned int get_vmid_bits(u64 mmfr1)
 	return 8;
 }
 
+static __always_inline bool system_has_actlr_state(void)
+{
+	return false;
+}
+
 s64 arm64_ftr_safe_value(const struct arm64_ftr_bits *ftrp, s64 new, s64 cur);
 struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id);
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f77371232d8c..d43c5791a35e 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -184,6 +184,9 @@ struct thread_struct {
 	u64			sctlr_user;
 	u64			svcr;
 	u64			tpidr2_el0;
+#ifdef CONFIG_ARM64_ACTLR_STATE
+	u64			actlr;
+#endif
 };
 
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7920056bad3e..117f80e16aac 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -372,6 +372,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		if (system_supports_tpidr2())
 			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 
+#ifdef CONFIG_ARM64_ACTLR_STATE
+		if (system_has_actlr_state())
+			p->thread.actlr = read_sysreg(actlr_el1);
+#endif
+
 		if (stack_start) {
 			if (is_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
@@ -533,6 +538,25 @@ int arch_prctl_mem_model_set(struct task_struct *t, unsigned long val)
 }
 #endif
 
+#ifdef CONFIG_ARM64_ACTLR_STATE
+/*
+ * IMPDEF control register ACTLR_EL1 handling. Some CPUs use this to
+ * expose features that can be controlled by userspace.
+ */
+static void actlr_thread_switch(struct task_struct *next)
+{
+	if (!system_has_actlr_state())
+		return;
+
+	current->thread.actlr = read_sysreg(actlr_el1);
+	write_sysreg(next->thread.actlr, actlr_el1);
+}
+#else
+static inline void actlr_thread_switch(struct task_struct *next)
+{
+}
+#endif
+
 /*
  * Thread switching.
  */
@@ -550,6 +574,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(next);
 	ptrauth_thread_switch_user(next);
+	actlr_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 65a052bf741f..35342f633a85 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -359,6 +359,14 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 */
 	init_task.thread_info.ttbr0 = phys_to_ttbr(__pa_symbol(reserved_pg_dir));
 #endif
+#ifdef CONFIG_ARM64_ACTLR_STATE
+	/* Store the boot CPU ACTLR_EL1 value as the default. This will only
+	 * be actually restored during context switching iff the platform is
+	 * known to use ACTLR_EL1 for exposable features and its layout is
+	 * known to be the same on all CPUs.
+	 */
+	init_task.thread.actlr = read_sysreg(actlr_el1);
+#endif
 
 	if (boot_args[1] || boot_args[2] || boot_args[3]) {
 		pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"

-- 
2.44.0


