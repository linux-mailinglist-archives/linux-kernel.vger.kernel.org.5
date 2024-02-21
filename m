Return-Path: <linux-kernel+bounces-74392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498C85D35B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E01B2412D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB753D0D1;
	Wed, 21 Feb 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhTpR9ul"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB113D0C5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507319; cv=none; b=pTCRBfcK8QhSLWFQjiciMnqGEqI3BIvYpGvXVeT0waXO5bqyDHc+vk388LuOZiSnC4p0aCb3n4W+wiSpfbnCAuOpD9vLQbcOGvgCD+LBd7XUJSZ86UlAcFc26vQB17BU7ZT9+J7zE4+KLtWLxBu282hTBlLbN3E+cIQYmaGBvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507319; c=relaxed/simple;
	bh=umzCLY6h8FpIU6ENoLoToP2YtXOdt3YTl2V6tCD79sk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SHdmcCww0aetAMY8bMvTCy6qKL8cD64+7m3Ejs3Kagacg7jSeUDIai9jpiciTJ12hKCv8mAWN5eozwujXStt3g26lwY+HXf9tiO/9UVRQXLggMDUcaEWEo+f5G1NE9EQSHCyz+wGqwO3SDocn7FavAD8YdMRv8zkdTS8VN7i6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhTpR9ul; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708507316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P28Fq0JrXGeyJdQJQF7vTKqPybUH7oxtv7SEgj52+bA=;
	b=IhTpR9ulFU7CasMq9YN3TjJtYVlDYMfIbmTN6IoMjX4/89YhbTSYmVX0SJHw7Cm5df9Lt6
	DEttEbRdwNS3d1aRxGGWmbn+YMGGDf6vLIk8JOJMAqEdObIFM2Mpb8gItDdvpNziOZD35L
	iZvx+qRs2O1lstz9nzVXk0VaFy/reWY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-unZMdcwxOgeKpVasqnmJIw-1; Wed, 21 Feb 2024 04:21:55 -0500
X-MC-Unique: unZMdcwxOgeKpVasqnmJIw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d7e755f52so129417f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507314; x=1709112114;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P28Fq0JrXGeyJdQJQF7vTKqPybUH7oxtv7SEgj52+bA=;
        b=icLbw3OBzsvLKHK8fPBF6RCI+YLIfE9AQRadEfbGAOmtvt0HB7PVqfjJCn/qFMhhXn
         qGTSIchKBf47kkzWAjAIWr1Xu7R9BI9l6m08EFWVek8PRX9QfwCN/WChQCnJAKIlvL2W
         mMhOKek9ukBqpsCOl4hfOeyBaVvTFZ6cI71uLFr01fkAtRlt1laT7zreHpsOZI+/RHyD
         D5T5/ipc9FXCuiqajgiMlP9a6XgIjN51kTrFz09dfGO1D+9SnHa82JbGNkmvXNb04Gwa
         qXYza3opuwcH0gKia9ovHzi4sXg0icfhpym1MNFDsEjZVbcilk8E5r3six2GDnXo7Jou
         qLmw==
X-Gm-Message-State: AOJu0YzvtgIfD5uYBuiT7gttSRHBri+cVD5d2mk1KtyquQ6qnFWc2d7i
	ngopnG+F0uli0juOlUKeDYWMfHyEx0+Np3b1lMyoPGbHS7ruPtWUyhrP0hx9rkHbHicAEi6XALr
	dbuuLKVUa+DpzEAA7q5ByyDU8hzi4/yKFnpl5zoL8rRakZFyzfTH8VaxEG/mggQ==
X-Received: by 2002:adf:ec4a:0:b0:33d:82c2:ad8d with SMTP id w10-20020adfec4a000000b0033d82c2ad8dmr307993wrn.56.1708507313851;
        Wed, 21 Feb 2024 01:21:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrcSHwbkcZMHd7SCXXxT5nn1F/BZ1IhnCxVe0JaavtnOYrFz1cY0G2mwM9GnXlRROiXShn2Q==
X-Received: by 2002:adf:ec4a:0:b0:33d:82c2:ad8d with SMTP id w10-20020adfec4a000000b0033d82c2ad8dmr307981wrn.56.1708507313407;
        Wed, 21 Feb 2024 01:21:53 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id bj29-20020a0560001e1d00b0033d5c454f03sm7502886wrb.114.2024.02.21.01.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 01:21:53 -0800 (PST)
Message-ID: <2bdc8a6e-fa7d-4893-951a-7212c5e04f9a@redhat.com>
Date: Wed, 21 Feb 2024 10:21:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] madvise:madvise_cold_or_pageout_pte_range(): allow split
 while folio_estimated_sharers = 0
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Matthew Wilcox <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>, Vishal Moola <vishal.moola@gmail.com>,
 Yang Shi <shy828301@gmail.com>
References: <20240221085036.105621-1-21cnbao@gmail.com>
 <4c1224e3-5c02-4d5d-9379-d3b74b1174dd@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4c1224e3-5c02-4d5d-9379-d3b74b1174dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.24 10:15, David Hildenbrand wrote:
> On 21.02.24 09:50, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> The purpose is stopping splitting large folios whose mapcount are 2 or
>> above. Folios whose estimated_shares = 0 should be still perfect and
>> even better candidates than estimated_shares = 1.
>>
>> Consider a pte-mapped large folio with 16 subpages, if we unmap 1-15,
>> the current code will split folios and reclaim them while madvise goes
>> on this folio; but if we unmap subpage 0, we will keep this folio and
>> break. This is weird.
>>
>> For pmd-mapped large folios, we can still use "= 1" as the condition
>> as anyway we have the entire map for it. So this patch doesn't change
>> the condition for pmd-mapped large folios.
>> This also explains why we had been using "= 1" for both pmd-mapped and
>> pte-mapped large folios before commit 07e8c82b5eff ("madvise: convert
>> madvise_cold_or_pageout_pte_range() to use folios"), because in the
>> past, we used the mapcount of the specific subpage, since the subpage
>> had pte present, its mapcount wouldn't be 0.
>>
>> The problem can be quite easily reproduced by writing a small program,
>> unmapping the first subpage of a pte-mapped large folio vs. unmapping
>> anyone other than the first subpage.
>>
>> Fixes: 2f406263e3e9 ("madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check")
>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>    mm/madvise.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index cfa5e7288261..abde3edb04f0 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>    		if (folio_test_large(folio)) {
>>    			int err;
>>    
>> -			if (folio_estimated_sharers(folio) != 1)
>> +			if (folio_estimated_sharers(folio) > 1)
>>    				break;
>>    			if (pageout_anon_only_filter && !folio_test_anon(folio))
>>    				break;
> 
> That's also what I do in
> 
> https://lkml.kernel.org/r/20231124132626.235350-4-david@redhat.com
> 
> I'll revive that soon.

Forgot to add: we can pull this in early.

Reviewed-by: David Hildenbrand <david@redhat.com>

(I'll do the simple folio_estimated_sharers() to folio_mapped_shared() 
conversion first and optimize with total mapcount separately)

-- 
Cheers,

David / dhildenb


