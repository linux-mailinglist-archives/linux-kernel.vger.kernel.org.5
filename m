Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0C7BE3B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346474AbjJIO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjJIO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:58:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DD5A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:58:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B250C433C7;
        Mon,  9 Oct 2023 14:58:13 +0000 (UTC)
Date:   Mon, 9 Oct 2023 15:58:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm/kmemleak: fix partially freeing unknown object
 warning
Message-ID: <ZSQVAglSDHKqZ9b3@arm.com>
References: <20231008023317.3015699-1-liushixin2@huawei.com>
 <20231008023317.3015699-4-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008023317.3015699-4-liushixin2@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 10:33:16AM +0800, Liu Shixin wrote:
> delete_object_part() can be called by multiple callers in the same time.
> If an object is found and removed by a caller, and then another caller
> try to find it too, it failed and return directly. The secound part still
> be recorded by kmemleak even if it has alreadly been freed to buddy.
> With DEBUG on, kmemleak will report the following warning:
> 
>  kmemleak: Partially freeing unknown object at 0xa1af86000 (size 4096)
>  CPU: 0 PID: 742 Comm: test_huge Not tainted 6.6.0-rc3kmemleak+ #54
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x37/0x50
>   kmemleak_free_part_phys+0x50/0x60
>   hugetlb_vmemmap_optimize+0x172/0x290
>   ? __pfx_vmemmap_remap_pte+0x10/0x10
>   __prep_new_hugetlb_folio+0xe/0x30
>   prep_new_hugetlb_folio.isra.0+0xe/0x40
>   alloc_fresh_hugetlb_folio+0xc3/0xd0
>   alloc_surplus_hugetlb_folio.constprop.0+0x6e/0xd0
>   hugetlb_acct_memory.part.0+0xe6/0x2a0
>   hugetlb_reserve_pages+0x110/0x2c0
>   hugetlbfs_file_mmap+0x11d/0x1b0
>   mmap_region+0x248/0x9a0
>   ? hugetlb_get_unmapped_area+0x15c/0x2d0
>   do_mmap+0x38b/0x580
>   vm_mmap_pgoff+0xe6/0x190
>   ksys_mmap_pgoff+0x18a/0x1f0
>   do_syscall_64+0x3f/0x90
>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> Fix the problem by adding a new mutex lock to make sure all objects are
> deleted sequentially in delete_object_part(). The kmemleak_lock is not
> suitable here because there is a memory allocation with flag GFP_KERNEL.
> 
> Fixes: 53238a60dd4a ("kmemleak: Allow partial freeing of memory blocks")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/kmemleak.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 54c2c90d3abc..ed497866361a 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -208,6 +208,8 @@ static struct rb_root object_tree_root = RB_ROOT;
>  static struct rb_root object_phys_tree_root = RB_ROOT;
>  /* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
>  static DEFINE_RAW_SPINLOCK(kmemleak_lock);
> +/* Serial delete_object_part() to ensure all objects are deleted correctly */
> +static DEFINE_MUTEX(delete_object_part_mutex);

I mentioned in my reply on v1, do we actually need a lock at all?

https://lore.kernel.org/r/ZRRhDgR/SIxbOCDk@arm.com

I think we can rework the core a bit to only use kmemleak_lock. We could
use GFP_ATOMIC when invoking __create_object(), it won't matter much as
partial freeing is used rarely and only during boot. Alternatively, we
could allocate two objects outside the lock and just pass them to a new,
modified __create_object() function which would avoid re-allocation.

The mutex looks simpler but then we need to be careful we only calls
these functions in a sleepable context.

-- 
Catalin
