Return-Path: <linux-kernel+bounces-121663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE488EC13
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC62B26B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F614D71C;
	Wed, 27 Mar 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivoiOLjP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F814D2B7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558957; cv=none; b=WgkDhQQJBiuj1LHILXzYKwO2s54fFl5YUGzwLZNsPzk8pJ3lf8cM3fbotqMYdvmzXYkXVz+mz0vVRtzAT0pnB8ulb3OIhl5nkHmVgSUbRi3QHuXdIew9CdJ0IjJoOb2RB8vtgdYHGs0xRNnNK6Hnh1LxlQcNMclVYu5NgJhSdz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558957; c=relaxed/simple;
	bh=wQlGuhP5TRAaC5RVCtGq3bUw9CjzgjNWBMs2lRaKSEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLdrxoKyoheXCva5uZgdoHhZMHe9uBXbvJ00iX7vkstqFWdbaRHXxAHa6BTb8jjDiDQ1OF2sa3HFZJBQzjD8Hj6cdso33PtqIvwoa4TpgwgwDhqMtJWfA+PnGunOjCfV9gnegOVH7w2SuLYVr4Dg7dFwc4Jr3H8GWafYKhhWsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivoiOLjP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711558955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uskMpTPHIkGSyW3/MxPwplkNedupZUv6Qk2XABgIKf4=;
	b=ivoiOLjP2X++C/ZIbEnOe66TDevATd6aSF/Qotwwx1wlXW6zESWz1uIXFHngUREkUZ1TCo
	nK4qoTTwdJFoX/kCez6/KJrnN4JVa2zkSQqMyShGF2Tn0CG0MNCvjF1QkWo1vK7gICeRL3
	9ARiL3X4Sb7bxLnoPUWa58NeN5YkLy8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-d-q3u9OlMJq4onTRTAVDgA-1; Wed, 27 Mar 2024 13:02:32 -0400
X-MC-Unique: d-q3u9OlMJq4onTRTAVDgA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-414ae9b8c04so102995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558951; x=1712163751;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uskMpTPHIkGSyW3/MxPwplkNedupZUv6Qk2XABgIKf4=;
        b=hjDV51+4PtgxEgQyzDamCIaD0ksirFir2BJOk1s8oUjrTrIJgYmP2HEwIJPpD1SUUg
         fjdkccxz7Ry/cBnag6sntPNDzFC/vjFI/l3JQ7g8JwwqnBvspDtwroJWtItwsJN5KLoJ
         IP64TRkaaOYjNsb3Q7tzOW/2Kk7IG1iIBbVtjlQF95eaoYIXkI/x9ird1NxsjJnm6ssL
         nFeZ7liPhoJSMv+5i3W1quaa9a9aUxEMXMSU98TLXTLtVc9apQ46GLqlEDQET5DukPuV
         oB0e1+t12dkWyHcSZn/ymzan+xV+7NT6R7B5L4d5wc++/DtSJOtyCxzm+98MYusWNvhN
         H4/g==
X-Forwarded-Encrypted: i=1; AJvYcCU1j9HukEuYgkVz2o+ESbobgpuxfSOh9apmjetv/HE53wn0bRv9EsCFG/tntUx6U5CrYIcNI4FoYD5kvQEXA2rmc7XfEVBfINXU2P+D
X-Gm-Message-State: AOJu0Yw5+tHbr6Zg5c2+vtragPdFW8wCteWKETy+wwsHoEiODYinFrWe
	6vu19syTZ9SpYDyPvoUDgY8sv7V67Np/lmVCsieXZilD3A35LbI8N7HumWRoWCmR0DgkRMdMJM1
	dKkzRF4unG6HwGWtia71q1tF/sbXqHTSI6iHtEcBMz+OSWwd3MCrtW5sG1nNZTg==
X-Received: by 2002:a05:600c:a08:b0:414:392:38d2 with SMTP id z8-20020a05600c0a0800b00414039238d2mr506241wmp.24.1711558951576;
        Wed, 27 Mar 2024 10:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVsFdc9/fJokKxX0lmRSMLmfPW2D/yYxD+1/VRmGLC5t31bxpeLhyOh2tC8NgH8ooQ3gsCjA==
X-Received: by 2002:a05:600c:a08:b0:414:392:38d2 with SMTP id z8-20020a05600c0a0800b00414039238d2mr506213wmp.24.1711558951110;
        Wed, 27 Mar 2024 10:02:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0041488cfd0fesm2696526wmo.28.2024.03.27.10.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 10:02:30 -0700 (PDT)
Message-ID: <6076ac95-b6c6-464c-8af0-6d5ab2d1a331@redhat.com>
Date: Wed, 27 Mar 2024 18:02:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] mm: Introduce ptep_get_lockless_norecency()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
 <20240215121756.2734131-2-ryan.roberts@arm.com>
 <7aefa967-43aa-490b-ae0d-7d1455402e89@redhat.com>
 <5c8dbda1-5b89-4599-9bc2-f840e7bc6a74@arm.com>
 <6777213f-6273-4942-86be-e712ee5ebd1a@redhat.com>
 <31b903f8-99dd-4790-8338-f4b9950b1ee6@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <31b903f8-99dd-4790-8338-f4b9950b1ee6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>>
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 68283e54c899..41dc44eb8454 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -7517,7 +7517,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct
>>>>> vm_area_struct *vma,
>>>>>         }
>>>>>
>>>>>         if (pte) {
>>>>> -        pte_t pteval = ptep_get_lockless(pte);
>>>>> +        pte_t pteval = ptep_get_lockless_norecency(pte);
>>>>>
>>>>>             BUG_ON(pte_present(pteval) && !pte_huge(pteval));
>>>>>         }
>>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>>> index 2771fc043b3b..1a6c9ed8237a 100644
>>>>> --- a/mm/khugepaged.c
>>>>> +++ b/mm/khugepaged.c
>>>>> @@ -1019,7 +1019,7 @@ static int __collapse_huge_page_swapin(struct mm_struct
>>>>> *mm,
>>>>>                 }
>>>>>             }
>>>>>
>>>>> -        vmf.orig_pte = ptep_get_lockless(pte);
>>>>> +        vmf.orig_pte = ptep_get_lockless_norecency(pte);
>>>>>             if (!is_swap_pte(vmf.orig_pte))
>>>>>                 continue;
>>>>
>>>>
>>>> Hm, I think you mentioned that we want to be careful with vmf.orig_pte.
>>>
>>> Yeah good point. So I guess this should move to patch 3 (which may be dropped -
>>> tbd)?
>>>
>>
>> Yes. Or a separate one where you explain in detail why do_swap_page() can handle
>> it just fine.
> 
> Ahh no wait - I remember now; the reason I believe this is a "trivial" case is
> because we only leak vmf.orig_pte to the rest of the world if its a swap entry.

Ugh, yes!

-- 
Cheers,

David / dhildenb


