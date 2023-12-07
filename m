Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920A1808B83
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjLGPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjLGPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:12:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECC26D5B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:12:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6611042;
        Thu,  7 Dec 2023 07:12:57 -0800 (PST)
Received: from [10.1.32.134] (XHFQ2J9959.cambridge.arm.com [10.1.32.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 769EC3F762;
        Thu,  7 Dec 2023 07:12:08 -0800 (PST)
Message-ID: <787eb131-759c-4cd3-a2b7-39caf818cffc@arm.com>
Date:   Thu, 7 Dec 2023 15:12:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-GB
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-5-ryan.roberts@arm.com>
 <71040a8c-4ea1-4f21-8ac8-65f7c25c217e@redhat.com>
 <f2896d7f-183b-48fb-a3aa-d21bf2257043@arm.com>
 <ca649aad-7b76-4c6d-b513-26b3d58f8e68@redhat.com>
 <126c3b71-1acc-4851-9986-4228cb8a8660@arm.com>
 <94806b4f-2370-4999-9586-2c936955cb87@redhat.com>
 <3d49bcbf-1f9b-48e8-a91a-ede0762b795c@arm.com>
 <369ec8d3-ef6a-4a4e-84e2-2c91b8293929@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <369ec8d3-ef6a-4a4e-84e2-2c91b8293929@redhat.com>
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

On 07/12/2023 15:01, David Hildenbrand wrote:
> On 07.12.23 15:45, Ryan Roberts wrote:
>> On 07/12/2023 13:28, David Hildenbrand wrote:
>>>>>
>>>>> Right, but you know from the first loop which order is applicable (and will be
>>>>> fed to the second loop) and could just pte_unmap(pte) + tryalloc. If that
>>>>> fails,
>>>>> remap and try with the next orders.
>>>>
>>>> You mean something like this?
>>>>
>>>>      pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>>      if (!pte)
>>>>          return ERR_PTR(-EAGAIN);
>>>>
>>>>      order = highest_order(orders);
>>>>      while (orders) {
>>>>          addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>>>          if (!pte_range_none(pte + pte_index(addr), 1 << order)) {
>>>>              order = next_order(&orders, order);
>>>>              continue;
>>>>          }
>>>>
>>>>          pte_unmap(pte);
>>>>                  folio = vma_alloc_folio(gfp, order, vma, addr, true);
>>>>          if (folio) {
>>>>              clear_huge_page(&folio->page, vmf->address, 1 << order);
>>>>              return folio;
>>>>          }
>>>>
>>>>          pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>>          if (!pte)
>>>>              return ERR_PTR(-EAGAIN);
>>>>
>>>>          order = next_order(&orders, order);
>>>>      }
>>>>
>>>>      pte_unmap(pte);
>>>>
>>>> I don't really like that because if high order folio allocations fail, then you
>>>> are calling pte_range_none() again for the next lower order; once that check
>>>> has
>>>> succeeded for an order it shouldn't be required for any lower orders. In this
>>>> case you also have lots of pte map/unmap.
>>>
>>> I see what you mean.
>>>
>>>>
>>>> The original version feels more efficient to me.
>>> Yes it is. Adding in some comments might help, like
>>>
>>> /*
>>>   * Find the largest order where the aligned range is completely prot_none().
>>> Note
>>>   * that all remaining orders will be completely prot_none().
>>>   */
>>> ...
>>>
>>> /* Try allocating the largest of the remaining orders. */
>>
>> OK added.
>>
>>>
>>>>
>>>>>
>>>>> That would make the code certainly easier to understand. That "orders"
>>>>> magic of
>>>>> constructing, filtering, walking is confusing :)
>>>>>
>>>>>
>>>>> I might find some time today to see if there is an easy way to cleanup all
>>>>> what
>>>>> I spelled out above. It really is a mess. But likely that cleanup could be
>>>>> deferred (but you're touching it, so ... :) ).
>>>>
>>>> I'm going to ignore the last 5 words. I heard the "that cleanup could be
>>>> deferred" part loud and clear though :)
>>>
>>> :)
>>>
>>> If we could stop passing orders into thp_vma_allowable_orders(), that would
>>> probably
>>> be the biggest win. It's just all a confusing mess.
>>
>>
>>
>> I tried an approach like you suggested in the other thread originally, but I
>> struggled to define exactly what "thp_vma_configured_orders()" should mean;
>> Ideally, I just want "all the THP orders that are currently enabled for this
>> VMA+flags". But some callers want to enforce_sysfs and others don't, so you
>> probably have to at least pass that flag. Then you have DAX which explicitly
> 
> Yes, the flags would still be passed. It's kind of the "context".
> 
>> ignores enforce_sysfs, but only in a page fault. And shmem, which ignores
>> enforce_sysfs, but only outside of a page fault. So it quickly becomes pretty
>> complex. It is basically thp_vma_allowable_orders() as currently defined.
> 
> Yeah, but moving the "can we actually fit a THP in there" check out of the picture.
> 
>>
>> If this could be a simple function then it could be inline and as you say, we
>> can do the masking in the caller and exit early for the order-0 case. But it is
>> very complex (at least if you want to retain the equivalent logic to what
>> thp_vma_allowable_orders() has) so I'm not sure how to do the order-0 early exit
>> without passing in the orders bitfield. And we are unlikely to exit early
>> because PMD-sized THP is likely enabled and because we didn't pass in a orders
>> bitfield, that wasn't filtered out.
>>
>> In short, I can't see a solution that's better than the one I have. But if you
>> have something in mind, if you can spell it out, then I'll have a go at tidying
>> it up and integrating it into the series. Otherwise I really would prefer to
>> leave it for a separate series.
> 
> I'm playing with some cleanups, but they can all be built on top if they
> materialize.

OK, I'm going to post a v9 then. And cross my fingers and hope that's the final
version.

