Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E67AA73B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 05:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjIVDHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 23:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVDHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 23:07:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F7E192
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 20:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695352026; x=1726888026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=md+zVUgWpFRtx1d5CvmHTbDkQvuQUPQT8p6Srus9Nvk=;
  b=L+rn77tC7jSWxl0uGvVnwOfdEUvP3L7U5eMv/3iR/o27yhlLDyXGf+lM
   ojPcNzmiDVKw03O3KMCn52dS5AyjKTZstyVWHuNTSFe3cw2pKz41yQ59y
   UoeMGN9J1JKf7LKbSeS+FKxtaT61clMrd1YScZG6TOY30JEBEG30esBRy
   LpkdZ0A53CLZl7/a6yvfQj9UIO0T8/Qu1avxF/TPdwSlkOnCvwzWGZpdu
   9mMHrmTwG3UOj8DoD/v8/TqQ5X5ZLtCMq4d9crTuyr6tzV7sF8l8FcsLj
   EmNvvS3XSqR50rwM3yu2cbiYgETxHPNVO7KZ+BMbXPZ9IOmpZSh0cr7Tw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="371049238"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="371049238"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 20:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="862768737"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="862768737"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2023 20:07:03 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     heng.su@intel.com, yi.sun@linux.intel.com,
        Yi Sun <yi.sun@intel.com>,
        Dongcheng Yan <dongcheng.yan@intel.com>
Subject: [PATCH v1] x86/tdx: Dump TDX version During the TD Bootup
Date:   Fri, 22 Sep 2023 11:06:48 +0800
Message-Id: <20230922030648.2596711-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is essential for TD users to be aware of the vendor and version of
the current TDX. Additionally, they can reference the TDX version when
reporting bugs or issues.

Furthermore, the applications or device drivers running in TD can achieve
enhanced reliability and flexibility by adhering to the TDX Module ABI
specification, as there are significant differences between various
versions of TDX.

During TD initialization, the TDX version info can be obtained by calling
TDG.SYS.RD. This will fetch the current version of TDX, including the major
and minor version numbers and vendor ID.

The TDCALL TDG.SYS.RD originates from TDX version 1.5. If the error
TDCALL_INVALID_OPERAND occurs, it should be treated as TDX version 1.0.

Co-developed-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..acf298ebbfd8 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -37,6 +37,9 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+/* Caches TDX Module global-scope metadata field via TDG.SYS.RD TDCALL */
+static struct tdg_sys_info td_sys_info;
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __tdx_hypercall_failed(void)
 {
@@ -757,6 +760,46 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return true;
 }
 
+/*
+ * Parse the tdx module version info from the global-scope metadata fields.
+ */
+static int tdg_get_sysinfo(void)
+{
+	struct tdx_module_output out;
+	u64 ret;
+
+	ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_VENDOR_ID_FID, 0, 0,
+				&out);
+	if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+		goto version_1_0;
+	else if (ret)
+		return ret;
+
+	td_sys_info.vendor_id = (u32)(out).r8;
+
+	ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_MAJOR_FID, 0, 0, &out);
+	if (ret)
+		return ret;
+
+	td_sys_info.major_version = (u16)(out).r8;
+
+	ret = __tdx_module_call(TDX_SYS_RD, 0, TDX_SYS_MINOR_FID, 0, 0, &out);
+	if (ret)
+		return ret;
+
+	td_sys_info.minor_version = (u16)(out).r8;
+
+	return 0;
+
+	/* TDX 1.0 does not have the TDCALL TDG.SYS.RD */
+version_1_0:
+	td_sys_info.vendor_id = 0x8086;
+	td_sys_info.major_version = 1;
+	td_sys_info.minor_version = 0;
+
+	return 0;
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -820,5 +863,9 @@ void __init tdx_early_init(void)
 	 */
 	x86_cpuinit.parallel_bringup = false;
 
-	pr_info("Guest detected\n");
+	tdg_get_sysinfo();
+
+	pr_info("Guest detected. TDX version:%u.%u VendorID: %x\n",
+		td_sys_info.major_version, td_sys_info.minor_version,
+		td_sys_info.vendor_id);
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 7513b3bb69b7..20ab96114970 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -16,6 +16,7 @@
 #define TDX_GET_REPORT			4
 #define TDX_ACCEPT_PAGE			6
 #define TDX_WR				8
+#define TDX_SYS_RD			11
 
 /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
@@ -26,6 +27,11 @@
 
 #ifndef __ASSEMBLY__
 
+/* TDX metadata base field id, used by TDCALL TDG.SYS.RD */
+#define TDX_SYS_VENDOR_ID_FID		0x0800000200000000ULL
+#define TDX_SYS_MINOR_FID		0x0800000100000003ULL
+#define TDX_SYS_MAJOR_FID		0x0800000100000004ULL
+
 /*
  * Used in __tdx_hypercall() to pass down and get back registers' values of
  * the TDCALL instruction when requesting services from the VMM.
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 603e6d1e9d4a..108409f24d59 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -40,6 +40,12 @@ struct ve_info {
 
 #ifdef CONFIG_INTEL_TDX_GUEST
 
+struct tdg_sys_info {
+	u32 vendor_id;
+	u16 major_version;
+	u16 minor_version;
+};
+
 void __init tdx_early_init(void);
 
 void tdx_get_ve_info(struct ve_info *ve);
-- 
2.34.1

