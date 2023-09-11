Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4251579B972
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjIKUtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243016AbjIKQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:44:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A4DE3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2N6m3edx41I1Oh1oh7HMzFAU2bfARAGawMSwEvl7fi4=; b=SFVp0Mdno32el6ma82vBvL/xlC
        lhnIZ2+Trvr6TOiYjp1PgmFfEjR/KpLm1Nc5//pAj1Pa/3d6aLp6SlkqfyBkRuraON7I2PgJEzJsX
        PmYUFcG629//wnDlS11P/Yn9B2Uy33SX556njw9p0t9gn+NUY1kPqEc/k5JkgTgsxNVst4UIhgdSQ
        533JXN+cJVvwjxLel/vgmAxge9u0LIxEkThaJ9rq2uvewv5jfirMu74cheMbZGyfMj2SqK+LRcXba
        RBGwa8rRKYSnju4txdboo/tcAqpdNiOJs8sF8CFF7/L9P+fGd5H39rFvNItxVFyZ3UsqDgUf93QfV
        ZtQPnP9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfk14-00212a-Jm; Mon, 11 Sep 2023 16:44:02 +0000
Date:   Mon, 11 Sep 2023 17:44:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>,
        syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Message-ID: <ZP9D0q5MSVFobNbZ@casper.infradead.org>
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
 <ZP8VcUIXTjvR3z54@casper.infradead.org>
 <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 08:34:57AM -0700, Dave Hansen wrote:
> On 9/11/23 06:26, Matthew Wilcox wrote:
> > @@ -231,7 +235,10 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> >  		if (--nr == 0)
> >  			break;
> >  		ptep++;
> > -		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> > +		if (__pte_needs_invert(pte_val(pte)))
> > +			pte = __pte(pte_val(pte) - (1UL << PFN_PTE_SHIFT));
> > +		else
> > +			pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> >  	}
> >  	arch_leave_lazy_mmu_mode();
> >  }
> 
> This is much better than a whole x86 fork of set_ptes().  But it's still
> a bit wonky because it exposes the PTE inversion logic to generic code.

I saw that as an advantage ... let people know that it exists as a
concept.

> static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>                 pte_t *ptep, pte_t pte, unsigned int nr)
> {
> 	pgprot_t prot = pte_pgprot(x);
> 	unsigned long pfn = pte_pfn(pte);
> 
>         page_table_check_ptes_set(mm, ptep, pte, nr);
> 
>         arch_enter_lazy_mmu_mode();
>         for (;;) {
>                 set_pte(ptep, pte);
>                 if (--nr == 0)
>                         break;
>                 ptep++;
> 		pfn++;
>                 pte = pfn_pte(pfn, pgprot);
>         }
>         arch_leave_lazy_mmu_mode();
> }
> 
> Obviously completely untested. :)

After fixing your two typos, this assembles to 176 bytes more code than
my version.  Not sure that's great.

How about this?  Keeps the inverted knowledge entirely in arch/x86.
Compiles to exactly the same code as the version I sent earlier.

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
index 1fba072b3dac..7a932ed59c27 100644
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
@@ -231,7 +235,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+		pte = pte_next(pte);
 	}
 	arch_leave_lazy_mmu_mode();
 }
