Return-Path: <linux-kernel+bounces-120619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE1C88DA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09F41C24A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DEF38388;
	Wed, 27 Mar 2024 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cp358ZKJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0E36E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532079; cv=none; b=paFUSZFovf4RJZ54kvhlCjq9ySrOylYEvpymS+mqn6IQaP0jW/YxXszUQPYmNtGNcl/Huo/9uFIuX69EenYhK2R8GybZY4+Lua5FMQFhpyyEfElkKutHIPCMzvUeV4Ab8eZlojId7ViVTpjqSzqMQBT++qvBFshJ99lNph7Gqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532079; c=relaxed/simple;
	bh=HcmhtMgYSlf6Q3MiMQ4w/5ZvKlNyG1b/Ya0NC6A0CJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqbQQkpEeLr9RsKAapLeSfAuhp4Ws+Ac7f1omAi1zX+UYPiomTiy3SBfxOq7ZHMn765hPp+NChqiT15vQ3Pa2JpBrwUjnDNM6XjAUOl7J7rM5ApdB9JlQ29mYLr5b35OLUVN2PgABRbk1QLltEIsBrtNqF/W8h0HI/DkVtMdgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cp358ZKJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711532076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9LLuogmZBw7/u037QPSgxeXpKZR87NTC4TIrWGd7J2U=;
	b=Cp358ZKJ71s5jeO+X/CAZudW51ORxzeZizCWC4LpXxY22/8QZaKEuM6pRd0zN4dBwkuZbl
	Sx+CW6vlU/2YCtGCG2N3gRzCq8NoohewhfD1cIc5Uo4PFqPV1/YxVBvi+NZhcyn0LaW1aD
	s+pTY0wKBptC1CBbTn2HTKa2C4KAWv4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-tqmqlEZWMKWwqO5uu2bbvg-1; Wed, 27 Mar 2024 05:34:34 -0400
X-MC-Unique: tqmqlEZWMKWwqO5uu2bbvg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d6ef704b35so12429351fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711532073; x=1712136873;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LLuogmZBw7/u037QPSgxeXpKZR87NTC4TIrWGd7J2U=;
        b=nQY4H1GlH9LLWJ9jTqv9L5Ufh3QzOKxbb/iSt3whoB6mnx6Lp5w8l/ElwYOV5CvtO5
         CUPFXwduC4Xqg5Fgm3McVCyTMQ9q/PzHQ412m2afjtSIoCRdPL9izw/pgLMZ/tQ63kY6
         i1ksMW9dHfw0RwA52VeJsXw6am/2atAFzLl2urBF9xGCwjpjF0tMNtafA3Xq0Jdh+YLp
         J/EJ/952tDlbppaFnP0VCGxeS3UAfr+WiKwm7JzHlZWLuVgusbZ58zXeWSGRWQLn+bSD
         0voNfiQOL1WGNc5CnV6JNpZijHfC4h9dtMtGvWE/Yf7f7IjPJ9rkj/AxNhuBaED60k9c
         rJXA==
X-Forwarded-Encrypted: i=1; AJvYcCUSNeCCTdD+k8/upNGlawh32tMfrS+FA2Du2ZeyBAhVlLIEBD3kInzYEHNfVbQLkdROEDVkPnGQ7HsqceHNhs9Y+VuX9MsT+UKL2SQX
X-Gm-Message-State: AOJu0YzDsI4rwZSHo3r6nvfEiS4s0D72NU5npDesF1kMIpK8tuagRg0u
	2Hi1JygiVprjGJR3QY7Imbg6VkzU0UlTLC37h0bE+hkYfyEbhVCo7eeI+5qkAcW2fnb2mFKPvwF
	X5/LKmIDMyoxJ1MINTEjFpX2Fo6Tn4cpLYTO0xJNceVCMDBaCfgzyydhsUk1Uuv/l9P38iw==
X-Received: by 2002:a2e:b05a:0:b0:2d4:a35c:3e5f with SMTP id d26-20020a2eb05a000000b002d4a35c3e5fmr2444948ljl.30.1711532072780;
        Wed, 27 Mar 2024 02:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMk2yHnXyNzj6c2qzpk/qO6ETWFT46sQBoOR5+HdB9TfU71Sw3ijy16j/SBsZVsmvZ0vpf+g==
X-Received: by 2002:a2e:b05a:0:b0:2d4:a35c:3e5f with SMTP id d26-20020a2eb05a000000b002d4a35c3e5fmr2444925ljl.30.1711532072207;
        Wed, 27 Mar 2024 02:34:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b004146c769c79sm1611093wms.0.2024.03.27.02.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 02:34:31 -0700 (PDT)
