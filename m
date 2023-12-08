Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340C80AA6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574436AbjLHRR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574187AbjLHRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F3E10E6;
        Fri,  8 Dec 2023 09:17:23 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AYK8JDa/3/4EaXRh0d/IVt4B6qp0E6G73A/t94skRCc=;
        b=0oIYRElkdby5tU/1BfZocijM6/KPblQvaObN54ID+YLew5Z8fAxjcMto/FAvCi+odvNdn8
        BEpGygTvunR/55PtJoviZi1A55BaAK43SusbSG0Gv6cd0FbMlyB/XCBQVMH+Cc8XE9cmFg
        4IzgBBxFy4wR5guawQBw751NA68JPzoY3F7G6UHxoahKPbZ55pC12Tc1F2Mrc1seW71dhD
        lSaueZDgQjgbJ1McT07h206/SvO9H1D1476MaxbmnTqAE8wo4fpl64ws0XvJA9SkRRGW03
        K/d5MvP6iBc7k0daMVuE6vBLNp23/Lm1LKNkfAg7+kOS3pZCNotPy8rV2JQO5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AYK8JDa/3/4EaXRh0d/IVt4B6qp0E6G73A/t94skRCc=;
        b=fwTcJv0iPhpGcRsuj99s5XeaFszU9sV1+/ltd4dXnL/XKYkOAAOWpUTXGzV7mwIhlhTmT6
        vk1lgTQUH0niePBg==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Configure TDX module with the TDMRs and
 global KeyID
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yuan Yao <yuan.yao@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584189.398.2713821707672808990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     554ce1c36d1bbeaec42ba870bad75e200af204be
Gitweb:        https://git.kernel.org/tip/554ce1c36d1bbeaec42ba870bad75e200af204be
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:33 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:41 -08:00

x86/virt/tdx: Configure TDX module with the TDMRs and global KeyID

The TDX module uses a private KeyID as the "global KeyID" for mapping
things like the PAMT and other TDX metadata.  This KeyID has already
been reserved when detecting TDX during the kernel early boot.

Now that the "TD Memory Regions" (TDMRs) are fully built, pass them to
the TDX module together with the global KeyID.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Yuan Yao <yuan.yao@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-13-dave.hansen%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 43 +++++++++++++++++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h |  2 ++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 98283f7..5146503 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -24,6 +24,8 @@
 #include <linux/pfn.h>
 #include <linux/align.h>
 #include <linux/sort.h>
+#include <linux/log2.h>
+#include <asm/page.h>
 #include <asm/msr-index.h>
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
@@ -892,6 +894,41 @@ static int construct_tdmrs(struct list_head *tmb_list,
 	return ret;
 }
 
+static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
+{
+	struct tdx_module_args args = {};
+	u64 *tdmr_pa_array;
+	size_t array_sz;
+	int i, ret;
+
+	/*
+	 * TDMRs are passed to the TDX module via an array of physical
+	 * addresses of each TDMR.  The array itself also has certain
+	 * alignment requirement.
+	 */
+	array_sz = tdmr_list->nr_consumed_tdmrs * sizeof(u64);
+	array_sz = roundup_pow_of_two(array_sz);
+	if (array_sz < TDMR_INFO_PA_ARRAY_ALIGNMENT)
+		array_sz = TDMR_INFO_PA_ARRAY_ALIGNMENT;
+
+	tdmr_pa_array = kzalloc(array_sz, GFP_KERNEL);
+	if (!tdmr_pa_array)
+		return -ENOMEM;
+
+	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++)
+		tdmr_pa_array[i] = __pa(tdmr_entry(tdmr_list, i));
+
+	args.rcx = __pa(tdmr_pa_array);
+	args.rdx = tdmr_list->nr_consumed_tdmrs;
+	args.r8 = global_keyid;
+	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
+
+	/* Free the array as it is not required anymore. */
+	kfree(tdmr_pa_array);
+
+	return ret;
+}
+
 static int init_tdx_module(void)
 {
 	struct tdx_tdmr_sysinfo tdmr_sysinfo;
@@ -927,10 +964,14 @@ static int init_tdx_module(void)
 	if (ret)
 		goto err_free_tdmrs;
 
+	/* Pass the TDMRs and the global KeyID to the TDX module */
+	ret = config_tdx_module(&tdx_tdmr_list, tdx_global_keyid);
+	if (ret)
+		goto err_free_pamts;
+
 	/*
 	 * TODO:
 	 *
-	 *  - Configure the TDMRs and the global KeyID to the TDX module.
 	 *  - Configure the global KeyID on all packages.
 	 *  - Initialize all TDMRs.
 	 *
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 1b04efe..fa5bcf8 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -17,6 +17,7 @@
 #define TDH_SYS_INIT		33
 #define TDH_SYS_RD		34
 #define TDH_SYS_LP_INIT		35
+#define TDH_SYS_CONFIG		45
 
 /*
  * Global scope metadata field ID.
@@ -53,6 +54,7 @@ struct tdmr_reserved_area {
 } __packed;
 
 #define TDMR_INFO_ALIGNMENT	512
+#define TDMR_INFO_PA_ARRAY_ALIGNMENT	512
 
 struct tdmr_info {
 	u64 base;
