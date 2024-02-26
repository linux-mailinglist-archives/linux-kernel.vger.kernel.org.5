Return-Path: <linux-kernel+bounces-81437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B88675F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B34A28737E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB28002F;
	Mon, 26 Feb 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLcpYGA6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8E5A7B9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952646; cv=none; b=Vjlu1jMo88Faf/CdqFzOZl6ySNutU7QnjYP1X04UUVyQH3T8jPqrN4QQD31RIQGum9V+nExjnlJrBeLLNxbuyWco3w85WkpjIshYNZr+eFpStqqGyb3UHU9qrqurbw8zOTBZZPH9+j4geXqLZuUKW4sa01DBvyc8GHIzfAtI968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952646; c=relaxed/simple;
	bh=cUlekvs3wYjDGwsZ/2gw62e3ychcJpK+pjlVZwYDch4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSHQiu9KAcJbZv2iYKzfIxbU+2A2f2w7KiaoT5jNNrTR5Wl618Edub3mRhEDjdDbl++cGsWSIGib6dGfp0PB6+vSfdEu22/Ubas/dB9L46LKhWyWrSxRpgUGMxqmB2Vc83PkPha7crUkRe0TnwpXbLGHnCilpO3UYrlAx73t5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLcpYGA6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708952643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tkUHhNf5nqE4vZor04LTozOwzk92JvYCvzeibbs9Ky0=;
	b=hLcpYGA61rF1ceRC7KA+NF71I94aN3SIjQqUiPkeWYXj4WwWxZZzCcVPjTDEksptFafJx4
	IXOwloSwkejwWDRMSFDd5a8kbhRQ2JJKJCr6b9PYYyv2paGUBmPU8jll/EueuGuL4L5Qdq
	OM6+JWnJci9oqnwnVaLVdgORfDHV1xA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-RAKgBktCOiq4OLfwclbW4w-1; Mon, 26 Feb 2024 08:04:02 -0500
X-MC-Unique: RAKgBktCOiq4OLfwclbW4w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4128defb707so15220975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708952641; x=1709557441;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkUHhNf5nqE4vZor04LTozOwzk92JvYCvzeibbs9Ky0=;
        b=lhz9Coxc9FB38JOPKDBIfDjeX2okmLwWSIogG/JxxP3ejgUhCrp0IgnZyii5U2GwxP
         TUqDWl75hDbg7/IVOZoCeOKxR5d/JbiRJoekRtNRyU1oSGFGM/PWaS0LYfi01GbD1+gV
         4RtXMmSnkvLfpdk11xjqS/QwWYBT5G7G1QKyRwNje/+Ru9Ge9eyJBDhPAVip5krLffGY
         JxK9sKYek5e9GI6XSGhcnz7uhLulb48YJOMFCy3rAAhqnlFCOFbpm1EO1Ktq/EncjNHF
         rXqRzuiIwd9NhDst/Vl/5Qfg7DpJmEmhvqwKyguCGVHq5Mh+t6EXb5WzGfNomx+R59Vq
         Xyrw==
X-Forwarded-Encrypted: i=1; AJvYcCVkCVbMTU2QcM3sa5cBehLBPz2yl8i8OfS8CnMgFaWCKmt802jFrrHfi6dxaBK9lk93fRPY+qpD3qLmGAiu0sILO0SIen/Ste/POAVH
X-Gm-Message-State: AOJu0Yys1nAjBV476pywQylZYKJ5YFWDeXlSodSnI0dVAK51iVRll8G5
	ynHZYyYIT7LY/NA6JvXAavAR9OZjYKms5x7hhWExMh1rqoOZWc5umD+YV+Jm0MqNQ20vXIJ1YKa
	CtShnG/NrwM/hgTRrtjq3DRORXZs/3ZDnGmFKqB8bbRWH1ZjwS9c1TZ4N4jE7CA==
X-Received: by 2002:a05:600c:4588:b0:412:8d98:34d0 with SMTP id r8-20020a05600c458800b004128d9834d0mr6768268wmo.33.1708952641025;
        Mon, 26 Feb 2024 05:04:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIfaeH+E+BW11w2/bmO8nMkFSN15zFm+vswMk5erlvo7oTSVZE6IZZ/bfUJaipZGMo9Wegig==
