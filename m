Return-Path: <linux-kernel+bounces-155003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872F28AE436
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149A41F21841
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433967FBA2;
	Tue, 23 Apr 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRAlGl0n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF225E576
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872287; cv=none; b=l1DBK/4ceQq/9w98xp3e4cCZPK3JSOwgX8ZdAd9LVQD5gN8HsUHZfOfpbSHRaZWhBvYXTWyF//ZOENiGp56xEMHy6lwggyjoZ/Pz8puGHILihAs+NNhhZ5YTgB3LaaRQwQu8YOFyg6a+e6tBnSf1hvL51M7zFj3hzxOtUJC5weY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872287; c=relaxed/simple;
	bh=UkOqjJLcJSyYV7BdEwZbGJizP2fX20J+/oCPqxrQT40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgmpi3w8tCoTn4WIwQFfOC4RVgGSpvmTkhKR5a3uhr8w4PRAOX9giw2azO6f0jPQro7ASL5lQaThIMgM9CBi8ofN9VD+VxUidO6O7uq+zLzPi7SSmq/v2nzNBZpGY4Xx7RvyKJsM8u6DIAubk8141/Hc7cVyw4lHk44l1kRig7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRAlGl0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713872284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UjO76X3N8uiKE88qJacfJA8nBoOAkuwJW8I/qg5fWk0=;
	b=FRAlGl0nfdXCcKd7NsdC3lskfaTeSpFwzYVdxvtmbuMwBsYPxnH2JGhDItNohUCQxHjJtF
	Nwm3JN2uWTsOvgU+mNqN0RnMzGiuGJS/Q1MK+fCoKD6GQMr0Op8gG6zaLaejaZJhdA9e1x
	rJT7zAV5Wz1ZeC+Mk08OYVwHDrAnaX0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-HbnIJbEGNdaLdwjyG7I7YA-1; Tue, 23 Apr 2024 07:38:01 -0400
X-MC-Unique: HbnIJbEGNdaLdwjyG7I7YA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41a370b6acdso8054405e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872280; x=1714477080;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UjO76X3N8uiKE88qJacfJA8nBoOAkuwJW8I/qg5fWk0=;
        b=SAXzig/wR4+lx5kyVWudW4AjhQ1Lan5KR7A5j+W8GOHX95zl2fLpDvY3weyPO4aQTj
         f6LoyaYFY9tR/Aq6ECPOWBrSNt3j8kE0JzpJ2PIPdirg6AcPSrOc6jKzvZzDcwyDC1H3
         qCjWD+YDOMXAqZWLRrYL1M07oPBbobrm/nBx/5v17l4o1L+8BF/zJ1nCb1xmTt7GH21k
         axh5P7ucol8Haq13NML6Ja59BF3ctlYAa24d81TmNXPGphAb9MPEV8JfG4rCE9ggvmeh
         ugQb9uUIqPTQQea50Dd6yj5W1cue8cIvAD4vKcEs7Ce9iFdRKq/NCzNQjbhcHhX7kSKo
         ETAw==
X-Forwarded-Encrypted: i=1; AJvYcCVmR6zvnp6X/99qrMK5+RmdLX1D3MJL8qqkq5GLSKyhT2XuXCznyJ7g7LlkdVfVeC2k2ShurNfb+pY73Y9OJNopGF1u7JeWk3UhkVAf
X-Gm-Message-State: AOJu0Yy68A1nrpliVe8P8//CjkAUDhoaAErnx0GirGl8gKBnd75hP468
	ocvxOHj32g/FPHKMlaqzVEzW1mBLtWIHJ9BSS9ZkXVAbDCVp/m1AaXQznQZu6IlEUGdZkwwA1u8
	o4cZ3M6IFnJ86UFx3zcamt1GK6XOSMEhln5c1H6lOuOY65UTmywhesJ5tL/NQLg==
X-Received: by 2002:a05:600c:3b10:b0:418:7028:f4d1 with SMTP id m16-20020a05600c3b1000b004187028f4d1mr7529851wms.29.1713872280078;
        Tue, 23 Apr 2024 04:38:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+SBvBWK4zAuvmISam4UyhDQKPzV1AN0dxSk+xrNs4wuppufjh+2jdJS2rmQYR/OJiIjrzkw==
X-Received: by 2002:a05:600c:3b10:b0:418:7028:f4d1 with SMTP id m16-20020a05600c3b1000b004187028f4d1mr7529833wms.29.1713872279659;
        Tue, 23 Apr 2024 04:37:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b0034659d971a6sm14321746wrw.26.2024.04.23.04.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:37:59 -0700 (PDT)
Message-ID: <ce6be451-7c5a-402f-8340-be40699829c2@redhat.com>
Date: Tue, 23 Apr 2024 13:37:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
To: Barry Song <21cnbao@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 wangkefeng.wang@huawei.com, ryan.roberts@arm.com, ying.huang@intel.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.04.24 03:17, Barry Song wrote:
> On Mon, Apr 22, 2024 at 3:03 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/huge_mm.h | 2 ++
>>   mm/huge_memory.c        | 4 ++++
>>   mm/shmem.c              | 5 ++++-
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 26b6fa98d8ac..67b9c1acad31 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -270,6 +270,8 @@ enum mthp_stat_item {
>>          MTHP_STAT_ANON_SWPOUT,
>>          MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>          MTHP_STAT_ANON_SWPIN_REFAULT,
>> +       MTHP_STAT_SHMEM_ANON_ALLOC,
>> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,
> 
> not quite sure about this. for 2MB pmd-mapped THP shmem, we count them
> as FILE_THP.
> here we are counting as SHMEM_ANON. To me, SHMEM_ANON is more correct but
> it doesn't align with pmd-mapped THP. David, Ryan, what do you think?

The term "anonymous share" in the patch subject is weird to begin with 
;) Easy to confuse with anonymous cow-shared memory. Let's just call it 
"anonymous shmem", which it is under the hood.

.. regarding the question: if we add FILE_ALLOC and friends, at least 
initially, we wouldn't account other large pagecache folios.

.. likely we should add that then as well so the counter matches the 
actual name?

If we later realize that we need separate FILE vs. SHMEM vs. WHATEVER 
counters, we can always add more fine-grained counters later. Doing it 
consistently w.r.t. traditional THPs first sounds reasonable.

-- 
Cheers,

David / dhildenb


