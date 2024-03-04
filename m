Return-Path: <linux-kernel+bounces-91267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB577870C09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A561F21D57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14510A35;
	Mon,  4 Mar 2024 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcboNZol"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5810A19
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586180; cv=none; b=V3+/uAxSLudUn4nTalYqLNxe/JoZHfkTDHBK3keI3aBuBFniq0CKWDu452V/V0Toanqs/hZ4gunxjU7NgaAtsJsn/bhDfCCh2DIVBlumOeQazSOHP0CY1OdACTmXuakiR+7GkBFBd4MDA3LR6DJq+1GLvEdJdlMXz+tuMCcqjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586180; c=relaxed/simple;
	bh=CItsUH8Iz8Zkqjz2l2xieBX+JKyAS448urbfViqgtbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRcMyAZkg/qmuu79G2m0J3NEt8lW4IBBd0o8EmliuSbCbJiEJg6Zzl3maapJoLEuFgzX4jiR+mu/zFiy31RQpJK4ZlS1gn1NNIKIMU7bcOjFM4E9hBn1Drw8Jssi4x5sOhc/CxmdBzzxJdPHGkeYd4d3PC5Pstm3KDbSIjZ0gpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcboNZol; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709586178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cese54POTivQZ+W5GHwwAwK3ptv9CAQYY/x9CSNE4fs=;
	b=WcboNZolgEHxAdRvI2VDixEJ4cyfQvYJLSnZBZ1NCPNllN+FY5ia3Ma1vZWqn9vHK6d8Qs
	p+VfbXSeSKa1THQ8PYV1EtYy2uoR+G1GwFH52vPZSMISrv0cnsCsae1PsWcvnQdVVyh7Vq
	PZZLevNdy5m1GXJJ4/sIxgmyLg1L2DM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-5nrLTC2SPWaZDQdTmWKXwA-1; Mon, 04 Mar 2024 16:02:56 -0500
X-MC-Unique: 5nrLTC2SPWaZDQdTmWKXwA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d19951a9bso1860197f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709586175; x=1710190975;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cese54POTivQZ+W5GHwwAwK3ptv9CAQYY/x9CSNE4fs=;
        b=DwHHwnrqMDER8dvxTEKhBzjJNugzX8uNKS0HkmOcu+WAwrOqTjhbm4gL0tPWgeYkaI
         FCEoHwS8LSNNvKD4PhImX++GDBM9cUQ77FTnPK0SDdZHJicvNnSMjA6pJv/KkOR2MN8x
         9eRPieFlDkZFYwVLnOyjiuQ5l3YRdFd+oOftv42NLpWGfsOA4WVyXkNPoiuQQHico272
         X3O4cg4giqbvMFTecuytQpNaJBiB9JxdSSC9YWifS2royWjvmt2hkWLZgUBex+M/ImsZ
         /Ag8x9AouUuVcEii08a8xriFiQ2VLSh0R7Mg1ZbsB8nLTnmRLN72htASWVmiAet9OGZw
         IUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFtL+Rtr4Ln2ccEUQFGDMB1/a+6Av5j3GrNM0UgKcoUS6zDuZdrukJcqi2HrazNa+FZeKF/Q9ZLx6tLv1cn/OTU4bBpt/Uyv3nCQFm
X-Gm-Message-State: AOJu0YymgejDNaBykBvVndHHynkebo0yzGbI5yAUxTNelpzle6kvFqU6
	25SkmvgAX/am8UWDDrk8nDe09OE9zwmsF9TFASsgERcM9hEvKyT1c/Fbxv9XjKktNKN9/EEs2yD
	dUk5NEvuMw4nugGXAIyh+53/UJqHGtFhxyqAm+CGJ1ShHlWE6SB4nY1qIK+ABfQ==
X-Received: by 2002:a05:6000:400c:b0:33e:3055:366c with SMTP id cp12-20020a056000400c00b0033e3055366cmr4738382wrb.51.1709586175535;
        Mon, 04 Mar 2024 13:02:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9Ow4Gg01zZ5Z5RUfqHK6uq+IV49G+BPhDqRY1aOg7hJUg2sVqmBmk1nes7yhjSkc5kR+D6A==
X-Received: by 2002:a05:6000:400c:b0:33e:3055:366c with SMTP id cp12-20020a056000400c00b0033e3055366cmr4738358wrb.51.1709586175086;
        Mon, 04 Mar 2024 13:02:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c733:f100:75e7:a0a4:9ac2:1abb? (p200300cbc733f10075e7a0a49ac21abb.dip0.t-ipconnect.de. [2003:cb:c733:f100:75e7:a0a4:9ac2:1abb])
        by smtp.gmail.com with ESMTPSA id q9-20020adf9dc9000000b0033e192a5852sm10972816wre.30.2024.03.04.13.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 13:02:54 -0800 (PST)
Message-ID: <882fcbdd-5392-4dbf-99e4-b35defd9e3dc@redhat.com>
Date: Mon, 4 Mar 2024 22:02:53 +0100
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
 <10f9542e-f3d8-42b0-9de4-9867cab997b9@arm.com>
 <17b4527c-3782-4eab-8b33-e0c6ff57139f@redhat.com>
 <CAGsJ_4wgMtY2=xRFSx8xAgROR97MevAtCYRUG+Xy+n6FUw9a1w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wgMtY2=xRFSx8xAgROR97MevAtCYRUG+Xy+n6FUw9a1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.03.24 21:42, Barry Song wrote:
> On Tue, Mar 5, 2024 at 3:27 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.03.24 14:03, Ryan Roberts wrote:
>>> On 04/03/2024 12:41, David Hildenbrand wrote:
>>>> On 04.03.24 13:20, Ryan Roberts wrote:
>>>>> Hi Barry,
>>>>>
>>>>> On 04/03/2024 10:37, Barry Song wrote:
>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>
>>>>>> page_vma_mapped_walk() within try_to_unmap_one() races with other
>>>>>> PTEs modification such as break-before-make, while iterating PTEs
>>>>>> of a large folio, it will only begin to acquire PTL after it gets
>>>>>> a valid(present) PTE. break-before-make intermediately sets PTEs
>>>>>> to pte_none. Thus, a large folio's PTEs might be partially skipped
>>>>>> in try_to_unmap_one().
>>>>>
>>>>> I just want to check my understanding here - I think the problem occurs for
>>>>> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large folios? Now
>>>>> that I've had a look at the code and have a better understanding, I think that
>>>>> must be the case? And therefore this problem exists independently of my work to
>>>>> support swap-out of mTHP? (From your previous report I was under the impression
>>>>> that it only affected mTHP).
>>>>>
>>>>> Its just that the problem is becoming more pronounced because with mTHP,
>>>>> PTE-mapped large folios are much more common?
>>>>
>>>> That is my understanding.
>>>>
>>>>>
>>>>>> For example, for an anon folio, after try_to_unmap_one(), we may
>>>>>> have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
>>>>>> So folio will be still mapped, the folio fails to be reclaimed.
>>>>>> What’s even more worrying is, its PTEs are no longer in a unified
>>>>>> state. This might lead to accident folio_split() afterwards. And
>>>>>> since a part of PTEs are now swap entries, accessing them will
>>>>>> incur page fault - do_swap_page.
>>>>>> It creates both anxiety and more expense. While we can't avoid
>>>>>> userspace's unmap to break up unified PTEs such as CONT-PTE for
>>>>>> a large folio, we can indeed keep away from kernel's breaking up
>>>>>> them due to its code design.
>>>>>> This patch is holding PTL from PTE0, thus, the folio will either
>>>>>> be entirely reclaimed or entirely kept. On the other hand, this
>>>>>> approach doesn't increase PTL contention. Even w/o the patch,
>>>>>> page_vma_mapped_walk() will always get PTL after it sometimes
>>>>>> skips one or two PTEs because intermediate break-before-makes
>>>>>> are short, according to test. Of course, even w/o this patch,
>>>>>> the vast majority of try_to_unmap_one still can get PTL from
>>>>>> PTE0. This patch makes the number 100%.
>>>>>> The other option is that we can give up in try_to_unmap_one
>>>>>> once we find PTE0 is not the first entry we get PTL, we call
>>>>>> page_vma_mapped_walk_done() to end the iteration at this case.
>>>>>> This will keep the unified PTEs while the folio isn't reclaimed.
>>>>>> The result is quite similar with small folios with one PTE -
>>>>>> either entirely reclaimed or entirely kept.
>>>>>> Reclaiming large folios by holding PTL from PTE0 seems a better
>>>>>> option comparing to giving up after detecting PTL begins from
>>>>>> non-PTE0.
>>>>>>
>>>>
>>>> I'm sure that wall of text can be formatted in a better way :) . Also, I think
>>>> we can drop some of the details,
>>>>
>>>> If you need some inspiration, I can give it a shot.
>>>>
>>>>>> Cc: Hugh Dickins <hughd@google.com>
>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> Do we need a Fixes tag?
>>>>>
>>>>
>>>> What would be the description of the problem we are fixing?
>>>>
>>>> 1) failing to unmap?
>>>>
>>>> That can happen with small folios as well IIUC.
>>>>
>>>> 2) Putting the large folio on the deferred split queue?
>>>>
>>>> That sounds more reasonable.
>>>
>>> Isn't the real problem today that we can end up writng a THP to the swap file
>>> (so 2M more IO and space used) but we can't remove it from memory, so no actual
>>> reclaim happens? Although I guess your (2) is really just another way of saying
>>> that.
>>
>> The same could happen with small folios I believe? We might end up
>> running into the
>>
>> folio_mapped()
>>
>> after the try_to_unmap().
>>
>> Note that the actual I/O does not happen during add_to_swap(), but
>> during the pageout() call when we find the folio to be dirty.
>>
>> So there would not actually be more I/O. Only swap space would be
>> reserved, that would be used later when not running into the race.
> 
> I am not worried about small folios at all as they have only one PTE.
> so the PTE is either completely unmapped or completely mapped.
> 
> In terms of large folios, it is a different story. for example, a large
> folio with 16 PTEs with CONT-PTE, we will have
> 
> 1. unfolded CONT-PTE, eg. PTE0 present, PTE1-PTE15 swap entries
> 
> 2. page faults on PTE1-PTE15 after try_to_unmap if we access them.
> 
> This is totally useless PF and can be avoided if we can try_to_unmap
> properly at the beginning.
> 
> 3. potential need to split a large folio afterwards. for example, MADV_PAGEOUT,
> MADV_FREE might split it after finding it is not completely mapped.
> 
> For small folios, we don't have any concern on the above issues.

Right, but when we talk about "Fixes:", what exactly are we consider 
"really broken" above and what is "undesired"?

(a) is there a correctness issue? I don't think so.

(b) is there a real performance issue? I'd like to understand.

After all, we've been living with that ever since we supported THP_SWAP, 
correct? "something does not work ideally in some corner cases" might be 
reasonable to handle here (and I really think we should), but might not 
be worth a "Fixes:".

So if we could clarify that, it would be great.

-- 
Cheers,

David / dhildenb


