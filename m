Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB37EAE78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjKNK6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjKNK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:57:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C12E61985
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:57:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9D0CC15;
        Tue, 14 Nov 2023 02:57:56 -0800 (PST)
Received: from [10.1.27.144] (XHFQ2J9959.cambridge.arm.com [10.1.27.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DA963F641;
        Tue, 14 Nov 2023 02:57:09 -0800 (PST)
Message-ID: <181a25c2-219e-4af9-9f8e-e5f514bbc4b6@arm.com>
Date:   Tue, 14 Nov 2023 10:57:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-GB
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com>
 <ZVGxkMeY50JSesaj@casper.infradead.org>
 <f1fa098b-210e-41a9-80fc-aec212976610@arm.com>
 <ZVI65lck7WqsHZwF@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZVI65lck7WqsHZwF@casper.infradead.org>
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

On 13/11/2023 15:04, Matthew Wilcox wrote:
> On Mon, Nov 13, 2023 at 10:19:48AM +0000, Ryan Roberts wrote:
>> On 13/11/2023 05:18, Matthew Wilcox wrote:
>>> My hope is to abolish the 64kB page size configuration.  ie instead of
>>> using the mixture of page sizes that you currently are -- 64k and
>>> 1M (right?  Order-0, and order-4)
>>
>> Not quite; the contpte-size for a 64K page size is 2M/order-5. (and yes, it is
>> 64K/order-4 for a 4K page size, and 2M/order-7 for a 16K page size. I agree that
>> intuitively you would expect the order to remain constant, but it doesn't).
>>
>> The "recommend" setting above will actually enable order-3 as well even though
>> there is no HW benefit to this. So the full set of available memory sizes here is:
>>
>> 64K/order-0, 512K/order-3, 2M/order-5, 512M/order-13
>>
>>> , that 4k, 64k and 2MB (order-0,
>>> order-4 and order-9) will provide better performance.
>>>
>>> Have you run any experiements with a 4kB page size?
>>
>> Agree that would be interesting with 64K small-sized THP enabled. And I'd love
>> to get to a world were we universally deal in variable sized chunks of memory,
>> aligned on 4K boundaries.
>>
>> In my experience though, there are still some performance benefits to 64K base
>> page vs 4K+contpte; the page tables are more cache efficient for the former case
>> - 64K of memory is described by 8 bytes in the former vs 8x16=128 bytes in the
>> latter. In practice the HW will still only read 8 bytes in the latter but that's
>> taking up a full cache line vs the former where a single cache line stores 8x
>> 64K entries.
> 
> This is going to depend on your workload though -- if you're using more
> 2MB than 64kB, you get to elide a layer of page table with 4k base,
> rather than taking up 4 cache lines with a 64k base.

True, but again depending on workload/config, you may have few levels of lookup
for the 64K native case in the first place because you consume more VA bits at
each level.

