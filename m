Return-Path: <linux-kernel+bounces-135018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4673E89B9FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0362281D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B852DF73;
	Mon,  8 Apr 2024 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ih43xdCn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031428DDE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564150; cv=none; b=b6O2THospqy+/ct4brCBzCpPyU+/ARGIi5sh7wEy2hpdR7/Bg36ud1RNJ/eFDUyi1YfU1lRrSbCA18MEw8OQVQsYZYJrYLDbRDHivu7hXuTav2omiRHtui1ExTL/W6ALJ9w62cq+fcAY0hS/dAeDoODMkq7WCIbczqEpRlPs5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564150; c=relaxed/simple;
	bh=5c/xi/RDWJTsSn3coMwuNtnFj9aKly/dw5s3pdYL7Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li6tShyYeGWaxDWIaxquqpXZJGgdRZUHHL35yKB/NhHCxptgOxkaekv2nxGAfY7Q/i8gFMUUae/Lct2TmJ11cLF1K5s3lYAIXNBjJvVzQrbAEOXwSrNdQNZCJwM6VaE0lNMjVQOowQVWOKeEAbWxQDXOGBBm9D6z8mWs7TZiN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ih43xdCn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712564147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6r1tbKfHyOlCHMHOLN4//rRsziNLaiDaOQ/a7cTjTEk=;
	b=ih43xdCn+bWlecvNK9yqnNaZO7RswzqlIounFqU/bPANGUJS/PNjagqf4jjJGMn+SXMSee
	YJz8i31alG8Q5ac9nBE4b2GeXoDnseHJTrF9LDmueAtqDD2FONTf4/OQFCoNtgO0UffKDw
	0gnGdw+zZMVJGEBdKaJHnAiMY559CHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-x7aSAomyPkCdg7Yg_2m9Ow-1; Mon, 08 Apr 2024 04:15:46 -0400
X-MC-Unique: x7aSAomyPkCdg7Yg_2m9Ow-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41663c713b7so3890755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564145; x=1713168945;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r1tbKfHyOlCHMHOLN4//rRsziNLaiDaOQ/a7cTjTEk=;
        b=gge5YMjA95ykusqz/YRAuw87klect9iU6Z/kBx6+jOtYEAlJyyqn/DfU4MR9Kp4174
         fpAsmhOVdneViYIpWPC9DL+u9ni/BofvRSWvtHYQA34nXqQAJq5A2TrKBL91Vm480CRV
         NYK+ZZe3l0r37MkuoaFnq4Qq+Iy8Jsw+YOvXYHytxH+TC41z0VZmmMEIK4Zo6Tykyszg
         Sud5dSN9LSyQXfBLFy8lxQPvCawBS3uAVQFE9f/bRjuHgS99Od1VQwtSGVGMrG3PDILV
         /zjWWgh4bTyCrACbW06JFdLqd1hDqekE4XAKe6R1zKt5fS1fS3DlWrGW5STxEK7N3lU8
         w7hg==
X-Forwarded-Encrypted: i=1; AJvYcCXDcG+COXId1UEW5+/Mly+8hrCOM7o4KkrQQmNiXiqP+kTVFN3QdacgcIO5yl02tMTWyykZBIOCLPjCMwldZHKRpqPUYQbIBAKYZcf1
X-Gm-Message-State: AOJu0YzJIEQY1/JcMiIaXbJa8wU7C7nvsKJfuDz86DB/Ad55i7u9d/gH
	yoIQv7IYriFS2aAxMs8UZsdm26yyIizFF1+Dxy+ZnAU93sWVH+ZD6bLhsQgFa5iv+glkVsi38NA
	W9twRdxFwUByQRLF66K3G5J1Z3A7/ZCck3WjZUgTWMChM41S45bxm1wEcEZ7BsQ==
X-Received: by 2002:a05:600c:470d:b0:416:6adf:fe44 with SMTP id v13-20020a05600c470d00b004166adffe44mr2013269wmo.17.1712564145190;
        Mon, 08 Apr 2024 01:15:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGscbuDcN414Ijs18OJVVR6dWLGPchNaRnBebcg2NHYd+HPoPdmnfIaWHeYZklwWDzwn/6p2Q==
