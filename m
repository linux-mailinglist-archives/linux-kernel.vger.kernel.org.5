Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D921D7B4FF2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbjJBKPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJBKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:15:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40A50B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:15:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52724C15;
        Mon,  2 Oct 2023 03:16:04 -0700 (PDT)
Received: from [10.57.66.79] (unknown [10.57.66.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3983F762;
        Mon,  2 Oct 2023 03:15:22 -0700 (PDT)
Message-ID: <3fabc0ed-9f2e-4ad6-ac40-aabdacff1cf2@arm.com>
Date:   Mon, 2 Oct 2023 11:15:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] mm: thp: Introduce anon_orders and
 anon_always_mask sysfs files
Content-Language: en-GB
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-5-ryan.roberts@arm.com>
 <20230929155530.a51e68e03e47a06b6b84c689@linux-foundation.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230929155530.a51e68e03e47a06b6b84c689@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 23:55, Andrew Morton wrote:
> On Fri, 29 Sep 2023 12:44:15 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> In preparation for adding support for anonymous large folios that are
>> smaller than the PMD-size, introduce 2 new sysfs files that will be used
>> to control the new behaviours via the transparent_hugepage interface.
>> For now, the kernel still only supports PMD-order anonymous THP, so when
>> reading back anon_orders, it will reflect that. Therefore there are no
>> behavioural changes intended here.
> 
> powerpc strikes again.  ARCH=powerpc allmodconfig:
> 
> 
> In file included from ./include/linux/bits.h:6,
>                  from ./include/linux/ratelimit_types.h:5,
>                  from ./include/linux/printk.h:9,
>                  from ./include/asm-generic/bug.h:22,
>                  from ./arch/powerpc/include/asm/bug.h:116,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/mm.h:6,
>                  from mm/huge_memory.c:8:
> ./include/vdso/bits.h:7:33: error: initializer element is not constant
>     7 | #define BIT(nr)                 (UL(1) << (nr))
>       |                                 ^
> mm/huge_memory.c:77:47: note: in expansion of macro 'BIT'
>    77 | unsigned int huge_anon_orders __read_mostly = BIT(PMD_ORDER);
>       |                                               ^~~

Ahh my bad, sorry about that - I built various configs and arches but not powerpc.

> 
> We keep tripping over this.  I wish there was a way to fix it.
> 
> 
> 
> Style whine: an all-caps identifier is supposed to be a constant,
> dammit.
> 
> 	#define PTE_INDEX_SIZE  __pte_index_size
> 
> Nope.
> 
> 
> 
> I did this:
> 
> --- a/mm/huge_memory.c~mm-thp-introduce-anon_orders-and-anon_always_mask-sysfs-files-fix
> +++ a/mm/huge_memory.c
> @@ -74,7 +74,7 @@ static unsigned long deferred_split_scan
>  static atomic_t huge_zero_refcount;
>  struct page *huge_zero_page __read_mostly;
>  unsigned long huge_zero_pfn __read_mostly = ~0UL;
> -unsigned int huge_anon_orders __read_mostly = BIT(PMD_ORDER);
> +unsigned int huge_anon_orders __read_mostly;
>  static unsigned int huge_anon_always_mask __read_mostly;
>  
>  /**
> @@ -528,6 +528,9 @@ static int __init hugepage_init_sysfs(st
>  {
>  	int err;
>  
> +	/* powerpc's PMD_ORDER isn't a compile-time constant */
> +	huge_anon_orders = BIT(PMD_ORDER);
> +
>  	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
>  	if (unlikely(!*hugepage_kobj)) {
>  		pr_err("failed to create transparent hugepage kobject\n");
> _
> 
> 
> I assume this is set up early enough.

Yes this should be fine.

> 
> I don't know why powerpc's PTE_INDEX_SIZE is variable.  Hopefully it
> has been set up by this time and it won't get altered.  

Looks that way from the code; its set during early_init_mmu().

Anyway, I'll take the fix into my next spin if I need to do one. I see you've
taken it into mm-unstable - thanks! But given I'm introducing UABI, I was
expecting some comments and a probably need for a new rev. I'd like to think we
are getting there though.

Thanks,
Ryan

