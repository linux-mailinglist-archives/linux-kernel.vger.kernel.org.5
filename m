Return-Path: <linux-kernel+bounces-134866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A49489B80A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADD21C214C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C2E20319;
	Mon,  8 Apr 2024 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXm1klXF"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2331BC39
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559514; cv=none; b=WJo4O5v2DMVmcp5FMosm0jB+LIFIvvXlxMt/D/0h8xYsVCY37XyAhy6nO9X3dY2NX5DmNDxwi2vsYS374tVK3O5AhoZCIkis/53M0/RYCrWRdRIYebxS2iUE2FSJceCpId0BtBMWbt1yExlelEQSJCcziMkKCtOhysj2z4xbDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559514; c=relaxed/simple;
	bh=xwZ0oRPRdQM/0/Nv4fTqK3P3CYlYkkyyakfpKgJMr/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSmHVuOgaqKo5mfJSP9FxlsAdozlaOWBiWDKkHx099eWAjqKeKACf2YOsLIdljgIs3rdwKo3/wFfMQOz9wYLHTypLb42QasTQTn79dRVZJ5u0mnFQOr6TG3BbDptuOt8Rh2LjFmSu7NJkCxO6t5kLgPVgx6nfVgavIMZNJPe/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXm1klXF; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ea1d2c1d58so162634a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712559512; x=1713164312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoEgnDj4oJZ/BtOVN1Y4mT1PkwbO2MooDgu35TXiDBY=;
        b=ZXm1klXFedQcVjfewbuUZh240WmIUtgl0Ll52o/5MT7BlPFcbYpOJImTgtBBUStb/I
         VZi4SPVs7Cy7cAYBp11V9of180ElUV1ijjIAI+qOQjVnRKD0saa14tcnH7pPH8PMrJpH
         gGzJwX1/5iIgg0kOAetNJHZXB2/OiyyncDNusCUv0JX6wCCO7prd+/o3dZyrNrTN1Cyf
         foP+2LaVHoUWU3avalBwGdLqNuwoX0lALN8SqDSY9PGrUeR7LlHaMkQ21vDpIovxyvAx
         Ul4RQSxDLKjQ4Lh690bzSY3hQSIXK7cHTl/ADp/OM57QmLNadHY+iq9PcZytMW0MQx3A
         5ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712559512; x=1713164312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoEgnDj4oJZ/BtOVN1Y4mT1PkwbO2MooDgu35TXiDBY=;
        b=Lj8mEncrSNks//SdmHkwkeNgIluWBDvzhPu+nqXJlZmS/ZNWNrraMGHow5MLecKLma
         kt64zJG7qo1htRzOTpHkwZy2e+hLNYGRnZ5ch4Dzzx7jJSWGmEJZj1gEC/S2oWZSZMKX
         GlJp3sYbuBwE8saX9BlN5p6VeV/P46RiQ3kNVhCehspqjZRTUHqQImasH+LsJQoYKkde
         rY+Wx3XcA1Fuiea0ORSWdJ23zg5ffs63leUY+3iBDCbvmA3TxZ34On4AJdqlb11/1U9j
         WptTbqsMcCdVJJDJsnnVxkVcIUVk75BO3XSlnSU/L4LQwuwwF4pqTbMcsudTIEWT8jh3
         Xa0A==
X-Forwarded-Encrypted: i=1; AJvYcCXNDht+pWICagtN3Ga6pUQBA1erk+GYlHYNIG+RRZjFI6r6JM3cmmQgHjvym7+tY8In3Xq8tm6J8QT58UCPhccCS/4vAto2yQK8s/ds
X-Gm-Message-State: AOJu0YxGpCcXGJmjdXQb0+l2R6X8siHmLJyllMvG9xJ+oliBt1R+ezFK
	f59l69Q/qohpIs0IBXgrEHq9ZG2MYjBBu0k1VISMtX7+Mdjrz7HOrmR0NnZ7ZOM=
X-Google-Smtp-Source: AGHT+IFSK6/D0rOzagy1/zSJBKXLz+q6H8hsvY0xHkJQFgJf4c4zq09MFV+GiamERIj//Ok+kaM7Lw==
X-Received: by 2002:a05:6808:209f:b0:3c5:f5c3:1c5c with SMTP id s31-20020a056808209f00b003c5f5c31c5cmr1851283oiw.27.1712559511628;
        Sun, 07 Apr 2024 23:58:31 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id a4-20020aa78644000000b006ea8c030c1esm5733082pfo.211.2024.04.07.23.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:58:31 -0700 (PDT)
Message-ID: <9cce197b-bbdc-4003-898e-11d736497c1d@gmail.com>
Date: Mon, 8 Apr 2024 14:58:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] mm/ksm: use folio in write_protect_page
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Matthew Wilcox <willy@infradead.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryncsn@gmail.com
Cc: Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>
References: <20240325124904.398913-1-alexs@kernel.org>
 <20240325124904.398913-8-alexs@kernel.org>
 <e16806b0-7c17-4356-8b47-30f624756e85@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <e16806b0-7c17-4356-8b47-30f624756e85@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/5/24 3:23 PM, David Hildenbrand wrote:
> On 25.03.24 13:48, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> Compound page is checked and skipped before write_protect_page() called,
>> use folio to save a few compound_head checking.
>>
>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Chris Wright <chrisw@sous-sol.org>
>> ---
>>   mm/ksm.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 95a487a21eed..5d1f62e7462a 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -1289,22 +1289,22 @@ static u32 calc_checksum(struct page *page)
>>       return checksum;
>>   }
>>   -static int write_protect_page(struct vm_area_struct *vma, struct page *page,
>> +static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
>>                     pte_t *orig_pte)
>>   {
>>       struct mm_struct *mm = vma->vm_mm;
>> -    DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, 0);
>> +    DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
>>       int swapped;
>>       int err = -EFAULT;
>>       struct mmu_notifier_range range;
>>       bool anon_exclusive;
>>       pte_t entry;
>>   -    pvmw.address = page_address_in_vma(page, vma);
>> +    pvmw.address = page_address_in_vma(&folio->page, vma);
>>       if (pvmw.address == -EFAULT)
>>           goto out;
>>   -    BUG_ON(PageTransCompound(page));
>> +    VM_BUG_ON(folio_test_large(folio));
> 
> I suggest
> 
> if (WARN_ON_ONCE(folio_test_large(folio)))
>     return err;
> 
> before the page_address_in_vma() call.
> 

Thanks for the suggestion, will take it.

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

