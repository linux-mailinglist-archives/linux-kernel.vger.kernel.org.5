Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F47B41FD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjI3QLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjI3QLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:11:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D1B9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696090311; x=1727626311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=54TB47Ve2g3NQfBdZ3OcMfBVNFAiDr22rl1oeSleK5o=;
  b=chN7zWoZ/5EPTfiSp5aWz6GgkJzSjFS5EqLZQS8tQ6KyAYSIQ5Preezq
   /OC3tLfkJc6uU0ZrWbPIk2LxSU7IgnfO7tWUzldbPyC65UqQFL0/sL6Pa
   POOofUuaxa9E5I30n1hl7ULHqc0Fh8S0BiygZgbqAjBPJGFpcFNHZOoJj
   reL0uDYIIXhB2v0dyasWWrQUX0MPDEsrFwERbrm03C2s0JkulKIMn6+OJ
   RSbmEtpoEVF160VOGPzlFCE5UkEG0uf9wNbgQf19e5J3/aZ27VCzkxzC/
   hj/5WXIqd5jTzpP1OcPi5eht+XmujcBh5IxaFkANf+9yYq19bOChfy7JK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="361840558"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="361840558"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 09:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="815869669"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="815869669"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2023 09:11:48 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     heng.su@intel.com, yi.sun@linux.intel.com,
        Yi Sun <yi.sun@intel.com>,
        Dongcheng Yan <dongcheng.yan@intel.com>
Subject: [PATCH v3] x86/tdx: Dump TDX version During the TD Bootup
Date:   Sun,  1 Oct 2023 00:11:10 +0800
Message-Id: <20230930161110.3251107-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Co-developed-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..052376d521d1 100644
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
 noinstr void __tdx_hypercall_failed(void)
 {
@@ -757,10 +775,54 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return true;
 }
 
+/*
+ * Parse the tdx module version info from the global-scope metadata fields.
+ */
+static int tdg_get_sysinfo(struct tdg_sys_info *td_sys)
+{
+	struct tdx_module_output out;
+	u64 ret;
+
+	if (!td_sys)
+		return -EINVAL;
+
+	ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_VENDOR_ID_FID, 0, 0,
+				&out);
+	if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+		goto version_1_0;
+	else if (ret)
+		return ret;
+
+	td_sys->vendor_id = (u32)out.r8;
+
+	ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_MAJOR_FID, 0, 0, &out);
+	if (ret)
+		return ret;
+
+	td_sys->major_version = (u16)out.r8;
+
+	ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_MINOR_FID, 0, 0, &out);
+	if (ret)
+		return ret;
+
+	td_sys->minor_version = (u16)out.r8;
+
+	return 0;
+
+	/* TDX 1.0 does not have the TDCALL TDG.SYS.RD */
+version_1_0:
+	td_sys->vendor_id = TDX_VENDOR_INTEL;
+	td_sys->major_version = 1;
+	td_sys->minor_version = 0;
+
+	return 0;
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
 	u32 eax, sig[3];
+	struct tdg_sys_info td_sys_info;
 
 	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
 
@@ -820,5 +882,9 @@ void __init tdx_early_init(void)
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
index 7513b3bb69b7..10ecb5dece84 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -16,6 +16,7 @@
 #define TDX_GET_REPORT			4
 #define TDX_ACCEPT_PAGE			6
 #define TDX_WR				8
+#define TDX_SYS_RD			11
 
 /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
-- 
2.34.1

