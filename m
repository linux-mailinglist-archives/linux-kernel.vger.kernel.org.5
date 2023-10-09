Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118BF7BD8F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbjJIKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjJIKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:47:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA599
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:47:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA7FC433C8;
        Mon,  9 Oct 2023 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696848457;
        bh=+6ayJyiGaU3UhAWivZrHdqfkLdoeJo+9qadAli1PDXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=os0fcFvV0DoUVDRpfiTs2bdsrTbzwTozJbTx8mgUsmyU9Sc4D4+ZPpjVa0AJgZJV5
         bvyUBPPRc7AqK6NIGrBkPRADD2lsxv8ELlpYVsmS3s2DxYt+ewqJkE5fcEes8hCuz7
         f5TDk6x2ykJHV0CcG01FFT56KUEIx+JZ0Yoooum4e0in/iXDu58WVlrO4YMbTk12J1
         Er1TB6YYE2+0CDM9omG4LzWL86TIo7QYbrKhFlcKRXMrYxhF2kk9iXQKkBD19dJ6lx
         y5VVjYGxdDw6C+PtqQS40sNf3shpy/jyhPoEZUVgbHCvmN5WGabHECwUOvbghucPWe
         gbe0wTYoYKJGA==
Date:   Mon, 9 Oct 2023 13:46:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm/mprotect: allow unfaulted VMAs to be unaccounted
 on mprotect()
Message-ID: <20231009104643.GO3303@kernel.org>
References: <bfef277462dd0dc75ce86e051bebc8b063f8d885.1696694712.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfef277462dd0dc75ce86e051bebc8b063f8d885.1696694712.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 05:47:48PM +0100, Lorenzo Stoakes wrote:
> When mprotect() is used to make unwritable VMAs writable, they have the
> VM_ACCOUNT flag applied and memory accounted accordingly.
> 
> If the VMA has had no pages faulted in and is then made unwritable once
> again, it will remain accounted for, despite not being capable of extending
> memory usage.
> 
> Consider:-
> 
> ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
> mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
> mprotect(ptr + page_size, page_size, PROT_READ);
> 
> The first mprotect() splits the range into 3 VMAs and the second fails to
> merge the three as the middle VMA has VM_ACCOUNT set and the others do not,
> rendering them unmergeable.
> 
> This is unnecessary, since no pages have actually been allocated and the
> middle VMA is not capable of utilising more memory, thereby introducing
> unnecessary VMA fragmentation (and accounting for more memory than is
> necessary).
> 
> Since we cannot efficiently determine which pages map to an anonymous VMA,
> we have to be very conservative - determining whether any pages at all have
> been faulted in, by checking whether vma->anon_vma is NULL.
> 
> We can see that the lack of anon_vma implies that no anonymous pages are
> present as evidenced by vma_needs_copy() utilising this on fork to
> determine whether page tables need to be copied.
> 
> The only place where anon_vma is set NULL explicitly is on fork with
> VM_WIPEONFORK set, however since this flag is intended to cause the child
> process to not CoW on a given memory range, it is right to interpret this
> as indicating the VMA has no faulted-in anonymous memory mapped.
> 
> If the VMA was forked without VM_WIPEONFORK set, then anon_vma_fork() will
> have ensured that a new anon_vma is assigned (and correctly related to its
> parent anon_vma) should any pages be CoW-mapped.
> 
> The overall operation is safe against races as we hold a write lock against
> mm->mmap_lock.
> 
> If we could efficiently look up the VMA's faulted-in pages then we would
> unaccount all those pages not yet faulted in. However as the original
> comment alludes this simply isn't currently possible, so we are
> conservative and account all pages or none at all.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> 
> v2:
> - Minor spelling correction.
> 
> v1:
> https://lore.kernel.org/all/20230626204612.106165-1-lstoakes@gmail.com/
> 
> 
>  mm/mprotect.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index b94fbb45d5c7..10685ec35c5e 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -608,8 +608,11 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	/*
>  	 * If we make a private mapping writable we increase our commit;
>  	 * but (without finer accounting) cannot reduce our commit if we
> -	 * make it unwritable again. hugetlb mapping were accounted for
> -	 * even if read-only so there is no need to account for them here
> +	 * make it unwritable again except in the anonymous case where no
> +	 * anon_vma has yet to be assigned.
> +	 *
> +	 * hugetlb mapping were accounted for even if read-only so there is
> +	 * no need to account for them here.
>  	 */
>  	if (newflags & VM_WRITE) {
>  		/* Check space limits when area turns into data. */
> @@ -623,6 +626,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  				return -ENOMEM;
>  			newflags |= VM_ACCOUNT;
>  		}
> +	} else if ((oldflags & VM_ACCOUNT) && vma_is_anonymous(vma) &&
> +		   !vma->anon_vma) {
> +		newflags &= ~VM_ACCOUNT;
>  	}
>  
>  	/*
> @@ -653,6 +659,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	}
>  
>  success:
> +	if ((oldflags & VM_ACCOUNT) && !(newflags & VM_ACCOUNT))
> +		vm_unacct_memory(nrpages);
> +
>  	/*
>  	 * vm_flags and vm_page_prot are protected by the mmap_lock
>  	 * held in write mode.
> -- 
> 2.42.0
> 

-- 
Sincerely yours,
Mike.
