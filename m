Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA84C7FC1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346846AbjK1Pev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346835AbjK1Pes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:34:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7A89D1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:34:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F36C15;
        Tue, 28 Nov 2023 07:35:42 -0800 (PST)
Received: from [10.1.33.188] (XHFQ2J9959.cambridge.arm.com [10.1.33.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2B783F6C4;
        Tue, 28 Nov 2023 07:34:51 -0800 (PST)
Message-ID: <f4c3972e-f341-4d15-baa2-bedda8d7a8ad@arm.com>
Date:   Tue, 28 Nov 2023 15:34:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <137902b6-24dc-4d51-9be2-6f94aa9dbc3a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 14:09, David Hildenbrand wrote:
> On 28.11.23 13:15, Ryan Roberts wrote:
>> On 28/11/2023 08:48, David Hildenbrand wrote:
>>>
>>>>>
>>>>> Agreed. We are bikeshedding here. But if we really can't swallow "small-sized
>>>>> THP" then perhaps the most efficient way to move this forwards is to review
>>>>> the
>>>>> documentation (where "small-sized THP" appears twice in order to differentiate
>>>>> from PMD-sized THP) - its in patch 3. Perhaps it will be easier to come up
>>>>> with
>>>>> a good description in the context of those prose? Then once we have that,
>>>>> hopefully a term will fall out that I'll update the commit logs with.
>>>>>
>>>>
>>>> I will see you over in patch 3, then. I've already looked at it and am going
>>>> to suggest a long and a short name. The long name is for use in comments and
>>>> documentation, and the short name is for variable fragments:
>>>>
>>>>        Long name:  "pte-mapped THPs"
>>>>        Short names: pte_thp, or pte-thp
>>>
>>> The issue is that any THP can be pte-mapped, even a PMD-sized THP. However, the
>>> "natural" way to map a PMD-sized THP is using a PMD.
>>>
>>
>> How about we just stop trying to come up with a term for the "small-sized THP"
>> vs "PMD-sized THP" and instead invent a name that covers ALL THP:
>>
>> "multi-size THP" vs "PMD-sized THP".
>>
>> Then in the docs we can talk about how multi-size THP introduces the ability to
>> allocate memory in blocks that are bigger than a base page but smaller than
>> traditional PMD-size, in increments of a power-of-2 number of pages.
> 
> So you're thinking of something like "multi-size THP" as a feature name, and
> stating that for now we limit it to <= PMD size. mTHP would be the short name?

Sure.

> 
> For the stats, we'd document that "AnonHugePages" and friends only count
> traditional PMD-sized THP for historical reasons -- and that AnonHugePages
> should have been called AnonHugePmdMapped (which we could still add as an alias
> and document why AnonHugePages is weird).

Sounds good to me.

> 
> Regarding new stats, maybe an interface that indicates the actual sizes would be
> best. As discussed, extending the existing single-large-file statistics might
> not be possible and we'd have to come up with a new interface, that maybe
> completely lacks "AnonHugePages" and directly goes for the individual sizes.

Yes, but I think we are agreed this is future work.

