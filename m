Return-Path: <linux-kernel+bounces-154849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5966C8AE1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68346B21953
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21D60EC3;
	Tue, 23 Apr 2024 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZ2Ot5V4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA95914C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867531; cv=none; b=E8BRToVSbiJCZb1tCc9UgBzW9T0Xp1RDNVrlynG9Yx768xwfFNmFrJKBpEAbUxIPg0hjbx1bwx+aA0OFx4Gp7txaRddCC9uxrD391d+jyHSUrSHGnnS9rm9GfAT/LhoLk/BM0opSvnp+oJZ121l3CKPVX+3OYaaKaYjiDbz7ZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867531; c=relaxed/simple;
	bh=vVn0l0+XVR6/P/DAbg3T9H6FzbpsIzVCAA3qIfTWO8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFe9BD8+Sb0VoxyOK6mTwmakJLYTrVe2c5QP4gzh9Q9lPmOcgx1Ng1NuWvywOqmqQ2BaYLMaDCxSN0/v3Zw45b4fGkwVxmLWTwMYMnYREFvCoJ3+17MVUJxhfbNA1OTUGWZgKb3lcx61AY8eyHXM4UQz7ebrM7L3CG5BnrJg6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZ2Ot5V4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713867529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HDNawudJ5KxjrW1cTaXxr2mViO8x3m4Lig3Uidmvkq8=;
	b=fZ2Ot5V4KySoDHSVhjcpmCTaB3ZsNYXpnKqo9wzI2O8YFAlnQHkcfYE8ex4NWwacWgvIdg
	HSUDQfmSsIYl7EJexH/rOgP+4qexKDMRy+PFBNpuHTs+9qssTUlmaGKJSQ17AyqVrxiJlp
	bXDqMfmhhH2ZjyVcU400CYAHLr5kdz8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-cVoxwHz6NBOl2h2s53E0_A-1; Tue, 23 Apr 2024 06:18:47 -0400
X-MC-Unique: cVoxwHz6NBOl2h2s53E0_A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-349fbb7ab16so3772808f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867526; x=1714472326;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HDNawudJ5KxjrW1cTaXxr2mViO8x3m4Lig3Uidmvkq8=;
        b=lILA3kcyAi4eFgqH2vBhzcXoaIlCvTXmvP6vAqtR+9e8WaH0Yd65+BHOe7ANXblErq
         g1bVEjJaEd0ptUIncdCitSxovyUU+iTkdczb4qdK7WB+LvTWIO3w6LfdtMpcBT+E9hEN
         hmzGrgADMzJZHF6pE19Vpk7BLkofuAJuWEDU7PITctpSjpGdM3YoIP2wILifapNLXld1
         n2CC8tYeJk3wPaGjpWsDnkmJlD46gLRwRZjNlzx45MaIrAi8gcOO0YUEeu7lqUTWou4e
         ihrIcSbNM8WfKZBMqYoaQbksKGKGgSTUg0JcjRNXiRguSRwcv/opD7BTKaRHXaLfWrzC
         E3zA==
X-Forwarded-Encrypted: i=1; AJvYcCXmpIojQGnKjT8cUu49zZDaGL6LlLNt48h/au9oNCEsRz1CMo6oEW/NpCrYLutXUaRAch4HDsEjtznhoUyQSqSUJRYYG6VblZ3nI7Y/
X-Gm-Message-State: AOJu0YwL+koZec1uWycVqdssL2UrMF6VwtIZgSTHRvPT8yKDJ0B8khAh
	YarV55gh8y+RraTcBwz/s3in11BIjrQSPXCapfwcsF4jcKf4VEGlqbCBF/3ctGPqvNq6+lFoOke
	vOyzs1ZpxPO4iWmEpATKgF+ckp2dan1Zn5qvAgsyZk8Qjw1/z+z9wOusNNtR7EA==
X-Received: by 2002:a5d:6a8b:0:b0:349:7e8e:b29a with SMTP id s11-20020a5d6a8b000000b003497e8eb29amr9070122wru.62.1713867526585;
        Tue, 23 Apr 2024 03:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPVkU2MPXUn0s5SXRSrCOpAdgk3C7A2u2zWDvzNMqHuldKbcFiFQQ3w9k9fuuzRCYAgc+Njw==
