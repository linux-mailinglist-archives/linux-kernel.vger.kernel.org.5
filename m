Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C557EC1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343749AbjKOMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343734AbjKOMBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:01:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B211D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049688; x=1731585688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVI78euvAk0U701k4eLRPlkAOqug1C4uO3/cEzD2QNo=;
  b=VqLhwdzMkYyjjGpK2LTKKf1Hec2H73tugZuzRIkFc6L3CDszjIYqT+fh
   M1zRZNnFoY6jxt2Ru5Ta+viGs0rO4AR6VbWmgcifoQIz4GeX74XFDqU1l
   pLJR4lOaoPsRdkqtnsA20k1nZ5B+ucGLTT0CH3CLmL7J8v9/jjABcYHy+
   ZRWaPmft/0aC+Qc+7bdmeY/io+CKvXKHIkhzXA/sJ5SjN/fibTh8v45mj
   VuQjq9dEvC8Y69hbY8xIsmOUNJYpfyZAWZImShSKRyyQJ5vzByx+4Uc7K
   sYaxmfKMTjxfGe15ejFz5e343LUDW0Mo0s5IMjZjVqacTm+gwhUytynVq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394780477"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="394780477"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="13160257"
Received: from mituomis-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:21 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9D17410A31C; Wed, 15 Nov 2023 15:01:12 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private on kexec
Date:   Wed, 15 Nov 2023 15:00:40 +0300
Message-ID: <20231115120044.8034-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/kexec.c       |   0
 arch/x86/coco/tdx/tdx.c         | 120 +++++++++++++++++++++++++++++++-
 arch/x86/include/asm/x86_init.h |   1 +
 arch/x86/kernel/crash.c         |   4 ++
 arch/x86/kernel/reboot.c        |   5 ++
 5 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/coco/tdx/kexec.c

diff --git a/arch/x86/coco/tdx/kexec.c b/arch/x86/coco/tdx/kexec.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 039f81b7c172..20e946c9a39d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -6,14 +6,17 @@
 
 #include <linux/cpufeature.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/kexec.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/set_memory.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -40,6 +43,9 @@
 
 static atomic_long_t nr_shared;
 
+static atomic_t conversions_in_progress;
+static bool conversion_allowed = true;
+
 static inline bool pte_decrypted(pte_t pte)
 {
 	return cc_mkdec(pte_val(pte)) == pte_val(pte);
@@ -725,6 +731,14 @@ static bool tdx_tlb_flush_required(bool private)
 
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
@@ -808,12 +822,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
 					 bool enc)
 {
+	atomic_inc(&conversions_in_progress);
+
+	/*
+	 * Check after bumping conversions_in_progress to serialize
+	 * against tdx_shutdown().
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
@@ -825,17 +852,104 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
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
 
+static void tdx_kexec_unshare_mem(bool crash)
+{
+	unsigned long addr, end;
+	long found = 0, shared;
+
+	/* Stop new private<->shared conversions */
+	conversion_allowed = false;
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
+			 *
+			 * Bypass unmapping for crash scenario. Unmapping
+			 * requires sleepable context, but in crash case kernel
+			 * hits the code path with interrupts disabled.
+			 * It shouldn't be a problem as all secondary CPUs are
+			 * down and kernel runs with interrupts disabled, so
+			 * there is no room for race.
+			 */
+			if (!crash)
+				set_memory_np(addr, pages);
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
@@ -895,6 +1009,8 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
+	x86_platform.guest.enc_kexec_unshare_mem     = tdx_kexec_unshare_mem;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c9503fe2d13a..917358821a31 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -154,6 +154,7 @@ struct x86_guest {
 	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_kexec_unshare_mem)(bool crash);
 };
 
 /**
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..1618224775f5 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -40,6 +40,7 @@
 #include <asm/intel_pt.h>
 #include <asm/crash.h>
 #include <asm/cmdline.h>
+#include <asm/tdx.h>
 
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
@@ -107,6 +108,9 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 
 	crash_smp_send_stop();
 
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		x86_platform.guest.enc_kexec_unshare_mem(true);
+
 	cpu_emergency_disable_virtualization();
 
 	/*
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 830425e6d38e..9fb302562bfd 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/kexec.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -31,6 +32,7 @@
 #include <asm/realmode.h>
 #include <asm/x86_init.h>
 #include <asm/efi.h>
+#include <asm/tdx.h>
 
 /*
  * Power off function, if any
@@ -716,6 +718,9 @@ static void native_machine_emergency_restart(void)
 
 void native_machine_shutdown(void)
 {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
+		x86_platform.guest.enc_kexec_unshare_mem(false);
+
 	/* Stop the cpus and apics */
 #ifdef CONFIG_X86_IO_APIC
 	/*
-- 
2.41.0

