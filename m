Return-Path: <linux-kernel+bounces-137541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264B89E3A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB838286444
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3D2156F4E;
	Tue,  9 Apr 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekzVQL1f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA813E3F2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691168; cv=none; b=R/JGgwB3xz8baIBiDxrqlUsiMmnVTINCoZbPOqmHfMrr6BK5kfNs/bGd1lMfmWBOw4a41VpVD0KFmTVZuYYgRdKdDs0J0uNPqU6ZVTtrS5l3Enwa36udhKDAZzH5+0lVoUklxBPUSda4lhIssvOHnEMib4QWrliRjdKqilGnJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691168; c=relaxed/simple;
	bh=0Q9iyMutk/Wg5UavhZU0QIhTShQgU9MiEdOoTkr3Q74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgVAe9LSGCbc99he9Jyt/z/sGzY/kLLhsh6+YDr4Ge3mIPT44/0cBX94LkB5tmZP87+53o803yMJNpoZ59cfsfEKyDzkbILnqWsLsEjZBOkhDDeEWl0+m1+SvM3BFVv/R6OtspaTlTkbqmLAmSzehgrPJFQIH7Zu8XVoW8LYe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekzVQL1f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712691165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q8UdogNOWcet6056LtjD9ttTcHoGt/88Y84TTKGXWcw=;
	b=ekzVQL1fXkA/RiLPgEhW4CGP7r+FCXq45Ihcu+N9lPYSlzRP+rTN3sImoRv6PsRcdrJya6
	bmvV+wzr4xW0qs68IOppI9JU+P99vStil+Ph12OVga1PhUjV/Ithyog9OWTVFeBFvmiuSF
	OLa+6c6gnWTj9OLUUoNRR7asM3ZQXdo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-NpWhzG_MNSaCZrebb3ENTA-1; Tue, 09 Apr 2024 15:32:44 -0400
X-MC-Unique: NpWhzG_MNSaCZrebb3ENTA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d86005189eso49985641fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 12:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712691163; x=1713295963;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8UdogNOWcet6056LtjD9ttTcHoGt/88Y84TTKGXWcw=;
        b=QMyocRBw2yLlZzpZKLRPJRga7ArdBPp3Kkl4UnxAfRdob4asVHejzlbGNCVZKahJxy
         v6nEMGR6IBUfJZFH/nk6ly2KFjNpcapja1mwBRb1DaMsqokqUe7eZY0dg+IQtakhRMNZ
         v7scc7GftqUR2Oo99NinUKaYolygR27YNsYpujB9k0QrtaJ7g6KBpTL8ZqJATLc1+5af
         H/r35kZ7pUJSb88Wt1K/AFqIPcHzJtU1VGiDqx8lz8cq06vDwhYwCOB4bMSUyoN4TOey
         9H0O52+GQ0NievsNW0fWw85iFsmHaM/y630Ewm1WVzrUUAM2aTBUVACS+LCLl66udAWV
         Ghbw==
X-Forwarded-Encrypted: i=1; AJvYcCUdYdfH0eBAUBb2Yh7/NxJM1CJCKWL8vVz9fxi96MeoAFP+bWLlOjLiyAbEmPjti9Fq2mQJ/bu+bshA0tuOk5Wgklqd5IZp77zKG8Gh
X-Gm-Message-State: AOJu0Yyqt8zOGicgOosJ3c+HI3MT4xsKID9H1QY5cLNZN1BIZe/h0VKA
	o3cdcSZUp6EcxOgXTujcrVtJeInNGiDLWJbfWYG7vGGdAhPJzmWEPfZariJV953rqBZ3rILv6c1
	cArbZ26kaw0/NbgfoZlVxAzImBN2PSveTlgx7DmY61m5yF3dPtO+DqmtOydicpg==
X-Received: by 2002:a2e:9783:0:b0:2d8:abb1:b311 with SMTP id y3-20020a2e9783000000b002d8abb1b311mr440756lji.44.1712691163127;
        Tue, 09 Apr 2024 12:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU4DNJNlb+Xekm0pCOOZhTBbQiL8SogN/qNiGp4xTHyI5lmITKdSK2Qvw9bv9MFccryAvtHw==
X-Received: by 2002:a2e:9783:0:b0:2d8:abb1:b311 with SMTP id y3-20020a2e9783000000b002d8abb1b311mr440745lji.44.1712691162541;
        Tue, 09 Apr 2024 12:32:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:be00:a285:bc76:307d:4eaa? (p200300cbc70abe00a285bc76307d4eaa.dip0.t-ipconnect.de. [2003:cb:c70a:be00:a285:bc76:307d:4eaa])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c299000b0041644e9f3a9sm2211047wmd.0.2024.04.09.12.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:32:42 -0700 (PDT)
