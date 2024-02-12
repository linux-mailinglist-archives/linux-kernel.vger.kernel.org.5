Return-Path: <linux-kernel+bounces-61361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33343851167
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998831F25ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA23C49B;
	Mon, 12 Feb 2024 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnDdjM5c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE53B194
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734712; cv=none; b=q/1k8cDagAf8MVH23x2maNAc6Q5fKPqkYQgm6AUOAGc2AFm3RmmebNAw8qi0clP00sCnA8mc5LujnXN2l/8ZXdhpQn2d/9jcA+8coLFgoLgwi/9R4GGLsuRglie4lPAxlakdgnr6N1IvChubAdg8EJX08zV7tQMS+a2p0hFPejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734712; c=relaxed/simple;
	bh=OpIDWzdlg0any9JAzqVnZ+xhu2rjxA6sBoybOHgswyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTFGPV078NCQERoWAGP4tbLz2D2kP86ClwdJIM/i8c4hD7EwxRLOaUshNYiXBdTK3ovWCB9PbhdW+iTTslL9+0oLjn6TQvY25WE+VID5zaKMryGN/GnaxF4UxHe5XXkk5zu2pF3PSLYq9wKFLcrGHriIQnW7Ehl2dW/w5d3/i58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnDdjM5c; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707734708; x=1739270708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OpIDWzdlg0any9JAzqVnZ+xhu2rjxA6sBoybOHgswyk=;
  b=TnDdjM5cOtJFiPhIHPhYkXzlPxYd2fX7AN95Ba/3yCMfK0EXDLd2d4EW
   nGKV7XFexLny+1qXkhoPCGxVMbuuEzQUWkNLBodkbvc5FpnaYPHXDsq7s
   pva4zfjHTaT0gu3FSxDiOLeBAxTs2Wciri1VgCy9V4H1pqRymV1l1Gqcw
   FQxurSyJFTsYYMH5YZZ+0WIxietrvzfx2+dcdchTw66POzaOByjWwip1l
   25ntY010M6IO3LcMV4mozkDyvff9EgcE1cjJEdbIJGkEPeZ+CSIlsoK7r
   vLpvXVUy9H7PsTVLF9xtOzdD1ku64dCZ/Ouhe0yJzefKFq4ZCvX/cEMXa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1585090"
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="1585090"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:45:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935035605"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="935035605"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 02:45:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 70AD1639; Mon, 12 Feb 2024 12:44:53 +0200 (EET)
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
Subject: [PATCHv7 10/16] x86/tdx: Convert shared memory back to private on kexec
Date: Mon, 12 Feb 2024 12:44:42 +0200
Message-ID: <20240212104448.2589568-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
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


