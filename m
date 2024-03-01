Return-Path: <linux-kernel+bounces-88785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A1986E690
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289892807BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A9538D;
	Fri,  1 Mar 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM1v6thh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88424694
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312407; cv=none; b=E0sMxq5Z8NF33yx+1auVVKCBkpZOSMmwAGqGqcH7dPUPRw6D+A9olU6Z25aPFbAu0SDd6veTwRpuu/T7Iys2AqcPWAIIscCa8cz3XWnj6fXeuhgHFQRizD1s73E2NtOAtO6ax6uI5sywKVj6HhvALl8NeI5zYKOyF/piHKs110w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312407; c=relaxed/simple;
	bh=cdUkwTJ4sDcwlz40Q1vcRQkndA/tRNvvv6VcEiAj2IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkUB5gy1asBjXFVt6v3bPsPKs1tBMolutlI2Kz8z7c5VeVM5ZgatbD/zbQ+Y3Zc8oPqxIa9eVsX8DExJgzMkPO1sAjNlzb3NHq6on9XY1CuW5VfO/CtvWfH9x1pRvYx64SfBSQXhddN2dJosNQWYsGj9Ca4XvfcFDaCVgl/jUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cM1v6thh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709312404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vC0j1pDca94kVzD56XU2b+pEwYKKJvaHqfZ/B4hPaHU=;
	b=cM1v6thhS1mzUngjxBEkv5qSkiy24Hh2GYZPV3hRWE/KOjTMMC+n+HzhbvFG7GSuAXdMmJ
	cbqroDyHMXeLxgpTwaXDB3v7gBqeuIsEQaC3+z5G+iHQ7CcDKZVUw/WpwMZc63h0ORSDEq
	dKnR2fwYKd6a2PSYZ2SUXW/dmGTpNmQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-T5WTpG1KNmyNszTEt7TaxA-1; Fri, 01 Mar 2024 12:00:03 -0500
X-MC-Unique: T5WTpG1KNmyNszTEt7TaxA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d308b0c76so1606468f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312402; x=1709917202;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC0j1pDca94kVzD56XU2b+pEwYKKJvaHqfZ/B4hPaHU=;
        b=hmtQJlQfx/BJyg7jyl/Fn2Kt0BlLeRfi7IbcRBiG/MxznldGvm/YJyMjckQp9aQ/CF
         N8YGE/w8kTvfxFSSeETh7h+UxUTkfNoBH/N3u7I9eVdOMH2G8WWzEBtW+g7zBift/+6H
         ZpaqtFmmzJb6rz6zXX1jIbS0R7fYRYNO9j45CAU3WLAcZdViRlN3MI/1MRLsRvm1FpGk
         kO6N6u5ONoXp3K7/fucHk+akOcza8hB6y9Qo3kqbGTcgw7iryUYUdRiF+Ukdtyr3SwTK
         EvELTCHujoUnv5Kp4uA0+TC3y3USf+ayA2QCZC/ImoV5dFNs4EXk3PyEA032UGD8Om11
         tfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlGkg+66Eu1G51+5vPcuXUN/Y13OQA6Y7BxqZLJdpWy2RqWmC67UmJHF4DTC0ZqwpmMhnyp0i+IFEnQAundTNibkvwG+50yZ6S7Vjm
X-Gm-Message-State: AOJu0YyRnaqkfXMUaoDogQjnXy35pPKjqNRcd8a/6Kq/Z5aTaTyv34rk
	kPqaM3dIg8xP62Ncr2EAWYyHkHMsq4sK4TB8xszpfxv6HLDtVwHbVVQ6o+yuii6jxZ6ZBuQHvQ4
	BlhI2EzRXSYozRk2ZGwcFUsML3YVrRHJbuW8aVWtJuuWp4JX0nC65cIVru5yKog==
