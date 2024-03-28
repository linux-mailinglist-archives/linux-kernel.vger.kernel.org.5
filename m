Return-Path: <linux-kernel+bounces-122234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65488F3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90631F360CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FDF9FF;
	Thu, 28 Mar 2024 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3oIJUH6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A638F66
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585665; cv=none; b=MteslbDl6W2CAmGgeGgpNJQJ9yF/8jaXU9gGrHdX8jlZcdcMmyU9J60JgT+13G/6mRDwppHBIGl2w/nf9BMeoSEVfb8axb796lrkIoHFxOq0xc8XvICILVBrMz24SD6YubBpoT+05F352fa8xPjbBlW1PXvxG+HTj8aa+rgSavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585665; c=relaxed/simple;
	bh=nOfjsguiUXzzQozFQI0gLYHatUvl4jMUEhWTMOYVU/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuPnBb3dKi3cCQ/GNkpDUD5FTj8RQfpYAC+N07si6eotKidhc7KB4hE/F+4dgGQNeMVf3zqimCB54uU/YkUPCkixq6xQqsPTPFoxGYuKZm1vTSf7dTvCwGk+BuAKMPQ9Npy7ZBKz/bih7MHut+sT0iAN45bbzpoP5Tow6FvjOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3oIJUH6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711585663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYRDhXXYwKXhmyLmKrVPl2OGvwD0tO+zX4ao1kqScaE=;
	b=N3oIJUH6rFYRYlxnF703EUD3g64awTgtSKg9BQxwHF5WszpWWt6jIPQnn9BbhtbISLGZ8T
	IXwKyrBCF2YxMODCy1sr1wqaFrL5IgNaYdeN5+FUW7LXoxybkfEzB2Vdwlam/uKh7a9Pt4
	08R+t1b5kdw9eH2vmIzIMR0R+zFOOMs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-CA1OYHdgORCRI2XplZYifw-1; Wed, 27 Mar 2024 20:27:40 -0400
X-MC-Unique: CA1OYHdgORCRI2XplZYifw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ea7f05b543so283007b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711585660; x=1712190460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYRDhXXYwKXhmyLmKrVPl2OGvwD0tO+zX4ao1kqScaE=;
        b=m1tWFXwQpFtimsK1w3iPpH9yKlbNYYomxsCYyKNqN3Pkxxh2rfKwjS0i+6gqE3571W
         TdyPxi54MbJQjckX9nk6Cr2SQ2da9df4JqX7SZIETOb4SnJ0/w/91HnY/o1tU/JsY99H
         l23YblbafyqIn/noJsmoK05Npw3YRDFb7EHHbvvqI+nIgWMfmbsMeRTQe19Vz7rI7wlG
         WigcK5WzmEEdw8r4TYylynodjf6bDaPd0HCQj1vohIs21R0ARsIMtv8e7dfUypRfZjry
         RRs3WlQyLvK/y35i/EOyIgYM3xHgTN6Tai5gh7rFCVm9f2qOTiUXK7vhqvSMr+FlseMJ
         ogcA==
X-Forwarded-Encrypted: i=1; AJvYcCWYv0X3FzXVrq+7Dt2v2nZSQs3ZNIOMU5a97WKbk687det6IiuHAP9Rg+JQJRkx6IiVK+GV2a70SOn+V0n0Vl3I8p1ujUNKmjluYwjk
X-Gm-Message-State: AOJu0YyrEhh0yVTyMdnN465HPBaP1Sr9UMAt4ZwbcMtcKW5/RXXJv0aO
	KVpPuodhN8JZxIjTbKiKzXbXtzlgg+qTWPMAV7eA1WwZe7GRC95W+xJwcxs7GAfZM84+IVwWv0x
	56yme38qjLN9arFgKHH2DIdmYZedMJUVSCDqNts2YRIrdtrfsObJLUilV9jJFnw==
