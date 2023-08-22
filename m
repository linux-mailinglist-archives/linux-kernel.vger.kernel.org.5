Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED578445E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbjHVOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbjHVOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E414CCA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692714693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHU6iKWanXrL3JWU9U/jjuWCG6VQHlMBWf5LyP3yyJQ=;
        b=bxCAmQTxhwc7T4uj0zecces/5Hhk+Kpf6bYFfahYLyWPXKLoMTl93rqDfkc5QNKOXPchgi
        hkRflYGDk0LfG2iCN7v2iFFLorjMSPULWthMwW+xyUYQ6irCXx24mQi4Lkvh6qeBhZJdv9
        mwgmZ324tzhYG6X4MgFh7xFfJrqOGEQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-iYLBnJlZN5e4VaH0hn_Uyg-1; Tue, 22 Aug 2023 10:31:31 -0400
X-MC-Unique: iYLBnJlZN5e4VaH0hn_Uyg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4059b5c3dd0so11587731cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714691; x=1693319491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHU6iKWanXrL3JWU9U/jjuWCG6VQHlMBWf5LyP3yyJQ=;
        b=P2rjwSywnGbu5o0Q4ylYL/C0jYgpQywshuq5ot/wF05YXfYgZhiEkjiJgFKDsEl9Y9
         6fozIXep+zoWq7VFNF0NPPbzq+1yqAChK8ptUXfe3Rm07zWqlDIN8f8Im+bvFltmpXhW
         bQS9GfU4VaivUtBmw9Y9Ejg5yJkPm0wkmVJYTwRhZ5OvrODtmhPKHh5FsIKr441jfPEQ
         RZHn6ShBewCsdEPZxupbpWEYdTGDhgJ0uoI0N4/c0DNcsvGelcs2puP/qD8zhwr/aDPH
         YesdNoSqz/iFftDVb725qAzH3gBOcGXBWXL04+be97kkRkMfdvmmQlhkxsJuUBSwns+I
         XWeg==
X-Gm-Message-State: AOJu0YxixzB32KV6j6XwBAZKqvD7EW9SLKWfY1fCL1+Q2SsNsxQVd2ET
        AxzG2GmkWqPGkwKCtkcLNPjvtqMhm3QnInUIp7M8QRWGwsXEf8v0bQE/KgP0EhIlaLjIk/mUR4e
        ihz9uTVo3Wi4iO7bzhoHHMC5K
X-Received: by 2002:a05:622a:309:b0:403:b395:b38e with SMTP id q9-20020a05622a030900b00403b395b38emr11725374qtw.2.1692714691336;
        Tue, 22 Aug 2023 07:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEDrFZmmOGoiw13xIqX9GTgknh8pZdmdD1gL5tuiszHwvGibdf+ny9PWf+EvJqXpP4fNvIlg==
X-Received: by 2002:a05:622a:309:b0:403:b395:b38e with SMTP id q9-20020a05622a030900b00403b395b38emr11725343qtw.2.1692714690938;
        Tue, 22 Aug 2023 07:31:30 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87108000000b0040331a24f16sm3099802qto.3.2023.08.22.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:31:30 -0700 (PDT)
Date:   Tue, 22 Aug 2023 10:31:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
Message-ID: <ZOTGvfO31pleXrPF@x1n>
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
 <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com>
 <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh, Jann,

