Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72235757738
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGRI6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjGRI6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:58:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 428B4172C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:58:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 689522F4;
        Tue, 18 Jul 2023 01:58:52 -0700 (PDT)
Received: from [10.1.34.52] (C02Z41KALVDN.cambridge.arm.com [10.1.34.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88D0C3F67D;
        Tue, 18 Jul 2023 01:58:07 -0700 (PDT)
Message-ID: <7319a1aa-7c72-82e9-f26d-eeccb6fdf35b@arm.com>
Date:   Tue, 18 Jul 2023 09:58:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
 <90b406af-9db4-b668-a7a0-e574e104c84c@redhat.com>
 <028c5f5b-b67c-9ccc-bc06-468f47362999@arm.com>
 <0250a2d7-c79b-0e0f-8161-bf475daf1c82@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <0250a2d7-c79b-0e0f-8161-bf475daf1c82@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 17:48, David Hildenbrand wrote:
> On 17.07.23 18:01, Ryan Roberts wrote:
>> On 17/07/2023 16:42, David Hildenbrand wrote:
>>> On 17.07.23 16:31, Ryan Roberts wrote:
>>>> In preparation for the introduction of large folios for anonymous
>>>> memory, we would like to be able to split them when they have unmapped
>>>> subpages, in order to free those unused pages under memory pressure. So
>>>> remove the artificial requirement that the large folio needed to be at
>>>> least PMD-sized.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> ---
>>>>    mm/rmap.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 0c0d8857dfce..2baf57d65c23 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1430,7 +1430,7 @@ void page_remove_rmap(struct page *page, struct
>>>> vm_area_struct *vma,
>>>>             * page of the folio is unmapped and at least one page
>>>>             * is still mapped.
>>>>             */
>>>> -        if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
>>>> +        if (folio_test_large(folio) && folio_test_anon(folio))
>>>>                if (!compound || nr < nr_pmdmapped)
>>>>                    deferred_split_folio(folio);
>>>
>>> !compound will always be true I guess, so nr_pmdmapped == 0 (which will always
>>> be the case) will be ignored.
>>
>> I don't follow why !compound will always be true. This function is
>> page_remove_rmap() (not folio_remove_rmap_range() which I add in a later patch).
>> page_remove_rmap() can work on pmd-mapped pages where compound=true is passed in.
> 
> I was talking about the folio_test_pmd_mappable() -> folio_test_large() change.
> For folio_test_large() && !folio_test_pmd_mappable() I expect that we'll never
> pass in "compound=true".
> 

Sorry David, I've been staring at the code and your comment, and I still don't
understand your point. I assumed you were trying to say that compound is always
false and therefore "if (!compound || nr < nr_pmdmapped)" can be removed? But
its not the case that compound is always false; it will be true when called to
remove a pmd-mapped compound page. What change are you suggesting, exactly?