X-Received: by 2002:a05:600c:4588:b0:412:8d98:34d0 with SMTP id r8-20020a05600c458800b004128d9834d0mr6768234wmo.33.1708952640575;
        Mon, 26 Feb 2024 05:04:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:f700:104b:9184:1b45:1898? (p200300cbc72ff700104b91841b451898.dip0.t-ipconnect.de. [2003:cb:c72f:f700:104b:9184:1b45:1898])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b00412a37130ccsm4467275wmp.48.2024.02.26.05.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 05:04:00 -0800 (PST)
Message-ID: <517e4c23-11f8-4ded-a502-354c482c4e51@redhat.com>
Date: Mon, 26 Feb 2024 14:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
 fengwei.yin@intel.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com,
 shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com,
 zokeefe@google.com, 21cnbao@gmail.com
References: <df416acb-d913-4e67-b810-cd991003242e@intel.com>
 <20240226083526.26002-1-ioworker0@gmail.com>
 <8b909691-ca53-43b9-aab1-dba3ef3577cd@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8b909691-ca53-43b9-aab1-dba3ef3577cd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.02.24 13:57, Ryan Roberts wrote:
> On 26/02/2024 08:35, Lance Yang wrote:
>> Hey Fengwei,
>>
>> Thanks for taking time to review!
>>
>>> On Mon, Feb 26, 2024 at 10:38 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>> On Sun, Feb 25, 2024 at 8:32 PM Lance Yang <ioworker0@gmail.com> wrote:
>> [...]
>>>> --- a/mm/madvise.c
>>>> +++ b/mm/madvise.c
>>>> @@ -676,11 +676,43 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>                 */
>>>>                if (folio_test_large(folio)) {
>>>>                        int err;
>>>> +                     unsigned long next_addr, align;
>>>>
>>>> -                     if (folio_estimated_sharers(folio) != 1)
>>>> -                             break;
>>>> -                     if (!folio_trylock(folio))
>>>> -                             break;
>>>> +                     if (folio_estimated_sharers(folio) != 1 ||
>>>> +                         !folio_trylock(folio))
>>>> +                             goto skip_large_folio;
>>>> +
>>>> +                     align = folio_nr_pages(folio) * PAGE_SIZE;
>>>> +                     next_addr = ALIGN_DOWN(addr + align, align);
>>> There is a possible corner case:
>>> If there is a cow folio associated with this folio and the cow folio
>>> has smaller size than this folio for whatever reason, this change can't
>>> handle it correctly.
>>
>> Thanks for pointing that out; it's very helpful to me!
>> I made some changes. Could you please check if this corner case is now resolved?
>>
>> As a diff against this patch.
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index bcbf56595a2e..c7aacc9f9536 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -686,10 +686,12 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>   			next_addr = ALIGN_DOWN(addr + align, align);
>>   
>>   			/*
>> -			 * If we mark only the subpages as lazyfree,
>> -			 * split the large folio.
>> +			 * If we mark only the subpages as lazyfree, or
>> +			 * if there is a cow folio associated with this folio,
>> +			 * then split the large folio.
>>   			 */
>> -			if (next_addr > end || next_addr - addr != align)
>> +			if (next_addr > end || next_addr - addr != align ||
>> +			    folio_total_mapcount(folio) != folio_nr_pages(folio))
> 
> I still don't think this is correct. I think you were previously assuming that
> if you see a page from a large folio then the whole large folio should be
> contiguously mapped? This new check doesn't validate that assumption reliably;
> you need to iterate through every pte to generate a batch, like David does in
> folio_pte_batch() for this to be safe.
> 
> An example of when this check is insufficient; let's say you have a 4 page anon
> folio mapped contiguously in a process (total_mapcount=4). The process is forked
> (total_mapcount=8). Then each process munmaps the second 2 pages
> (total_mapcount=4). In place of the munmapped 2 pages, 2 new pages are mapped.
> Then call madvise. It's probably even easier to trigger for file-backed memory
> (I think this code path is used for both file and anon?)

What would work here is using folio_pte_batch() to get how many PTEs are 
mapped *here*, then comparing the the batch size to folio_nr_pages(). If 
both match, we are mapping all subpages.

-- 
Cheers,

David / dhildenb


