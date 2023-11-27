Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232AA7F9DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjK0KsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjK0KsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:48:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C8A210F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:48:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 630E3C15;
        Mon, 27 Nov 2023 02:49:05 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240883F73F;
        Mon, 27 Nov 2023 02:48:15 -0800 (PST)
Message-ID: <15c288aa-feab-4d3a-af33-b87481eaffe3@arm.com>
Date:   Mon, 27 Nov 2023 10:48:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 09/10] selftests/mm/cow: Generalize
 do_run_with_thp() helper
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
 <20231122162950.3854897-10-ryan.roberts@arm.com>
 <ead82cbe-19c9-43ce-9f28-7ced118b130a@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ead82cbe-19c9-43ce-9f28-7ced118b130a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 17:48, David Hildenbrand wrote:
> On 22.11.23 17:29, Ryan Roberts wrote:
>> do_run_with_thp() prepares (PMD-sized) THP memory into different states
>> before running tests. With the introduction of small-sized THP, we would
>> like to reuse this logic to also test those smaller THP sizes. So let's
>> add a size parameter which tells the function what size THP it should
>> operate on.
>>
>> A separate commit will utilize this change to add new tests for
>> small-sized THP, where available.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   tools/testing/selftests/mm/cow.c | 146 +++++++++++++++++--------------
>>   1 file changed, 79 insertions(+), 67 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>> index 7324ce5363c0..d03c453cfd5c 100644
>> --- a/tools/testing/selftests/mm/cow.c
>> +++ b/tools/testing/selftests/mm/cow.c
>> @@ -32,7 +32,7 @@
>>
>>   static size_t pagesize;
>>   static int pagemap_fd;
>> -static size_t thpsize;
>> +static size_t pmdsize;
>>   static int nr_hugetlbsizes;
>>   static size_t hugetlbsizes[10];
>>   static int gup_fd;
>> @@ -734,14 +734,14 @@ enum thp_run {
>>       THP_RUN_PARTIAL_SHARED,
>>   };
>>
>> -static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
>> +static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t size)
> 
> Nit: can we still call it "thpsize" in this function? That makes it clearer IMHO
> and avoids most renaming.

Yep no problem. Will fix in next version.

> 
>>   {
>>       char *mem, *mmap_mem, *tmp, *mremap_mem = MAP_FAILED;
>> -    size_t size, mmap_size, mremap_size;
>> +    size_t mmap_size, mremap_size;
>>       int ret;
>>
>> -    /* For alignment purposes, we need twice the thp size. */
>> -    mmap_size = 2 * thpsize;
>> +    /* For alignment purposes, we need twice the requested size. */
>> +    mmap_size = 2 * size;
>>       mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>>               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>       if (mmap_mem == MAP_FAILED) {
>> @@ -749,36 +749,40 @@ static void do_run_with_thp(test_fn fn, enum thp_run
>> thp_run)
>>           return;
>>       }
>>
>> -    /* We need a THP-aligned memory area. */
>> -    mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
>> +    /* We need to naturally align the memory area. */
>> +    mem = (char *)(((uintptr_t)mmap_mem + size) & ~(size - 1));
>>
>> -    ret = madvise(mem, thpsize, MADV_HUGEPAGE);
>> +    ret = madvise(mem, size, MADV_HUGEPAGE);
>>       if (ret) {
>>           ksft_test_result_fail("MADV_HUGEPAGE failed\n");
>>           goto munmap;
>>       }
>>
>>       /*
>> -     * Try to populate a THP. Touch the first sub-page and test if we get
>> -     * another sub-page populated automatically.
>> +     * Try to populate a THP. Touch the first sub-page and test if
>> +     * we get the last sub-page populated automatically.
>>        */
>>       mem[0] = 0;
>> -    if (!pagemap_is_populated(pagemap_fd, mem + pagesize)) {
>> +    if (!pagemap_is_populated(pagemap_fd, mem + size - pagesize)) {
>>           ksft_test_result_skip("Did not get a THP populated\n");
>>           goto munmap;
>>       }
> 
> Yes! I have a patch lying around here that does that same. :)
> 
> I guess there is no need to set MADV_NOHUGEPAGE on the remainder of the mmap'ed
> are:
> 
> Assume we want a 64KiB thp. We mmap'ed 128KiB. If we get a reasonably aligned
> area, we might populate a 128KiB THP.
> 
> But I assume the MADV_HUGEPAGE will in all configurations properly create a
> separate 64KiB VMA and we'll never get 128 KiB populated. So this should work
> reliably.

Yes agreed. And also, we explicitly only enable a single THP size at a time so
should only allocate a THP of the expected size. Perhaps we should mark the
whole mmap area with MADV_HUGEPAGE since that will serve as a test that we only
get the smaller size we configured?

> 
>> -    memset(mem, 0, thpsize);
>> +    memset(mem, 0, size);
>>
>> -    size = thpsize;
>>       switch (thp_run) {
>>       case THP_RUN_PMD:
>>       case THP_RUN_PMD_SWAPOUT:
>> +        if (size != pmdsize) {
>> +            ksft_test_result_fail("test bug: can't PMD-map size\n");
>> +            goto munmap;
>> +        }
> 
> Maybe rather "assert()" because that's a real BUG in the test?

Yep will do.

> 
> [...]
> 
>> +    pmdsize = read_pmd_pagesize();
>> +    if (pmdsize)
>> +        ksft_print_msg("[INFO] detected PMD-mapped THP size: %zu KiB\n",
> 
> Maybe simply: "detected PMD size". Zes, we read it via the THP interface, but
> that shouldn't matter much.

Err, just want to clarify what you are suggesting. With the current patch you
will see something like:

[INFO] detected PMD-mapped THP size: 2048 KiB
[INFO] detected small-sized THP size: 64 KiB
[INFO] detected small-sized THP size: 128 KiB
...
[INFO] detected small-sized THP size: 1024 KiB


Are you suggesting something like this:

[INFO] detected PMD size: 2048 KiB
[INFO] detected THP size: 64 KiB
[INFO] detected THP size: 128 KiB
...
[INFO] detected THP size: 2048 KiB


> 

