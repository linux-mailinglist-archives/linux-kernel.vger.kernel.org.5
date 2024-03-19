Return-Path: <linux-kernel+bounces-107205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0852B87F90A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE3E1F2269E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA45548E9;
	Tue, 19 Mar 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNsuN4PH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D054729
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835719; cv=none; b=qP4tEQs3WRuksU943OqZ6AaIvwGcCYYq/OY/EpCfq6gLZvYibxj2qGzWAeuzghPqnflcscX8ti/Tv8lO8wvI15Q/MYurXT1JBvDSfR9G/lOEr/P6HcWcUP51U33gvrNB5SWjeALma55AQiO99dGFCZ8GBMDatmAx0iGhTwiqaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835719; c=relaxed/simple;
	bh=8ibEuIaVig1hAiYyalS4W6OCLW5TeFYVgNtcnd7QKyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoqF025wY14w3o1j95NN+4BHfb+hN0Yhi57PeDB0pUXjZzbZUgOhqCzF4L8BckxB8reqnJ0Ve4q07XMBNlHiaCb/fjZ1Jn2wm1bt01YnoPmbw7h9jK9hM8398ICoMUMzm/L9EIXWi9wo0lYS+6Lu53IRVLyYFpp8SkOxsIVBqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNsuN4PH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710835716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ju8gWBaWN+2UIqDfiEjPtIBulqNS5l/Hxkm05DauZf8=;
	b=UNsuN4PHvvJL2k+EgBBKJRf236HTFGHc2qpDJKlNsQEuZ7kUswgR0IfAlFEYw4BaFeTeef
	KiofATAjTdzg8LY3knlFuQxJPRU74M4nQE9woOsmg08xhyHy6C58lOmVU/iHC2SZrlr9O9
	zCefs5kVyhgMezhlRI/hkNs/X4Iohbg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-kxuNVFErO_mgb8XlW9f91Q-1; Tue, 19 Mar 2024 04:08:34 -0400
X-MC-Unique: kxuNVFErO_mgb8XlW9f91Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e71aec985bso2236629b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710835714; x=1711440514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju8gWBaWN+2UIqDfiEjPtIBulqNS5l/Hxkm05DauZf8=;
        b=Pvz9tt9xVxUeHqx2H01wnqQ1aN5LE5VNBWlPrk50c5RvZWgFvTlRxDDjWcvD2UzsxX
         L+J8WIiG7qzDd2fc/+6Fuyd52jFvmBhB/TLcu4Ikl4jx5tJdlpzH0Tsv3uPigUrJHOKl
         6OBkJJUJ4FRO7+ZAXFyAP/Mkl0664t+GQU/YPqFgNJbHAm4Cqb9dNi/Vge05s3v2Wbh2
         bheAeJW2GcEKYzgMFy28LJ3DKs1cnfvtlVOwH8O5O1MO8TEAnUVCnP4wfijKnwifmVXi
         II0CBL5XvMlgNtTE6z32vpgUXpy/0FDOWgq7YoddL6ZQpDquU2wgzDUejMgbBnvxYzwa
         i0rA==
X-Forwarded-Encrypted: i=1; AJvYcCWXT+kbwA/t9Z1xi/P5rJoOC/ALyEyqLkD9U+tPUmLFLRBXU/AyrsiJsZIbqr+rMlzOUU10XLFcmHWa6PFcGj/KyEyxMfK745/cay0V
X-Gm-Message-State: AOJu0YxCAFo29UlT9EysqZHS3Hg+JVVtND2boH8BS7lICc84QZo7XgQh
	TeqmlBSPUCSRIs3Sp3BX1Sb/1PRpLoG4NjMPe3wrNzMa1mTbeQ/kM1WCGWqawyPwVTKoaDHQj5x
	IEtM3tezWg8ox+MCce4MNiAjwhfU4ib56MYpPY7lIJX1+ljiRLglwGZeYO6ZvGg==
