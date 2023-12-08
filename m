Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A465B80AA73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574270AbjLHRRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574273AbjLHRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2378310E7;
        Fri,  8 Dec 2023 09:17:26 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=F2XaGwrZXFvr39xXa9kaZq9mbS4+ABY0ts2Jt9DMH+Q=;
        b=L01Sri8Rq8e9BxSAZ962iJRUCTzhKlwSqCkJQGJ+ZSO/iWE7Pf8h6iB5vg1Gf1rqkfI8vz
        yd4FjH87aJjxQI/mFudOtfEIm9W6cWIBn2wkzVj3yVVznKf0ZSbYvcKVVsgNrTG44WqNKx
        bIswekzJn6+yeMC0LcphtFKGCA9/BFyE36wNX4y89ucHb9ADOr2IpZL0YA++iW+aRiiXlM
        IwCbODC75i8KuHK9H9rQmC7xWoxkjI54WPdtcG2TPj/4XrJJThi6CPNlVJgkUxaHrBnQht
        +K3onytF1ZfuuNDOT/5nXkIhflwdUwS7Nmh8n+jiUGSY0cubfq6bxMZ0kiofqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=F2XaGwrZXFvr39xXa9kaZq9mbS4+ABY0ts2Jt9DMH+Q=;
        b=3pmAbmjOrhfWVnlfyTfRct20YVdLVuBrILHHvJn7v8h6WUQYklGXcSrH8SxicY3LjvSRKS
        sJMyUoAExaFFgfCg==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Fill out TDMRs to cover all TDX memory regions
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yuan Yao <yuan.yao@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584411.398.4669234273253047441.tip-bot2@tip-bot2>
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

Commit-ID:     f3338ac15931075ef8b81145f5de128158a8dc8e
Gitweb:        https://git.kernel.org/tip/f3338ac15931075ef8b81145f5de128158a8dc8e
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:30 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:35 -08:00

x86/virt/tdx: Fill out TDMRs to cover all TDX memory regions

Start to transit out the "multi-steps" to construct a list of "TD Memory
Regions" (TDMRs) to cover all TDX-usable memory regions.

The kernel configures TDX-usable memory regions by passing a list of
TDMRs "TD Memory Regions" (TDMRs) to the TDX module.  Each TDMR contains
the information of the base/size of a memory region, the base/size of the
associated Physical Address Metadata Table (PAMT) and a list of reserved
areas in the region.

Do the first step to fill out a number of TDMRs to cover all TDX memory
regions.  To keep it simple, always try to use one TDMR for each memory
region.  As the first step only set up the base/size for each TDMR.

Each TDMR must be 1G aligned and the size must be in 1G granularity.
This implies that one TDMR could cover multiple memory regions.  If a
memory region spans the 1GB boundary and the former part is already
covered by the previous TDMR, just use a new TDMR for the remaining
part.

TDX only supports a limited number of TDMRs.  Disable TDX if all TDMRs
are consumed but there is more memory region to cover.

There are fancier things that could be done like trying to merge
adjacent TDMRs.  This would allow more pathological memory layouts to be
supported.  But, current systems are not even close to exhausting the
existing TDMR resources in practice.  For now, keep it simple.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Yuan Yao <yuan.yao@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-10-dave.hansen%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 103 ++++++++++++++++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h |   3 +-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index eeb7bf8..d7f9287 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -369,6 +369,102 @@ static void free_tdmr_list(struct tdmr_info_list *tdmr_list)
 			tdmr_list->max_tdmrs * tdmr_list->tdmr_sz);
 }
 
