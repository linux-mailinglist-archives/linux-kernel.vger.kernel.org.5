Return-Path: <linux-kernel+bounces-139596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EDD8A04EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D0B285BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DB1F9DA;
	Thu, 11 Apr 2024 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="nX/a7pNH"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7AD528
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796704; cv=none; b=fy6GKmG/xGV6zbeLS9JUSfVN9Hd78daZXVlyR71JiGHuciYgmepUg2kSpoxqeM406YrptqFmtMUoYHTMoJo2ATfl9ToMwaOtFh5PwlWzLBnloqNC+zhqGQXchWIQZn5aDcsBhCXBznCkkO9VtDGWFYcjOXjY9S9IWR72Z1Hl7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796704; c=relaxed/simple;
	bh=oISCn6HTlsZmKUOaxgKnHYg672B8CResDHmP3zCW1MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r8l9JdUfvH0vmo6JMQs2k55nspWWKVfr9HEYAUTjEy0lk9LjeE7WeJF3HcM5e0T7aQXF0jEj5leVZKnlRzHDEOA95gCH/QlpJUMFSnFm2WQpDMXzS96LKmLN1oWu1gvyJmvrMdEOJQUF5vKxg0gzUO57OFYtEQZgZGJ3lLwLGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=nX/a7pNH; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id E1A2A425BF;
	Thu, 11 Apr 2024 00:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1712796700; bh=oISCn6HTlsZmKUOaxgKnHYg672B8CResDHmP3zCW1MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nX/a7pNHfAXiCvRUmeEGsXfJVsBpAIZIlubeHMBosYwoGG9hmjlvdA6KaxDZqVlmF
	 DQ8gk3hkbT1EJItGpRUeCt8GpUbQ6y/tVQFTq6tgETvz2+e9+DmSuF3ETKPyqrPKbX
	 +Vcobr4fAoSgW+2VQQVIq6NB9i6nF2s6XQo0N7XfSFv6AgbTpUFXcnR9AnBN+/dAy4
	 UPWebzHr4TRcRy/TWjdq3mddtslfLBX3iPQmq354fAm4TS31TL3Rv0+XUVsVxQ6lKw
	 nBWLYwF1QWsf4zFyV0WXi6BHwx+BDABMl+o4NvlHVRk5cK+i9lUBdZax/YpXNeWxlS
	 Yz4v6kLwcQJLQ==
From: Hector Martin <marcan@marcan.st>
Date: Thu, 11 Apr 2024 09:51:21 +0900
Subject: [PATCH 2/4] arm64: Implement PR_{GET,SET}_MEM_MODEL for always-TSO
 CPUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-tso-v1-2-754f11abfbff@marcan.st>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7167; i=marcan@marcan.st;
 h=from:subject:message-id; bh=oISCn6HTlsZmKUOaxgKnHYg672B8CResDHmP3zCW1MM=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhjRxE57a5HP7e152SOzeJvh2p2AX49RolkDJPZGnTUpP5
 n4Nf67cUcrCIMbFICumyNJ4ovdUt+f0c+qqKdNh5rAygQxh4OIUgIlINDEyvCuZ4TiNf9VBZyNn
 vnz36mhP85dRLcaxXYvPJi7UdnPRYfgr3/FliYvzRIPclbu/bHBMbTnw6Y+09xdhRZMVFxklbRJ
 4AQ==
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5

Some ARM64 implementations are known to always use the TSO memory model.
Add trivial support for the PR_{GET,SET}_MEM_MODEL prctl, which allows
userspace to learn this fact.

Known TSO implementations:
- Nvidia Denver
- Nvidia Carmel
- Fujitsu A64FX

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/Kconfig                    |  9 +++++++++
 arch/arm64/include/asm/cpufeature.h   |  4 ++++
 arch/arm64/kernel/Makefile            |  3 ++-
 arch/arm64/kernel/cpufeature.c        | 11 +++++-----
 arch/arm64/kernel/cpufeature_impdef.c | 38 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c           | 24 ++++++++++++++++++++++
 arch/arm64/tools/cpucaps              |  1 +
 7 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..f8e66fe44ff4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2162,6 +2162,15 @@ config ARM64_DEBUG_PRIORITY_MASKING
 	  If unsure, say N
 endif # ARM64_PSEUDO_NMI
 
+config ARM64_MEMORY_MODEL_CONTROL
+	bool "Runtime memory model control"
+	help
+	  Some ARM64 CPUs support runtime switching of the CPU memory
+	  model, which can be useful to emulate other CPU architectures
+	  which have different memory models. Say Y to enable support
+	  for the PR_SET_MEM_MODEL/PR_GET_MEM_MODEL prctl() calls on
+	  CPUs with this feature.
+
 config RELOCATABLE
 	bool "Build a relocatable kernel image" if EXPERT
 	select ARCH_HAS_RELR
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8b904a757bd3..fb215b0e7529 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -1032,6 +1032,10 @@ static inline bool cpu_has_lpa2(void)
 #endif
 }
 
