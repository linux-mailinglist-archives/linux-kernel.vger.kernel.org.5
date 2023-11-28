Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B247FC144
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344468AbjK1QI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjK1QI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:08:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A91DA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701187711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=soyiTtP+gPlQ7bbuHvFbNVbbE3R/GLF0+Udhto1bAz0=;
        b=Y62MCe3y9WP0dj6AkU/wMsJagJyTc2oTPTZaudFr9ZqHY/GKoPTgMufpjUL3UKCnmWUMin
        fq1kkai27S3FlD5zirLOOFLVayUOp8YB0wCmRS34DB+MI2MNc3t7ME+urmV83oIvZcHJT0
        uDjVs0n5zOF9FTbh5ZpaiVyRylXnokw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-TizjiYd8NdWGOIo7wLGfzA-1; Tue, 28 Nov 2023 11:08:29 -0500
X-MC-Unique: TizjiYd8NdWGOIo7wLGfzA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67a24e9712aso9562046d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187708; x=1701792508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soyiTtP+gPlQ7bbuHvFbNVbbE3R/GLF0+Udhto1bAz0=;
        b=KztrQgZ7g47UKsfeDeYmNDi/EGL7IBSMC9faKAkL4IyVh0aho5BJwGXfn2CxSfwv0p
         AhQoUBxkYXSP/4/P/54F6U6ufclbj8mBc1PqVNQ4cgO40p+92h0mPBTwtTAP14YiAKJP
         DK1Kv5KnOFuh37KvMqAeSbXmeM8QavDwXhc2iDgnzmSLjueAT7mb9Nn2YaWIDthvLNwk
         8K5QyyoSFkLIx5IC+MS2rkCnqBumKEOM+7j5kddSU5IEbayEegNHgIU0okEW9+ljcsjv
         8rlSrm+MUi2Zm6K8iABurEnon+m/kUQdcq0BpsyLYKjCSEaj3bJFplntYjKfqXpUZWQ4
         xOHg==
X-Gm-Message-State: AOJu0Yy/3p5uWtGEHWtmNjx6/PV49hIR5LMnv9KKItkQwS4BAYzcF35L
        L9UQ9RAOCWLfK6wSnz2j9dcREYnFs+3T3QIkND8CTdzj8ONh76TJxxl4mG4mgegYgxIwJQgBinM
        PcLH9RwRc6gQJuJhBS2GDqcY1hWZDSJST
X-Received: by 2002:a05:6214:3018:b0:67a:8e0:bf28 with SMTP id ke24-20020a056214301800b0067a08e0bf28mr16757303qvb.3.1701187708084;
        Tue, 28 Nov 2023 08:08:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWn9jMOhnDF2ZZIcrQo8ekWA9To5I3Zb1UyODKnTrxbo30MQjzPmKMNb+UeJSmsZZSB4OYMw==
X-Received: by 2002:a05:6214:3018:b0:67a:8e0:bf28 with SMTP id ke24-20020a056214301800b0067a08e0bf28mr16757283qvb.3.1701187707742;
        Tue, 28 Nov 2023 08:08:27 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id a24-20020a0ca998000000b00677a12f11bcsm5234822qvb.24.2023.11.28.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:08:27 -0800 (PST)
Date:   Tue, 28 Nov 2023 11:08:25 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 2/5] mm/rmap: introduce and use hugetlb_remove_rmap()
Message-ID: <ZWYQeW1dqK6xM1T9@x1n>
References: <20231128145205.215026-1-david@redhat.com>
 <20231128145205.215026-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128145205.215026-3-david@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:52:02PM +0100, David Hildenbrand wrote:
> hugetlb rmap handling differs quite a lot from "ordinary" rmap code. We
> don't want this hugetlb special-casing in the rmap functions, as
> we're special casing the callers already. Let's simply use a separate
> function for hugetlb.

We were special casing some, not all..

And IIUC the suggestion from the community is we reduce that "special
casing", instead of adding more?  To be explicit below..

> 
> Let's introduce and use hugetlb_remove_rmap() and remove the hugetlb
> code from page_remove_rmap(). This effectively removes one check on the
> small-folio path as well.
> 
> While this is a cleanup, this will also make it easier to change rmap
> handling for partially-mappable folios.
> 
> Note: all possible candidates that need care are page_remove_rmap() that
>       pass compound=true.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/rmap.h |  5 +++++
>  mm/hugetlb.c         |  4 ++--
>  mm/rmap.c            | 17 ++++++++---------
>  3 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 4c5bfeb05463..e8d1dc1d5361 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -208,6 +208,11 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  
> +static inline void hugetlb_remove_rmap(struct folio *folio)
> +{
> +	atomic_dec(&folio->_entire_mapcount);
> +}
> +
>  static inline void __page_dup_rmap(struct page *page, bool compound)
>  {
>  	if (compound) {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4cfa0679661e..d17bb53b19ff 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5669,7 +5669,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  					make_pte_marker(PTE_MARKER_UFFD_WP),
>  					sz);
>  		hugetlb_count_sub(pages_per_huge_page(h), mm);
> -		page_remove_rmap(page, vma, true);
> +		hugetlb_remove_rmap(page_folio(page));
>  
>  		spin_unlock(ptl);
>  		tlb_remove_page_size(tlb, page, huge_page_size(h));
> @@ -5980,7 +5980,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  		/* Break COW or unshare */
>  		huge_ptep_clear_flush(vma, haddr, ptep);
> -		page_remove_rmap(&old_folio->page, vma, true);
> +		hugetlb_remove_rmap(old_folio);
>  		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
>  		if (huge_pte_uffd_wp(pte))
>  			newpte = huge_pte_mkuffd_wp(newpte);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 112467c30b2c..5037581b79ec 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1440,13 +1440,6 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  
>  	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  
> -	/* Hugetlb pages are not counted in NR_*MAPPED */
> -	if (unlikely(folio_test_hugetlb(folio))) {
> -		/* hugetlb pages are always mapped with pmds */
> -		atomic_dec(&folio->_entire_mapcount);
> -		return;
> -	}

Fundamentally in the ideal world when hugetlb can be merged into generic
mm, I'd imagine that as dropping here, meanwhile...

> -
>  	/* Is page being unmapped by PTE? Is this its last map to be removed? */
>  	if (likely(!compound)) {
>  		last = atomic_add_negative(-1, &page->_mapcount);
> @@ -1804,7 +1797,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			dec_mm_counter(mm, mm_counter_file(&folio->page));
>  		}
>  discard:
> -		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
> +		if (unlikely(folio_test_hugetlb(folio)))
> +			hugetlb_remove_rmap(folio);
> +		else
> +			page_remove_rmap(subpage, vma, false);

... rather than moving hugetlb_* handlings even upper the stack, we should
hopefully be able to keep this one as a generic api.

I worry this patch is adding more hugetlb-specific paths even onto higher
call stacks so it's harder to generalize, going the other way round to what
we wanted per previous discussions.

Said that, indeed I read mostly nothing yet with the recent rmap patches,
so I may miss some important goal here.

>  		if (vma->vm_flags & VM_LOCKED)
>  			mlock_drain_local();
>  		folio_put(folio);
> @@ -2157,7 +2153,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			 */
>  		}
>  
> -		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
> +		if (unlikely(folio_test_hugetlb(folio)))
> +			hugetlb_remove_rmap(folio);
> +		else
> +			page_remove_rmap(subpage, vma, false);
>  		if (vma->vm_flags & VM_LOCKED)
>  			mlock_drain_local();
>  		folio_put(folio);
> -- 
> 2.41.0
> 
> 

Thanks,

-- 
Peter Xu

