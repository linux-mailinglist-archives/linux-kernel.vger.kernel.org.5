Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF57FD36B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjK2J7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjK2J7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:59:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 488CA19A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:59:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A16792F4;
        Wed, 29 Nov 2023 02:00:37 -0800 (PST)
Received: from [10.57.70.211] (unknown [10.57.70.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DEA03F5A1;
        Wed, 29 Nov 2023 01:59:47 -0800 (PST)
Message-ID: <832a486c-7f22-49cd-a3f5-3709dc6c6d09@arm.com>
Date:   Wed, 29 Nov 2023 09:59:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-GB
To:     John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
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
 <51e6c9f1-e863-464b-b5f3-d7f60a7ebed6@arm.com>
 <b2d19306-0d68-4aef-9b68-15948ddc8ea0@nvidia.com>
 <afb92816-25ed-41c8-a48b-94fb2d885d8e@redhat.com>
 <58af512c-3d7d-4774-88f7-6336c9384b61@arm.com>
 <137902b6-24dc-4d51-9be2-6f94aa9dbc3a@redhat.com>
 <f4c3972e-f341-4d15-baa2-bedda8d7a8ad@arm.com>
 <47d27539-6cf1-4375-9bbb-2ebb9a2acfb3@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <47d27539-6cf1-4375-9bbb-2ebb9a2acfb3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 18:39, John Hubbard wrote:
> On 11/28/23 07:34, Ryan Roberts wrote:
>> On 28/11/2023 14:09, David Hildenbrand wrote:
>>> On 28.11.23 13:15, Ryan Roberts wrote:
>>>> On 28/11/2023 08:48, David Hildenbrand wrote:
>>>> How about we just stop trying to come up with a term for the "small-sized THP"
>>>> vs "PMD-sized THP" and instead invent a name that covers ALL THP:
>>>>
>>>> "multi-size THP" vs "PMD-sized THP".
>>>>
>>>> Then in the docs we can talk about how multi-size THP introduces the ability to
>>>> allocate memory in blocks that are bigger than a base page but smaller than
>>>> traditional PMD-size, in increments of a power-of-2 number of pages.
>>>
>>> So you're thinking of something like "multi-size THP" as a feature name, and
>>> stating that for now we limit it to <= PMD size. mTHP would be the short name?
>>
>> Sure.
> 
> Sounds workable to me, too.
> 
>>
>>>
>>> For the stats, we'd document that "AnonHugePages" and friends only count
>>> traditional PMD-sized THP for historical reasons -- and that AnonHugePages
>>> should have been called AnonHugePmdMapped (which we could still add as an alias
>>> and document why AnonHugePages is weird).
>>
>> Sounds good to me.
> 
> OK.
> 
>>
>>>
>>> Regarding new stats, maybe an interface that indicates the actual sizes would be
>>> best. As discussed, extending the existing single-large-file statistics might
>>> not be possible and we'd have to come up with a new interface, that maybe
>>> completely lacks "AnonHugePages" and directly goes for the individual sizes.
>>
>> Yes, but I think we are agreed this is future work.
>>
> 
> We do want to have at least some way to verify that mTHP is active from
> day 0, though.

Could you clarify what you mean by "active"?

Current plan is that there will be a per-size
transparent_hugepage/hugepages-<size>kB/enabled sysfs file that can be querried
to see if the size is enabled (available for the kernel to use).

But for this initial submission, we previously agreed (well, at least David and
I) that not having a full set of stats is not a problem - they can come later.
So the only way to verify that the kernel is allocating and mapping a particular
THP size is to parse /proc/<pid>pagemap and look at the PFNs for now. Is that
sufficient?

> 
> 
> thanks,

