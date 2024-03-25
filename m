Return-Path: <linux-kernel+bounces-116880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D5088A53E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B409DBC74F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612871C41D1;
	Mon, 25 Mar 2024 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHoWuReV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416014D299
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363586; cv=none; b=hHtlHmzhVkCXdKgoXIrEzSObHLlF+NF5EUM/wyZisZyQ2mF3g2fB8Om+TKft1/WNPmt7mEyVtT3M3Q+s0li+WJxnPZTEChk2PREkuPNT46L/Gl3zZD5KmvUkMQLw+0IvxVQhD176fYO0uwnP776vF22/pIfOejSg0/eWya8zbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363586; c=relaxed/simple;
	bh=cWV7a/56NGBWfLPCfzjcByxIHOjU8h5IHcNll3QuTV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMRK1HQvAOJk/goDXDcS/xoBcjfcWLvsao8ASmmv9bisIHpluj2B5ugnSMGbId9UGUsBGbd6vQnbN/am5P+fw7WQQ11praT6CZerRA/KyA3uK7VbQ0zoKM2y7Eexj453c7Ywe5aLfQEfjeuUQJ9ymjhTEFqMvQ2z5DH/qyuPc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHoWuReV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363586; x=1742899586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cWV7a/56NGBWfLPCfzjcByxIHOjU8h5IHcNll3QuTV4=;
  b=JHoWuReVNGXkxWtY2tEwjC+K5C+UAZpiHrPrSxSH1QVx9OiA9cTTE8UQ
   BLBf15AL8ziuWN7ZUXhchK/pv+WKT2T4q8fx7nK9ERG+ijeWzm1UCfDtK
   cmfYGsZhvjAER/icSYEX1PcerWONfQJUKXEfXOijNDXi7/PHp7+QyAkXM
   MLwtiSLydpRIjqL2v0w0MdQ2aVyF7DrRxOf4Xx7eF1jxPU/S3dqMAT3K7
   fwSbrb81eqrJwy5qKvzumRTxvvaHWPI//xbdSp5oA0ZzJ4xpG9AtBydIu
   INT+xxQTBqIiCZBAEyErur+/GGg8uQbF0AwKR98GhLIXQhx1n6dP33gnz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6562000"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6562000"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070189"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070189"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:46:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D049DE7; Mon, 25 Mar 2024 12:46:10 +0200 (EET)
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 1/4] x86/tdx: Introduce tdg_vm_wr()
Date: Mon, 25 Mar 2024 12:46:04 +0200
Message-ID: <20240325104607.2653307-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to write to a TD-scope metadata field and use it
to set NOTIFY_ENABLES.

The helper function will be paired with tdg_vm_rd() and will be used to
manipulate other metadata fields, not just NOTIFY_ENABLES.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 59776ce1c1d7..4fb36e5c4e80 100644
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


