Return-Path: <linux-kernel+bounces-98042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652768773FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845761C21033
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99F53E0A;
	Sat,  9 Mar 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atKwgKfz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841250A93
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710018171; cv=none; b=riBcCCodN6eU4ZTgmDeNwBMqGMJrmDC3TlofCuzupmWje/CW43L4yVc2tG8lkBcF/meWEhpnPF+dPBPfnhWWDJl8TiuMwj+jaeJGrLy1BIbzjlTtpoktWaUfEDe6UiHJ7EWseQo6TGw1kWwaGE8c1Xv/sSE8CpitTC/bWTSGD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710018171; c=relaxed/simple;
	bh=3UzLr7/RRaafFrtH5Z2p+MKstcMcwEJZRIwJsFMEBdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgxTlMf4dda4wIHU/5MtdeYEtd237WwH7EzUKC9Hekpv4PAjYnnA6KKZcKOxrzaUro0lGWv+396VeL9tjTcMMPSqwlbXU/hCH6WPfgfpqHnLGWfqd/TZ+L9dgpBR1Cfg4D+o5bbgq0EoRaikwsG0Ar5/RI1SuBq5bbt7iT3L3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atKwgKfz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710018170; x=1741554170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3UzLr7/RRaafFrtH5Z2p+MKstcMcwEJZRIwJsFMEBdg=;
  b=atKwgKfzB/DGy3HBRN3aiGZvUSq9nxqDVPsIP/XgfPHbvm1S3Ct2yXzL
   j7sW0rjjS/tCaAPRln9VInOFTofplPg0iWcxBpEvgsveBuYWW4OKcv1IB
   Dw8eLbAAq1+ey+om3eYl12rua3zfvG6D6NGgrkuh9aSzv8eYiBDyVUUmp
   Amn8PBmCOcefTErR4K/hCvfzVpy4t0NHUrpCCYp9QkZTZmelvHcVCGIYi
   3iis03+heq/viv0tD+0Ay6ygphuOJeiQRE3A+98wsDkOkfqstRR7dnicK
   PmlcBidPUnvoNltTvtdyrieitzxWfw65DVhSALrCCe/XGNNgxa+qilknV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4861575"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4861575"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 13:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="937048393"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="937048393"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2024 13:02:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 56733377; Sat,  9 Mar 2024 23:02:42 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hpa@zytor.com,
	seanjc@google.com,
	ele.reshetova@intel.com,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 3/4] x86/tdx: Handle PENDING_EPT_VIOLATION_V2
Date: Sat,  9 Mar 2024 23:02:29 +0200
Message-ID: <20240309210230.239045-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309210230.239045-1-kirill.shutemov@linux.intel.com>
References: <20240309210230.239045-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PENDING_EPT_VIOLATION_V2 allows TD to control whether access to
a pending page triggers #VE.

Kernel doesn't want to see any #VEs on accesses to private memory:
disable such #VEs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 66 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/shared/tdx.h | 18 ++++++++-
 2 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index afdaf46cabb9..d9ea82f8772d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -77,6 +77,17 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+static inline u64 tdg_vm_rd(u64 field)
+{
+	struct tdx_module_args args = {
+		.rdx = field,
+	};
+
+	tdcall(TDG_VM_RD, &args);
+
+	return args.r8;
+}
+
 static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
 {
 	struct tdx_module_args args = {
@@ -91,6 +102,17 @@ static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
 	return args.r8;
 }
 
+static inline u64 tdg_sys_rd(u64 field)
+{
+	struct tdx_module_args args = {
+		.rdx = field,
+	};
+
+	tdcall(TDG_SYS_RD, &args);
+
+	return args.r8;
+}
+
 /**
  * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
  *                           subtype 0) using TDG.MR.REPORT TDCALL.
@@ -185,7 +207,8 @@ static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
 	unsigned int gpa_width;
-	u64 td_attr;
+	u64 td_attr, features;
+	bool sept_ve_disabled;
 
 	/*
 	 * TDINFO TDX module call is used to get the TD execution environment
@@ -206,19 +229,52 @@ static void tdx_setup(u64 *cc_mask)
 	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
+	td_attr = args.rdx;
+
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
 	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
+	features = tdg_sys_rd(TDCS_TDX_FEATURES0);
+
 	/*
 	 * The kernel can not handle #VE's when accessing normal kernel
 	 * memory.  Ensure that no #VE will be delivered for accesses to
 	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
+	 *
+	 * Check if the TD is created with SEPT #VE disabled.
 	 */
-	td_attr = args.rdx;
-	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
-		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
+	sept_ve_disabled = td_attr & ATTR_SEPT_VE_DISABLE;
 
-		/* Relax SEPT_VE_DISABLE check for debug TD. */
+	/*
+	 * Check if flexible control of SEPT #VE is supported.
+	 *
+	 * The check consists of verifying if the feature is supported by the
+	 * TDX module (the TDX_FEATURES0 check) and if the feature is enabled
+	 * for this TD (CONFIG_FLAGS check).
+	 *
+	 * If flexible control is supported, disable SEPT #VE.
+	 *
+	 * Disable SEPT #VE regardless of ATTR_SEPT_VE_DISABLE status as
+	 * flexible control allows software running before the kernel to
+	 * enable it.
+	 *
+	 * Skip SEPT disabling for debug TD. SEPT #VE is unsafe but can be
+	 * useful for debugging to produce a stack trace. Known to be useful
+	 * for debugging unaccepted memory problems.
+	 */
+	if (features & TDX_FEATURES0_PENDING_EPT_VIOLATION_V2 &&
+	    (tdg_vm_rd(TDCS_CONFIG_FLAGS) & TDCS_CONFIG_FLEXIBLE_PENDING_VE) &&
+	    !(td_attr & ATTR_DEBUG)) {
+		tdg_vm_wr(TDCS_TD_CTLS,
+			  TD_CTLS_PENDING_VE_DISABLE,
+			  TD_CTLS_PENDING_VE_DISABLE);
+		sept_ve_disabled = true;
+	}
+
+	if (!sept_ve_disabled) {
+		const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
+
+		/* Relax SEPT #VE disable check for debug TD. */
 		if (td_attr & ATTR_DEBUG)
 			pr_warn("%s\n", msg);
 		else
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fdfd41511b02..29a61c72e4dd 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -16,11 +16,27 @@
 #define TDG_VP_VEINFO_GET		3
 #define TDG_MR_REPORT			4
 #define TDG_MEM_PAGE_ACCEPT		6
+#define TDG_VM_RD			7
 #define TDG_VM_WR			8
+#define TDG_SYS_RD			11
 
-/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
+/* TDX Global Metadata. To be used by TDG.SYS.RD */
+#define TDCS_TDX_FEATURES0		0x0A00000300000008
+
+/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
+#define TDCS_CONFIG_FLAGS		0x1110000300000016
+#define TDCS_TD_CTLS			0x1110000300000017
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
 
+/* TDCS_TDX_FEATURES0 bits */
+#define TDX_FEATURES0_PENDING_EPT_VIOLATION_V2	BIT_ULL(16)
+
+/* TDCS_CONFIG_FLAGS bits */
+#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
+
+/* TDCS_TD_CTLS bits */
+#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
+
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_GET_QUOTE		0x10002
-- 
2.43.0


