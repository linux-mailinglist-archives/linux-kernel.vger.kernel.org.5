Return-Path: <linux-kernel+bounces-121665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8E88EC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A24329FCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7814D70B;
	Wed, 27 Mar 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpCYXb0d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04E14D2B7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559160; cv=none; b=tJL5ve7xHMzVzNrL7989idkCNRZGPERMvWWH96ZvFX4ITsXhWO4BmdVogv6mCHnHKfWW1/A2fQ0iVd1CZ7kboEXHAm2Kww7vc0o/5+y4VFEDU0mVLpnpjlaFA5f9+LtmlEr+xP8IGNr2NscrIscv21jDAvWlYY4SPG6btCWzr08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559160; c=relaxed/simple;
	bh=pmE/WNsN48zINl0lqmAAtZNwjI8ndKJP9+bm1YuX6p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvhwxOz77t0IuYMhu9uGndN6prAh+/En4A7tkCJZCrHw9RmGJADEfl4z7Elwros5Dw3Dyx635mPdJ8vPFQGBZ79/gdWQCHfOc+EquEXHE81AVBAJaBBsYIiTqgzhdYyOGjSoWCLR8DWF9P6T5LKaujDpWzMrs1hHO/U8EHC2wug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpCYXb0d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711559157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9PPCx7i0tEizVRzpeoi4x1mQBKJiyNyYCbcOnRkQ3J4=;
	b=TpCYXb0dlRJea51ilRHQWojv/GEMO4fY/KX1zdR4ciOBzw1CmSzFO+yQP7r8kI4p3YfVnw
	VggsXOCGEmdvvRR7lxFexyZF56BkGlIZZAaC8W2vG/gcUam9GjTaACxAq25NOydl6Jy6hA
	hakolJdj67BBkfOtRwq8Y2MIZzml3XA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-mosBsRfXPPKZwrVOz6jeVw-1; Wed, 27 Mar 2024 13:05:55 -0400
X-MC-Unique: mosBsRfXPPKZwrVOz6jeVw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41489c04e3aso135945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711559154; x=1712163954;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PPCx7i0tEizVRzpeoi4x1mQBKJiyNyYCbcOnRkQ3J4=;
        b=STien+3s+Idh/1BiXf5zIf9t+h+c4ADQN/yF4uIHD2ieT1T1Si97Nje2q7LpKid9F/
         3o0hPTJSC9jCiJGX8HYxMbLrMwzN5IoQFLq97dTpetD+1PhXI813gqNpMBA6hmd6ypt9
         TUv3G5t7CawvBaapn4fQ0sUYUB3aDz93Vtk8tAYz+7tJJrAuopVnSyTYSzfM51wcedOh
         IO8W5Z/Ir0LKaWcjdvh6dGG+itp+Fsbd2HEHpRA1iNM5ozTLI/TP+s2/vOmLgLhcGBD0
         xWM1kyPJ8IQyMs8JzSKLuiKtaWr2dXVTYzEXV+yRe5vvvERwyZC7deMv9HWjt0wJMSAy
         GG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrL0G1UhrDi13KF0rw3fBEVd7+XbOrlDF7To4WSmmvPSFG/nxFBZnS6veH3RQ6BYJodHzs7lg47UlKugWO0B67jOXXxd5bAKNwo6S7
X-Gm-Message-State: AOJu0YypFteRN+0veV+15QBPt880R4FWwzSa+ZxO7yGXGh3aAR7tssoS
	8qA+BkBt4XqE+xPicwBS0CNBPjfgWvUt4UTFlu78AxpeFA/MaWnLMhCfdYjlM7n25IfU7M0Iy+p
	kQXj17W1wjEyUWIdVkUF58qlHXIwDx8L+xeMcjL30OVy7jVbwImTmz8WNrOrdow==
X-Received: by 2002:a05:600c:4189:b0:414:ae9b:7d71 with SMTP id p9-20020a05600c418900b00414ae9b7d71mr390756wmh.27.1711559154608;
        Wed, 27 Mar 2024 10:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1MYeye6OtJGkBoUbsdHFp6CS9XMloRwCD6aQ0fv/2bpw5rMyIIj/MqLk156Q9dYs1oZdtYg==
X-Received: by 2002:a05:600c:4189:b0:414:ae9b:7d71 with SMTP id p9-20020a05600c418900b00414ae9b7d71mr390729wmh.27.1711559154193;
        Wed, 27 Mar 2024 10:05:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b004146a304863sm2703001wms.34.2024.03.27.10.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 10:05:53 -0700 (PDT)
