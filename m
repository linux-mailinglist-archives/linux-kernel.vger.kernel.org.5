Return-Path: <linux-kernel+bounces-135849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE489CC09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06564B23F00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C001474A6;
	Mon,  8 Apr 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZvNrH4B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B6146A6E;
	Mon,  8 Apr 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602525; cv=none; b=oRWyvDQrJj26b1r1QpEM5bUNYtbfzpIcerxjkP9mtJjwqHXyYEXRLQL7nAV3hGaHvn/t4fE3muv8z76agYteyYoq2q3nOshxiG30jLNGYkx0uEQC896YO2jk/v6M8rcaLIXQb/k4fhETwM1uTVyvDHtVWTsAgRidGl03UXgg6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602525; c=relaxed/simple;
	bh=7PoVJmimaSPjnO8B487RlebpLNs+6OqGKUwsigSg9gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7KMi0thIC62WiVZGarkfbgGmcYJrOP+x8KB7VDA5FHvzrKdqrwX6ZAVZ+SA78TDE7i97/n2lVL3lepFbkvj1ueLrPsARsTx/A6pFDo8ctf/bk5RqkXd2nO2hepjedzeMvaCrA+87wdc55HITJrteCA21+e9cW7EecrTRfUhvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZvNrH4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11922C43390;
	Mon,  8 Apr 2024 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602524;
	bh=7PoVJmimaSPjnO8B487RlebpLNs+6OqGKUwsigSg9gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZvNrH4BmeNOmDOldspGZUSicZ0uN54YWEf2xmXkxloPSVfVl8ZPhsn946eJ1ncYp
	 CXyQ2R45675G4pmQR+NPsU7QmKq6GzDp0YRgNEI0x7ogBx0tYCZ26brPIffNj/oscn
	 SnSAbG4tf/oNVFbuxhHNtw/RX68thDTWZyTA0GdEuMCNoNPZf8QINZx6BYLyNV5vdT
	 B+URhLgPxePH9GyHQvSkEuSgPKoQiJKrUQWOsxFqLCC5k//TRb/W1GGgB6pu2PDn6/
	 0/1nrnO01AiJPg+Pc45F9n49MUuPGL8ctdxWlkWyoxSzBepfRhirP7ooFYPm6aDi9K
	 zjIg85yeU/QIQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: [PATCH 5/9] tools/include: Sync x86 CPU feature headers with the kernel sources
Date: Mon,  8 Apr 2024 11:55:16 -0700
Message-ID: <20240408185520.1550865-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240408185520.1550865-1-namhyung@kernel.org>
References: <20240408185520.1550865-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes from:

  598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")
  7f274e609f3d ("x86/cpufeatures: Add new word for scattered features")

This should address these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
    diff -u tools/arch/x86/include/asm/required-features.h arch/x86/include/asm/required-features.h
    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/x86/include/asm/cpufeatures.h       | 17 ++++++++++++-----
 tools/arch/x86/include/asm/disabled-features.h | 11 +++++++++--
 tools/arch/x86/include/asm/required-features.h |  3 ++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 25160d26764b..a38f8f9ba657 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			21	   /* N 32-bit words worth of info */
+#define NCAPINTS			22	   /* N 32-bit words worth of info */
 #define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
@@ -81,10 +81,8 @@
 #define X86_FEATURE_K6_MTRR		( 3*32+ 1) /* AMD K6 nonstandard MTRRs */
 #define X86_FEATURE_CYRIX_ARR		( 3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* Centaur MCRs (= MTRRs) */
-
-/* CPU types for specific tunings: */
 #define X86_FEATURE_K8			( 3*32+ 4) /* "" Opteron, Athlon64 */
-/* FREE, was #define X86_FEATURE_K7			( 3*32+ 5) "" Athlon */
+#define X86_FEATURE_ZEN5		( 3*32+ 5) /* "" CPU based on Zen5 microarchitecture */
 #define X86_FEATURE_P3			( 3*32+ 6) /* "" P3 */
 #define X86_FEATURE_P4			( 3*32+ 7) /* "" P4 */
 #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* TSC ticks at a constant rate */
@@ -97,7 +95,7 @@
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
 #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
-/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
+#define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* "" Clear CPU buffers using VERW */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
 #define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
@@ -461,6 +459,14 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
+/*
+ * Extended auxiliary flags: Linux defined - for features scattered in various
+ * CPUID levels like 0x80000022, etc.
+ *
+ * Reuse free bits when adding new feature flags!
+ */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* AMD LBR and PMC Freeze */
+
 /*
  * BUG word(s)
  */
@@ -508,4 +514,5 @@
 /* BUG word 2 */
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 1f23960d2b06..c492bdc97b05 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -123,6 +123,12 @@
 # define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
 #endif
 
+#ifdef CONFIG_KVM_AMD_SEV
+#define DISABLE_SEV_SNP		0
+#else
+#define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -147,8 +153,9 @@
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	(DISABLE_IBT)
-#define DISABLED_MASK19	0
+#define DISABLED_MASK19	(DISABLE_SEV_SNP)
 #define DISABLED_MASK20	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define DISABLED_MASK21	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index 7ba1726b71c7..e9187ddd3d1f 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -99,6 +99,7 @@
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
 #define REQUIRED_MASK20	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define REQUIRED_MASK21	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
-- 
2.44.0.478.gd926399ef9-goog


