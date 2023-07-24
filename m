Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF075FB07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjGXPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGXPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:42:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0920C10E4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:42:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D774AFEC;
        Mon, 24 Jul 2023 08:42:42 -0700 (PDT)
Received: from [10.57.76.172] (unknown [10.57.76.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FC643F67D;
        Mon, 24 Jul 2023 08:41:56 -0700 (PDT)
Message-ID: <34979a4c-0bab-fbb9-f8dd-ab3da816de52@arm.com>
Date:   Mon, 24 Jul 2023 16:41:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/4] variable-order, large folios for anonymous memory
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <83bb1b99-81d3-0f32-4bf2-032cb512a1a1@arm.com>
 <2FCD9E8A-D38A-40C4-9825-AE7ECEEFC715@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2FCD9E8A-D38A-40C4-9825-AE7ECEEFC715@nvidia.com>
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

On 24/07/2023 15:58, Zi Yan wrote:
> On 24 Jul 2023, at 7:59, Ryan Roberts wrote:
> 
>> On 14/07/2023 17:04, Ryan Roberts wrote:
>>> Hi All,
>>>
>>> This is v3 of a series to implement variable order, large folios for anonymous
>>> memory. (currently called "FLEXIBLE_THP") The objective of this is to improve
>>> performance by allocating larger chunks of memory during anonymous page faults.
>>> See [1] and [2] for background.
>>
>> A question for anyone that can help; I'm preparing v4 and as part of that am
>> running the mm selftests, now that I've fixed them  up to run reliably for
>> arm64. This is showing 2 regressions vs the v6.5-rc3 baseline:
>>
>> 1) khugepaged test fails here:
>> # Run test: collapse_max_ptes_none (khugepaged:anon)
>> # Maybe collapse with max_ptes_none exceeded.... Fail
>> # Unexpected huge page
>>
>> 2) split_huge_page_test fails with:
>> # Still AnonHugePages not split
>>
>> I *think* (but haven't yet verified) that (1) is due to khugepaged ignoring
>> non-order-0 folios when looking for candidates to collapse. Now that we have
>> large anon folios, the memory allocated by the test is in large folios and
>> therefore does not get collapsed. We understand this issue, and I believe
>> DavidH's new scheme for determining exclusive vs shared should give us the tools
>> to solve this.
>>
>> But (2) is weird. If I run this test on its own immediately after booting, it
>> passes. If I then run the khugepaged test, then re-run this test, it fails.
>>
>> The test is allocating 4 hugepages, then requesting they are split using the
>> debugfs interface. Then the test looks at /proc/self/smaps to check that
>> AnonHugePages is back to 0.
>>
>> In both the passing and failing cases, the kernel thinks that it has
>> successfully split the pages; the debug logs in split_huge_pages_pid() confirm
>> this. In the failing case, I wonder if somehow khugepaged could be immediately
>> re-collapsing the pages before user sapce can observe the split? Perhaps the
>> failed khugepaged test has left khugepaged in an "awake" state and it
>> immediately pounces?
> 
> This is more likely to be a stats issue. Have you checked smap to see if
> AnonHugePages is 0 KB by placing a getchar() before the exit(EXIT_FAILURE)?

Yes - its still 8192K. But looking at the code that value is determined from the
fact that there is a PMD block mapping present. And the split definitely
succeeded so something must have re-collapsed it.

Looking into the khugepaged test suite, it saves the thp and khugepaged settings
out of sysfs, modifies them for the tests, then restores them when finished. But
it doesn't restore if exiting early (due to failure). It changes the settings
for alloc_sleep_millisecs and scan_sleep_millisecs from a large number of
seconds to 10 ms, for example. So I'm pretty sure this is the culprit.


> Since split_huge_page_test checks that stats to make sure the split indeed
> happened.
> 
> --
> Best Regards,
> Yan, Zi

