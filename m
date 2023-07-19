Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8560C75A27C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGSWuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGSWsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9348C272D;
        Wed, 19 Jul 2023 15:47:46 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fyfTt34v1IYISmEvRy8fesWha5NZ7aSUFzM58/9GUqc=;
        b=NsvDMAMy2YBsNzaZRp59FCd7a+43liUttxrmeh82BL4Qr+4ooXIDbtT7jvSo7xjHy6vVgn
        MqbyEgXAZrdxfFFE0vWwUrEqx9GZThXN+XnOqHjmndbp3vE/vZYldnG+OrfD8I+KrwdULX
        uMongAhSsQXzqB5OigFFm4FLGMIiqMUfT5V8JetgeoQxXua47sqwd5+4kLyNyJRUbcAYIV
        QFaTXnnKKTzdyT/TndMJpuGR7/e+xtsksFIkey4dcvUnQsqpZLAWugx8SaUTu2PZEiLrml
        fjfli9zcolUU0NqIOpid0mvKfzl1w62D7iat/62y2nlGs3ufC87aZW1gJNKVBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fyfTt34v1IYISmEvRy8fesWha5NZ7aSUFzM58/9GUqc=;
        b=xbFDEyu2PxLhjusT5CGywCytTeTPyH0i4lhvytQBtV43sRC293/+V28u+FEUmqayBUq3FV
        w4LQo3k9iTGnS8BA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980686397.28540.8623862885690529767.tip-bot2@tip-bot2>
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

Commit-ID:     2f0584f3f4bd60bcc8735172981fb0bff86e74e0
Gitweb:        https://git.kernel.org/tip/2f0584f3f4bd60bcc8735172981fb0bff86e74e0
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:27 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:10:56 -07:00

mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()

The x86 Shadow stack feature includes a new type of memory called shadow
stack. This shadow stack memory has some unusual properties, which requires
some core mm changes to function properly.

One of these unusual properties is that shadow stack memory is writable,
but only in limited ways. These limits are applied via a specific PTE
bit combination. Nevertheless, the memory is writable, and core mm code
will need to apply the writable permissions in the typical paths that
call pte_mkwrite(). The goal is to make pte_mkwrite() take a VMA, so
that the x86 implementation of it can know whether to create regular
writable or shadow stack mappings.

But there are a couple of challenges to this. Modifying the signatures of
each arch pte_mkwrite() implementation would be error prone because some
are generated with macros and would need to be re-implemented. Also, some
pte_mkwrite() callers operate on kernel memory without a VMA.

So this can be done in a three step process. First pte_mkwrite() can be
renamed to pte_mkwrite_novma() in each arch, with a generic pte_mkwrite()
added that just calls pte_mkwrite_novma(). Next callers without a VMA can
be moved to pte_mkwrite_novma(). And lastly, pte_mkwrite() and all callers
can be changed to take/pass a VMA.

Start the process by renaming pte_mkwrite() to pte_mkwrite_novma() and
adding the pte_mkwrite() wrapper in linux/pgtable.h. Apply the same
pattern for pmd_mkwrite(). Since not all archs have a pmd_mkwrite_novma(),
create a new arch config HAS_HUGE_PAGE that can be used to tell if
pmd_mkwrite() should be defined. Otherwise in the !HAS_HUGE_PAGE cases the
compiler would not be able to find pmd_mkwrite_novma().

