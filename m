Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109F87D8DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ0Ex5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0Exz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:53:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924471A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 21:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698382433; x=1729918433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=huQdfmv4RAlE6agN1ox97fjjq4rCy8uyOU1Wk51RW30=;
  b=DFttywXP+YBLXNyOea+Ty+0xHYV2TTYTSbrlWrrPf5tZUrL2M16kvbNI
   18pl8/+fvToEyuBwAEASaNLRUcBkqoez8UqqYHNcVyFVd+NFM8xAQQUzd
   bECkLDG00JsYPwEnzMkyN04u0RKMzRJtEONoeQ97lXkhbAsRpXrLem8Mv
   kCoPaOjaBE/Ip5TjMkTazlWVY+mDV3arSTE/r1j8FesANBuQWvZ3UhXeN
   gw5QSXniQ0I/w1Tu5vL3ttU/hC42KmcKsdU0IQ3hs9b9cGkePvCDlSmJn
   HZCInH0hmPT/X+UahwKZopRkJr6qYAxZ5cGMhW4HoiZWIKIPw6rgOWc3Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="9247690"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="9247690"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 21:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="763080962"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="763080962"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by fmsmga007.fm.intel.com with ESMTP; 26 Oct 2023 21:53:49 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org
Cc:     kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, kai.huang@intel.com,
        nik.borisov@suse.com, linux-kernel@vger.kernel.org,
        heng.su@intel.com, yi.sun@linux.intel.com,
        Yi Sun <yi.sun@intel.com>,
        Dongcheng Yan <dongcheng.yan@intel.com>
Subject: [PATCH v7] x86/tdx: Dump TDX Version During TD Bootup
Date:   Fri, 27 Oct 2023 12:52:34 +0800
Message-Id: <20231027045234.1371846-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different versions of TDX have significant differences, as stated in the
"Intel® TDX Module Incompatibilities between v1.0 and v1.5" reference.

It would be useful for TD users to be aware of the vendor and version of
the current TDX in use. Users could expect different results when checking
CPIUD or reading MSR in the user space, depending on the TDX version.
Additionally, refer to the TDX version when reporting issues.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Co-developed-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Yi Sun <yi.sun@intel.com>

---
V6 -> V7:
	- Reduce unnecessary variable initializations and improve the dump
	information. (Kuppuswamy Sathyanarayanan)

V5 -> V6:
	- Remove random warnings at every step. Print the error in common
	code. (Dave Hansen)

	- Remove useless assignment and cast. Re-zeroed the input args
	between tdcalls. Refine the comments. (Dave Hansen)

V4 -> V5:
	- Print the version info inside the function detect_tdx_version, but
	not tdx_early_init(). Remove the structure tdg_sys_info, but have 3
	local variables instead. (Huang, Kai)

V3 -> V4: 
	- Rebase the patch on top of the latest tip tree. (Huang, Kai)
	- Change the return value of function tdg_get_sysinfo as void, and
	zero out tdg_sys_info when error occurs. (Kuppuswamy Sathyanarayanan)

V2 -> V3: 
	- Move the allocation of struct tdg_sys_info on stack inside
	tdx_early_init() and pass down to tdg_get_sysinfo() to fill.
	(Kirill Shutemov)

V1 -> V2: 
	- Move the defination of field IDs and the struct tdg_sys_info to tdx.c.
	(Kuppuswamy Sathyanarayanan)


diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 2f27ae1e2c6b..66e020e3bb48 100644
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
@@ -800,6 +809,55 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return true;
 }
 
+/*
+ * Detect TDX Module version info from TDG.SYS.RD TDCALL
+ */
+static void detect_tdx_version(void)
+{
+	struct tdx_module_args args = {};
+	u16 major_version, minor_version;
+	u32 vendor_id;
+	u64 ret;
+
+	args.rdx = TDX_SYS_VENDOR_ID_FID;
+	ret = __tdcall_ret(TDG_SYS_RD, &args);
+	if (ret)
+		goto err_out;
+
+	vendor_id = args.r8;
+
+	memset(&args, 0, sizeof(args));
+	args.rdx = TDX_SYS_MAJOR_FID;
+	ret = __tdcall_ret(TDG_SYS_RD, &args);
+	if (ret)
+		goto err_out;
+
+	major_version = args.r8;
+
+	memset(&args, 0, sizeof(args));
+	args.rdx = TDX_SYS_MINOR_FID;
+	ret = __tdcall_ret(TDG_SYS_RD, &args);
+	if (ret)
+		goto err_out;
+
+	minor_version = args.r8;
+
+	pr_info("Guest detected. version:%u.%u VendorID:%x\n",
+		major_version, minor_version, vendor_id);
+
+	return;
+
+err_out:
+	if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+		pr_info("TDG.SYS.RD not available\n");
+	else
+		pr_info("TDG.SYS.RD unknown error (%llu), reading field %llu\n",
+			ret, args.rdx);
+
+	pr_info("Assuming TDX version:1.x (x<5) VendorID:%x\n",
+		TDX_VENDOR_INTEL);
+}
+
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -870,5 +928,5 @@ void __init tdx_early_init(void)
 	 */
 	x86_cpuinit.parallel_bringup = false;
 
-	pr_info("Guest detected\n");
+	detect_tdx_version();
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index f74695dea217..10b6c61e835e 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -17,6 +17,8 @@
 #define TDG_MR_REPORT			4
 #define TDG_MEM_PAGE_ACCEPT		6
 #define TDG_VM_WR			8
+/* The TDCALL TDG.SYS.RD originates from TDX version 1.5 */
+#define TDG_SYS_RD			11
 
 /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
-- 
2.34.1
