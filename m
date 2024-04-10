Return-Path: <linux-kernel+bounces-138998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9141F89FD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB191B2B209
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396A17B503;
	Wed, 10 Apr 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fz8t8+sz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514926AE8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767263; cv=none; b=AG9soOcAycLPjDPJaMgsI5D2fNAlLauJyc/Qoda3ABDsLkj0bcH8LXbHvPVBsdjJX/itA8StkKKSGX3omi7GIW3Cc4QdP37QeRRsCCEtR+bnO3KOlm8/4KfRfcP1WKAMgUCi42VeLlMFZgpUTklp68cDPzngc2pnFJPXewyU1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767263; c=relaxed/simple;
	bh=ZuBYKqU8ZmA/aGr4ChFiG4nBtr/BlIEzsnC8/Gkf/Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZcUjTIsx/w9UaHfP+OhYNLjz2ELX7NqRLXkKa2M9XCG+P/dHWmvmTLI6bAYedLjN/cZzJ4VH+kCkj278cIoufyy0ynwVf6oJDVhvplGKeEfIp21wp7h4e1NN+Y3b0jQNTEWAcB9hAO9y7Xdc9MqucMFhnvicaazDCCCFzzuZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fz8t8+sz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712767260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PlvfzPGDpPMuwq7KoNXGefI78QEOx7lRYT1QwZ8k6B0=;
	b=fz8t8+sz3FSagelzTvvEDwTbrfrS6gNTF+oMwv4onlAc/O/rX/NZHbWcGnDbebAzv194MQ
	mIA1PDi+vtL+yGch6uXR6kUF6k9YrNuAU5JpN/P/wo8NsBEvBBP0a0qYt9V5uqZzPIMaT4
	/sqThBiiSpjJKO0az+7APOE9fts/wN0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-T9P2j9uYPO2Nq1lnhuDKTQ-1; Wed, 10 Apr 2024 12:40:58 -0400
X-MC-Unique: T9P2j9uYPO2Nq1lnhuDKTQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3455cbdea2cso11233f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767257; x=1713372057;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PlvfzPGDpPMuwq7KoNXGefI78QEOx7lRYT1QwZ8k6B0=;
        b=gA6qEADfvW3Ri1w5aeTScrFlx3yurO0s5gNm/eHycxeRrM+egfV+qQj/j5ANd3Zifz
         PSx/3meXMdgvnMNbPgi33zaatj0Wm21gCrgOWixYnI0fAYStCF2CliVJnYSJluhAmN2r
         Dl2BecTpPEUOgd4eBrEQSIGHuWjiFxMRbHIGspAk+zNL4gndA7w6W0E1ClY+CIh3YldP
         5KHSTBQrMJVYOO8OlTBdQ0xhqKa03bMfv0uRkYWnAi1+8L2kFAYJHadsttzu4fBKUES+
         3Cd2ALcbr9IwHzIIzQW1xP/3wyZDW/WQPag/2QeRXP7Zj4uIiBRWHZCkA7PAgGlaE6Ub
         J5vw==
X-Forwarded-Encrypted: i=1; AJvYcCVUyjLJrT3JqJXSFfmfA8wXwOgY0H6GTZJhf0Yqwb2LV/AknphY19hWyqHlW3clOeD8jomw9HdrMnVpclM1RUIraXOrgzJmq197d5Ex
X-Gm-Message-State: AOJu0Yy4qjCFJC5NcGiPpWDGUbE4WBFs5tRAtedwklDuVrl2i2pZF+Yg
	09Qf32VJU83g0+UG/E9qweARsRaPNe8JyOp2nPPnf3rytaGjw5o8/d27mXViykfjyqXVRYR3/1C
	aTLnmL4LhCTvTNkE8yZWAM8/xKs3P3pZTd5IzUP171RNBFVTsviQB3LwrTgfEon9ACp4I4w==
X-Received: by 2002:adf:b308:0:b0:345:7fb2:4cec with SMTP id j8-20020adfb308000000b003457fb24cecmr156725wrd.2.1712767257715;
        Wed, 10 Apr 2024 09:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO6KTeGtg2/ZJCvhV0ePycMiXDZxTJwrF1KzBYOYhz6qBHvTc/LDm7uDAdJMdYEp4Db4ioCw==
X-Received: by 2002:adf:b308:0:b0:345:7fb2:4cec with SMTP id j8-20020adfb308000000b003457fb24cecmr156703wrd.2.1712767257278;
        Wed, 10 Apr 2024 09:40:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id p9-20020adff209000000b003432d61d6b7sm14070089wro.51.2024.04.10.09.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 09:40:56 -0700 (PDT)
