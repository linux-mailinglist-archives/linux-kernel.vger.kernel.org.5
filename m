Return-Path: <linux-kernel+bounces-91335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50177870FAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743151C230A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4237B3FD;
	Mon,  4 Mar 2024 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBp9vlQy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D411F60A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589732; cv=none; b=r8O4UWLrhiISobTi6bCTEfr00dTbgmn40QHFfT1oSv5Kr/0BSIgV2XQdISPgkzDJpiC5Z/srXesTCgRMdyaXFGOhdaPm0HAjdvkEBHZePpCSw18THoJlP8U7/yfZQODDA4XsuFt0QlcP1ndNnglrCPDOUXy5oArYffG4xrMzFVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589732; c=relaxed/simple;
	bh=ZsS/evDbxWSi4GEk1h1mDCydMazNVdqC+HaNBuEtAvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSRkUFVbZqwFVmGPXRTEsidIHWliXQf9eqm41mqtQzydvdD1ef8HeP/w3i1npyGLP+I3bzCt62OUCk2U1WNEFzn6f49NoiC2d3cgC23NAKghLE0o39H0ZZ+L5K9ZZSZkbZfhcaG1+3KyNAE4+2r5+1hwKg2RqiK5qznXn1GhYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBp9vlQy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709589728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/lOOQEDhmZ6iERpA92aARWtQ+g49q7FmW05Be5tF+as=;
	b=gBp9vlQy8CqqSAup1suSLAYX7CRuAxhMMtBNTncjsZCfpDzzCf8ZkjdUqUccB95YgJJgJ3
	9PEsZ5gzl2GMIrlNP4y377EGsPEmIWPuIOtbmGlD9VpzE79YQwyqjfWCmMwYuYvVoeWVbJ
	YN1tpBTcrNzMEhouSBNzDiW6xtc9SWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-RAsfWyB5Mty2fLm5nU73Mg-1; Mon, 04 Mar 2024 17:02:07 -0500
X-MC-Unique: RAsfWyB5Mty2fLm5nU73Mg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412e992444eso2580885e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 14:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709589726; x=1710194526;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lOOQEDhmZ6iERpA92aARWtQ+g49q7FmW05Be5tF+as=;
        b=Gmb7r2Es9F7hTJPHN2eW0RUr567gvB9NQKcaAGaYGi6BWLsVV4/4NiPJ6olnCfZHpq
         4WNV2xcI+3SdClAR76dLiprpX+e7ReHgmhP4SE+9cXA9IF6j4Yse2uOgeo4jSJO+Hbbc
         FDeux5sUXwR6YAJenES2sMOZgy68vN8l4X9mK+HF+o1dT4H9TCFwIotsIwqOt6o61DUr
         gtwNmqgS9UGFsxVi64944rbq9hPctAVgjJjYdtk2KM9ss2Ioqy8m5eg9pD/kFm8cqwHU
         1nxIgJULADxHVf7cIfkewv8d6pc8x5aDWCmYXYIM9XCMfmSebd1yQ68c+s5O+f6k53yL
         Qk3g==
X-Gm-Message-State: AOJu0Yya7+eo/Is6rMnRQKW03N5d4zKCgrUMN4qkgvxxiQGNdprXofww
	c4hl5M9eaT761aomW5MjTaVn+CiVwO/xRGWy7TKTfEdPRNIJd/WC2xh5/GV/KtWovhIxFOsf/aa
	emd4JfsWpgV2g2+tDFv+70Ge8JICErtMxiYcu52A8FDM+3omNg3iu4lI7faNLcQ==
X-Received: by 2002:adf:ee8c:0:b0:33d:82bb:d1ad with SMTP id b12-20020adfee8c000000b0033d82bbd1admr7319773wro.27.1709589725792;
        Mon, 04 Mar 2024 14:02:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5bRsBUMEZNEwZXW1H9TOuKiTS0AYPYor+ULksK1OfhuJLrvfpOlmaEeg3QBZoIpaOEOsqEw==
X-Received: by 2002:adf:ee8c:0:b0:33d:82bb:d1ad with SMTP id b12-20020adfee8c000000b0033d82bbd1admr7319762wro.27.1709589725357;
        Mon, 04 Mar 2024 14:02:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c733:f100:75e7:a0a4:9ac2:1abb? (p200300cbc733f10075e7a0a49ac21abb.dip0.t-ipconnect.de. [2003:cb:c733:f100:75e7:a0a4:9ac2:1abb])
        by smtp.gmail.com with ESMTPSA id co14-20020a0560000a0e00b0033e3ce48ba1sm3941070wrb.16.2024.03.04.14.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 14:02:04 -0800 (PST)
