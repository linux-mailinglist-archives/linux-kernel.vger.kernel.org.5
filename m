Return-Path: <linux-kernel+bounces-82933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47671868BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F34281012
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD513340B;
	Tue, 27 Feb 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2Q27Mq2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA5C55E68
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025291; cv=none; b=WrRrH+jwKudJLYchdLGLEBqlPXi0zeeoWP3zEu8hKXqalK+KJ8JXWtJoDhk4f6082XvqjvTEIk72OxBKJb6IRR41Qi574v73b8Wx5MmTsm+zxKo/a1MOpuidT896aVSzUXDMAckt+h5krJbSZy8dwoQKTNu1od6RnnVF0X+e2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025291; c=relaxed/simple;
	bh=ouup5rxCuyQmiwZH4Xmdvo22x+lDkW+vtUFTUlJ7NfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2IwQ2oHAUW8FOpGXvQha9UPyL1uQ5XedceFQwcmnq3+I8+VCeU5qyhy6CErRDE4vJCAGv7Rz4EwPRohx0+mgbePNlUsMzzDMbE+LduCkPwJ5eXppe2K8d5Jd0p9R/s0XxTqRIbI6JZu6hykcQxvbY27M2fEAycFOHC8H6FJcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2Q27Mq2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709025288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2/gjWd2qDKmet6I9PBwA50r61BeuZ2ughk1QxC4Mh80=;
	b=h2Q27Mq2+2oDhNFzdZkLHT8Jd886BiLlZbjmBW4LrzTCZVADCxRzYKQOAjr7WZZsZqC1XV
	va/89LeMGPtLBe0RQ0eNapdqa+Yiwh0hFu0KuavEbnIHWab7BOA8aDGEEyMtKF/y1/Vxb1
	zB2+DshF2H01oyV+Omz5hrpzo4AgNkA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-el69sIBAPOa0upP3m21JQw-1; Tue, 27 Feb 2024 04:14:46 -0500
X-MC-Unique: el69sIBAPOa0upP3m21JQw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412a44c72c1so8239085e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025285; x=1709630085;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/gjWd2qDKmet6I9PBwA50r61BeuZ2ughk1QxC4Mh80=;
        b=Vbk6RE054GgqcoIZ8Y1y/jNzhnagNGMXpiogvAWfBbT1l4o7hY2PQl/HUmayUTY+u+
         4ENpoLQKo0BzOep8A0GtCPUVBKqf8eeJA/IsnrwPE8PtTMeTAg0O4iuDge8MEQBleQAr
         roZYgBNw282ZgE4OuI6bHdrHvvYJPe2i0VmpAHP6MzpMwkfcZ09Uit8tkgLQbdSBbTaK
         bkAkCuRZo7CVk5tHvK+09DDJSVLOZSs1E3OKxBa4OaWvOEeaudVzWq/BbMdl+iNAKPY9
         wEorV2m3UD6wPQZNCSLkWzxgiwzGtH1MzcQlrE/1+jfyy1gvsUgwZUv4qwdkOQ1GlJsR
         zHKw==
X-Gm-Message-State: AOJu0Yz4CzFvjad6shCJIJhx4fEOzOPZ5C1sMAQwFgxAUK7hSmNRlPfh
	EIJU63mhDuwmIr1tabzIU9xTjHK5TQIyXnK1kkoIl0qZxB/jLpKMNTxnkfY9oj/e02LG/MN/90F
	x/grFRQSXLwEUi7BPuAsiZqwK0HWGdPd2O6ZX+JsdvxKtFPv0dVFmrB9crRDT2A==
X-Received: by 2002:a05:600c:1f86:b0:412:8306:a7bb with SMTP id je6-20020a05600c1f8600b004128306a7bbmr7895002wmb.12.1709025285706;
        Tue, 27 Feb 2024 01:14:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnDYuhOpt+TZSeo4lVcA2J8HInWVZsVc0kUTBO9H7Gg6MmXIwJBPzdYYwZC4Hw8JgWBUma0Q==
X-Received: by 2002:a05:600c:1f86:b0:412:8306:a7bb with SMTP id je6-20020a05600c1f8600b004128306a7bbmr7894980wmb.12.1709025285290;
        Tue, 27 Feb 2024 01:14:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c00d400b00410b0ce91b1sm14393440wmm.25.2024.02.27.01.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:14:44 -0800 (PST)
