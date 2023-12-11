Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8AE80D1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjLKQ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjLKQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:29:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDB5D99
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:30:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DDFE1007;
        Mon, 11 Dec 2023 08:30:48 -0800 (PST)
Received: from [10.57.73.30] (unknown [10.57.73.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2028F3F738;
        Mon, 11 Dec 2023 08:30:00 -0800 (PST)
Message-ID: <cf04016d-8f50-4733-a399-5925603a2682@arm.com>
Date:   Mon, 11 Dec 2023 16:29:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/39] mm/rmap: add hugetlb sanity checks
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-7-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-7-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 15:56, David Hildenbrand wrote:
> Let's make sure we end up with the right folios in the right functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/rmap.h | 7 +++++++
>  mm/rmap.c            | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 4c0650e9f6db..e3857d26b944 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -217,6 +217,7 @@ void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
>  		struct vm_area_struct *vma)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  
>  	if (PageAnonExclusive(&folio->page)) {
> @@ -231,6 +232,7 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
>  /* See page_try_share_anon_rmap() */
>  static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  	VM_WARN_ON_FOLIO(!PageAnonExclusive(&folio->page), folio);
>  
> @@ -253,6 +255,7 @@ static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
>  
>  static inline void hugetlb_add_file_rmap(struct folio *folio)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>  
>  	atomic_inc(&folio->_entire_mapcount);
> @@ -260,11 +263,15 @@ static inline void hugetlb_add_file_rmap(struct folio *folio)
>  
>  static inline void hugetlb_remove_rmap(struct folio *folio)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
> +
>  	atomic_dec(&folio->_entire_mapcount);
>  }
>  
>  static inline void __page_dup_rmap(struct page *page, bool compound)
>  {
> +	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
> +
>  	if (compound) {
>  		struct folio *folio = (struct folio *)page;
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index e210ac1b73de..41597da14f26 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1343,6 +1343,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  {
>  	int nr = folio_nr_pages(folio);
>  
> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>  	VM_BUG_ON_VMA(address < vma->vm_start ||
>  			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>  	__folio_set_swapbacked(folio);
> @@ -1395,6 +1396,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  	unsigned int nr_pmdmapped = 0, first;
>  	int nr = 0;
>  
> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
> @@ -1480,6 +1482,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  	bool last;
>  	enum node_stat_item idx;
>  
> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>  	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  
>  	/* Is page being unmapped by PTE? Is this its last map to be removed? */
> @@ -2632,6 +2635,7 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
>  void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  		unsigned long address, rmap_t flags)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>  	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  
>  	atomic_inc(&folio->_entire_mapcount);
> @@ -2644,6 +2648,8 @@ void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  void hugetlb_add_new_anon_rmap(struct folio *folio,
>  		struct vm_area_struct *vma, unsigned long address)
>  {
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
> +
>  	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
>  	/* increment count (starts at -1) */
>  	atomic_set(&folio->_entire_mapcount, 0);