Message-ID: <3d47ae7d-297a-441e-941c-5b2e34ba8759@redhat.com>
Date: Mon, 4 Mar 2024 23:02:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
 <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
 <b642c7ff-c452-4066-ac12-dbf05e215cb9@arm.com>
 <949b6c22-d737-4060-9ca1-a69d8e986d90@redhat.com>
 <9ed743a7-0c5d-49d9-b8b2-d58364df1f5f@arm.com>
 <65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com>
 <6cfc022a-0c7a-4fe6-aaa4-3d28aeacc982@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6cfc022a-0c7a-4fe6-aaa4-3d28aeacc982@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.03.24 22:55, Ryan Roberts wrote:
> On 04/03/2024 20:50, David Hildenbrand wrote:
>>>>>
>>>>> This is the existing free_swap_and_cache(). I think _swap_info_get() would
>>>>> break
>>>>> if this could race with swapoff(), and __swap_entry_free() looks up the cluster
>>>>> from an array, which would also be freed by swapoff if racing:
>>>>>
>>>>> int free_swap_and_cache(swp_entry_t entry)
>>>>> {
>>>>>       struct swap_info_struct *p;
>>>>>       unsigned char count;
>>>>>
>>>>>       if (non_swap_entry(entry))
>>>>>           return 1;
>>>>>
>>>>>       p = _swap_info_get(entry);
>>>>>       if (p) {
>>>>>           count = __swap_entry_free(p, entry);
>>>>
>>>> If count dropped to 0 and
>>>>
>>>>>           if (count == SWAP_HAS_CACHE)
>>>>
>>>>
>>>> count is now SWAP_HAS_CACHE, there is in fact no swap entry anymore. We removed
>>>> it. That one would have to be reclaimed asynchronously.
>>>>
>>>> The existing code we would call swap_page_trans_huge_swapped() with the SI it
>>>> obtained via _swap_info_get().
>>>>
>>>> I also don't see what should be left protecting the SI. It's not locked anymore,
>>>> the swapcounts are at 0. We don't hold the folio lock.
>>>>
>>>> try_to_unuse() will stop as soon as si->inuse_pages is at 0. Hm ...
>>>
>>> But, assuming the caller of free_swap_and_cache() acquires the PTL first, I
>>> think this all works out ok? While free_swap_and_cache() is running,
>>> try_to_unuse() will wait for the PTL. Or if try_to_unuse() runs first, then
>>> free_swap_and_cache() will never be called because the swap entry will have been
>>> removed from the PTE?
>>
>> But can't try_to_unuse() run, detect !si->inuse_pages and not even bother about
>> scanning any further page tables?
>>
>> But my head hurts from digging through that code.
> 
> Yep, glad I'm not the only one that gets headaches from swapfile.c.
> 
>>
>> Let me try again:
>>
>> __swap_entry_free() might be the last user and result in "count == SWAP_HAS_CACHE".
>>
>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>
>>
>> So the question is: could someone reclaim the folio and turn si->inuse_pages==0,
>> before we completed swap_page_trans_huge_swapped().
>>
>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are still
>> references by swap entries.
>>
>> Process 1 still references subpage 0 via swap entry.
>> Process 2 still references subpage 1 via swap entry.
>>
>> Process 1 quits. Calls free_swap_and_cache().
>> -> count == SWAP_HAS_CACHE
>> [then, preempted in the hypervisor etc.]
>>
>> Process 2 quits. Calls free_swap_and_cache().
>> -> count == SWAP_HAS_CACHE
>>
>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>> __try_to_reclaim_swap().
>>
>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->put_swap_folio()->
>> free_swap_slot()->swapcache_free_entries()->swap_entry_free()->swap_range_free()->
>> ...
>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>
>>
>> What stops swapoff to succeed after process 2 reclaimed the swap cache but
>> before process 1 finished its call to swap_page_trans_huge_swapped()?
> 
> Assuming you are talking about anonymous memory, process 1 has the PTL while
> it's executing free_swap_and_cache(). try_to_unuse() iterates over every vma in
> every mm, and it swaps-in a page for every PTE that holds a swap entry for the
> device being swapoff'ed. It takes the PTL while converting the swap entry to
> present PTE - see unuse_pte(). Process 1 must have beaten try_to_unuse() to the
> particular pte, because if try_to_unuse() got there first, it would have
> converted it from a swap entry to present pte and process 1 would never even
> have called free_swap_and_cache(). So try_to_unuse() will eventually wait on the
> PTL until process 1 has released it after free_swap_and_cache() completes. Am I
> missing something? Because that part feels pretty clear to me.

Why should try_to_unuse() do *anything* if it already finds
si->inuse_pages == 0 because we (p1 } p2) just freed the swapentries and 
process 2 managed to free the last remaining swapcache entry?

I'm probably missing something important :)

try_to_unuse() really starts with

	if (!READ_ONCE(si->inuse_pages))
		goto success;

-- 
Cheers,

David / dhildenb


