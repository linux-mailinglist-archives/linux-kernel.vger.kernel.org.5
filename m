Return-Path: <linux-kernel+bounces-157274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B6B8B0F56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24262B2F03B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7227416C6A6;
	Wed, 24 Apr 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9XFU2FT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3513D893
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974340; cv=none; b=rG9o6YABYH6a6GXo2RIln4GCBo1CRtY/jIqXWCTOL3QPoJ4dl8Pheefn4plunGKTPAX0Q3N/6sN9TaDiVGHDSwp3BueXRmDCjP+/IRysA5mMI9d0YIJ2IsE3M5ND1gCxjmUQ+p2m3TcZ/MHoiG10ZOyHrA7f4zC7ZFoHk33vDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974340; c=relaxed/simple;
	bh=OZgvUlHgkufvf5THPx1/s0u9VcMkB2raE44eXoL8lkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6P7jjnXS0QalaOJX4kX5I9fPAGK0BJ17lYkQlkzvTBk7Y18XJlJi27jFqpJPFOGA0bubJDpjhi6Y4vCEprFKrVGFc8lOLbfH3Fln3m1gEqUL222OfLenQr+pRjfE7pf1X2RzcrHaRZJKOnJorVZ791PEDIa6iqcvv1q6dQmAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9XFU2FT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713974338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FXxAne31QRv+Be4fJgW6rZrEYbRt43j8aWEXlyjQvIc=;
	b=X9XFU2FTzZ1i+qOPF9lRvUqb64YIHV2SnuaLkSoNyq55bqDevI1vhPTpV/QjUuZuIT+QEq
	CnfLG22gY+T7TCiiMzw3hqIaO/OPNzsewhdT1rWYOsv9Lufx3Bpgv4Uy/lxdKwRabkojn4
	MG/mn/YyJhnRWsHtYnnKuUA8d4oU/R8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-HHz6dRkPMoSnbMXv2Pm-lQ-1; Wed, 24 Apr 2024 11:58:56 -0400
X-MC-Unique: HHz6dRkPMoSnbMXv2Pm-lQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34b08e09bc4so2284935f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974335; x=1714579135;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXxAne31QRv+Be4fJgW6rZrEYbRt43j8aWEXlyjQvIc=;
        b=Olm3ktWEJE4vFOOIRYwxyH6mb35Q7pnWtQL2uxiz6tn2ixzcoxP3fiC/OeJ8Z8fZD6
         gnP7/1dGvdY7gMEv2aPgHTWiWoLYZ6cO7vHWsLSBhSq1DkbY/MbOdByBNUIRJADf+30N
         ywR/xqtcrBpLO4XiqhdrBbbVCq588zVHjzzPGZLXgzjUDvOjOBwa8GXerDjyiByX0RWB
         YvvrFhxa6pKHk3DGosCg3RzY+0Yz49SmXTbaqc74En99YZI2hanoteKcLCOI5F5DEysM
         LkTv1xL9CgBajUnc6CGXh0Q4gVhT25xvHFH+hc1q4tgFp5P890NIuKvrLgwnF0xwKPfi
         jSmg==
X-Forwarded-Encrypted: i=1; AJvYcCVsC/Lg22Xf+K16YWnLo+OdVdTTnCwahb4Pzi0dU2ojpY0mkflq69AlSI8mh4LcSw99FT9wwZzrPtDibjKczdpyY4snnVTzXPmdxP9A
X-Gm-Message-State: AOJu0Yz/hG+yTC1/n/+j58e4zdZmcCs9o3eCmaXPA/o5zcq1gFSUrxTC
	yOezXcKYv23NZnRemkjI0HOn0KeXXRDD1uhf9RRiKurbacabb0kHVinZlTGbQ41ODEz8x2oWQsq
	hv0D6RZ2E4+rlZItywInsDSFU/4BQak3Mps7WKUcAq1AEoOAlzfTpKPW/V1QS3g==
X-Received: by 2002:adf:e0d0:0:b0:347:41be:3cf9 with SMTP id m16-20020adfe0d0000000b0034741be3cf9mr2296307wri.18.1713974335528;
        Wed, 24 Apr 2024 08:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG81RWjqB7Hx0TC/5TXRGjBfMzWGnrHQirtQ2JJCkjU59opn1dMkAl3JLq1F6NFX5C4pDMUrA==
X-Received: by 2002:adf:e0d0:0:b0:347:41be:3cf9 with SMTP id m16-20020adfe0d0000000b0034741be3cf9mr2296273wri.18.1713974335031;
        Wed, 24 Apr 2024 08:58:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id a7-20020adfeec7000000b00349cadc5024sm17449951wrp.61.2024.04.24.08.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:58:54 -0700 (PDT)
Message-ID: <51ba6efa-ce5a-49cf-b90e-62310db2c561@redhat.com>
Date: Wed, 24 Apr 2024 17:58:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during
 shrink_folio_list()
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Lance Yang <ioworker0@gmail.com>,
 akpm@linux-foundation.org, maskray@google.com, ryan.roberts@arm.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240422055213.60231-1-ioworker0@gmail.com>
 <ZiiHSwG_bnLJbwfb@casper.infradead.org>
 <1a0ca018-8ad3-42b0-b98a-8e6b6862fc7a@redhat.com>
 <333181FE-C2E6-4859-AF6A-0667A1F42037@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <333181FE-C2E6-4859-AF6A-0667A1F42037@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.24 17:57, Zi Yan wrote:
> On 24 Apr 2024, at 3:17, David Hildenbrand wrote:
> 
>> On 24.04.24 06:15, Matthew Wilcox wrote:
>>> On Mon, Apr 22, 2024 at 01:52:13PM +0800, Lance Yang wrote:
>>>> When the user no longer requires the pages, they would use
>>>> madvise(MADV_FREE) to mark the pages as lazy free. IMO, they would not
>>>> typically rewrite to the given range.
>>>>
>>>> At present, PMD-mapped THPs that are marked as lazyfree during
>>>> shrink_folio_list() are unconditionally split, which may be unnecessary.
>>>> If the THP is clean, its PMD is also clean, and there are no unexpected
>>>> references, then we can attempt to remove the PMD mapping from it. This
>>>> change will improve the efficiency of memory reclamation in this case.
>>>
>>> Does this happen outside of benchmarks?  I'm really struggling to see
>>> how we end up in this situation.  We have a clean THP without swap
>>> backing, so it's full of zeroes, but for some reason we haven't used the
>>> shared huge zero page?  What is going on?
>>
>> It's not full of zeroes.
>>
>> User space called MADV_FREE on a PMD-mapped THP.
>>
>> During MADV_FREE, we mark the PTEs as clean, the folio as clean and sd "lazyfree" (no swap backend). If, during memory reclaim, we detect that (a) the folio is still clean (b) the PTEs are still clean and (c) there are no unexpected references (GUP), user space didn't re-write to that memory again, so we can just discard the memory "lazily".
> 
> It seems that try_to_unmap_one() does not support unmapping PMD-mapped folios.
> Maybe adding that support instead of a special case handling?

I was thinking the same, and finding a way to avoid TTU_LAZYFREE_THP.

-- 
Cheers,

David / dhildenb


