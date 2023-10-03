Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE127B6284
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjJCHcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjJCHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:32:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8B3CA9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:32:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C668DC15;
        Tue,  3 Oct 2023 00:33:12 -0700 (PDT)
Received: from [10.57.66.79] (unknown [10.57.66.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E17F3F59C;
        Tue,  3 Oct 2023 00:32:31 -0700 (PDT)
Message-ID: <0fb0840f-02f0-4103-a6be-eeb4fcc16f8f@arm.com>
Date:   Tue, 3 Oct 2023 08:32:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] arm64/mm: Override arch_wants_pte_order()
Content-Language: en-GB
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-8-ryan.roberts@arm.com> <ZRrgEPwuFnCry3+/@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZRrgEPwuFnCry3+/@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2023 16:21, Catalin Marinas wrote:
> On Fri, Sep 29, 2023 at 12:44:18PM +0100, Ryan Roberts wrote:
>> Define an arch-specific override of arch_wants_pte_order() so that when
>> anon_orders=recommend is set, large folios will be allocated for
>> anonymous memory with an order that is compatible with arm64's HPA uarch
>> feature.
>>
>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 7f7d9b1df4e5..e3d2449dec5c 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -1110,6 +1110,16 @@ extern pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
>>  extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
>>  				    unsigned long addr, pte_t *ptep,
>>  				    pte_t old_pte, pte_t new_pte);
>> +
>> +#define arch_wants_pte_order arch_wants_pte_order
>> +static inline int arch_wants_pte_order(void)
>> +{
>> +	/*
>> +	 * Many arm64 CPUs support hardware page aggregation (HPA), which can
>> +	 * coalesce 4 contiguous pages into a single TLB entry.
>> +	 */
>> +	return 2;
>> +}
> 
> I haven't followed the discussions on previous revisions of this series
> but I wonder why not return a bitmap from arch_wants_pte_order(). For
> arm64 we may want an order 6 at some point (contiguous ptes) with a
> fallback to order 2 as the next best.
> 

This sounds like good idea to me - I'll implement it, assuming there is a next
rev. (Or in the unlikely event that this is the only pending change, I'd rather
defer it to when we actually need it with the contpte series).

This is just a hangover from the "MVP" approach that I was persuing in v5, where
we didn't want to configure too many orders for fear of fragmentation. But in v6
I've introduced UABI to configure the set of orders, and this function feeds
into the special "recommend" set. So I think it is appropriate that this API
allows expression of multiple orders as you suggest.

Side note: I don't think order-6 is ever a contpte size? Its order-4 for 4K,
order-7 for 16k and order-5 for 64k.

