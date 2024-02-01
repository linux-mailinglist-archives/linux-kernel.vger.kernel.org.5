Return-Path: <linux-kernel+bounces-47664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DFD8450EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AF5289977
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84AA7D3F2;
	Thu,  1 Feb 2024 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EGk8uS4R"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B873C49B;
	Thu,  1 Feb 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766426; cv=none; b=T0TflEcVrAMsC5GpmZxTnojiKgPw3xwqmdh7zDOXnMylOHKI/fSnGUg1ua1y7bSrEXMjlJQdTdJZb4CD09CUwzHXtrQKhBcWV1BEfWCXCEn3TkDupNy5hRNl8KgL+gtnrbMKu3EIMXrq6nar2YRtGye26CYHRfWu+Auu19Vb0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766426; c=relaxed/simple;
	bh=DPHiEOhjxsM3Rjoc6y/DfyHo8rtHRh3orm7rZ62bXo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiUO2fxkAFtxzVAqR3WkopTcbHOjD0E82LeG4R3y0F8qwUsrU/xiquEQ4Gj+eF1EvxnSG1YairswZta4ygcRyvdJFXJsiIsMOlLwuZdhj5oXigs1oW37yW7NWTbNox1fdJL9BSFwwQzzlO0pmfpTsTWwvAycCMkIHwAUHtoTrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=EGk8uS4R; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4115kU5J3816769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 31 Jan 2024 21:46:37 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4115kU5J3816769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706766397;
	bh=83EE8CoxNBVo+Wdn+2GRozH+rbrgR4nbHmHY9grt9iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGk8uS4RYGnrJLy5loYj4rCv2fVlmvmbsO4gGIGUt2U0FEvCLIgq3YZ/NUkb1juGb
	 obgXxZVsdyhcDtMXOygtB8P2Op/nXifbv11qGOLOaD3UjCHNB+mi2rF9aDWDpkgvJE
	 YGMK1uoLR/vQnaCCAKKVMN1I0WUhRIbPYtpZWZOETMJwZI9Ten9drRFbQePzgYgB7r
	 BnopF3gyz0MxlP8F00QRmcSHlDISi66lMJdzCMxyHZsUnvlhnlpfSiCGDSHpGSb1qO
	 VmBa73A65fUzLCXrYcx6xwpLGXfjyjj9mdI8eDmy0hbG8iBDFcXTlxA0dUN241rcOJ
	 ZWmf33JoB/fYQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
Subject: [PATCH v1 3/3] x86/cpufeatures: Remove {disabled,required}-features.h
Date: Wed, 31 Jan 2024 21:46:29 -0800
Message-ID: <20240201054629.3816748-4-xin@zytor.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201054629.3816748-1-xin@zytor.com>
References: <20240201054629.3816748-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functionalities of {disabled,required}-features.h are replaced
with the auto-generated header cpufeature_masks.h. Thus they are no
longer needed. So delete them.

