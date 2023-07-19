Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5979759A27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjGSPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGSPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:49:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D3A0197
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:49:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 428F92F4;
        Wed, 19 Jul 2023 08:49:58 -0700 (PDT)
Received: from [10.57.76.81] (unknown [10.57.76.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 336EC3F67D;
        Wed, 19 Jul 2023 08:49:12 -0700 (PDT)
Message-ID: <a8f567b0-3501-7f1b-7e14-e0e5fb205a59@arm.com>
Date:   Wed, 19 Jul 2023 16:49:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
 <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
 <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
 <ZKgPIXSrxqymWrsv@casper.infradead.org>
 <bfa13f35-bca9-c4e8-25f3-e8021f85f223@redhat.com>
 <C56EA745-E112-4887-8C22-B74FCB6A14EB@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <C56EA745-E112-4887-8C22-B74FCB6A14EB@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 17:53, Zi Yan wrote:
> On 7 Jul 2023, at 9:24, David Hildenbrand wrote:
> 
>> On 07.07.23 15:12, Matthew Wilcox wrote:
>>> On Fri, Jul 07, 2023 at 01:40:53PM +0200, David Hildenbrand wrote:
>>>> On 06.07.23 10:02, Ryan Roberts wrote:
>>>> But can you comment on the page migration part (IOW did you try it already)?
>>>>
>>>> For example, memory hotunplug, CMA, MCE handling, compaction all rely on
>>>> page migration of something that was allocated using GFP_MOVABLE to actually
>>>> work.
>>>>
>>>> Compaction seems to skip any higher-order folios, but the question is if the
>>>> udnerlying migration itself works.
>>>>
>>>> If it already works: great! If not, this really has to be tackled early,
>>>> because otherwise we'll be breaking the GFP_MOVABLE semantics.
>>>
>>> I have looked at this a bit.  _Migration_ should be fine.  _Compaction_
>>> is not.
>>
>> Thanks! Very nice if at least ordinary migration works.
>>
>>>
>>> If you look at a function like folio_migrate_mapping(), it all seems
>>> appropriately folio-ised.  There might be something in there that is
>>> slightly wrong, but that would just be a bug to fix, not a huge
>>> architectural problem.
>>>
>>> The problem comes in the callers of migrate_pages().  They pass a
>>> new_folio_t callback.  alloc_migration_target() is the usual one passed
>>> and as far as I can tell is fine.  I've seen no problems reported with it.
>>>
>>> compaction_alloc() is a disaster, and I don't know how to fix it.
>>> The compaction code has its own allocator which is populated with order-0
>>> folios.  How it populates that freelist is awful ... see split_map_pages()
>>
>> Yeah, all that code was written under the assumption that we're moving order-0 pages (which is what the anon+pagecache pages part).
>>
>> From what I recall, we're allocating order-0 pages from the high memory addresses, so we can migrate from low memory addresses, effectively freeing up low memory addresses and filling high memory addresses.
>>
>> Adjusting that will be ... interesting. Instead of allocating order-0 pages from high addresses, we might want to allocate "as large as possible" ("grab what we can") from high addresses and then have our own kind of buddy for allocating from that pool a compaction destination page, depending on our source page. Nasty.
> 
> We probably do not need a pool, since before migration, we have isolated folios to
> be migrated and can come up with a stats on how many folios there are at each order.
> Then, we can isolate free pages based on the stats and do not split free pages
> all the way down to order-0. We can sort the source folios based on their orders
> and isolate free pages from largest order to smallest order. That could avoid
> a free page pool.

Hi Zi, I just wanted to check; is this something you are working on or planning
to work on? I'm trying to maintain a list of all the items that need to get
sorted for large anon folios. It would be great to put your name against it! ;-)

> 
> --
> Best Regards,
> Yan, Zi

