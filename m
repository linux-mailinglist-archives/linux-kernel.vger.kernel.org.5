Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129367FB930
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344530AbjK1LPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjK1LPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:15:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14E45D60
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:15:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48454C15;
        Tue, 28 Nov 2023 03:16:11 -0800 (PST)
Received: from [10.1.33.188] (XHFQ2J9959.cambridge.arm.com [10.1.33.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4A923F73F;
        Tue, 28 Nov 2023 03:15:20 -0800 (PST)
Message-ID: <51f57fa1-a2ca-4e3e-82cd-b0733d4f12a7@arm.com>
Date:   Tue, 28 Nov 2023 11:15:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, david@redhat.com, dvyukov@google.com,
        glider@google.com, james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
References: <20231115163018.1303287-15-ryan.roberts@arm.com>
 <20231128073254.37870-1-v-songbaohua@oppo.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231128073254.37870-1-v-songbaohua@oppo.com>
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

On 28/11/2023 07:32, Barry Song wrote:
>> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
>> +static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>> +				unsigned long addr, pte_t *ptep, int full)
>> +{
>> +	pte_t orig_pte = __ptep_get(ptep);
>> +
>> +	if (!pte_valid_cont(orig_pte) || !full) {
>> +		contpte_try_unfold(mm, addr, ptep, orig_pte);
>> +		return __ptep_get_and_clear(mm, addr, ptep);
>> +	} else
>> +		return contpte_ptep_get_and_clear_full(mm, addr, ptep);
>> +}
>> +
> 
> Hi Ryan,
> 
> I feel quite hard to understand the code. when !pte_valid_cont(orig_pte),
> we will call contpte_try_unfold(mm, addr, ptep, orig_pte);
> 
> but in contpte_try_unfold(), we call unfold only if pte_valid_cont()
> is true:
> static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>                                         pte_t *ptep, pte_t pte) 
> {
>         if (contpte_is_enabled(mm) && pte_valid_cont(pte))
>                 __contpte_try_unfold(mm, addr, ptep, pte);
> }
> 
> so do you mean the below?
> 
> if (!pte_valid_cont(orig_pte))
> 	return __ptep_get_and_clear(mm, addr, ptep);
> 
> if (!full) {
> 	contpte_try_unfold(mm, addr, ptep, orig_pte);
> 	return __ptep_get_and_clear(mm, addr, ptep);	
> } else {
> 	return contpte_ptep_get_and_clear_full(mm, addr, ptep);
> }

Yes, this is equivalent. In general, I was trying not to spray `if
(pte_valid_cont(orig_pte))` checks everywhere to guard contpte_try_unfold() and
instead put the checks into contpte_try_unfold() (hence the 'try'). I figured
just calling it unconditionally and letting the compiler optimize as it sees fit
was the cleanest approach.

But in this instance I can see this is confusing. I'll modify as you suggest.
Thanks!

> 
> Thanks
> Barry
> 
> 