None of the macros defined in {disabled,required}-features.h is used
in tools directory, delete them.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/disabled-features.h      | 154 ------------------
 arch/x86/include/asm/required-features.h      | 104 ------------
 tools/arch/x86/include/asm/cpufeatures.h      |   8 -
 .../arch/x86/include/asm/disabled-features.h  | 154 ------------------
 .../arch/x86/include/asm/required-features.h  | 104 ------------
 tools/perf/check-headers.sh                   |   2 -
 6 files changed, 526 deletions(-)
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
deleted file mode 100644
index 1f23960d2b06..000000000000
--- a/arch/x86/include/asm/disabled-features.h
+++ /dev/null
@@ -1,154 +0,0 @@
-#ifndef _ASM_X86_DISABLED_FEATURES_H
-#define _ASM_X86_DISABLED_FEATURES_H
-
-/* These features, although they might be available in a CPU
- * will not be used because the compile options to support
- * them are not present.
- *
- * This code allows them to be checked and disabled at
- * compile time without an explicit #ifdef.  Use
- * cpu_feature_enabled().
- */
-
-#ifdef CONFIG_X86_UMIP
-# define DISABLE_UMIP	0
-#else
-# define DISABLE_UMIP	(1<<(X86_FEATURE_UMIP & 31))
-#endif
-
-#ifdef CONFIG_X86_64
-# define DISABLE_VME		(1<<(X86_FEATURE_VME & 31))
-# define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
-# define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
-# define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
-# define DISABLE_PCID		0
-#else
-# define DISABLE_VME		0
-# define DISABLE_K6_MTRR	0
-# define DISABLE_CYRIX_ARR	0
-# define DISABLE_CENTAUR_MCR	0
-# define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
-#endif /* CONFIG_X86_64 */
-
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-# define DISABLE_PKU		0
-# define DISABLE_OSPKE		0
-#else
-# define DISABLE_PKU		(1<<(X86_FEATURE_PKU & 31))
-# define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
-#endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
-
-#ifdef CONFIG_X86_5LEVEL
-# define DISABLE_LA57	0
-#else
-# define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
-# define DISABLE_PTI		0
-#else
-# define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_RETPOLINE
-# define DISABLE_RETPOLINE	0
-#else
-# define DISABLE_RETPOLINE	((1 << (X86_FEATURE_RETPOLINE & 31)) | \
-				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
-#endif
-
-#ifdef CONFIG_MITIGATION_RETHUNK
-# define DISABLE_RETHUNK	0
-#else
-# define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_UNRET_ENTRY
-# define DISABLE_UNRET		0
-#else
-# define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-# define DISABLE_CALL_DEPTH_TRACKING	0
-#else
-# define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
-#endif
-
-#ifdef CONFIG_ADDRESS_MASKING
-# define DISABLE_LAM		0
-#else
-# define DISABLE_LAM		(1 << (X86_FEATURE_LAM & 31))
-#endif
-
-#ifdef CONFIG_INTEL_IOMMU_SVM
-# define DISABLE_ENQCMD		0
-#else
-# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
-#endif
-
-#ifdef CONFIG_X86_SGX
-# define DISABLE_SGX	0
-#else
-# define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
-#endif
-
-#ifdef CONFIG_XEN_PV
-# define DISABLE_XENPV		0
-#else
-# define DISABLE_XENPV		(1 << (X86_FEATURE_XENPV & 31))
-#endif
-
-#ifdef CONFIG_INTEL_TDX_GUEST
-# define DISABLE_TDX_GUEST	0
-#else
-# define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
-#endif
-
-#ifdef CONFIG_X86_USER_SHADOW_STACK
-#define DISABLE_USER_SHSTK	0
-#else
-#define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
-#endif
-
-#ifdef CONFIG_X86_KERNEL_IBT
-#define DISABLE_IBT	0
-#else
-#define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
-#endif
-
-#ifdef CONFIG_X86_FRED
-# define DISABLE_FRED	0
-#else
-# define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
-#endif
-
-/*
- * Make sure to add features to the correct mask
- */
-#define DISABLED_MASK0	(DISABLE_VME)
-#define DISABLED_MASK1	0
-#define DISABLED_MASK2	0
-#define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
-#define DISABLED_MASK4	(DISABLE_PCID)
-#define DISABLED_MASK5	0
-#define DISABLED_MASK6	0
-#define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST)
-#define DISABLED_MASK9	(DISABLE_SGX)
-#define DISABLED_MASK10	0
-#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
-			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
-#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
-#define DISABLED_MASK13	0
-#define DISABLED_MASK14	0
-#define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
-#define DISABLED_MASK17	0
-#define DISABLED_MASK18	(DISABLE_IBT)
-#define DISABLED_MASK19	0
-#define DISABLED_MASK20	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
-
-#endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
deleted file mode 100644
index 13018e507f76..000000000000
--- a/arch/x86/include/asm/required-features.h
+++ /dev/null
@@ -1,104 +0,0 @@
-#ifndef _ASM_X86_REQUIRED_FEATURES_H
-#define _ASM_X86_REQUIRED_FEATURES_H
-
-/* Define minimum CPUID feature set for kernel These bits are checked
-   really early to actually display a visible error message before the
-   kernel dies.  Make sure to assign features to the proper mask!
-
-   Some requirements that are not in CPUID yet are also in the
-   CONFIG_X86_MINIMUM_CPU_FAMILY which is checked too.
-
-   The real information is in arch/x86/Kconfig.cpu, this just converts
-   the CONFIGs into a bitmask */
-
-#ifndef CONFIG_MATH_EMULATION
-# define NEED_FPU	(1<<(X86_FEATURE_FPU & 31))
-#else
-# define NEED_FPU	0
-#endif
-
-#if defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
-# define NEED_PAE	(1<<(X86_FEATURE_PAE & 31))
-#else
-# define NEED_PAE	0
-#endif
-
-#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
-# define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
-#else
-# define NEED_CX8	0
-#endif
-
-#if defined(CONFIG_X86_REQUIRED_FEATURE_CMOV) || defined(CONFIG_X86_64)
-# define NEED_CMOV	(1<<(X86_FEATURE_CMOV & 31))
-#else
-# define NEED_CMOV	0
-#endif
-
-# define NEED_3DNOW	0
-
-#if defined(CONFIG_X86_P6_NOP) || defined(CONFIG_X86_64)
-# define NEED_NOPL	(1<<(X86_FEATURE_NOPL & 31))
-#else
-# define NEED_NOPL	0
-#endif
-
-#ifdef CONFIG_MATOM
-# define NEED_MOVBE	(1<<(X86_FEATURE_MOVBE & 31))
-#else
-# define NEED_MOVBE	0
-#endif
-
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_PARAVIRT_XXL
-/* Paravirtualized systems may not have PSE or PGE available */
-#define NEED_PSE	0
-#define NEED_PGE	0
-#else
-#define NEED_PSE	(1<<(X86_FEATURE_PSE) & 31)
-#define NEED_PGE	(1<<(X86_FEATURE_PGE) & 31)
-#endif
-#define NEED_MSR	(1<<(X86_FEATURE_MSR & 31))
-#define NEED_FXSR	(1<<(X86_FEATURE_FXSR & 31))
-#define NEED_XMM	(1<<(X86_FEATURE_XMM & 31))
-#define NEED_XMM2	(1<<(X86_FEATURE_XMM2 & 31))
-#define NEED_LM		(1<<(X86_FEATURE_LM & 31))
-#else
-#define NEED_PSE	0
-#define NEED_MSR	0
-#define NEED_PGE	0
-#define NEED_FXSR	0
-#define NEED_XMM	0
-#define NEED_XMM2	0
-#define NEED_LM		0
-#endif
-
-#define REQUIRED_MASK0	(NEED_FPU|NEED_PSE|NEED_MSR|NEED_PAE|\
-			 NEED_CX8|NEED_PGE|NEED_FXSR|NEED_CMOV|\
-			 NEED_XMM|NEED_XMM2)
-#define SSE_MASK	(NEED_XMM|NEED_XMM2)
-
-#define REQUIRED_MASK1	(NEED_LM|NEED_3DNOW)
-
-#define REQUIRED_MASK2	0
-#define REQUIRED_MASK3	(NEED_NOPL)
-#define REQUIRED_MASK4	(NEED_MOVBE)
-#define REQUIRED_MASK5	0
-#define REQUIRED_MASK6	0
-#define REQUIRED_MASK7	0
-#define REQUIRED_MASK8	0
-#define REQUIRED_MASK9	0
-#define REQUIRED_MASK10	0
-#define REQUIRED_MASK11	0
-#define REQUIRED_MASK12	0
-#define REQUIRED_MASK13	0
-#define REQUIRED_MASK14	0
-#define REQUIRED_MASK15	0
-#define REQUIRED_MASK16	0
-#define REQUIRED_MASK17	0
-#define REQUIRED_MASK18	0
-#define REQUIRED_MASK19	0
-#define REQUIRED_MASK20	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
-
-#endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 953e6efead26..fcf3ea6ffaf0 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -2,14 +2,6 @@
 #ifndef _ASM_X86_CPUFEATURES_H
 #define _ASM_X86_CPUFEATURES_H
 
