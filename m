Return-Path: <linux-kernel+bounces-139598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927C8A04F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148281F25226
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B31119B;
	Thu, 11 Apr 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="hQsQ2KMF"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880513ADC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796713; cv=none; b=UsoojF9mSyg37j50bH2eT0S3KOMmwDVle9TA4KFDXWeBn2z204VwzoWW0yL35r+g2DS2kawUnu7aUVU8mJRixSrBd+vjaUuIloiAnQe1Y3KAx1nO5wu8Rt7Kq6iVTG+opj+8vhAeqBqxxoGy9zBRuMQFWHp+3HAtZ/YwhlHFmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796713; c=relaxed/simple;
	bh=A6cfBeGeoux68NpHgjY1yK+Y/P3gva5wYhlCSyteIQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEjsKb4ATcT/GFSsvHGwJN5kM+a2zoZRjIDEtWqCo85QcuJ1lDhF/XvQ2W4rj0HdKUue/IMz/LKUP2R9eAZrQbUcNBqTmbKdRSC15kfJFPgsrQeABo4pInH/vHqQdR/o45OxPBgM7+AdmnzqmwPqlOPVgvuiOHgHdRH0pSz1moI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=hQsQ2KMF; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id A9CB8425C7;
	Thu, 11 Apr 2024 00:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1712796710; bh=A6cfBeGeoux68NpHgjY1yK+Y/P3gva5wYhlCSyteIQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hQsQ2KMFH+62Ms4wBxA9kOprBD45PuiudDTCI4Jc4FGX9LpD74wyBTzgEPPVjWUnB
	 953bY8Dqz9SO3OO4aOQL27CegKMagwfpLuV+N2j2IubpZ7mJZRXeV17q646tvLmMdj
	 AQDO6gvir7cpikZZ9v9b5p9KjuO929lju6gRqXmEl6ayhx28tondrxz9ioiCDG4zG/
	 k8Tkna5i6wcEZy8+4LyPyH56PrRn/PB64V2/cZ1Ga6JK07yFX/7ipVjJ20wK9jbGED
	 /rxmNI9VBoHwwwL0I2ru1B1ACbf8DbqhzbbOC/lshwf4EIjeUqmSxkMii2YRtjO8Uj
	 BZfDAJl3lm9Rg==
From: Hector Martin <marcan@marcan.st>
Date: Thu, 11 Apr 2024 09:51:23 +0900
Subject: [PATCH 4/4] arm64: Implement Apple IMPDEF TSO memory model control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-tso-v1-4-754f11abfbff@marcan.st>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5582; i=marcan@marcan.st;
 h=from:subject:message-id; bh=A6cfBeGeoux68NpHgjY1yK+Y/P3gva5wYhlCSyteIQ8=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhjRxE94WxUt9IucjBTdtv6v15/UKdQNda43uC39P229ef
 uim5u6wjlIWBjEuBlkxRZbGE72nuj2nn1NXTZkOM4eVCWQIAxenAEzkhCrDf8/nnCam8mvmbv3j
 rVJcmMGmb8BzQcSso17uv+gqxuKo9Qz/7O4K+/y0uul+TvFG7uNAH1NVHblvejunNfWVqW+SPqj
 PBAA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5

Apple CPUs may implement the TSO memory model as an optional
configurable mode. This allows x86 emulators to simplify their
load/store handling, greatly increasing performance.

Expose this via the prctl PR_SET_MEM_MODEL_TSO mechanism. We use the
Apple IMPDEF AIDR_EL1 register to check for the availability of TSO
mode, and enable this codepath on all CPUs with an Apple implementer.

This relies on the ACTLR_EL1 thread state scaffolding introduced
earlier.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/Kconfig                        |  2 ++
 arch/arm64/include/asm/apple_cpufeature.h | 15 +++++++++++++++
 arch/arm64/include/asm/cpufeature.h       |  3 ++-
 arch/arm64/kernel/cpufeature_impdef.c     | 23 +++++++++++++++++++++++
 arch/arm64/kernel/process.c               | 22 ++++++++++++++++++++++
 arch/arm64/tools/cpucaps                  |  1 +
 6 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9b3593b34cce..2f3eedd955c9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2167,6 +2167,8 @@ endif # ARM64_PSEUDO_NMI
 
 config ARM64_MEMORY_MODEL_CONTROL
 	bool "Runtime memory model control"
+	default ARCH_APPLE
+	select ARM64_ACTLR_STATE
 	help
 	  Some ARM64 CPUs support runtime switching of the CPU memory
 	  model, which can be useful to emulate other CPU architectures
