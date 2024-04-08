Return-Path: <linux-kernel+bounces-135851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA589CC0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27ECC1C219FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA614882C;
	Mon,  8 Apr 2024 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKziX7k2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C40147C72;
	Mon,  8 Apr 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602526; cv=none; b=B+IT3lw/NrE9K7z5K/ZpwmEFWQaP+Osvs8H+UZAknOdNJ3JpUf12H3gXnwkyRdZoVWKnhfACS2Wi99rnrVydJ9qS615d/DWClRhdV/325HyX+aRiAcKg/+jHbPdtfYz97FdYWiuaFC4JudmtrvvbeW97qFcOnI4ml19sAptYHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602526; c=relaxed/simple;
	bh=eIb4mp2+ak7Zrc/JqmL5iOMyf+ztQz2scuPWswxDijM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNO1P9iKKktfeLQH0LYaQX1JABp859A4slqTzH8zdzGdpHDy5p4rBDrF/cin0YJv18EVGMhCK+XlsNolbcUngYV7Nt+RdKMgOiCEKHmLGUjk1bgmBCTRC4C5412Fy00hTkng9cZLGZsAzzy+6boqfjP/bDTC30sawMVmaqKjsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKziX7k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865B7C43390;
	Mon,  8 Apr 2024 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602526;
	bh=eIb4mp2+ak7Zrc/JqmL5iOMyf+ztQz2scuPWswxDijM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKziX7k2yShkVf0VUqBaAeeSjf8LQ/AyakjfKKgWV0l9T4dbSGLM6jB1X2fwEvzcs
	 ASbYFnsjHSRPLv8UzJ/NnrAxNk7sMCVIIKV0Wp4MUmRlpWcff6Vx6B7D1APZ5UUP8k
	 Kzl5YkuDB33frAUeNlQkbLR++I1n3BKCaIpOHzC8mD31anTECXmAXJwxXD1sB3Hs+v
	 E6TuOLGNK2m+YqlviGlvivvV7Bdbfm0s81aPsgCNm1wmsQCzYoGQtYvRwo/yKET+yZ
	 COKDG5ecMuZBp9crNTdkuBEtW6aWANBCmPBUg7gj5Jqj31Lk1VuCDE5vNuZyXLzta5
	 S2oWbhFWBEdjA==
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
Subject: [PATCH 7/9] tools/include: Sync x86 asm/msr-index.h with the kernel sources
Date: Mon,  8 Apr 2024 11:55:18 -0700
Message-ID: <20240408185520.1550865-8-namhyung@kernel.org>
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

  8076fcde016c ("x86/rfds: Mitigate Register File Data Sampling (RFDS)")
  d7b69b590bc9 ("x86/sev: Dump SEV_STATUS")
  cd6df3f378f6 ("x86/cpu: Add MSR numbers for FRED configuration")
  216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")

This should address these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/x86/include/asm/msr-index.h | 74 ++++++++++++++++++--------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 1f9dc9bd13eb..05956bd8bacf 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -176,6 +176,14 @@
 						 * CPU is not vulnerable to Gather
 						 * Data Sampling (GDS).
 						 */
+#define ARCH_CAP_RFDS_NO		BIT(27)	/*
+						 * Not susceptible to Register
+						 * File Data Sampling.
+						 */
+#define ARCH_CAP_RFDS_CLEAR		BIT(28)	/*
+						 * VERW clears CPU Register
+						 * File.
+						 */
 
 #define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
 						 * IA32_XAPIC_DISABLE_STATUS MSR
@@ -605,34 +613,47 @@
 #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
