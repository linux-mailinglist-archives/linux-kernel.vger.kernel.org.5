Return-Path: <linux-kernel+bounces-106901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70CC87F52D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399E81F21A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B0165BB4;
	Tue, 19 Mar 2024 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVisq1T7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0765BA0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812948; cv=none; b=YWUD1vr7mg6Cy+9xMolmQ6qTLrAqrzcPYcl5x6mJl+GFe0LODPYBoSOAfNbMsZvmRRC9ald1v+z5XFoIf4AbZ40F9mUckYEBpYTegxtGi/9Snr9a1xiZvRWtUu1Ns8Zj5pcGVmhkm5vni7av/jXNxd3NmUyGeDbN3XKdQHdB6nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812948; c=relaxed/simple;
	bh=hMVS5xLN7SybAyi7eh+e9lC94o21AAJJbCO+iURGvB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7EvmHFhkwJdks3HJvHBQ7oiu0IyNyuPtuR0/uhKZPORV2zofFnkWlfk0GPMinRT6xQwsv0S3FCQ5iQ6uhqHatXkM1In9yLYw2UYClZLy5yldOQNFWvevZ/ghEZWKOjehe7u0A78Vs+0VCZmujwEqq4Crj18A4I2FqMNm1uuRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVisq1T7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710812946; x=1742348946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMVS5xLN7SybAyi7eh+e9lC94o21AAJJbCO+iURGvB8=;
  b=ZVisq1T7i0a/wkzmxxR8YMXdScXWHOYec5BxJJf1hqcyh7T0wOPPjhv9
   5Le9MMP4kpoUEiyVC450YqqiyPJl1R0IoOg0deN2VUsp1AZLGjMOpOU5l
   l6IhEcVaSi23gQdxi5DceJh6AIKXaG2KQL4+kQLf4f4o6Semf/hgE88Dl
   4kN7egBuO36Ydh+XCCfRzdy2ZKWTDPK52N1bBObfHjpjQ2pWjb36/b5JU
   CgQSzQmJgo+oYxafwpfX/ZxrpYFLt40gp8HgVoquom7fNdufV/4bIGZlL
   nUx5SK5s4B56D6hRD0svb3keVAMsyuLOtxb93zLL66LY9W3hCc8PIuuD8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5776907"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5776907"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:49:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13697344"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:49:02 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v2 3/5] x86/kexec: Reset TDX private memory on platforms with TDX erratum
Date: Tue, 19 Mar 2024 01:48:46 +0000
Message-Id: <848cf96640be6ea8132ab173b83f5ea13b88a88e.1710811610.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710811610.git.kai.huang@intel.com>
References: <cover.1710811610.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR:

On the platforms with TDX "partial write machine check" erratum, during
kexec, convert TDX private memory back to normal before jumping to the
second kernel to avoid the second kernel seeing potential unexpected
machine check.

Long version:

The first few generations of TDX hardware have an erratum.  A partial
write to a TDX private memory cacheline will silently "poison" the
line.  Subsequent reads will consume the poison and generate a machine
check.  According to the TDX hardware spec, neither of these things
should have happened.

== Background ==

Virtually all kernel memory accesses operations happen in full
cachelines.  In practice, writing a "byte" of memory usually reads a 64
byte cacheline of memory, modifies it, then writes the whole line back.
Those operations do not trigger this problem.

This problem is triggered by "partial" writes where a write transaction
of less than cacheline lands at the memory controller.  The CPU does
these via non-temporal write instructions (like MOVNTI), or through
UC/WC memory mappings.  The issue can also be triggered away from the
CPU by devices doing partial writes via DMA.

== Problem ==

A fast warm reset doesn't reset TDX private memory.  Kexec() can also
boot into the new kernel directly.  Thus if the old kernel has left any
TDX private pages on the platform with this erratum, the new kernel
might get unexpected machine check.

Note that w/o this erratum any kernel read/write on TDX private memory
should never cause machine check, thus it's OK for the old kernel to
leave TDX private pages as is.

== Solution ==

In short, with this erratum, the kernel needs to explicitly convert all
TDX private pages back to normal to give the new kernel a clean slate
after kexec().  The BIOS is also expected to disable fast warm reset as
a workaround to this erratum, thus this implementation doesn't try to
reset TDX private memory for the reboot case in the kernel but depends
on the BIOS to enable the workaround.

Convert TDX private pages back to normal (using MOVDIR64B to clear these
pages) after all remote cpus have been stopped and cache flush has been
done on all cpus, when no more TDX activity can happen further.

Do it in machine_kexec() to cover both normal kexec, and crash kexec.

For now TDX private memory can only be PAMT pages.  It would be ideal to
cover all types of TDX private memory here, but there are practical
problems to do so:

1) There's no existing infrastructure to track TDX private pages;
2) It's not feasible to query the TDX module about page type, because
   VMX, which making SEAMCALL requires, has already been disabled;
3) Even if it is feasible to query the TDX module, the result may not be
   accurate.  E.g., the remote CPU could be stopped right before
   MOVDIR64B.

One temporary solution is to blindly convert all memory pages, but it's
problematic to do so too, because not all pages are mapped as writable
in the direct mapping.  It can be done by switching to the identical
mapping created for kexec(), or a new page table, but the complexity
looks overkill.

Therefore, rather than doing something dramatic, only reset PAMT pages
here.

Leave resetting other TDX private pages as a future work when they
become possible to exist.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

