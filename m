Return-Path: <linux-kernel+bounces-106903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515B87F52F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F911C2154A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F720664A5;
	Tue, 19 Mar 2024 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THuYTleB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92665E03
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812956; cv=none; b=jkQPP2GDBx6yBhbOEHiCnmZK/p7jpibPoYTcCYBNjTeZ9X7XN0crAP1DPeGExw3mrPZd4dg8AQTl+6zZuqE0LnAIkNElqFoWvqWLIOEa871Z1s0mIeQIY4UbfFxiU8e9uWArO4FRFgXZTeyI9wu7xgRRBHjv9LoPBlGVL6/Mty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812956; c=relaxed/simple;
	bh=XhEDGjpkkBWdU1+76Autwe4cmMRpk96DQ5negFxNrS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JY2ILKvNJ0YexTVpN+N1XDYEltc2MyQ1s6VgnKocvrD/jL9MXO77GYSC11I0vcPlXMqJ3tcGY9fajD44isVf+BHa0GlxaUEXqsjrCPSp2CIwieXX3LNmjrooQekgdxnmehYqW09yFZXASamXdQPryA9SWgcy3TsKkNNKfcu0CSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THuYTleB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710812954; x=1742348954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XhEDGjpkkBWdU1+76Autwe4cmMRpk96DQ5negFxNrS8=;
  b=THuYTleBd/ZOwOJS+Vg2vD7S4edSmn6O+1/5Pll3aHpL0UMc/hzYCtBk
   UBeVYyLhQpA1qAD1v2DmPevU9r+fqV1BP8pzEIUSSNRWLWzcaxH4+4DpQ
   XEa0WP4JDT2XW7QLOmToOb+33Sngbrva9Qpi7sYoS0xLK9mFmrEyw93JY
   fdj5AThvN1679qaGLI3EYEwl36uIxWxxqJAhGPS31zzNmbVTVJsXYMQwb
   6ZRORVyjRyeptjNwP32dQJ/UdPp7OZZOjRu2+2WIYfKVSfu+EBw4ptJXl
   85h0MleXyGmRpsdjS88tudNF/KZT72vcYeNsn3q/pY0MOUSnfUFOt3umt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5776932"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5776932"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13697367"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:49:10 -0700
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
Subject: [PATCH v2 5/5] x86/virt/tdx: Add TDX memory reset notifier to reset other private pages
Date: Tue, 19 Mar 2024 01:48:48 +0000
Message-Id: <7ba5b283e6406790a929f61645445bf6997bd334.1710811610.git.kai.huang@intel.com>
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

To cover both normal kexec and crash kexec, add a TDX specific memory
reset notifier to let "in-kernel TDX users" use their own way to convert
TDX private pages (that they manage respectively) in tdx_reset_memory().

Long version:

On the platforms with TDX "partial write machine check" erratum, during
kexec, the kernel needs to convert TDX private memory back to normal
before jumping to the second kernel to avoid the second kernel seeing
potential machine check.

For now tdx_reset_memory() only resets PAMT pages.  KVM will be the
first in-kernel TDX user to support running TDX guests, and by then
other TDX private pages will start to exist.  They need to be covered
too.

Currently the kernel doesn't have a unified way to tell whether a given
page is TDX private page or not.  One choice is to add such unified way,
and there are couple of options to do it:

 1) Use a bitmap, or Xarray, etc to track TDX private page for all PFNs;
 2) Use a "software-only" bit in the direct-mapping PTE to mark a given
    page is TDX private page;
 3) Use a new flag in 'struct page' to mark TDX private page;
 4) ... potential other ways.

Option 1) consumes additional memory.  E.g., if using bitmap, the
overhead is "number of total RAM pages / 8" bytes.

Option 2) would cause splitting large-page mapping to 4K mapping in the
direct mapping when one page is allocated as TDX private page, and cause
additional TLB flush etc.  It's not ideal for such use case.

Option 3) apparently contradicts to the effort to reduce the use of the
flags of 'struct page'.

None of above is ideal.

Therefore, instead of providing a unified way to tell whether a given
page is TDX private page or not, leave "resetting TDX private pages" to
the "in-kernel user" of TDX.

This is motivated by the fact that KVM is already maintaining an Xarray
to track "memory attributes (e.g., private or shared)" for each GFN for
each guest.  Thus KVM can use its own way to find all TDX private pages
that it manages and convert them back to normal.

For the normal kexec the reboot notifier could be used, but it doesn't
cover the cash kexec.

Add a TDX specific memory reset notifier to achieve this.  The in-kernel
TDX users will need to register their own notifiers to reset TDX private
pages.  Call these notifiers in tdx_reset_memory() right before
resetting PAMT pages.

KVM will be the first user of this notifier.  Export the "register" and
"unregister" APIs for KVM to use.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/include/asm/tdx.h  | 14 ++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c | 45 +++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ed3ac9a8a079..7c2c0a0b9754 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -117,12 +117,26 @@ int tdx_cpu_enable(void);
 int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 void tdx_reset_memory(void);
+
+struct notifier_block;
+
+int tdx_register_memory_reset_notifier(struct notifier_block *nb);
+void tdx_unregister_memory_reset_notifier(struct notifier_block *nb);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_cpu_enable(void) { return -ENODEV; }
 static inline int tdx_enable(void)  { return -ENODEV; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 static inline void tdx_reset_memory(void) { }
+
+struct notifier_block;
+
+static inline int tdx_register_memory_reset_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+static inline void tdx_unregister_memory_reset_notifier(
+		struct notifier_block *nb) { }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 1443d486858a..a3daea33c59f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/suspend.h>
 #include <linux/acpi.h>
+#include <linux/notifier.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -55,6 +56,8 @@ static LIST_HEAD(tdx_memlist);
 
 static bool tdx_may_have_private_memory __read_mostly;
 
+static BLOCKING_NOTIFIER_HEAD(tdx_memory_reset_chain);
+
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -1512,6 +1515,27 @@ void __init tdx_init(void)
 	check_tdx_erratum();
 }
 
+int tdx_register_memory_reset_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&tdx_memory_reset_chain, nb);
+}
+EXPORT_SYMBOL_GPL(tdx_register_memory_reset_notifier);
+
+void tdx_unregister_memory_reset_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&tdx_memory_reset_chain, nb);
+}
+EXPORT_SYMBOL_GPL(tdx_unregister_memory_reset_notifier);
+
+static int notify_reset_memory(void)
+{
+	int ret;
+
+	ret = blocking_notifier_call_chain(&tdx_memory_reset_chain, 0, NULL);
+
+	return notifier_to_errno(ret);
+}
+
 void tdx_reset_memory(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
@@ -1554,18 +1578,15 @@ void tdx_reset_memory(void)
 	native_wbinvd();
 
 	/*
-	 * It's ideal to cover all types of TDX private pages here, but
-	 * currently there's no unified way to tell whether a given page
-	 * is TDX private page or not.
-	 *
-	 * Just convert PAMT pages now, as currently TDX private pages
-	 * can only be PAMT pages.
-	 *
-	 * TODO:
-	 *
-	 * This leaves all other types of TDX private pages undealt
-	 * with.  They must be handled in _some_ way when they become
-	 * possible to exist.
+	 * Tell all in-kernel TDX users to reset TDX private pages
+	 * that they manage.
+	 */
+	if (notify_reset_memory())
+		pr_err("Failed to reset all TDX private pages.\n");
+
+	/*
+	 * The only remaining TDX private pages are PAMT pages.
+	 * Reset them.
 	 */
 	tdmrs_reset_pamt_all(&tdx_tdmr_list);
 }
-- 
2.34.1


