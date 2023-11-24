Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BEA7F6F17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjKXJGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:06:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6942BC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:06:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74521063;
        Fri, 24 Nov 2023 01:06:52 -0800 (PST)
Received: from [10.57.71.2] (unknown [10.57.71.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64DC23F73F;
        Fri, 24 Nov 2023 01:06:03 -0800 (PST)
Message-ID: <510adc26-9aed-4745-8807-dba071fadbbe@arm.com>
Date:   Fri, 24 Nov 2023 09:06:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in hugepd
 processing
Content-Language: en-GB
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
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
 <d2313c1d-1e50-49b7-bed7-840431af799a@arm.com> <ZV-sJsdFfXiCkylv@x1n>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZV-sJsdFfXiCkylv@x1n>
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

On 23/11/2023 19:46, Peter Xu wrote:
> On Thu, Nov 23, 2023 at 07:11:19PM +0000, Ryan Roberts wrote:
>> Hi,
>>
>> I'm not sure I've 100% understood the crossover between this series and my work
>> to support arm64's contpte mappings generally for anonymous and file-backed memory.
> 
> No worry, there's no confliction.  If you worked on that it's only be
> something nice on top.  Also, I'm curious if you have performance numbers,

I have perf numbers for high level use cases (kernel compilation and Speedometer
Java Script benchmarks) at
https://lore.kernel.org/linux-arm-kernel/20230622144210.2623299-1-ryan.roberts@arm.com/

I don't have any micro-benchmarks for GUP though, if that's your question. Is
there an easy-to-use test I can run to get some numbers? I'd be happy to try it out.

> because I'm going to do some test for hugetlb cont_ptes (which is only the
> current plan), and if you got those it'll be a great baseline for me,
> because it should be similar in you case even though the goal is slightly
> different.
> 
>>
>> My approach is to transparently use contpte mappings when core-mm request pte
>> mappings that meet the requirements; and its all based around intercepting the
>> normal (non-hugetlb) helpers (e.g. set_ptes(), ptep_get() and friends). There is
>> no semantic change to the core-mm. See [1]. It relies on 1) the page cache using
>> large folios and 2) my "small-sized THP" series which starts using arbitrary
>> sized large folios for anonymous memory [2].
>>
>> If I've understood this conversation correctly there is an object called hugepd,
>> which today is only supported by powerpc, but which could allow the core-mm to
>> control the mapping granularity? I can see some value in exposing that control
>> to core-mm in the (very) long term.
> 
> For me it's needed immediately, because hugetlb_follow_page_mask() will be
> gone after the last patch.
> 
>>
>> [1] https://lore.kernel.org/all/20231115163018.1303287-1-ryan.roberts@arm.com/
>> [2] https://lore.kernel.org/linux-mm/20231115132734.931023-1-ryan.roberts@arm.com/
> 
> AFAICT you haven't yet worked on gup then, after I glimpsed the above
> series.

No, I haven't touched GUP at all. The approach is fully inside the arm64 arch
code (except 1 patch to core-mm which enables an optimization). So as far as GUP
and the rest of the core-mm is concerned, there are still only page-sized ptes
and they can all be iterated over and accessed as normal.

> 
> It's a matter of whether one follow_page_mask() call can fetch more than
> one page* for a cont_pte entry on aarch64 for a large non-hugetlb folio
> (and if this series lands, it'll be the same to hugetlb or non-hugetlb).
> Now the current code can only fetch one page I think.
> 
> Thanks,
> 