No functional change.

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/lkml/CAHk-=wiZjSu7c9sFYZb3q04108stgHff2wfbokGCCgW7riz+8Q@mail.gmail.com/
Link: https://lore.kernel.org/all/20230613001108.3040476-2-rick.p.edgecombe%40intel.com
---
 Documentation/mm/arch_pgtable_helpers.rst    |  6 ++++++
 arch/Kconfig                                 |  8 ++++++++
 arch/alpha/include/asm/pgtable.h             |  2 +-
 arch/arc/include/asm/hugepage.h              |  2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h    |  2 +-
 arch/arm/include/asm/pgtable-3level.h        |  2 +-
 arch/arm/include/asm/pgtable.h               |  2 +-
 arch/arm64/include/asm/pgtable.h             |  4 ++--
 arch/csky/include/asm/pgtable.h              |  2 +-
 arch/hexagon/include/asm/pgtable.h           |  2 +-
 arch/ia64/include/asm/pgtable.h              |  2 +-
 arch/loongarch/include/asm/pgtable.h         |  4 ++--
 arch/m68k/include/asm/mcf_pgtable.h          |  2 +-
 arch/m68k/include/asm/motorola_pgtable.h     |  2 +-
 arch/m68k/include/asm/sun3_pgtable.h         |  2 +-
 arch/microblaze/include/asm/pgtable.h        |  2 +-
 arch/mips/include/asm/pgtable.h              |  6 +++---
 arch/nios2/include/asm/pgtable.h             |  2 +-
 arch/openrisc/include/asm/pgtable.h          |  2 +-
 arch/parisc/include/asm/pgtable.h            |  2 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++--
 arch/powerpc/include/asm/nohash/32/pgtable.h |  4 ++--
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  4 ++--
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
 arch/riscv/include/asm/pgtable.h             |  6 +++---
 arch/s390/Kconfig                            |  1 +
 arch/s390/include/asm/hugetlb.h              |  2 +-
 arch/s390/include/asm/pgtable.h              |  4 ++--
 arch/sh/include/asm/pgtable_32.h             |  4 ++--
 arch/sparc/include/asm/pgtable_32.h          |  2 +-
 arch/sparc/include/asm/pgtable_64.h          |  6 +++---
 arch/um/include/asm/pgtable.h                |  2 +-
 arch/x86/include/asm/pgtable.h               |  4 ++--
 arch/xtensa/include/asm/pgtable.h            |  2 +-
 include/asm-generic/hugetlb.h                |  2 +-
 include/linux/pgtable.h                      | 14 ++++++++++++++
 37 files changed, 76 insertions(+), 47 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index af3891f..69ce1f2 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -48,6 +48,9 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_mkwrite               | Creates a writable PTE                           |
 +---------------------------+--------------------------------------------------+
+| pte_mkwrite_novma         | Creates a writable PTE, of the conventional type |
+|                           | of writable.                                     |
++---------------------------+--------------------------------------------------+
 | pte_wrprotect             | Creates a write protected PTE                    |
 +---------------------------+--------------------------------------------------+
 | pte_mkspecial             | Creates a special PTE                            |
@@ -120,6 +123,9 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_mkwrite               | Creates a writable PMD                           |
 +---------------------------+--------------------------------------------------+
+| pmd_mkwrite_novma         | Creates a writable PMD, of the conventional type |
+|                           | of writable.                                     |
++---------------------------+--------------------------------------------------+
 | pmd_wrprotect             | Creates a write protected PMD                    |
 +---------------------------+--------------------------------------------------+
 | pmd_mkspecial             | Creates a special PMD                            |
diff --git a/arch/Kconfig b/arch/Kconfig
index aff2746..cde7983 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -939,6 +939,14 @@ config HAVE_ARCH_HUGE_VMALLOC
 config ARCH_WANT_HUGE_PMD_SHARE
 	bool
 
+# Archs that want to use pmd_mkwrite on kernel memory need it defined even
+# if there are no userspace memory management features that use it
+config ARCH_WANT_KERNEL_PMD_MKWRITE
+	bool
+
+config ARCH_WANT_PMD_MKWRITE
+	def_bool TRANSPARENT_HUGEPAGE || ARCH_WANT_KERNEL_PMD_MKWRITE
+
 config HAVE_ARCH_SOFT_DIRTY
 	bool
 
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index ba43cb8..af1a13a 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -256,7 +256,7 @@ extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; 
 extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_FOW; return pte; }
 extern inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~(__DIRTY_BITS); return pte; }
 extern inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~(__ACCESS_BITS); return pte; }
