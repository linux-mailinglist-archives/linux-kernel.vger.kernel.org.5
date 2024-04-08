Return-Path: <linux-kernel+bounces-135222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208DC89BCF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC0B1F2274C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B85339B;
	Mon,  8 Apr 2024 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhoBol3f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84652F82
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571858; cv=none; b=fTCielp2KpZBYhX2nCn5n9tPjYWjfzGK75TaHQM/0R+9LdSBbIjBG+DjB6ukR6DIexKx/Hs9lVV3bfNgzIAW3uO56S4obMWn1b9krPrvRYbM6GtekzYp3bOjMjjldmKvPQrGg78mK4IZZbhZbuXrRDFr5k4FRAN63Ht6rs6PJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571858; c=relaxed/simple;
	bh=A8Q0+XzACjuiXUOGHDawC3LlH7W1Nb490tromVVDGN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Auj8hPUsKcq+YmS0WjYDNt8LlAXyKm7CPXC3/AYF4VBxW1cQVZApu6+hs952aUH+8jshz4khJwjOiGI9GfR6AhSXR8FOCVhwJVvKrIbJmjKUar0eH7yT7m6fDp+XM6O9pmxxWWu2IjHuChXhvBaiIrmG7qNmN0ybKDZycSm3+ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhoBol3f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712571855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J4hclr+x6PNHXV/FMdK1oarJGrEoXdXw4qLmIVzU6S8=;
	b=RhoBol3fbjMZSLTGDUL6pBK7JKwbYo9ixMGFBD9dnHQbckG1tZU1ShEDG6CAjOq12iDyj+
	0lEh34vvrhGehTJFXFisrphwn5lfmD60Me4rvlkWyq9mNYaSGSQIGFzexynsmEvRm9r5Eb
	Am6nuGT6ZbrUav0cPzZA2muFmpYMNnA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-Ctxq03k5MUmHR-gv07e3SA-1; Mon, 08 Apr 2024 06:24:13 -0400
X-MC-Unique: Ctxq03k5MUmHR-gv07e3SA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3418412a734so3111948f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 03:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712571852; x=1713176652;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J4hclr+x6PNHXV/FMdK1oarJGrEoXdXw4qLmIVzU6S8=;
        b=eJCXJ43nY3/xZnZy2z1vzlXb91MJT2hxFVxbboCF92nhTMTBz0dNO2V7+eOGhpe6wh
         fI4dgsR4DCB4QIHebuJppbvGSeQmqgOx4jDgb6qV+eG5rkOBR5+lD7hoobdoO7tYfV4t
         lloGpyWWwg5AO3QTn9zx+4db5F7v41oI/wmI3v/bfRYfLAG4JLGe7zslwIOk8JCoNmFJ
         GFENGsE4FlEfioHK6gtO2A4RtUlzrZ5rnDI3bJDNk6+zZtKsYh1KB5ofKhwm3UOyjcOC
         VXeH6JXidYX501+1e/8pi15hbdkyCFrz/dLAQEmC+7jdmro3HXtgsviEMRnQuEBScDGd
         a3HA==
X-Forwarded-Encrypted: i=1; AJvYcCWHICFRb0qAgBPQnxRbQy2IGprz4iLLgt7YP6BqL3YgkUMQE6DwifI8eZjpwTq3T1a8isPvrupxa6JDgD9DJmK0IBclRAau+7lTFXe/
X-Gm-Message-State: AOJu0YzQQ/CAyxAPXsCeEh/1l+JInfQe61HvriAooo1DQFoXvWh7OiEe
	u0sLEdp1Zd5Vr8zXK49shb4S5MYSrtdkDJ+SCuYi498VAvWptyjhpwX2GGtwAPp0RT0cL7FwlBw
	gVdHCOWZ9sEgG8rppLL7xSZC7jpggS5lt2VP7BjpnzuqSaTit1V71mk46FlJnOQ==
