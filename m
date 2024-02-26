Return-Path: <linux-kernel+bounces-80923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767D9866E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0154D1F290E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372F1CAB7;
	Mon, 26 Feb 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYZOguv9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3921CAA2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936901; cv=none; b=gWBLS+kzADwh/BYx/WzMkafwLJtj1mvX6MF9GXC3/ZxRbUDSWR8sr+K/qakeR/bGAvxVSj/8n4o5EI4/+HqlotEeEVohjnaWhdpQqh55900kpeRytg5AJKfMI9jUT3PNGpsGeJppT3H+vDBA2CfiNJwHzKaqF8GZ7jZ1jZ/yick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936901; c=relaxed/simple;
	bh=c7jj18jWYlB26ju/1lg9Pby6pC6dQoZyhm13sYGA9zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DP+vKkkN0C+4w74ZdJY3RDZEQu32uZ2hNarnklQUImGOPv1Yc7qZZlHkiVqXcfUgC5ne2EoMercWJnTWbiyvR9ggphai3sz8+amDufLpTk/VpOx3Ex2TwyqT7Jz+pQ4de8U5wfNxkvGZb3gvWbkpKNER9m1uqUCebwOVEj3IfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYZOguv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708936898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P8y/Ig8ZKtbAPD0VATVTl6bWZP8q1OWRJYCo5KhKU9A=;
	b=GYZOguv9EbcXy5cK9LR9bSXjb4ZcJO16ewnSN6kkdrN3SgZAW4jdReLf2qmS1vtz4eads1
	GXAYk8HQA20JWIwGz0j37vS4kpZiLAwMXFFNTd5KRx26VGVM98R7LtMP+dOiwai6zckn6n
	g81zIm1mi5y8XH1A51n/cQT/x0c4n30=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-rLjflVEgPySaJgHXWOCI3Q-1; Mon, 26 Feb 2024 03:41:36 -0500
X-MC-Unique: rLjflVEgPySaJgHXWOCI3Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33dbbe709ffso510483f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936895; x=1709541695;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8y/Ig8ZKtbAPD0VATVTl6bWZP8q1OWRJYCo5KhKU9A=;
        b=wlFUtG2PwbVuIkqvit/sK01JColU0IoiyVjkOtexte5Pinc1G2lNeeism17HVXwUd2
         ewpx38pCMrpNVm9sVhicf/VXpY4BYlDwfnAH01k+FKuUHWQqV5uYWRZvKtH4DBTHYlOS
         Xi6nRAW0/IHs+jlXJjlhISlWkavICQPR7mWn0+rYlGJ3Y3Ts2aHabEXdafaZaayA1JOT
         BSBB15BFORI6y8DWL00jw4kKA1pN8fxAdA/6KO0Q2WUXa5+5TofYDMHTSZLn0NtHMnSB
         DiSzbV9DkLrl0m0qsIJaql18zZMoNUkV4+xj8fjT5Db3Eu0+o4zajNz4HaM4puY7GOny
         hzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFrYmk5X5tbq1Q/QJcau0DoG4apCAwWrQ+iLAGb8APHKGIBia0fY9YNm8NvrwK1j4qoh8cxioidRJzcwTW9a6lg0ikClId+qQHf1x+
X-Gm-Message-State: AOJu0YxoP+sYZ5z+Sqzn4DeKRf7mNPxW04PSmsO2WcJZzkslZVU7IJnk
	E5ibnxd8dnMQ4RXUTXFSeHWnkb7QrU3jY6/ekJzyGAtPVR4zZcxQfCmOE5YJuZIlRNe8OP1W/DG
	nW2r3OOJ4iDGzAFeWDItxdbbunIxZJ2g0CmlC7KoC2729kYqqiOJ1M315mt7Q2g==
X-Received: by 2002:adf:e284:0:b0:33d:a62e:43b3 with SMTP id v4-20020adfe284000000b0033da62e43b3mr4944829wri.64.1708936895707;
        Mon, 26 Feb 2024 00:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYiDh9bcerQN3wetWVRDWBu8sC9PT1BDY2gY8LqGhz5mlFGFNBe/ffySnTb2ls3t7PEKcOZw==
