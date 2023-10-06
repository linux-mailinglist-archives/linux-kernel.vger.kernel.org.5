Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0432F7BB18D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjJFGaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJFGaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:30:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B72AE4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696573806; x=1728109806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6KA3o7Q+0ZiB26ZPIhrmr6o7vKG/7KfJ8PTKqX0mwec=;
  b=CZPqeX1I/4VPsi4dV1Q/zWv9jrsbBA4sKYkArPhKuurCjP/hVxLA36Qe
   /85Cy3QFH61ggMWmBLwzbDr0AGzc1L5vwg/wwuinWmFiqV/6zQyGPtncn
   +KEB4om6cELhwIbgjlfvuLatcl9o84X0QEyoDvXilXMTLfpBD2qje52zk
   HKFxQAP2oTgyINMHco/pSwVkP3qHMP+hDMLg3xnvnfhAj+fiPRkNppGI3
   hpk/sYkH7C5lMEKtnwfr+zOORaWnMG2qTzXZg/ez095RQOvdn/B5yJJeh
   yst5ODtvpmsmc2ITi71LajCivT2gRIY2CGYIzEP2BotU5WcA3/xZxaYx+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2290389"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2290389"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 23:30:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755749919"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755749919"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by fmsmga007.fm.intel.com with ESMTP; 05 Oct 2023 23:30:00 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org
Cc:     kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, kai.huang@intel.com,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        yi.sun@linux.intel.com, Yi Sun <yi.sun@intel.com>,
        Dongcheng Yan <dongcheng.yan@intel.com>
Subject: [PATCH v4] x86/tdx: Dump TDX version During the TD Bootup
Date:   Fri,  6 Oct 2023 14:28:55 +0800
Message-Id: <20231006062855.875631-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is essential for TD users to be aware of the vendor and version of
the current TDX. Additionally, they can reference the TDX version when
reporting bugs or issues.

Furthermore, the applications or device drivers running in TD can achieve
enhanced reliability and flexibility by following the TDX Module ABI
specification, because there are significant differences between different
versions of TDX, as mentioned in the "Intel® TDX Module Incompatibilities
between v1.0 and v1.5" reference. Here are a few examples:

MSR Name		Index		Reason
----------------------------------------------
IA32_UARCH_MISC_CTL	0x1B01		From v1.5
IA32_ARCH_CAPABILITIES	0x010A		Changed in v1.5
IA32_TSX_CTRL		0x0122		Changed in v1.5

CPUID Leaf	Sub-leaf	Reason
---------------------------------------
0x7		2		From v1.5
0x22		0		From v1.5
0x23		0~3		From v1.5
0x80000007	0		From v1.5

During TD initialization, the TDX version info can be obtained by calling
TDG.SYS.RD. This will fetch the current version of TDX, including the major
and minor version numbers and vendor ID.

The TDCALL TDG.SYS.RD originates from TDX version 1.5. If the error
TDCALL_INVALID_OPERAND occurs, it should be treated as TDX version 1.0.

If the __tdcall_ret fails, expect a zero value for all tdx sys info.
No additional error code is necessary to avoid introducing noise during
the bootup.

Co-developed-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3e6dbd2199cf..991f7dc695bd 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -37,6 +37,24 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+/*
+ * TDX metadata base field id, used by TDCALL TDG.SYS.RD
+ * See TDX ABI Spec section 3.3.2.3 Global Metadata Fields
+ */
+#define TDX_SYS_VENDOR_ID_FID		0x0800000200000000ULL
+#define TDX_SYS_MINOR_FID		0x0800000100000003ULL
+#define TDX_SYS_MAJOR_FID		0x0800000100000004ULL
+#define TDX_VENDOR_INTEL		0x8086
+
+/*
+ * The global-scope metadata field via TDG.SYS.RD TDCALL
+ */
+struct tdg_sys_info {
+	u32 vendor_id;
+	u16 major_version;
+	u16 minor_version;
+};
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __noreturn __tdx_hypercall_failed(void)
 {
@@ -800,6 +818,60 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return true;
 }
 
+/*
+ * Parse the tdx module version info from the global-scope metadata fields.
+ *
+ * Refer to Intel TDX Application Binary Interface (ABI) section
+ * "TDG.SYS.RD".
+ */
+static void tdg_get_sysinfo(struct tdg_sys_info *td_sys)
+{
+	u64 ret;
+	struct tdx_module_args args = {
+		.rdx = TDX_SYS_VENDOR_ID_FID,
+	};
+
+	if (!td_sys)
+		return;
+
+	memset(td_sys, 0, sizeof(struct tdg_sys_info));
+
+	/*
+	 * TDCALL leaf TDX_SYS_RD
+	 * Input Field Identifier via RDX and get the output via R8.
+	 */
+	ret = __tdcall_ret(TDX_SYS_RD, &args);
+	/*
+	 * The TDCALL TDG.SYS.RD originates from TDX version 1.5.
+	 * Treat TDCALL_INVALID_OPERAND error as TDX version 1.0.
+	 * If other errors occur, return with zero td_sys.
+	 */
+	if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+		goto version_1_0;
+	else if (ret)
+		return;
+
+	td_sys->vendor_id = (u32)args.r8;
+
+	args.rdx = TDX_SYS_MAJOR_FID;
+	__tdcall_ret(TDX_SYS_RD, &args);
+
+	td_sys->major_version = (u16)args.r8;
+
+	args.rdx = TDX_SYS_MINOR_FID;
+	__tdcall_ret(TDX_SYS_RD, &args);
+
+	td_sys->minor_version = (u16)args.r8;
+
+	return;
+
+	/* TDX 1.0 does not have the TDCALL TDG.SYS.RD */
+version_1_0:
+	td_sys->vendor_id = TDX_VENDOR_INTEL;
+	td_sys->major_version = 1;
+	td_sys->minor_version = 0;
+}
+
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -808,6 +880,7 @@ void __init tdx_early_init(void)
 	};
 	u64 cc_mask;
 	u32 eax, sig[3];
+	struct tdg_sys_info td_sys_info;
 
 	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
 
@@ -867,5 +940,9 @@ void __init tdx_early_init(void)
 	 */
 	x86_cpuinit.parallel_bringup = false;
 
-	pr_info("Guest detected\n");
+	tdg_get_sysinfo(&td_sys_info);
+
+	pr_info("Guest detected. TDX version:%u.%u VendorID: %x\n",
+		td_sys_info.major_version, td_sys_info.minor_version,
+		td_sys_info.vendor_id);
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index f74695dea217..d326509832e6 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -17,6 +17,7 @@
 #define TDG_MR_REPORT			4
 #define TDG_MEM_PAGE_ACCEPT		6
 #define TDG_VM_WR			8
+#define TDX_SYS_RD			11
 
 /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
-- 
2.34.1

