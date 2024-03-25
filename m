Return-Path: <linux-kernel+bounces-116860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2114588A476
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1071C39985
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900181BDBB2;
	Mon, 25 Mar 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZIk7Dq1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E644149C7E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363221; cv=none; b=QFy7rewrj8u3v2zbJWT46efx2ooKLob8aWs/9WI/pywf91gjA6xcz7PBYK1EGK1B3XDT7zWinW3YIN11hjhAHu1ZW3d8yZMHO2eE5g7qg8ke8TW9Xwm5sMCnAQO+A0e6Hpmg1g38MyS0O+Nyif0lH3gjWFCDbuncvNj4kSdzY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363221; c=relaxed/simple;
	bh=ougN67D/kq1SmTfIiMnsRqu94By12DPjybftCFC4vBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX2k62DPCcIQwUt6NcBROYQwoQxtoSoeqZSUTcK63e+7DStF07kRDgjzyF+GHW+6+/PHfPqYpT0DsJfg5XqUElGb+xJfiY5xQBlljc9JwkULUrP2P80+5L8MrUWRxhdon/TCRYaKwz8VuvoNc2OPZB0b6/DhGS8D7tU2Qr4tKkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZIk7Dq1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363219; x=1742899219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ougN67D/kq1SmTfIiMnsRqu94By12DPjybftCFC4vBw=;
  b=YZIk7Dq1h5L6OwotHP4fGXqaAleDwRVcVT2R4CcIDzWFUoY/oTBcNQlm
   ZDul3qmE2k16As8rDKnu132KtXMOmSlGd3HfO7OMuF2eO5kmxT/6ypw3R
   ojekuPVxRis3jD2td6J25RbksGjpx+rhl4Kbzh06iNg+qLWhJAQyaif9J
   1xwuPxPjwmVkrDRsz7eUltWNiLFRzMerNbcdBqjkUnVM85BAaYG0AjEpn
   PKcQd4hEHZHtgTPvzM4v38rYt/QqYwLy6M9ZM3EAyBwcY0ZoS0H32FRZc
   RJYNomp4DJzBO80U30URigm1Zq3w8p596hF7eUjwldT921C4iobQySMOJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6561417"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6561417"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070161"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070161"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:40:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 25543643; Mon, 25 Mar 2024 12:40:05 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCHv9 06/17] x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
Date: Mon, 25 Mar 2024 12:39:00 +0200
Message-ID: <20240325103911.2651793-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
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
---
 arch/x86/coco/tdx/tdx.c         | 20 +++++++++++---------
 arch/x86/hyperv/ivm.c           |  9 +++------
 arch/x86/include/asm/x86_init.h |  4 ++--
 arch/x86/kernel/x86_init.c      |  4 ++--
 arch/x86/mm/mem_encrypt_amd.c   |  8 ++++----
 arch/x86/mm/pat/set_memory.c    |  8 +++++---
 6 files changed, 27 insertions(+), 26 deletions(-)

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
index 768d73de0d09..870b82fce5ce 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -536,7 +536,7 @@ static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc
  * with host. This function works as wrap of hv_mark_gpa_visibility()
  * with memory base and size.
  */
-static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
+static int hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
 {
 	enum hv_mem_host_visibility visibility = enc ?
 			VMBUS_PAGE_NOT_VISIBLE : VMBUS_PAGE_VISIBLE_READ_WRITE;
@@ -544,7 +544,6 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	phys_addr_t paddr;
 	void *vaddr;
 	int ret = 0;
-	bool result = true;
 	int i, pfn;
 
 	pfn_array = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
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
@@ -589,7 +586,7 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	if (set_memory_p(kbuffer, pagecount))
 		result = false;
 
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


