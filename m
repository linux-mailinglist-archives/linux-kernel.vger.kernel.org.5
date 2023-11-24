Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E747F7A94
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjKXRsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXRsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AE3171D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700848135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=GxUuGgqvBiwXQGtDlv7ryFP6iHTy8SVVoV36zP4gnMI=;
        b=Al4pcUIy/wg8bvSfdIerrlJbVfNYueaVjj4+H0j4zF/502fUa+L0Wc7J4yYVAYRt4fOgaW
        mH/pry2cunVkePN5uOYQwaS1S69TsGFVgMi0oBQQy48i5mkyquUmLjy07ZdWSkHcHJn0sq
        OuVk8JnT2xadhJQYDuJeHpQakCTZR0M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-Uki9BwfaNoCeDgz0W3pJYg-1; Fri, 24 Nov 2023 12:48:54 -0500
X-MC-Unique: Uki9BwfaNoCeDgz0W3pJYg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-332e899b927so743036f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700848133; x=1701452933;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxUuGgqvBiwXQGtDlv7ryFP6iHTy8SVVoV36zP4gnMI=;
        b=JRK9AOC/EZeuc22JTbh8DaEHJ6LCo1TUFhgDkEQUtf286kS2iKHReoc511u7ZZKpRZ
         P5kAVqPeQN98bG7Pw//6en1nf1i6IrzgX+QqwzoQamP0cZjQj3G/3WyzByD9M5tEs0Kv
         vEYPd1fwA5S+dajG4q+ffNba5N0/o8V29uSG3QHAdYMcKE1JGWdyxtIUnbGVrH66CRMr
         PT99/DKFaHZxE4LaiMbQ27pns2erEwpVyg3N1ksPONnsIo+zRxMOP0SkwHbk359t4J5S
         20JX43QqlSoe7n+6uvQNbNIbAeBQ+pxYjpf/7fCvp5Ey9raTLT2jk7IkkxfMCR3Vu227
         rRyA==
X-Gm-Message-State: AOJu0YwK8ArNXKkuj9Iwi+1Lx/+PEZUkZcSG5zVXG+xN0Uz2awM/MBv2
        9Jms+r9o0UaZZr4+lbTGEFMw+5RU0/7MqmKZ+/LF1+U5rnjslDADb1SrhBwne8MNB76y4giodrd
        PgoqCZgnf9DHA0cpmhz9KiZWu
X-Received: by 2002:a05:600c:4fc5:b0:401:bd2e:49fc with SMTP id o5-20020a05600c4fc500b00401bd2e49fcmr2891460wmq.24.1700848133202;
        Fri, 24 Nov 2023 09:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNs2CSLxAJ5sxsCGnK8NIWQsksfySxAR/7AcX90Fs/Qgye84ZkQ6vfLRXECzpCtmFmHbyYNg==
X-Received: by 2002:a05:600c:4fc5:b0:401:bd2e:49fc with SMTP id o5-20020a05600c4fc500b00401bd2e49fcmr2891445wmq.24.1700848132768;
        Fri, 24 Nov 2023 09:48:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b0040b3525428bsm5704150wmq.2.2023.11.24.09.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 09:48:52 -0800 (PST)
Message-ID: <ead82cbe-19c9-43ce-9f28-7ced118b130a@redhat.com>
Date:   Fri, 24 Nov 2023 18:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 09/10] selftests/mm/cow: Generalize
 do_run_with_thp() helper
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
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
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231122162950.3854897-10-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.23 17:29, Ryan Roberts wrote:
> do_run_with_thp() prepares (PMD-sized) THP memory into different states
> before running tests. With the introduction of small-sized THP, we would
> like to reuse this logic to also test those smaller THP sizes. So let's
> add a size parameter which tells the function what size THP it should
> operate on.
> 
> A separate commit will utilize this change to add new tests for
> small-sized THP, where available.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/cow.c | 146 +++++++++++++++++--------------
>   1 file changed, 79 insertions(+), 67 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 7324ce5363c0..d03c453cfd5c 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -32,7 +32,7 @@
> 
>   static size_t pagesize;
>   static int pagemap_fd;
> -static size_t thpsize;
> +static size_t pmdsize;
>   static int nr_hugetlbsizes;
>   static size_t hugetlbsizes[10];
>   static int gup_fd;
> @@ -734,14 +734,14 @@ enum thp_run {
>   	THP_RUN_PARTIAL_SHARED,
>   };
> 
> -static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
> +static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t size)

Nit: can we still call it "thpsize" in this function? That makes it 
clearer IMHO and avoids most renaming.

>   {
>   	char *mem, *mmap_mem, *tmp, *mremap_mem = MAP_FAILED;
> -	size_t size, mmap_size, mremap_size;
> +	size_t mmap_size, mremap_size;
>   	int ret;
> 
> -	/* For alignment purposes, we need twice the thp size. */
> -	mmap_size = 2 * thpsize;
> +	/* For alignment purposes, we need twice the requested size. */
> +	mmap_size = 2 * size;
>   	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>   			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>   	if (mmap_mem == MAP_FAILED) {
> @@ -749,36 +749,40 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
>   		return;
>   	}
> 
> -	/* We need a THP-aligned memory area. */
> -	mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
> +	/* We need to naturally align the memory area. */
> +	mem = (char *)(((uintptr_t)mmap_mem + size) & ~(size - 1));
> 
> -	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
> +	ret = madvise(mem, size, MADV_HUGEPAGE);
>   	if (ret) {
>   		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
>   		goto munmap;
>   	}
> 
>   	/*
> -	 * Try to populate a THP. Touch the first sub-page and test if we get
> -	 * another sub-page populated automatically.
> +	 * Try to populate a THP. Touch the first sub-page and test if
> +	 * we get the last sub-page populated automatically.
>   	 */
>   	mem[0] = 0;
> -	if (!pagemap_is_populated(pagemap_fd, mem + pagesize)) {
> +	if (!pagemap_is_populated(pagemap_fd, mem + size - pagesize)) {
>   		ksft_test_result_skip("Did not get a THP populated\n");
>   		goto munmap;
>   	}

Yes! I have a patch lying around here that does that same. :)

I guess there is no need to set MADV_NOHUGEPAGE on the remainder of the 
mmap'ed are:

Assume we want a 64KiB thp. We mmap'ed 128KiB. If we get a reasonably 
aligned area, we might populate a 128KiB THP.

But I assume the MADV_HUGEPAGE will in all configurations properly 
create a separate 64KiB VMA and we'll never get 128 KiB populated. So 
this should work reliably.

> -	memset(mem, 0, thpsize);
> +	memset(mem, 0, size);
> 
> -	size = thpsize;
>   	switch (thp_run) {
>   	case THP_RUN_PMD:
>   	case THP_RUN_PMD_SWAPOUT:
> +		if (size != pmdsize) {
> +			ksft_test_result_fail("test bug: can't PMD-map size\n");
> +			goto munmap;
> +		}

Maybe rather "assert()" because that's a real BUG in the test?

[...]

> +	pmdsize = read_pmd_pagesize();
> +	if (pmdsize)
> +		ksft_print_msg("[INFO] detected PMD-mapped THP size: %zu KiB\n",

Maybe simply: "detected PMD size". Zes, we read it via the THP 
interface, but that shouldn't matter much.

-- 
Cheers,

David / dhildenb

