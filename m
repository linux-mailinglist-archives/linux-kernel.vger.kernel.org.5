Return-Path: <linux-kernel+bounces-132731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FB289995E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176E71C213ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB9215FD14;
	Fri,  5 Apr 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+Ab7Aam"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C7145B09
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309083; cv=none; b=EyQJMbGcF2/7oBqkoNjXzymd9EOcpAdXujo4FNqG6Hn1nTXBIdbb3IH6kV8JjcapbuGfziDH5B5Z6ZwSambqPsIuHR5ircBotnOWygGWM5X0CAtv+dqfJLqJzbRnH/qevLfzax/lecYhgFAG1JISIumHmb9YUZpRFwDtDAT6oV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309083; c=relaxed/simple;
	bh=7e+GZYsKL7Gf+BXm+BdH4bf3XLqLFRAkE4luSGnT9kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pG0FQBaf8CVgrY93479kvgYSW3VvfYgrP5SwicLVywYLwvgTXMJDvS6UR5oI2W2mby0Ko+qVONPp1Ym8eJzPjpl1JhHk5QsM96dfLhOG4vofD70cPKnPdB691loLzkls5AzWihx3H8QPiuGcGRhmgfeYInKVPMUF4U75bFSwONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+Ab7Aam; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712309081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5CUGEh7qt513XXq70meozxW0RhRyZE2IyjxQxM/2VZo=;
	b=X+Ab7AamwhWT2pWYcr0MW/pP63k9W6OoUlSClOsilDXukO8EA31tRlsbtSShU04dzG+UEy
	Juu8IpsZq7Ipmur8JPkN7gsVBo5qBwJKMp1L0U5VYDonj8XTWkczQozM7wu39HMTAv5af8
	D/P7AdyFMZxlrW/hCdkU+jcHn/FUllM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-mLm2tNPAPnSgGxRcazK7CQ-1; Fri, 05 Apr 2024 05:24:39 -0400
X-MC-Unique: mLm2tNPAPnSgGxRcazK7CQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3437032fe82so1534046f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309078; x=1712913878;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CUGEh7qt513XXq70meozxW0RhRyZE2IyjxQxM/2VZo=;
        b=eRce0eFRuilfScO80Zdh4QC9ydVm0eho00TJ5B1mBM3rJkqiU46lgjAsicxsGrR+eV
         TrzWIipaMKqSBiSXW7KIIkYAmAw1n2ICg4vhTdWmhDi9a2pWdGOLBvHSeyubIYVr5SWH
         j6JriLCIhAuPLfzD0vVO7MDtD1cof69XBcvgHe377qGbDmdhXaUrWvq4Iy2sjsqVRxnK
         K3fBK4G2JS2qM2HmvS/3VDFKutSpRJxgjPoMGArVV6+ZN5Bnelt4Fk/wWt1F5aLRBux3
         DrxwoOI7mdiGlWaCDi0zlW13rLFQSnv9WuXo+Vcm21BX/xbpqOQuvmTuz0IxwATpqn61
         50LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+EC9B85/ET/oM6MBoILYjR8lH0uJPOXRMPkPNw3P9GJ9OIO9H9w65Ft+Uf0+UjXW4Zv/JYHGVFbKcUftF7RLnsPGud70u6BiIgkfg
X-Gm-Message-State: AOJu0YzB7VsrKSalFI6g2F8huLXJ5Lx6/IBbYb+5PuC0P/FnOjeTLUKT
	wQniEIIxJdeOvitohNqRSiTGarAYfcKAUieUA6poC2fNyQ777FmnToQT6lZHaSMBzRpmnJCv4hx
	DeU0E7euKSU5Y8WKNu1Mg9Z3xlc27XAs0Sm533aBBeU1g/jbxqApCZwXB1ECNaw==
X-Received: by 2002:adf:e9c4:0:b0:343:dde1:2ef6 with SMTP id l4-20020adfe9c4000000b00343dde12ef6mr1522665wrn.27.1712309078251;
        Fri, 05 Apr 2024 02:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETvnnYUTERDtD8QL5p05wSwIy4I+fVaePwiqrjA6gbsbZPJlrr5CFHgaERteBP0qlfc0HVgg==
X-Received: by 2002:adf:e9c4:0:b0:343:dde1:2ef6 with SMTP id l4-20020adfe9c4000000b00343dde12ef6mr1522634wrn.27.1712309077765;
        Fri, 05 Apr 2024 02:24:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d568b000000b00343c9ce4b50sm1559079wrv.53.2024.04.05.02.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:24:37 -0700 (PDT)
