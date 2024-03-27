Return-Path: <linux-kernel+bounces-121287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7864988E4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E21229EC08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B6131BBC;
	Wed, 27 Mar 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIIq9P/7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8412EBD5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542868; cv=none; b=nDgc+A795jXqnD1ROMdGayvac4JfjDbkbMRUtYP5SSnHIjui63M9AR+RgMEOiHWNf27ftlFJ0iEPZ/XhkygWXMv6mPuhGSbEK34xPtqOmaCOAkcu7xPubbKp4FibsLOvm1iUsuEbZrdt8pjt59G5j4T3bvrmF/bm9uGWWj3PDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542868; c=relaxed/simple;
	bh=p9PwPvQjRA4xnOgpahayDoIxX+OmMMU0a1xglOgOyPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9ZRYVn+D+lGbio++IMt4Det8XTOQ+2QhpjUSCStHgQAr80IrysOg9B1dq6n/cWVc9Wk540s/QMqtVVStzMUzT81DyyXT+/D6CvZPy1gW/Ryt9PjIZEH4OiOSps2JnBGQuHIVtAtUm96zeTv94lUSUn8Eg9Gqj8RL+h15mpbYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIIq9P/7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711542867; x=1743078867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p9PwPvQjRA4xnOgpahayDoIxX+OmMMU0a1xglOgOyPY=;
  b=MIIq9P/7V6lbpRNpAwMSKltMouBhnO03rsny0Pi4J0mx6AL+pOAi+BUB
   o6t8EozzCwKf+RRQGlFxsZ2XROCvPyzkhDpbji45BTqvxdWEKsLDb0+lj
   EEGiww3WPwra8HgugRtOrNEYVoSdsO8Z+cwUDOgHElTK7uXB1U466SVHJ
   3EcqoWribXjQl3uoyM2B1uE2PcMIklIKfeMpLNEddSpKZQHfq5yg4fGEo
   JU0pH7K36Ml3remWNW1Rj5GvP3VcMbf/2jq+kpV2LfT6cgterGGT6z1Ph
   CIpOaaHigcRJiGJ7BnI7XaG27bIoh7kjbUv/Q3a6kS3/BqQzfAe8j0ZxF
   g==;
X-CSE-ConnectionGUID: g4V4LkH1RjGlzBgCk10UbQ==
X-CSE-MsgGUID: yNgUj1DHQ1S21e8Hgwz1Bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10440985"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="10440985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 05:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937074503"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="937074503"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 05:34:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 33926193; Wed, 27 Mar 2024 14:34:20 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: kirill.shutemov@linux.intel.com
Cc: adrian.hunter@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	elena.reshetova@intel.com,
	jun.nakajima@intel.com,
	kai.huang@intel.com,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	seanjc@google.com,
	tglx@linutronix.de,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv9.1 06/17] x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
Date: Wed, 27 Mar 2024 14:34:17 +0200
Message-ID: <20240327123417.1754166-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325103911.2651793-7-kirill.shutemov@linux.intel.com>
References: <20240325103911.2651793-7-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX is going to have more than one reason to fail
enc_status_change_prepare().

Change the callback to return errno instead of assuming -EIO;
enc_status_change_finish() changed too to keep the interface symmetric.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
---
  v9.1:
    - Fix build error in Hyper-V code after rebase;
---
 arch/x86/coco/tdx/tdx.c         | 20 +++++++++++---------
 arch/x86/hyperv/ivm.c           | 22 ++++++++++------------
 arch/x86/include/asm/x86_init.h |  4 ++--
 arch/x86/kernel/x86_init.c      |  4 ++--
 arch/x86/mm/mem_encrypt_amd.c   |  8 ++++----
 arch/x86/mm/pat/set_memory.c    |  8 +++++---
 6 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c1cb90369915..26fa47db5782 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -798,28 +798,30 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
-static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
-					  bool enc)
+static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
+					 bool enc)
 {
 	/*
 	 * Only handle shared->private conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
+	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+		return -EIO;
+
+	return 0;
 }
 
-static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
+static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 					 bool enc)
 {
 	/*
 	 * Only handle private->shared conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (!enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
+	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+		return -EIO;
+
+	return 0;
 }
 
 void __init tdx_early_init(void)
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 768d73de0d09..b4a851d27c7c 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -523,9 +523,9 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
  * transition is complete, hv_vtom_set_host_visibility() marks the pages
  * as "present" again.
  */
-static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
+static int hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
 {
-	return !set_memory_np(kbuffer, pagecount);
+	return set_memory_np(kbuffer, pagecount);
 }
 
 /*
@@ -536,20 +536,19 @@ static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc
  * with host. This function works as wrap of hv_mark_gpa_visibility()
  * with memory base and size.
  */
-static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
+static int hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
 {
 	enum hv_mem_host_visibility visibility = enc ?
 			VMBUS_PAGE_NOT_VISIBLE : VMBUS_PAGE_VISIBLE_READ_WRITE;
 	u64 *pfn_array;
 	phys_addr_t paddr;
+	int i, pfn, err;
 	void *vaddr;
 	int ret = 0;
-	bool result = true;
-	int i, pfn;
 
 	pfn_array = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!pfn_array) {
-		result = false;
+		ret = -ENOMEM;
 		goto err_set_memory_p;
 	}
 
@@ -568,10 +567,8 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
 			ret = hv_mark_gpa_visibility(pfn, pfn_array,
 						     visibility);
-			if (ret) {
-				result = false;
+			if (ret)
 				goto err_free_pfn_array;
-			}
 			pfn = 0;
 		}
 	}
@@ -586,10 +583,11 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	 * order to avoid leaving the memory range in a "broken" state. Setting
 	 * the PRESENT bits shouldn't fail, but return an error if it does.
 	 */
-	if (set_memory_p(kbuffer, pagecount))
-		result = false;
+	err = set_memory_p(kbuffer, pagecount);
+	if (err && !ret)
+		ret = err;
 
-	return result;
+	return ret;
 }
 
 static bool hv_vtom_tlb_flush_required(bool private)
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index b89b40f250e6..4770af4d6015 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -150,8 +150,8 @@ struct x86_init_acpi {
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
  */
 struct x86_guest {
-	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
-	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
+	int (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
+	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
 };
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a42830dc151b..69413ca37bfe 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -132,8 +132,8 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
-static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
-static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
+static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
+static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 70b91de2e053..d314e577836d 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -283,7 +283,7 @@ static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 #endif
 }
 
-static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
+static int amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
 {
 	/*
 	 * To maintain the security guarantees of SEV-SNP guests, make sure
@@ -292,11 +292,11 @@ static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool
 	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
 		snp_set_memory_shared(vaddr, npages);
 
-	return true;
+	return 0;
 }
 
 /* Return true unconditionally: return value doesn't matter for the SEV side */
-static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
+static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
 {
 	/*
 	 * After memory is mapped encrypted in the page table, validate it
@@ -308,7 +308,7 @@ static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool e
 	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
 
-	return true;
+	return 0;
 }
 
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 80c9037ffadf..e5b454036bf3 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2156,7 +2156,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
-	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
+	ret = x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
+	if (ret)
 		goto vmm_fail;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
@@ -2174,7 +2175,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		return ret;
 
 	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+	ret = x86_platform.guest.enc_status_change_finish(addr, numpages, enc);
+	if (ret)
 		goto vmm_fail;
 
 	return 0;
@@ -2183,7 +2185,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s.\n",
 		  (void *)addr, numpages, enc ? "private" : "shared");
 
-	return -EIO;
+	return ret;
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
-- 
2.43.0


