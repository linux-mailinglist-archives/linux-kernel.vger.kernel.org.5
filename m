Return-Path: <linux-kernel+bounces-83814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ABB869ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C3828B3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E014CAB3;
	Tue, 27 Feb 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljmNej1b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE409149DEE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057822; cv=none; b=oCnm7roj7kdfVITPCdf6w/NEWXyItPfEy3OsQELfV7tjODUpGyyHrkgqZkqwLsed5QcjthqtsbySXg/yLUleGvVav04E24LV94U+df08ttIsOlctX1KNUC+aXnhF9wAhlMTCFh//2s4xUpdpz5TEv6dJplsWCB2HDDm7YUtdOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057822; c=relaxed/simple;
	bh=OpIDWzdlg0any9JAzqVnZ+xhu2rjxA6sBoybOHgswyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCdxbgEN/js9YFsW8JTPS/Chb6B4R9/sdHx6VqjC0Nzej6NcN93waGLS+GqeHqsNf14vJQ+EYBPpWQrm5CZL+lnNaAhOMKAU+O8a7EUqYOgeEEUeP9l6jIaYjn+O1fWqApLaAJHZ/GiDJWLhy2sXeQH5vj05BrQD2FrvZXrUBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljmNej1b; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709057820; x=1740593820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OpIDWzdlg0any9JAzqVnZ+xhu2rjxA6sBoybOHgswyk=;
  b=ljmNej1bg0IkKYUr1C+SB3Xcn7JNOceWIVvItsxxow6tBM4FzDSs6A1V
   kaHf8XvtGOCRHo2XB6QxYG7ZqEo+vC/4icEfzSu4o02rZst11MMV5Wm+l
   iHKOTsDsL158NS2HaiLmJwvwXwEcbgdJMSIy2pI5EZqGevWDGKtPQxBll
   EQSqSrCpfZV5+1rp3IH6njQAg3E8IwFdOq1SmsMSP1jM+ExJiLHNzZHj2
   CjWuGm6eQhSbswzgmhepGL8oPEqYSALaVzNGQwavd5O53Rkr6FimwnvR9
   kUj3kKW+7DsxQbjwN/kSWm7+6fCM8kh4WWIVITbxcWIw4DMKg1Ul5jpac
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20966105"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="20966105"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 10:16:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032727"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032727"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 10:16:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C1F679AD; Tue, 27 Feb 2024 20:16:19 +0200 (EET)
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
Subject: [PATCHv8 10/16] x86/tdx: Convert shared memory back to private on kexec
Date: Tue, 27 Feb 2024 20:16:10 +0200
Message-ID: <20240227181616.3032032-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227181616.3032032-1-kirill.shutemov@linux.intel.com>
References: <20240227181616.3032032-1-kirill.shutemov@linux.intel.com>
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


