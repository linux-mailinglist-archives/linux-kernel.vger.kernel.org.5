Return-Path: <linux-kernel+bounces-46351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE358843E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EDB1C22B53
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DAC76C7B;
	Wed, 31 Jan 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjuY2fWh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1769D39
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700739; cv=none; b=TAVP1vtPKN/biA6/qrgYNtKqqAFtnY3MKb3T5uN+BSmZKiTyoK7S1lmQJvGNqwj9IbaR2xTy+oGq2x3Bke8rzsSa3nhGJ80POH1fJgAT2IKhcTMyIusaKFsbBjvKL8pfC9bQf3l+muG8N6xWyuAieTFzeFXAy8YgF1VzQy58ihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700739; c=relaxed/simple;
	bh=QLWjPgOAvzM+NdIViGkH5yb5DqSyVU9intDk4LX036k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9VfQx+4sq+bzzk/pcSN7aHgeL+V4D2XheLOoY7zGfMVtjHttLqljY6ePbZxySCCL9EGYesd8uDYrRZjZ8Ea+qiHlXnjd6wC8U+DBm47QVgZLeC0m+EG64xP/lLz61IHEZubFuBT1hWALdk0d0OLdg0VUCBrg/+sQjrCXR++oaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjuY2fWh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706700738; x=1738236738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLWjPgOAvzM+NdIViGkH5yb5DqSyVU9intDk4LX036k=;
  b=kjuY2fWhkCn8CEwJut9i0U3yXXRpZCpURemPalYn3xTNWQ/vHfnlT97f
   GZK1lgPwKxmrz+DoPH04dzjqmlSf0tQ0ygdoyEbS8MgM7WYwaNzxhctfM
   ecM3Ey2GDpuM7ORL6KBu4v57a63HWpdMNq/+XJSbBQhSy4lY4Nv3TSH3T
   5AgoVJGa+gTZSzw4tGFdmDZJ6KDwLuCHdcG2NHJZHMH8Gk+BTdxnG9YZV
   e07GTmc6MtXoee1VXrzxmTGa+o3JqexzGR3N/AJWgTtF3O0fRbGuaFXzw
   A6RCn9qEF7nt2AF6Vim5kaF4226AzhkL5NTksp34s1N8DRaGUVCtyL78W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3414232"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3414232"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878764813"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="878764813"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:13 -0800
From: "Huang, Kai" <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	thomas.lendacky@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com
Subject: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms with TDX erratum
Date: Wed, 31 Jan 2024 11:31:55 +0000
Message-Id: <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706698706.git.kai.huang@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kai Huang <kai.huang@intel.com>

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
boot into the new kernel directly.  Thus if the old kernel has enabled
TDX on the platform with this erratum, the new kernel may get unexpected
machine check.

Note that w/o this erratum any kernel read/write on TDX private memory
should never cause machine check, thus it's OK for the old kernel to
leave TDX private pages as is.

== Solution ==

In short, with this erratum, the kernel needs to explicitly convert all
TDX private pages back to normal to give the new kernel a clean slate
after kexec().  The BIOS is also expected to disable fast warm reset as
a workaround to this erratum, thus this implementation doesn't try to
reset TDX private memory for the reboot case in the kernel but depend on
the BIOS to enable the workaround.

Convert TDX private pages back to normal after all remote cpus has been
stopped and cache flush has been done on all cpus, when no more TDX
activity can happen further.  Do it in machine_kexec() to avoid the
additional overhead to the normal reboot/shutdown as the kernel depends
on the BIOS to disable fast warm reset for the reboot case.

For now TDX private memory can only be PAMT pages.  It would be ideal to
cover all types of TDX private memory here, but there are practical
problems to do so:

1) There's no existing infrastructure to track TDX private pages;
2) It's not feasible to query the TDX module about page type because VMX
   has already been stopped when KVM receives the reboot notifier, plus
   the result from the TDX module may not be accurate (e.g., the remote
   CPU could be stopped right before MOVDIR64B).

One temporary solution is to blindly convert all memory pages, but it's
problematic to do so too, because not all pages are mapped as writable
in the direct mapping.  It can be done by switching to the identical
mapping created for kexec() or a new page table, but the complexity
looks overkill.

Therefore, rather than doing something dramatic, only reset PAMT pages
here.  Other kernel components which use TDX need to do the conversion
on their own by intercepting the rebooting/shutdown notifier (KVM
already does that).

Note kexec() can happen at anytime, including when TDX module is being
initialized.  Register TDX reboot notifier callback to stop further TDX
module initialization.  If there's any ongoing module initialization,
wait until it finishes.  This makes sure the TDX module status is stable
after the reboot notifier callback, and the later kexec() code can read
module status to decide whether PAMTs are stable and available.

Also stop further TDX module initialization in case of machine shutdown
and halt, but not limited to kexec(), as there's no reason to do so in
these cases too.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/tdx.h         |  2 +
 arch/x86/kernel/machine_kexec_64.c | 16 +++++
 arch/x86/virt/vmx/tdx/tdx.c        | 98 ++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

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
index c9c6974e2e9c..b2279a3f6976 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -298,9 +299,24 @@ void machine_kexec(struct kimage *image)
 	void *control_page;
 	int save_ftrace_enabled;
 
