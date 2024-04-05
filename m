Return-Path: <linux-kernel+bounces-132342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFEB89935F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268A3B25ADE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694718E28;
	Fri,  5 Apr 2024 02:47:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4422616;
	Fri,  5 Apr 2024 02:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285242; cv=none; b=RAEz5NlyGXYNBbAipkwc23JHNgfbR93S7J+OxS/8gkBNhurFpzGjg0WQQ/OtBCgVIIZ02bXT1U5pNHu4CX+ykYThafF9+q4imOoWQUeWVTkYXI68W5rux/X0Z4v+CMSoo0pSZ1cIj9KNmJGqHBsiz9fRQet8LQRZbgMtMJaUZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285242; c=relaxed/simple;
	bh=JwC7YAnWyfiHK6XtAKEvLgWXV6GQ33AAA/cq7RvWPC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQW0K2Y5hOazEEx9Y11/HEuT6RQsqMl9r41hhTid5dwbzsY3aF3Rwp97yRo8ZZrf/c0BXG9LXx6GacvsVnxRTY+ABTA1P1NupTCusBFnKDCe79l6QZJzDoZshknm/YsERi1w3TDIGxrtwW5qr2FH0UaDpL0vIi4VBLkKeLqgxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64B6BFEC;
	Thu,  4 Apr 2024 19:47:50 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28F0E3F766;
	Thu,  4 Apr 2024 19:47:13 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-doc@vger.kernel.org
Subject: [PATCH V17 4/9] arm64/boot: Enable EL2 requirements for BRBE
Date: Fri,  5 Apr 2024 08:16:34 +0530
Message-Id: <20240405024639.1179064-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405024639.1179064-1-anshuman.khandual@arm.com>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fine grained trap control for BRBE registers, and instructions access need
to be configured in HDFGRTR_EL2, HDFGWTR_EL2 and HFGITR_EL2 registers when
kernel enters at EL1 but EL2 is present. This changes __init_el2_fgt() as
required.

Similarly cycle and mis-prediction capture need to be enabled in BRBCR_EL1
and BRBCR_EL2 when the kernel enters either into EL1 or EL2. This adds new
__init_el2_brbe() to achieve this objective.

This also updates Documentation/arch/arm64/booting.rst with all the above
EL2 along with MDRC_EL3.SBRBE requirements.

First this replaces an existing hard encoding (1 << 62) with corresponding
applicable macro HDFGRTR_EL2_nPMSNEVFR_EL1_MASK.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
----
Changes in V17:

- New patch added in the series
- Separated out from the BRBE driver implementation patch
- Dropped the comment in __init_el2_brbe()
- Updated __init_el2_brbe() with BRBCR_EL2.MPRED requirements
- Updated __init_el2_brbe() with __check_hvhe() constructs
- Updated booting.rst regarding MPRED, MDCR_EL3 and fine grained control

 Documentation/arch/arm64/booting.rst | 26 ++++++++
 arch/arm64/include/asm/el2_setup.h   | 90 +++++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index b57776a68f15..512210da7dd2 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -349,6 +349,32 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HWFGWTR_EL2.nSMPRI_EL1 (bit 54) must be initialised to 0b01.
 
+  For CPUs with feature Branch Record Buffer Extension (FEAT_BRBE):
+
+  - If the kernel is entered at EL2 and EL1 is present:
+
+    - BRBCR_EL1.CC (bit 3) must be initialised to 0b1.
+    - BRBCR_EL1.MPRED (bit 4) must be initialised to 0b1.
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - BRBCR_EL2.CC (bit 3) must be initialised to 0b1.
+    - BRBCR_EL2.MPRED (bit 4) must be initialised to 0b1.
+
+    - HDFGRTR_EL2.nBRBDATA (bit 61) must be initialised to 0b1.
+    - HDFGRTR_EL2.nBRBCTL  (bit 60) must be initialised to 0b1.
+    - HDFGRTR_EL2.nBRBIDR  (bit 59) must be initialised to 0b1.
+
+    - HDFGWTR_EL2.nBRBDATA (bit 61) must be initialised to 0b1.
+    - HDFGWTR_EL2.nBRBCTL  (bit 60) must be initialised to 0b1.
+
+    - HFGITR_EL2.nBRBIALL (bit 56) must be initialised to 0b1.
+    - HFGITR_EL2.nBRBINJ  (bit 55) must be initialised to 0b1.
+
+  - If EL3 is present:
+
+    - MDCR_EL3.SBRBE (bits 33:32) must be initialised to 0b11.
+
   For CPUs with the Scalable Matrix Extension FA64 feature (FEAT_SME_FA64):
 
   - If EL3 is present:
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index b7afaa026842..7c12a8e658d4 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -154,6 +154,41 @@
 .Lskip_set_cptr_\@:
 .endm
 
