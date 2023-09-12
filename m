Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7855B79D4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbjILPcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjILPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:32:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F277E10DE;
        Tue, 12 Sep 2023 08:32:05 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:32:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694532724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nXzA2RSxP3eRTGwf5iBxLFu6JQd7RKnjE6KyKDGTsBc=;
        b=tzNSINMmWpiMhQZNnBS7kN5cYNvcME3RiRYIA2/SQ4PcHr/+DJ/xNvMKHZHzBYbqhO5FGO
        av2vUJ7HIExP0fcF18Im/JRnInnx1naYx6cjbs9VZgRq+iNetA1aeSUIQuRAIIE5vsYHN1
        RAi5ig72AmMqP3rOHVwGE/wdZu2qdoCbQbfYEOTwA3d5RVDB6d7q2CCrtx7GqhB5Ov2iN5
        lMfAftVmlJ+I9Jfrl1N0RoSnPuSSsO57XRYh4Xh+dSA0SzZMXLrNfmO5tLlVoqODjslokz
        S2ASTmCHHrjQ+ZjD9tYMD8gSLezsM6EA06zPuiJ3tYnHm/aZjkp+Awnmw3QiQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694532724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nXzA2RSxP3eRTGwf5iBxLFu6JQd7RKnjE6KyKDGTsBc=;
        b=L/E1tFIuv5q008dwksO8o32G3/eNW9uOQKC6O7S736HpRP80dqO8J52XcTg4+maXP1ebnv
        Ws00n68Y3A6eFSAA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Make macros of TDCALLs consistent with the spec
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169453272405.27769.13975117331414363362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     f0024dbfc48d8814d915eb5bd5253496b9b8a6df
Gitweb:        https://git.kernel.org/tip/f0024dbfc48d8814d915eb5bd5253496b9b8a6df
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:01:57 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Sep 2023 16:33:16 -07:00

x86/tdx: Make macros of TDCALLs consistent with the spec

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/516dccd0bd8fb9a0b6af30d25bb2d971aa03d598.1692096753.git.kai.huang%40intel.com
---
 arch/x86/coco/tdx/tdx-shared.c    |  4 ++--
 arch/x86/coco/tdx/tdx.c           |  8 ++++----
 arch/x86/include/asm/shared/tdx.h | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index ef20ddc..f10cd3e 100644
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
index 746075d..dd16bf1 100644
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
@@ -814,7 +814,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdx_module_call(TDX_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+	tdx_module_call(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 22ee23a..05874a5 100644
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
