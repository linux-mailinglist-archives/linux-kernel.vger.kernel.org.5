Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78EA78B451
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjH1PVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjH1PV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:21:29 -0400
Received: from out-245.mta0.migadu.com (out-245.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB08BE0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:21:25 -0700 (PDT)
Date:   Tue, 29 Aug 2023 00:21:13 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693236082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAXqRb7f3TkLKfxHc6WqM603wFyJETSjvqftd5xFDu8=;
        b=U3iDCIMzNv/u2zstS1bYaiv1hU43uCxMGdgZcvAyRvAIZUV5zbKaT7TwpUse7q9NGPgWk9
        pSBdcdma2iTsVz3KhuPFqRQNmtb7eOv8B7ku/+6o+VyA0So+lsJEdo0Z68iEb5RaU/ShMU
        Xd5Ln5mKPYDHlvqYOLys31RrQyijDEQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        naoya.horiguchi@nec.com, osalvador@suse.de
Subject: Re: [PATCH v2 1/3] mm/page_alloc: correct start page when guard page
 debug is enabled
Message-ID: <20230828152113.GA886794@ik1-406-35019.vs.sakura.ne.jp>
References: <20230826154745.4019371-1-shikemeng@huaweicloud.com>
 <20230826154745.4019371-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230826154745.4019371-2-shikemeng@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:47:43PM +0800, Kemeng Shi wrote:
> When guard page debug is enabled and set_page_guard returns success, we
> miss to forward page to point to start of next split range and we will do
> split unexpectedly in page range without target page. Move start page
> update before set_page_guard to fix this.
> 
> As we split to wrong target page, then splited pages are not able to merge
> back to original order when target page is put back and splited pages
> except target page is not usable. To be specific:
> 
> Consider target page is the third page in buddy page with order 2.
> | buddy-2 | Page | Target | Page |
> 
> After break down to target page, we will only set first page to Guard
> because of bug.
> | Guard   | Page | Target | Page |
> 
> When we try put_page_back_buddy with target page, the buddy page of target
> if neither guard nor buddy, Then it's not able to construct original page
> with order 2
> | Guard | Page | buddy-0 | Page |
> 
> All pages except target page is not in free list and is not usable.
> 
> Fixes: 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Thank you for finding the problem and writing patches.  I think the patch
fixes the reported problem, But I wonder that we really need guard page
mechanism in break_down_buddy_pages() which is only called from memory_failure.
As stated in Documentation/admin-guide/kernel-parameters.txt, this is a
debugging feature to detect memory corruption due to buggy kernel or drivers
code.  So if HW memory failrue seems to be out of the scope, and I feel that
we could simply remove it from break_down_buddy_pages().

        debug_guardpage_minorder=
                        [KNL] When CONFIG_DEBUG_PAGEALLOC is set, this
                        parameter allows control of the order of pages that will
                        be intentionally kept free (and hence protected) by the
                        buddy allocator. Bigger value increase the probability
                        of catching random memory corruption, but reduce the
                        amount of memory for normal system use. The maximum
                        possible value is MAX_ORDER/2.  Setting this parameter
                        to 1 or 2 should be enough to identify most random
                        memory corruption problems caused by bugs in kernel or
                        driver code when a CPU writes to (or reads from) a
                        random memory location. Note that there exists a class
                        of memory corruptions problems caused by buggy H/W or
                        F/W or by drivers badly programming DMA (basically when
                        memory is written at bus level and the CPU MMU is
                        bypassed) which are not detectable by
                        CONFIG_DEBUG_PAGEALLOC, hence this option will not help
                        tracking down these problems.

If you have any idea about how guard page mechanism helps memory_failrue,
could you share it?

Thanks,
Naoya Horiguchi

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fefc4074d9d0..88c5f5aea9b0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6505,6 +6505,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>  			next_page = page;
>  			current_buddy = page + size;
>  		}
> +		page = next_page;
>  
>  		if (set_page_guard(zone, current_buddy, high, migratetype))
>  			continue;
> @@ -6512,7 +6513,6 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>  		if (current_buddy != target) {
>  			add_to_free_list(current_buddy, zone, high, migratetype);
>  			set_buddy_order(current_buddy, high);
> -			page = next_page;
>  		}
>  	}
>  }
> -- 
> 2.30.0
> 
> 
> 