X-Received: by 2002:a05:6a20:3955:b0:1a3:6704:8885 with SMTP id r21-20020a056a20395500b001a367048885mr1371129pzg.51.1710835713760;
        Tue, 19 Mar 2024 01:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk7L/5R++tIec7RGJ5dVuOOSuByzVSgvORsavBQdMwSBFir5LXMrz07yEfky6wE6VMoQutNA==
X-Received: by 2002:a05:6a20:3955:b0:1a3:6704:8885 with SMTP id r21-20020a056a20395500b001a367048885mr1371095pzg.51.1710835712980;
        Tue, 19 Mar 2024 01:08:32 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902680e00b001dda608484asm10932340plk.57.2024.03.19.01.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 01:08:32 -0700 (PDT)
Message-ID: <e582f248-28e9-4d0b-aa5d-26b82cd96a68@redhat.com>
Date: Tue, 19 Mar 2024 18:08:27 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
 <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>
 <20240319024025-mutt-send-email-mst@kernel.org>
 <d8387677-7025-4daa-b8b5-5a8f24a671d5@redhat.com>
 <20240319030505-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240319030505-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 17:09, Michael S. Tsirkin wrote:
> On Tue, Mar 19, 2024 at 04:49:50PM +1000, Gavin Shan wrote:
>>
>> On 3/19/24 16:43, Michael S. Tsirkin wrote:
>>> On Tue, Mar 19, 2024 at 04:38:49PM +1000, Gavin Shan wrote:
>>>> On 3/19/24 16:09, Michael S. Tsirkin wrote:
>>>>
>>>>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>>>>> index 49299b1f9ec7..7d852811c912 100644
>>>>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>>>>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>>>>>>      	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>>>>>      	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>>>>> -	/* Descriptors and available array need to be set before we expose the
>>>>>>>> -	 * new available array entries. */
>>>>>>>> -	virtio_wmb(vq->weak_barriers);
>>>>>>>> +	/*
>>>>>>>> +	 * Descriptors and available array need to be set before we expose
>>>>>>>> +	 * the new available array entries. virtio_wmb() should be enough
>>>>>>>> +	 * to ensuere the order theoretically. However, a stronger barrier
>>>>>>>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>>>>>>>> +	 * by the host (vhost). A stronger barrier should work for other
>>>>>>>> +	 * architectures, but performance loss is expected.
>>>>>>>> +	 */
>>>>>>>> +	virtio_mb(false);
>>>>>>>>      	vq->split.avail_idx_shadow++;
>>>>>>>>      	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>>>>>      						vq->split.avail_idx_shadow);
>>>>>>>
>>>>>>> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
>>>>>>> here, especially when ordering accesses to coherent memory.
>>>>>>>
>>>>>>> In practice, either the larger timing different from the DSB or the fact
>>>>>>> that you're going from a Store->Store barrier to a full barrier is what
>>>>>>> makes things "work" for you. Have you tried, for example, a DMB SY
>>>>>>> (e.g. via __smb_mb()).
>>>>>>>
>>>>>>> We definitely shouldn't take changes like this without a proper
>>>>>>> explanation of what is going on.
>>>>>>>
>>>>>>
>>>>>> Thanks for your comments, Will.
>>>>>>
>>>>>> Yes, DMB should work for us. However, it seems this instruction has issues on
>>>>>> NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
>>>>>> from hardware level. I agree it's not the solution to replace DMB with DSB
>>>>>> before we fully understand the root cause.
>>>>>>
>>>>>> I tried the possible replacement like below. __smp_mb() can avoid the issue like
>>>>>> __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
>>>>>>
>>>>>> static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
>>>>>> {
>>>>>>        :
>>>>>>            /* Put entry in available array (but don't update avail->idx until they
>>>>>>             * do sync). */
>>>>>>            avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>>>            vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>>>
>>>>>>            /* Descriptors and available array need to be set before we expose the
>>>>>>             * new available array entries. */
>>>>>>            // Broken: virtio_wmb(vq->weak_barriers);
>>>>>>            // Broken: __dma_mb();
>>>>>>            // Work:   __mb();
>>>>>>            // Work:   __smp_mb();
>>>>>>            // Work:   __ndelay(100);
>>>>>>            // Work:   __ndelay(10);
>>>>>>            // Broken: __ndelay(9);
>>>>>>
>>>>>>           vq->split.avail_idx_shadow++;
>>>>>>            vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>>>                                                    vq->split.avail_idx_shadow);
>>>>>
>>>>> What if you stick __ndelay here?
>>>>>
>>>>
>>>>          /* Put entry in available array (but don't update avail->idx until they
>>>>            * do sync). */
>>>>           avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>           vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>
>>>>           /* Descriptors and available array need to be set before we expose the
>>>>            * new available array entries. */
>>>>           virtio_wmb(vq->weak_barriers);
>>>>           vq->split.avail_idx_shadow++;
>>>>           vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>                                                   vq->split.avail_idx_shadow);
>>>>           /* Try __ndelay(x) here as Michael suggested
>>>>            *
>>>>            * Work:      __ndelay(200);    possiblly make it hard to reproduce
>>>>            * Broken:    __ndelay(100);
>>>>            * Broken:    __ndelay(20);
>>>>            * Broken:    __ndelay(10);
>>>>            */
>>>>           __ndelay(200);
>>>
>>> So we see that just changing the timing masks the race.
>>> What are you using on the host side? vhost or qemu?
>>>
>>
>> __ndelay(200) may make the issue harder to be reproduce as I understand.
>> More delays here will give vhost relief, reducing the race.
>>
>> The issue is only reproducible when vhost is turned on. Otherwise, we
>> aren't able to hit the issue.
>>
>>     -netdev tap,id=vnet0,vhost=true,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
>>     -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
> 
> 
> Given it's vhost, it's also possible that the issue is host side.
> I wonder what happens if we stick a delay or a stronger barrier
> in vhost.c - either here:
> 
>          /* Make sure buffer is written before we update index. */
>          smp_wmb();
> 
> 
> or here:
> 
>                  /* Only get avail ring entries after they have been
>                   * exposed by guest.
>                   */
>                  smp_rmb();
> 
> ?
> 

