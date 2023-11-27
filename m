Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889C77F9E97
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjK0L2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjK0L2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:28:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A5D1B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:28:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF9142F4;
        Mon, 27 Nov 2023 03:29:39 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F21143F73F;
        Mon, 27 Nov 2023 03:28:48 -0800 (PST)
Message-ID: <4785ad95-7af7-4d41-9997-e97b2a8e9666@arm.com>
Date:   Mon, 27 Nov 2023 11:28:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 04/10] mm: thp: Support allocation of anonymous
 small-sized THP
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, david@redhat.com, fengwei.yin@intel.com,
        hughd@google.com, itaru.kitayama@gmail.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, rientjes@google.com,
        shy828301@gmail.com, vbabka@suse.cz, wangkefeng.wang@huawei.com,
        willy@infradead.org, ying.huang@intel.com, yuzhao@google.com,
        ziy@nvidia.com
References: <20231122162950.3854897-5-ryan.roberts@arm.com>
 <20231127034135.6754-1-v-songbaohua@oppo.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231127034135.6754-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 03:41, Barry Song wrote:
>> +	if ((nr_pages == 1 && vmf_pte_changed(vmf)) ||
>> +	    (nr_pages  > 1 && !pte_range_none(vmf->pte, nr_pages))) {
>> +		for (i = 0; i < nr_pages; i++)
>> +			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>>  		goto release;
>>  	}
> 
> Hi Ryan,
> what has stopped nr_pages == 1 from using !pte_range_none(vmf->pte, 1)
> directly, then the code can become,
> +	if (!pte_range_none(vmf->pte, nr_pages)) {
> +		for (i = 0; i < nr_pages; i++)
> +			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>  		goto release;
>  	}
> 
> for both 1 and > 1 cases?

We can get to do_anonymous_page() from 2 routes:

 - page fault on unallocated memory (pte_none())
 - page fault on uffd_wp pte marker

In the latter case, we guarrantee that we are only operating on nr_pages == 1
because when uffd is in the picture we need to preserve any uffd state per-pte.
It also means we can't just check the pte is none because in this case it is not
none, it has a pte marker so we need to check it hasn't changed.

I was previously abstracting this in vmf_pte_range_changed() but there were
complaints [1] about the semantic being different based on the number of pages,
so this was my attempt to make it more understandable.

[1] https://lore.kernel.org/linux-mm/a6fa0847-a950-4044-972c-e5dc8cbc7922@arm.com/

Thanks,
Ryan


> 
> Thanks
> Barry
> 

