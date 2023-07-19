Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A149975A275
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGSWtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGSWr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E591BF3;
        Wed, 19 Jul 2023 15:47:43 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lj2GlhiUyoqKwmt4HkZaHuIcZ+p6D1w5jcodKh47nQ0=;
        b=qG7X35RMdzwtyp/snhQeVERNqCwL1dnqCcxRiPWqWS6q6/dPI+GkWEp9ww7DIM+NTt0WyG
        wpNjPc3JZQxmsIvdzEr2LzIb74y9V+LtDfAvU+AkkZLPfT/fsEk3C5ssZB0yCoHCrReMKF
        7uMYjkDKYpM11Cr9uhY6a8G5RJUEEYw95Y5LntSZ/O0egplvoZZAQj5O4514vekBmqjAEf
        ZpTyxXyK0+4S/bOzZ/oiim41mBvNND1oOMy5OsycrPj+vPJxisV5OjXpQHyEYk8of2h50D
        W9YRcpnaGBIg6+q2F/CqIhWkuXtiR4REmNyZTrDsbiXlDS3n3sQWGtOXRg6luQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lj2GlhiUyoqKwmt4HkZaHuIcZ+p6D1w5jcodKh47nQ0=;
        b=WMfoe7LhqAqq2DnQbkeVPjODUXlCklywEOyrK9DvjnMWpSV2t7AsGwQiN5FIjxDYPDL9lM
        FiGc4cogO8KTDJDg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Introduce _PAGE_SAVED_DIRTY
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980685984.28540.7804300587316012917.tip-bot2@tip-bot2>
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

Commit-ID:     fca4d413c5f707b759d1031b170cbb8884f0999d
Gitweb:        https://git.kernel.org/tip/fca4d413c5f707b759d1031b170cbb8884f0999d
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:36 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:19 -07:00

x86/mm: Introduce _PAGE_SAVED_DIRTY

Some OSes have a greater dependence on software available bits in PTEs than
Linux. That left the hardware architects looking for a way to represent a
new memory type (shadow stack) within the existing bits. They chose to
repurpose a lightly-used state: Write=0,Dirty=1. So in order to support
shadow stack memory, Linux should avoid creating memory with this PTE bit
combination unless it intends for it to be shadow stack.

The reason it's lightly used is that Dirty=1 is normally set by HW
_before_ a write. A write with a Write=0 PTE would typically only generate
a fault, not set Dirty=1. Hardware can (rarely) both set Dirty=1 *and*
generate the fault, resulting in a Write=0,Dirty=1 PTE. Hardware which
supports shadow stacks will no longer exhibit this oddity.

So that leaves Write=0,Dirty=1 PTEs created in software. To avoid
inadvertently created shadow stack memory, in places where Linux normally
creates Write=0,Dirty=1, it can use the software-defined _PAGE_SAVED_DIRTY
in place of the hardware _PAGE_DIRTY. In other words, whenever Linux needs
to create Write=0,Dirty=1, it instead creates Write=0,SavedDirty=1 except
for shadow stack, which is Write=0,Dirty=1.

There are six bits left available to software in the 64-bit PTE after
consuming a bit for _PAGE_SAVED_DIRTY. For 32 bit, the same bit as
_PAGE_BIT_UFFD_WP is used, since user fault fd is not supported on 32
bit. This leaves one unused software bit on 32 bit (_PAGE_BIT_SOFT_DIRTY,
as this is also not supported on 32 bit).

Implement only the infrastructure for _PAGE_SAVED_DIRTY. Changes to
actually begin creating _PAGE_SAVED_DIRTY PTEs will follow once other
pieces are in place.

Since this SavedDirty shifting is done for all x86 CPUs, this leaves
the possibility for the hardware oddity to still create Write=0,Dirty=1
PTEs in rare cases. Since these CPUs also don't support shadow stack, this
will be harmless as it was before the introduction of SavedDirty.

