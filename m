Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7E7F66F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjKWTLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:11:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6FA89E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:11:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C64A1042;
        Thu, 23 Nov 2023 11:12:14 -0800 (PST)
Received: from [10.57.70.238] (unknown [10.57.70.238])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 746AA3F7A6;
        Thu, 23 Nov 2023 11:11:25 -0800 (PST)
Message-ID: <d2313c1d-1e50-49b7-bed7-840431af799a@arm.com>
Date:   Thu, 23 Nov 2023 19:11:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in hugepd
 processing
Content-Language: en-GB
To:     Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com> <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n> <ZV21GCbG48nTLDzn@infradead.org>
 <ZV90JcnQ1RGud/0R@casper.infradead.org> <ZV-KQ0e0y9BTsHGv@x1n>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZV-KQ0e0y9BTsHGv@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 17:22, Peter Xu wrote:
> On Thu, Nov 23, 2023 at 03:47:49PM +0000, Matthew Wilcox wrote:
>> It looks like ARM (in the person of Ryan) are going to add support for
>> something equivalent to hugepd.
> 
> If it's about arm's cont_pte, then it looks ideal because this series
> didn't yet touch cont_pte, assuming it'll just work.  From that aspect, his
> work may help mine, and no immediately collapsing either.

Hi,

I'm not sure I've 100% understood the crossover between this series and my work
to support arm64's contpte mappings generally for anonymous and file-backed memory.

My approach is to transparently use contpte mappings when core-mm request pte
mappings that meet the requirements; and its all based around intercepting the
normal (non-hugetlb) helpers (e.g. set_ptes(), ptep_get() and friends). There is
no semantic change to the core-mm. See [1]. It relies on 1) the page cache using
large folios and 2) my "small-sized THP" series which starts using arbitrary
sized large folios for anonymous memory [2].

If I've understood this conversation correctly there is an object called hugepd,
which today is only supported by powerpc, but which could allow the core-mm to
control the mapping granularity? I can see some value in exposing that control
to core-mm in the (very) long term.

[1] https://lore.kernel.org/all/20231115163018.1303287-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20231115132734.931023-1-ryan.roberts@arm.com/

Thanks,
Ryan


> 
> There can be a slight performance difference which I need to measure for
> arm's cont_pte already for hugetlb, but I didn't worry much on that;
> quotting my commit message in the last patch:
> 
>     There may be a slight difference of how the loops run when processing
>     GUP over a large hugetlb range on either ARM64 (e.g. CONT_PMD) or RISCV
>     (mostly its Svnapot extension on 64K huge pages): each loop of
>     __get_user_pages() will resolve one pgtable entry with the patch
>     applied, rather than relying on the size of hugetlb hstate, the latter
>     may cover multiple entries in one loop.
>     
>     However, the performance difference should hopefully not be a major
>     concern, considering that GUP just yet got 57edfcfd3419 ("mm/gup:
>     accelerate thp gup even for "pages != NULL""), and that's not part of a
>     performance analysis but a side dish.  If the performance will be a
>     concern, we can consider handle CONT_PTE in follow_page(), for example.
> 
> So IMHO it can be slightly different comparing to e.g. page fault, because
> each fault is still pretty slow as a whole if one fault for each small pte
> (of a large folio / cont_pte), while the loop in GUP is still relatively
> tight and short, comparing to a fault.  I'd boldly guess more low hanging
> fruits out there for large folio outside GUP areas.
> 
> In all cases, it'll be interesting to know if Ryan has worked on cont_pte
> support for gup on large folios, and whether there's any performance number
> to share.  It's definitely good news to me because it means Ryan's work can
> also then benefit hugetlb if this series will be merged, I just don't know
> how much difference there will be.
> 
> Thanks,
> 