+/* Get the TDMR from the list at the given index. */
+static struct tdmr_info *tdmr_entry(struct tdmr_info_list *tdmr_list,
+				    int idx)
+{
+	int tdmr_info_offset = tdmr_list->tdmr_sz * idx;
+
+	return (void *)tdmr_list->tdmrs + tdmr_info_offset;
+}
+
+#define TDMR_ALIGNMENT		SZ_1G
+#define TDMR_ALIGN_DOWN(_addr)	ALIGN_DOWN((_addr), TDMR_ALIGNMENT)
+#define TDMR_ALIGN_UP(_addr)	ALIGN((_addr), TDMR_ALIGNMENT)
+
+static inline u64 tdmr_end(struct tdmr_info *tdmr)
+{
+	return tdmr->base + tdmr->size;
+}
+
+/*
+ * Take the memory referenced in @tmb_list and populate the
+ * preallocated @tdmr_list, following all the special alignment
+ * and size rules for TDMR.
+ */
+static int fill_out_tdmrs(struct list_head *tmb_list,
+			  struct tdmr_info_list *tdmr_list)
+{
+	struct tdx_memblock *tmb;
+	int tdmr_idx = 0;
+
+	/*
+	 * Loop over TDX memory regions and fill out TDMRs to cover them.
+	 * To keep it simple, always try to use one TDMR to cover one
+	 * memory region.
+	 *
+	 * In practice TDX supports at least 64 TDMRs.  A 2-socket system
+	 * typically only consumes less than 10 of those.  This code is
+	 * dumb and simple and may use more TMDRs than is strictly
+	 * required.
+	 */
+	list_for_each_entry(tmb, tmb_list, list) {
+		struct tdmr_info *tdmr = tdmr_entry(tdmr_list, tdmr_idx);
+		u64 start, end;
+
+		start = TDMR_ALIGN_DOWN(PFN_PHYS(tmb->start_pfn));
+		end   = TDMR_ALIGN_UP(PFN_PHYS(tmb->end_pfn));
+
+		/*
+		 * A valid size indicates the current TDMR has already
+		 * been filled out to cover the previous memory region(s).
+		 */
+		if (tdmr->size) {
+			/*
+			 * Loop to the next if the current memory region
+			 * has already been fully covered.
+			 */
+			if (end <= tdmr_end(tdmr))
+				continue;
+
+			/* Otherwise, skip the already covered part. */
+			if (start < tdmr_end(tdmr))
+				start = tdmr_end(tdmr);
+
+			/*
+			 * Create a new TDMR to cover the current memory
+			 * region, or the remaining part of it.
+			 */
+			tdmr_idx++;
+			if (tdmr_idx >= tdmr_list->max_tdmrs) {
+				pr_warn("initialization failed: TDMRs exhausted.\n");
+				return -ENOSPC;
+			}
+
+			tdmr = tdmr_entry(tdmr_list, tdmr_idx);
+		}
+
+		tdmr->base = start;
+		tdmr->size = end - start;
+	}
+
+	/* @tdmr_idx is always the index of the last valid TDMR. */
+	tdmr_list->nr_consumed_tdmrs = tdmr_idx + 1;
+
+	/*
+	 * Warn early that kernel is about to run out of TDMRs.
+	 *
+	 * This is an indication that TDMR allocation has to be
+	 * reworked to be smarter to not run into an issue.
+	 */
+	if (tdmr_list->max_tdmrs - tdmr_list->nr_consumed_tdmrs < TDMR_NR_WARN)
+		pr_warn("consumed TDMRs reaching limit: %d used out of %d\n",
+				tdmr_list->nr_consumed_tdmrs,
+				tdmr_list->max_tdmrs);
+
+	return 0;
+}
+
 /*
  * Construct a list of TDMRs on the preallocated space in @tdmr_list
  * to cover all TDX memory regions in @tmb_list based on the TDX module
@@ -378,10 +474,15 @@ static int construct_tdmrs(struct list_head *tmb_list,
 			   struct tdmr_info_list *tdmr_list,
 			   struct tdx_tdmr_sysinfo *tdmr_sysinfo)
 {
+	int ret;
+
+	ret = fill_out_tdmrs(tmb_list, tdmr_list);
+	if (ret)
+		return ret;
+
 	/*
 	 * TODO:
 	 *
-	 *  - Fill out TDMRs to cover all TDX memory regions.
 	 *  - Allocate and set up PAMTs for each TDMR.
 	 *  - Designate reserved areas for each TDMR.
 	 *
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 9b6b5d7..f18ce1b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -96,6 +96,9 @@ struct tdx_tdmr_sysinfo {
 	u16 pamt_entry_size[TDX_PS_NR];
 };
 
+/* Warn if kernel has less than TDMR_NR_WARN TDMRs after allocation */
+#define TDMR_NR_WARN 4
+
 struct tdmr_info_list {
 	void *tdmrs;	/* Flexible array to hold 'tdmr_info's */
 	int nr_consumed_tdmrs;	/* How many 'tdmr_info's are in use */
