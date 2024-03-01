Return-Path: <linux-kernel+bounces-88815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66A86E708
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151A61F29A47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB68C1B;
	Fri,  1 Mar 2024 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NabDh8pO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71858BEB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313547; cv=none; b=HKy4NYOU3W7GY9RATLvks39moh4Hj7pgWUjtmqv9yGVaYvJy3WbP5zoimHnW9LCzk9SFRJfsaPkx5cBL7LjBDQVBpZGhNBCJXOFgaoA7Dlzy6xaA1S14It6iYCYeeT3ApaCb4nZoLv4ZtQIkwnnD8HuMWi1+UWjYnh80GGaIjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313547; c=relaxed/simple;
	bh=b3AgZhvl+7VL7ka+WCqt8qjw0MSg13jsoabbOV4zjFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NU5F4tvob2q7xz2Cr2WGw9NmlPiiDof2+k4xI3XcXgHwYOpN1lSZ93OrZzIAWZUPF3uFqUhqx4hsQ9LJQ+rk0FJpONbZ4ZH6huIBuRtDtSPQtKqEG52ltfZ9fQ8Od9vOXUPSV8P5zgEieuVgwB8bZ3oUU4CtFaKW4CD81GmlUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NabDh8pO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709313544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2iOy7UdgTKcwbx5hTPJnUBr/z1XHzlHtQ32n8SJ0C8Y=;
	b=NabDh8pOvdNxXuBIMOOndMNkXd6OLHtSrrml9tLn65zyYK2lSe/V6jvfy9WlLSCxeaM0pb
	zHb6No4gOcI8Luh9praW8a8P6KFXCm/aWJ7DXXyNEliYi3aJP4CN4oWiOIn/r9f2eef1Aj
	WCq4dsKvy924oF2ZvLo1x+HP0j3KP4I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-7N3oRGmZN0SgszIwy4QIHw-1; Fri, 01 Mar 2024 12:19:03 -0500
X-MC-Unique: 7N3oRGmZN0SgszIwy4QIHw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51333e20813so475504e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313541; x=1709918341;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iOy7UdgTKcwbx5hTPJnUBr/z1XHzlHtQ32n8SJ0C8Y=;
        b=YSAcA3lKfEGD5cbeYtZcJlPXaNieNW2Nd6pKYh8LmZDR2Wwniv0mMPi1e515arRWAD
         zVkmzDqhFDY4KrwQxrgG/2k8hdWObirUn91ucFuxI1lZz1Caof+CLe6L/85S5RdBQlcy
         DXqZOujezXSSXw4vQg+BALxirHisxywqxxKUfjJry5+tnD4rTSU8C7vF0/zUqbLkyJBW
         9Yzc5LSRpm1CFJbl/ZEZpn5xRfuUQNtHYmQ+KyJcHxl7jsuoIY5P84R3ksvZcJGUskva
         dwNt63aoIEXjXkvo1y3a3A96Tqes8JkCiyzPtcNMf/3POxUyCyFRP84+R98eXDhNVZEt
         kPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnm8cVCfjs+Lk703OmxLQaiXjcUhOd6l7x6BUivyhA6AQE0cmhFOoFrb/QfRSHUo9+tXcIdijXp6WcYanj5ATvL0udyuGf2XiVgqdB
X-Gm-Message-State: AOJu0YzdOt3kJWQwsLRMgepWBGEPGs16DBA+bmOVDTlY3u8m7pNY1y63
	5h7zz+UoyJ10RKgcae08nH/CzZT+XdVFCaHIse0Y0cpCe1SYNdCck2Lo5PpYnf5QJC85g9QXJoG
	xnV2M7W8pY4rYNBwLdKOVqEnbQ0SIw+urFR4dI51raOa2dwBxaEzN0Ize4HVfLg==
X-Received: by 2002:a05:6512:24a:b0:513:42e:ddf0 with SMTP id b10-20020a056512024a00b00513042eddf0mr1799711lfo.36.1709313541571;
        Fri, 01 Mar 2024 09:19:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYW/wx45+LyeDTZJLf19hqNz0JUJcDB4fXD6zRDovG9ujfQZfUB7lVl+O0DpJA3+Oy3TVjhg==
X-Received: by 2002:a05:6512:24a:b0:513:42e:ddf0 with SMTP id b10-20020a056512024a00b00513042eddf0mr1799686lfo.36.1709313541095;
        Fri, 01 Mar 2024 09:19:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c713:3200:77d:8652:169f:b5f7? (p200300cbc7133200077d8652169fb5f7.dip0.t-ipconnect.de. [2003:cb:c713:3200:77d:8652:169f:b5f7])
        by smtp.gmail.com with ESMTPSA id cl5-20020a5d5f05000000b0033d1b760125sm5351759wrb.92.2024.03.01.09.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 09:19:00 -0800 (PST)
