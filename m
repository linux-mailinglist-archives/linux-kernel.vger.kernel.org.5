Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5767CD211
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjJRB6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJRB6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:58:43 -0400
Received: from out-190.mta1.migadu.com (out-190.mta1.migadu.com [IPv6:2001:41d0:203:375::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22649C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:58:41 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:58:24 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697594317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TtNdG5qwi8W/bQEJ73s/sZz1y//7quk4778GSvCx/FQ=;
        b=G45y4SRiY5MglF+fHzpy9Hizc1US199bCJce5SoSOLMcJZqTHrxY7fpp2dw5nv2ANBjyTy
        zaqbam+GWAiolwdvwntcuiLbFqDeosMefjbwE68fZ3pjKb/XNoRzshj2PlosslQMwgwS1f
        fjUk3KwU1B2GUy/czphYufIuiplUqxc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/11] hugetlb: set hugetlb page flag before
 optimizing vmemmap
Message-ID: <20231018015824.GA2942027@ik1-406-35019.vs.sakura.ne.jp>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-2-mike.kravetz@oracle.com>
 <20231013125856.GA636971@u2004>
 <20231017032140.GA3680@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017032140.GA3680@monkey>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:21:40PM -0700, Mike Kravetz wrote:
> On 10/13/23 21:58, Naoya Horiguchi wrote:
> > On Tue, Sep 05, 2023 at 02:44:00PM -0700, Mike Kravetz wrote:
> > > 
> > > Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
> > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > I saw that VM_WARN_ON_ONCE() in hugetlb_vmemmap_restore is triggered when
> > memory_failure() is called on a free hugetlb page with vmemmap optimization
> > disabled (the warning is not triggered if vmemmap optimization is enabled).
> > I think that we need check folio_test_hugetlb() before dissolve_free_huge_page()
> > calls hugetlb_vmemmap_restore_folio().
> > 
> > Could you consider adding some diff like below?
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2312,15 +2312,16 @@ int dissolve_free_huge_page(struct page *page)
> >  		 * Attempt to allocate vmemmmap here so that we can take
> >  		 * appropriate action on failure.
> >  		 */
> > -		rc = hugetlb_vmemmap_restore_folio(h, folio);
> > -		if (!rc) {
> > -			update_and_free_hugetlb_folio(h, folio, false);
> > -		} else {
> > -			spin_lock_irq(&hugetlb_lock);
> > -			add_hugetlb_folio(h, folio, false);
> > -			h->max_huge_pages++;
> > -			spin_unlock_irq(&hugetlb_lock);
> > +		if (folio_test_hugetlb(folio)) {
> > +			rc = hugetlb_vmemmap_restore_folio(h, folio);
> > +			if (rc) {
> > +				spin_lock_irq(&hugetlb_lock);
> > +				add_hugetlb_folio(h, folio, false);
> > +				h->max_huge_pages++;
> > +				goto out;
> > +			}
> >  		}
> > +		update_and_free_hugetlb_folio(h, folio, false);
> >  
> >  		return rc;
> >  	}
> > 
> 
> Hi Naoya,
> 
> I believe we need to set 'rc = 0' in the !folio_test_hugetlb().  I put
> together the following patch based on mm-stable.  Please take a look.

Hi Mike, the patch looks good to me, and I confirmed that my test programs
showed no new problem on latest mm-stable + this patch.

Thank you very much.
Naoya Horiguchi

> 
> From f19fbfab324d7d17de4a1e814f95ee655950c58e Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Mon, 16 Oct 2023 19:55:49 -0700
> Subject: [PATCH] hugetlb: check for hugetlb folio before vmemmap_restore
> 
> In commit d8f5f7e445f0 ("hugetlb: set hugetlb page flag before
> optimizing vmemmap") checks were added to print a warning if
> hugetlb_vmemmap_restore was called on a non-hugetlb page.  This
> was mostly due to ordering issues in the hugetlb page set up and
>  tear down sequencees.  One place missed was the routine
> dissolve_free_huge_page.  Naoya Horiguchi noted: "I saw that
> VM_WARN_ON_ONCE() in hugetlb_vmemmap_restore is triggered when
> memory_failure() is called on a free hugetlb page with vmemmap
> optimization disabled (the warning is not triggered if vmemmap
> optimization is enabled).  I think that we need check
> folio_test_hugetlb() before dissolve_free_huge_page() calls
> hugetlb_vmemmap_restore_folio()."
> 
> Perform the check as suggested by Naoya.
> 
> Fixes: d8f5f7e445f0 ("hugetlb: set hugetlb page flag before optimizing vmemmap")
> Suggested-by: Naoya Horiguchi <naoya.horiguchi@linux.dev>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 36b40bc9ac25..13736cbb2c19 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2290,17 +2290,23 @@ int dissolve_free_huge_page(struct page *page)
>  		 * need to adjust max_huge_pages if the page is not freed.
>  		 * Attempt to allocate vmemmmap here so that we can take
>  		 * appropriate action on failure.
> +		 *
> +		 * The folio_test_hugetlb check here is because
> +		 * remove_hugetlb_folio will clear hugetlb folio flag for
> +		 * non-vmemmap optimized hugetlb folios.
>  		 */
> -		rc = hugetlb_vmemmap_restore(h, &folio->page);
> -		if (!rc) {
> -			update_and_free_hugetlb_folio(h, folio, false);
> -		} else {
> -			spin_lock_irq(&hugetlb_lock);
> -			add_hugetlb_folio(h, folio, false);
> -			h->max_huge_pages++;
> -			spin_unlock_irq(&hugetlb_lock);
> -		}
> +		if (folio_test_hugetlb(folio)) {
> +			rc = hugetlb_vmemmap_restore(h, &folio->page);
> +			if (rc) {
> +				spin_lock_irq(&hugetlb_lock);
> +				add_hugetlb_folio(h, folio, false);
> +				h->max_huge_pages++;
> +				goto out;
> +			}
> +		} else
> +			rc = 0;
>  
> +		update_and_free_hugetlb_folio(h, folio, false);
>  		return rc;
>  	}
>  out:
> -- 
> 2.41.0
> 
