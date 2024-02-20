Return-Path: <linux-kernel+bounces-72669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1B085B6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601632842A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBFE60DE6;
	Tue, 20 Feb 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVcyQQyi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E845FDB3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420314; cv=none; b=c4Q4aThXBRk2/5Xe3HvE87HsqVG0CUPQgUG2IFbxc+bVEgAsHtC6sXPo+epCHkt9Ay2x1F7PkKns7lgA4vpIV5icN+66D3vPHYxb255EX6u5d4iDBmv6VHaankcDaFUlqzwjAcTa3MQZilpyqyi3sq35HXpfz2dGKxPhqyid6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420314; c=relaxed/simple;
	bh=Jw58d3PIRHMR6kihzKv0kkvazhIqV5r5fBFnMkfKw1c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dKWICJRs3vgbwpcNlbUTJPRH1dKVx14941zMOiOAIujWkMvtNz9NRiuyCP1jfJ/NIL087uuz7Zn/aoTHQHDG6hCEXYsuPRdPVv1chA+vqytufoK6k0vLj302FYACcFQB5ypsCywahm6rq5gsgKTFgolfrNqZ0aM1DxMiXO90WxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVcyQQyi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708420311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ydpv7uzb+kCUFp13gnlTxWS2SWh+s4umAAY6DmFWn44=;
	b=hVcyQQyiNVW1a6mIeMZlOQmA41PvZu3RI9aElsh0tOs/Zb7mj/d/cB3IfpuNl5lK6BKx0T
	AfR15ewoe0Z7AWFcSI+Q/3LadvOMRfyZEMVaiQC/UzrQlE1oYJ+2B0OX3CAe9Sl/2Jq29i
	GAdvzHQT5Jyj+GIORkW5hlpi4Y32k8c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-DSuHgl28OiK890VxS6rfNw-1; Tue, 20 Feb 2024 04:11:49 -0500
X-MC-Unique: DSuHgl28OiK890VxS6rfNw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412567128ebso13993455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420308; x=1709025108;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydpv7uzb+kCUFp13gnlTxWS2SWh+s4umAAY6DmFWn44=;
        b=u6RaELi4lxd+LOFHp8CXDDPwOxR0jL6JxrugEO9PqPgMvGEOecfALQDMpfmRnYzcSz
         rifbpMmuIYPN8M20cCZ9nw1FxOXu72Z7SoJmxxj+U1hwhGii/DXQI5ElbjP6JOjG4wOU
         NHWOEbyxD3/E6vOmCS01GupF5aiUQUUcr3AbsMP5ILVW+qhPfXl2Lhk2E7JiUyHu4e7r
         WmBf1i+Fq16XF3WrH6sfcE6ORIiQlY7U2CXj9IwqzqXZVM5tPjj8ubbhK/lclAKbjfAH
         5d7USSJ+/Xjhbd68iYO7ncNvvEnoCsaYz0g7yvL+HraDJwesWC3z1t0HxoceKXcDizp8
         ZceA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ezwIj6mZz6zgubpWKQLeoZnP+MJhnAdzjeSBclbJjyh9xsbV++ZWx6ZiE/XRZovCM95tk8lw9V0i7I1CaNX5d68z1p2ZBZjJdnq9
X-Gm-Message-State: AOJu0YykX7/CcL2Ou4q/wYRbbZ0pzePC5GeU/g6Ed5PolA9BYN6yv8f7
	4qSiJir+duDF/ZtDNI5Ytn/uxXUP8vFI0m+2lYXO4Z5dElb/auPlP8rowxPTx4XVL+vkM3neWl/
	qo/cdyZZmuI0x3WnlpfZA2g68Q7NY3YKW4EsABmyJiQxv63iOuwXWk3GICwS5DjFmXBe5/A==
X-Received: by 2002:a05:600c:4507:b0:412:6170:a178 with SMTP id t7-20020a05600c450700b004126170a178mr4893037wmo.29.1708420308557;
        Tue, 20 Feb 2024 01:11:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFssF+sD8CPNhU1u7409oVIchgUTNyuXbMg8IQSuvbCAer9kgBnItgkaMXweVY12fvn+e4dgQ==
X-Received: by 2002:a05:600c:4507:b0:412:6170:a178 with SMTP id t7-20020a05600c450700b004126170a178mr4893018wmo.29.1708420308218;
        Tue, 20 Feb 2024 01:11:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb? (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de. [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c19d300b004126ca6c241sm2367328wmq.23.2024.02.20.01.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 01:11:47 -0800 (PST)
Message-ID: <7ca085eb-baa5-4085-a2b9-7402bb3fd9e9@redhat.com>
Date: Tue, 20 Feb 2024 10:11:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] mm/compaction: enable compacting >0 order folios.
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Yin, Fengwei" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rohan Puri
 <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
 <20240216170432.1268753-3-zi.yan@sent.com>
 <416d1450-6480-4113-b778-689a8f1d4e42@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <416d1450-6480-4113-b778-689a8f1d4e42@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.24 10:03, David Hildenbrand wrote:
> On 16.02.24 18:04, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> migrate_pages() supports >0 order folio migration and during compaction,
>> even if compaction_alloc() cannot provide >0 order free pages,
>> migrate_pages() can split the source page and try to migrate the base
>> pages from the split.  It can be a baseline and start point for adding
>> support for compacting >0 order folios.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Suggested-by: Huang Ying <ying.huang@intel.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Tested-by: Yu Zhao <yuzhao@google.com>
>> Cc: Adam Manzanares <a.manzanares@samsung.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>    mm/compaction.c | 66 ++++++++++++++++++++++++++++++++++++++-----------
>>    1 file changed, 52 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index cc801ce099b4..aa6aad805c4d 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_control *cc)
>>    	return too_many;
>>    }
>>    
>> +/*
> 
> 
> Can't you add these comments to the respective checks? Like
> 
> static bool skip_isolation_on_order(int order, int target_order)
> {
> 	/*
> 	 * Unless we are performing global compaction (targert_order <
> 	 * 0), skip any folios that are larger than the target order: we
> 	 * wouldn't be here if we'd have a free folio with the desired
> 	 * target_order, so migrating this folio would likely fail
> 	 * later.
> 	 */
> 	if (target_order != -1 && order >= target_order)
> 		return true;

I just stumbled over "is_via_compact_memory", likely that should be used 
instead of the "!= -1 check.

-- 
Cheers,

David / dhildenb


