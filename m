Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A97B3CCB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjI2Wzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Wzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:55:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A6CDD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:55:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942E1C433C8;
        Fri, 29 Sep 2023 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696028132;
        bh=KNRUE/bqgzjbX6niCi2O3ojYnR3wGKaiurwRPiLMZgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H347bVg3Ycwc1wo6fcrd5Afmv52WRMyS8kXf5asP0Hop0dFWRmi9dccDtxsRfaMmr
         beZRv2asIxXtXgsfyxef/3GiWLYzkObX9fg3zHh/V4JdY4gPbUHVu0w6DeGcUN0ej0
         v1lvGNFIqjesuhlZ8VxDTlfZ0rzO1cdIF879OkVI=
Date:   Fri, 29 Sep 2023 15:55:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
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
Message-Id: <20230929155530.a51e68e03e47a06b6b84c689@linux-foundation.org>
In-Reply-To: <20230929114421.3761121-5-ryan.roberts@arm.com>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
        <20230929114421.3761121-5-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:44:15 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> In preparation for adding support for anonymous large folios that are
> smaller than the PMD-size, introduce 2 new sysfs files that will be used
> to control the new behaviours via the transparent_hugepage interface.
> For now, the kernel still only supports PMD-order anonymous THP, so when
> reading back anon_orders, it will reflect that. Therefore there are no
> behavioural changes intended here.

powerpc strikes again.  ARCH=powerpc allmodconfig:


In file included from ./include/linux/bits.h:6,
                 from ./include/linux/ratelimit_types.h:5,
                 from ./include/linux/printk.h:9,
                 from ./include/asm-generic/bug.h:22,
                 from ./arch/powerpc/include/asm/bug.h:116,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/mm.h:6,
                 from mm/huge_memory.c:8:
./include/vdso/bits.h:7:33: error: initializer element is not constant
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                 ^
mm/huge_memory.c:77:47: note: in expansion of macro 'BIT'
   77 | unsigned int huge_anon_orders __read_mostly = BIT(PMD_ORDER);
      |                                               ^~~

We keep tripping over this.  I wish there was a way to fix it.



Style whine: an all-caps identifier is supposed to be a constant,
dammit.

	#define PTE_INDEX_SIZE  __pte_index_size

Nope.



I did this:

--- a/mm/huge_memory.c~mm-thp-introduce-anon_orders-and-anon_always_mask-sysfs-files-fix
+++ a/mm/huge_memory.c
@@ -74,7 +74,7 @@ static unsigned long deferred_split_scan
 static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
-unsigned int huge_anon_orders __read_mostly = BIT(PMD_ORDER);
+unsigned int huge_anon_orders __read_mostly;
 static unsigned int huge_anon_always_mask __read_mostly;
 
 /**
@@ -528,6 +528,9 @@ static int __init hugepage_init_sysfs(st
 {
 	int err;
 
+	/* powerpc's PMD_ORDER isn't a compile-time constant */
+	huge_anon_orders = BIT(PMD_ORDER);
+
 	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
 	if (unlikely(!*hugepage_kobj)) {
 		pr_err("failed to create transparent hugepage kobject\n");
_


I assume this is set up early enough.

I don't know why powerpc's PTE_INDEX_SIZE is variable.  Hopefully it
has been set up by this time and it won't get altered.  

