Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1B79C60F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjILFCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjILFBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:01:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506342689
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qlHiVdctGtE8cTlsZ7r3qTBiN24obLZ8NT3ZxV5GGjQ=; b=vj7EwTUMPFTFwzH6VKpURhlvd/
        Vd5J7FwM70o6dglSNIJFdcIZtRU2LLnbc8P/R4w41B8wno3LxIgnsuVSqbO8GMRmctTm5xKsXNx+U
        KihzX9nqgx2udqK1Ocgj5i0+EKEnvfFbhjmA407nNSj1y6nHZYEZlt9ixUQqjLa0gh5MI+uP/rKA3
        6+N+ZlcR6QdHfVLydtTv16GcTj2/7QpH3XwVgBVPq/NBfyaTTd37GxByeIPmDKdntf2elSt+Uh+GY
        scpFU7aND+pW1r/wMxtW50yiqeHQtr6xXADFKv0VPvuJBYeunbnog191MoaKHM+VwpNQI/piea3tN
        dNXsSlbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfvUj-005c9Y-MQ; Tue, 12 Sep 2023 04:59:25 +0000
Date:   Tue, 12 Sep 2023 05:59:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>,
        syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Message-ID: <ZP/wLVg1JCvhaEKm@casper.infradead.org>
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
 <ZP8VcUIXTjvR3z54@casper.infradead.org>
 <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
 <ZP9D0q5MSVFobNbZ@casper.infradead.org>
 <fb936bdb-6473-a956-8431-fe95f5940acc@intel.com>
 <ZP9mla26MWqKKUZ7@casper.infradead.org>
 <092a9bb2-727e-5849-fa4f-18535b998efc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <092a9bb2-727e-5849-fa4f-18535b998efc@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 01:22:51PM -0700, Dave Hansen wrote:
> On 9/11/23 12:12, Matthew Wilcox wrote:
> > On Mon, Sep 11, 2023 at 09:55:37AM -0700, Dave Hansen wrote:
> >> On 9/11/23 09:44, Matthew Wilcox wrote:
> >>> After fixing your two typos, this assembles to 176 bytes more code than
> >>> my version.  Not sure that's great.
> >> Maybe I'm a fool, but 176 bytes of text bloat isn't scaring me off too
> >> much.  I'd much rather have that than another window into x86 goofiness
> >> to maintain.
> >>
> >> Does that 176 bytes translate into meaningful performance, or is it just
> >> a bunch of register bit twiddling that the CPU will sail through?
> > I'm ... not sure how to tell.  It's 1120 bytes vs 944 bytes and crawling
> > through that much x86 assembly isn't my idea of a great time.  I can
> > send you objdump -dr for all three options if you like?  Maybe there's
> > a quick way to compare them that I've never known about.
> 
> Working patches would be great if you're got 'em handy, plus your
> .config and generally what compiler you're on.

gcc (Debian 13.2.0-2) 13.2.0

I don't think there's anything particularly strange about my .config

If you compile this patch as-is, you'll get your preferred code.
Remove the #define DH and you get mine.

I would say that 176 bytes is 3 cachelines of I$, which isn't free,
even if all the insns in it can be executed while the CPU is waiting
for cache misses.  This ought to be a pretty tight loop anyway; we're
just filling in adjacent PTEs.  There may not be many spare cycles
for "free" uops to execute.

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index d6ad98ca1288..c9781b8b14af 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -955,6 +955,14 @@ static inline int pte_same(pte_t a, pte_t b)
 	return a.pte == b.pte;
 }
 
+static inline pte_t pte_next(pte_t pte)
+{
+	if (__pte_needs_invert(pte_val(pte)))
+		return __pte(pte_val(pte) - (1UL << PFN_PTE_SHIFT));
+	return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+}
+#define pte_next	pte_next
+
 static inline int pte_present(pte_t a)
 {
 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1fba072b3dac..25333cf3c865 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -205,6 +205,10 @@ static inline int pmd_young(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
+#ifndef pte_next
+#define pte_next(pte)	((pte) + (1UL << PFN_PTE_SHIFT))
+#endif
+
 #ifndef set_ptes
 /**
  * set_ptes - Map consecutive pages to a contiguous range of addresses.
@@ -223,6 +227,11 @@ static inline int pmd_young(pmd_t pmd)
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pte, unsigned int nr)
 {
+#define DH
+#ifdef DH
+	pgprot_t prot = pte_pgprot(pte);
+	unsigned long pfn = pte_pfn(pte);
+#endif
 	page_table_check_ptes_set(mm, ptep, pte, nr);
 
 	arch_enter_lazy_mmu_mode();
@@ -231,7 +240,12 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+#ifdef DH
+		pfn++;
+		pte = pfn_pte(pfn, prot);
+#else
+		pte = pte_next(pte);
+#endif
 	}
 	arch_leave_lazy_mmu_mode();
 }