X-Received: by 2002:adf:cc07:0:b0:33e:11d7:1a95 with SMTP id x7-20020adfcc07000000b0033e11d71a95mr3304519wrh.27.1709312402480;
        Fri, 01 Mar 2024 09:00:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYnzp3dw9AckN62AJlZtm/FXCwjJTKZL+PJQjC/qnNz+fG+crGDHIqjyPeWe9oHBKdvoouUA==
X-Received: by 2002:adf:cc07:0:b0:33e:11d7:1a95 with SMTP id x7-20020adfcc07000000b0033e11d71a95mr3304493wrh.27.1709312402127;
        Fri, 01 Mar 2024 09:00:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c713:3200:77d:8652:169f:b5f7? (p200300cbc7133200077d8652169fb5f7.dip0.t-ipconnect.de. [2003:cb:c713:3200:77d:8652:169f:b5f7])
        by smtp.gmail.com with ESMTPSA id jn3-20020a05600c6b0300b004128e903b2csm8893123wmb.39.2024.03.01.09.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 09:00:01 -0800 (PST)
Message-ID: <c12fbea5-0d5d-4c06-b063-dab3dd00e704@redhat.com>
Date: Fri, 1 Mar 2024 18:00:00 +0100
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e56fbf5e-8051-4285-875b-1de529dc6809@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.03.24 17:44, Ryan Roberts wrote:
> On 01/03/2024 16:31, Matthew Wilcox wrote:
>> On Fri, Mar 01, 2024 at 04:27:32PM +0000, Ryan Roberts wrote:
>>> I've implemented the batching as David suggested, and I'm pretty confident it's
>>> correct. The only problem is that during testing I can't provoke the code to
>>> take the path. I've been pouring through the code but struggling to figure out
>>> under what situation you would expect the swap entry passed to
>>> free_swap_and_cache() to still have a cached folio? Does anyone have any idea?
>>>
>>> This is the original (unbatched) function, after my change, which caused David's
>>> concern that we would end up calling __try_to_reclaim_swap() far too much:
>>>
>>> int free_swap_and_cache(swp_entry_t entry)
>>> {
>>> 	struct swap_info_struct *p;
>>> 	unsigned char count;
>>>
>>> 	if (non_swap_entry(entry))
>>> 		return 1;
>>>
>>> 	p = _swap_info_get(entry);
>>> 	if (p) {
>>> 		count = __swap_entry_free(p, entry);
>>> 		if (count == SWAP_HAS_CACHE)
>>> 			__try_to_reclaim_swap(p, swp_offset(entry),
>>> 					      TTRS_UNMAPPED | TTRS_FULL);
>>> 	}
>>> 	return p != NULL;
>>> }
>>>
>>> The trouble is, whenever its called, count is always 0, so
>>> __try_to_reclaim_swap() never gets called.
>>>
>>> My test case is allocating 1G anon memory, then doing madvise(MADV_PAGEOUT) over
>>> it. Then doing either a munmap() or madvise(MADV_FREE), both of which cause this
>>> function to be called for every PTE, but count is always 0 after
>>> __swap_entry_free() so __try_to_reclaim_swap() is never called. I've tried for
>>> order-0 as well as PTE- and PMD-mapped 2M THP.
>>
>> I think you have to page it back in again, then it will have an entry in
>> the swap cache.  Maybe.  I know little about anon memory ;-)
> 
> Ahh, I was under the impression that the original folio is put into the swap
> cache at swap out, then (I guess) its removed once the IO is complete? I'm sure
> I'm miles out... what exactly is the lifecycle of a folio going through swap out?

I thought with most (disk) backends you will add it to the swapcache and 
leave it there until there is actual memory pressure. Only then, under 
memory pressure, you'd actually reclaim the folio.

You can fault it back in from the swapcache without having to go to disk.

That's how you can today end up with a THP in the swapcache: during 
swapin from disk (after the folio was reclaimed) you'd currently only 
get order-0 folios.

At least that was my assumption with my MADV_PAGEOUT testing so far :)

-- 
Cheers,

David / dhildenb