-#define MSR_AMD64_SEV_ES_ENABLED_BIT	1
-#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
+#define MSR_AMD64_SEV_ES_ENABLED_BIT	1
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
-
-/* SNP feature bits enabled by the hypervisor */
-#define MSR_AMD64_SNP_VTOM			BIT_ULL(3)
-#define MSR_AMD64_SNP_REFLECT_VC		BIT_ULL(4)
-#define MSR_AMD64_SNP_RESTRICTED_INJ		BIT_ULL(5)
-#define MSR_AMD64_SNP_ALT_INJ			BIT_ULL(6)
-#define MSR_AMD64_SNP_DEBUG_SWAP		BIT_ULL(7)
-#define MSR_AMD64_SNP_PREVENT_HOST_IBS		BIT_ULL(8)
-#define MSR_AMD64_SNP_BTB_ISOLATION		BIT_ULL(9)
-#define MSR_AMD64_SNP_VMPL_SSS			BIT_ULL(10)
-#define MSR_AMD64_SNP_SECURE_TSC		BIT_ULL(11)
-#define MSR_AMD64_SNP_VMGEXIT_PARAM		BIT_ULL(12)
-#define MSR_AMD64_SNP_IBS_VIRT			BIT_ULL(14)
-#define MSR_AMD64_SNP_VMSA_REG_PROTECTION	BIT_ULL(16)
-#define MSR_AMD64_SNP_SMT_PROTECTION		BIT_ULL(17)
-
-/* SNP feature bits reserved for future use. */
-#define MSR_AMD64_SNP_RESERVED_BIT13		BIT_ULL(13)
-#define MSR_AMD64_SNP_RESERVED_BIT15		BIT_ULL(15)
-#define MSR_AMD64_SNP_RESERVED_MASK		GENMASK_ULL(63, 18)
+#define MSR_AMD64_SNP_VTOM_BIT		3
+#define MSR_AMD64_SNP_VTOM		BIT_ULL(MSR_AMD64_SNP_VTOM_BIT)
+#define MSR_AMD64_SNP_REFLECT_VC_BIT	4
+#define MSR_AMD64_SNP_REFLECT_VC	BIT_ULL(MSR_AMD64_SNP_REFLECT_VC_BIT)
+#define MSR_AMD64_SNP_RESTRICTED_INJ_BIT 5
+#define MSR_AMD64_SNP_RESTRICTED_INJ	BIT_ULL(MSR_AMD64_SNP_RESTRICTED_INJ_BIT)
+#define MSR_AMD64_SNP_ALT_INJ_BIT	6
+#define MSR_AMD64_SNP_ALT_INJ		BIT_ULL(MSR_AMD64_SNP_ALT_INJ_BIT)
+#define MSR_AMD64_SNP_DEBUG_SWAP_BIT	7
+#define MSR_AMD64_SNP_DEBUG_SWAP	BIT_ULL(MSR_AMD64_SNP_DEBUG_SWAP_BIT)
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT 8
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS	BIT_ULL(MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT)
+#define MSR_AMD64_SNP_BTB_ISOLATION_BIT	9
+#define MSR_AMD64_SNP_BTB_ISOLATION	BIT_ULL(MSR_AMD64_SNP_BTB_ISOLATION_BIT)
+#define MSR_AMD64_SNP_VMPL_SSS_BIT	10
+#define MSR_AMD64_SNP_VMPL_SSS		BIT_ULL(MSR_AMD64_SNP_VMPL_SSS_BIT)
+#define MSR_AMD64_SNP_SECURE_TSC_BIT	11
+#define MSR_AMD64_SNP_SECURE_TSC	BIT_ULL(MSR_AMD64_SNP_SECURE_TSC_BIT)
+#define MSR_AMD64_SNP_VMGEXIT_PARAM_BIT	12
+#define MSR_AMD64_SNP_VMGEXIT_PARAM	BIT_ULL(MSR_AMD64_SNP_VMGEXIT_PARAM_BIT)
+#define MSR_AMD64_SNP_RESERVED_BIT13	BIT_ULL(13)
+#define MSR_AMD64_SNP_IBS_VIRT_BIT	14
+#define MSR_AMD64_SNP_IBS_VIRT		BIT_ULL(MSR_AMD64_SNP_IBS_VIRT_BIT)
+#define MSR_AMD64_SNP_RESERVED_BIT15	BIT_ULL(15)
+#define MSR_AMD64_SNP_VMSA_REG_PROT_BIT	16
+#define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_BIT)
+#define MSR_AMD64_SNP_SMT_PROT_BIT	17
+#define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		18
+#define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+#define MSR_AMD64_RMP_BASE		0xc0010132
+#define MSR_AMD64_RMP_END		0xc0010133
+
 /* AMD Collaborative Processor Performance Control MSRs */
 #define MSR_AMD_CPPC_CAP1		0xc00102b0
 #define MSR_AMD_CPPC_ENABLE		0xc00102b1
@@ -719,8 +740,15 @@
 #define MSR_K8_TOP_MEM1			0xc001001a
 #define MSR_K8_TOP_MEM2			0xc001001d
 #define MSR_AMD64_SYSCFG		0xc0010010
-#define MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT	23
+#define MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT 23
 #define MSR_AMD64_SYSCFG_MEM_ENCRYPT	BIT_ULL(MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT)
+#define MSR_AMD64_SYSCFG_SNP_EN_BIT	24
+#define MSR_AMD64_SYSCFG_SNP_EN		BIT_ULL(MSR_AMD64_SYSCFG_SNP_EN_BIT)
+#define MSR_AMD64_SYSCFG_SNP_VMPL_EN_BIT 25
+#define MSR_AMD64_SYSCFG_SNP_VMPL_EN	BIT_ULL(MSR_AMD64_SYSCFG_SNP_VMPL_EN_BIT)
+#define MSR_AMD64_SYSCFG_MFDM_BIT	19
+#define MSR_AMD64_SYSCFG_MFDM		BIT_ULL(MSR_AMD64_SYSCFG_MFDM_BIT)
+
 #define MSR_K8_INT_PENDING_MSG		0xc0010055
 /* C1E active bits in int pending message */
 #define K8_INTP_C1E_ACTIVE_MASK		0x18000000
-- 
2.44.0.478.gd926399ef9-goog