Message-ID: <7d5b2f03-dc36-477d-8d5c-4eb8d45db398@redhat.com>
Date: Fri, 5 Apr 2024 11:24:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
To: Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-3-ryan.roberts@arm.com>
 <B0E526FD-64CF-4653-B624-1AFA5B7AA245@nvidia.com>
 <4020c532-d20d-4624-8ea6-607de423396c@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4020c532-d20d-4624-8ea6-607de423396c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 09:21, Ryan Roberts wrote:
> On 03/04/2024 01:30, Zi Yan wrote:
>> On 27 Mar 2024, at 10:45, Ryan Roberts wrote:
>>
>>> Now that we no longer have a convenient flag in the cluster to determine
>>> if a folio is large, free_swap_and_cache() will take a reference and
>>> lock a large folio much more often, which could lead to contention and
>>> (e.g.) failure to split large folios, etc.
>>>
>>> Let's solve that problem by batch freeing swap and cache with a new
>>> function, free_swap_and_cache_nr(), to free a contiguous range of swap
>>> entries together. This allows us to first drop a reference to each swap
>>> slot before we try to release the cache folio. This means we only try to
>>> release the folio once, only taking the reference and lock once - much
>>> better than the previous 512 times for the 2M THP case.
>>>
>>> Contiguous swap entries are gathered in zap_pte_range() and
>>> madvise_free_pte_range() in a similar way to how present ptes are
>>> already gathered in zap_pte_range().
>>>
>>> While we are at it, let's simplify by converting the return type of both
>>> functions to void. The return value was used only by zap_pte_range() to
>>> print a bad pte, and was ignored by everyone else, so the extra
>>> reporting wasn't exactly guaranteed. We will still get the warning with
>>> most of the information from get_swap_device(). With the batch version,
>>> we wouldn't know which pte was bad anyway so could print the wrong one.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>   include/linux/pgtable.h | 28 +++++++++++++++
>>>   include/linux/swap.h    | 12 +++++--
>>>   mm/internal.h           | 48 +++++++++++++++++++++++++
>>>   mm/madvise.c            | 12 ++++---
>>>   mm/memory.c             | 13 +++----
>>>   mm/swapfile.c           | 78 ++++++++++++++++++++++++++++++-----------
>>>   6 files changed, 157 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 09c85c7bf9c2..8185939df1e8 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -708,6 +708,34 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
>>>   }
>>>   #endif
>>>
>>> +#ifndef clear_not_present_full_ptes
>>> +/**
>>> + * clear_not_present_full_ptes - Clear consecutive not present PTEs.
>>> + * @mm: Address space the ptes represent.
>>> + * @addr: Address of the first pte.
>>> + * @ptep: Page table pointer for the first entry.
>>> + * @nr: Number of entries to clear.
>>> + * @full: Whether we are clearing a full mm.
>>> + *
>>> + * May be overridden by the architecture; otherwise, implemented as a simple
>>> + * loop over pte_clear_not_present_full().
>>> + *
>>> + * Context: The caller holds the page table lock.  The PTEs are all not present.
>>> + * The PTEs are all in the same PMD.
>>> + */
>>> +static inline void clear_not_present_full_ptes(struct mm_struct *mm,
>>> +		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
>>> +{
>>> +	for (;;) {
>>> +		pte_clear_not_present_full(mm, addr, ptep, full);
>>> +		if (--nr == 0)
>>> +			break;
>>> +		ptep++;
>>> +		addr += PAGE_SIZE;
>>> +	}
>>> +}
>>> +#endif
>>> +
>>
>> Would the code below be better?
>>
>> for (i = 0; i < nr; i++, ptep++, addr += PAGE_SIZE)
>> 	pte_clear_not_present_full(mm, addr, ptep, full);
> 
> I certainly agree that this is cleaner and more standard. But I'm copying the
> pattern used by the other batch helpers. I believe this pattern was first done
> by Willy for set_ptes(), then continued by DavidH for wrprotect_ptes() and
> clear_full_ptes().
> 
> I guess the benefit is that ptep and addr are only incremented if we are going
> around the loop again. I'd rather continue to be consistent with those other
> helpers.

Yes please. I remember Willy found that variant to be most micro-optimized.

-- 
Cheers,

David / dhildenb


