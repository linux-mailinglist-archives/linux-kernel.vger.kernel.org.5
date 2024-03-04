Return-Path: <linux-kernel+bounces-90731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDA387041D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17261F21265
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19840C04;
	Mon,  4 Mar 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGH7G2lT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA14087C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562477; cv=none; b=Gk7uXs7fH/9Z3S9ZgCpRkrn+3QkwRBGKhyvseVh7GBky8sVt9nHH7vdaIEjh2lYzn6qycP1H6U9cz8iobEJzIqT9yBmRIEC82JyE0hqwXeKK25tzwTPv/8AHBCU89hezMxA0IUc4EXa2Iv1v9a37tJmbkKNeSahkbq9oJU95I5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562477; c=relaxed/simple;
	bh=i5xflYvLm9ZmjHe2F3VsR2M1NBql8/cesu+cSv3RAmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRNdneISJiO64XrQ0AtWkAXcDkh2lF8oybG4AuV0daPHY8y3kHulxUqxb+dSwcsAYRu8vsIkwCdxICAaoJgWEswk97dCNu/41L9a4p21OLPdPqUXGjdG+OjHPivCAcJAGj27Yl0NPRByiU+nd/Uu+/enjRvNZX/tK9LzRHA1YWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGH7G2lT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709562474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4iaPdRRBKH6i1gb2pr9yhl7DaDu+qacE7YcEU9c1uj4=;
	b=FGH7G2lTahEwgB9Ux+28ROI8Qevxm0ZNdMlB6h03PN7aQCV8jv+zHO/NNE7P2JFgWrFkTW
	3C+PsQ8Hbx0lMEIdg79M6Bk1HLlYxA18lhoSG0uDCh8hNnPHyvNpLGAB4iM+l/aEZ7CxZx
	0iN86J2EmVwMi8if3xj9OJj4fR3CJ44=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-vcKIQ9jlOZOVwpiNA4ypfg-1; Mon, 04 Mar 2024 09:27:53 -0500
X-MC-Unique: vcKIQ9jlOZOVwpiNA4ypfg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412b2321084so22571385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 06:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709562472; x=1710167272;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iaPdRRBKH6i1gb2pr9yhl7DaDu+qacE7YcEU9c1uj4=;
        b=dz6gYoX2n5nu7eCZImHzNOskVwuzjOvuDSvwHBIxVUVQdQzejIUMccPlfKCC25Lcd6
         WR5AGs3mzqhFFqoW9Pj52So3fdIuQmhFp9/m4vzy93NGqWzrydCSXwXb9tj31gsmieHK
         WSLCMd3qM6ZBYx7sk8LaciHW2Eo0I1cuEY6qqnyvd2LjpO/UGmelPeRSEcj+2zfbPjsk
         9pOhkbSRHT/W+H5ARdf9ckiRCW+0nNDtpSrM/Xt2ZuCTznVuREkHsyvPNDV08N5VEilp
         h3OA88F8gBVeMiDz1jX5lDZ+Qqd8MHMxZkklk7tLT0LXNTkDJdZrJvzw4LbuBUqlucbL
         fKSw==
X-Forwarded-Encrypted: i=1; AJvYcCXFnKtOI3jDTM1TdPd9ZNWCUFENJcX+K8UWySOMh3MSOnA1l62gqb26b/bfJwcQAc2Bdu5uzxVG0DF7hPvdzh0CjaDR5sH4Ly+fASxF
X-Gm-Message-State: AOJu0Ywz+ZGuIbtPolt3SJki6Kvf/76MimIJY1eDJOLUDU2Y/S09cxYI
	mU/hnLjuv1zDjL30/6BeMAFfiutrzo564cHWPZHUwMZRGzalhr4oZ5YGQ9JafAlnvlBwIBtawui
	LdI+vMQjJpghM0T2w4fOg3wzotYqfQm1bbRbWPIV+0lKcXhKaUEZp5kmZsxe8Dw==
X-Received: by 2002:a05:600c:45d1:b0:412:97d5:6a60 with SMTP id s17-20020a05600c45d100b0041297d56a60mr7893727wmo.26.1709562471743;
        Mon, 04 Mar 2024 06:27:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0mtTgEmNKWrmRQwi9tq10Bjf9MXBqqw3U5VTGrqUl5iz56nIt5hMI5+NT+CdRdKv64gaLiw==
