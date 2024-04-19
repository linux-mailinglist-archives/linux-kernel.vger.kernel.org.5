Return-Path: <linux-kernel+bounces-151931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA28AB5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83BA1F21AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679F13CAB5;
	Fri, 19 Apr 2024 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzkPXfmf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC710A03
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713557645; cv=none; b=eqJm95NLfRe+bIFcCzjTZcOplGei5bloUdsfK8ry8ozX6zpGCAEiFIJLtFw+Dzug5q15/D/D/1ZTmBa2zaCGfgtuRw+nlQXX3mhU7HAnOJIzQvMhEqURy1lmzrl99v/icOyn+gRam/f/LK0sLr2NQftMDFN3NMKV15s6rX4zfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713557645; c=relaxed/simple;
	bh=QVe30pNQfjn4Hsx1tvDUc19vE02t0tecn5ysBPJ3hPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pcLKcFDwc71k7hNHFk3UiKz195j2/ZRoDhkBGvadhiLcs9nKnMklmcVz/Pnotk3C+gjUaAZ0d5IaRkFElwB0EvChGRQ4gtk9geY/rXUPcTnVGGjT6h5ZtwLPqSrZ18HVudmr9g1O862FCrlxpNtpghUB8UthzRyRzeSiJIhxPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzkPXfmf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713557644; x=1745093644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QVe30pNQfjn4Hsx1tvDUc19vE02t0tecn5ysBPJ3hPI=;
  b=JzkPXfmfZJVMZ/QE0cqPPUmcV8VpfBgEsZ9/9l9h4XflCLWa02pcFTSS
   chclv4KSjOOFljVPm8wHlFm2Cvcg9GE21RCP/m8m35X2KPMzgChDTuwo9
   +n6div+tIAnGDv23fkoXQO3z6mu98y7tSq2lHHP6MaBlUsmczbTb9uyti
   gmmozbVVMn31HdultVgtnFvpk8ZYsGrTw5wiMRW1hIEOkoPT+pgoriQVa
   3lR7P+lbZxCCfI4PgPjLRn/Zi43b4zaNWfbp4FYk6176wsDotZUNa9Fb8
   gzFhEwmoMa3nWIbZMyjbUH7EBbQ15J6gUgHo+aLa/F4QbwVK3paIXx7Sm
   A==;
X-CSE-ConnectionGUID: H93uszjvRaGOvnYdCTTyiA==
X-CSE-MsgGUID: s9ZIGHBgSMymXdDKCIEQXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9298423"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="9298423"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:14:03 -0700
X-CSE-ConnectionGUID: RUnQRXSfRLifO78AMABfTw==
X-CSE-MsgGUID: k2gRDKGmQaOSNPw+2wHdRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="54363905"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 19 Apr 2024 13:13:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9B8AD18F; Fri, 19 Apr 2024 23:13:58 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hpa@zytor.com,
	seanjc@google.com,
	elena.reshetova@intel.com,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Chris Oo <cho@microsoft.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCHv2] x86/tdx: Preserve shared bit on mprotect()
Date: Fri, 19 Apr 2024 23:13:53 +0300
Message-ID: <20240419201353.3937135-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX guest platform takes one bit from the physical address to
indicate if the page is shared (accessible by VMM). This bit is not part
of the physical_mask and is not preserved during mprotect(). As a
result, the 'shared' bit is lost during mprotect() on shared mappings.

_COMMON_PAGE_CHG_MASK specifies which PTE bits need to be preserved
during modification. AMD includes 'sme_me_mask' in the define to
preserve the 'encrypt' bit.

To cover both Intel and AMD cases, include 'cc_mask' in
_COMMON_PAGE_CHG_MASK instead of 'sme_me_mask'.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 41394e33f3a0 ("x86/tdx: Extend the confidential computing API to support TDX guests")
Reported-and-tested-by: Chris Oo <cho@microsoft.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dexuan Cui <decui@microsoft.com>
---

 v2:
   - Fix build for !CONFIG_ARCH_HAS_CC_PLATFORM

---
 arch/x86/include/asm/coco.h          | 1 +
 arch/x86/include/asm/pgtable_types.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index c086699b0d0c..ac8cd4447d48 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -25,6 +25,7 @@ u64 cc_mkdec(u64 val);
 void cc_random_init(void);
 #else
 #define cc_vendor (CC_VENDOR_NONE)
+#define cc_mask 0
 
 static inline u64 cc_mkenc(u64 val)
 {
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 8857d811fb5d..2f321137736c 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -148,7 +148,7 @@
 #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	\
 				 _PAGE_SPECIAL | _PAGE_ACCESSED |	\
 				 _PAGE_DIRTY_BITS | _PAGE_SOFT_DIRTY |	\
-				 _PAGE_DEVMAP | _PAGE_ENC | _PAGE_UFFD_WP)
+				 _PAGE_DEVMAP | _PAGE_CC | _PAGE_UFFD_WP)
 #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
 #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
 
@@ -173,6 +173,7 @@ enum page_cache_mode {
 };
 #endif
 
+#define _PAGE_CC		(_AT(pteval_t, cc_mask))
 #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)
-- 
2.43.0


