Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804707F709D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjKXJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:56:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FC8992
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:56:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35B5D1063;
        Fri, 24 Nov 2023 01:57:32 -0800 (PST)
Received: from [10.57.71.2] (unknown [10.57.71.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09BD53F7A6;
        Fri, 24 Nov 2023 01:56:42 -0800 (PST)
Message-ID: <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
Date:   Fri, 24 Nov 2023 09:56:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-GB
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZV9267tQEhoPzCru@casper.infradead.org>
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

On 23/11/2023 15:59, Matthew Wilcox wrote:
> On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
>> Note: I'm resending this at Andrew's suggestion due to having originally sent
>> it during LPC. I'm hoping its in a position where the feedback is minor enough
>> that I can rework in time for v6.8, but so far haven't had any.
>>
>> Hi All,
>>
>> This is v7 of a series to implement small-sized THP for anonymous memory
>> (previously called "large anonymous folios"). The objective of this is to
> 
> I'm still against small-sized THP.  We've now got people asking whether
> the THP counters should be updated when dealing with large folios that
> are smaller than PMD sized.  It's sowing confusion, and we should go
> back to large anon folios as a name.

I suspect I'm labouring the point here, but I'd like to drill into exactly what
you are objecting to. Is it:

A) Using the name "small-sized THP" (which is currently only used in the commit
logs and a couple of times in the documentation).

B) Exposing the controls for this feature as an extension to the existing
/sys/kernel/mm/transparent_hugepage/* sysfs interface (note the interface never
uses the term "small-sized").

If A) then this is easily solved by choosing another descriptive name and
updating those places. Personally I think it would be best to continue to use
"THP" since we are exposing the feature through that interface. Perhaps "large
folio THP".

If B) we could move the interface to /sys/kernel/mm/large_folio/*, but that
introduces many more banana skins than the current approach IMHO:

  - We would still want to expose the PMD-size large folio through this new
    interface and so would still need "global" or equivalent for at least PMD
    size, but "global" now points to a completely different sibling directory
    structure. And it probably doesn't make any sense for the non-PMD-sizes to
    have "global" because that would imply the THP interface could control the
    non-PMD-sizes, which is what we are trying to separate in the first place.
    So we end up with an asymmetry.

  - When we get to adding other feature support for the smaller sizes (e.g.
    khugepaged), we will end up having to duplicate all the controls from
    transparent_hugepage/* to large_folio/*, then we have the problem that e.g.
    scan rates could differ and we would end up needing 2 separate daemons.

On the interface, David and I did request feedback on the proposal a number of
times before I coded it up.

I'm sure all solvable eventually, but I personally think it is overall simpler
and more understandable as it is. I also agree with the other points raised in
favor of "small-sized THP".

Thanks,
Ryan
