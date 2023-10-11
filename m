Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D517C5442
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346870AbjJKMqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjJKMqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:46:17 -0400
Received: from outbound-smtp27.blacknight.com (outbound-smtp27.blacknight.com [81.17.249.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA391
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:46:14 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 9E262B2013
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:46:13 +0100 (IST)
Received: (qmail 15039 invoked from network); 11 Oct 2023 12:46:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Oct 2023 12:46:13 -0000
Date:   Wed, 11 Oct 2023 13:46:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 01/10] mm, pcp: avoid to drain PCP when process exit
Message-ID: <20231011124610.4punxroovolyvmgr@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920061856.257597-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230920061856.257597-2-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:18:47PM +0800, Huang Ying wrote:
> In commit f26b3fa04611 ("mm/page_alloc: limit number of high-order
> pages on PCP during bulk free"), the PCP (Per-CPU Pageset) will be
> drained when PCP is mostly used for high-order pages freeing to
> improve the cache-hot pages reusing between page allocation and
> freeing CPUs.
> 
> But, the PCP draining mechanism may be triggered unexpectedly when
> process exits.  With some customized trace point, it was found that
> PCP draining (free_high == true) was triggered with the order-1 page
> freeing with the following call stack,
> 
>  => free_unref_page_commit
>  => free_unref_page
>  => __mmdrop
>  => exit_mm
>  => do_exit
>  => do_group_exit
>  => __x64_sys_exit_group
>  => do_syscall_64
> 
> Checking the source code, this is the page table PGD
> freeing (mm_free_pgd()).  It's a order-1 page freeing if
> CONFIG_PAGE_TABLE_ISOLATION=y.  Which is a common configuration for
> security.
> 
> Just before that, page freeing with the following call stack was
> found,
> 
>  => free_unref_page_commit
>  => free_unref_page_list
>  => release_pages
>  => tlb_batch_pages_flush
>  => tlb_finish_mmu
>  => exit_mmap
>  => __mmput
>  => exit_mm
>  => do_exit
>  => do_group_exit
>  => __x64_sys_exit_group
>  => do_syscall_64
> 
> So, when a process exits,
> 
> - a large number of user pages of the process will be freed without
>   page allocation, it's highly possible that pcp->free_factor becomes
>   > 0.
> 
> - after freeing all user pages, the PGD will be freed, which is a
>   order-1 page freeing, PCP will be drained.
> 
> All in all, when a process exits, it's high possible that the PCP will
> be drained.  This is an unexpected behavior.
> 
> To avoid this, in the patch, the PCP draining will only be triggered
> for 2 consecutive high-order page freeing.
> 
> On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
> one socket with `make -j 112`.  With the patch, the build time
> decreases 3.4% (from 206s to 199s).  The cycles% of the spinlock
> contention (mostly for zone lock) decreases from 43.6% to 40.3% (with
> PCP size == 361).  The number of PCP draining for high order pages
> freeing (free_high) decreases 50.8%.
> 
> This helps network workload too for reduced zone lock contention.  On
> a 2-socket Intel server with 128 logical CPU, with the patch, the
> network bandwidth of the UNIX (AF_UNIX) test case of lmbench test
> suite with 16-pair processes increase 17.1%.  The cycles% of the
> spinlock contention (mostly for zone lock) decreases from 50.0% to
> 45.8%.  The number of PCP draining for high order pages
> freeing (free_high) decreases 27.4%.  The cache miss rate keeps 0.3%.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

However, I want to note that batching on exit is not necessarily
unexpected. For processes that are multi-TB in size, the time to exit
can actually be quite large and batching is of benefit but optimising
for exit is rarely a winning strategy. The pattern of "all allocs on CPU
B and all frees on CPU B" or "short-lived tasks triggering a premature
drain" is a bit more compelling but not worth a changelog rewrite.
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 4106fbc5b4b3..64d5ed2bb724 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -676,12 +676,15 @@ enum zone_watermarks {
>  #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
>  #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
>  
> +#define	PCPF_PREV_FREE_HIGH_ORDER	0x01
> +

The meaning of the flag and its intent should have been documented.

-- 
Mel Gorman
SUSE Labs
