Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1F7F9D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjK0KbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjK0KbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:31:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB4F7EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:31:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF9692F4;
        Mon, 27 Nov 2023 02:31:53 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E6A23F73F;
        Mon, 27 Nov 2023 02:31:03 -0800 (PST)
Message-ID: <51e6c9f1-e863-464b-b5f3-d7f60a7ebed6@arm.com>
Date:   Mon, 27 Nov 2023 10:31:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-GB
To:     Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
 <ZWDG6BYqmZVpyTLL@casper.infradead.org>
 <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
 <87sf4rppuc.fsf@nvdebian.thelocal>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87sf4rppuc.fsf@nvdebian.thelocal>
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

On 27/11/2023 08:20, Alistair Popple wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 24.11.23 16:53, Matthew Wilcox wrote:
>>> On Fri, Nov 24, 2023 at 04:25:38PM +0100, David Hildenbrand wrote:
>>>> On 24.11.23 16:13, Matthew Wilcox wrote:
>>>>> On Fri, Nov 24, 2023 at 09:56:37AM +0000, Ryan Roberts wrote:
>>>>>> On 23/11/2023 15:59, Matthew Wilcox wrote:
>>>>>>> On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
>>>>>>>> This is v7 of a series to implement small-sized THP for anonymous memory
>>>>>>>> (previously called "large anonymous folios"). The objective of this is to
>>>>>>>
>>>>>>> I'm still against small-sized THP.  We've now got people asking whether
>>>>>>> the THP counters should be updated when dealing with large folios that
>>>>>>> are smaller than PMD sized.  It's sowing confusion, and we should go
>>>>>>> back to large anon folios as a name.
>>>>>>
>>>>>> I suspect I'm labouring the point here, but I'd like to drill into exactly what
>>>>>> you are objecting to. Is it:
>>>>>>
>>>>>> A) Using the name "small-sized THP" (which is currently only used in the commit
>>>>>> logs and a couple of times in the documentation).
>>>>>
>>>>> Yes, this is what I'm objecting to.
>>>>
>>>> I'll just repeat that "large anon folio" is misleading, because
>>>> * we already have "large anon folios" in hugetlb
>>> We do?  Where?
>>
>> MAP_PRIVATE of hugetlb. hugepage_add_anon_rmap() instantiates them.
>>
>> Hugetlb is likely one of the oldest user of compund pages aka large folios.
> 
> I don't like "large anon folios" because it seems to confuse collegaues
> when explaining that large anon folios are actually smaller than the
> existing Hugetlb/THP size. I suspect this is because they already assume
> large folios are used for THP. I guess this wouldn't be an issue if
> everyone assumed THP was implemented with huge folios, but that doesn't
> seem to be the case for me at least. Likely because the default THP size
> is often 2MB, which is hardly huge.
> 
>>>
>>>> * we already have PMD-sized "large anon folios" in THP
>>> Right, those are already accounted as THP, and that's what users
>>> expect.
>>> If we're allocating 1024 x 64kB chunks of memory, the user won't be able
>>> to distinguish that from 32 x 2MB chunks of memory, and yet the
>>> performance profile for some applications will be very different.
>>
>> Very right, and because there will be a difference between 1024 x
>> 64kB, 2048 x 32 kB and so forth, we need new memory stats either way.
>>
>> Ryan had some ideas on that, but currently, that's considered future
>> work, just like it likely is for the pagecache as well and needs much
>> more thoughts.
>>
>> Initially, the admin will have to enable all that for anon either
>> way. It all boils down to one memory statistic for anon memory
>> (AnonHugePages) that's messed-up already.
>>
>>>
>>>> But inn the end, I don't care how we will call this in a commit message.
>>>>
>>>> Just sticking to what we have right now makes most sense to me.
>>>>
>>>> I know, as the creator of the term "folio" you have to object :P Sorry ;)
>>> I don't care if it's called something to do with folios or not.  I
>>
>> Good!
>>
>>> am objecting to the use of the term "small THP" on the grounds of
>>> confusion and linguistic nonsense.
>>
>> Maybe that's the reason why FreeBSD calls them "medium-sized
>> superpages", because "Medium-sized" seems to be more appropriate to
>> express something "in between".
> 
> Transparent Medium Pages?

I don't think this is future proof; If we are going to invent a new term, it
needs to be indpendent of size to include all sizes including PMD-size and
perhaps in future, bigger-than-PMD-size. I think generalizing the meaning of
"huge" in THP to mean "bigger than the base page" is the best way to do this.
Then as David says, over time people will qualify it with a specific size when
appropriate.

> 
>> So far I thought the reason was because they focused on 64k only.
>>
>> Never trust a German guy on naming suggestions. John has so far been
>> my naming expert, so I'm hoping he can help.
> 
> Likewise :-)
> 
>> "Sub-pmd-sized THP" is just mouthful. But then, again, this is would
>> just be a temporary name, and in the future THP will just naturally
>> come in multiple sizes (and others here seem to agree on that).

I actually don't mind "sub-pmd-sized THP" given the few locations its actually
going to live.

>>
>>
>> But just to repeat: I don't think there is need to come up with new
>> terminology and that there will be mass-confusion. So far I've not
>> heard a compelling argument besides "one memory counter could confuse
>> an admin that explicitly enables that new behavior.".
>>
>> Side note: I'm, happy that we've reached a stage where we're
>> nitpicking on names :)
> 

Agreed. We are bikeshedding here. But if we really can't swallow "small-sized
THP" then perhaps the most efficient way to move this forwards is to review the
documentation (where "small-sized THP" appears twice in order to differentiate
from PMD-sized THP) - its in patch 3. Perhaps it will be easier to come up with
a good description in the context of those prose? Then once we have that,
hopefully a term will fall out that I'll update the commit logs with.