X-Received: by 2002:a5d:6a8b:0:b0:349:7e8e:b29a with SMTP id s11-20020a5d6a8b000000b003497e8eb29amr9070103wru.62.1713867526143;
        Tue, 23 Apr 2024 03:18:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id a3-20020adffb83000000b0034b32e5e9ccsm3746231wrr.64.2024.04.23.03.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 03:18:45 -0700 (PDT)
Message-ID: <03cf371d-6473-463b-8586-f3ee794d8ed3@redhat.com>
Date: Tue, 23 Apr 2024 12:18:44 +0200
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
 <86680856-2532-495b-951a-ea7b2b93872f@arm.com>
 <35236bbf-3d9a-40e9-84b5-e10e10295c0c@redhat.com>
 <dbc5083b-bf8c-4869-8dc7-5fbf2c88cce8@arm.com>
 <f2aad459-e19c-45e2-a7ab-35383e8c3ba5@redhat.com>
 <4fba71aa-8a63-4a27-8eaf-92a69b2cff0d@arm.com>
 <5a23518b-7974-4b03-bd6e-80ecf6c39484@redhat.com>
 <81aa23ca-18b1-4430-9ad1-00a2c5af8fc2@arm.com>
 <70a36403-aefd-4311-b612-84e602465689@redhat.com>
 <f13d1e4d-1eea-4379-b683-4d736ad99c2c@arm.com>
 <3e50030d-2289-4470-a727-a293baa21618@redhat.com>
 <772de69a-27fa-4d39-a75d-54600d767ad1@arm.com>
 <969dc6c3-2764-4a35-9fa6-7596832fb2a3@redhat.com>
 <e0b34a1f-ef2e-484e-8d56-4901101dbdbf@arm.com>
 <11b1c25b-3e20-4acf-9be5-57b508266c5b@redhat.com>
 <89e04df9-6a2f-409c-ae7d-af1f91d0131e@arm.com>
 <ecd6e3e5-8617-42bd-bed4-3f97577934f9@redhat.com>
 <c880ba19-93ab-492b-a720-7272a1f8756d@arm.com>
 <abc3f45e-3bb9-44b8-ac87-c988e4de706c@redhat.com>
 <789cb7e4-8659-4244-b72e-e8fa0b26431d@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <789cb7e4-8659-4244-b72e-e8fa0b26431d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.04.24 12:15, Ryan Roberts wrote:
> Hi David,
> 
> Sorry for the slow reply on this; its was due to a combination of thinking a bit
> more about the options here and being out on holiday.
> 

No worries, there are things more important in life than 
ptep_get_lockless() :D

>> (1) seems like the easiest thing to do.
> 
> Yes, I'm very much in favour of easy.
> 
>>
>>>
>>> Perhaps its useful to enumerate why we dislike the current ptep_get_lockless()?
>>
>> Well, you sent that patch series with "that aims to reduce the cost and
>> complexity of ptep_get_lockless() for arm64". (2) and (3) would achieve that. :)
> 
> Touche! I'd half forgotten that we were having this conversation in the context
> of this series!
> 
> I guess your ptep_get_gup_fast() approach is very similar to
> ptep_get_lockless_norecency()... So we are back to the beginning :)

Except that it would be limited to GUP-fast :)

> 
> But ultimately I've come to the conclusion that it is easy to reason about the
> current arm64 ptep_get_lockless() implementation and see that its correct. The
> other options both have their drawbacks.

Yes.

> 
> Yes, there is a loop in the current implementation that would be nice to get rid
> of, but I don't think it is really any worse than the cmpxchg loops we already
> have in other helpers.
> 
> I'm not planning to persue this any further. Thanks for the useful discussion
> (as always).

Make sense to me. let's leave it as is for the time being. (and also see 
if a GUP-fast user that needs precise dirty/accessed actually gets real)

-- 
Cheers,

David / dhildenb