X-Received: by 2002:adf:e284:0:b0:33d:a62e:43b3 with SMTP id v4-20020adfe284000000b0033da62e43b3mr4944803wri.64.1708936895303;
        Mon, 26 Feb 2024 00:41:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:f700:104b:9184:1b45:1898? (p200300cbc72ff700104b91841b451898.dip0.t-ipconnect.de. [2003:cb:c72f:f700:104b:9184:1b45:1898])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b0033cf5094fcesm7549356wrc.36.2024.02.26.00.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:41:34 -0800 (PST)
Message-ID: <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
Date: Mon, 26 Feb 2024 09:41:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>, 21cnbao@gmail.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com,
 ryan.roberts@arm.com, shy828301@gmail.com, songmuchun@bytedance.com,
 wangkefeng.wang@huawei.com, zokeefe@google.com, fengwei.yin@intel.com
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240226083714.26187-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.02.24 09:37, Lance Yang wrote:
> Hey Barry,
> 
> Thanks for taking time to review!
> 
> On Mon, Feb 26, 2024 at 12:00 PM Barry Song <21cnbao@gmail.com> wrote:
> [...]
>> On Mon, Feb 26, 2024 at 1:33 AM Lance Yang <ioworker0@gmail.com> wrote:
> [...]
>> We did something similar on MADV_PAGEOUT[1]
>> [1] https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail.com/
> 
> Thanks for providing the link above.
> 
> [...]
>>> +                        * Avoid unnecessary folio splitting if the large
>>> +                        * folio is entirely within the given range.
>>> +                        */
>>> +                       folio_test_clear_dirty(folio);
>>> +                       folio_unlock(folio);
>>> +                       for (; addr != next_addr; pte++, addr += PAGE_SIZE) {
>>> +                               ptent = ptep_get(pte);
>>> +                               if (pte_young(ptent) || pte_dirty(ptent)) {
>>> +                                       ptent = ptep_get_and_clear_full(
>>> +                                               mm, addr, pte, tlb->fullmm);
>>> +                                       ptent = pte_mkold(ptent);
>>> +                                       ptent = pte_mkclean(ptent);
>>> +                                       set_pte_at(mm, addr, pte, ptent);
>>> +                                       tlb_remove_tlb_entry(tlb, pte, addr);
>>> +                               }
>>
>> The code works under the assumption the large folio is entirely mapped
>> in all PTEs in the range. This is not always true.
>>
>> This won't work in some cases as some PTEs might be mapping to the
>> large folios. some others might have been unmapped or mapped
>> to different folios.
>>
>> so in MADV_PAGEOUT, we have a function to check the folio is
>> really entirely mapped:
>>
>> +static inline bool pte_range_cont_mapped(unsigned long start_pfn,
>> + pte_t *start_pte, unsigned long start_addr, int nr)
>> +{
>> +              int i;
>> +              pte_t pte_val;
>> +
>> +              for (i = 0; i < nr; i++) {
>> +                           pte_val = ptep_get(start_pte + i);
>> +
>> +                           if (pte_none(pte_val))
>> +                                        return false;
>> +
>> +                           if (pte_pfn(pte_val) != (start_pfn + i))
>> +                                        return false;
>> +              }
>> +
>> +              return true;
>> +}
> 
> Thanks for providing the information; it's very helpful to me!
> I made some changes. Would you mind taking another look, please?
> 
> As a diff against this patch.
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index bcbf56595a2e..255d2f329be4 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -616,6 +616,18 @@ static long madvise_pageout(struct vm_area_struct *vma,
>   	return 0;
>   }
>   
> +static inline bool pte_range_cont_mapped(pte_t *pte, unsigned long nr)
> +{
> +	pte_t pte_val;
> +	unsigned long pfn = pte_pfn(pte);
> +	for (int i = 0; i < nr; i++) {
> +		pte_val = ptep_get(pte + i);
> +		if (pte_none(pte_val) || pte_pfn(pte_val) != (pfn + i))
> +			return false;
> +	}
> +	return true;
> +}

I dislike the "cont mapped" terminology.

Maybe folio_pte_batch() does what you want?

-- 
Cheers,

David / dhildenb


