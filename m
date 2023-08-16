Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B3377ECBA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346746AbjHPWGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242448AbjHPWFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:05:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DC826AD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UyMlVsySCN0Jx6lE67WHs7khNsl6mnl5e8ThdgyztOo=; b=XOhFJl2tl49bvGiQbffIoFYh5+
        f8d7k5GtYOyYGA7dQO3uQKmJO8PqBNhRsZ/yEIUfdVRS793BMTxduCnkdTsU6BqHxwXTdMvQ8Nl+J
        +1KbxsgGvxlxTHvk+tmv64CZ7U0PpP/8qL4gXp96p0bA2rfCWRcFwK30Pfl/J4lBG45Egno/FmJ+Q
        LxX249DsWmItd9LcUYCXNEpBfIl2J5WH9M/vg7Thr/SAg2M+h4BUoI1N9YN6HDs9Vxo/TNf9EKEAK
        9zmKL5bYbmhp2ZLUu/CzuMF6D2SmLvIU2F69FKrsm1Sm8EwGlJAztn7rfA/mKn4AZqqh5ZGRFqpwC
        j54F1cbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWOdj-00H9lF-Cu; Wed, 16 Aug 2023 22:05:19 +0000
Date:   Wed, 16 Aug 2023 23:05:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH RFC v3] mm: Proper document tail pages fields for folio
Message-ID: <ZN1IH/8JxkkOU5Ec@casper.infradead.org>
References: <20230815212547.431693-1-peterx@redhat.com>
 <b887e764-ffa3-55ee-3c44-69cb15f8a115@redhat.com>
 <ZN0YSOQmSR/voPVO@casper.infradead.org>
 <ae8ea59e-3081-072b-faa0-b67a5d5af047@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8ea59e-3081-072b-faa0-b67a5d5af047@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:51:49PM +0200, David Hildenbrand wrote:
> On 16.08.23 20:41, Matthew Wilcox wrote:
> > On Wed, Aug 16, 2023 at 03:33:30PM +0200, David Hildenbrand wrote:
> > > My simple tests passed so far. If there isn't something obvious missing,
> > > I can do more testing and send this as an official patch.
> > 
> > I think you missed one:
> > 
> > +++ b/mm/swapfile.c
> > @@ -1490,7 +1490,7 @@ int swp_swapcount(swp_entry_t entry)
> > 
> >          page = vmalloc_to_page(p->swap_map + offset);
> >          offset &= ~PAGE_MASK;
> > -       VM_BUG_ON(page_private(page) != SWP_CONTINUED);
> > +       VM_BUG_ON(page_swap_entry(page).val != SWP_CONTINUED);
> 
> That falls under the "weird handling of SWP_CONTINUED using vmalloced
> pages". So different user of page_private().
> 
> Note that we don't even store swap entries in there but extended swap
> counts.

Ah, right.  I see now.


Not necessarily as part of this patch, but it got me wondering ...
should we do this?  And then maybe we could remove folio_swap_entry()
and folio_set_swap_entry() and just use folio->swap directly.


diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3880b3f2e321..e23d1356e504 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -266,6 +266,14 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
 	return (struct page *)(~ENCODE_PAGE_BITS & (unsigned long)page);
 }
 
+/*
+ * A swap entry has to fit into a "unsigned long", as the entry is hidden
+ * in the "index" field of the swapper address space.
+ */
+typedef struct {
+	unsigned long val;
+} swp_entry_t;
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
@@ -276,7 +284,7 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
  * @index: Offset within the file, in units of pages.  For anonymous memory,
  *    this is the index from the beginning of the mmap.
  * @private: Filesystem per-folio data (see folio_attach_private()).
- *    Used for swp_entry_t if folio_test_swapcache().
+ * @swap: Used for swp_entry_t if folio_test_swapcache().
  * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
  *    find out how many times this folio is mapped by userspace.
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
@@ -319,7 +327,10 @@ struct folio {
 			};
 			struct address_space *mapping;
 			pgoff_t index;
-			void *private;
+			union {
+				void *private;
+				swp_entry_t swap;
+			};
 			atomic_t _mapcount;
 			atomic_t _refcount;
 #ifdef CONFIG_MEMCG
@@ -1158,14 +1169,6 @@ enum tlb_flush_reason {
 	NR_TLB_FLUSH_REASONS,
 };
 
- /*
-  * A swap entry has to fit into a "unsigned long", as the entry is hidden
-  * in the "index" field of the swapper address space.
-  */
-typedef struct {
-	unsigned long val;
-} swp_entry_t;
-
 /**
  * enum fault_flag - Fault flag definitions.
  * @FAULT_FLAG_WRITE: Fault was a write fault.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index bb5adc604144..59b0f37eae5b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -335,13 +335,12 @@ struct swap_info_struct {
 
 static inline swp_entry_t folio_swap_entry(struct folio *folio)
 {
-	swp_entry_t entry = { .val = page_private(&folio->page) };
-	return entry;
+	return folio->swap;
 }
 
 static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
 {
-	folio->private = (void *)entry.val;
+	folio->swap = entry;
 }
 
 /* linux/mm/workingset.c */
