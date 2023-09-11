Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C281679B1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378856AbjIKWhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbjIKN0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:26:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8EA193
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wP2szp+jTJIKevwc9pquiJB7kq4tgwrIrdBfL9KhesI=; b=lrewdIRIPHPn8jO9o3Fn8lvuCP
        yr2rJ8jaFXmcwzxMr992lqRtIAzooIp9PpHQkm7XHNcpaKrqwKRcU+iHuK5LqPANbUwCaALX4lCC0
        Ibei47n8NhtoBox7CLCEjdgzKpUt93Y/lNyfbRjES32NgaTh621eDQlAsHYa+etoEwhqkiEXYyFS8
        tVSwqM/7WRZcfoE5c57p9ZLacVT6c8ZuLzE4Y+LI6xU2RwAnSBgwH+DSrMuPp0+hy0QmR+7z9BMcC
        mWTMASMYPcG3U1UxbEXaTltDZAcVkIy3qyqFB9GEKegemZhww1KqvZ5iLIi+lMfksZ3Cqo0BritQ2
        lZMsNzkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfgvZ-001AmI-Ky; Mon, 11 Sep 2023 13:26:09 +0000
Date:   Mon, 11 Sep 2023 14:26:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Message-ID: <ZP8VcUIXTjvR3z54@casper.infradead.org>
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:12:27PM +0800, Yin Fengwei wrote:
>  
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +               pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +       bool protnone = (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
> +                       == _PAGE_PROTNONE;
> +
> +       page_table_check_ptes_set(mm, ptep, pte, nr);
> +
> +       for(;;) {
> +               native_set_pte(ptep, pte);
> +               if (--nr == 0)
> +                       break;
> +
> +               ptep++;
> +               if (protnone)
> +                       pte = __pte(pte_val(pte) - (1UL << PFN_PTE_SHIFT));
> +               else
> +                       pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> +       }
> +}
> +#define set_ptes set_ptes

Thanks for figuring this out.  I don't think I would have been able to!

I think this solution probably breaks pgtable-2level configs,
unfortunately.  How about this?  If other architectures decide to adopt
the inverted page table entry in the future, it'll work for them too.

#syz test

diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index e9482a11ac52..a89be3e9b032 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -123,9 +123,6 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask)
 	return val;
 }
 
-static inline bool __pte_needs_invert(u64 val)
-{
-	return false;
-}
+#define __pte_needs_invert(val)	false
 
 #endif /* _ASM_X86_PGTABLE_2LEVEL_H */
diff --git a/arch/x86/include/asm/pgtable-invert.h b/arch/x86/include/asm/pgtable-invert.h
index a0c1525f1b6f..f21726add655 100644
--- a/arch/x86/include/asm/pgtable-invert.h
+++ b/arch/x86/include/asm/pgtable-invert.h
@@ -17,6 +17,7 @@ static inline bool __pte_needs_invert(u64 val)
 {
 	return val && !(val & _PAGE_PRESENT);
 }
+#define __pte_needs_invert __pte_needs_invert
 
 /* Get a mask to xor with the page table entry to get the correct pfn. */
 static inline u64 protnone_mask(u64 val)
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1fba072b3dac..34b12e94b850 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -205,6 +205,10 @@ static inline int pmd_young(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
+#ifndef __pte_needs_invert
+#define __pte_needs_invert(pte)	false
+#endif
+
 #ifndef set_ptes
 /**
  * set_ptes - Map consecutive pages to a contiguous range of addresses.
@@ -231,7 +235,10 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+		if (__pte_needs_invert(pte_val(pte)))
+			pte = __pte(pte_val(pte) - (1UL << PFN_PTE_SHIFT));
+		else
+			pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
 	}
 	arch_leave_lazy_mmu_mode();
 }