Message-ID: <61a3bd6b-a352-4e02-8357-81ac7b9f2848@redhat.com>
Date: Wed, 10 Apr 2024 18:40:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled transparent
 hugepages
To: Peter Xu <peterx@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, hughd@google.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, iii@linux.ibm.com, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
 <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
 <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <29b613a8-f0d5-4f5f-adbc-d64ed8908044@redhat.com>
 <Zha5V0QxODZR4qOW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1ce2fe6c-b56a-4582-a5d8-babc8fccef52@redhat.com> <Zha_auw6yBx0YRWQ@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zha_auw6yBx0YRWQ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.24 18:33, Peter Xu wrote:
> On Wed, Apr 10, 2024 at 06:12:34PM +0200, David Hildenbrand wrote:
>> On 10.04.24 18:07, Sumanth Korikkar wrote:
>>> On Wed, Apr 10, 2024 at 05:51:28PM +0200, David Hildenbrand wrote:
>>>> On 10.04.24 17:26, Sumanth Korikkar wrote:
>>>>> On Wed, Apr 10, 2024 at 02:34:35PM +0200, David Hildenbrand wrote:
>>>>>> On 09.04.24 17:54, Sumanth Korikkar wrote:
>>>>>>> In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
>>>>>>> compiler might choose to make a regular function call (out-of-line) for
>>>>>>> shmem_is_huge() instead of inlining it. When transparent hugepages are
>>>>>>> disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
>>>>>>> error.
>>>>>>>
>>>>>>> mm/shmem.c: In function ‘shmem_getattr’:
>>>>>>> ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
>>>>>>>       383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
>>>>>>>           |                           ^~~~~~~~~
>>>>>>> mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
>>>>>>>      1148 |                 stat->blksize = HPAGE_PMD_SIZE;
>>>>>>>
>>>>>>> To prevent the possible error, always inline shmem_is_huge() when
>>>>>>> transparent hugepages are disabled.
>>>>>>>
>>>>>>
>>>>>> Do you know which commit introduced that?
>>>>> Hi David,
>>>>>
>>>>> Currently with CONFIG_CC_OPTIMIZE_FOR_SIZE=y and expirementing with
>>>>> -fPIC kernel compiler option, I could see this error on s390.
>>>>
>>>> Got it. I assume on Linus' tree, not mm/unstable?
>>>
>>> It's not yet upstream.
>>>>
>>>>>
>>>>> However, default kernel compiler options doesnt end up with the above
>>>>> pattern right now.
>>>>
>>>> Okay, just asking if this is related to recent HPAGE_PMD_SIZE changes:
>>>>
>>>> commit c1a1e497a3d5711dbf8fa6d7432d6b83ec18c26f
>>>> Author: Peter Xu <peterx@redhat.com>
>>>> Date:   Wed Mar 27 11:23:22 2024 -0400
>>>>
>>>>       mm: make HPAGE_PXD_* macros even if !THP
>>>>
>>>> Which is still in mm-unstable and not upstream.
>>>
>>> Not related to this commit. I tried on master branch.
>>
>> Thanks! Can you try with Peters patch? (ccing Peter)
>>
>> If I am not wrong, that should also resolve the issue you are seeing.
> 
> David,
> 
> Do you mean this one?
> 
> https://lore.kernel.org/all/20240403013249.1418299-4-peterx@redhat.com/
> 

No, I meant:

https://lore.kernel.org/all/20240327152332.950956-4-peterx@redhat.com/

which removes the "#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })" that we 
seem to trigger here.


.. but it's been a long day, so maybe I'm all wrong :)

> That's indeed similar but that was for pud_pfn() not HPAGE_* stuff.
> 
> I just had a quick look, Sumanth's fix looks valid, and IIUC the goal is
> also that we should keep these build checks around for the long term goal
> (Jason definitely preferred that [1] too, which I agree).
> 
> I removed that build check there for pud_pfn just to avoid other build
> fallouts for other archs as a temporary measure.  For this one if it's in
> common code for a long time and if it's the single spot maybe it's nice to
> have this patch as proposed, as it means it optimizes the if check too
> besides fixing the build error.  After all referencing HPAGE_* with
> !THP+!HUGETLB shouldn't happen logically.
> 
> [1] https://lore.kernel.org/r/20240404112404.GG1723999@nvidia.com
> 
> Thanks,
> 

-- 
Cheers,

David / dhildenb