+	/*
+	 * For platforms with TDX "partial write machine check" erratum,
+	 * all TDX private pages need to be converted back to normal
+	 * before booting to the new kernel, otherwise the new kernel
+	 * may get unexpected machine check.
+	 *
+	 * But skip this when preserve_context is on.  The second kernel
+	 * shouldn't write to the first kernel's memory anyway.  Skipping
+	 * this also avoids killing TDX in the first kernel, which would
+	 * require more complicated handling.
+	 */
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
 		save_processor_state();
+	else
+		tdx_reset_memory();
+#else
+	tdx_reset_memory();
 #endif
 
 	save_ftrace_enabled = __ftrace_enabled_save();
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9f1fed458a32..0537b1b76c2b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/suspend.h>
 #include <linux/acpi.h>
+#include <linux/reboot.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -54,6 +55,8 @@ static DEFINE_MUTEX(tdx_module_lock);
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
+static bool tdx_rebooting;
+
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -1187,6 +1190,9 @@ static int __tdx_enable(void)
 {
 	int ret;
 
+	if (tdx_rebooting)
+		return -EAGAIN;
+
 	ret = init_tdx_module();
 	if (ret) {
 		pr_err("module initialization failed (%d)\n", ret);
@@ -1420,6 +1426,90 @@ static struct notifier_block tdx_memory_nb = {
 	.notifier_call = tdx_memory_notifier,
 };
 
+/*
+ * Convert TDX private pages back to normal on platforms with
+ * "partial write machine check" erratum.
+ *
+ * Called from machine_kexec() before booting to the new kernel.
+ */
+void tdx_reset_memory(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return;
+
+	/*
+	 * Kernel read/write to TDX private memory doesn't
+	 * cause machine check on hardware w/o this erratum.
+	 */
+	if (!boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
+		return;
+
+	/* Called from kexec() when only rebooting cpu is alive */
+	WARN_ON_ONCE(num_online_cpus() != 1);
+
+	/*
+	 * tdx_reboot_notifier() waits until ongoing TDX module
+	 * initialization to finish, and module initialization is
+	 * rejected after that.  Therefore @tdx_module_status is
+	 * stable here and can be read w/o holding lock.
+	 */
+	if (tdx_module_status != TDX_MODULE_INITIALIZED)
+		return;
+
+	/*
+	 * Flush cache of all TDX private memory _before_ converting
+	 * them back to avoid silent memory corruption.
+	 */
+	native_wbinvd();
+
+	/*
+	 * Convert PAMTs back to normal.  All other cpus are already
+	 * dead and TDMRs/PAMTs are stable.
+	 *
+	 * Ideally it's better to cover all types of TDX private pages
+	 * here, but it's impractical:
+	 *
+	 *  - There's no existing infrastructure to tell whether a page
+	 *    is TDX private memory or not.
+	 *
+	 *  - Using SEAMCALL to query TDX module isn't feasible either:
+	 *    - VMX has been turned off by reaching here so SEAMCALL
+	 *      cannot be made;
+	 *    - Even SEAMCALL can be made the result from TDX module may
+	 *      not be accurate (e.g., remote CPU can be stopped while
+	 *      the kernel is in the middle of reclaiming TDX private
+	 *      page and doing MOVDIR64B).
+	 *
+	 * One temporary solution could be just converting all memory
+	 * pages, but it's problematic too, because not all pages are
+	 * mapped as writable in direct mapping.  It can be done by
+	 * switching to the identical mapping for kexec() or a new page
+	 * table which maps all pages as writable, but the complexity is
+	 * overkill.
+	 *
+	 * Thus instead of doing something dramatic to convert all pages,
+	 * only convert PAMTs here.  Other kernel components which use
+	 * TDX need to do the conversion on their own by intercepting the
+	 * rebooting/shutdown notifier (KVM already does that).
+	 */
+	tdmrs_reset_pamt_all(&tdx_tdmr_list);
+}
+
+static int tdx_reboot_notifier(struct notifier_block *nb, unsigned long mode,
+			       void *unused)
+{
+	/* Wait ongoing TDX initialization to finish */
+	mutex_lock(&tdx_module_lock);
+	tdx_rebooting = true;
+	mutex_unlock(&tdx_module_lock);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block tdx_reboot_nb = {
+	.notifier_call = tdx_reboot_notifier,
+};
+
 static void __init check_tdx_erratum(void)
 {
 	/*
@@ -1474,6 +1564,14 @@ void __init tdx_init(void)
 		return;
 	}
 
+	err = register_reboot_notifier(&tdx_reboot_nb);
+	if (err) {
+		pr_err("initialization failed: register_reboot_notifier() failed (%d)\n",
+				err);
+		unregister_memory_notifier(&tdx_memory_nb);
+		return;
+	}
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 	pr_info("Disable ACPI S3. Turn off TDX in the BIOS to use ACPI S3.\n");
 	acpi_suspend_lowlevel = NULL;
-- 
2.34.1


