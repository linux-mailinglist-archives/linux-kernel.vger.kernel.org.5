Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B376CC0F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjHBLvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHBLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:51:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71B2D26A1;
        Wed,  2 Aug 2023 04:51:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FB31113E;
        Wed,  2 Aug 2023 04:52:15 -0700 (PDT)
Received: from [10.57.77.90] (unknown [10.57.77.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BE173F6C4;
        Wed,  2 Aug 2023 04:51:29 -0700 (PDT)
Message-ID: <2d64ca09-06fe-a32f-16f9-c277b7033b57@arm.com>
Date:   Wed, 2 Aug 2023 12:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
To:     David Hildenbrand <david@redhat.com>,
        Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, yuzhao@google.com, shy828301@gmail.com
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
 <31093c49-5baa-caed-9871-9503cb89454b@redhat.com>
 <20419779-b5f5-7240-3f90-fe5c4b590e4d@arm.com>
 <2722c9ad-370a-70ff-c374-90a94eca742a@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2722c9ad-370a-70ff-c374-90a94eca742a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 12:36, David Hildenbrand wrote:
> On 02.08.23 13:20, Ryan Roberts wrote:
>> On 02/08/2023 11:48, David Hildenbrand wrote:
>>> On 02.08.23 12:27, Ryan Roberts wrote:
>>>> On 28/07/2023 17:13, Yin Fengwei wrote:
>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>>>>> folio_mapcount() is used to check whether the folio is shared. But it's
>>>>> not correct as folio_mapcount() returns total mapcount of large folio.
>>>>>
>>>>> Use folio_estimated_sharers() here as the estimated number is enough.
>>>>>
>>>>> Yin Fengwei (2):
>>>>>     madvise: don't use mapcount() against large folio for sharing check
>>>>>     madvise: don't use mapcount() against large folio for sharing check
>>>>>
>>>>>    mm/huge_memory.c | 2 +-
>>>>>    mm/madvise.c     | 6 +++---
>>>>>    2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>
>>>> As a set of fixes, I agree this is definitely an improvement, so:
>>>>
>>>> Reviewed-By: Ryan Roberts
>>>>
>>>>
>>>> But I have a couple of comments around further improvements;
>>>>
>>>> Once we have the scheme that David is working on to be able to provide precise
>>>> exclusive vs shared info, we will probably want to move to that. Although that
>>>> scheme will need access to the mm_struct of a process known to be mapping the
>>>
>>> There are probably ways to work around lack of mm_struct, but it would not be
>>> completely for free. But passing the mm_struct should probably be an easy
>>> refactoring.
>>>
>>>> folio. We have that info, but its not passed to folio_estimated_sharers() so we
>>>> can't just reimplement folio_estimated_sharers() - we will need to rework these
>>>> call sites again.
>>>
>>> We should probably just have a
>>>
>>> folio_maybe_mapped_shared()
>>>
>>> with proper documentation. Nobody should care about the exact number.
>>>
>>>
>>> If my scheme for anon pages makes it in, that would be precise for anon pages
>>> and we could document that. Once we can handle pagecache pages as well to get a
>>> precise answer, we could change to folio_mapped_shared() and adjust the
>>> documentation.
>>
>> Makes sense to me. I'm assuming your change would allow us to get rid of
>> PG_anon_exclusive too? In which case we would also want a precise API
>> specifically for anon folios for the CoW case, without waiting for pagecache
>> page support.
> 
> Not necessarily and I'm currently not planning that
> 
> On the COW path, I'm planning on using it only when PG_anon_exclusive is clear
> for a compound page, combined with a check that there are no other page
> references besides from mappings: all mappings from me and #refs == #mappings ->
> reuse (set PG_anon_exclusive). That keeps the default (no fork) as fast as
> possible and simple.
> 
>>>
>>> I just saw
>>>
>>> https://lkml.kernel.org/r/20230802095346.87449-1-wangkefeng.wang@huawei.com
>>>
>>> that converts a lot of code to folio_estimated_sharers().
>>>
>>>
>>> That patchset, for example, also does
>>>
>>> total_mapcount(page) > 1 -> folio_estimated_sharers(folio) > 1
>>>
>>> I'm not 100% sure what to think about that at this point. We eventually add
>>> false negatives (actually shared but we fail to detect it) all over the place,
>>> instead of having false positives (actually exclusive, but we fail to detect
>>> it).
>>>
>>> And that patch set doesn't even spell that out.
>>>
>>>
>>> Maybe it's as good as we will get, especially if my scheme doesn't make it in.
>>
>> I've been working on the assumption that your scheme is plan A, and I'm waiting
>> for it to unblock forward progress on large anon folios. Is this the right
>> approach, or do you think your scheme is sufficiently riskly and/or far out that
>> I should aim not to depend on it?
> 
> It is plan A. IMHO, it does not feel too risky and/or far out at this point --
> and the implementation should not end up too complicated. But as always, I
> cannot promise anything before it's been implemented and discussed upstream.

OK, good we are on the same folio... (stolen from Hugh; if a joke is worth
telling once, its worth telling 1000 times ;-)

> 
> Hopefully, we know more soon. I'll get at implementing it fairly soon.
> 