Message-ID: <69dcd33b-e8de-4927-93dd-d4ea22834a18@redhat.com>
Date: Tue, 9 Apr 2024 21:32:39 +0200
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
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJD7tkaa3P7dQys+LhuDe8kqWsUqf7PDB8Q+07+wnQ513-6NLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.04.24 10:07, Yosry Ahmed wrote:
> [..]
>>>> Note that totalram_pages can also change during memory onlining and
>>>> offlining. For that you need a memory notifier that also calls that
>>>> refresh function. It's simple enough, though, check out the code
>>>> around register_memory_notifier() in drivers/xen/balloon.c.
>>>
>>> Good point, I completely missed this. It seems like totalram_pages can
>>> actually change from contexts other than memory hotplug as well,
>>> specifically through adjust_managed_page_count(), and mostly through
>>> ballooning drivers. Do we trigger the notifiers in this case? I can't
>>> find such logic.
>>
>> Things like virtio-balloon never online/offline memory and would never
>> call it.
> 
> I see calls to adjust_managed_page_count() from
> drivers/virtio/virtio_balloon.c, but I don't understand enough to know
> what they are doing.

Essentially fake removing/adding pages. :)

> 
>>
>> Things like virtio-mem sometimes will online/offline memory and would
>> sometimes call it (but not always). Things like the Hyper-V balloon and
>> XEN balloon never offline memory, and would only call it when onlining
>> memory.
> 
> Thanks for the details.
> 
>>
>>>
>>> It seems like in this case the actual amount of memory does not
>>> change, but the drivers take it away from the system. It makes some
>>> sense to me that the zswap limits do not change in this case,
>>> especially that userspace just sets those limits as a percentage of
>>> total memory. I wouldn't expect userspace to take ballooning into
>>> account here.
>>>
>>
>> For virtio-mem, it does change ("actual amount of memory"). For
>> virtio-balloon, it's tricky. When using virtio-balloon for VM resizing,
>> it would similarly change. When using it for pure memory overcommit, it
>> depends on whatever the policy in the hypervisor is ... might be that
>> under memory pressure that memory is simply given back to the VM.
> 
> That's good to know, it seems like we need to take these into account,
> and not just because the users may happen to change zswap limits while
> they are onlining/offlining memory.

Yes. Likely other parts of the system would want to know when available 
memory changes (especially, if it's quite significant).

> 
>>
>>> However, it would be a behavioral change from today where we always
>>> rely on totalram_pages(). Also, if userspace happens to change the
>>> limit when a driver is holding a big chunk of memory away from
>>> totalram_pages, then the limit would be constantly underestimated.
>>>
>>> I do not have enough familiarity with memory ballooning to know for
>>> sure if this is okay. How much memory can memory ballooning add/remove
>>> from totalram_pages(), and is it usually transient or does it stick
>>> around for a while?
>>>
>>> Also CCing David here.
>>
>> It can be a lot. Especially with the Hyper-V balloon (but also on
>> environments where other forms of memory hotunplug are not supported),
>> memory ballooning can be used to unplug memory. So that memory can be
>> gone for good and it can end up being quite a lot of memory.
>>
>> The clean thing to do would be to have a way for other subsystems to get
>> notified on any totalram_pages() changes, so they can adjust accordingly.
> 
> Yeah I agree. I imagined that register_memory_notifier() would be the
> way to do that. Apparently it is only effective for memory hotplug.

Yes. Right now it's always called under the memory hotplug lock. We 
could reuse it for this fake hotplug/unplug as well, but we'd have to 
clarify how exactly we expect this to interact with the existing 
notifications+notifiers.

>  From your description, it sounds like the ballooning drivers may have
> a very similar effect to memory hotplug, but I don't see
> memory_notify() being called in these paths.

Right, the existing notifications (MEM_ONLINE etc.) are called when 
memory blocks change their state. That's not what the fake 
hotplug/unplug does, that operates on much smaller ranges.

> 
> Do we need a separate notifier chain for totalram_pages() updates?

Good question. I actually might have the requirement to notify some arch 
code (s390x) from virtio-mem when fake adding/removing memory, and 
already wondered how to best wire that up.

Maybe we can squeeze that into the existing notifier chain, but needs a 
bit of thought.

-- 
Cheers,

David / dhildenb


