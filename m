Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2685D7BCA77
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbjJGWyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 18:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 18:54:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C28B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 15:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1696719265;
        bh=nbk6q9Yf8RtraLdUwwm6uSKRHWkNNpARqVFKgzAyVkY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CyilkWGntWBxGsb8/XLbizmV96t6hMY+W0oQpxspY3WK2Zh0/R+joh7+C88GFimV3
         6I5g2B4Dt2Xy+wj9DW/HuxK8tyxrSKxDPP7oNzaxvdscosPR/vDjlFPma8eZgFv6+G
         uQ/RHEyrZOZ4Ga1RPNBGnPQAKoEcdrniyh0eOgpfh44rH+bJaeiBGUPMx8MWSQU7UY
         LNh2tKDZ5Hn1nHnyTit7RGBb6gLwaex8nvFzsEQxmBY98k0X6xlE+Ot6LEQwu9o8dz
         tlT32psHUtCIwAtIXIHSWPGI1WDqRVZQnxpg6bO5PFz5v8KTolLpb8r45OssLtfpBu
         Ejp+7pALj8xzQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S30wb2SbSz4x7V;
        Sun,  8 Oct 2023 09:54:23 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Subject: Re: [PATCH v6 4/9] mm: thp: Introduce anon_orders and
 anon_always_mask sysfs files
In-Reply-To: <20230929155530.a51e68e03e47a06b6b84c689@linux-foundation.org>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-5-ryan.roberts@arm.com>
 <20230929155530.a51e68e03e47a06b6b84c689@linux-foundation.org>
Date:   Sun, 08 Oct 2023 09:54:22 +1100
Message-ID: <87fs2mrqld.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:
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
>
> We keep tripping over this.  I wish there was a way to fix it.

I can't think of any solution, other than ripping the code out.

To catch it earlier we'd need a generic compile-time test that all values
derived from the page table geometry are only used in places that don't
require a constant. I can't think of a way to write a test for that.

Or submitters could compile-test for powerpc - one can dream :D

> Style whine: an all-caps identifier is supposed to be a constant,
> dammit.
>
> 	#define PTE_INDEX_SIZE  __pte_index_size
>
> Nope.

I agree it's ugly. It was done that way because PTE_INDEX_SIZE used to
be constant, and still is for 32-bit PPC and 64-bit Book3E PPC.

We could rename PTE_INDEX_SIZE itself, but we'd still have eg.
PTE_TABLE_SIZE which is used in generic code, and which would be
sometimes constant and sometimes not for different powerpc subarches.

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

Yes it should be.

> I don't know why powerpc's PTE_INDEX_SIZE is variable.

To allow a single vmlinux to boot using either the Hashed Page Table
MMU, or Radix Tree MMU, which have different page table geometry.

That's a pretty crucial feature for distros, so that they can build a
single kernel to boot on Power8/9/10.

cheers