-extern inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &= ~_PAGE_FOW; return pte; }
+extern inline pte_t pte_mkwrite_novma(pte_t pte){ pte_val(pte) &= ~_PAGE_FOW; return pte; }
 extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= __DIRTY_BITS; return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; return pte; }
 
diff --git a/arch/arc/include/asm/hugepage.h b/arch/arc/include/asm/hugepage.h
index 5001b79..ef8d416 100644
--- a/arch/arc/include/asm/hugepage.h
+++ b/arch/arc/include/asm/hugepage.h
@@ -21,7 +21,7 @@ static inline pmd_t pte_pmd(pte_t pte)
 }
 
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkwrite_novma(pmd)	pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index 6e9f8ca..5c073d9 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -87,7 +87,7 @@
 
 PTE_BIT_FUNC(mknotpresent,     &= ~(_PAGE_PRESENT));
 PTE_BIT_FUNC(wrprotect,	&= ~(_PAGE_WRITE));
-PTE_BIT_FUNC(mkwrite,	|= (_PAGE_WRITE));
+PTE_BIT_FUNC(mkwrite_novma,	|= (_PAGE_WRITE));
 PTE_BIT_FUNC(mkclean,	&= ~(_PAGE_DIRTY));
 PTE_BIT_FUNC(mkdirty,	|= (_PAGE_DIRTY));
 PTE_BIT_FUNC(mkold,	&= ~(_PAGE_ACCESSED));
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 1060497..71c3add 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -202,7 +202,7 @@ static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
 
 PMD_BIT_FUNC(wrprotect,	|= L_PMD_SECT_RDONLY);
 PMD_BIT_FUNC(mkold,	&= ~PMD_SECT_AF);
-PMD_BIT_FUNC(mkwrite,   &= ~L_PMD_SECT_RDONLY);
+PMD_BIT_FUNC(mkwrite_novma,   &= ~L_PMD_SECT_RDONLY);
 PMD_BIT_FUNC(mkdirty,   |= L_PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkclean,   &= ~L_PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 34662a9..d88dd54 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -227,7 +227,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return set_pte_bit(pte, __pgprot(L_PTE_RDONLY));
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return clear_pte_bit(pte, __pgprot(L_PTE_RDONLY));
 }
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0bd18de..7a3d62c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -180,7 +180,7 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
 	return pmd;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
 	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
@@ -487,7 +487,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkwrite_novma(pmd)	pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)))
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index d404249..aa0cce4 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -176,7 +176,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	if (pte_val(pte) & _PAGE_MODIFIED)
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 5939361..fc2d2d8 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -300,7 +300,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 }
 
 /* pte_mkwrite - mark page as writable */
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	return pte;
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 21c97e3..f80aba7 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -268,7 +268,7 @@ ia64_phys_addr_valid (unsigned long addr)
  * access rights:
  */
 #define pte_wrprotect(pte)	(__pte(pte_val(pte) & ~_PAGE_AR_RW))
