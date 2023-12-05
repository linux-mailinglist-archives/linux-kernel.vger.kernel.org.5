Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB08F804DF2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjLEJeX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 04:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:34:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E34679A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:34:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 381B8139F;
        Tue,  5 Dec 2023 01:35:14 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8863E3F6C4;
        Tue,  5 Dec 2023 01:34:24 -0800 (PST)
Message-ID: <2de0617e-d1d7-49ec-9cb8-206eaf37caed@arm.com>
Date:   Tue, 5 Dec 2023 09:34:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204113039.42510c23455026e40c5e2a56@linux-foundation.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231204113039.42510c23455026e40c5e2a56@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 19:30, Andrew Morton wrote:
> On Mon,  4 Dec 2023 10:20:17 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> Hi All,
>>
>>
>> Prerequisites
>> =============
>>
>> Some work items identified as being prerequisites are listed on page 3 at [9].
>> The summary is:
>>
>> | item                          | status                  |
>> |:------------------------------|:------------------------|
>> | mlock                         | In mainline (v6.7)      |
>> | madvise                       | In mainline (v6.6)      |
>> | compaction                    | v1 posted [10]          |
>> | numa balancing                | Investigated: see below |
>> | user-triggered page migration | In mainline (v6.7)      |
>> | khugepaged collapse           | In mainline (NOP)       |
> 
> What does "prerequisites" mean here?  Won't compile without?  Kernel
> crashes without?  Nice-to-have-after?  Please expand on this.

Short answer: It's supposed to mean things that either need to be done to prevent the mm from regressing (both correctness and performance) when multi-size THP is present but disabled, or things that need to be done to make the mm robust (but not neccessarily optimially performant) when multi-size THP is enabled. But in reality, all of the things on the list could really be reclassified as "nice-to-have-after", IMHO; their absence will neither cause compilation nor runtime errors.

Longer answer: When I first started looking at this, I was advised that there were likely a number of corners which made assumptions about large folios always being PMD-sized, and if not found and fixed, could lead to stability issues. At the time I was also pursuing a strategy of multi-size THP being a compile-time feature with no runtime control, so I decided it was important for multi-size THP to not effectively disable other features (e.g. various madvise ops used to ignore PTE-mapped large folios). This list represents all the things that I could find based on code review, as well as things suggested by others, and in the end, they all fall into that last category of "PTE-mapped large folios efectively disable existing features". But given we now have runtime controls to opt-in to multi-size THP, I'm not sure we need to classify these as prerequisites. But I didn't want to unilaterally make that decision, given this list has previously been discussed and agreed by others.

It's also worth noting that in the case of compaction, that's already a problem for large folios in the page cache; large folios will be skipped.

> 
> I looked at [9], but access is denied.

Sorry about that; its owned by David Rientjes so I can't fix that for you. It's a PDF of a slide with the following table:

+-------------------------------+------------------------------------------------------------------------+--------------+--------------------+
| Item                          | Description                                                            | Assignee     | Status             |
+-------------------------------+------------------------------------------------------------------------+--------------+--------------------+
| mlock                         | Large, pte-mapped folios are ignored when mlock is requested.          | Yin, Fengwei | In mainline (v6.7) |
|                               | Code comment for mlock_vma_folio() says "...filter out pte mappings    |              |                    |
|                               | of THPs which cannot be consistently counted: a pte mapping of the     |              |                    |
|                               | THP head cannot be distinguished by the page alone."                   |              |                    |
| madvise                       | MADV_COLD, MADV_PAGEOUT, MADV_FREE: For large folios, code assumes     | Yin, Fengwei | In mainline (v6.6) |
|                               | exclusive only if mapcount==1, else skips remainder of operation.      |              |                    |
|                               | For large, pte-mapped folios, exclusive folios can have mapcount       |              |                    |
|                               | upto nr_pages and still be exclusive. Even better; don't split         |              |                    |
|                               | the folio if it fits entirely within the range.                        |              |                    |
| compaction                    | Raised at LSFMM: Compaction skips non-order-0 pages.                   | Zi Yan       | v1 posted          |
|                               | Already problem for page-cache pages today.                            |              |                    |
| numa balancing                | Large, pte-mapped folios are ignored by numa-balancing code. Commit    | John Hubbard | Investigated:      |
|                               | comment (e81c480): "We're going to have THP mapped with PTEs. It       |              | Not prerequisite   |
|                               | will confuse numabalancing. Let's skip them for now."                  |              |                    |
| user-triggered page migration | mm/migrate.c (migrate_pages syscall) We don't want to migrate folio    | Kefeng Wang  | In mainline (v6.7) |
|                               | that is shared.                                                        |              |                    |
| khugepaged collapse           | collapse small-sized THP to PMD-sized THP in khugepaged/MADV_COLLAPSE. | Ryan Roberts | In mainline (NOP)  |
|                               | Kirill thinks khugepage should already be able to collapse             |              |                    |
|                               | small large folios to PMD-sized THP; verification required.            |              |                    |
+-------------------------------+------------------------------------------------------------------------+--------------+--------------------+

Thanks,
Ryan

> 
>> [9] https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/view?usp=sharing&resourcekey=0-U1Mj3-RhLD1JV6EThpyPyA
> 
> 

