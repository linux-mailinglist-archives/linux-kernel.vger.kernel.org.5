Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC379C405
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjILDUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241850AbjILDPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:15:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694D7BE1C;
        Mon, 11 Sep 2023 18:49:51 -0700 (PDT)
Date:   Mon, 11 Sep 2023 23:23:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694474641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RKNzrKDbxp6SlnBJWYyLW20AScpNUCzY5NycfewQzU8=;
        b=T84vweB+R9x28If2gtHm/pUig49hiZyfrUG48s04aidCB5GWg+fE6WHgKXfvC+sl5svqdJ
        /UCbijN39KxYkIa4D83T1/JULWErvvtDa+PwMq1p/iQ0RO4u79yvJzhP6ynhkjJ7L06lUK
        j+FjvrkL0fMbnUueccvw6/1wLwPh+sB9QEYqXu1CQCFB908CdBmlhCqBRXQxjLxJ2BzLHB
        6CA5hH+mVROQMKyld+kie3zLRvmx7QKi70ivzUDK9r9pfWEr5ic6yCzsjcrAoMzVK6wXO0
        PrDAsdZ6B2OKzS/BdR1gcEN/9zmQ0mdJEu4JT2lqZU+ImCTgER/+nI7SF3E4eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694474641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RKNzrKDbxp6SlnBJWYyLW20AScpNUCzY5NycfewQzU8=;
        b=BMuE6VGZZh8pEvc7QfpQ6uaw3NoPXQkW9C91xu4FyIVlNpGM4lzB2gKhrXgtmuqQXBzRq0
        uITxsGU+lI6MUKCQ==
From:   "tip-bot2 for Dexuan Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Retry partially-completed page conversion hypercalls
Cc:     Dexuan Cui <decui@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169447463987.27769.8924490797849833894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     019b383d1132e4051de0d2e43254454b86538cf4
Gitweb:        https://git.kernel.org/tip/019b383d1132e4051de0d2e43254454b86538cf4
Author:        Dexuan Cui <decui@microsoft.com>
AuthorDate:    Thu, 10 Aug 2023 19:12:45 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Sep 2023 16:19:33 -07:00

x86/tdx: Retry partially-completed page conversion hypercalls

TDX guest memory is private by default and the VMM may not access it.
However, in cases where the guest needs to share data with the VMM,
the guest and the VMM can coordinate to make memory shared between
them.

The guest side of this protocol includes the "MapGPA" hypercall.  This
call takes a guest physical address range.  The hypercall spec (aka.
the GHCI) says that the MapGPA call is allowed to return partial
progress in mapping this range and indicate that fact with a special
error code.  A guest that sees such partial progress is expected to
retry the operation for the portion of the address range that was not
completed.

Hyper-V does this partial completion dance when set_memory_decrypted()
is called to "decrypt" swiotlb bounce buffers that can be up to 1GB
in size.  It is evidently the only VMM that does this, which is why
nobody noticed this until now.

[ dhansen: rewrite changelog ]

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20230811021246.821-2-decui%40microsoft.com
---
 arch/x86/coco/tdx/tdx.c           | 64 ++++++++++++++++++++++++------
 arch/x86/include/asm/shared/tdx.h |  2 +-
 2 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863..746075d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -703,14 +703,15 @@ static bool tdx_cache_flush_required(void)
 }
 
 /*
- * Inform the VMM of the guest's intent for this physical page: shared with
- * the VMM or private to the guest.  The VMM is expected to change its mapping
- * of the page in response.
+ * Notify the VMM about page mapping conversion. More info about ABI
+ * can be found in TDX Guest-Host-Communication Interface (GHCI),
+ * section "TDG.VP.VMCALL<MapGPA>".
  */
-static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	/* Retrying the hypercall a second time should succeed; use 3 just in case */
+	const int max_retries_per_page = 3;
+	int retry_count = 0;
 
 	if (!enc) {
 		/* Set the shared (decrypted) bits: */
@@ -718,12 +719,51 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		end   |= cc_mkdec(0);
 	}
 
-	/*
-	 * Notify the VMM about page mapping conversion. More info about ABI
-	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
-	 * section "TDG.VP.VMCALL<MapGPA>"
-	 */
-	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+	while (retry_count < max_retries_per_page) {
+		struct tdx_hypercall_args args = {
+			.r10 = TDX_HYPERCALL_STANDARD,
+			.r11 = TDVMCALL_MAP_GPA,
+			.r12 = start,
+			.r13 = end - start };
+
+		u64 map_fail_paddr;
+		u64 ret = __tdx_hypercall_ret(&args);
+
+		if (ret != TDVMCALL_STATUS_RETRY)
+			return !ret;
+		/*
+		 * The guest must retry the operation for the pages in the
+		 * region starting at the GPA specified in R11. R11 comes
+		 * from the untrusted VMM. Sanity check it.
+		 */
+		map_fail_paddr = args.r11;
+		if (map_fail_paddr < start || map_fail_paddr >= end)
+			return false;
+
+		/* "Consume" a retry without forward progress */
+		if (map_fail_paddr == start) {
+			retry_count++;
+			continue;
+		}
+
+		start = map_fail_paddr;
+		retry_count = 0;
+	}
+
+	return false;
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest.  The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (!tdx_map_gpa(start, end, enc))
 		return false;
 
 	/* shared->private conversion requires memory to be accepted before use */
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 7513b3b..22ee23a 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -24,6 +24,8 @@
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
 
+#define TDVMCALL_STATUS_RETRY		1
+
 #ifndef __ASSEMBLY__
 
 /*
