Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362C87634D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjGZL0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjGZL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:26:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2E2689
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690370761; x=1721906761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k9oROdILzd+iAfn2LHZf2F4VtQKvvgvPEAtqzujmFHQ=;
  b=DKTEFuSxvKEQftvI85ZM4j6UKL8M60NEhMs+REMH+oNL6h/GSHigD8Yy
   2rybelFweHIHjuMPjLYYsszQljwYUg7KAaZZvXy4umT5V/D6Chq0pL//C
   g+T6urToBb1v6SfVofagApNnaTGHCAjj+QBilXNuyOFohvkqTd4Xbtbc+
   qaJvKx/c41qs5dMk/K87ouXgubZWUIQevcE32KVlSAWI4nQoYaWf0Tf1x
   7nfZUeKyK3neohl7jgc14qKHgu9MqoKyRmHpx+tZlE4yVms7nMsCB63+k
   FSwQ7tMdTcgdS9nCAiZcRfs66xCM0RcFOjvCxvRS2GB/EDHc1VbELHGJf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370663910"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="370663910"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791810953"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="791810953"
Received: from bterry-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.177.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:25:57 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v3 03/12] x86/tdx: Make macros of TDCALLs consistent with the spec
Date:   Wed, 26 Jul 2023 23:25:05 +1200
Message-ID: <b3f5a25e72094a11add22e1a7c5dda3ea91d0e98.1690369495.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690369495.git.kai.huang@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
---

v2 -> v3:
 - No change.

v1 -> v2:
 - Rebase to 6.5-rc2.

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