+#ifdef CONFIG_ARM64_BRBE
+/*
+ * Enable BRBE cycle count and miss-prediction
+ *
+ * BRBE requires both BRBCR_EL1.CC and BRBCR_EL2.CC fields, be set
+ * for the cycle counts to be available in BRBINF<N>_EL1.CC during
+ * branch record processing after a PMU interrupt. This enables CC
+ * field on both these registers while still executing inside EL2.
+ *
+ * BRBE driver would still be able to toggle branch records cycle
+ * count support via BRBCR_EL1.CC field regardless of whether the
+ * kernel ends up executing in EL1 or EL2.
+ *
+ * The same principle applies for branch record mis-prediction info
+ * as well, thus requiring MPRED field to be set on both BRBCR_EL1
+ * and BRBCR_EL2 while still executing inside EL2.
+ */
+.macro __init_el2_brbe
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_\@
+
+	mov_q	x0, BRBCR_ELx_CC | BRBCR_ELx_MPRED
+	msr_s	SYS_BRBCR_EL2, x0
+
+	__check_hvhe .Lset_brbe_nvhe_\@, x1
+	msr_s	SYS_BRBCR_EL12, x0	// VHE
+	b	.Lskip_brbe_\@
+
+.Lset_brbe_nvhe_\@:
+	msr_s	SYS_BRBCR_EL1, x0	// NVHE
+.Lskip_brbe_\@:
+.endm
+#endif /* CONFIG_ARM64_BRBE */
+
 /* Disable any fine grained traps */
 .macro __init_el2_fgt
 	mrs	x1, id_aa64mmfr0_el1
@@ -161,16 +196,48 @@
 	cbz	x1, .Lskip_fgt_\@
 
 	mov	x0, xzr
+	mov	x2, xzr
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
 	cmp	x1, #3
 	b.lt	.Lset_debug_fgt_\@
+
 	/* Disable PMSNEVFR_EL1 read and write traps */
-	orr	x0, x0, #(1 << 62)
+	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
+	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
 
 .Lset_debug_fgt_\@:
+#ifdef CONFIG_ARM64_BRBE
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_reg_fgt_\@
+
+	/*
+	 * Disable read traps for the following registers
+	 *
+	 * [BRBSRC|BRBTGT|RBINF]_EL1
+	 * [BRBSRCINJ|BRBTGTINJ|BRBINFINJ|BRBTS]_EL1
+	 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBDATA_MASK
+
+	/*
+	 * Disable write traps for the following registers
+	 *
+	 * [BRBSRCINJ|BRBTGTINJ|BRBINFINJ|BRBTS]_EL1
+	 */
+	orr	x2, x2, #HDFGWTR_EL2_nBRBDATA_MASK
+
+	/* Disable read and write traps for [BRBCR|BRBFCR]_EL1 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBCTL_MASK
+	orr	x2, x2, #HDFGWTR_EL2_nBRBCTL_MASK
+
+	/* Disable read traps for BRBIDR_EL1 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBIDR_MASK
+
+.Lskip_brbe_reg_fgt_\@:
+#endif /* CONFIG_ARM64_BRBE */
 	msr_s	SYS_HDFGRTR_EL2, x0
-	msr_s	SYS_HDFGWTR_EL2, x0
+	msr_s	SYS_HDFGWTR_EL2, x2
 
 	mov	x0, xzr
 	mrs	x1, id_aa64pfr1_el1
@@ -193,7 +260,21 @@
 .Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0
-	msr_s	SYS_HFGITR_EL2, xzr
+	mov	x0, xzr
+#ifdef CONFIG_ARM64_BRBE
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_insn_fgt_\@
+
+	/* Disable traps for BRBIALL instruction */
+	orr	x0, x0, #HFGITR_EL2_nBRBIALL_MASK
+
+	/* Disable traps for BRBINJ instruction */
+	orr	x0, x0, #HFGITR_EL2_nBRBINJ_MASK
+
+.Lskip_brbe_insn_fgt_\@:
+#endif /* CONFIG_ARM64_BRBE */
+	msr_s	SYS_HFGITR_EL2, x0
 
 	mrs	x1, id_aa64pfr0_el1		// AMU traps UNDEF without AMU
 	ubfx	x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4
@@ -228,6 +309,9 @@
 	__init_el2_nvhe_idregs
 	__init_el2_cptr
 	__init_el2_fgt
+#ifdef CONFIG_ARM64_BRBE
+	__init_el2_brbe
+#endif
 .endm
 
 #ifndef __KVM_NVHE_HYPERVISOR__
-- 
2.25.1


