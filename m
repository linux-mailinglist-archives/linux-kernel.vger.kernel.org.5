Return-Path: <linux-kernel+bounces-95138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D48749A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9B8B21213
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA1A81216;
	Thu,  7 Mar 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zsjdw1i0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E280C17
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800344; cv=none; b=POdhzIO5ih1FrhevJRCXYs+Z3nH270Y50kShsTNMdnaiNBB5F/gvUoArP+AnQrLrddmJex5uC5EvFVa4NljhbTd5PSB3h7dThswtph4PlzKQ7dJuYvijMhRbSIkNCguHUD9uZFZlB2BHzsL4CGu110KgTwDnHDlgT7VSA0pQMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800344; c=relaxed/simple;
	bh=p/ilcvrnwxNax+96bwrJypXLvlKGbHwkCZdG1/0HcRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A31iO1o/UmO5jNdaA5MUqAVGHOXhvYZN4rY8kdBK1FViB4F8hQKPX4g6k+R0VxoYroyFF7uenICiHrcvvSSFmC9k4JUA4y8aBuK+LxDnnhGbul6ph58KgL25MLeUI6xf46gR4nC5vi3RW/deAGHUDEdbZp04XpnevIZ0Eez1x6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zsjdw1i0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709800341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zAHn8LOx1lP7JKwUZINZyWvLPYZR5f8B3ar1vFmQjwU=;
	b=Zsjdw1i0LpjV/KtxZxz3132NoHDgvjrz4xpV99CHKE3R1bhSm1wJgQ5Q/4IazBf7rJjjkK
	BCwUn0nizaBTLHDhT2uKbPxmscMD632xrfzc+gnlVmOcHDhRVUH1WfnRKix1Y2rK7/6DeF
	AtfpzouBDllTUpDM4cLqTLt/bd1qjqM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-MB5H4xzjOyysDcaE-7bLVA-1; Thu, 07 Mar 2024 03:32:16 -0500
X-MC-Unique: MB5H4xzjOyysDcaE-7bLVA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-609a1063919so12170027b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800336; x=1710405136;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAHn8LOx1lP7JKwUZINZyWvLPYZR5f8B3ar1vFmQjwU=;
        b=vzK1IpwrF2t8aq4aC3CFKAIu8tNohVLR+8ov/0CUSovA2DSgzULLUV2eEZXx8Xev0x
         1H1yEl6MV8k4WHSPdkvgnv70xnpk1W+4VeoFYsW6PIwKiwXQ1sVDsNNtaE2UF7kxUr5q
         A/gabeKp1FV8xX0kHJwQxeMIJKBq0ab9k6sx9TerRMJL26tbuTK+qw8sPeKTPQrYCOss
         1nS0zqy7FQyVX8leVs+rsAW4Ravbz0GQu81UFm+OqoLmGOtqE3H0EeoOJ3AOumPSVywi
         vTesGlNSF6bdOOgRpWvBsGz7i6BFLRfDIoZwY7vWOYnYj7WYbSPwM62Y67g7W0GAWej0
         O2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbjlj3qcwOvfvBhur+cQjel06mg87dTJ3//8K8iwJ/PClVhhJvngmt1q9qQY4LzTYuIUCzfPGXA9/tn7L8z+MW2g2+FS1q425SXoyT
X-Gm-Message-State: AOJu0Yytj/owjQ7M7QWufH2gkcpZhze7RSBh4YR5IxTv6kueSqMtHL1Y
	A3IywwnbTKN3UHAiNNJUXkIBjmqbyocPPJ688htOLGnfxNjx+TIu25ti9tmOFB3YDU0A0qyGLRH
	ElLAkaXUmdD9+GZOYmwWMRFQEnamDWiXaC1fg0hspfdjcRET0nTd2XPYutWATig==
X-Received: by 2002:a81:4ec2:0:b0:609:f49f:5949 with SMTP id c185-20020a814ec2000000b00609f49f5949mr608719ywb.21.1709800336281;
        Thu, 07 Mar 2024 00:32:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm/KflH3weBClUJUanqSqMvy2sb1vEIhS4wRzH9yk4QowkTMli4quk1DwpgpmNFA7QVESgug==
X-Received: by 2002:a81:4ec2:0:b0:609:f49f:5949 with SMTP id c185-20020a814ec2000000b00609f49f5949mr608698ywb.21.1709800335891;
        Thu, 07 Mar 2024 00:32:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:6400:4867:4ed0:9726:a0c9? (p200300cbc74d640048674ed09726a0c9.dip0.t-ipconnect.de. [2003:cb:c74d:6400:4867:4ed0:9726:a0c9])
        by smtp.gmail.com with ESMTPSA id v4-20020a81b704000000b00609f060cecbsm201111ywh.129.2024.03.07.00.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:32:15 -0800 (PST)
Message-ID: <5cc05529-eb80-410e-bc26-233b0ba0b21f@redhat.com>
Date: Thu, 7 Mar 2024 09:32:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
To: Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 Vishal Moola <vishal.moola@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, ryan.roberts@arm.com,
 shy828301@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240307061425.21013-1-ioworker0@gmail.com>
 <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.03.24 09:10, Barry Song wrote:
> On Thu, Mar 7, 2024 at 9:00 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> Hey Barry,
>>
>> Thanks for taking time to review!
>>
>> On Thu, Mar 7, 2024 at 3:00 PM Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> On Thu, Mar 7, 2024 at 7:15 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>
>> [...]
>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
>>>> +                                                struct folio *folio, pte_t *start_pte)
>>>> +{
>>>> +       int nr_pages = folio_nr_pages(folio);
>>>> +       fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>> +
>>>> +       for (int i = 0; i < nr_pages; i++)
>>>> +               if (page_mapcount(folio_page(folio, i)) != 1)

No new direct subpage mapcount users please if avoidable. Also, without 
holding the page lock this might be racy (did not stare at the bigger code).

>>>> +                       return false;
>>>
>>> we have moved to folio_estimated_sharers though it is not precise, so
>>> we don't do
>>> this check with lots of loops and depending on the subpage's mapcount.
>>
>> If we don't check the subpage’s mapcount, and there is a cow folio associated
>> with this folio and the cow folio has smaller size than this folio,
>> should we still
>> mark this folio as lazyfree?
> 
> I agree, this is true. However, we've somehow accepted the fact that
> folio_likely_mapped_shared
> can result in false negatives or false positives to balance the
> overhead.  So I really don't know :-)
> 
> Maybe David and Vishal can give some comments here.

Well, I did not accept the fact yet that folio_likely_mapped_shared() 
can give false negatives :)

So I've been working on a replacement [1], also in the context of 
removing the subpage mapcounts. But there is still a lot to resolve 
around that, first step being to introduce the total mapcount.

But independent of that, MADV_FREE is special (compared to 
MADV_DONTNEED), because we really have to make sure all page table 
mappings that map the folio will be covered here.

What could work for large folios is making sure that #ptes that map the 
folio here correspond to the folio_mapcount(). And folio_mapcount() 
should be called under folio lock, to avoid racing with swapout/migration.

So instead of checking each page_mapcount(), see how many PTEs you could 
batch, try taking the folio lock, and compare the number of batched PTEs 
against folio_mapcount(). If they match, we're good. if not, there is 
some other folio mapping somewhere else (other process, mremap).

folio_likely_mapped_shared() should still be used as an early exit point.

[1] 
https://lore.kernel.org/all/20231124132626.235350-1-david@redhat.com/T/#u

-- 
Cheers,

David / dhildenb


