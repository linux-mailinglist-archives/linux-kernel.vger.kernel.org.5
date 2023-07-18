Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD837583F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGRR5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjGRR5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:57:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DDBE8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:57:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb2468257fso18945855ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689703035; x=1692295035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRD9blNIxHluSUPOIYULRJbi8uFOds7uOEZDc3kDErE=;
        b=mMpImavfY2ADOOfTsM0dULPAztPWwAkAxaN5EBRdgTONlUbuDv0bc/jnql1JEnUeOO
         bda5Tj4uvdDQ4B+NJ/gmvkMeUhOrHdA5CxK42FliEYPeTWhjOiI8i0+G+nUodHSTQx/g
         HanMLQr/dHe8w7iHPBOx35pnzrQWodjmfukbs1BbseIHXHWTRnEizqCumzGYhUaGm+dQ
         jRxPO5RqjGL1hwX87TamgliuO3lsmronneNDvHaIucdFlccgiBcVHg4FAmdI6hkUO0Ji
         3UXm13B3+3pT+2iToWzn8Ie1OvrVbaXYWR6AEsbzg//AwTK48dHUa2cpqzFIrDJGPtWZ
         5PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703035; x=1692295035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRD9blNIxHluSUPOIYULRJbi8uFOds7uOEZDc3kDErE=;
        b=ee1unjd1EBoWnqIxVsmN1LlhD4nfE8whTC4+hcrQeRzNr3dApFfFdFp91sNOZeUXhQ
         PK2hOWoWSVljmMhMaClgWr0l9XAtQ6o1nbD+JypfUtKzIDTHH0Wko3pfOym1HqVgdSiA
         a66hfRV56vO1ZHd2Q/0yKPpSvv1GkqyUpqNma8kk9L2pAr+oO5Q9U1+eq4F1WOyuD849
         pHdjbxEblT1Dbtnpfz4R8gUeTxkUWfyXX65px56wPosv1I9VE3ZZPptSwh7pt6OzTwPU
         oA1drE2WFtv3OLb+mPi1Mg8v52Ij7hBPSroOFHGCu3cBo7jtNRV7lYA6+0qqsbpehyj5
         ihPQ==
X-Gm-Message-State: ABy/qLYR5c5sP5RL8DG1a5IiExAAHQIy8+C2q76RQ+qa5dnNp9hUb/v8
        hY4OJnqXlvvcvr3wVk+nehL2vS00R1TlifADNPA=
X-Google-Smtp-Source: APBJJlH/DFdDcamBY608z6if+lXRDqfUJnrs4w53GX7UPxfbPo+Y0+UeHJe6ZmJVTzN0SvAK3Kq8RA==
X-Received: by 2002:a17:902:e549:b0:1b8:aef2:773e with SMTP id n9-20020a170902e54900b001b8aef2773emr17009609plf.46.1689703034916;
        Tue, 18 Jul 2023 10:57:14 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b001b89612dc7dsm2167740plb.142.2023.07.18.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:57:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qLowi-002aex-Bi;
        Tue, 18 Jul 2023 14:57:12 -0300
Date:   Tue, 18 Jul 2023 14:57:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, ajd@linux.ibm.com,
        catalin.marinas@arm.com, fbarrat@linux.ibm.com,
        iommu@lists.linux.dev, jhubbard@nvidia.com, kevin.tian@intel.com,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        nicolinc@nvidia.com, npiggin@gmail.com, robin.murphy@arm.com,
        seanjc@google.com, will@kernel.org, x86@kernel.org,
        zhi.wang.linux@gmail.com
Subject: Re: [PATCH 1/4] mm_notifiers: Rename invalidate_range notifier
Message-ID: <ZLbSeO+XjSx1W795@ziepe.ca>
References: <cover.b4454f7f3d0afbfe1965e8026823cd50a42954b4.1689666760.git-series.apopple@nvidia.com>
 <c0daf0870f7220bbf815713463aff86970a5d0fa.1689666760.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0daf0870f7220bbf815713463aff86970a5d0fa.1689666760.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:56:15PM +1000, Alistair Popple wrote:
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index b466172..48c81b9 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -456,7 +456,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  		return;
>  
>  	tlb_flush(tlb);
> -	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
> +	mmu_notifier_invalidate_secondary_tlbs(tlb->mm, tlb->start, tlb->end);
>  	__tlb_reset_range(tlb);

Does this compile? I don't see
"mmu_notifier_invalidate_secondary_tlbs" ?

Maybe we don't need to rename this function since you pretty much
remove it in the next patches?

> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 50c0dde..34c5a84 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -207,7 +207,7 @@ mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub)
>  	 *    spin_lock
>  	 *     seq = ++subscriptions->invalidate_seq
>  	 *    spin_unlock
> -	 *     op->invalidate_range():
> +	 *     op->invalidate_secondary_tlbs():

The later patch should delete this stuff from the comment too, we
no longer guarantee this relationship?

> @@ -560,23 +560,23 @@ mn_hlist_invalidate_end(struct mmu_notifier_subscriptions *subscriptions,
>  	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist,
>  				 srcu_read_lock_held(&srcu)) {
>  		/*
> -		 * Call invalidate_range here too to avoid the need for the
> -		 * subsystem of having to register an invalidate_range_end
> -		 * call-back when there is invalidate_range already. Usually a
> -		 * subsystem registers either invalidate_range_start()/end() or
> -		 * invalidate_range(), so this will be no additional overhead
> -		 * (besides the pointer check).
> +		 * Subsystems should register either invalidate_secondary_tlbs()
> +		 * or invalidate_range_start()/end() callbacks.
>  		 *
> -		 * We skip call to invalidate_range() if we know it is safe ie
> -		 * call site use mmu_notifier_invalidate_range_only_end() which
> -		 * is safe to do when we know that a call to invalidate_range()
> -		 * already happen under page table lock.
> +		 * We call invalidate_secondary_tlbs() here so that subsystems
> +		 * can use larger range based invalidations. In some cases
> +		 * though invalidate_secondary_tlbs() needs to be called while
> +		 * holding the page table lock. In that case call sites use
> +		 * mmu_notifier_invalidate_range_only_end() and we know it is
> +		 * safe to skip secondary TLB invalidation as it will have
> +		 * already been done.
>  		 */
> -		if (!only_end && subscription->ops->invalidate_range)
> -			subscription->ops->invalidate_range(subscription,
> -							    range->mm,
> -							    range->start,
> -							    range->end);
> +		if (!only_end && subscription->ops->invalidate_secondary_tlbs)
> +			subscription->ops->invalidate_secondary_tlbs(

More doesn't compile, and the comment has the same issue..

But I think the approach in this series looks fine, it is so much
cleaner after we remove all the cruft in patch 4, just look at the
diffstat..

Jason
