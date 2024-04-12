Return-Path: <linux-kernel+bounces-143272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095468A367E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAEF1F25E51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102E150981;
	Fri, 12 Apr 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA5SVZ1c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC9405FD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951333; cv=none; b=Ye++09y02T0PSzqBq2Nyu5nIqo4c2kkIGn3anzSAWb4Hy6SI29xIKVMDGgMbtgu7qFgGkFIcKMWb3daaJdjF5XbovOJr3j2jfb9ZhHLHa+RFB+x2tRTO87x0pfPiBRUij1jSx8i48575GSpcD4kJOkcDjONd9IfpD8OUWN+rRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951333; c=relaxed/simple;
	bh=hFmSiF5Eb94AD+YWUstb1d2lnwkN7MpvxNfFrmroPp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyTNxiWf+uB/EjopmTIXo/x9aCh9h30+RyWzXoy3KXxxuR7CDlY7NsrVujytSdEWzdtukoFYzrGiKZxgHFQNg7ti+DtvGMTWehud6H+XiVXOThNA8gx84sasWsTtJ/lKwI1vpfTeL+2hX//3mT+GdS/ebEIdYyZo5vmNLj4ZC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OA5SVZ1c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712951330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TYkmJicVD3bVegYHeGie21mEZo8b7qtRmpMvmHpP2SY=;
	b=OA5SVZ1cvzOyW6KvUnovtlEjoVRg4J5SnQh95C/oxsrR9roP42326mP0ylbNU8HGG7nvVZ
	VOtwO5FjaXodKbn0pT79pYk/X9bNeb4oJ2XTS9XTGPQ3CU2CbRevq5Ach5YiyPuk1RSEhT
	mQrdhmYaX6VXdxAeKh93keHjTQy7Qbs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-McDP9qQWPaC9gXL1tecVBA-1; Fri, 12 Apr 2024 15:48:49 -0400
X-MC-Unique: McDP9qQWPaC9gXL1tecVBA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343e775c794so684951f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712951328; x=1713556128;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYkmJicVD3bVegYHeGie21mEZo8b7qtRmpMvmHpP2SY=;
        b=bVTSenYi2/znvTcl6wHwhlQVBxin6HzYvdD2EE3GJYwLhgAC8+ba0AjsZYeql2TPfv
         yFU8toFGnGsJl4D2lGAzLrhLpm6sdGoL0JLAWlFusSvpcuWQz6k0wR23vPZwetHg/mdy
         AOZDemju4GcaW6m0NXvKkmO74ZgMpUg7pjjdgtregevov8ou93a7rDJvt3OyNyRL+T9+
         AMDgmPfcYvNQiPAWv80T+nJaFljZOG63/RFYq+LX564VKodP97Vhz1EaF2A7t6hrjPWs
         x2hIBRLcymVs2apFpRR6NLPmuD1qsdV8YxXGnGOLZCy3N1pFT39xADFqvM7jwgv7U5gd
         dROg==
X-Forwarded-Encrypted: i=1; AJvYcCVRafT/teYHdbIhnuZddbZ7jW7GPEA3AB4KdzpcMFQMtukRAqP9GmC9I0r6JkTAkWFPnGqOF4kb6iSJkiwMMB+HTnjWesoMHXOuWO/3
X-Gm-Message-State: AOJu0Yyg6cf4vJlZE3XJXGrkop6NMgdTmx+YfdhwjtkShMx2UMHBY3Ek
	LcjLzfT5bbvNm3GvVnY1i8WrRHznjAQ4VGCpJOs/Cdq67vwReYz5VnBExfLe3lVvzxBbVdFc96g
	DB6raQFa7ftvMCPa76mcDVhaXnJq5sLoRmx45TS3zLkkerPOgcZteuYaCaXRncw==
