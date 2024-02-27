Return-Path: <linux-kernel+bounces-82930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A75868BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7833EB29B53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDBC136666;
	Tue, 27 Feb 2024 09:11:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8265136657
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025100; cv=none; b=TxqzIvoXr+qvg9uq3YFNQ8pZVaZcaxqUvuBrJRGpkKpSG4YZPXX3bo9uJkyf3fZ+jCnMY49hr8qlw+UtwjJsX9TKb5i3kjgYt+tjv0t1A7bxWtw79VITJ1TOrkLomId7uCbRQ5eT+i1l55amuyRUpuOp9mRszno30t1KSuOmgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025100; c=relaxed/simple;
	bh=qMLHym6yNvFLmUfm3UsVaWLkuqL0S1B5ZeBX1KCN1VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meNAQsRIUOdpyijGy40kCVluJNaupELcV1267j3ZAgN9VRaBo34BC6D0FJDbLX7lszyuwkDtE2wGsa+yGqf7egWxRt8S/Wo9zHMY0f+wtwwhKr0lTQ3imx31JiDghhjxvppJJFMnHkZmnCT0TmbM/LulIdwkc/kBsTDdu4n21tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C163DA7;
	Tue, 27 Feb 2024 01:12:15 -0800 (PST)
Received: from [10.57.67.4] (unknown [10.57.67.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB49E3F762;
	Tue, 27 Feb 2024 01:11:35 -0800 (PST)
Message-ID: <4c3d1891-e784-4599-9640-4ff092ba7a31@arm.com>
Date: Tue, 27 Feb 2024 09:11:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Yin Fengwei <fengwei.yin@intel.com>
References: <20240227024050.244567-1-21cnbao@gmail.com>
 <CAGsJ_4yF+kuTtN4YmtwSvfcCRqixvzL5qT0BLLfTg9nLLsReZg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4yF+kuTtN4YmtwSvfcCRqixvzL5qT0BLLfTg9nLLsReZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2024 03:18, Barry Song wrote:
> On Tue, Feb 27, 2024 at 3:41 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> madvise and some others might need folio_pte_batch to check if a range
>> of PTEs are completely mapped to a large folio with contiguous physcial
>> addresses. Let's export it for others to use.
>>
>> Cc: Lance Yang <ioworker0@gmail.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
> 
> Hi David, Ryan,
> 
> Sorry, I realize I just made a mistake and your tags should be both
> Suggested-by. Please feel
> free to review the patch and give comments. I will fix the tags
> together with addressing your
> review comments in v2.

Don't worry about it. Don't feel you need to update it on my account.

> 
>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>  -v1:
>>  at least two jobs madv_free and madv_pageout depend on it. To avoid
>>  conflicts and dependencies, after discussing with Lance, we prefer
>>  this one can land earlier.
>>
>>  mm/internal.h | 13 +++++++++++++
>>  mm/memory.c   | 11 +----------
>>  2 files changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 13b59d384845..8e2bc304f671 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *folio)
>>         return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>>  }
>>
>> +/* Flags for folio_pte_batch(). */
>> +typedef int __bitwise fpb_t;
>> +
>> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>> +#define FPB_IGNORE_DIRTY               ((__force fpb_t)BIT(0))
>> +
>> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>> +#define FPB_IGNORE_SOFT_DIRTY          ((__force fpb_t)BIT(1))
>> +
>> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
>> +               pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>> +               bool *any_writable);
>> +
>>  void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>>                                                 int nr_throttled);
>>  static inline void acct_reclaim_writeback(struct folio *folio)
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 1c45b6a42a1b..319b3be05e75 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
>>         set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>>  }
>>
>> -/* Flags for folio_pte_batch(). */
>> -typedef int __bitwise fpb_t;
>> -
>> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>> -#define FPB_IGNORE_DIRTY               ((__force fpb_t)BIT(0))
>> -
>> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>> -#define FPB_IGNORE_SOFT_DIRTY          ((__force fpb_t)BIT(1))
>> -
>>  static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>  {
>>         if (flags & FPB_IGNORE_DIRTY)
>> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>   * If "any_writable" is set, it will indicate if any other PTE besides the
>>   * first (given) PTE is writable.
>>   */
>> -static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>> +int folio_pte_batch(struct folio *folio, unsigned long addr,
>>                 pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>>                 bool *any_writable)
>>  {
>> --
>> 2.34.1
>>
> 
> Thanks
> Barry