diff --git a/arch/arm64/include/asm/apple_cpufeature.h b/arch/arm64/include/asm/apple_cpufeature.h
new file mode 100644
index 000000000000..4370d91ffa3e
--- /dev/null
+++ b/arch/arm64/include/asm/apple_cpufeature.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __ASM_APPLE_CPUFEATURES_H
+#define __ASM_APPLE_CPUFEATURES_H
+
+#include <linux/bits.h>
+#include <asm/sysreg.h>
+
+#define AIDR_APPLE_TSO_SHIFT	9
+#define AIDR_APPLE_TSO		BIT(9)
+
+#define ACTLR_APPLE_TSO_SHIFT	1
+#define ACTLR_APPLE_TSO		BIT(1)
+
+#endif
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 46ab37f8f4d8..a191000d88c2 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -911,7 +911,8 @@ static inline unsigned int get_vmid_bits(u64 mmfr1)
 
 static __always_inline bool system_has_actlr_state(void)
 {
-	return false;
+	return IS_ENABLED(CONFIG_ARM64_ACTLR_STATE) &&
+		alternative_has_cap_unlikely(ARM64_HAS_TSO_APPLE);
 }
 
 s64 arm64_ftr_safe_value(const struct arm64_ftr_bits *ftrp, s64 new, s64 cur);
diff --git a/arch/arm64/kernel/cpufeature_impdef.c b/arch/arm64/kernel/cpufeature_impdef.c
index bb04a8e3d79d..9325d1eb12f4 100644
--- a/arch/arm64/kernel/cpufeature_impdef.c
+++ b/arch/arm64/kernel/cpufeature_impdef.c
@@ -4,8 +4,21 @@
  */
 
 #include <asm/cpufeature.h>
+#include <asm/apple_cpufeature.h>
 
 #ifdef CONFIG_ARM64_MEMORY_MODEL_CONTROL
+static bool has_apple_feature(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	u64 val;
+	WARN_ON(scope != SCOPE_SYSTEM);
+
+	if (read_cpuid_implementor() != ARM_CPU_IMP_APPLE)
+		return false;
+
+	val = read_sysreg(aidr_el1);
+	return cpufeature_matches(val, entry);
+}
+
 static bool has_tso_fixed(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	/* List of CPUs that always use the TSO memory model */
@@ -22,6 +35,16 @@ static bool has_tso_fixed(const struct arm64_cpu_capabilities *entry, int scope)
 
 static const struct arm64_cpu_capabilities arm64_impdef_features[] = {
 #ifdef CONFIG_ARM64_MEMORY_MODEL_CONTROL
+	{
+		.desc = "TSO memory model (Apple)",
+		.capability = ARM64_HAS_TSO_APPLE,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_apple_feature,
+		.field_pos = AIDR_APPLE_TSO_SHIFT,
+		.field_width = 1,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 1,
+	},
 	{
 		.desc = "TSO memory model (Fixed)",
 		.capability = ARM64_HAS_TSO_FIXED,
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 117f80e16aac..34a19ecfb630 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -44,6 +44,7 @@
 #include <linux/memory_ordering_model.h>
 
 #include <asm/alternative.h>
+#include <asm/apple_cpufeature.h>
 #include <asm/compat.h>
 #include <asm/cpufeature.h>
 #include <asm/cacheflush.h>
@@ -522,6 +523,10 @@ void update_sctlr_el1(u64 sctlr)
 #ifdef CONFIG_ARM64_MEMORY_MODEL_CONTROL
 int arch_prctl_mem_model_get(struct task_struct *t)
 {
+	if (alternative_has_cap_unlikely(ARM64_HAS_TSO_APPLE) &&
+		t->thread.actlr & ACTLR_APPLE_TSO)
+		return PR_SET_MEM_MODEL_TSO;
+
 	return PR_SET_MEM_MODEL_DEFAULT;
 }
 
@@ -531,6 +536,23 @@ int arch_prctl_mem_model_set(struct task_struct *t, unsigned long val)
 	    val == PR_SET_MEM_MODEL_TSO)
 		return 0;
 
+	if (alternative_has_cap_unlikely(ARM64_HAS_TSO_APPLE)) {
+		WARN_ON(!system_has_actlr_state());
+
+		switch (val) {
+		case PR_SET_MEM_MODEL_TSO:
+			t->thread.actlr |= ACTLR_APPLE_TSO;
+			break;
+		case PR_SET_MEM_MODEL_DEFAULT:
+			t->thread.actlr &= ~ACTLR_APPLE_TSO;
+			break;
+		default:
+			return -EINVAL;
+		}
+		write_sysreg(t->thread.actlr, actlr_el1);
+		return 0;
+	}
+
 	if (val == PR_SET_MEM_MODEL_DEFAULT)
 		return 0;
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index daa6b9495402..62f9ca9ce44b 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -52,6 +52,7 @@ HAS_STAGE2_FWB
 HAS_TCR2
 HAS_TIDCP1
 HAS_TLB_RANGE
+HAS_TSO_APPLE
 HAS_TSO_FIXED
 HAS_VA52
 HAS_VIRT_HOST_EXTN

-- 
2.44.0


