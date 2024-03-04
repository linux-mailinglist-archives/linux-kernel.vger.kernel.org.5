Return-Path: <linux-kernel+bounces-91280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381C870C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 866D3B2140A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93FB1C68E;
	Mon,  4 Mar 2024 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0x7y80K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD18F58
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586910; cv=none; b=r0hofFtMBOIsTPFKClEiTtZ3umJTc+hRy/FMXWeUlheeh7x71J3eNJiuTIMFTaIf8SSiyyhX+bvp0bXEb4kXnQ2WyhzlNChc3drMWut6cPSl4lvrwN51GASYr9rsPTuYILDLa7hUrDUVeq1fvlcRLI+H3cTgFg8pYKXXLFK75VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586910; c=relaxed/simple;
	bh=e9hu28gGClrg6op2e0f6amThqB7qzzjNw5TYeSla2qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZSeLh1fiopAGMmzTZLsE0HNi9ntYNWkPkrQ8oEasfE254eS8GEV+l9D+2NqpzAC303relbhaJdsmsxjWxv5oXHkZD7SADT/IEe88QKC9Way4oYraMShDGe60vBezGPZ5/uhd4FFcmW6z2s70n52CRetPzA2nP/nUJ9zSLKqcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0x7y80K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709586907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CPY6F3oqGaK/IRoPeDONLBp2gMCiMOL0sWkPhVH57Ow=;
	b=K0x7y80KCzlUl1GH+ndmAMpSlORH4QG6dMJo6QJwLa1V2315xhtxWARSO2WfKH+BJOAQ+D
	OG/waD/wCZUMYDWvKidLzKbLzPEgfIFP1yjI8M1Sgw8WBExJhbBx9AFUMMQaShjlGGYcTr
	7kwOlubM/eKq+QNTKAEoooVZOXxTbmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-KBWz4tCqOne8LOaiF5O9Nw-1; Mon, 04 Mar 2024 16:15:05 -0500
X-MC-Unique: KBWz4tCqOne8LOaiF5O9Nw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412ae5704f7so32617485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709586904; x=1710191704;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPY6F3oqGaK/IRoPeDONLBp2gMCiMOL0sWkPhVH57Ow=;
        b=A2zT9Eix623kkX8rp/87qXfeScdulWGTUCbAKcCOgkHtE6Op1DES9DsPiu31n/uRHR
         phJ3PsSF+w3ljGbR6NUVrjGXADQWQ6YY5ZETB3JpDSvnsvrClhqInuK47BUTbIovhPMs
         gmyTfKMQVKlc5nlGDzGrhvzVTX79o+m4ge8xD7/MaGG0RjAMeAq9VYw7NuBkmcO1Iycs
         jasc/cggibmoiaECA4TsxbbzlgZ69QzfV76lPRVo1cIXVQ9zaz7jrYZAnuhCX6VSDkO4
         OKFbg7foozL0oJ/BHN15uKEayQPfPBbjMwh+fcXrPR0ACh2T6uWkYcie/do+fZpTzxlg
         pqdg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Zg9WO5XgBznhTxQZ5TVm1uAmkB9H3OHBqUyVK8OpNTNPFzYrWl46at8rmftD77XJMxiAGjgdYPEtuFtdUKGrZlCKjR4/HJ0qDl75
X-Gm-Message-State: AOJu0Yy/m3MAz8Iw1uyrhzbgZVKCAuFl88v6Ky2NzS0bfs0ibdVz/9l9
	AOCGAUCPkp2CAhkLOMFLecG0qmWgvA+UQQ+MpyOHYRRuVvmXiI14ucfiRpm3YHO3QgA1z2J4GtE
	9XlJw5TQ4C7Mudo49B5o/VYvEqNIylmWBWX0Vz+CFLaCtLKTfa4U7qZx12eV6Ew==
X-Received: by 2002:a05:600c:1d16:b0:412:b2fe:6e46 with SMTP id l22-20020a05600c1d1600b00412b2fe6e46mr6377562wms.27.1709586904480;
        Mon, 04 Mar 2024 13:15:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0SyybCovDrz9QkNXwCtaukp2ykABn968sortElciC0+XZ3EJlkfnoYcr23KTntXqdz+RkYg==
X-Received: by 2002:a05:600c:1d16:b0:412:b2fe:6e46 with SMTP id l22-20020a05600c1d1600b00412b2fe6e46mr6377541wms.27.1709586904108;
        Mon, 04 Mar 2024 13:15:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c733:f100:75e7:a0a4:9ac2:1abb? (p200300cbc733f10075e7a0a49ac21abb.dip0.t-ipconnect.de. [2003:cb:c733:f100:75e7:a0a4:9ac2:1abb])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c4ecb00b00412e293bee9sm4890462wmq.38.2024.03.04.13.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 13:15:03 -0800 (PST)
Message-ID: <804524c8-772c-42d0-93a5-90d77f13f304@redhat.com>
Date: Mon, 4 Mar 2024 22:15:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, chrisl@kernel.org, yuzhao@google.com,
 hanchuanhua@oppo.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 ying.huang@intel.com, xiang@kernel.org, mhocko@suse.com,
 shy828301@gmail.com, wangkefeng.wang@huawei.com,
 Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>
References: <20240304103757.235352-1-21cnbao@gmail.com>
 <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
 <CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>> Do we need a Fixes tag?
> 
> I am not quite sure which commit should be here for a fixes tag.
> I think it's more of an optimization.

Good, that helps!

> 
>>>
>>
>> What would be the description of the problem we are fixing?
>>
>> 1) failing to unmap?
>>
>> That can happen with small folios as well IIUC.
>>
>> 2) Putting the large folio on the deferred split queue?
>>
>> That sounds more reasonable.
> 
> I don't feel it is reasonable. Avoiding this kind of accident splitting
> from the kernel's improper code is a more reasonable approach
> as there is always a price to pay for splitting and unfolding PTEs
> etc.
> 
> While we can't avoid splitting coming from userspace's
> MADV_DONTNEED, munmap, mprotect, we have a way
> to ensure the kernel itself doesn't accidently break up a
> large folio.

Note that on the next vmscan we would retry, find the remaining present 
entries and swapout that thing completely :)

> 
> In OPPO's phones, we ran into some weird bugs due to skipped PTEs
> in try_to_unmap_one. hardly could we fix it from the root cause. with
> various races, figuring out their timings was really a big pain :-)
> 

I can imagine. I assume, though, that it might be related to the way the 
cont-pte bit was handled. Ryan's implementation should be able to cope 
with that.

> But we did "resolve" those bugs by entirely untouching all PTEs if we
> found some PTEs were skipped in try_to_unmap_one [1].
> 
> While we find we only get the PTL from 2nd, 3rd but not
> 1st PTE, we entirely give up on try_to_unmap_one, and leave
> all PTEs untouched.
> 
> /* we are not starting from head */
> if (!IS_ALIGNED((unsigned long)pvmw.pte, CONT_PTES * sizeof(*pvmw.pte))) {
>                     ret = false;
>                     atomic64_inc(&perf_stat.mapped_walk_start_from_non_head);
>                     set_pte_at(mm, address, pvmw.pte, pteval);
>                     page_vma_mapped_walk_done(&pvmw);
>                     break;
> }
> This will ensure all PTEs still have a unified state such as CONT-PTE
> after try_to_unmap fails.
> I feel this could have some false postive because when racing
> with unmap, 1st PTE might really become pte_none. So explicitly
> holding PTL from 1st PTE seems a better way.

Can we estimate the "cost" of holding the PTL?

-- 
Cheers,

David / dhildenb