X-Received: by 2002:a05:600c:470d:b0:416:6adf:fe44 with SMTP id v13-20020a05600c470d00b004166adffe44mr2013243wmo.17.1712564144789;
        Mon, 08 Apr 2024 01:15:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d6a4e000000b0033b48190e5esm8333086wrw.67.2024.04.08.01.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 01:15:44 -0700 (PDT)
Message-ID: <13833f69-0f32-4590-9188-a7fb04e31c45@redhat.com>
Date: Mon, 8 Apr 2024 10:15:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to
 cma_declare_contiguous_nid
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
References: <20240404162515.527802-1-fvdl@google.com>
 <20240404162515.527802-2-fvdl@google.com>
 <e74cfee3-565f-4c69-bb7b-bdd40d01d212@redhat.com>
 <CAPTztWbpDizLVk14jfxtS8mzQo3KvR+3KHiAiksxCXo=SQ4HrQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAPTztWbpDizLVk14jfxtS8mzQo3KvR+3KHiAiksxCXo=SQ4HrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.04.24 23:44, Frank van der Linden wrote:
> On Thu, Apr 4, 2024 at 1:13 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.04.24 18:25, Frank van der Linden wrote:
>>> The hugetlb_cma code passes 0 in the order_per_bit argument to
>>> cma_declare_contiguous_nid (the alignment, computed using the
>>> page order, is correctly passed in).
>>>
>>> This causes a bit in the cma allocation bitmap to always represent
>>> a 4k page, making the bitmaps potentially very large, and slower.
>>>
>>> So, correctly pass in the order instead.
>>>
>>> Signed-off-by: Frank van der Linden <fvdl@google.com>
>>> Cc: Roman Gushchin <roman.gushchin@linux.dev>
>>> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
>>
>> It might be subopimal, but do we call it a "BUG" that needs "fixing". I
>> know, controversial :)
>>
>>> ---
>>>    mm/hugetlb.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 23ef240ba48a..6dc62d8b2a3a 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -7873,9 +7873,9 @@ void __init hugetlb_cma_reserve(int order)
>>>                 * huge page demotion.
>>>                 */
>>>                res = cma_declare_contiguous_nid(0, size, 0,
>>> -                                             PAGE_SIZE << HUGETLB_PAGE_ORDER,
>>> -                                              0, false, name,
>>> -                                              &hugetlb_cma[nid], nid);
>>> +                                     PAGE_SIZE << HUGETLB_PAGE_ORDER,
>>> +                                     HUGETLB_PAGE_ORDER, false, name,
>>> +                                     &hugetlb_cma[nid], nid);
>>>                if (res) {
>>>                        pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
>>>                                res, nid);
>>
>> ... I'm afraid this is not completely correct.
>>
>> For example, on arm64, HUGETLB_PAGE_ORDER is essentially PMD_ORDER.
>>
>> ... but we do support smaller hugetlb sizes than that (cont-pte hugetlb
>> size is 64 KiB, not 2 MiB -- PMD -- on a 4k kernel)
> 
> Right,  smaller hugetlb page sizes exist. But, the value here is not
> intended to represent the minimum hugetlb page size - it's the minimum
> hugetlb page size that we can demote a CMA-allocated hugetlb page to.
> See:
> 
> a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA")
> 
> So, this just restricts demotion of the gigantic, CMA-allocated pages
> to HUGETLB_PAGE_ORDER-sized chunks.

Right, now my memory comes back. In v1 of that patch set, Mike did 
support denoting to any smaller hugetlb order.

And because that smallest hugetlb order is not known when we call 
cma_declare_contiguous_nid(), he used to pass "0" for the order.

In v2, he simplifed that, though, and limited it to HUGETLB_PAGE_ORDER. 
He didn't update the order here, though.

Acked-by: David Hildenbrand <david@redhat.com>


Note that I don't think any of these patches are CC-stable material.

-- 
Cheers,

David / dhildenb


