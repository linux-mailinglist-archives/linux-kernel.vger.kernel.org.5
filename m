Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010197C6F98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347273AbjJLNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347295AbjJLNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:46:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2577BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697118375; x=1728654375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dtlwpq33h+p/pIrL6SXL7lK5bzVsa0cQ+HBNMOWUKLA=;
  b=NOVMhUF7bSSBHu4SAt8TZ3qgYRPOJGe24jPFYT3vAfxe60grKwomxxEU
   A431LP2u22xRIq3MuTwFaS647Kv+NPkBlx4sv2/eyyMnX0LqpN+fPxI7d
   O/F5pl8CVajwE/y6AShDhG2NNz8jdOyksb+xG415HHjsVwL6yFt5JQw5n
   LTkspz+t1acI+OQY46jRzFMNZ2HPtU8fnzZ5+FDRa4T0bQxli0G/AmMaC
   N9/9fAzvCbb/udma33BGSoO/6fL6j4HnA+gvEDjDeVaTZN++8rdP5cREE
   DqxirjTZFddT2nrZMEjxpYC9Lf3xiek+l75UmUmroQnhJb2cGtZpNU/ZQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="451416859"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="451416859"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="747880184"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="747880184"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by orsmga007.jf.intel.com with ESMTP; 12 Oct 2023 06:46:10 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org
Cc:     kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, kai.huang@intel.com,
        nik.borisov@suse.com, linux-kernel@vger.kernel.org,
        heng.su@intel.com, yi.sun@linux.intel.com,
        Yi Sun <yi.sun@intel.com>,
        Dongcheng Yan <dongcheng.yan@intel.com>
Subject: [PATCH v5] x86/tdx: Dump TDX version During the TD Bootup
Date:   Thu, 12 Oct 2023 21:41:36 +0800
Message-Id: <20231012134136.1310650-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
between v1.0 and v1.5" reference.

Add function detect_tdx_version to fetch and dump the version of the
TDX, which is called during TD initialization. Obtain the info by calling
TDG.SYS.RD, including the major and minor version numbers and vendor ID.

The TDCALL TDG.SYS.RD originates from TDX version 1.5. If the error
TDCALL_INVALID_OPERAND occurs, it should be treated as TDX version 1.0.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Yi Sun <yi.sun@intel.com>
---
V1 -> V2:
        - Move the defination of field IDs and the struct tdg_sys_info to tdx.c.
        (Kuppuswamy Sathyanarayanan)

V2 -> V3:
        - Move the allocation of struct tdg_sys_info on stack inside
        tdx_early_init() and pass down to tdg_get_sysinfo() to fill.
        (Kirill Shutemov)

V3 -> V4:
        - Rebase the patch on top of the latest tip tree. (Huang, Kai)
        - Change the return value of function tdg_get_sysinfo as void, and
        zero out tdg_sys_info when error occurs. (Kuppuswamy Sathyanarayanan)

V4 -> V5:
        - Print the version info inside the function detect_tdx_version, but
        not tdx_early_init(). Remove the structure tdg_sys_info, but have 3
        local variables instead. (Huang, Kai)
	- Check for errors on each call to TDG.SYS.RD (Nikolay &
	Sathyanarayanan)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3e6dbd2199cf..23b56952e132 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -37,6 +37,15 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+/*
+ * TDX metadata base field id, used by TDCALL TDG.SYS.RD
+ * See TDX ABI Spec Global Metadata Fields
+ */
+#define TDX_SYS_VENDOR_ID_FID		0x0800000200000000ULL
+#define TDX_SYS_MINOR_FID		0x0800000100000003ULL
+#define TDX_SYS_MAJOR_FID		0x0800000100000004ULL
+#define TDX_VENDOR_INTEL		0x8086
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __noreturn __tdx_hypercall_failed(void)
 {
@@ -800,6 +809,63 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return true;
 }
 
+/*
+ * Detect TDX Module version info from TDG.SYS.RD TDCALL
+ */
+static void detect_tdx_version(void)
+{
+	struct tdx_module_args args = {};
+	u32 vendor_id = TDX_VENDOR_INTEL;
+	u16 major_version = 0;
+	u16 minor_version = 0;
+	u64 ret;
+
+	/*
+	 * TDCALL leaf TDG_SYS_RD
+	 */
+	args.rdx = TDX_SYS_VENDOR_ID_FID;
+	ret = __tdcall_ret(TDG_SYS_RD, &args);
+	/*
+	 * The TDCALL TDG.SYS.RD originates from TDX version 1.5.
+	 * Treat TDCALL_INVALID_OPERAND error as TDX version 1.0.
+	 */
+	if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+		goto version_1_0;
+	if (ret) {
+		WARN(1, "TDX detection: TDG.SYS.RD(VENDOR_ID) error, return %llu\n",
+		     ret);
+		return;
+	}
+	vendor_id = (u32)args.r8;
+
+	args.rdx = TDX_SYS_MAJOR_FID;
+	ret = __tdcall_ret(TDG_SYS_RD, &args);
+	if (ret) {
+		WARN(1, "TDX detection: TDG.SYS.RD(MAJOR) error, return %llu\n",
+		     ret);
+		return;
+	}
+	major_version = (u16)args.r8;
+
+	args.rdx = TDX_SYS_MINOR_FID;
+	ret = __tdcall_ret(TDG_SYS_RD, &args);
+	if (ret) {
+		WARN(1, "TDX detection: TDG.SYS.RD(MINOR) error, return %llu\n",
+		     ret);
+		return;
+	}
+	minor_version = (u16)args.r8;
+
+	pr_info("TDX detected. TDX version:%u.%u VendorID:%x\n",
+		major_version, minor_version, vendor_id);
+
+	return;
+
+	/* TDX 1.0 does not have the TDCALL TDG.SYS.RD */
+version_1_0:
+	pr_info("TDX detected. TDG.SYS.RD not available, assuming TDX version: 1.x (x<5)\n");
+}
+
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -867,5 +933,5 @@ void __init tdx_early_init(void)
 	 */
 	x86_cpuinit.parallel_bringup = false;
 
-	pr_info("Guest detected\n");
+	detect_tdx_version();
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index f74695dea217..1a0cacad5a0c 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -17,6 +17,7 @@
 #define TDG_MR_REPORT			4
 #define TDG_MEM_PAGE_ACCEPT		6
 #define TDG_VM_WR			8
+#define TDG_SYS_RD			11
 
 /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
-- 
2.34.1

