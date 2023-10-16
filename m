Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B337F7CA6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjJPLg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJPLg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:36:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 778548E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:36:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F362F4;
        Mon, 16 Oct 2023 04:37:05 -0700 (PDT)
Received: from [10.57.66.151] (unknown [10.57.66.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 795373F5A1;
        Mon, 16 Oct 2023 04:36:23 -0700 (PDT)
Message-ID: <daa423be-6db6-46bc-98a7-0c37ede04a8e@arm.com>
Date:   Mon, 16 Oct 2023 12:36:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] mm, kpageflags: support folio and fix output for
 compound pages
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
 <63d119f7-5adb-861a-00c2-69a92b19ef9b@redhat.com>
 <20231012150226.GA473412@u2004>
 <86170ebf-cbe3-1cda-dcb4-87e18695f9cd@redhat.com>
 <ZSlcJWvTNi3rEcPf@casper.infradead.org>
 <65dbdf2a-9281-a3c3-b7e3-a79c5b60b357@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <65dbdf2a-9281-a3c3-b7e3-a79c5b60b357@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 11:13, David Hildenbrand wrote:
>>>>> It does sound inconsistent. What exactly do you want to tell user space with
>>>>> the new flag?
>>>>
>>>> The current most problematic behavior is to report folio as thp (order-2
>>>> pagecache page is definitely a folio but not a thp), and this is what the
>>>> new flag is intended to tell.
>>>
>>> We are currently considering calling these sub-PMD sized THPs "small-sized
>>> THP". [1] Arguably, we're starting with the anon part where we won't get
>>> around exposing them to the user in sysfs.
>>>
>>> So I wouldn't immediately say that these things are not THPs. They are not
>>> PMD-sized THP. A slab/hugetlb is certainly not a thp but a folio. Whereby
>>> slabs can also be order-0 folios, but hugetlb can't.
>>
>> I think this is a mistake.  Users expect THPs to be PMD sized.  We already
>> have the term "large folio" in use for file-backed memory; why do we
>> need to invent a new term for anon large folios?
> 
> I changed my opinion two times, but I stabilized at "these are just huge pages
> of different size" when it comes to user-visible features.
> 
> Handling/calling them folios internally -- especially to abstract the page vs.
> compound page and how we manage/handle the metadata -- is a reasonable thing to
> do, because that's what we decided to pass around.
> 
> 
> For future reference, here is a writeup about my findings and the reason for my
> opinion:
> 
> 
> (1) OS-independent concept
> 
> Ignoring how the OS manages metadata (e.g., "struct page", "struct folio",
> compound head/tail, memdesc, ...), the common term to describe a "the smallest
> fixed-length contiguous block of physical memory into which memory pages are
> mapped by the operating system.["[1] is a page frame -- people usually simplify
> by dropping the "frame" part, so do I.
> 
> Larger pages (which we call "huge pages", FreeBSD "superpages", Windows "large
> pages") can come in different sizes and were traditionally based on architecture
> support, whereby architectures can support multiple ones [1]; I think what we
> see is that the OS might use intermediate sizes to manage memory more
> efficiently, abstracting/evolving that concept from the actual hardware page
> table mapping granularity.
> 
> But the foundation is that we are dealing with "blocks of physical memory" in a
> unit that is larger than the smallest page sizes. Larger pages.
> 
> [the comment about SGI IRIX on [1] is an interesting read; so are "scattered
> superpages"[3]]
> 
> Users learned the difference between a "page" and a "huge page". I'm confident
> that they can learn the difference between a "traditional huge page" and a
> "small-sized huge page", just like they did with hugetlb (below).
> 
> We just have to be careful with memory statistics and to default to the
> traditional huge pages for now. Slowly, the term "THP" will become more generic.
> Apart from that, I fail to see the big source of confusion.
> 
> Note: FreeBSD currently similarly calls these things on arm64 "medium-sized
> superpages", and did not invent new terms for that so far [2].
> 
> 
> (2) hugetlb
> 
> Traditional huge pages started out to be PMD-sized. Before 2008, we only
> supported a single huge page size. Ever since, we added support for sizes larger
> (gigantic) and smaller than that (cont-pte / cont-pmd).
> 
> So (a) users did not panic because we also supported huge pages that were not
> PMD-sized; (b) we managed to integrate it into the existing environment,
> defaulting to the old PMD-sized huge pages towards the user but still providing
> configuration knobs and (c) it is natural today to have multiple huge page sizes
> supported in hugetlb.
> 
> Nowadays, when somebody says that they are using hugetlb huge pages, the first
> question frequently is "which huge page size?". The same will happen with
> transparent huge pages I believe.
> 
> 
> (3) THP preparation for multiple sizes
> 
> With
>     /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
> added in 2016, we already provided a way for users to query the PMD size for
> THP, implying that there might be multiple sizes in the future.
> 
> Therefore, in commit 49920d28781d, Hugh already envisioned " some transparent
> support for pud and pgd pages" and ended up calling it "_pmd_size". Turns out,
> we want smaller THPs first, not larger ones.
> 
> 
> (4) Metadata management
> 
> How the OS manages metadata for its memory -- and how it calls the involved
> datastructures -- is IMHO an implementation detail (an important one regarding
> performance, robustness and metadata overhead as we learned, though ;) ).
> 
> We were able to introduce folios without user-visible changes. We should be able
> to implement memdesc (or memory type hierarchies) without user-visible changes
> -- except for some interfaces that provide access to bare "struct page"
> information (classifies as debugging interfaces IMHO).
> 
> 
> Last but not least, we ended up consistently calling these "larger than a page"
> things that we map into user space "(transparent) huge page" towards the user in
> toggles, stats and documentation. Fortunately we didn't use the term "compound
> page" back then; it would have been a mistake.
> 
> 
> Regarding the pagecache, we managed to not expose any toggles towards the user,
> because memory waste can be better controlled. So the term "folio" does not pop
> up as a toggle in /sys and /proc.
> 
>     t14s: ~  $ find /sys -name "*folio*" 2> /dev/null
>     t14s: ~  $ find /proc -name "*folio*" 2> /dev/null
> 
> Once we want to remove the (sub)page mapcount, we'll likely have to remove
> _nr_pages_mapped. To make some workloads that are sensitive to memory
> consumption [4] play along when not accounting only the actually mapped parts,
> we might have to introduce other ways to control that, when
> "/sys/kernel/debug/fault_around_bytes" no longer does the trick. I'm hoping we
> can still find ways to avoid exposing any toggles for that; we'll see.
> 
> 
> [1] https://en.wikipedia.org/wiki/Page_(computer_memory)
> [2] https://www.freebsd.org/status/report-2022-04-2022-06/superpages/
> [3] https://ieeexplore.ieee.org/document/6657040/similar#similar
> [4] https://www.suse.com/support/kb/doc/?id=000019017

+1 for David's reasoning.

FWIW, the way I see it, everything is a folio; a folio is an implementation
detail that neatly abstracts a physically contiguous, power-of-2 number of pages
(including the single page case). So I'm not sure how useful it is to add the
proposed KPF_FOLIO flag. The only real thing I can imagine user space using it
for would be to tell if some extent of virtual memory is physically contiguous,
and you can already do that from the PFN.

Bigger picture interface-wise, I think it is simpler and more understandable to
the user to extend an existing concept (THP) rather than invent a new one
(folios) that substantially overlaps with the existing (PMD-sized) THP concept.

That said, if you have plans in the folio roadmap that I'm not aware of, then
perhaps those would change my mind. There is a thread here [1] where we are
discussing the best way to expose "small-sized THP" (anon large folios) to user
space - Metthew if you you stong feelings, please do reply!

[1]
https://lore.kernel.org/linux-mm/6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com/

Thanks,
Ryan


> 
> 
>>
>>> Looking at other interfaces, we do expose:
>>>
>>> include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_HEAD        15
>>> include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_TAIL        16
>>>
>>> So maybe we should just continue talking about compound pages or do we have
>>> to use both terms here in this interface?
>>
>> I don;t know how easy it's going to be to distinguish between a head
>> and tail page in the Glorious Future once pages and folios are separated.
> 
> Probably a page-based interface would be the wrong interface for that;
> fortunately, this interface has a "debugging" smell to it, so we might be able
> to replace it.
> 

