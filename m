Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812C177CB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjHOLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjHOLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:02:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C182B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692097349; x=1723633349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IZ+alnXDfOwrRUZWMFGFpUzYn1twgi8bthwccjxvN8A=;
  b=EcVxtNfA5toyRO16SYnpF2iNLsduwOQ4s54vNyxjJIvfY707mHg0K8fS
   Nz4252JW+CQTBegIKGead/PTlWn4uBYtliu92tvHOTg9AvhA1WqCunUYU
   LKXhJ2u24LYOlNZfvI89pVgJgWGY6SR590WlD6dP4I9+gjCiSKFN9JiwV
   bzT+KGkCvw0oRI02/U5ZacJrMlCgPxHQyAtNOfNhoi70qosQB7Bw0Zz3Z
   PMqhJQlsFcW0GW/INawcoGSgPWs8+lKluNFuxGxt0bgPC9ch7O9St0dFY
   ELKEHgZZ9RIlYTzXEq9JNHCt0wXQOeMaCit2TrB87wS3zMnCKW6TIAO0Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436148279"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436148279"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763236122"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763236122"
Received: from fwafula-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.73.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:25 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v4 03/12] x86/tdx: Make macros of TDCALLs consistent with the spec
Date:   Tue, 15 Aug 2023 23:01:57 +1200
Message-ID: <516dccd0bd8fb9a0b6af30d25bb2d971aa03d598.1692096753.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692096753.git.kai.huang@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TDX spec names all TDCALLs with prefix "TDG".  Currently, the kernel
doesn't follow such convention for the macros of those TDCALLs but uses
prefix "TDX_" for all of them.  Although it's arguable whether the TDX
spec names those TDCALLs properly, it's better for the kernel to follow
the spec when naming those macros.

Change all macros of TDCALLs to make them consistent with the spec.  As
a bonus, they get distinguished easily from the host-side SEAMCALLs,
which all have prefix "TDH".

No functional change intended.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx-shared.c    |  4 ++--
 arch/x86/coco/tdx/tdx.c           |  8 ++++----
 arch/x86/include/asm/shared/tdx.h | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index ef20ddc37b58..f10cd3e4a04e 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -35,7 +35,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 	}
 
 	tdcall_rcx = start | page_size;
-	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
+	if (__tdx_module_call(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
 		return 0;
 
 	return accept_size;
@@ -45,7 +45,7 @@ bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/*
 	 * For shared->private conversion, accept the page using
-	 * TDX_ACCEPT_PAGE TDX module call.
+	 * TDG_MEM_PAGE_ACCEPT TDX module call.
 	 */
 	while (start < end) {
 		unsigned long len = end - start;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..05785df66b1c 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -91,7 +91,7 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 {
 	u64 ret;
 
-	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
+	ret = __tdx_module_call(TDG_MR_REPORT, virt_to_phys(tdreport),
 				virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
 				0, NULL);
 	if (ret) {
@@ -152,7 +152,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
 	 * [TDG.VP.INFO].
 	 */
-	tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
+	tdx_module_call(TDG_VP_INFO, 0, 0, 0, 0, &out);
 
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
@@ -594,7 +594,7 @@ void tdx_get_ve_info(struct ve_info *ve)
 	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
 	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
 	 */
-	tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);
+	tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
 
 	/* Transfer the output parameters */
 	ve->exit_reason = out.rcx;
@@ -774,7 +774,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdx_module_call(TDX_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+	tdx_module_call(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 7513b3bb69b7..78f109446da6 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -11,11 +11,11 @@
 #define TDX_IDENT		"IntelTDX    "
 
 /* TDX module Call Leaf IDs */
-#define TDX_GET_INFO			1
-#define TDX_GET_VEINFO			3
-#define TDX_GET_REPORT			4
-#define TDX_ACCEPT_PAGE			6
-#define TDX_WR				8
+#define TDG_VP_INFO			1
+#define TDG_VP_VEINFO_GET		3
+#define TDG_MR_REPORT			4
+#define TDG_MEM_PAGE_ACCEPT		6
+#define TDG_VM_WR			8
 
 /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
-- 
2.41.0

