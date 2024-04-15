Return-Path: <linux-kernel+bounces-145759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1758A5A70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68DCFB21FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE469155A52;
	Mon, 15 Apr 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M47oWl9M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810CB656
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208531; cv=none; b=n+ujQkyhLjm8xEQdM702cdlUikQxI2j5QeFaa+FOOPcTU15iiZQkpnYJS+/mZ0GQIodtNWZNF+d40t8EMGTPxtvkQpEC0kqo4Ii89pCwR0KPGD1lou1bQF537qTE7Wv0KrmBUJ5Ce3pVaz6sQ9cQhgR72rrqBTlsWUOBJ+Xfkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208531; c=relaxed/simple;
	bh=sS5bwsq/P3NSc86p4xD4KVMCnlJfUqYZprAYaDAq9II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWmNF7aQjt7IYdGPWvtN8IDyI32uGs8d4jSqOgo7XIYDpdgngnIIMcMM9Ewxq+tWnRPo0AAEa7UnFaulglj+uDf7DZhqXv7O1MXLLGNKvRwrfxxHgC4j4/8+1G7Vt7mOaUubYBYyGi/Ws2Tb5KqAIp8EtsloeW8fDfD9QLzNUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M47oWl9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713208529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+fl4YekS370NcpAxHdEz/bCgYFnF1wkEkXC2Kv4cg2k=;
	b=M47oWl9Mtap+A9kEoO8V7qvPAtuipLmodnchWZt9VcZe7gHvuXFVy20YpquIakthrkvXsX
	qEqsUEXu4prKkrwA1z4Mp73TTMbqU32xbf4peAn/5qvzDb4C1FOe9hU4DfRbMvrxAnKdwO
	Y4Qe80M061vXfU9p0NzigeivM50Nr3k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-fsds1x3KN_Ke2AeIAdAEog-1; Mon, 15 Apr 2024 15:15:27 -0400
X-MC-Unique: fsds1x3KN_Ke2AeIAdAEog-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-345c686ba9bso2763920f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713208527; x=1713813327;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fl4YekS370NcpAxHdEz/bCgYFnF1wkEkXC2Kv4cg2k=;
        b=RzhbAXz/3bCpNT4mUcVDqgUEdCV021FjWzaPGDf/X3GNT+rjJwAKCNnphCq9UfKwkG
         m2JY4pCD9SGWzw3zYy1ss1DAaRCTI2mH0R3zZBBXNFj1HVKSdMXDTvLPBE7f6k9gBRUv
         zbIGzXQZeRKwhYU88VJ2r74vvdMVy8CHNVNygodk6VY39iScfkurIq+Jx3PswVCmtDs/
         4Xt3H/jVxhsWi4icZjee5H8Lzfu4ekKje6Qf+OtoSmh1uSRQ3BYsvYnJdaveRJHQTCwa
         8D/D2zXHIeZeN7QUt6JaEx0eIeVpyL6Ggmuke4+nbtjAswBPr+h0djMalPUnokyduEGB
         PvAw==
X-Forwarded-Encrypted: i=1; AJvYcCVdfmFArR6sdGxBuhKvwmEAneKA723sfu4jgArSjzEjvowP1pkh6oxCer/qjUhjrGofTuv2g8tjIIogzmY30N5u0MFREZRoejStUGeV
X-Gm-Message-State: AOJu0Yyg+rI1SdDCJMSrkAOqtuKwdfPkrYWUQ2JtbZ1QdHiJNguwN+La
	t6Ix+1n8Ek5Zn8moZO4QbzrvSFrxJ4VcJfNo+2+UBi6t0bxTmSCup1Oa0c6BWlFdjyMDYLA5eyd
	gtTr7qT77bkhnfb99UZhrptOR4lzExtYkitv+ai0JyjfwFC7CZXb7DozBMmDiPA==
X-Received: by 2002:adf:ab03:0:b0:346:758e:5f29 with SMTP id q3-20020adfab03000000b00346758e5f29mr7759900wrc.60.1713208526798;
        Mon, 15 Apr 2024 12:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Ulrp+8Swv1A+UUfh1bARerfIKoWvOT4VvOeYfs32V6QCUl9TMR5E+cvECdOeHHY18kkZmg==
X-Received: by 2002:adf:ab03:0:b0:346:758e:5f29 with SMTP id q3-20020adfab03000000b00346758e5f29mr7759886wrc.60.1713208526410;
        Mon, 15 Apr 2024 12:15:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id i10-20020adffc0a000000b003456c693fa4sm12812933wrr.93.2024.04.15.12.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:15:26 -0700 (PDT)
