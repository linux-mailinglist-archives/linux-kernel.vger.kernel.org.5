Return-Path: <linux-kernel+bounces-135053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25189BA6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C461F22C88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0863BBDB;
	Mon,  8 Apr 2024 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FN2Ndxdx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65ED3BB3D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565388; cv=none; b=jVxC6PW37OUOLqcigpCWGM9eeXCn0b+0uU5jit/Ouh3gyaaET28goOCmfY4ydEv8/+YOobbn8MwSXzV3gbkacL44AM6LVUuCtxchoe+8OanpuH0UWJ5fldtovkFKngIg0TWVpiRrvutmgPEFPeep95U4ZfcuAUkG2WjRqkvbrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565388; c=relaxed/simple;
	bh=0avSstRAweWmkFgZTXypsMULAb7CGsaqEoxgj4UKmYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEBkPiRtBdnTQxKp6cnRahQbnGqWYJRjjVCEIbadIH5oK4OgGGcKTCz0NJJPbeexuAu3S/qnP7UGTd6Irj2wWP9BarvtiP85UnlrF/dCNCwO1LbjdjgPVtatmjCEDZ8Foq6JngP+GcGcgJu0BpvOai7fJRBjvLsOVdZDhQsrss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FN2Ndxdx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JWCyBqXSOrlIAdyizfHRPZAsjfer/rBsGaiHFl8omqI=;
	b=FN2NdxdxtxQVLAlYyvFHVj90QOErEcWhHjhsht/QsnYwq4uzxENm5BDGFeOA6CBQJpM0lu
	QowUa8Hc1BrlSOV98Umgx02U/eeNVKCFvcxSt4+sF24wNKty09inTC7S+Iga+2ixw7Z2yn
	UhkWBuPLeg6+Ob1jL8GpWieu6pVuqfk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-0Sxz-QrIMrqHtUvT3YEDtw-1; Mon, 08 Apr 2024 04:36:23 -0400
X-MC-Unique: 0Sxz-QrIMrqHtUvT3YEDtw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41489c04f8cso21050315e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565382; x=1713170182;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JWCyBqXSOrlIAdyizfHRPZAsjfer/rBsGaiHFl8omqI=;
        b=FgF5nwTP1Z9DPs5YKOqk9dI+K9cGzjB48oe5+4cKsHkz3EgquY9I/yeis83q/ak6mh
         Cn4p0VMthQdZ/au3YaqOgdZuFfdbwQ4chIDWOlpPFoo3yQZzNh3+bRZVKOXJsHHBMsxQ
         CNortUX+r6mdzvR5RLo42DdpD1tVFyb7VHfgq5OFLaMa7v6Px/C3G8KbsFaz7Oc+WZOd
         40Hk8EaAqt/5LuBg95L3l+6NqXEXzKLUf5OTBlk4aFhiPOQXSlxyHyd0ZTI/RgSn0kaV
         +huUN+KWuXihMWDsg1m4r5bS7qJiiufHbqzhMfVz7L+jEASV/UsdI8Y0q7zXI5IgnTzI
         H0cg==
X-Forwarded-Encrypted: i=1; AJvYcCUe6MzhvYHJw7faYcbRc21UES3V8filadxNrdcx1vHljV4YueRcaf2yK27nwRAQB3s61dnlW4sxKt2fa/q5HktiPaSi4taikR8xvzxD
X-Gm-Message-State: AOJu0YzXbEUFO2gJdEex3aIA7rOXNeE76IraELtT4/JIqVMzOuT/QYXp
	ibX6v/LdTCTPQNXpqRqn9FZC+2JH3MPX7BkISRVQ26hNK8MNFdoaYsEKx1UVuLssAINjDGtEaHF
	2C4CYcWnKMJ8JD1x72ohWepyZDB2ouDgs/zdnifTaus8C5TTOSoBtHQUaI1wd1Q==
