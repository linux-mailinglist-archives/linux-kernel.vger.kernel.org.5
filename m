Return-Path: <linux-kernel+bounces-37024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7844C83AA60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D54B1C22A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DFD7764E;
	Wed, 24 Jan 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LO7ctXRm"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B747763C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101008; cv=none; b=bvmX45HDpfSRQ5buYhOQuR9enLT2sbBTC84fJH8d5LDrEQljGIdd2qmIR7f5oovOTPf+mWmbujFj3xre3R+bFTd/bAG6VzTWPiOs9ixI/hMU2Rye/BoNG+0SOd3EVvGnix7L2+ENtpgqG52T8o+d+9Bn1nyKZl2E3Nwfcw/9oc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101008; c=relaxed/simple;
	bh=OpIDWzdlg0any9JAzqVnZ+xhu2rjxA6sBoybOHgswyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmeZ2DMEdHvKnfYvSkUcCOIzeZs10ANFjHRRnLHVJyUyuM1ip9fKJn3rtNDIOUMy3mYdcHDiH36SXZiSkx3GlGce1A+JmG98tTo6xdGA3Rz9v7oZV54QWYwv/K3IRkMEbeexDuWtVGzk0rg5PEG2WdAx2Z6Wb0PhPLJ8fVDAHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LO7ctXRm; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706101007; x=1737637007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OpIDWzdlg0any9JAzqVnZ+xhu2rjxA6sBoybOHgswyk=;
  b=LO7ctXRmjAf/wW1P6dQkl5WRM4Qsl8CesuSHvSuk4Wh855CxiET7teZS
   3okUdpz5CKOQvuOp0feVYkDEZaz12igHn5dUmO56y5LK6DzN2O3fdaEXB
   +7riklKq+1ZHYD7wdPG0fbaN6MgGGcmUZ9HKNEE81MwdMVWkG0Ohbi2t3
   PCjE0RszXBaTyzRNlPMOC0MnyeCP0Xuyi5OANinbEzNJw736M9hRIJsOU
   hjKsjUpzNOZb30aazyEtahpnB1BQiolzfivF3SEOvKEQ3GLmDLo2wt5A8
   3Ci1gSrxmcY1Rfnw8QwC1+MbDjCd/MkdKEq7C8zI892OngzduV4WwcDus
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="466110023"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466110023"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 04:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735924052"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735924052"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2024 04:56:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 954A689B; Wed, 24 Jan 2024 14:56:02 +0200 (EET)
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 10/16] x86/tdx: Convert shared memory back to private on kexec
Date: Wed, 24 Jan 2024 14:55:51 +0200
Message-ID: <20240124125557.493675-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The second kernel has no idea what memory is converted this way. It only
sees E820_TYPE_RAM.

Accessing shared memory via private mapping is fatal. It leads to
unrecoverable TD exit.

On kexec walk direct mapping and convert all shared memory back to
private. It makes all RAM private again and second kernel may use it
normally.

The conversion occurs in two steps: stopping new conversions and
unsharing all memory. In the case of normal kexec, the stopping of
conversions takes place while scheduling is still functioning. This
allows for waiting until any ongoing conversions are finished. The
second step is carried out when all CPUs except one are inactive and
interrupts are disabled. This prevents any conflicts with code that may
access shared memory.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/coco/tdx/tdx.c | 124 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index fd212c9bad89..bb77a927a831 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -6,8 +6,10 @@
 
 #include <linux/cpufeature.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/kexec.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -15,6 +17,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/set_memory.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -41,6 +44,9 @@
 
 static atomic_long_t nr_shared;
 
+static atomic_t conversions_in_progress;
+static bool conversion_allowed = true;
+
 static inline bool pte_decrypted(pte_t pte)
 {
 	return cc_mkdec(pte_val(pte)) == pte_val(pte);
@@ -726,6 +732,14 @@ static bool tdx_tlb_flush_required(bool private)
 
 static bool tdx_cache_flush_required(void)
 {
+	/*
+	 * Avoid issuing CLFLUSH on set_memory_decrypted() if conversions
+	 * stopped. Otherwise it can race with unshare_all_memory() and trigger
+	 * implicit conversion to shared.
+	 */
+	if (!conversion_allowed)
+		return false;
+
 	/*
 	 * AMD SME/SEV can avoid cache flushing if HW enforces cache coherence.
 	 * TDX doesn't have such capability.
@@ -809,12 +823,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
 					 bool enc)
 {
+	atomic_inc(&conversions_in_progress);
+
+	/*
+	 * Check after bumping conversions_in_progress to serialize
+	 * against tdx_kexec_stop_conversion().
+	 */
+	if (!conversion_allowed) {
+		atomic_dec(&conversions_in_progress);
+		return -EBUSY;
+	}
+
 	/*
 	 * Only handle shared->private conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
+		atomic_dec(&conversions_in_progress);
 		return -EIO;
+	}
 
 	return 0;
 }
@@ -826,17 +853,107 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	 * Only handle private->shared conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
+		atomic_dec(&conversions_in_progress);
 		return -EIO;
+	}
 
 	if (enc)
 		atomic_long_sub(numpages, &nr_shared);
 	else
 		atomic_long_add(numpages, &nr_shared);
 
+	atomic_dec(&conversions_in_progress);
+
 	return 0;
 }
 
+static void tdx_kexec_stop_conversion(bool crash)
+{
+	/* Stop new private<->shared conversions */
+	conversion_allowed = false;
+
+	/*
+	 * Make sure conversion_allowed is cleared before checking
+	 * conversions_in_progress.
+	 */
+	barrier();
+
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!crash) {
+		unsigned long timeout;
+
+		/*
+		 * Wait for in-flight conversions to complete.
+		 *
+		 * Do not wait more than 30 seconds.
+		 */
+		timeout = 30 * USEC_PER_SEC;
+		while (atomic_read(&conversions_in_progress) && timeout--)
+			udelay(1);
+	}
+
+	if (atomic_read(&conversions_in_progress))
+		pr_warn("Failed to finish shared<->private conversions\n");
+}
+
+static void tdx_kexec_unshare_mem(void)
+{
+	unsigned long addr, end;
+	long found = 0, shared;
+
+	/*
+	 * Walk direct mapping and convert all shared memory back to private,
+	 */
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		if (pte && pte_decrypted(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			/*
+			 * Touching memory with shared bit set triggers implicit
+			 * conversion to shared.
+			 *
+			 * Make sure nobody touches the shared range from
+			 * now on.
+			 */
+			set_pte(pte, __pte(0));
+
+			if (!tdx_enc_status_changed(addr, pages, true)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+			found += pages;
+		}
+
+		addr += size;
+	}
+
+	__flush_tlb_all();
+
+	shared = atomic_long_read(&nr_shared);
+	if (shared != found) {
+		pr_err("shared page accounting is off\n");
+		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
+	}
+}
+
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -896,6 +1013,9 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
+	x86_platform.guest.enc_kexec_stop_conversion = tdx_kexec_stop_conversion;
+	x86_platform.guest.enc_kexec_unshare_mem     = tdx_kexec_unshare_mem;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
-- 
2.43.0


