Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECBF75A26E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGSWtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGSWrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ABC2703;
        Wed, 19 Jul 2023 15:47:42 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NjE9B+nzQu8pouAo4v5duSCj1r9uS4+mal7ymvz1xfo=;
        b=D/m3w797e1gBYN8m9WJYv9dfkTe3nu+NM2gUR1S2Vz2NRtlGC22AUQvZ884y48JIYc37M9
        N7RP8LA5NFfasTfbkeElWXXSq8rl6iUisD8/3CHaUN5Bs60C9LDwM+pf/5k0PxtxSfU4sk
        C3y1zbq114cRLGbYUQml4x9l2bvOSw0uxJAcEqhEmo8KESAEfMrMUWQkIJCU+oSJtmzSc7
        wfOMFK2lnge1reTEQD28Nv2tKM5Jnn3vkdMpmNQOxKPd/iAQU7Dh+17p9UyDfjxIG871s9
        7RkS8ol2vPhokDjz6xcc+IidNqGLd5ozWZ6VtHdmCkrbwiYonr3KArYr5WAiqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NjE9B+nzQu8pouAo4v5duSCj1r9uS4+mal7ymvz1xfo=;
        b=eKHxMK1VgJVCuwOtlqZRRRTdo5jYdFWl9aQjY4FQitYNa5sBKATVhFdjDA/pAtZnozHqJP
        johi4c/1e6/hyIAQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Move pmd_write(), pud_write() up in the file
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980686029.28540.10685579278645068504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     a956efc09b106173c6c85da7e3bb6e0f452a5681
Gitweb:        https://git.kernel.org/tip/a956efc09b106173c6c85da7e3bb6e0f452a5681
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:35 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:19 -07:00

x86/mm: Move pmd_write(), pud_write() up in the file

To prepare the introduction of _PAGE_SAVED_DIRTY, move pmd_write() and
pud_write() up in the file, so that they can be used by other
helpers below.  No functional changes.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-10-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0aa295c..5f6e4ac 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -161,6 +161,18 @@ static inline int pte_write(pte_t pte)
 	return pte_flags(pte) & _PAGE_RW;
 }
 
+#define pmd_write pmd_write
+static inline int pmd_write(pmd_t pmd)
+{
+	return pmd_flags(pmd) & _PAGE_RW;
+}
+
+#define pud_write pud_write
+static inline int pud_write(pud_t pud)
+{
+	return pud_flags(pud) & _PAGE_RW;
+}
+
 static inline int pte_huge(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_PSE;
@@ -1121,12 +1133,6 @@ extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
 				  unsigned long address, pmd_t *pmdp);
 
 
-#define pmd_write pmd_write
-static inline int pmd_write(pmd_t pmd)
-{
-	return pmd_flags(pmd) & _PAGE_RW;
-}
-
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pmd_t *pmdp)
@@ -1156,12 +1162,6 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
 }
 
-#define pud_write pud_write
-static inline int pud_write(pud_t pud)
-{
-	return pud_flags(pud) & _PAGE_RW;
-}
-
 #ifndef pmdp_establish
 #define pmdp_establish pmdp_establish
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