X-Received: by 2002:a05:600c:5106:b0:414:63c2:23cc with SMTP id o6-20020a05600c510600b0041463c223ccmr7454334wms.2.1712565382608;
        Mon, 08 Apr 2024 01:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdOMw2EkAcjI9pppz0RUaGuUBEY24aFMFQ1T/VIY1IPJwT9ro5682HvMiT5fcZh5LzRE5KNw==
X-Received: by 2002:a05:600c:5106:b0:414:63c2:23cc with SMTP id o6-20020a05600c510600b0041463c223ccmr7454316wms.2.1712565382195;
        Mon, 08 Apr 2024 01:36:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c46d200b00414659ba8c2sm12643588wmo.37.2024.04.08.01.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 01:36:21 -0700 (PDT)
Message-ID: <f2aad459-e19c-45e2-a7ab-35383e8c3ba5@redhat.com>
Date: Mon, 8 Apr 2024 10:36:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
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
 <0ae22147-e1a1-4bcb-8a4c-f900f3f8c39e@redhat.com>
 <d8b3bcf2-495f-42bd-b114-6e3a010644d8@arm.com>
 <de143212-49ce-4c30-8bfa-4c0ff613f107@redhat.com>
 <374d8500-4625-4bff-a934-77b5f34cf2ec@arm.com>
 <c1218cdb-905b-4896-8e17-109700577cec@redhat.com>
 <a41b0534-b841-42c2-8c06-41337c35347d@arm.com>
 <8bd9e136-8575-4c40-bae2-9b015d823916@redhat.com>
 <86680856-2532-495b-951a-ea7b2b93872f@arm.com>
 <35236bbf-3d9a-40e9-84b5-e10e10295c0c@redhat.com>
 <dbc5083b-bf8c-4869-8dc7-5fbf2c88cce8@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dbc5083b-bf8c-4869-8dc7-5fbf2c88cce8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 14:59, Ryan Roberts wrote:
> On 27/03/2024 09:34, David Hildenbrand wrote:
>> On 26.03.24 18:51, Ryan Roberts wrote:
>>> On 26/03/2024 17:39, David Hildenbrand wrote:
>>>> On 26.03.24 18:32, Ryan Roberts wrote:
>>>>> On 26/03/2024 17:04, David Hildenbrand wrote:
>>>>>>>>>>
>>>>>>>>>> Likely, we just want to read "the real deal" on both sides of the
>>>>>>>>>> pte_same()
>>>>>>>>>> handling.
>>>>>>>>>
>>>>>>>>> Sorry I'm not sure I understand? You mean read the full pte including
>>>>>>>>> access/dirty? That's the same as dropping the patch, right? Of course if
>>>>>>>>> we do
>>>>>>>>> that, we still have to keep pte_get_lockless() around for this case. In an
>>>>>>>>> ideal
>>>>>>>>> world we would convert everything over to ptep_get_lockless_norecency() and
>>>>>>>>> delete ptep_get_lockless() to remove the ugliness from arm64.
>>>>>>>>
>>>>>>>> Yes, agreed. Patch #3 does not look too crazy and it wouldn't really affect
>>>>>>>> any
>>>>>>>> architecture.
>>>>>>>>
>>>>>>>> I do wonder if pte_same_norecency() should be defined per architecture
>>>>>>>> and the
>>>>>>>> default would be pte_same(). So we could avoid the mkold etc on all other
>>>>>>>> architectures.
>>>>>>>
>>>>>>> Wouldn't that break it's semantics? The "norecency" of
>>>>>>> ptep_get_lockless_norecency() means "recency information in the returned pte
>>>>>>> may
>>>>>>> be incorrect". But the "norecency" of pte_same_norecency() means "ignore the
>>>>>>> access and dirty bits when you do the comparison".
>>>>>>
>>>>>> My idea was that ptep_get_lockless_norecency() would return the actual
>>>>>> result on
>>>>>> these architectures. So e.g., on x86, there would be no actual change in
>>>>>> generated code.
>>>>>
>>>>> I think this is a bad plan... You'll end up with subtle differences between
>>>>> architectures.
>>>>>
>>>>>>
>>>>>> But yes, the documentation of these functions would have to be improved.
>>>>>>
>>>>>> Now I wonder if ptep_get_lockless_norecency() should actively clear
>>>>>> dirty/accessed bits to more easily find any actual issues where the bits still
>>>>>> matter ...
>>>>>
>>>>> I did a version that took that approach. Decided it was not as good as this way
>>>>> though. Now for the life of me, I can't remember my reasoning.
>>>>
>>>> Maybe because there are some code paths that check accessed/dirty without
>>>> "correctness" implications? For example, if the PTE is already dirty, no need to
>>>> set it dirty etc?
>>>
>>> I think I decided I was penalizing the architectures that don't care because all
>>> their ptep_get_norecency() and ptep_get_lockless_norecency() need to explicitly
>>> clear access/dirty. And I would have needed ptep_get_norecency() from day 1 so
>>> that I could feed its result into pte_same().
>>
>> True. With ptep_get_norecency() you're also penalizing other architectures.
>> Therefore my original thought about making the behavior arch-specific, but the
>> arch has to make sure to get the combination of
>> ptep_get_lockless_norecency()+ptep_same_norecency() is right.
>>
>> So if an arch decide to ignore bits in ptep_get_lockless_norecency(), it must
>> make sure to also ignore them in ptep_same_norecency(), and must be able to
>> handle access/dirty bit changes differently.
>>
>> Maybe one could have one variant for "hw-managed access/dirty" vs. "sw managed
>> accessed or dirty". Only the former would end up ignoring stuff here, the latter
>> would not.
>>
>> But again, just some random thoughts how this affects other architectures and
>> how we could avoid it. The issue I describe in patch #3 would be gone if
>> ptep_same_norecency() would just do a ptep_same() check on other architectures
>> -- and would make it easier to sell :)
>>
> 
> I've been thinking some more about this. I think your proposal is the following:
> 
> 
> // ARM64
> ptep_get_lockless_norecency()
> {
> 	- returned access/dirty may be incorrect
> 	- returned access/dirty may be differently incorrect between 2 calls
> }
> pte_same_norecency()
> {
> 	- ignore access/dirty when doing comparison
> }
> ptep_set_access_flags(ptep, pte)
> {
> 	- must not assume access/dirty in pte are "more permissive" than
> 	  access/dirty in *ptep
> 	- must only set access/dirty in *ptep, never clear
> }
> 
> 
> // Other arches: no change to generated code
> ptep_get_lockless_norecency()
> {
> 	return ptep_get_lockless();
> }
> pte_same_norecency()
> {
> 	return pte_same();
> }
> ptep_set_access_flags(ptep, pte)
> {
> 	- may assume access/dirty in pte are "more permissive" than access/dirty
> 	  in *ptep
> 	- if no HW access/dirty updates, "*ptep = pte" always results in "more
> 	  permissive" change
> }
> 
> An arch either specializes all 3 or none of them.
> 
> This would allow us to get rid of ptep_get_lockless().
> 
> And it addresses the bug you found with ptep_set_access_flags().
> 
> 
> BUT, I still have a nagging feeling that there are likely to be other similar
> problems caused by ignoring access/dirty during pte_same_norecency(). I can't
> convince myself that its definitely all safe and robust.

Right, we'd have to identify the other possible cases and document what 
an arch + common code must stick to to make it work.

Some rules would be: if an arch implements ptep_get_lockless_norecency():

(1) Passing the result from ptep_get_lockless_norecency() to pte_same()
     is wrong.
(2) Checking pte_young()/pte_old/pte_dirty()/pte_clean() after
     ptep_get_lockless_norecency() is very likely wrong.


> 
> So I'm leaning towards dropping patch 3 and therefore keeping
> ptep_get_lockless() around.
> 
> Let me know if you have any insight that might help me change my mind :)

I'm wondering if it would help if we could find a better name (or 
concept) for "norecency" here, that expresses that only on some archs 
we'd have that fuzzy handling.

Keeping ptep_get_lockless() around for now sounds like the best alternative.

-- 
Cheers,

David / dhildenb