-#define pte_mkwrite(pte)	(__pte(pte_val(pte) | _PAGE_AR_RW))
+#define pte_mkwrite_novma(pte)	(__pte(pte_val(pte) | _PAGE_AR_RW))
 #define pte_mkold(pte)		(__pte(pte_val(pte) & ~_PAGE_A))
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_A))
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 38afeb7..e8e10d0 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -390,7 +390,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	if (pte_val(pte) & _PAGE_MODIFIED)
@@ -490,7 +490,7 @@ static inline int pmd_write(pmd_t pmd)
 	return !!(pmd_val(pmd) & _PAGE_WRITE);
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	pmd_val(pmd) |= _PAGE_WRITE;
 	if (pmd_val(pmd) & _PAGE_MODIFIED)
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 43e8da8..6cd022f 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -210,7 +210,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |= CF_PAGE_WRITABLE;
 	return pte;
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index ec0dc19..ba28ca4 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -155,7 +155,7 @@ static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; 
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_RONLY; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &= ~_PAGE_RONLY; return pte; }
+static inline pte_t pte_mkwrite_novma(pte_t pte){ pte_val(pte) &= ~_PAGE_RONLY; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mknocache(pte_t pte)
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index 9e7bf8a..b60723b 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -143,7 +143,7 @@ static inline int pte_young(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESS
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_WRITEABLE; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_MODIFIED; return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_WRITEABLE; return pte; }
+static inline pte_t pte_mkwrite_novma(pte_t pte){ pte_val(pte) |= SUN3_PAGE_WRITEABLE; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_MODIFIED; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mknocache(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_NOCACHE; return pte; }
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index d1b8272..9108b33 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -266,7 +266,7 @@ static inline pte_t pte_mkread(pte_t pte) \
 	{ pte_val(pte) |= _PAGE_USER; return pte; }
 static inline pte_t pte_mkexec(pte_t pte) \
 	{ pte_val(pte) |= _PAGE_USER | _PAGE_EXEC; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte) \
+static inline pte_t pte_mkwrite_novma(pte_t pte) \
 	{ pte_val(pte) |= _PAGE_RW; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte) \
 	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 574fa14..40a54fd 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -309,7 +309,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte.pte_low |= _PAGE_WRITE;
 	if (pte.pte_low & _PAGE_MODIFIED) {
@@ -364,7 +364,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	if (pte_val(pte) & _PAGE_MODIFIED)
@@ -627,7 +627,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return pmd;
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	pmd_val(pmd) |= _PAGE_WRITE;
 	if (pmd_val(pmd) & _PAGE_MODIFIED)
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 0f5c256..cf1ffbc 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -129,7 +129,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	return pte;
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 3eb9b95..828820c 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -250,7 +250,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	return pte;
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 5656395..5f4dfe9 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -331,7 +331,7 @@ static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~_PAGE_ACCESSED; retu
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~_PAGE_WRITE; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= _PAGE_WRITE; return pte; }
+static inline pte_t pte_mkwrite_novma(pte_t pte)	{ pte_val(pte) |= _PAGE_WRITE; return pte; }
 static inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |= _PAGE_SPECIAL; return pte; }
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 7bf1fe7..67dfb67 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -498,7 +498,7 @@ static inline pte_t pte_mkpte(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 4acc969..0328d91 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -600,7 +600,7 @@ static inline pte_t pte_mkexec(pte_t pte)
 	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_EXEC));
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	/*
 	 * write implies read, hence set both
@@ -1071,7 +1071,7 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkwrite_novma(pmd)	pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)))
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index fec56d9..33213b3 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -170,8 +170,8 @@ void unmap_kernel_page(unsigned long va);
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(mm, addr, ptep, ~0, 0, 0); } while (0)
 
-#ifndef pte_mkwrite
-static inline pte_t pte_mkwrite(pte_t pte)
+#ifndef pte_mkwrite_novma
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1a89ebd..21f681e 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -101,12 +101,12 @@ static inline int pte_write(pte_t pte)
 
 #define pte_write pte_write
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_RO);
 }
 
-#define pte_mkwrite pte_mkwrite
+#define pte_mkwrite_novma pte_mkwrite_novma
 
 static inline bool pte_user(pte_t pte)
 {
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 287e258..abe4fd8 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -85,7 +85,7 @@
 #ifndef __ASSEMBLY__
 /* pte_clear moved to later in this file */
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 75970ee..d2b9901 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -378,7 +378,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
@@ -664,9 +664,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
-	return pte_pmd(pte_mkwrite(pmd_pte(pmd)));
+	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5b39918..91514d5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -128,6 +128,7 @@ config S390
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_OPTIMIZE_VMEMMAP
+	select ARCH_WANT_KERNEL_PMD_MKWRITE
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
 	select DMA_OPS if PCI
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index ccdbccf..f072678 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -104,7 +104,7 @@ static inline int huge_pte_dirty(pte_t pte)
 
 static inline pte_t huge_pte_mkwrite(pte_t pte)
 {
-	return pte_mkwrite(pte);
+	return pte_mkwrite_novma(pte);
 }
 
 static inline pte_t huge_pte_mkdirty(pte_t pte)
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index c55f3c3..83c5da3 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1002,7 +1002,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return set_pte_bit(pte, __pgprot(_PAGE_PROTECT));
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(_PAGE_WRITE));
 	if (pte_val(pte) & _PAGE_DIRTY)