It's possible. However, I still can hit the issue after both of them are
replaed with '__mb()'. So the issue seems on the guest side, where the
written data isn't observed in time by the CPU on far end (for vhost worker).

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 045f666b4f12..327b68d21b02 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2529,7 +2529,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
                 /* Only get avail ring entries after they have been
                  * exposed by guest.
                  */
-               smp_rmb();
+               // smp_rmb();
+               __mb();
         }
  
         /* Grab the next descriptor number they're advertising, and increment
@@ -2703,7 +2704,9 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
         r = __vhost_add_used_n(vq, heads, count);
  
         /* Make sure buffer is written before we update index. */
-       smp_wmb();
+       // smp_wmb();
+       __mb();
+

 From the guest:

[   14.102608] virtio_net virtio0: output.0:id 80 is not a head!


>>>>
>>>>>
>>>>>>            vq->num_added++;
>>>>>>
>>>>>>            pr_debug("Added buffer head %i to %p\n", head, vq);
>>>>>>            END_USE(vq);
>>>>>>            :
>>>>>> }
>>>>>>
>>>>>> I also tried to measure the consumed time for various barrier-relative instructions using
>>>>>> ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
>>>>>> __smp_wmb() but faster than __mb()
>>>>>>
>>>>>>        Instruction           Range of used time in ns
>>>>>>        ----------------------------------------------
>>>>>>        __smp_wmb()           [32  1128032]
>>>>>>        __smp_mb()            [32  1160096]
>>>>>>        __mb()                [32  1162496]
>>>>>>

Thanks,
Gavin


