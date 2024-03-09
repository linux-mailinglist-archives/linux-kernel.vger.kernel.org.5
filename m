Return-Path: <linux-kernel+bounces-98043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6018773FE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3EB28239D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821853E12;
	Sat,  9 Mar 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8nwSujk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028651021
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710018171; cv=none; b=ZhCpIECpOTeg5FVb7/sGWndUsIS+WkHsoB8mHifxcuZnQ33zeACuGaV/oiowMER8BMBb3GZBRhZHB4JAgk0z7ruxPd2S2SpDtpoKSY4CmZDFsBfAMekBwYZFlX2hn9aAdkCy1sNUugqE7pPxLtuw/DbxY1cTswpDiy4+lxQfCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710018171; c=relaxed/simple;
	bh=l1JZHNfw4NSUSsC+y2v9OCYY6Ndd0+Cz/FPtWPxp0a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHlGQ6XvxnRkeqh6cvA/uM8UnHoLUiGfauK8Vw3HkRpIby5edKeP+84inQbCT0k3IhZgWeE04mDrMuAsqNKkOc1bDGJ/R1Xs51DWTXkpmHnB01ObdYtTM8VeJmkAH1hbVPlb0FgzsbuQygJ+K5hO9QMax4GTkhRNcF6lKAb20hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8nwSujk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710018170; x=1741554170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1JZHNfw4NSUSsC+y2v9OCYY6Ndd0+Cz/FPtWPxp0a4=;
  b=Q8nwSujkO18uW3ickIbrqqgoycyV614yNkdxSB0H0py42jFedVQIuN4/
   n5lttgOuqCe+qxxCj+XuzqNlFiyDwFsxCJtTYTy/q5rvo0swYthoYmw3x
   AP1YwnSOaoxj+Jg3mcpKOvNzj2PyeMMroSOY3hojFSbg7QNVB/FoDKWz0
   9Ka5BOHaKAjOrFeR5R0V9uh2e5EsIlngVqwJjrWPDPIv/RZ0UKS5Y5M38
   mBFzN5sv23h07xXDCXmMcHmiSIxLlrQiUjCvS3TQuPHgBxQEPOLKR1+fi
   IE5T6Xi+DR1+8TewqLgUwRddFILFNmUkbgeRzOHufRLfftrWtzZMiynO2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4861582"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4861582"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 13:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="937048395"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="937048395"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2024 13:02:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 48B5536D; Sat,  9 Mar 2024 23:02:42 +0200 (EET)
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
Subject: [PATCH 2/4] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
Date: Sat,  9 Mar 2024 23:02:28 +0200
Message-ID: <20240309210230.239045-3-kirill.shutemov@linux.intel.com>
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

Rename tdx_parse_tdinfo() to tdx_setup() and move setting NOTIFY_ENABLES
there.

The function will be extended to adjust TD configuration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 5ffe5ef99536..afdaf46cabb9 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -181,7 +181,7 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args);
 }
 
-static void tdx_parse_tdinfo(u64 *cc_mask)
+static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
 	unsigned int gpa_width;
@@ -206,6 +206,9 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
+	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
+	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
+
 	/*
 	 * The kernel can not handle #VE's when accessing normal kernel
 	 * memory.  Ensure that no #VE will be delivered for accesses to
@@ -930,11 +933,11 @@ void __init tdx_early_init(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 	cc_vendor = CC_VENDOR_INTEL;
-	tdx_parse_tdinfo(&cc_mask);
-	cc_set_mask(cc_mask);
 
-	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
+	/* Configure the TD */
+	tdx_setup(&cc_mask);
+
+	cc_set_mask(cc_mask);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
-- 
2.43.0