+void __init init_cpucap_indirect_list_impdef(void);
+void __init init_cpucap_indirect_list_from_array(const struct arm64_cpu_capabilities *caps);
+bool cpufeature_matches(u64 reg, const struct arm64_cpu_capabilities *entry);
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 763824963ed1..5eaaee7b8358 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -33,7 +33,8 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
-			   syscall.o proton-pack.o idle.o patching.o pi/
+			   syscall.o proton-pack.o idle.o patching.o pi/	\
+			   cpufeature_impdef.o
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 56583677c1f2..e39ab93ad683 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1028,7 +1028,7 @@ static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
 extern const struct arm64_cpu_capabilities arm64_errata[];
 static const struct arm64_cpu_capabilities arm64_features[];
 
-static void __init
+void __init
 init_cpucap_indirect_list_from_array(const struct arm64_cpu_capabilities *caps)
 {
 	for (; caps->matches; caps++) {
@@ -1540,8 +1540,8 @@ has_always(const struct arm64_cpu_capabilities *entry, int scope)
 	return true;
 }
 
-static bool
-feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
+bool
+cpufeature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 {
 	int val, min, max;
 	u64 tmp;
@@ -1594,14 +1594,14 @@ has_user_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 	if (!mask)
 		return false;
 
-	return feature_matches(val, entry);
+	return cpufeature_matches(val, entry);
 }
 
 static bool
 has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	u64 val = read_scoped_sysreg(entry, scope);
-	return feature_matches(val, entry);
+	return cpufeature_matches(val, entry);
 }
 
 const struct cpumask *system_32bit_el0_cpumask(void)
@@ -3486,6 +3486,7 @@ void __init setup_boot_cpu_features(void)
 	 * handle the boot CPU.
 	 */
 	init_cpucap_indirect_list();
+	init_cpucap_indirect_list_impdef();
 
 	/*
 	 * Detect broken pseudo-NMI. Must be called _before_ the call to
diff --git a/arch/arm64/kernel/cpufeature_impdef.c b/arch/arm64/kernel/cpufeature_impdef.c
new file mode 100644
index 000000000000..bb04a8e3d79d
--- /dev/null
+++ b/arch/arm64/kernel/cpufeature_impdef.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Contains implementation-defined CPU feature definitions.
+ */
+
+#include <asm/cpufeature.h>
+
+#ifdef CONFIG_ARM64_MEMORY_MODEL_CONTROL
+static bool has_tso_fixed(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	/* List of CPUs that always use the TSO memory model */
+	static const struct midr_range fixed_tso_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_NVIDIA_DENVER),
+		MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
+		MIDR_ALL_VERSIONS(MIDR_FUJITSU_A64FX),
+		{ /* sentinel */ }
+	};
+
+	return is_midr_in_range_list(read_cpuid_id(), fixed_tso_list);
+}
+#endif
+
+static const struct arm64_cpu_capabilities arm64_impdef_features[] = {
+#ifdef CONFIG_ARM64_MEMORY_MODEL_CONTROL
+	{
+		.desc = "TSO memory model (Fixed)",
+		.capability = ARM64_HAS_TSO_FIXED,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_tso_fixed,
+	},
+#endif
+	{},
+};
+
+void __init init_cpucap_indirect_list_impdef(void)
+{
+	init_cpucap_indirect_list_from_array(arm64_impdef_features);
+}
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4ae31b7af6c3..7920056bad3e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -41,6 +41,7 @@
 #include <linux/thread_info.h>
 #include <linux/prctl.h>
 #include <linux/stacktrace.h>
+#include <linux/memory_ordering_model.h>
 
 #include <asm/alternative.h>
 #include <asm/compat.h>
@@ -513,6 +514,25 @@ void update_sctlr_el1(u64 sctlr)
 	isb();
 }
 
+#ifdef CONFIG_ARM64_MEMORY_MODEL_CONTROL
+int arch_prctl_mem_model_get(struct task_struct *t)
+{
+	return PR_SET_MEM_MODEL_DEFAULT;
+}
+
+int arch_prctl_mem_model_set(struct task_struct *t, unsigned long val)
+{
+	if (alternative_has_cap_unlikely(ARM64_HAS_TSO_FIXED) &&
+	    val == PR_SET_MEM_MODEL_TSO)
+		return 0;
+
+	if (val == PR_SET_MEM_MODEL_DEFAULT)
+		return 0;
+
+	return -EINVAL;
+}
+#endif
+
 /*
  * Thread switching.
  */
@@ -651,6 +671,10 @@ void arch_setup_new_exec(void)
 		arch_prctl_spec_ctrl_set(current, PR_SPEC_STORE_BYPASS,
 					 PR_SPEC_ENABLE);
 	}
+
+#ifdef CONFIG_ARM64_MEMORY_MODEL_CONTROL
+	arch_prctl_mem_model_set(current, PR_SET_MEM_MODEL_DEFAULT);
+#endif
 }
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 62b2838a231a..daa6b9495402 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -52,6 +52,7 @@ HAS_STAGE2_FWB
 HAS_TCR2
 HAS_TIDCP1
 HAS_TLB_RANGE
+HAS_TSO_FIXED
 HAS_VA52
 HAS_VIRT_HOST_EXTN
 HAS_WFXT

-- 
2.44.0