Message-ID: <44fc26ae-de7d-4bed-af7b-bcd2c593c676@redhat.com>
Date: Wed, 27 Mar 2024 18:05:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] mm/memory: Use ptep_get_lockless_norecency()
 for orig_pte
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
 <20240215121756.2734131-4-ryan.roberts@arm.com>
 <e0bdbd5e-a098-422a-90af-9cf07ce378a4@redhat.com>
 <febd0c97-8869-4ce5-bd37-cbbdf5be0a43@arm.com>
 <f6996c4f-da60-4267-bcf1-09e4fd40c91b@redhat.com>
 <fb101fd1-e28a-4278-bf5f-e2dca0215a90@arm.com>
 <6aaff470-c510-469b-8f4f-2e4c5cf07d56@redhat.com>
 <de03fcd0-53fe-4672-b148-7a5eda19be03@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <de03fcd0-53fe-4672-b148-7a5eda19be03@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.03.24 10:51, Ryan Roberts wrote:
> On 26/03/2024 17:58, David Hildenbrand wrote:
>>>>>>
>>>>>> vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte)
>>>>>> /* not dirty */
>>>>>>
>>>>>> /* Now, thread 2 ends up setting the PTE dirty under PT lock. */
>>>
>>> Ahh, this comment about thread 2 is not referring to the code immediately below
>>> it. It all makes much more sense now. :)
>>
>> Sorry :)
>>
>>>
>>>>>>
>>>>>> spin_lock(vmf->ptl);
>>>>>> entry = vmf->orig_pte;
>>>>>> if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
>>>>>>        ...
>>>>>> }
>>>>>> ...
>>>>>> entry = pte_mkyoung(entry);
>>>>>
>>>>> Do you mean pte_mkdirty() here? You're talking about dirty everywhere else.
>>>>
>>>> No, that is just thread 1 seeing "oh, nothing to do" and then goes ahead and
>>>> unconditionally does that in handle_pte_fault().
>>>>
>>>>>
>>>>>> if (ptep_set_access_flags(vmf->vma, ...)
>>>>>> ...
>>>>>> pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>>
>>>>>>
>>>>>> Generic ptep_set_access_flags() will do another pte_same() check and realize
>>>>>> "hey, there was a change!" let's update the PTE!
>>>>>>
>>>>>> set_pte_at(vma->vm_mm, address, ptep, entry);
>>>>>
>>>>> This is called from the generic ptep_set_access_flags() in your example, right?
>>>>>
>>>>
>>>> Yes.
>>>>
>>>>>>
>>>>>> would overwrite the dirty bit set by thread 2.
>>>>>
>>>>> I'm not really sure what you are getting at... Is your concern that there is a
>>>>> race where the page could become dirty in the meantime and it now gets lost? I
>>>>> think that's why arm64 overrides ptep_set_access_flags(); since the hw can
>>>>> update access/dirty we have to deal with the races.
>>>>
>>>> My concern is that your patch can in subtle ways lead to use losing PTE dirty
>>>> bits on architectures that don't have the HW-managed dirty bit. They do exist ;)
>>>
>>> But I think the example you give can already happen today? Thread 1 reads
>>> orig_pte = ptep_get_lockless(). So that's already racy, if thread 2 is going to
>>> set dirty just after the get, then thread 1 is going to set the PTE back to (a
>>> modified version of) orig_pte. Isn't it already broken?
>>
>> No, because the pte_same() check under PTL would have detected it, and we would
>> have backed out. And I think the problem comes to live when we convert
>> pte_same()->pte_same_norecency(), because we fail to protect PTE access/dirty
>> changes that happend under PTL from another thread.
> 
> Ahh yep. Got it. I absolutely knew that you would be correct, but I still walked
> right into it!
> 
> I think one could argue that the generic ptep_set_access_flags() is not
> implementing its own spec:
> 
> "
> ... Only sets the access flags (dirty, accessed), as well as write permission.
> Furthermore, we know it always gets set to a "more permissive" setting ...
> "
> 
> Surely it should be folding the access and dirty bits from *ptep into entry if
> they are set?

Likely yes. Unless it's also used to clear access/dirty (don't think so, 
and would not be documented).

But the simplification made sense for now, because you previously 
checked that pte_same(), and nobody can modify it concurrently.

> 
> Regardless, I think this example proves that its fragile and subtle. I'm not
> really sure how to fix it more generally/robustly. Any thoughts? If not perhaps
> we are better off keeping ptep_get_lockless() around and only using
> ptep_get_lockless_norecency() for the really obviously correct cases?

Maybe one of the "sources of problems" is that we have a 
ptep_get_lockless_norecency() call followed by a pte_same() check, like 
done here.

Not the source of all problems I believe, though ...

-- 
Cheers,

David / dhildenb


