Return-Path: <linux-kernel+bounces-98039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779BD8773FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2547C281BA7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469C350243;
	Sat,  9 Mar 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Igd8khMh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64FD29E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710018168; cv=none; b=GwNaQ1U0AY9GZ6eEevA9NB55yedmtOeUk7tuIo9/RAnvYsPPl146rCoBMoKg6BLkgs8fDkFOHhadyQVd759/G8HvZeMCxUZUrm0lCR2o2/8lRaI6QcorBG5FsjwIxxU0h/jJTtQ4hVFTv+MxiHDafeGDqXvchwX73Gc2F0g7Jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710018168; c=relaxed/simple;
	bh=7PF0+D1IOCR6YLRa244+vy+ff5vcASshR/asOF7cdrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1o+7keuq2QBR8OJL5d1zh5rgKOg0SsaVRX5RunTISYDZ3dtDBfY8H35EMY4WqUbKrBUk/XoRo6wvRsHlSIK1D/oWTMjM7J9bwxQ6yR7UeferOvzVFOfOi3hBOCTRDiFIqso8E0GOKksXcRqAu0jacEgSH6VW9cjRouC2e0lnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Igd8khMh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710018167; x=1741554167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7PF0+D1IOCR6YLRa244+vy+ff5vcASshR/asOF7cdrk=;
  b=Igd8khMhBv4cDaT8IEOY6ODkWLieBt8qRz1FO4dmR2xMQsbZFqA3wvzu
   KMu5zNeypIN/bFVLr/tL/iuAc0sda6oWcV5CI810QP0aEm3ts28eTTkQR
   Drxfm9qi4KSbRswycHoGm8ZjMFcYV4wWLXCZGSg/2j+P0MEQEP7wjyxqm
   Nv+nZSUZicF/XLnCcjraWWeJ0dQ7IZEBzkBkVe840NdRUnwBQMHDsEKQo
   UGKgHpziJHrA6beoWSxdfpZEDse94E0mX8Or7RVcMNUhgORCdiEMAUgxA
   iXT+lZeXDjozxVbYf86nna5SbE5T0zJue1ZTv+nsbgUkAwtwooepoBXIM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4861554"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4861554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 13:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="937048387"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="937048387"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2024 13:02:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3AD1E169; Sat,  9 Mar 2024 23:02:42 +0200 (EET)
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
Subject: [PATCH 1/4] x86/tdx: Introduce tdg_vm_wr()
Date: Sat,  9 Mar 2024 23:02:27 +0200
Message-ID: <20240309210230.239045-2-kirill.shutemov@linux.intel.com>
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

Add a helper to write to a TD-scope metadata field and use it to set
NOTIFY_ENABLES.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cc67f7380055..5ffe5ef99536 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -77,6 +77,20 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
+{
+	struct tdx_module_args args = {
+		.rdx = field,
+		.r8 = value,
+		.r9 = mask,
+	};
+
+	tdcall(TDG_VM_WR, &args);
+
+	/* Old value */
+	return args.r8;
+}
+
 /**
  * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
  *                           subtype 0) using TDG.MR.REPORT TDCALL.
@@ -902,10 +916,6 @@ static void tdx_kexec_unshare_mem(void)
 
 void __init tdx_early_init(void)
 {
-	struct tdx_module_args args = {
-		.rdx = TDCS_NOTIFY_ENABLES,
-		.r9 = -1ULL,
-	};
 	u64 cc_mask;
 	u32 eax, sig[3];
 
@@ -924,7 +934,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdcall(TDG_VM_WR, &args);
+	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
-- 
2.43.0