On Mon, Aug 21, 2023 at 07:51:38PM -0700, Hugh Dickins wrote:
> On Mon, 21 Aug 2023, Jann Horn wrote:
> > On Mon, Aug 21, 2023 at 9:51 PM Hugh Dickins <hughd@google.com> wrote:
> > > Jann Horn demonstrated how userfaultfd ioctl UFFDIO_COPY into a private
> > > shmem mapping can add valid PTEs to page table collapse_pte_mapped_thp()
> > > thought it had emptied: page lock on the huge page is enough to protect
> > > against WP faults (which find the PTE has been cleared), but not enough
> > > to protect against userfaultfd.  "BUG: Bad rss-counter state" followed.
> > >
> > > retract_page_tables() protects against this by checking !vma->anon_vma;
> > > but we know that MADV_COLLAPSE needs to be able to work on private shmem
> > > mappings, even those with an anon_vma prepared for another part of the
> > > mapping; and we know that MADV_COLLAPSE needs to work on shared shmem
> > > mappings which are userfaultfd_armed().  Whether it needs to work on
> > > private shmem mappings which are userfaultfd_armed(), I'm not so sure:
> > > but assume that it does.
> > 
> > I think we couldn't rely on anon_vma here anyway, since holding the
> > mmap_lock in read mode doesn't prevent concurrent creation of an
> > anon_vma?
> 
> We would have had to do the same as in retract_page_tables() (which
> doesn't even have mmap_lock for read): recheck !vma->anon_vma after
> finally acquiring ptlock.  But the !anon_vma limitation is certainly
> not acceptable here anyway.
> 
> > 
> > > Just for this case, take the pmd_lock() two steps earlier: not because
> > > it gives any protection against this case itself, but because ptlock
> > > nests inside it, and it's the dropping of ptlock which let the bug in.
> > > In other cases, continue to minimize the pmd_lock() hold time.
> > 
> > Special-casing userfaultfd like this makes me a bit uncomfortable; but
> > I also can't find anything other than userfaultfd that would insert
> > pages into regions that are khugepaged-compatible, so I guess this
> > works?
> 
> I'm as sure as I can be that it's solely because userfaultfd breaks
> the usual rules here (and in fairness, IIRC Andrea did ask my permission
> before making it behave that way on shmem, COWing without a source page).
> 
> Perhaps something else will want that same behaviour in future (it's
> tempting, but difficult to guarantee correctness); for now, it is just
> userfaultfd (but by saying "_armed" rather than "_missing", I'm half-
> expecting uffd to add more such exceptional modes in future).
> 
> > 
> > I guess an alternative would be to use a spin_trylock() instead of the
> > current pmd_lock(), and if that fails, temporarily drop the page table
> > lock and then restart from step 2 with both locks held - and at that
> > point the page table scan should be fast since we expect it to usually
> > be empty.
> 
> That's certainly a good idea, if collapse on userfaultfd_armed private
> is anything of a common case (I doubt, but I don't know).  It may be a
> better idea anyway (saving a drop and retake of ptlock).
> 
> I gave it a try, expecting to end up with something that would lead
> me to say "I tried it, but it didn't work out well"; but actually it
> looks okay to me.  I wouldn't say I prefer it, but it seems reasonable,
> and no more complicated (as Peter rightly observes) than the original.
> 
> It's up to you and Peter, and whoever has strong feelings about it,
> to choose between them: I don't mind (but I shall be sad if someone
> demands that I indent that comment deeper - I'm not a fan of long
> multi-line comments near column 80).

No strong opinion here, either.  Just one trivial comment/question below on
the new patch (if that will be preferred)..

> 
> 
> [PATCH mm-unstable v2] mm/khugepaged: fix collapse_pte_mapped_thp() versus uffd
> 
> Jann Horn demonstrated how userfaultfd ioctl UFFDIO_COPY into a private
> shmem mapping can add valid PTEs to page table collapse_pte_mapped_thp()
> thought it had emptied: page lock on the huge page is enough to protect
> against WP faults (which find the PTE has been cleared), but not enough
> to protect against userfaultfd.  "BUG: Bad rss-counter state" followed.
> 
> retract_page_tables() protects against this by checking !vma->anon_vma;
> but we know that MADV_COLLAPSE needs to be able to work on private shmem
> mappings, even those with an anon_vma prepared for another part of the
> mapping; and we know that MADV_COLLAPSE needs to work on shared shmem
> mappings which are userfaultfd_armed().  Whether it needs to work on
> private shmem mappings which are userfaultfd_armed(), I'm not so sure:
> but assume that it does.
> 
> Now trylock pmd lock without dropping ptlock (suggested by jannh): if
> that fails, drop and retake ptlock around taking pmd lock, and just in
> the uffd private case, go back to recheck and empty the page table.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/linux-mm/CAG48ez0FxiRC4d3VTu_a9h=rg5FW-kYD5Rg5xo_RDBM0LTTqZQ@mail.gmail.com/
> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/khugepaged.c | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 40d43eccdee8..ad1c571772fe 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1476,7 +1476,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  	struct page *hpage;
>  	pte_t *start_pte, *pte;
>  	pmd_t *pmd, pgt_pmd;
> -	spinlock_t *pml, *ptl;
> +	spinlock_t *pml = NULL, *ptl;
>  	int nr_ptes = 0, result = SCAN_FAIL;
>  	int i;
>  
> @@ -1572,9 +1572,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  				haddr, haddr + HPAGE_PMD_SIZE);
>  	mmu_notifier_invalidate_range_start(&range);
>  	notified = true;
> -	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
> -	if (!start_pte)		/* mmap_lock + page lock should prevent this */
> -		goto abort;
> +	spin_lock(ptl);