X-Received: by 2002:adf:fac7:0:b0:343:a521:6585 with SMTP id a7-20020adffac7000000b00343a5216585mr5435419wrs.53.1712571852070;
        Mon, 08 Apr 2024 03:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyHV3e2NrErVuds9mx20F1ADlt+AQvlVCZbZXF5L4mAhpQPk7ilmRucpeMHZt4d3lEQNELdg==
X-Received: by 2002:adf:fac7:0:b0:343:a521:6585 with SMTP id a7-20020adffac7000000b00343a5216585mr5435402wrs.53.1712571851652;
        Mon, 08 Apr 2024 03:24:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id e16-20020adff350000000b00343ca138924sm8591031wrp.39.2024.04.08.03.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 03:24:11 -0700 (PDT)
Message-ID: <79c5513b-b3f2-4fbb-a3c7-a09894d54d22@redhat.com>
Date: Mon, 8 Apr 2024 12:24:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-3-ryan.roberts@arm.com>
 <051052af-3b56-4290-98d3-fd5a1eb11ce1@redhat.com>
 <73adae65-4429-41d7-bbb6-4c58156060d3@arm.com>
 <7d3d3c58-1bb1-4d70-9ae3-fa96f6d624d8@redhat.com>
 <e8dfe18d-d3fe-47a8-88b6-d0145895d7af@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e8dfe18d-d3fe-47a8-88b6-d0145895d7af@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.04.24 12:07, Ryan Roberts wrote:
> On 08/04/2024 10:43, David Hildenbrand wrote:
>>
>>>>> +
>>>>> +/**
>>>>> + * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
>>>>> + * @start_ptep: Page table pointer for the first entry.
>>>>> + * @max_nr: The maximum number of table entries to consider.
>>>>> + * @entry: Swap entry recovered from the first table entry.
>>>>> + *
>>>>> + * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
>>>>> + * containing swap entries all with consecutive offsets and targeting the same
>>>>> + * swap type.
>>>>> + *
>>>>
>>>> Likely you should document that any swp pte bits are ignored? ()
>>>
>>> Sorry I don't understand this comment. I thought any non-none, non-present PTE
>>> was always considered to contain only a "swap entry" and a swap entry consists
>>> of a "type" and an "offset" only. (and its a special "non-swap" swap entry if
>>> type > SOME_CONSTANT) Are you saying there are additional fields in the PTE that
>>> are not part of the swap entry?
>>
>>
>> pte_swp_soft_dirty()
>> pte_swp_clear_exclusive()
>> pte_swp_uffd_wp()
>>
>> Are PTE bits used for swp PTE.
> 
> Ahh wow. mind blown. Looks like a massive hack... why not store them in the
> arch-independent swap entry, rather than have them squat independently in the PTE?

I think that was discussed at some point, but it not only requires quite 
some churn to change it (all that swp entry code is a mess), these bits 
are conceptually really per PTE and not something you would want to pass 
into actual swap handling code that couldn't care less about all of these.

I looked at this when I added SWP exclusive, but accidentally losing the 
SWP exclusive marker when converting back and forth made me go the PTE 
route instead.

Then, the available PTE bits are a bit scattered on some architectures, 
and converting entry<->PTE gets even uglier if we don't want to "lose" 
available bits.

Probably the whole "unsigned long swp_entry" stuff should be replaced by 
a proper struct where we could more easily add flags and have the arch 
code handle the conversion to the PTE just once. The arch-specific 
swp_entry stuff is another nasty thing IMHO.

> 
> OK, my implementation is buggy. I'll re-spin to fix this.
> 
> 
>>
>> There is also dirty/young for migration entries, but that's not of a concern
>> here, because we stop for non_swap_entry().
> 
> Looks like these are part of the offset field in the arch-independent swap entry
> - much cleaner ;-).

Note that it only applies to migration entries, and only when we have 
some spare bits due to PFN < offset.

-- 
Cheers,

David / dhildenb


