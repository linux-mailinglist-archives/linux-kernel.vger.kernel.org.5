Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834897F9CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjK0Jfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjK0Jfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:35:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B15911B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:35:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 954202F4;
        Mon, 27 Nov 2023 01:36:41 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A92323F6C4;
        Mon, 27 Nov 2023 01:35:50 -0800 (PST)
Message-ID: <bfebd80b-b60d-48e2-b350-7c0ac0299cda@arm.com>
Date:   Mon, 27 Nov 2023 09:35:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>, david@redhat.com
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
References: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
 <20231127084217.13110-1-v-songbaohua@oppo.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231127084217.13110-1-v-songbaohua@oppo.com>
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

On 27/11/2023 08:42, Barry Song wrote:
>>> +		for (i = 0; i < nr; i++, page++) {
>>> +			if (anon) {
>>> +				/*
>>> +				 * If this page may have been pinned by the
>>> +				 * parent process, copy the page immediately for
>>> +				 * the child so that we'll always guarantee the
>>> +				 * pinned page won't be randomly replaced in the
>>> +				 * future.
>>> +				 */
>>> +				if (unlikely(page_try_dup_anon_rmap(
>>> +						page, false, src_vma))) {
>>> +					if (i != 0)
>>> +						break;
>>> +					/* Page may be pinned, we have to copy. */
>>> +					return copy_present_page(
>>> +						dst_vma, src_vma, dst_pte,
>>> +						src_pte, addr, rss, prealloc,
>>> +						page);
>>> +				}
>>> +				rss[MM_ANONPAGES]++;
>>> +				VM_BUG_ON(PageAnonExclusive(page));
>>> +			} else {
>>> +				page_dup_file_rmap(page, false);
>>> +				rss[mm_counter_file(page)]++;
>>> +			}
>>>   		}
>>> -		rss[MM_ANONPAGES]++;
>>> -	} else if (page) {
>>> -		folio_get(folio);
>>> -		page_dup_file_rmap(page, false);
>>> -		rss[mm_counter_file(page)]++;
>>> +
>>> +		nr = i;
>>> +		folio_ref_add(folio, nr);
>>
>> You're changing the order of mapcount vs. refcount increment. Don't. 
>> Make sure your refcount >= mapcount.
>>
>> You can do that easily by doing the folio_ref_add(folio, nr) first and 
>> then decrementing in case of error accordingly. Errors due to pinned 
>> pages are the corner case.
>>
>> I'll note that it will make a lot of sense to have batch variants of 
>> page_try_dup_anon_rmap() and page_dup_file_rmap().
>>
> 
> i still don't understand why it is not a entire map+1, but an increment
> in each basepage.

Because we are PTE-mapping the folio, we have to account each individual page.
If we accounted the entire folio, where would we unaccount it? Each page can be
unmapped individually (e.g. munmap() part of the folio) so need to account each
page. When PMD mapping, the whole thing is either mapped or unmapped, and its
atomic, so we can account the entire thing.

> 
> as long as it is a CONTPTE large folio, there is no much difference with
> PMD-mapped large folio. it has all the chance to be DoubleMap and need
> split.
> 
> When A and B share a CONTPTE large folio, we do madvise(DONTNEED) or any
> similar things on a part of the large folio in process A,
> 
> this large folio will have partially mapped subpage in A (all CONTPE bits
> in all subpages need to be removed though we only unmap a part of the
> large folioas HW requires consistent CONTPTEs); and it has entire map in
> process B(all PTEs are still CONPTES in process B).
> 
> isn't it more sensible for this large folios to have entire_map = 0(for
> process B), and subpages which are still mapped in process A has map_count
> =0? (start from -1).
> 
>> Especially, the batch variant of page_try_dup_anon_rmap() would only 
>> check once if the folio maybe pinned, and in that case, you can simply 
>> drop all references again. So you either have all or no ptes to process, 
>> which makes that code easier.

I'm afraid this doesn't make sense to me. Perhaps I've misunderstood. But
fundamentally you can only use entire_mapcount if its only possible to map and
unmap the whole folio atomically.

>>
>> But that can be added on top, and I'll happily do that.
>>
>> -- 
>> Cheers,
>>
>> David / dhildenb
> 
> Thanks
> Barry
> 

