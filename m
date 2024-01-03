Return-Path: <linux-kernel+bounces-15275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410382297E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B711F23CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5594918629;
	Wed,  3 Jan 2024 08:34:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286E418622
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72AA7C15;
	Wed,  3 Jan 2024 00:34:49 -0800 (PST)
Received: from [10.57.74.226] (unknown [10.57.74.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356A43F5A1;
	Wed,  3 Jan 2024 00:33:33 -0800 (PST)
Message-ID: <7d07caae-ae22-4cda-a3d0-4f542f52817a@arm.com>
Date: Wed, 3 Jan 2024 08:33:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/10] selftests/mm/cow: Generalize do_run_with_thp()
 helper
Content-Language: en-GB
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yin Fengwei <fengwei.yin@intel.com>,
 David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Yang Shi
 <shy828301@gmail.com>, "Huang, Ying" <ying.huang@intel.com>,
 Zi Yan <ziy@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Itaru Kitayama <itaru.kitayama@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 John Hubbard <jhubbard@nvidia.com>, David Rientjes <rientjes@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-10-ryan.roberts@arm.com> <ZZT9BHVU0+lyKNJF@vm3>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZZT9BHVU0+lyKNJF@vm3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/01/2024 06:21, Itaru Kitayama wrote:
> On Thu, Dec 07, 2023 at 04:12:10PM +0000, Ryan Roberts wrote:
>> do_run_with_thp() prepares (PMD-sized) THP memory into different states
>> before running tests. With the introduction of multi-size THP, we would
>> like to reuse this logic to also test those smaller THP sizes. So let's
>> add a thpsize parameter which tells the function what size THP it should
>> operate on.
>>
>> A separate commit will utilize this change to add new tests for
>> multi-size THP, where available.
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Tested-by: Itaru Kitayama <itaru.kitayama@linux.dev>

Thanks for testing!

> 
> I am replying to all this time; Ryan, do you think it's okay to run
> 700 of selftests/mm/cow tests? Even on FVP, they did not take longer
> though.

What exactly is your concern, the amount of time it takes to run the tests? I've
found (at least on real HW) that the time it takes to run a test is dominated by
accessing the folio's memory. So adding all of the new tests that test sizes
between order-2 and PMD_ORDER-1 is ~equivalent to running the existing PMD_ORDER
tests twice. And the runtime of those is barely noticable compared to the
PUD_ORDER HugeTLB tests. So I don't think we are impacting runtime by much.
Sounds like your experience says that's also true for FVP?

> 
>> ---
>>  tools/testing/selftests/mm/cow.c | 121 +++++++++++++++++--------------
>>  1 file changed, 67 insertions(+), 54 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>> index 7324ce5363c0..4d0b5a125d3c 100644
>> --- a/tools/testing/selftests/mm/cow.c
>> +++ b/tools/testing/selftests/mm/cow.c
>> @@ -32,7 +32,7 @@
>>  
>>  static size_t pagesize;
>>  static int pagemap_fd;
>> -static size_t thpsize;
>> +static size_t pmdsize;
>>  static int nr_hugetlbsizes;
>>  static size_t hugetlbsizes[10];
>>  static int gup_fd;
>> @@ -734,7 +734,7 @@ enum thp_run {
>>  	THP_RUN_PARTIAL_SHARED,
>>  };
>>  
>> -static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
>> +static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>>  {
>>  	char *mem, *mmap_mem, *tmp, *mremap_mem = MAP_FAILED;
>>  	size_t size, mmap_size, mremap_size;
>> @@ -759,11 +759,11 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
>>  	}
>>  
>>  	/*
>> -	 * Try to populate a THP. Touch the first sub-page and test if we get
>> -	 * another sub-page populated automatically.
>> +	 * Try to populate a THP. Touch the first sub-page and test if
>> +	 * we get the last sub-page populated automatically.
>>  	 */
>>  	mem[0] = 0;
>> -	if (!pagemap_is_populated(pagemap_fd, mem + pagesize)) {
>> +	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
>>  		ksft_test_result_skip("Did not get a THP populated\n");
>>  		goto munmap;
>>  	}
>> @@ -773,12 +773,14 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
>>  	switch (thp_run) {
>>  	case THP_RUN_PMD:
>>  	case THP_RUN_PMD_SWAPOUT:
>> +		assert(thpsize == pmdsize);
>>  		break;
>>  	case THP_RUN_PTE:
>>  	case THP_RUN_PTE_SWAPOUT:
>>  		/*
>>  		 * Trigger PTE-mapping the THP by temporarily mapping a single
>> -		 * subpage R/O.
>> +		 * subpage R/O. This is a noop if the THP is not pmdsize (and
>> +		 * therefore already PTE-mapped).
>>  		 */
>>  		ret = mprotect(mem + pagesize, pagesize, PROT_READ);
>>  		if (ret) {
>> @@ -875,52 +877,60 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
>>  		munmap(mremap_mem, mremap_size);
>>  }
>>  
>> -static void run_with_thp(test_fn fn, const char *desc)
>> +static void run_with_thp(test_fn fn, const char *desc, size_t size)
>>  {
>> -	ksft_print_msg("[RUN] %s ... with THP\n", desc);
>> -	do_run_with_thp(fn, THP_RUN_PMD);
>> +	ksft_print_msg("[RUN] %s ... with THP (%zu kB)\n",
>> +		desc, size / 1024);
>> +	do_run_with_thp(fn, THP_RUN_PMD, size);
>>  }
>>  
>> -static void run_with_thp_swap(test_fn fn, const char *desc)
>> +static void run_with_thp_swap(test_fn fn, const char *desc, size_t size)
>>  {
>> -	ksft_print_msg("[RUN] %s ... with swapped-out THP\n", desc);
>> -	do_run_with_thp(fn, THP_RUN_PMD_SWAPOUT);
>> +	ksft_print_msg("[RUN] %s ... with swapped-out THP (%zu kB)\n",
>> +		desc, size / 1024);
>> +	do_run_with_thp(fn, THP_RUN_PMD_SWAPOUT, size);
>>  }
>>  
>> -static void run_with_pte_mapped_thp(test_fn fn, const char *desc)
>> +static void run_with_pte_mapped_thp(test_fn fn, const char *desc, size_t size)
>>  {
>> -	ksft_print_msg("[RUN] %s ... with PTE-mapped THP\n", desc);
>> -	do_run_with_thp(fn, THP_RUN_PTE);
>> +	ksft_print_msg("[RUN] %s ... with PTE-mapped THP (%zu kB)\n",
>> +		desc, size / 1024);
>> +	do_run_with_thp(fn, THP_RUN_PTE, size);
>>  }
>>  
>> -static void run_with_pte_mapped_thp_swap(test_fn fn, const char *desc)
>> +static void run_with_pte_mapped_thp_swap(test_fn fn, const char *desc, size_t size)
>>  {
>> -	ksft_print_msg("[RUN] %s ... with swapped-out, PTE-mapped THP\n", desc);
>> -	do_run_with_thp(fn, THP_RUN_PTE_SWAPOUT);
>> +	ksft_print_msg("[RUN] %s ... with swapped-out, PTE-mapped THP (%zu kB)\n",
>> +		desc, size / 1024);
>> +	do_run_with_thp(fn, THP_RUN_PTE_SWAPOUT, size);
>>  }
>>  
>> -static void run_with_single_pte_of_thp(test_fn fn, const char *desc)
>> +static void run_with_single_pte_of_thp(test_fn fn, const char *desc, size_t size)
>>  {
>> -	ksft_print_msg("[RUN] %s ... with single PTE of THP\n", desc);
>> -	do_run_with_thp(fn, THP_RUN_SINGLE_PTE);
>> +	ksft_print_msg("[RUN] %s ... with single PTE of THP (%zu kB)\n",
>> +		desc, size / 1024);
>> +	do_run_with_thp(fn, THP_RUN_SINGLE_PTE, size);
>>  }
>>  
>> -static void run_with_single_pte_of_thp_swap(test_fn fn, const char *desc)
>> +static void run_with_single_pte_of_thp_swap(test_fn fn, const char *desc, size_t size)
>>  {
>> -	ksft_print_msg("[RUN] %s ... with single PTE of swapped-out THP\n", desc);
>> -	do_run_with_thp(fn, THP_RUN_SINGLE_PTE_SWAPOUT);
>> +	ksft_print_msg("[RUN] %s ... with single PTE of swapped-out THP (%zu kB)\n",
>> +		desc, size / 1024);
>> +	do_run_with_thp(fn, THP_RUN_SINGLE_PTE_SWAPOUT, size);
>>  }
>>  
>> -static void run_with_partial_mremap_thp(test_fn fn, const char *desc)
>> +static void run_with_partial_mremap_thp(test_fn fn, const char *desc, size_t size)
>>  {
>> -	ksft_print_msg("[RUN] %s ... with partially mremap()'ed THP\n", desc);
>> -	do_run_with_thp(fn, THP_RUN_PARTIAL_MREMAP);
>> +	ksft_print_msg("[RUN] %s ... with partially mremap()'ed THP (%zu kB)\n",
>> +		desc, size / 1024);
>> +	do_run_with_thp(fn, THP_RUN_PARTIAL_MREMAP, size);
>>  }
>>  
>> -static void run_with_partial_shared_thp(test_fn fn, const char *desc)
>> +static void run_with_partial_shared_thp(test_fn fn, const char *desc, size_t size)
>>  {
>> -	ksft_print_msg("[RUN] %s ... with partially shared THP\n", desc);
>> -	do_run_with_thp(fn, THP_RUN_PARTIAL_SHARED);
>> +	ksft_print_msg("[RUN] %s ... with partially shared THP (%zu kB)\n",
>> +		desc, size / 1024);
>> +	do_run_with_thp(fn, THP_RUN_PARTIAL_SHARED, size);
>>  }
>>  
>>  static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
>> @@ -1091,15 +1101,15 @@ static void run_anon_test_case(struct test_case const *test_case)
>>  
>>  	run_with_base_page(test_case->fn, test_case->desc);
>>  	run_with_base_page_swap(test_case->fn, test_case->desc);
>> -	if (thpsize) {
>> -		run_with_thp(test_case->fn, test_case->desc);
>> -		run_with_thp_swap(test_case->fn, test_case->desc);
>> -		run_with_pte_mapped_thp(test_case->fn, test_case->desc);
>> -		run_with_pte_mapped_thp_swap(test_case->fn, test_case->desc);
>> -		run_with_single_pte_of_thp(test_case->fn, test_case->desc);
>> -		run_with_single_pte_of_thp_swap(test_case->fn, test_case->desc);
>> -		run_with_partial_mremap_thp(test_case->fn, test_case->desc);
>> -		run_with_partial_shared_thp(test_case->fn, test_case->desc);
>> +	if (pmdsize) {
>> +		run_with_thp(test_case->fn, test_case->desc, pmdsize);
>> +		run_with_thp_swap(test_case->fn, test_case->desc, pmdsize);
>> +		run_with_pte_mapped_thp(test_case->fn, test_case->desc, pmdsize);
>> +		run_with_pte_mapped_thp_swap(test_case->fn, test_case->desc, pmdsize);
>> +		run_with_single_pte_of_thp(test_case->fn, test_case->desc, pmdsize);
>> +		run_with_single_pte_of_thp_swap(test_case->fn, test_case->desc, pmdsize);
>> +		run_with_partial_mremap_thp(test_case->fn, test_case->desc, pmdsize);
>> +		run_with_partial_shared_thp(test_case->fn, test_case->desc, pmdsize);
>>  	}
>>  	for (i = 0; i < nr_hugetlbsizes; i++)
>>  		run_with_hugetlb(test_case->fn, test_case->desc,
>> @@ -1120,7 +1130,7 @@ static int tests_per_anon_test_case(void)
>>  {
>>  	int tests = 2 + nr_hugetlbsizes;
>>  
>> -	if (thpsize)
>> +	if (pmdsize)
>>  		tests += 8;
>>  	return tests;
>>  }
>> @@ -1329,7 +1339,7 @@ static void run_anon_thp_test_cases(void)
>>  {
>>  	int i;
>>  
>> -	if (!thpsize)
>> +	if (!pmdsize)
>>  		return;
>>  
>>  	ksft_print_msg("[INFO] Anonymous THP tests\n");
>> @@ -1338,13 +1348,13 @@ static void run_anon_thp_test_cases(void)
>>  		struct test_case const *test_case = &anon_thp_test_cases[i];
>>  
>>  		ksft_print_msg("[RUN] %s\n", test_case->desc);
>> -		do_run_with_thp(test_case->fn, THP_RUN_PMD);
>> +		do_run_with_thp(test_case->fn, THP_RUN_PMD, pmdsize);
>>  	}
>>  }
>>  
>>  static int tests_per_anon_thp_test_case(void)
>>  {
>> -	return thpsize ? 1 : 0;
>> +	return pmdsize ? 1 : 0;
>>  }
>>  
>>  typedef void (*non_anon_test_fn)(char *mem, const char *smem, size_t size);
>> @@ -1419,7 +1429,7 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
>>  	}
>>  
>>  	/* For alignment purposes, we need twice the thp size. */
>> -	mmap_size = 2 * thpsize;
>> +	mmap_size = 2 * pmdsize;
>>  	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>>  			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>  	if (mmap_mem == MAP_FAILED) {
>> @@ -1434,11 +1444,11 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
>>  	}
>>  
>>  	/* We need a THP-aligned memory area. */
>> -	mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
>> -	smem = (char *)(((uintptr_t)mmap_smem + thpsize) & ~(thpsize - 1));
>> +	mem = (char *)(((uintptr_t)mmap_mem + pmdsize) & ~(pmdsize - 1));
>> +	smem = (char *)(((uintptr_t)mmap_smem + pmdsize) & ~(pmdsize - 1));
>>  
>> -	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
>> -	ret |= madvise(smem, thpsize, MADV_HUGEPAGE);
>> +	ret = madvise(mem, pmdsize, MADV_HUGEPAGE);
>> +	ret |= madvise(smem, pmdsize, MADV_HUGEPAGE);
>>  	if (ret) {
>>  		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
>>  		goto munmap;
>> @@ -1457,7 +1467,7 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
>>  		goto munmap;
>>  	}
>>  
>> -	fn(mem, smem, thpsize);
>> +	fn(mem, smem, pmdsize);
>>  munmap:
>>  	munmap(mmap_mem, mmap_size);
>>  	if (mmap_smem != MAP_FAILED)
>> @@ -1650,7 +1660,7 @@ static void run_non_anon_test_case(struct non_anon_test_case const *test_case)
>>  	run_with_zeropage(test_case->fn, test_case->desc);
>>  	run_with_memfd(test_case->fn, test_case->desc);
>>  	run_with_tmpfile(test_case->fn, test_case->desc);
>> -	if (thpsize)
>> +	if (pmdsize)
>>  		run_with_huge_zeropage(test_case->fn, test_case->desc);
>>  	for (i = 0; i < nr_hugetlbsizes; i++)
>>  		run_with_memfd_hugetlb(test_case->fn, test_case->desc,
>> @@ -1671,7 +1681,7 @@ static int tests_per_non_anon_test_case(void)
>>  {
>>  	int tests = 3 + nr_hugetlbsizes;
>>  
>> -	if (thpsize)
>> +	if (pmdsize)
>>  		tests += 1;
>>  	return tests;
>>  }
>> @@ -1681,10 +1691,13 @@ int main(int argc, char **argv)
>>  	int err;
>>  
>>  	pagesize = getpagesize();
>> -	thpsize = read_pmd_pagesize();
>> -	if (thpsize)
>> +	pmdsize = read_pmd_pagesize();
>> +	if (pmdsize) {
>> +		ksft_print_msg("[INFO] detected PMD size: %zu KiB\n",
>> +			       pmdsize / 1024);
>>  		ksft_print_msg("[INFO] detected THP size: %zu KiB\n",
>> -			       thpsize / 1024);
>> +			       pmdsize / 1024);
>> +	}
>>  	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
>>  						    ARRAY_SIZE(hugetlbsizes));
>>  	detect_huge_zeropage();
>> -- 
>> 2.25.1
>>