v1 -> v2:
 - Remove using reboot notifier to stop TDX module as it doesn't
   cover crash kexec.  Change to use a variable with barrier instead.
   (Rick)
 - Introduce kexec_save_processor_start() to make code better, and
   make the comment around calling site of tdx_reset_memory() more
   concise. (Dave)
 - Mention cache for all other cpus have been flushed around
   native_wbinvd() in tdx_reset_memory(). (Dave)
 - Remove the extended alternaties discussion from the comment, but leave
   it in the changelog. Point out what does current code do and point out
   risk. (Dave)

---
 arch/x86/include/asm/tdx.h         |  2 +
 arch/x86/kernel/machine_kexec_64.c | 27 ++++++++--
 arch/x86/virt/vmx/tdx/tdx.c        | 79 ++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba178996d84..ed3ac9a8a079 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -116,11 +116,13 @@ static inline u64 sc_retry(sc_func_t func, u64 fn,
 int tdx_cpu_enable(void);
 int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
+void tdx_reset_memory(void);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_cpu_enable(void) { return -ENODEV; }
 static inline int tdx_enable(void)  { return -ENODEV; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
+static inline void tdx_reset_memory(void) { }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b9a632479b36..fdc2ffdc7d90 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -288,6 +289,14 @@ void machine_kexec_cleanup(struct kimage *image)
 	free_transition_pgtable(image);
 }
 
+static void kexec_save_processor_start(struct kimage *image)
+{
+#ifdef CONFIG_KEXEC_JUMP
+	if (image->preserve_context)
+		save_processor_state();
+#endif
+}
+
 /*
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
@@ -298,10 +307,20 @@ void machine_kexec(struct kimage *image)
 	void *control_page;
 	int save_ftrace_enabled;
 
-#ifdef CONFIG_KEXEC_JUMP
-	if (image->preserve_context)
-		save_processor_state();
-#endif
+	kexec_save_processor_start(image);
+
+	/*
+	 * Convert TDX private memory back to normal (when needed) to
+	 * avoid the second kernel potentially seeing unexpected machine
+	 * check.
+	 *
+	 * However skip this when preserve_context is on.  By reaching
+	 * here, TDX (if ever got enabled by the kernel) has survived
+	 * from the suspend when preserve_context is on, and it can
+	 * continue to work after jumping back from the second kernel.
+	 */
+	if (!image->preserve_context)
+		tdx_reset_memory();
 
 	save_ftrace_enabled = __ftrace_enabled_save();
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d6826a76f78..1443d486858a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -53,6 +53,8 @@ static DEFINE_MUTEX(tdx_module_lock);
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
+static bool tdx_may_have_private_memory __read_mostly;
+
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -1097,6 +1099,18 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+static void mark_may_have_private_memory(bool may)
+{
+	tdx_may_have_private_memory = may;
+
+	/*
+	 * Ensure update to tdx_may_have_private_memory is visible to all
+	 * cpus.  This ensures when any remote cpu reads it as true, the
+	 * 'tdx_tdmr_list' must be stable for reading PAMTs.
+	 */
+	smp_wmb();
+}
+
 static int init_tdx_module(void)
 {
 	struct tdx_tdmr_sysinfo tdmr_sysinfo;
@@ -1142,6 +1156,12 @@ static int init_tdx_module(void)
 	if (ret)
 		goto err_reset_pamts;
 
+	/*
+	 * Starting from this point the system is possible to have
+	 * TDX private memory.
+	 */
+	mark_may_have_private_memory(true);
+
 	/* Initialize TDMRs to complete the TDX module initialization */
 	ret = init_tdmrs(&tdx_tdmr_list);
 	if (ret)
@@ -1173,6 +1193,7 @@ static int init_tdx_module(void)
 	 * as suggested by the TDX spec.
 	 */
 	tdmrs_reset_pamt_all(&tdx_tdmr_list);
+	mark_may_have_private_memory(false);
 err_free_pamts:
 	tdmrs_free_pamt_all(&tdx_tdmr_list);
 err_free_tdmrs:
@@ -1490,3 +1511,61 @@ void __init tdx_init(void)
 
 	check_tdx_erratum();
 }
+
+void tdx_reset_memory(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return;
+
+	/*
+	 * Converting TDX private pages back to normal must be done
+	 * when there's no TDX activity anymore on all remote cpus.
+	 * Verify this is only called when all remote cpus have
+	 * been stopped.
+	 */
+	WARN_ON_ONCE(num_online_cpus() != 1);
+
+	/*
+	 * Kernel read/write to TDX private memory doesn't cause
+	 * machine check on hardware w/o this erratum.
+	 */
+	if (!boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
+		return;
+
+	/*
+	 * Nothing to convert if it's not possible to have any TDX
+	 * private pages.
+	 */
+	if (!tdx_may_have_private_memory)
+		return;
+
+	/*
+	 * Ensure the 'tdx_tdmr_list' is stable for reading PAMTs
+	 * when tdx_may_have_private_memory reads true, paired with
+	 * the smp_wmb() in mark_may_have_private_memory().
+	 */
+	smp_rmb();
+
+	/*
+	 * All remote cpus have been stopped, and their caches have
+	 * been flushed in stop_this_cpu().  Now flush cache for the
+	 * last running cpu _before_ converting TDX private pages.
+	 */
+	native_wbinvd();
+
+	/*
+	 * It's ideal to cover all types of TDX private pages here, but
+	 * currently there's no unified way to tell whether a given page
+	 * is TDX private page or not.
+	 *
+	 * Just convert PAMT pages now, as currently TDX private pages
+	 * can only be PAMT pages.
+	 *
+	 * TODO:
+	 *
+	 * This leaves all other types of TDX private pages undealt
+	 * with.  They must be handled in _some_ way when they become
+	 * possible to exist.
+	 */
+	tdmrs_reset_pamt_all(&tdx_tdmr_list);
+}
-- 
2.34.1


