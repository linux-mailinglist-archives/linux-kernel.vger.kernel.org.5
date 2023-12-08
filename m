Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E168F80AA70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574466AbjLHRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjLHRRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D953D54;
        Fri,  8 Dec 2023 09:17:23 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=whWOuJeeI4RxrHi15qpmwr6URJYckjH5vPHef6z4hBs=;
        b=ueUidS+aF4WbFwUpPF016AR7aY5d904Bf8fjqrGnQHRl6sBFV7PGl9dcZV8vVYkEohzjcv
        FU95cSnBAVrWw7haGqUBj0FW0EG+NCx9XrF/QhkoHE0KtSeTvqjl4KB31euaiPdMs8SMwc
        gJDeE++O8IDGoI3iTB0yBW+n4VTtClk3wJVo1p7wppkeVyg6f2B/fWPcKd55UP51UPFPwP
        A0OJgUEH9hSRYEVed/eVBPM5Hiw8d/BCyb0wvnMQUG5PM0o+oRp8RRSzw6pnj9uPl26sR1
        L2f54E44MhNyAgreLXUjk+oshi0DJLWOvR9uLQm5BJ7iYCU+tBBzqEFvEI8gKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=whWOuJeeI4RxrHi15qpmwr6URJYckjH5vPHef6z4hBs=;
        b=Ycdpmsyynn7E4O0/yGymauFwUShg1xVVDJWLE3cdSwpaNZKGeIFQDYeNvp5zhbxufhWQ9M
        /oxqLWVvyW1uIDBQ==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Configure global KeyID on all packages
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yuan Yao <yuan.yao@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584116.398.10552160777675451766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     e56d28df2f666af9ce0c27d8d204ad813d3766f4
Gitweb:        https://git.kernel.org/tip/e56d28df2f666af9ce0c27d8d204ad813d3766f4
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:34 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:43 -08:00

x86/virt/tdx: Configure global KeyID on all packages

After the list of TDMRs and the global KeyID are configured to the TDX
module, the kernel needs to configure the key of the global KeyID on all
packages using TDH.SYS.KEY.CONFIG.

This SEAMCALL cannot run parallel on different cpus.  Loop all online
cpus and use smp_call_on_cpu() to call this SEAMCALL on the first cpu of
each package.

To keep things simple, this implementation takes no affirmative steps to
online cpus to make sure there's at least one cpu for each package.  The
callers (aka. KVM) can ensure success by ensuring sufficient CPUs are
online for this to succeed.

Intel hardware doesn't guarantee cache coherency across different
KeyIDs.  The PAMTs are transitioning from being used by the kernel
mapping (KeyId 0) to the TDX module's "global KeyID" mapping.

This means that the kernel must flush any dirty KeyID-0 PAMT cachelines
before the TDX module uses the global KeyID to access the PAMTs.
Otherwise, if those dirty cachelines were written back, they would
corrupt the TDX module's metadata.  Aside: This corruption would be
detected by the memory integrity hardware on the next read of the memory
with the global KeyID.  The result would likely be fatal to the system
but would not impact TDX security.

Following the TDX module specification, flush cache before configuring
the global KeyID on all packages.  Given the PAMT size can be large
(~1/256th of system RAM), just use WBINVD on all CPUs to flush.

If TDH.SYS.KEY.CONFIG fails, the TDX module may already have "converted"
some memory for TDX module use.  Convert the memory back so that it can
be safely used by the kernel again.  Note that this is slower than it
should be because of the "partial write machine check" erratum which
affects TDX-capable hardware.

Also refactor and introduce a new helper: tdmr_do_pamt_func().  This
takes a TDMR and runs a function on its PAMT.  It looks a _bit_ odd to
pass a function pointer around like this, but its use is pretty narrow
and it does eliminate what would otherwise be some copying and pasting.

[ dhansen: * munge changelog as usual
	   * remove weird (*pamd_func)() syntax ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Yuan Yao <yuan.yao@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-14-dave.hansen%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 133 ++++++++++++++++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h |   1 +-
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5146503..d2e4180 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -26,6 +26,7 @@
 #include <linux/sort.h>
 #include <linux/log2.h>
 #include <asm/page.h>
+#include <asm/special_insns.h>
 #include <asm/msr-index.h>
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
@@ -606,7 +607,8 @@ static void tdmr_get_pamt(struct tdmr_info *tdmr, unsigned long *pamt_base,
 	*pamt_size = pamt_sz;
 }
 
-static void tdmr_free_pamt(struct tdmr_info *tdmr)
+static void tdmr_do_pamt_func(struct tdmr_info *tdmr,
+		void (*pamt_func)(unsigned long base, unsigned long size))
 {
 	unsigned long pamt_base, pamt_size;
 
@@ -619,9 +621,19 @@ static void tdmr_free_pamt(struct tdmr_info *tdmr)
 	if (WARN_ON_ONCE(!pamt_base))
 		return;
 
+	pamt_func(pamt_base, pamt_size);
+}
+
+static void free_pamt(unsigned long pamt_base, unsigned long pamt_size)
+{
 	free_contig_range(pamt_base >> PAGE_SHIFT, pamt_size >> PAGE_SHIFT);
 }
 
+static void tdmr_free_pamt(struct tdmr_info *tdmr)
+{
+	tdmr_do_pamt_func(tdmr, free_pamt);
+}
+
 static void tdmrs_free_pamt_all(struct tdmr_info_list *tdmr_list)
 {
 	int i;
@@ -650,6 +662,41 @@ err:
 	return ret;
 }
 
+/*
+ * Convert TDX private pages back to normal by using MOVDIR64B to
+ * clear these pages.  Note this function doesn't flush cache of
+ * these TDX private pages.  The caller should make sure of that.
+ */
+static void reset_tdx_pages(unsigned long base, unsigned long size)
+{
+	const void *zero_page = (const void *)page_address(ZERO_PAGE(0));
+	unsigned long phys, end;
+
+	end = base + size;
+	for (phys = base; phys < end; phys += 64)
+		movdir64b(__va(phys), zero_page);
+
+	/*
+	 * MOVDIR64B uses WC protocol.  Use memory barrier to
+	 * make sure any later user of these pages sees the
+	 * updated data.
+	 */
+	mb();
+}
+
+static void tdmr_reset_pamt(struct tdmr_info *tdmr)
+{
+	tdmr_do_pamt_func(tdmr, reset_tdx_pages);
+}
+
+static void tdmrs_reset_pamt_all(struct tdmr_info_list *tdmr_list)
+{
+	int i;
+
+	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++)
+		tdmr_reset_pamt(tdmr_entry(tdmr_list, i));
+}
+
 static unsigned long tdmrs_count_pamt_kb(struct tdmr_info_list *tdmr_list)
 {
 	unsigned long pamt_size = 0;
@@ -929,6 +976,64 @@ static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
 	return ret;
 }
 