.. here will the ptl always be valid?

That comes from the previous round of pte_offset_map_lock(), and I assume
after this whole "thp collapse without write lock" work landed, it has the
same lifecycle with the *pte pointer, so can be invalid right after the rcu
read lock released; mmap read lock isn't strong enough to protect the ptl,
not anymore.

Maybe it's all fine because the thp collapse path is the solo path(s) that
will release the pte pgtable page without write mmap lock (so as to release
the ptl too when doing so), and we at least still hold the page lock, so
the worst case is the other concurrent "thp collapse" will still serialize
with this one on the huge page lock. But that doesn't look as solid as
fetching again the ptl from another pte_offset_map_nolock().  So still just
raise this question up.  It's possible I just missed something.

> +recheck:
> +	start_pte = pte_offset_map(pmd, haddr);
> +	VM_BUG_ON(!start_pte);	/* mmap_lock + page lock should prevent this */
>  
>  	/* step 2: clear page table and adjust rmap */
>  	for (i = 0, addr = haddr, pte = start_pte;
> @@ -1608,20 +1609,36 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  		nr_ptes++;
>  	}
>  
> -	pte_unmap_unlock(start_pte, ptl);
> +	pte_unmap(start_pte);
>  
>  	/* step 3: set proper refcount and mm_counters. */
>  	if (nr_ptes) {
>  		page_ref_sub(hpage, nr_ptes);
>  		add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
> +		nr_ptes = 0;
>  	}
>  
> -	/* step 4: remove page table */
> +	/* step 4: remove empty page table */
> +	if (!pml) {
> +		pml = pmd_lockptr(mm, pmd);
> +		if (pml != ptl && !spin_trylock(pml)) {
> +			spin_unlock(ptl);
> +			spin_lock(pml);
> +			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +	/*
> +	 * pmd_lock covers a wider range than ptl, and (if split from mm's
> +	 * page_table_lock) ptl nests inside pml. The less time we hold pml,
> +	 * the better; but userfaultfd's mfill_atomic_pte() on a private VMA
> +	 * inserts a valid as-if-COWed PTE without even looking up page cache.
> +	 * So page lock of hpage does not protect from it, so we must not drop
> +	 * ptl before pgt_pmd is removed, so uffd private needs rechecking.
> +	 */
> +			if (userfaultfd_armed(vma) &&
> +			    !(vma->vm_flags & VM_SHARED))
> +				goto recheck;
> +		}
> +	}
>  
> -	/* Huge page lock is still held, so page table must remain empty */
> -	pml = pmd_lock(mm, pmd);
> -	if (ptl != pml)
> -		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>  	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
>  	pmdp_get_lockless_sync();
>  	if (ptl != pml)
> @@ -1648,6 +1665,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  	}
>  	if (start_pte)
>  		pte_unmap_unlock(start_pte, ptl);
> +	if (pml && pml != ptl)
> +		spin_unlock(pml);
>  	if (notified)
>  		mmu_notifier_invalidate_range_end(&range);
>  drop_hpage:
> -- 
> 2.35.3


-- 
Peter Xu