Message-ID: <11e9143f-67c6-4d7a-827b-dd04043b6fa4@redhat.com>
Date: Mon, 15 Apr 2024 21:15:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-3-yosryahmed@google.com>
 <20240405152619.GA866431@cmpxchg.org>
 <CAJD7tkaSCvgs-yKXeAVoW14_LhtCrL3N9hu9xA41GCvz+RvWBw@mail.gmail.com>
 <7aec7b98-db81-4238-bdd6-afb69679f852@redhat.com>
 <CAJD7tkaa3P7dQys+LhuDe8kqWsUqf7PDB8Q+07+wnQ513-6NLg@mail.gmail.com>
 <69dcd33b-e8de-4927-93dd-d4ea22834a18@redhat.com>
 <CAJD7tkb5D6Y5OMTzpHefYgSXbw7GdPtfjSp2=nBGjJFk99GP_A@mail.gmail.com>
 <f18ecb84-31a5-4767-a8df-0c0b8be82d81@redhat.com>
 <CAJD7tkYMM9oDQYsWPcQNctRRH52+oM-3cUhxV+_7Qg1NNZx4cg@mail.gmail.com>
 <d4b5033a-34fd-44ed-ab57-ea2b4ed01468@redhat.com>
 <CAJD7tkacCA5JQpis=Y6zGVx+uMnwCBk3jUDA8Nch2qXnR1qrgw@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJD7tkacCA5JQpis=Y6zGVx+uMnwCBk3jUDA8Nch2qXnR1qrgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.04.24 20:30, Yosry Ahmed wrote:
> On Mon, Apr 15, 2024 at 8:10 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 13.04.24 03:05, Yosry Ahmed wrote:
>>> On Fri, Apr 12, 2024 at 12:48 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 10.04.24 02:52, Yosry Ahmed wrote:
>>>>> [..]
>>>>>>> Do we need a separate notifier chain for totalram_pages() updates?
>>>>>>
>>>>>> Good question. I actually might have the requirement to notify some arch
>>>>>> code (s390x) from virtio-mem when fake adding/removing memory, and
>>>>>> already wondered how to best wire that up.
>>>>>>
>>>>>> Maybe we can squeeze that into the existing notifier chain, but needs a
>>>>>> bit of thought.
>>>>>
>>>>
>>>> Sorry for the late reply, I had to think about this a bit.
>>>>
>>>>> Do you mean by adding new actions (e.g. MEM_FAKE_ONLINE,
>>>>> MEM_FAKE_OFFLINE), or by reusing the existing actions (MEM_ONLINE,
>>>>> MEM_OFFLINE, etc).
>>>>
>>>> At least for virtio-mem, I think we could have a MEM_ONLINE/MEM_OFFLINE
>>>> that prepare the whole range belonging to the Linux memory block
>>>> (/sys/devices/system/memory/memory...) to go online, and then have
>>>> something like MEM_SOFT_ONLINE/MEM_SOFT_OFFLINE or
>>>> ENABLE_PAGES/DISABLE_PAGES ... notifications when parts become usable
>>>> (!PageOffline, handed to the buddy) or unusable (PageOffline, removed
>>>> from the buddy).
>>>>
>>>> There are some details to be figured out, but it could work.
>>>>
>>>> And as virtio-mem currently operates in pageblock granularity (e.g., 2
>>>> MiB), but frequently handles multiple contiguous pageblocks within a
>>>> Linux memory block, it's not that bad.
>>>>
>>>>
>>>> But the issue I see with ballooning is that we operate here often on
>>>> page granularity. While we could optimize some cases, we might get quite
>>>> some overhead from all the notifications. Alternatively, we could send a
>>>> list of pages, but it won't win a beauty contest.
>>>>
>>>> I think the main issue is that, for my purpose (virtio-mem on s390x), I
>>>> need to notify about the exact memory ranges (so I can reinitialize
>>>> stuff in s390x code when memory gets effectively re-enabled). For other
>>>> cases (total pages changing), we don't need the memory ranges, but only
>>>> the "summary" -- or a notification afterwards that the total pages were
>>>> just changed quite a bit.
>>>
>>>
>>> Thanks for shedding some light on this. Although I am not familiar
>>> with ballooning, sending notifications on page granularity updates
>>> sounds terrible. It seems like this is not as straightforward as I had
>>> anticipated.
>>>
>>> I was going to take a stab at this, but given that the motivation is a
>>> minor optimization on the zswap side, I will probably just give up :)
>>
>> Oh no, so I have to do the work! ;)
>>
>>>
>>> For now, I will drop this optimization from the series for now, and I
>>> can revisit it if/when notifications for totalram_pages() are
>>> implemented at some point. Please CC me if you do so for the s390x use
>>> case :)
>>
>> I primarily care about virtio-mem resizing VM memory and adjusting
>> totalram_pages(), memory ballooning for that is rather a hack for that
>> use case ... so we're in agreement :)
>>
>> Likely we'd want two notification mechanisms, but no matter how I look
>> at it, it's all a bit ugly.
> 
> I am assuming you mean one with exact memory ranges for your s390x use
> case, and one high-level mechanism for totalram_pages() updates -- or
> did I miss the point?

No, that's it.

> 
> I am interested to see how page granularity updates would be handled
> in this case. Perhaps they are only relevant for the high-level
> mechanism? In that case, I suppose we can batch updates and notify
> once when a threshold is crossed or something.

Yes, we'd batch updates.

-- 
Cheers,

David / dhildenb