Message-ID: <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com>
Date: Tue, 27 Feb 2024 10:14:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Yin Fengwei <fengwei.yin@intel.com>
References: <20240227024050.244567-1-21cnbao@gmail.com>
 <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.24 10:07, Ryan Roberts wrote:
> On 27/02/2024 02:40, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> madvise and some others might need folio_pte_batch to check if a range
>> of PTEs are completely mapped to a large folio with contiguous physcial
>> addresses. Let's export it for others to use.
>>
>> Cc: Lance Yang <ioworker0@gmail.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>   -v1:
>>   at least two jobs madv_free and madv_pageout depend on it. To avoid
>>   conflicts and dependencies, after discussing with Lance, we prefer
>>   this one can land earlier.
> 
> I think this will also ultimately be useful for mprotect too, though I haven't
> looked at it properly yet.
> 

Yes, I think we briefly discussed that.

>>
>>   mm/internal.h | 13 +++++++++++++
>>   mm/memory.c   | 11 +----------
>>   2 files changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 13b59d384845..8e2bc304f671 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *folio)
>>   	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>>   }
>>   
>> +/* Flags for folio_pte_batch(). */
>> +typedef int __bitwise fpb_t;
>> +
>> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>> +#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
>> +
>> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>> +#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
>> +
>> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
>> +		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>> +		bool *any_writable);
>> +
>>   void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>>   						int nr_throttled);
>>   static inline void acct_reclaim_writeback(struct folio *folio)
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 1c45b6a42a1b..319b3be05e75 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
>>   	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>>   }
>>   
>> -/* Flags for folio_pte_batch(). */
>> -typedef int __bitwise fpb_t;
>> -
>> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>> -#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
>> -
>> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>> -#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
>> -
>>   static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>   {
>>   	if (flags & FPB_IGNORE_DIRTY)
>> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>    * If "any_writable" is set, it will indicate if any other PTE besides the
>>    * first (given) PTE is writable.
>>    */
> 
> David was talking in Lance's patch thread, about improving the docs for this
> function now that its exported. Might be worth syncing on that.

Here is my take:

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/memory.c | 22 ++++++++++++++++++----
  1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d0b855a1837a8..098356b8805ae 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -971,16 +971,28 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  	return pte_wrprotect(pte_mkold(pte));
  }
  
-/*
+/**
+ * folio_pte_batch - detect a PTE batch for a large folio
+ * @folio: The large folio to detect a PTE batch for.
+ * @addr: The user virtual address the first page is mapped at.
+ * @start_ptep: Page table pointer for the first entry.
+ * @pte: Page table entry for the first page.
+ * @max_nr: The maximum number of table entries to consider.
+ * @flags: Flags to modify the PTE batch semantics.
+ * @any_writable: Optional pointer to indicate whether any entry except the
+ *		  first one is writable.
+ *
   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
- * pages of the same folio.
+ * pages of the same large folio.
   *
   * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
   * the accessed bit, writable bit, dirty bit (with FPB_IGNORE_DIRTY) and
   * soft-dirty bit (with FPB_IGNORE_SOFT_DIRTY).
   *
- * If "any_writable" is set, it will indicate if any other PTE besides the
- * first (given) PTE is writable.
+ * start_ptep must map any page of the folio. max_nr must be at least one and
+ * must be limited by the caller so scanning cannot exceed a single page table.
+ *
+ * Return: the number of table entries in the batch.
   */
  static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
  		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
@@ -996,6 +1008,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
  		*any_writable = false;
  
  	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
+	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
+	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
  
  	nr = pte_batch_hint(start_ptep, pte);
  	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
-- 
2.43.2


> 
>> -static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>> +int folio_pte_batch(struct folio *folio, unsigned long addr,
> 
> fork() is very performance sensitive. Is there a risk we are regressing
> performance by making this out-of-line? Although its in the same compilation
> unit so the compiler may well inline it anyway?

Easy to verify by looking at the generated asm I guess?

> 
> Either way, perhaps we are better off making it inline in the header? That would
> avoid needing to rerun David's micro-benchmarks for fork() and munmap().

That way, the compiler can most certainly better optimize it also outside of mm/memory.c

-- 
Cheers,

David / dhildenb