Implement the shifting logic to be branchless. Embed the logic of whether
to do the shifting (including checking the Write bits) so that it can be
called by future callers that would otherwise need additional branching
logic. This efficiency allows the logic of when to do the shifting to be
centralized, making the code easier to reason about.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-11-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h       | 83 +++++++++++++++++++++++++++-
 arch/x86/include/asm/pgtable_types.h | 34 +++++++++--
 arch/x86/include/asm/tlbflush.h      |  3 +-
 3 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5f6e4ac..0c0747c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -302,6 +302,53 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+/*
+ * Write protection operations can result in Dirty=1,Write=0 PTEs. But in the
+ * case of X86_FEATURE_USER_SHSTK, these PTEs denote shadow stack memory. So
+ * when creating dirty, write-protected memory, a software bit is used:
+ * _PAGE_BIT_SAVED_DIRTY. The following functions take a PTE and transition the
+ * Dirty bit to SavedDirty, and vice-vesra.
+ *
+ * This shifting is only done if needed. In the case of shifting
+ * Dirty->SavedDirty, the condition is if the PTE is Write=0. In the case of
+ * shifting SavedDirty->Dirty, the condition is Write=1.
+ */
+static inline pgprotval_t mksaveddirty_shift(pgprotval_t v)
+{
+	pgprotval_t cond = (~v >> _PAGE_BIT_RW) & 1;
+
+	v |= ((v >> _PAGE_BIT_DIRTY) & cond) << _PAGE_BIT_SAVED_DIRTY;
+	v &= ~(cond << _PAGE_BIT_DIRTY);
+
+	return v;
+}
+
+static inline pgprotval_t clear_saveddirty_shift(pgprotval_t v)
+{
+	pgprotval_t cond = (v >> _PAGE_BIT_RW) & 1;
+
+	v |= ((v >> _PAGE_BIT_SAVED_DIRTY) & cond) << _PAGE_BIT_DIRTY;
+	v &= ~(cond << _PAGE_BIT_SAVED_DIRTY);
+
+	return v;
+}
+
+static inline pte_t pte_mksaveddirty(pte_t pte)
+{
+	pteval_t v = native_pte_val(pte);
+
+	v = mksaveddirty_shift(v);
+	return native_make_pte(v);
+}
+
+static inline pte_t pte_clear_saveddirty(pte_t pte)
+{
+	pteval_t v = native_pte_val(pte);
+
+	v = clear_saveddirty_shift(v);
+	return native_make_pte(v);
+}
+
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	return pte_clear_flags(pte, _PAGE_RW);
@@ -414,6 +461,24 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+/* See comments above mksaveddirty_shift() */
+static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
+{
+	pmdval_t v = native_pmd_val(pmd);
+
+	v = mksaveddirty_shift(v);
+	return native_make_pmd(v);
+}
+
+/* See comments above mksaveddirty_shift() */
+static inline pmd_t pmd_clear_saveddirty(pmd_t pmd)
+{
+	pmdval_t v = native_pmd_val(pmd);
+
+	v = clear_saveddirty_shift(v);
+	return native_make_pmd(v);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pmd_clear_flags(pmd, _PAGE_RW);
@@ -485,6 +550,24 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 	return native_make_pud(v & ~clear);
 }
 
+/* See comments above mksaveddirty_shift() */
+static inline pud_t pud_mksaveddirty(pud_t pud)
+{
+	pudval_t v = native_pud_val(pud);
+
+	v = mksaveddirty_shift(v);
+	return native_make_pud(v);
+}
+
+/* See comments above mksaveddirty_shift() */
+static inline pud_t pud_clear_saveddirty(pud_t pud)
+{
+	pudval_t v = native_pud_val(pud);
+
+	v = clear_saveddirty_shift(v);
+	return native_make_pud(v);
+}
+
 static inline pud_t pud_mkold(pud_t pud)
 {
 	return pud_clear_flags(pud, _PAGE_ACCESSED);
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index ba3e255..9379647 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -21,7 +21,8 @@
 #define _PAGE_BIT_SOFTW2	10	/* " */
 #define _PAGE_BIT_SOFTW3	11	/* " */
 #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
-#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
+#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
+#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
 #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
 #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
 #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
@@ -34,6 +35,13 @@
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
+#ifdef CONFIG_X86_64
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
+#else
+/* Shared with _PAGE_BIT_UFFD_WP which is not supported on 32 bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit */
+#endif
+
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
@@ -117,6 +125,18 @@
 #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * The hardware requires shadow stack to be Write=0,Dirty=1. However,
+ * there are valid cases where the kernel might create read-only PTEs that
+ * are dirty (e.g., fork(), mprotect(), uffd-wp(), soft-dirty tracking). In
+ * this case, the _PAGE_SAVED_DIRTY bit is used instead of the HW-dirty bit,
+ * to avoid creating a wrong "shadow stack" PTEs. Such PTEs have
+ * (Write=0,SavedDirty=1,Dirty=0) set.
+ */
+#define _PAGE_SAVED_DIRTY	(_AT(pteval_t, 1) << _PAGE_BIT_SAVED_DIRTY)
+
+#define _PAGE_DIRTY_BITS (_PAGE_DIRTY | _PAGE_SAVED_DIRTY)
+
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 /*
@@ -125,9 +145,9 @@
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
-			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |  \
+#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		     \
+			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY_BITS | \
+			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |	     \
 			 _PAGE_UFFD_WP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
@@ -188,10 +208,16 @@ enum page_cache_mode {
 
 #define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
+
+/*
+ * Page tables needs to have Write=1 in order for any lower PTEs to be
+ * writable. This includes shadow stack memory (Write=0, Dirty=1)
+ */
 #define _KERNPG_TABLE_NOENC	 (__PP|__RW|   0|___A|   0|___D|   0|   0)
 #define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
+
 #define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 80450e1..2deae4d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -286,7 +286,8 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
 	const pteval_t flush_on_clear = _PAGE_DIRTY | _PAGE_PRESENT |
 					_PAGE_ACCESSED;
 	const pteval_t software_flags = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
-					_PAGE_SOFTW3 | _PAGE_SOFTW4;
+					_PAGE_SOFTW3 | _PAGE_SOFTW4 |
+					_PAGE_SAVED_DIRTY;
 	const pteval_t flush_on_change = _PAGE_RW | _PAGE_USER | _PAGE_PWT |
 			  _PAGE_PCD | _PAGE_PSE | _PAGE_GLOBAL | _PAGE_PAT |
 			  _PAGE_PAT_LARGE | _PAGE_PKEY_BIT0 | _PAGE_PKEY_BIT1 |
