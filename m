Return-Path: <linux-kernel+bounces-76296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1F685F553
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914481C22178
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAD439857;
	Thu, 22 Feb 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8US3848"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD4383B6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596589; cv=none; b=jeDMpSwG+ijeGhIqt1ZkGQF+AROvgdAl0R2517PojcsLE99LF3mYvXCbX5YZZPTP7/8S9dOjty3r+xyvDhjEtNe9BiafCpROL6T2TS0O+trQRd70aIThwKqJGcb7G31iIK+A7NuEjXQtsZK5gexyu13oyp57DppaXlxKm5rBsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596589; c=relaxed/simple;
	bh=l7OP69mJjmjYhHV5Jm0JJ/uw/K7+1xgIU/++X08E1Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nK87xRZiWqoBXISs+tXir8A4n9lNGVvRF/g9tDZH4XhrNfal/Ctwt2e/RKmsN68iFMhA735wyv0JFJQD2YfTNWVvOOw2olJTMmbr1SmJ3Z69kH/VrB6bQ7J6xgCIpsH/CyBVOBywTI2iLv+qDblbWMMKEAh8gUwIQvlO/NT+3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8US3848; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708596586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4xnrCfEIVs3Du53BsshUUe9FZo9DURe+PxS/m7A6u5E=;
	b=d8US3848Zp2Xd6IhKFuBjFUABKtDrv0bG6O9f2fOBn38/xJhGkvU8yvvcvCHYVegORZdDt
	6n1yewJ8TN6qatAQCy9qUYqOAK8+4cJwTFQUhgV0UOBgwWuO4jPkf8FhJNI0BWQpIeD8B0
	JKV7C/XKPbzkwfo6zm265TdurBCUxVQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-qUTjJS-GPpunQTC0PkUy4A-1; Thu, 22 Feb 2024 05:09:44 -0500
X-MC-Unique: qUTjJS-GPpunQTC0PkUy4A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d89a393c8so391378f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596583; x=1709201383;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xnrCfEIVs3Du53BsshUUe9FZo9DURe+PxS/m7A6u5E=;
        b=h43AhmUo8znsVft7KZUgE6xl4qxkny6Kef6LSWS6QL1pc2yNvtMvjaBqi3m6CXsMPA
         6cMiuc6OgM8A3c3KIYO1bnNWivgVKmSej6WlSOzz4Yv8P7UazfvtgmnAOFqUx/osqrCV
         1gVKOOPMGTHdaqhKVt8/l4PKBqrE1xFRa3Vw+/TvxrIq7gdw8RfJvxGBWS8iC06jsdMj
         tx+gYMnpE6pu8ScPGZd8s34idkvOFWm2XgyeUSTPZZbwJeOTgcTNS/eflxZMSQ7UWJ7x
         QWzq7tzwRBxrv2oAqHH1sQC8KqOT4AcGitjjtw17nTxuZVCCt937rnqnbkCpUk4GpvZj
         aXbg==
X-Forwarded-Encrypted: i=1; AJvYcCVLvTXQHg4AKXrrSvi5IKWmFJYM6SspUW3J+Ko9KAnGjXT8iDGPI8uYv2Wu9JneAiyX0CWv4YI3h07StYT25ogwWlrMc1XdmAul9QnG
X-Gm-Message-State: AOJu0YyZ66kC2diGkWH/ZYwhnRNFhsI0SPTVy0rcLSOFsLhB/5xpAhux
	hxJ8Evw9kEMV0z1vXcvyONhiSvYZGE3JnUl/I8A/40b2v6TC3jCfNVXQFfnccJn9OA+zavpzW0B
	BL4mnXOszITy35asNId7Wm/5XKEJu92okAdnFqWdw6wuTHwB8Vj04PnNU8//xNg==
X-Received: by 2002:a5d:59a9:0:b0:33d:9283:93b with SMTP id p9-20020a5d59a9000000b0033d9283093bmr890294wrr.47.1708596583564;
        Thu, 22 Feb 2024 02:09:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFci1HE9M+Tq7v/+E6ijaeOFwkVfWkjtRhQA7c1BfNGSqEo7ggRfrqXvue4tJVcg5FFdQ/BFw==
X-Received: by 2002:a5d:59a9:0:b0:33d:9283:93b with SMTP id p9-20020a5d59a9000000b0033d9283093bmr890263wrr.47.1708596583081;
        Thu, 22 Feb 2024 02:09:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8b00:ed48:6d18:2152:1cda? (p200300cbc70f8b00ed486d1821521cda.dip0.t-ipconnect.de. [2003:cb:c70f:8b00:ed48:6d18:2152:1cda])
        by smtp.gmail.com with ESMTPSA id p15-20020a5d4e0f000000b0033d87f61613sm2474706wrt.58.2024.02.22.02.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:09:42 -0800 (PST)
Message-ID: <1a9fcdcd-c0dd-46dd-9c03-265a6988eeb2@redhat.com>
Date: Thu, 22 Feb 2024 11:09:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, ryan.roberts@arm.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yuzhao@google.com, chrisl@kernel.org,
 surenb@google.com, hanchuanhua@oppo.com
References: <20231025144546.577640-5-ryan.roberts@arm.com>
 <20240222070544.133673-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240222070544.133673-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.02.24 08:05, Barry Song wrote:
