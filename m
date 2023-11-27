Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6017FA20E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjK0OMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjK0OLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:11:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6812526B3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:02:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0D572F4;
        Mon, 27 Nov 2023 06:02:55 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 626723F6C4;
        Mon, 27 Nov 2023 06:02:05 -0800 (PST)
Message-ID: <8dd0f52c-d261-4541-930f-bd4e5921be5b@arm.com>
Date:   Mon, 27 Nov 2023 14:02:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 10/10] selftests/mm/cow: Add tests for anonymous
 small-sized THP
Content-Language: en-GB
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-11-ryan.roberts@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231122162950.3854897-11-ryan.roberts@arm.com>
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

On 22/11/2023 16:29, Ryan Roberts wrote:
> Add tests similar to the existing PMD-sized THP tests, but which operate
> on memory backed by (PTE-mapped) small-sized THP. This reuses all the
> existing infrastructure. If the test suite detects that small-sized THP
> is not supported by the kernel, the new tests are skipped.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  tools/testing/selftests/mm/cow.c | 71 +++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index d03c453cfd5c..3efc395c7077 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -29,15 +29,49 @@
>  #include "../../../../mm/gup_test.h"
>  #include "../kselftest.h"
>  #include "vm_util.h"
> +#include "thp_settings.h"
> 
>  static size_t pagesize;
>  static int pagemap_fd;
>  static size_t pmdsize;
> +static int nr_thpsmallsizes;
> +static size_t thpsmallsizes[20];

Off the back of some comments David made againt the previous patch [1], I'm
proposing to rework this a bit so that ALL thp sizes are stored in this array,
not just the non-PMD-sized sizes. This makes the changes overall a bit smaller
and easier to understand, I think...

>  static int nr_hugetlbsizes;
>  static size_t hugetlbsizes[10];
>  static int gup_fd;
>  static bool has_huge_zeropage;
> 
> +static int sz2ord(size_t size)
> +{
> +	return __builtin_ctzll(size / pagesize);
> +}
> +
> +static int detect_smallthp_sizes(size_t sizes[], int max)

This changes to detect_thp_sizes() and deposits all sizes in sizes[]

> +{
> +	int count = 0;
> +	unsigned long orders;
> +	size_t kb;
> +	int i;
> +
> +	/* thp not supported at all. */
> +	if (!pmdsize)
> +		return 0;
> +
> +	orders = thp_supported_orders();
> +
> +	/* Only interested in small-sized THP (less than PMD-size). */
> +	for (i = 0; i < sz2ord(pmdsize); i++) {
> +		if (!(orders & (1UL << i)))
> +			continue;
> +		kb = (pagesize >> 10) << i;
> +		sizes[count++] = kb * 1024;
> +		ksft_print_msg("[INFO] detected small-sized THP size: %zu KiB\n",
> +			       kb);

This just prints "[INFO] detected THP size: %zu KiB"

> +	}
> +
> +	return count;
> +}
> +
>  static void detect_huge_zeropage(void)
>  {
>  	int fd = open("/sys/kernel/mm/transparent_hugepage/use_zero_page",
> @@ -1113,6 +1147,23 @@ static void run_anon_test_case(struct test_case const *test_case)
>  		run_with_partial_mremap_thp(test_case->fn, test_case->desc, pmdsize);
>  		run_with_partial_shared_thp(test_case->fn, test_case->desc, pmdsize);
>  	}
> +	for (i = 0; i < nr_thpsmallsizes; i++) {
> +		size_t size = thpsmallsizes[i];
> +		struct thp_settings settings = *thp_current_settings();
> +
> +		settings.hugepages[sz2ord(pmdsize)].enabled = THP_NEVER;
> +		settings.hugepages[sz2ord(size)].enabled = THP_ALWAYS;
> +		thp_push_settings(&settings);
> +
> +		run_with_pte_mapped_thp(test_case->fn, test_case->desc, size);
> +		run_with_pte_mapped_thp_swap(test_case->fn, test_case->desc, size);
> +		run_with_single_pte_of_thp(test_case->fn, test_case->desc, size);
> +		run_with_single_pte_of_thp_swap(test_case->fn, test_case->desc, size);
> +		run_with_partial_mremap_thp(test_case->fn, test_case->desc, size);
> +		run_with_partial_shared_thp(test_case->fn, test_case->desc, size);
> +
> +		thp_pop_settings();
> +	}

This same loop covers the pmdsize tests too, and I've just added a conditional
that runs the 2 extra tests that are pmdsize only.

>  	for (i = 0; i < nr_hugetlbsizes; i++)
>  		run_with_hugetlb(test_case->fn, test_case->desc,
>  				 hugetlbsizes[i]);
> @@ -1134,6 +1185,7 @@ static int tests_per_anon_test_case(void)
> 
>  	if (pmdsize)
>  		tests += 8;
> +	tests += 6 * nr_thpsmallsizes;
>  	return tests;
>  }
> 
> @@ -1691,12 +1743,24 @@ static int tests_per_non_anon_test_case(void)
>  int main(int argc, char **argv)
>  {
>  	int err;
> +	struct thp_settings default_settings;
> 
>  	pagesize = getpagesize();
>  	pmdsize = read_pmd_pagesize();
> -	if (pmdsize)
> +	if (pmdsize) {
> +		/* Only if THP is supported. */
> +		thp_read_settings(&default_settings);
> +		default_settings.hugepages[sz2ord(pmdsize)].enabled = THP_GLOBAL;
> +		thp_save_settings();
> +		thp_push_settings(&default_settings);
> +
>  		ksft_print_msg("[INFO] detected PMD-mapped THP size: %zu KiB\n",
>  			       pmdsize / 1024);
> +
> +		nr_thpsmallsizes = detect_smallthp_sizes(thpsmallsizes,
> +						    ARRAY_SIZE(thpsmallsizes));
> +	}
> +
>  	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
>  						    ARRAY_SIZE(hugetlbsizes));
>  	detect_huge_zeropage();
> @@ -1715,6 +1779,11 @@ int main(int argc, char **argv)
>  	run_anon_thp_test_cases();
>  	run_non_anon_test_cases();
> 
> +	if (pmdsize) {
> +		/* Only if THP is supported. */
> +		thp_restore_settings();
> +	}
> +
>  	err = ksft_get_fail_cnt();
>  	if (err)
>  		ksft_exit_fail_msg("%d out of %d tests failed\n",
> --
> 2.25.1
> 

