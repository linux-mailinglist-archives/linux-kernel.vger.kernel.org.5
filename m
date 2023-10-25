Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE27D71A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJYQYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:24:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B250D10E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:24:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 039A31FB;
        Wed, 25 Oct 2023 09:25:09 -0700 (PDT)
Received: from [10.57.70.113] (unknown [10.57.70.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD1953F64C;
        Wed, 25 Oct 2023 09:24:24 -0700 (PDT)
Message-ID: <fcbe9179-dcd9-4bf8-b1d1-82201880527e@arm.com>
Date:   Wed, 25 Oct 2023 17:24:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
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
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
 <a7781f13-21ca-48c7-99c4-22beef0400f9@arm.com>
In-Reply-To: <a7781f13-21ca-48c7-99c4-22beef0400f9@arm.com>
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

On 20/10/2023 13:33, Ryan Roberts wrote:
> On 06/10/2023 21:06, David Hildenbrand wrote:
>> On 29.09.23 13:44, Ryan Roberts wrote:
>>> Hi All,
>>
> 
> [...]
> 
>>> NOTE: These changes should not be merged until the prerequisites are complete.
>>> These are in progress and tracked at [7].
>>
>> We should probably list them here, and classify which one we see as strict a
>> requirement, which ones might be an optimization.
>>
> 
> Bringing back the discussion of prerequistes to this thread following the
> discussion at the mm-alignment meeting on Wednesday.
> 
> Slides, updated following discussion to reflect all the agreed items that are
> prerequisites and enhancements, are at [1].
> 
> I've taken a closer look at the situation with khugepaged, and can confirm that
> it does correctly collapse anon small-sized THP into PMD-sized THP. I did notice
> though, that one of the khugepaged selftests (collapse_max_ptes_none) fails when
> small-sized THP is enabled+always. So I've fixed that test up and will add the
> patch to the next version of my series.
> 
> So I believe the khugepaged prerequisite can be marked as done.
> 
> [1]
> https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/view?usp=sharing&resourcekey=0-U1Mj3-RhLD1JV6EThpyPyA

Hi All,

It's been a week since the mm alignment meeting discussion we had around
prerequisites and the ABI. I haven't heard any further feedback on the ABI
proposal, so I'm going to be optimistic and assume that nobody has found any
fatal flaws in it :).

Certainly, I think it held up to the potential future policies that Yu Zhou
cited on the call - the possibility of preferring a smaller size over a bigger
one, if the smaller size can be allocated without splitting a contiguous block.
I think the suggestion of adding a per-size priority file would solve it. And in
general because we have a per-size directory, that gives us lots of flexibility
for growth.

Anyway, given the lack of feedback, I'm proposing to spin a new version. I'm
planning to do the following:

  - Drop the accounting patch (#3); we will continue to only account PMD-sized
    THP for now. We can add more counters in future if needed. page cache large
    folios haven't needed any new counters yet.

  - Pivot to the ABI proposed by DavidH; per-size directories in a similar shape
    to that used by hugetlb

  - Drop the "recommend" keyword patch (#6); For now, users will need to
    understand implicitly which sizes are beneficial to their HW perf

  - Drop patch (#7); arch_wants_pte_order() is no longer needed due to dropping
    patch #6

  - Add patch for khugepaged selftest improvement (described in previous email
    above).

  - Ensure that PMD_ORDER is not assumed to be compile-time constant (current
    code is broken on powerpc)

Please shout if you think this is the wrong approach.

On the prerequisites front, we have 2 items still to land:

  - compaction; Zi Yan is working on a v2

  - numa balancing; A developer has signed up and is working on it (I'll leave
    them to reveal themself as preferred).

Thanks,
Ryan

