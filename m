Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFC9791575
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjIDKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjIDKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:05:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79023E1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 03:05:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34EEA143D;
        Mon,  4 Sep 2023 03:05:46 -0700 (PDT)
Received: from [10.57.65.16] (unknown [10.57.65.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 995A13F793;
        Mon,  4 Sep 2023 03:05:05 -0700 (PDT)
Message-ID: <61f875fe-d2e0-4a46-baeb-b6cd7b765267@arm.com>
Date:   Mon, 4 Sep 2023 11:05:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-GB
To:     Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Zi Yan <ziy@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com>
 <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
 <CAHbLzkog9B_NWhvYmb7=n3Fnb0oER-sXhE3=Nyx_8Kc3-dggcQ@mail.gmail.com>
 <ZPINmXyTgy2wqLqr@casper.infradead.org>
 <CAHbLzkpQ-qzFpc0nntoodRMunTtgRKHQCfV8ubXwQQeVVNo+uw@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHbLzkpQ-qzFpc0nntoodRMunTtgRKHQCfV8ubXwQQeVVNo+uw@mail.gmail.com>
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

On 01/09/2023 18:18, Yang Shi wrote:
> On Fri, Sep 1, 2023 at 9:13 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Thu, Aug 31, 2023 at 10:15:09AM -0700, Yang Shi wrote:
>>> On Thu, Aug 31, 2023 at 12:57 AM David Hildenbrand <david@redhat.com> wrote:
>>>> Let's talk about that in a bi-weekly MM session. (I proposed it as a
>>>> topic for next week).
>>>>
>>>> As raised in another mail, we can then discuss
>>>> * how we want to call this feature (transparent large pages? there is
>>>>    the concern that "THP" might confuse users. Maybe we can consider
>>>>    "large" the more generic version and "huge" only PMD-size, TBD)
>>>
>>> I tend to agree. "Huge" means PMD-mappable (transparent or HugeTLB),
>>> "Large" means any order but less than PMD-mappable order, "Gigantic"
>>> means PUD mappable. This should incur the least confusion IMHO.
>>
>> "Large" means any order > 0.  The limitation to <= PMD_ORDER is simply
>> because I don't want to go through the whole VM and fix all the places
>> that assume that pmd_page() returns a head page.  The benefit to doing so
>> is quite small, and the work to achieve it is quite large.  The amount of
>> work needed should decrease over time as we convert more code to folios,
>> so deferring it is the right decision today.
> 
> Yeah, I agree. And we are on the same page.
> 
>>
>> But nobody should have the impression that large folios are smaller
>> than PMD size, nor even less than or equal.  Just like they shouldn't
>> think that large folios depend on CONFIG_TRANSPARENT_HUGEPAGE.  They do
>> today, but that's purely an implementation detail that will be removed
>> eventually.
> 
> Yes, THP should be just a special case of large folio from page table
> point of view (for example, PMD-mappable vs non-PMD-mappable).
> 
>>
>>>> I think there *really* has to be a way to disable it for a running
>>>> system, otherwise no distro will dare pulling it in, even after we
>>>> figured out the other stuff.
>>>
>>> TBH I really don't like to tie large folio to THP toggles. THP
>>> (PMD-mappable) is just a special case of LAF. The large folio should
>>> be tried whenever it is possible ideally. But I do agree we may not be
>>> able to achieve the ideal case at the time being, and also understand
>>> the concern about regression in early adoption, so a knob that can
>>> disable large folio may be needed for now. But it should be just a
>>> simple binary knob (on/off), and should not be a part of kernel ABI
>>> (temporary and debugging only) IMHO.
>>
>> Best of luck trying to remove it after you've shipped it ... we've
>> never been able to remove any of the THP toggles, only make them more
>> complicated.
> 
> Fingers crossed... and my point is we should try to avoid making
> things more complicated. It may be hard...
> 
>>
>>> One more thing we may discuss is whether huge page madvise APIs should
>>> take effect for large folio or not.
>>
>> They already do for file large folios; we listen to MADV_HUGEPAGE and
>> attempt to allocate PMD_ORDER folios for faults.
> 
> OK, file folio may be simpler than anonymous. For anonymous folio,
> there may be two potential cases depending on our choice:
> 
> Tie large folio to THP knobs:
> MADV_HUGEPAGE - large folio if THP is on/no large folio if THP is off
> MADV_NOHUGEPAGE - no large folio
> 
> Not tie large folio to THP knob:
> MADV_HUGEPAGE - always large folio
> MADV_NOHUGEPAGE - shall create large folio?
> 

In my mind, the debate on how LAF and MADV_NOHUGEPAGE should interact is
concluded; David has explained a QEMU live migration use case, which would break
if a LAF was allocated for a VMA with MADV_NOHUGEPAGE (see [1]).

Given LAF and THP controls must be tied together at MADV_NOHUGEPAGE as a
minimum, then for me it makes most sense to expose LAF to user space as a
generalization of THP rather than a separate, independent feature. And if taking
such a route, Huang Ying's suggestion at [2] sounds like a good starting point.

Anyway, let's discuss in the mm meeting as David requested.


[1]
https://lore.kernel.org/linux-mm/b936041c-08a7-e844-19e7-eafc4ddf63b9@redhat.com/
[2]
https://lore.kernel.org/linux-mm/87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com/