-#ifndef _ASM_X86_REQUIRED_FEATURES_H
-#include <asm/required-features.h>
-#endif
-
-#ifndef _ASM_X86_DISABLED_FEATURES_H
-#include <asm/disabled-features.h>
-#endif
-
 /*
  * Defines x86 CPU feature bits
  */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
deleted file mode 100644
index 1f23960d2b06..000000000000
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ /dev/null
@@ -1,154 +0,0 @@
-#ifndef _ASM_X86_DISABLED_FEATURES_H
-#define _ASM_X86_DISABLED_FEATURES_H
-
-/* These features, although they might be available in a CPU
- * will not be used because the compile options to support
- * them are not present.
- *
- * This code allows them to be checked and disabled at
- * compile time without an explicit #ifdef.  Use
- * cpu_feature_enabled().
- */
-
-#ifdef CONFIG_X86_UMIP
-# define DISABLE_UMIP	0
-#else
-# define DISABLE_UMIP	(1<<(X86_FEATURE_UMIP & 31))
-#endif
-
-#ifdef CONFIG_X86_64
-# define DISABLE_VME		(1<<(X86_FEATURE_VME & 31))
-# define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
-# define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
-# define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
-# define DISABLE_PCID		0
-#else
-# define DISABLE_VME		0
-# define DISABLE_K6_MTRR	0
-# define DISABLE_CYRIX_ARR	0
-# define DISABLE_CENTAUR_MCR	0
-# define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
-#endif /* CONFIG_X86_64 */
-
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-# define DISABLE_PKU		0
-# define DISABLE_OSPKE		0
-#else
-# define DISABLE_PKU		(1<<(X86_FEATURE_PKU & 31))
-# define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
-#endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
-
-#ifdef CONFIG_X86_5LEVEL
-# define DISABLE_LA57	0
-#else
-# define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
-# define DISABLE_PTI		0
-#else
-# define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_RETPOLINE
-# define DISABLE_RETPOLINE	0
-#else
-# define DISABLE_RETPOLINE	((1 << (X86_FEATURE_RETPOLINE & 31)) | \
-				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
-#endif
-
-#ifdef CONFIG_MITIGATION_RETHUNK
-# define DISABLE_RETHUNK	0
-#else
-# define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_UNRET_ENTRY
-# define DISABLE_UNRET		0
-#else
-# define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-# define DISABLE_CALL_DEPTH_TRACKING	0
-#else
-# define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
-#endif
-
-#ifdef CONFIG_ADDRESS_MASKING
-# define DISABLE_LAM		0
-#else
-# define DISABLE_LAM		(1 << (X86_FEATURE_LAM & 31))
-#endif
-
-#ifdef CONFIG_INTEL_IOMMU_SVM
-# define DISABLE_ENQCMD		0
-#else
-# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
-#endif
-
-#ifdef CONFIG_X86_SGX
-# define DISABLE_SGX	0
-#else
-# define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
-#endif
-
-#ifdef CONFIG_XEN_PV
-# define DISABLE_XENPV		0
-#else
-# define DISABLE_XENPV		(1 << (X86_FEATURE_XENPV & 31))
-#endif
-
-#ifdef CONFIG_INTEL_TDX_GUEST
-# define DISABLE_TDX_GUEST	0
-#else
-# define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
-#endif
-
-#ifdef CONFIG_X86_USER_SHADOW_STACK
-#define DISABLE_USER_SHSTK	0
-#else
-#define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
-#endif
-
-#ifdef CONFIG_X86_KERNEL_IBT
-#define DISABLE_IBT	0
-#else
-#define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
-#endif
-
-#ifdef CONFIG_X86_FRED
-# define DISABLE_FRED	0
-#else
-# define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
-#endif
-
-/*
- * Make sure to add features to the correct mask
- */
-#define DISABLED_MASK0	(DISABLE_VME)
-#define DISABLED_MASK1	0
-#define DISABLED_MASK2	0
-#define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
-#define DISABLED_MASK4	(DISABLE_PCID)
-#define DISABLED_MASK5	0
-#define DISABLED_MASK6	0
-#define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST)
-#define DISABLED_MASK9	(DISABLE_SGX)
-#define DISABLED_MASK10	0
-#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
-			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
-#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
-#define DISABLED_MASK13	0
-#define DISABLED_MASK14	0
-#define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
-#define DISABLED_MASK17	0
-#define DISABLED_MASK18	(DISABLE_IBT)
-#define DISABLED_MASK19	0
-#define DISABLED_MASK20	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
-
-#endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
deleted file mode 100644
index 13018e507f76..000000000000
--- a/tools/arch/x86/include/asm/required-features.h
+++ /dev/null
@@ -1,104 +0,0 @@
-#ifndef _ASM_X86_REQUIRED_FEATURES_H
-#define _ASM_X86_REQUIRED_FEATURES_H
-
-/* Define minimum CPUID feature set for kernel These bits are checked
-   really early to actually display a visible error message before the
-   kernel dies.  Make sure to assign features to the proper mask!
-
-   Some requirements that are not in CPUID yet are also in the
-   CONFIG_X86_MINIMUM_CPU_FAMILY which is checked too.
-
-   The real information is in arch/x86/Kconfig.cpu, this just converts
-   the CONFIGs into a bitmask */
-
-#ifndef CONFIG_MATH_EMULATION
-# define NEED_FPU	(1<<(X86_FEATURE_FPU & 31))
-#else
-# define NEED_FPU	0
-#endif
-
-#if defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
-# define NEED_PAE	(1<<(X86_FEATURE_PAE & 31))
-#else
-# define NEED_PAE	0
-#endif
-
-#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
-# define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
-#else
-# define NEED_CX8	0
-#endif
-
-#if defined(CONFIG_X86_REQUIRED_FEATURE_CMOV) || defined(CONFIG_X86_64)
-# define NEED_CMOV	(1<<(X86_FEATURE_CMOV & 31))
-#else
-# define NEED_CMOV	0
-#endif
-
-# define NEED_3DNOW	0
-
-#if defined(CONFIG_X86_P6_NOP) || defined(CONFIG_X86_64)
-# define NEED_NOPL	(1<<(X86_FEATURE_NOPL & 31))
-#else
-# define NEED_NOPL	0
-#endif
-
-#ifdef CONFIG_MATOM
-# define NEED_MOVBE	(1<<(X86_FEATURE_MOVBE & 31))
-#else
-# define NEED_MOVBE	0
-#endif
-
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_PARAVIRT_XXL
-/* Paravirtualized systems may not have PSE or PGE available */
-#define NEED_PSE	0
-#define NEED_PGE	0
-#else
-#define NEED_PSE	(1<<(X86_FEATURE_PSE) & 31)
-#define NEED_PGE	(1<<(X86_FEATURE_PGE) & 31)
-#endif
-#define NEED_MSR	(1<<(X86_FEATURE_MSR & 31))
-#define NEED_FXSR	(1<<(X86_FEATURE_FXSR & 31))
-#define NEED_XMM	(1<<(X86_FEATURE_XMM & 31))
-#define NEED_XMM2	(1<<(X86_FEATURE_XMM2 & 31))
-#define NEED_LM		(1<<(X86_FEATURE_LM & 31))
-#else
-#define NEED_PSE	0
-#define NEED_MSR	0
-#define NEED_PGE	0
-#define NEED_FXSR	0
-#define NEED_XMM	0
-#define NEED_XMM2	0
-#define NEED_LM		0
-#endif
-
-#define REQUIRED_MASK0	(NEED_FPU|NEED_PSE|NEED_MSR|NEED_PAE|\
-			 NEED_CX8|NEED_PGE|NEED_FXSR|NEED_CMOV|\
-			 NEED_XMM|NEED_XMM2)
-#define SSE_MASK	(NEED_XMM|NEED_XMM2)
-
-#define REQUIRED_MASK1	(NEED_LM|NEED_3DNOW)
-
-#define REQUIRED_MASK2	0
-#define REQUIRED_MASK3	(NEED_NOPL)
-#define REQUIRED_MASK4	(NEED_MOVBE)
-#define REQUIRED_MASK5	0
-#define REQUIRED_MASK6	0
-#define REQUIRED_MASK7	0
-#define REQUIRED_MASK8	0
-#define REQUIRED_MASK9	0
-#define REQUIRED_MASK10	0
-#define REQUIRED_MASK11	0
-#define REQUIRED_MASK12	0
-#define REQUIRED_MASK13	0
-#define REQUIRED_MASK14	0
-#define REQUIRED_MASK15	0
-#define REQUIRED_MASK16	0
-#define REQUIRED_MASK17	0
-#define REQUIRED_MASK18	0
-#define REQUIRED_MASK19	0
-#define REQUIRED_MASK20	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
-
-#endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 66ba33dbcef2..b85ab7c3f3c5 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -33,8 +33,6 @@ FILES=(
   "include/linux/hash.h"
   "include/linux/list-sort.h"
   "include/uapi/linux/hw_breakpoint.h"
-  "arch/x86/include/asm/disabled-features.h"
-  "arch/x86/include/asm/required-features.h"
   "arch/x86/include/asm/cpufeatures.h"
   "arch/x86/include/asm/inat_types.h"
   "arch/x86/include/asm/emulate_prefix.h"
-- 
2.43.0