X-Received: by 2002:a5d:480a:0:b0:347:2055:f49e with SMTP id l10-20020a5d480a000000b003472055f49emr1420375wrq.33.1712951328018;
        Fri, 12 Apr 2024 12:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4sS0y0d+9cOo5SmPWK2Wk76fTrpGzq8giq9UqFehqKXT4WEsD993Zm4Rb2Atw2XLIY2eYNQ==
X-Received: by 2002:a5d:480a:0:b0:347:2055:f49e with SMTP id l10-20020a5d480a000000b003472055f49emr1420367wrq.33.1712951327564;
        Fri, 12 Apr 2024 12:48:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:f600:afa2:4e8a:448a:9831? (p200300cbc730f600afa24e8a448a9831.dip0.t-ipconnect.de. [2003:cb:c730:f600:afa2:4e8a:448a:9831])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d6d48000000b00346ab3c372bsm4887616wri.73.2024.04.12.12.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 12:48:47 -0700 (PDT)
Message-ID: <f18ecb84-31a5-4767-a8df-0c0b8be82d81@redhat.com>
Date: Fri, 12 Apr 2024 21:48:46 +0200
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
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJD7tkb5D6Y5OMTzpHefYgSXbw7GdPtfjSp2=nBGjJFk99GP_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.04.24 02:52, Yosry Ahmed wrote:
> [..]
>>> Do we need a separate notifier chain for totalram_pages() updates?
>>
>> Good question. I actually might have the requirement to notify some arch
>> code (s390x) from virtio-mem when fake adding/removing memory, and
>> already wondered how to best wire that up.
>>
>> Maybe we can squeeze that into the existing notifier chain, but needs a
>> bit of thought.
> 

Sorry for the late reply, I had to think about this a bit.

> Do you mean by adding new actions (e.g. MEM_FAKE_ONLINE,
> MEM_FAKE_OFFLINE), or by reusing the existing actions (MEM_ONLINE,
> MEM_OFFLINE, etc).

At least for virtio-mem, I think we could have a MEM_ONLINE/MEM_OFFLINE 
that prepare the whole range belonging to the Linux memory block 
(/sys/devices/system/memory/memory...) to go online, and then have 
something like MEM_SOFT_ONLINE/MEM_SOFT_OFFLINE or 
ENABLE_PAGES/DISABLE_PAGES ... notifications when parts become usable 
(!PageOffline, handed to the buddy) or unusable (PageOffline, removed 
from the buddy).

There are some details to be figured out, but it could work.

And as virtio-mem currently operates in pageblock granularity (e.g., 2 
MiB), but frequently handles multiple contiguous pageblocks within a 
Linux memory block, it's not that bad.


But the issue I see with ballooning is that we operate here often on 
page granularity. While we could optimize some cases, we might get quite 
some overhead from all the notifications. Alternatively, we could send a 
list of pages, but it won't win a beauty contest.

I think the main issue is that, for my purpose (virtio-mem on s390x), I 
need to notify about the exact memory ranges (so I can reinitialize 
stuff in s390x code when memory gets effectively re-enabled). For other 
cases (total pages changing), we don't need the memory ranges, but only 
the "summary" -- or a notification afterwards that the total pages were 
just changed quite a bit.

> 
> New actions mean minimal impact to existing notifiers, but it may make
> more sense to reuse MEM_ONLINE and MEM_OFFLINE to have generic actions
> that mean "memory increased" and "memory decreased".

Likely, we should keep their semantics unchanged. Things like KASAN want 
to allocate metadata memory for the whole range, not on some smallish 
pieces. It really means "This Linux memory block goes online/offline, 
please prepare for that.". And again, memory ballooning with small pages 
is a bit problematic.

> 
> I suppose we can add new actions and then separately (and probably
> incrementally) audit existing notifiers to check if they want to
> handle the new actions as well.
> 
> Another consideration is that apparently some ballooning drivers also
> register notifiers, so we need to make sure there is no possibility of
> deadlock/recursion.

Right.

-- 
Cheers,

David / dhildenb