> Hi Ryan,
> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 2cc0cb41fb32..ea19710aa4cd 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>   					if (!can_split_folio(folio, NULL))
>>   						goto activate_locked;
>>   					/*
>> -					 * Split folios without a PMD map right
>> -					 * away. Chances are some or all of the
>> -					 * tail pages can be freed without IO.
>> +					 * Split PMD-mappable folios without a
>> +					 * PMD map right away. Chances are some
>> +					 * or all of the tail pages can be freed
>> +					 * without IO.
>>   					 */
>> -					if (!folio_entire_mapcount(folio) &&
>> +					if (folio_test_pmd_mappable(folio) &&
>> +					    !folio_entire_mapcount(folio) &&
>>   					    split_folio_to_list(folio,
>>   								folio_list))
>>   						goto activate_locked;
> 
> I ran a test to investigate what would happen while reclaiming a partially
> unmapped large folio. for example, for 64KiB large folios, MADV_DONTNEED
> 4KB~64KB, and keep the first subpage 0~4KiB.

IOW, something that already happens with ordinary THP already IIRC.

>   
> My test wants to address my three concerns,
> a. whether we will have leak on swap slots
> b. whether we will have redundant I/O
> c. whether we will cause races on swapcache
> 
> what i have done is printing folio->_nr_pages_mapped and dumping 16 swap_map[]
> at some specific stage
> 1. just after add_to_swap   (swap slots are allocated)
> 2. before and after try_to_unmap   (ptes are set to swap_entry)
> 3. before and after pageout (also add printk in zram driver to dump all I/O write)
> 4. before and after remove_mapping
> 
> The below is the dumped info for a particular large folio,
> 
> 1. after add_to_swap
> [   27.267357] vmscan: After add_to_swap shrink_folio_list 1947 mapnr:1
> [   27.267650] vmscan: offset:101b0 swp_map 40-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
> 
> as you can see,
> _nr_pages_mapped is 1 and all 16 swap_map are SWAP_HAS_CACHE (0x40)
> 
> 
> 2. before and after try_to_unmap
> [   27.268067] vmscan: before try to unmap shrink_folio_list 1991 mapnr:1
> [   27.268372] try_to_unmap_one address:ffff731f0000 pte:e8000103cd0b43 pte_p:ffff0000c36a8f80
> [   27.268854] vmscan: after try to unmap shrink_folio_list 1997 mapnr:0
> [   27.269180] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
> 
> as you can see, one pte is set to swp_entry, and _nr_pages_mapped becomes
> 0 from 1. The 1st swp_map becomes 0x41, SWAP_HAS_CACHE + 1
> 
> 3. before and after pageout
> [   27.269602] vmscan: before pageout shrink_folio_list 2065 mapnr:0
> [   27.269880] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
> [   27.270691] zram: zram_write_page page:fffffc00030f3400 index:101b0
> [   27.271061] zram: zram_write_page page:fffffc00030f3440 index:101b1
> [   27.271416] zram: zram_write_page page:fffffc00030f3480 index:101b2
> [   27.271751] zram: zram_write_page page:fffffc00030f34c0 index:101b3
> [   27.272046] zram: zram_write_page page:fffffc00030f3500 index:101b4
> [   27.272384] zram: zram_write_page page:fffffc00030f3540 index:101b5
> [   27.272746] zram: zram_write_page page:fffffc00030f3580 index:101b6
> [   27.273042] zram: zram_write_page page:fffffc00030f35c0 index:101b7
> [   27.273339] zram: zram_write_page page:fffffc00030f3600 index:101b8
> [   27.273676] zram: zram_write_page page:fffffc00030f3640 index:101b9
> [   27.274044] zram: zram_write_page page:fffffc00030f3680 index:101ba
> [   27.274554] zram: zram_write_page page:fffffc00030f36c0 index:101bb
> [   27.274870] zram: zram_write_page page:fffffc00030f3700 index:101bc
> [   27.275166] zram: zram_write_page page:fffffc00030f3740 index:101bd
> [   27.275463] zram: zram_write_page page:fffffc00030f3780 index:101be
> [   27.275760] zram: zram_write_page page:fffffc00030f37c0 index:101bf
> [   27.276102] vmscan: after pageout and before needs_release shrink_folio_list 2124 mapnr:0
> 
> as you can see, obviously, we have done redundant I/O - 16 zram_write_page though
> 4~64KiB has been zap_pte_range before, we still write them to zRAM.
> 
> 4. before and after remove_mapping
> [   27.276428] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
> [   27.277485] vmscan: after remove_mapping shrink_folio_list 2169 mapnr:0 offset:0
> [   27.277802] vmscan: offset:101b0 01-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
> 
> as you can see, swp_map 1-15 becomes 0 and only the first swp_map is 1.
> all SWAP_HAS_CACHE has been removed. This is perfect and there is no swap
> slot leak at all!
> 
> Thus, only two concerns are left for me,
> 1. as we don't split anyway, we have done 15 unnecessary I/O if a large folio
> is partially unmapped.
> 2. large folio is added as a whole as a swapcache covering the range whose
> part has been zapped. I am not quite sure if this will cause some problems
> while some concurrent do_anon_page, swapin and swapout occurs between 3 and
> 4 on zapped subpage1~subpage15. still struggling.. my brain is exploding...

Just noting: I was running into something different in the past with 
THP. And it's effectively the same scenario, just swapout and 
MADV_DONTNEED reversed.

Imagine you swapped out a THP and the THP it still is in the swapcache.

Then you unmap/zap some PTEs, freeing up the swap slots.

In zap_pte_range(), we'll call free_swap_and_cache(). There, we run into 
the "!swap_page_trans_huge_swapped(p, entry)", and we won't be calling 
__try_to_reclaim_swap().

So we won't split the large folio that is in the swapcache and it will 
continue consuming "more memory" than intended until fully evicted.

> 
> To me, it seems safer to split or do some other similar optimization if we find a
> large folio has partial map and unmap.

I'm hoping that we can avoid any new direct users of _nr_pages_mapped if 
possible.

If we find that the folio is on the deferred split list, we might as 
well just split it right away, before swapping it out. That might be a 
reasonable optimization for the case you describe.

-- 
Cheers,

David / dhildenb