@@ -1485,7 +1485,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_PROTECT));
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	pmd = set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_WRITE));
 	if (pmd_val(pmd) & _SEGMENT_ENTRY_DIRTY)
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 21952b0..165b4fd 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -359,11 +359,11 @@ static inline pte_t pte_##fn(pte_t pte) { pte.pte_##h op; return pte; }
  * kernel permissions), we attempt to couple them a bit more sanely here.
  */
 PTE_BIT_FUNC(high, wrprotect, &= ~(_PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE));
-PTE_BIT_FUNC(high, mkwrite, |= _PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE);
+PTE_BIT_FUNC(high, mkwrite_novma, |= _PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE);
 PTE_BIT_FUNC(high, mkhuge, |= _PAGE_SZHUGE);
 #else
 PTE_BIT_FUNC(low, wrprotect, &= ~_PAGE_RW);
-PTE_BIT_FUNC(low, mkwrite, |= _PAGE_RW);
+PTE_BIT_FUNC(low, mkwrite_novma, |= _PAGE_RW);
 PTE_BIT_FUNC(low, mkhuge, |= _PAGE_SZHUGE);
 #endif
 
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index d4330e3..a2d9094 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -241,7 +241,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~SRMMU_REF);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | SRMMU_WRITE);
 }
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 5563efa..4dd4f6c 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -517,7 +517,7 @@ static inline pte_t pte_mkclean(pte_t pte)
 	return __pte(val);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	unsigned long val = pte_val(pte), mask;
 
@@ -772,11 +772,11 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return __pmd(pte_val(pte));
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
 
-	pte = pte_mkwrite(pte);
+	pte = pte_mkwrite_novma(pte);
 
 	return __pmd(pte_val(pte));
 }
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index a70d161..46f59a8 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -207,7 +207,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return(pte);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	if (unlikely(pte_get_bits(pte,  _PAGE_RW)))
 		return pte;
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5700bb3..0aa295c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -353,7 +353,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte_set_flags(pte, _PAGE_ACCESSED);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return pte_set_flags(pte, _PAGE_RW);
 }
@@ -454,7 +454,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_ACCESSED);
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_RW);
 }
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index fc7a148..27e3ae3 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -262,7 +262,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)
 	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 	{ pte_val(pte) |= _PAGE_WRITABLE; return pte; }
 
 #define pgprot_noncached(prot) \
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index d7f6335..4da0279 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -22,7 +22,7 @@ static inline unsigned long huge_pte_dirty(pte_t pte)
 
 static inline pte_t huge_pte_mkwrite(pte_t pte)
 {
-	return pte_mkwrite(pte);
+	return pte_mkwrite_novma(pte);
 }
 
 #ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5063b48..e6ea6e0 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -515,6 +515,20 @@ extern pud_t pudp_huge_clear_flush(struct vm_area_struct *vma,
 			      pud_t *pudp);
 #endif
 
+#ifndef pte_mkwrite
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return pte_mkwrite_novma(pte);
+}
+#endif
+
+#if defined(CONFIG_ARCH_WANT_PMD_MKWRITE) && !defined(pmd_mkwrite)
+static inline pmd_t pmd_mkwrite(pmd_t pmd)
+{
+	return pmd_mkwrite_novma(pmd);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