Message-ID: <861321e8-6b96-4cbf-a61b-d9cbc2dc093e@redhat.com>
Date: Fri, 1 Mar 2024 18:18:59 +0100
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
To: Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
 <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
 <4a73b16e-9317-477a-ac23-8033004b0637@arm.com>
 <1195531c-d985-47e2-b7a2-8895fbb49129@redhat.com>
 <5ebac77a-5c61-481f-8ac1-03bc4f4e2b1d@arm.com>
 <ZeIC0Bn7N0JlP4TY@casper.infradead.org>
 <e56fbf5e-8051-4285-875b-1de529dc6809@arm.com>
 <c12fbea5-0d5d-4c06-b063-dab3dd00e704@redhat.com>
 <7774edad-a194-4259-a95f-88bcef846f90@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7774edad-a194-4259-a95f-88bcef846f90@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.03.24 18:14, Ryan Roberts wrote:
> On 01/03/2024 17:00, David Hildenbrand wrote:
>> On 01.03.24 17:44, Ryan Roberts wrote:
>>> On 01/03/2024 16:31, Matthew Wilcox wrote:
>>>> On Fri, Mar 01, 2024 at 04:27:32PM +0000, Ryan Roberts wrote:
>>>>> I've implemented the batching as David suggested, and I'm pretty confident it's
>>>>> correct. The only problem is that during testing I can't provoke the code to
>>>>> take the path. I've been pouring through the code but struggling to figure out
>>>>> under what situation you would expect the swap entry passed to
>>>>> free_swap_and_cache() to still have a cached folio? Does anyone have any idea?
>>>>>
>>>>> This is the original (unbatched) function, after my change, which caused
>>>>> David's
>>>>> concern that we would end up calling __try_to_reclaim_swap() far too much:
>>>>>
>>>>> int free_swap_and_cache(swp_entry_t entry)
>>>>> {
>>>>>      struct swap_info_struct *p;
>>>>>      unsigned char count;
>>>>>
>>>>>      if (non_swap_entry(entry))
>>>>>          return 1;
>>>>>
>>>>>      p = _swap_info_get(entry);
>>>>>      if (p) {
>>>>>          count = __swap_entry_free(p, entry);
>>>>>          if (count == SWAP_HAS_CACHE)
>>>>>              __try_to_reclaim_swap(p, swp_offset(entry),
>>>>>                            TTRS_UNMAPPED | TTRS_FULL);
>>>>>      }
>>>>>      return p != NULL;
>>>>> }
>>>>>
>>>>> The trouble is, whenever its called, count is always 0, so
>>>>> __try_to_reclaim_swap() never gets called.
>>>>>
>>>>> My test case is allocating 1G anon memory, then doing madvise(MADV_PAGEOUT)
>>>>> over
>>>>> it. Then doing either a munmap() or madvise(MADV_FREE), both of which cause
>>>>> this
>>>>> function to be called for every PTE, but count is always 0 after
>>>>> __swap_entry_free() so __try_to_reclaim_swap() is never called. I've tried for
>>>>> order-0 as well as PTE- and PMD-mapped 2M THP.
>>>>
>>>> I think you have to page it back in again, then it will have an entry in
>>>> the swap cache.  Maybe.  I know little about anon memory ;-)
>>>
>>> Ahh, I was under the impression that the original folio is put into the swap
>>> cache at swap out, then (I guess) its removed once the IO is complete? I'm sure
>>> I'm miles out... what exactly is the lifecycle of a folio going through swap out?
>>
>> I thought with most (disk) backends you will add it to the swapcache and leave
>> it there until there is actual memory pressure. Only then, under memory
>> pressure, you'd actually reclaim the folio.
> 
> OK, my problem is that I'm using a VM, whose disk shows up as rotating media, so
> the swap subsystem refuses to swap out THPs to that and they get split. To solve
> that, (and to speed up testing) I moved to the block ram disk, which convinces
> swap to swap-out THPs. But that causes the folios to be removed from the swap
> cache (I assumed because its syncrhonous, but maybe there is a flag somewhere to
> affect that behavior?) And I can't convince QEMU to emulate an SSD to the guest
> under macos. Perhaps the easiest thing is to hack it to ignore the rotating
> media flag.

I'm trying to remember how I triggered it in the past, I thought cow.c 
selftest was able to do that.

What certainly works is taking a reference on the page using vmsplice() 
and then doing the MADV_PAGEOUT. But there has to be a better way :)

I'll dig on Monday!

-- 
Cheers,

David / dhildenb


