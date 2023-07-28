Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84433766803
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjG1JAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjG1JA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:00:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE72DE69
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:00:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDCB32F4;
        Fri, 28 Jul 2023 02:01:07 -0700 (PDT)
Received: from [10.57.77.173] (unknown [10.57.77.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240D23F67D;
        Fri, 28 Jul 2023 02:00:23 -0700 (PDT)
Message-ID: <3c26aa4e-fe11-09d2-c2fb-63546ba80893@arm.com>
Date:   Fri, 28 Jul 2023 10:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] mm: Implement folio_remove_rmap_range()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230720112955.643283-1-ryan.roberts@arm.com>
 <20230720112955.643283-3-ryan.roberts@arm.com>
 <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
 <ZMFNgmlT1JpI0z5+@casper.infradead.org>
 <87r0ouw39n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZMHX+O0wmjuPXdTi@casper.infradead.org>
 <faf8d723-afb8-ac4e-7861-4004bb78c5a9@arm.com>
 <CAOUHufa38H0o0ZoX-KYMSeAiJghMWtjfHM2F4OjUZ-a--_Kt_w@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufa38H0o0ZoX-KYMSeAiJghMWtjfHM2F4OjUZ-a--_Kt_w@mail.gmail.com>
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

On 27/07/2023 17:38, Yu Zhao wrote:
> On Thu, Jul 27, 2023 at 1:26 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 27/07/2023 03:35, Matthew Wilcox wrote:
>>> On Thu, Jul 27, 2023 at 09:29:24AM +0800, Huang, Ying wrote:
>>>> Matthew Wilcox <willy@infradead.org> writes:
>>>>> I think that can make sense.  Because we limit to a single page table,
>>>>> specifying 'nr = 1 << PMD_ORDER' is the same as 'compound = true'.
>>>>> Just make it folio, page, nr, vma.  I'd actually prefer it as (vma,
>>>>> folio, page, nr), but that isn't the convention we've had in rmap up
>>>>> until now.
>>>>
>>>> IIUC, even if 'nr = 1 << PMD_ORDER', we may remove one PMD 'compound'
>>>> mapping, or 'nr' PTE mapping.  So, we will still need 'compound' (or
>>>> some better name) as parameter.
>>>
>>> Oh, this is removing ... so you're concerned with the case where we've
>>> split the PMD into PTEs, but all the PTEs are still present in a single
>>> page table?  OK, I don't have a good answer to that.  Maybe that torpedoes
>>> the whole idea; I'll think about it.
>>
>> This is exactly why I think the approach I've already taken is the correct one;
>> a 'range' makes no sense when you are dealing with 'compound' pages because you
>> are accounting the entire folio. So surely its better to reflect that by only
>> accounting small pages in the range version of the API.
> 
> If the argument is the compound case is a separate one, then why not a
> separate API for it?
> 
> I don't really care about whether we think 'range' makes sense for
> 'compound' or not. What I'm saying is:
> 1. if they are considered one general case, then one API with the
> compound parameter.
> 2. if they are considered two specific cases, there should be two APIs.
> This common design pattern is cleaner IMO.

Option 2 definitely makes sense to me and I agree that it would be cleaner to
have 2 separate APIs, one for small-page accounting (which can accept a range
within a folio) and one for large-page accounting (i.e. compound=true in today's
API).

But...

1) That's not how the rest of the rmap API does it

2) This would be a much bigger change since I'm removing an existing API and
replacing it with a completely new one (there are ~20 call sites to fix up). I
was trying to keep the change small and manageable by maintaining the current
API but moving all the small-page logic to the new API, so the old API is a
wrapper in that case.

3) You would also need an API for the hugetlb case, which page_remove_rmap()
handles today. Perhaps that could also be done by the new API that handles the
compound case. But then you are mixing and matching your API styles - one caters
for 1 specific case, and the other caters for 2 cases and figures out which one.

> 
> Right now we have an overlap (redundancy) -- people would have to do
> two code searches: one for page_remove_rmap() and the other for
> folio_remove_rmap_range(nr=1), and this IMO is a bad design pattern.

I'm open to doing the work to remove this redundancy, but I'd like to hear
concensus on this thread that its the right approach first. Although personally
I don't see a problem with what I've already done; If you want to operate on a
page (inc the old concept of a "compound page" and a hugetlb page) call the old
one. If you want to operate on a range of pages in a folio, call the new one.

Thanks,
Ryan