X-Received: by 2002:a05:6a00:4b16:b0:6e6:8b59:1bad with SMTP id kq22-20020a056a004b1600b006e68b591badmr1548174pfb.25.1711585659616;
        Wed, 27 Mar 2024 17:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvpTosFo7/pLx/mYgr8vyc9usrDD6UtWd6JJ1sl7V79VUxz2b37iP92LXtAbN+rvgAGGkAwA==
X-Received: by 2002:a05:6a00:4b16:b0:6e6:8b59:1bad with SMTP id kq22-20020a056a004b1600b006e68b591badmr1548160pfb.25.1711585659160;
        Wed, 27 Mar 2024 17:27:39 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b006eac433b2casm146099pfg.128.2024.03.27.17.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 17:27:37 -0700 (PDT)
Message-ID: <48b1cc13-849f-4f36-b328-175417a1e4d2@redhat.com>
Date: Thu, 28 Mar 2024 10:27:33 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 mst@redhat.com, davem@davemloft.net, stefanha@redhat.com,
 sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com,
 shan.gavin@gmail.com, Will Deacon <will@kernel.org>
References: <20240326233846.1086253-1-gshan@redhat.com>
 <20240326233846.1086253-2-gshan@redhat.com>
 <CACGkMEtyEo2QQSEh0ZnZDUJSXMMhzeO97Jp0wF4_rhzUBGk4Zg@mail.gmail.com>
 <CACGkMEtUdgDr_M-F8-gdFkJp+29Xuw9DCib2-diFmJxFxDN2Bw@mail.gmail.com>
 <b6f4e8c1-bdd1-496e-aa1a-68349674671c@redhat.com>
 <92ac171a-0004-45ef-a6c8-01b1c135a8ca@redhat.com>
 <CACGkMEti3xtqHxhM-DGcquP6UncELUzrNeVor45wfGRCBkkZrg@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CACGkMEti3xtqHxhM-DGcquP6UncELUzrNeVor45wfGRCBkkZrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/24 17:42, Jason Wang wrote:
> On Wed, Mar 27, 2024 at 3:35 PM Gavin Shan <gshan@redhat.com> wrote:
>>
>> On 3/27/24 14:08, Gavin Shan wrote:
>>> On 3/27/24 12:44, Jason Wang wrote:
>>>> On Wed, Mar 27, 2024 at 10:34 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>> On Wed, Mar 27, 2024 at 7:39 AM Gavin Shan <gshan@redhat.com> wrote:
>>>>>>
>>>>>> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
>>>>>> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
>>>>>> available ring entries pushed by guest can be observed by vhost
>>>>>> in time, leading to stale available ring entries fetched by vhost
>>>>>> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
>>>>>> grace-hopper (ARM64) platform.
>>>>>>
>>>>>>     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>>>>>>     -accel kvm -machine virt,gic-version=host -cpu host          \
>>>>>>     -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>>>>>>     -m 4096M,slots=16,maxmem=64G                                 \
>>>>>>     -object memory-backend-ram,id=mem0,size=4096M                \
>>>>>>      :                                                           \
>>>>>>     -netdev tap,id=vnet0,vhost=true                              \
>>>>>>     -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
>>>>>>      :
>>>>>>     guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>>>>>>     virtio_net virtio0: output.0:id 100 is not a head!
>>>>>>
>>>>>> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
>>>>>> should be safe until vq->avail_idx is changed by commit 275bf960ac697
>>>>>> ("vhost: better detection of available buffers").
>>>>>>
>>>>>> Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
>>>>>> Cc: <stable@kernel.org> # v4.11+
>>>>>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>>> ---
>>>>>>    drivers/vhost/vhost.c | 11 ++++++++++-
>>>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>>>> index 045f666b4f12..00445ab172b3 100644
>>>>>> --- a/drivers/vhost/vhost.c
>>>>>> +++ b/drivers/vhost/vhost.c
>>>>>> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>>>>>           r = vhost_get_avail_idx(vq, &avail_idx);
>>>>>>           if (unlikely(r))
>>>>>>                   return false;
>>>>>> +
>>>>>>           vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>>>>>> +       if (vq->avail_idx != vq->last_avail_idx) {
>>>>>> +               /* Similar to what's done in vhost_get_vq_desc(), we need
>>>>>> +                * to ensure the available ring entries have been exposed
>>>>>> +                * by guest.
>>>>>> +                */
>>>>>
>>>>> We need to be more verbose here. For example, which load needs to be
>>>>> ordered with which load.
>>>>>
>>>>> The rmb in vhost_get_vq_desc() is used to order the load of avail idx
>>>>> and the load of head. It is paired with e.g virtio_wmb() in
>>>>> virtqueue_add_split().
>>>>>
>>>>> vhost_vq_avail_empty() are mostly used as a hint in
>>>>> vhost_net_busy_poll() which is under the protection of the vq mutex.
>>>>>
>>>>> An exception is the tx_can_batch(), but in that case it doesn't even
>>>>> want to read the head.
>>>>
>>>> Ok, if it is needed only in that path, maybe we can move the barriers there.
>>>>
>>>
>>> [cc Will Deacon]
>>>
>>> Jason, appreciate for your review and comments. I think PATCH[1/2] is
>>> the fix for the hypothesis, meaning PATCH[2/2] is the real fix. However,
>>> it would be nice to fix all of them in one shoot. I will try with PATCH[2/2]
>>> only to see if our issue will disappear or not. However, the issue still
>>> exists if PATCH[2/2] is missed.
>>>
>>
>> Jason, PATCH[2/2] is sufficient to fix our current issue. I tried with PATCH[2/2]
>> only and unable to hit the issue. However, PATCH[1/2] may be needed by other scenarios.
>> So it would be nice to fix them in one shoot.
> 
> Yes, see below.
> 
>>
>>
>>> Firstly, We were failing on the transmit queue and {tvq, rvq}->busyloop_timeout
>>> == false if I remember correctly. So the added smp_rmb() in vhost_vq_avail_empty()
>>> is only a concern to tx_can_batch(). A mutex isn't enough to ensure the order
>>> for the available index and available ring entry (head). For example, vhost_vq_avail_empty()
>>> called by tx_can_batch() can see next available index, but its corresponding
>>> available ring entry (head) may not be seen by vhost yet if smp_rmb() is missed.
>>> The next call to get_tx_bufs(), where the available ring entry (head) doesn't
>>> arrived yet, leading to stale available ring entry (head) being fetched.
>>>
>>>     handle_tx_copy
>>>       get_tx_bufs                 // smp_rmb() won't be executed when vq->avail_idx != vq->last_avail_idx
>>>       tx_can_batch
>>>         vhost_vq_avail_empty      // vq->avail_idx is updated from vq->avail->idx
>>>
>>> The reason why I added smp_rmb() to vhost_vq_avail_empty() is because the function
>>> is a exposed API, even it's only used by drivers/vhost/net.c at present. It means
>>> the API has been broken internally. So it seems more appropriate to fix it up in
>>> vhost_vq_avail_empty() so that the API's users needn't worry about the memory access
>>> order.
> 
> When tx_can_batch returns true it means there's still pending tx
> buffers. Since it might read indices so it still can bypass the
> smp_rmb() in the vhost_get_vq_desc().
> 
> I'd suggest adding those above to change log.
> 
> With this,
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 

Thanks, Jason. The change log has been improved as you suggested in
v3, which was posted for further review.

Thanks,
Gavin

>>>
>>>>>
>>>>>
>>>>>> +               smp_rmb();
>>>>>> +               return false;
>>>>>> +       }
>>>>>>
>>>>>> -       return vq->avail_idx == vq->last_avail_idx;
>>>>>> +       return true;
>>>>>>    }
>>>>>>    EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);