X-Received: by 2002:a05:600c:45d1:b0:412:97d5:6a60 with SMTP id s17-20020a05600c45d100b0041297d56a60mr7893704wmo.26.1709562471267;
        Mon, 04 Mar 2024 06:27:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c733:f100:75e7:a0a4:9ac2:1abb? (p200300cbc733f10075e7a0a49ac21abb.dip0.t-ipconnect.de. [2003:cb:c733:f100:75e7:a0a4:9ac2:1abb])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600c4e0a00b00412e445a6e4sm2807340wmq.25.2024.03.04.06.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 06:27:50 -0800 (PST)
Message-ID: <17b4527c-3782-4eab-8b33-e0c6ff57139f@redhat.com>
Date: Mon, 4 Mar 2024 15:27:49 +0100
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
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, ying.huang@intel.com,
 xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>,
 Hugh Dickins <hughd@google.com>
References: <20240304103757.235352-1-21cnbao@gmail.com>
 <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
 <10f9542e-f3d8-42b0-9de4-9867cab997b9@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <10f9542e-f3d8-42b0-9de4-9867cab997b9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.03.24 14:03, Ryan Roberts wrote:
> On 04/03/2024 12:41, David Hildenbrand wrote:
>> On 04.03.24 13:20, Ryan Roberts wrote:
>>> Hi Barry,
>>>
>>> On 04/03/2024 10:37, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> page_vma_mapped_walk() within try_to_unmap_one() races with other
>>>> PTEs modification such as break-before-make, while iterating PTEs
>>>> of a large folio, it will only begin to acquire PTL after it gets
>>>> a valid(present) PTE. break-before-make intermediately sets PTEs
>>>> to pte_none. Thus, a large folio's PTEs might be partially skipped
>>>> in try_to_unmap_one().
>>>
>>> I just want to check my understanding here - I think the problem occurs for
>>> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large folios? Now
>>> that I've had a look at the code and have a better understanding, I think that
>>> must be the case? And therefore this problem exists independently of my work to
>>> support swap-out of mTHP? (From your previous report I was under the impression
>>> that it only affected mTHP).
>>>
>>> Its just that the problem is becoming more pronounced because with mTHP,
>>> PTE-mapped large folios are much more common?
>>
>> That is my understanding.
>>
>>>
>>>> For example, for an anon folio, after try_to_unmap_one(), we may
>>>> have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
>>>> So folio will be still mapped, the folio fails to be reclaimed.
>>>> What’s even more worrying is, its PTEs are no longer in a unified
>>>> state. This might lead to accident folio_split() afterwards. And
>>>> since a part of PTEs are now swap entries, accessing them will
>>>> incur page fault - do_swap_page.
>>>> It creates both anxiety and more expense. While we can't avoid
>>>> userspace's unmap to break up unified PTEs such as CONT-PTE for
>>>> a large folio, we can indeed keep away from kernel's breaking up
>>>> them due to its code design.
>>>> This patch is holding PTL from PTE0, thus, the folio will either
>>>> be entirely reclaimed or entirely kept. On the other hand, this
>>>> approach doesn't increase PTL contention. Even w/o the patch,
>>>> page_vma_mapped_walk() will always get PTL after it sometimes
>>>> skips one or two PTEs because intermediate break-before-makes
>>>> are short, according to test. Of course, even w/o this patch,
>>>> the vast majority of try_to_unmap_one still can get PTL from
>>>> PTE0. This patch makes the number 100%.
>>>> The other option is that we can give up in try_to_unmap_one
>>>> once we find PTE0 is not the first entry we get PTL, we call
>>>> page_vma_mapped_walk_done() to end the iteration at this case.
>>>> This will keep the unified PTEs while the folio isn't reclaimed.
>>>> The result is quite similar with small folios with one PTE -
>>>> either entirely reclaimed or entirely kept.
>>>> Reclaiming large folios by holding PTL from PTE0 seems a better
>>>> option comparing to giving up after detecting PTL begins from
>>>> non-PTE0.
>>>>
>>
>> I'm sure that wall of text can be formatted in a better way :) . Also, I think
>> we can drop some of the details,
>>
>> If you need some inspiration, I can give it a shot.
>>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Do we need a Fixes tag?
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
> Isn't the real problem today that we can end up writng a THP to the swap file
> (so 2M more IO and space used) but we can't remove it from memory, so no actual
> reclaim happens? Although I guess your (2) is really just another way of saying
> that.

The same could happen with small folios I believe? We might end up 
running into the

folio_mapped()

after the try_to_unmap().

Note that the actual I/O does not happen during add_to_swap(), but 
during the pageout() call when we find the folio to be dirty.

So there would not actually be more I/O. Only swap space would be 
reserved, that would be used later when not running into the race.

-- 
Cheers,

David / dhildenb