+static int do_global_key_config(void *unused)
+{
+	struct tdx_module_args args = {};
+
+	return seamcall_prerr(TDH_SYS_KEY_CONFIG, &args);
+}
+
+/*
+ * Attempt to configure the global KeyID on all physical packages.
+ *
+ * This requires running code on at least one CPU in each package.
+ * TDMR initialization) will fail will fail if any package in the
+ * system has no online CPUs.
+ *
+ * This code takes no affirmative steps to online CPUs.  Callers (aka.
+ * KVM) can ensure success by ensuring sufficient CPUs are online and
+ * can run SEAMCALLs.
+ */
+static int config_global_keyid(void)
+{
+	cpumask_var_t packages;
+	int cpu, ret = -EINVAL;
+
+	if (!zalloc_cpumask_var(&packages, GFP_KERNEL))
+		return -ENOMEM;
+
+	/*
+	 * Hardware doesn't guarantee cache coherency across different
+	 * KeyIDs.  The kernel needs to flush PAMT's dirty cachelines
+	 * (associated with KeyID 0) before the TDX module can use the
+	 * global KeyID to access the PAMT.  Given PAMTs are potentially
+	 * large (~1/256th of system RAM), just use WBINVD.
+	 */
+	wbinvd_on_all_cpus();
+
+	for_each_online_cpu(cpu) {
+		/*
+		 * The key configuration only needs to be done once per
+		 * package and will return an error if configured more
+		 * than once.  Avoid doing it multiple times per package.
+		 */
+		if (cpumask_test_and_set_cpu(topology_physical_package_id(cpu),
+					packages))
+			continue;
+
+		/*
+		 * TDH.SYS.KEY.CONFIG cannot run concurrently on
+		 * different cpus.  Do it one by one.
+		 */
+		ret = smp_call_on_cpu(cpu, do_global_key_config, NULL, true);
+		if (ret)
+			break;
+	}
+
+	free_cpumask_var(packages);
+	return ret;
+}
+
 static int init_tdx_module(void)
 {
 	struct tdx_tdmr_sysinfo tdmr_sysinfo;
@@ -969,6 +1074,11 @@ static int init_tdx_module(void)
 	if (ret)
 		goto err_free_pamts;
 
+	/* Config the key of global KeyID on all packages */
+	ret = config_global_keyid();
+	if (ret)
+		goto err_reset_pamts;
+
 	/*
 	 * TODO:
 	 *
@@ -979,7 +1089,7 @@ static int init_tdx_module(void)
 	 */
 	ret = -EINVAL;
 	if (ret)
-		goto err_free_pamts;
+		goto err_reset_pamts;
 
 	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
 
@@ -991,6 +1101,22 @@ out_put_tdxmem:
 	put_online_mems();
 	return ret;
 
+err_reset_pamts:
+	/*
+	 * Part of PAMTs may already have been initialized by the
+	 * TDX module.  Flush cache before returning PAMTs back
+	 * to the kernel.
+	 */
+	wbinvd_on_all_cpus();
+	/*
+	 * According to the TDX hardware spec, if the platform
+	 * doesn't have the "partial write machine check"
+	 * erratum, any kernel read/write will never cause #MC
+	 * in kernel space, thus it's OK to not convert PAMTs
+	 * back to normal.  But do the conversion anyway here
+	 * as suggested by the TDX spec.
+	 */
+	tdmrs_reset_pamt_all(&tdx_tdmr_list);
 err_free_pamts:
 	tdmrs_free_pamt_all(&tdx_tdmr_list);
 err_free_tdmrs:
@@ -1024,6 +1150,9 @@ static int __tdx_enable(void)
  * lock to prevent any new cpu from becoming online; 2) done both VMXON
  * and tdx_cpu_enable() on all online cpus.
  *
+ * This function requires there's at least one online cpu for each CPU
+ * package to succeed.
+ *
  * This function can be called in parallel by multiple callers.
  *
  * Return 0 if TDX is enabled successfully, otherwise error.
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index fa5bcf8..dd35baf 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -14,6 +14,7 @@
 /*
  * TDX module SEAMCALL leaf functions
  */
+#define TDH_SYS_KEY_CONFIG	31
 #define TDH_SYS_INIT		33
 #define TDH_SYS_RD		34
 #define TDH_SYS_LP_INIT		35