Message-ID: <35236bbf-3d9a-40e9-84b5-e10e10295c0c@redhat.com>
Date: Wed, 27 Mar 2024 10:34:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
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
 <0ae22147-e1a1-4bcb-8a4c-f900f3f8c39e@redhat.com>
 <d8b3bcf2-495f-42bd-b114-6e3a010644d8@arm.com>
 <de143212-49ce-4c30-8bfa-4c0ff613f107@redhat.com>
 <374d8500-4625-4bff-a934-77b5f34cf2ec@arm.com>
 <c1218cdb-905b-4896-8e17-109700577cec@redhat.com>
 <a41b0534-b841-42c2-8c06-41337c35347d@arm.com>
 <8bd9e136-8575-4c40-bae2-9b015d823916@redhat.com>
 <86680856-2532-495b-951a-ea7b2b93872f@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <86680856-2532-495b-951a-ea7b2b93872f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.03.24 18:51, Ryan Roberts wrote:
> On 26/03/2024 17:39, David Hildenbrand wrote:
>> On 26.03.24 18:32, Ryan Roberts wrote:
>>> On 26/03/2024 17:04, David Hildenbrand wrote:
>>>>>>>>
>>>>>>>> Likely, we just want to read "the real deal" on both sides of the pte_same()
>>>>>>>> handling.
>>>>>>>
>>>>>>> Sorry I'm not sure I understand? You mean read the full pte including
>>>>>>> access/dirty? That's the same as dropping the patch, right? Of course if
>>>>>>> we do
>>>>>>> that, we still have to keep pte_get_lockless() around for this case. In an
>>>>>>> ideal
>>>>>>> world we would convert everything over to ptep_get_lockless_norecency() and
>>>>>>> delete ptep_get_lockless() to remove the ugliness from arm64.
>>>>>>
>>>>>> Yes, agreed. Patch #3 does not look too crazy and it wouldn't really affect
>>>>>> any
>>>>>> architecture.
>>>>>>
>>>>>> I do wonder if pte_same_norecency() should be defined per architecture and the
>>>>>> default would be pte_same(). So we could avoid the mkold etc on all other
>>>>>> architectures.
>>>>>
>>>>> Wouldn't that break it's semantics? The "norecency" of
>>>>> ptep_get_lockless_norecency() means "recency information in the returned pte
>>>>> may
>>>>> be incorrect". But the "norecency" of pte_same_norecency() means "ignore the
>>>>> access and dirty bits when you do the comparison".
>>>>
>>>> My idea was that ptep_get_lockless_norecency() would return the actual result on
>>>> these architectures. So e.g., on x86, there would be no actual change in
>>>> generated code.
>>>
>>> I think this is a bad plan... You'll end up with subtle differences between
>>> architectures.
>>>
>>>>
>>>> But yes, the documentation of these functions would have to be improved.
>>>>
>>>> Now I wonder if ptep_get_lockless_norecency() should actively clear
>>>> dirty/accessed bits to more easily find any actual issues where the bits still
>>>> matter ...
>>>
>>> I did a version that took that approach. Decided it was not as good as this way
>>> though. Now for the life of me, I can't remember my reasoning.
>>
>> Maybe because there are some code paths that check accessed/dirty without
>> "correctness" implications? For example, if the PTE is already dirty, no need to
>> set it dirty etc?
> 
> I think I decided I was penalizing the architectures that don't care because all
> their ptep_get_norecency() and ptep_get_lockless_norecency() need to explicitly
> clear access/dirty. And I would have needed ptep_get_norecency() from day 1 so
> that I could feed its result into pte_same().

True. With ptep_get_norecency() you're also penalizing other 
architectures. Therefore my original thought about making the behavior 
arch-specific, but the arch has to make sure to get the combination of 
ptep_get_lockless_norecency()+ptep_same_norecency() is right.

So if an arch decide to ignore bits in ptep_get_lockless_norecency(), it 
must make sure to also ignore them in ptep_same_norecency(), and must be 
able to handle access/dirty bit changes differently.

Maybe one could have one variant for "hw-managed access/dirty" vs. "sw 
managed accessed or dirty". Only the former would end up ignoring stuff 
here, the latter would not.

But again, just some random thoughts how this affects other 
architectures and how we could avoid it. The issue I describe in patch 
#3 would be gone if ptep_same_norecency() would just do a ptep_same() 
check on other architectures -- and would make it easier to sell :)

-- 
Cheers,

David / dhildenb


