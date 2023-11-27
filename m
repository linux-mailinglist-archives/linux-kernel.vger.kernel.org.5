Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3A7FA3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjK0OyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjK0OyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:54:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AD8C99
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:54:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F1AC2F4;
        Mon, 27 Nov 2023 06:55:17 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B814D3F6C4;
        Mon, 27 Nov 2023 06:54:26 -0800 (PST)
Message-ID: <28bc0263-c297-4392-b70a-df8214ca1a67@arm.com>
Date:   Mon, 27 Nov 2023 14:54:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 10/10] selftests/mm/cow: Add tests for anonymous
 small-sized THP
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
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-11-ryan.roberts@arm.com>
 <8dd0f52c-d261-4541-930f-bd4e5921be5b@arm.com>
 <13a2ce75-b1c0-4930-8911-36ded0b428a7@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <13a2ce75-b1c0-4930-8911-36ded0b428a7@redhat.com>
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

On 27/11/2023 14:50, David Hildenbrand wrote:
> On 27.11.23 15:02, Ryan Roberts wrote:
>> On 22/11/2023 16:29, Ryan Roberts wrote:
>>> Add tests similar to the existing PMD-sized THP tests, but which operate
>>> on memory backed by (PTE-mapped) small-sized THP. This reuses all the
>>> existing infrastructure. If the test suite detects that small-sized THP
>>> is not supported by the kernel, the new tests are skipped.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>   tools/testing/selftests/mm/cow.c | 71 +++++++++++++++++++++++++++++++-
>>>   1 file changed, 70 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>>> index d03c453cfd5c..3efc395c7077 100644
>>> --- a/tools/testing/selftests/mm/cow.c
>>> +++ b/tools/testing/selftests/mm/cow.c
>>> @@ -29,15 +29,49 @@
>>>   #include "../../../../mm/gup_test.h"
>>>   #include "../kselftest.h"
>>>   #include "vm_util.h"
>>> +#include "thp_settings.h"
>>>
>>>   static size_t pagesize;
>>>   static int pagemap_fd;
>>>   static size_t pmdsize;
>>> +static int nr_thpsmallsizes;
>>> +static size_t thpsmallsizes[20];
>>
>> Off the back of some comments David made againt the previous patch [1], I'm
>> proposing to rework this a bit so that ALL thp sizes are stored in this array,
>> not just the non-PMD-sized sizes. This makes the changes overall a bit smaller
>> and easier to understand, I think...
>>
>>>   static int nr_hugetlbsizes;
>>>   static size_t hugetlbsizes[10];
>>>   static int gup_fd;
>>>   static bool has_huge_zeropage;
>>>
>>> +static int sz2ord(size_t size)
>>> +{
>>> +    return __builtin_ctzll(size / pagesize);
>>> +}
>>> +
>>> +static int detect_smallthp_sizes(size_t sizes[], int max)
>>
>> This changes to detect_thp_sizes() and deposits all sizes in sizes[]
> 
> Just what I wanted to propose :) Makes it simpler by removing the "small"
> terminology and just detecting thp sizes.

Great! All done and queued up for the next version. Just waiting for some
feedback on the 2 crucial patches in this series (3 & 4) :)

