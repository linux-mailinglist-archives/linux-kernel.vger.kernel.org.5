Return-Path: <linux-kernel+bounces-107126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D987F7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D0B282595
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AFE50A72;
	Tue, 19 Mar 2024 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSB5zlqu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B435026A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831268; cv=none; b=X/hEzsbi03s9p5VkW4r11jLoibJZN2RygC7bAX2fTkWFGm0Pj2LVDWzNv8A7umcirNs2wTC3cY7TMJ5DbUFBojeeqUG0wYW2/nuyiHuHspp546kAMu1rB7e33vS7+6MvZ5ibj7ubsZz1X0n63iAMNzV6S6dtLwIYQOOXMrrTS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831268; c=relaxed/simple;
	bh=BLv7Oj3VZ7iceafKAUY/widGHGZAc/uj42nv+VKIa/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HO9b0k2842UnN1ZulmbtFheLImzYJ1NwTeCsAO8Tu4TlDUiXPFy9YzwcZgfLlxlu/P6VURk9LdDTBPGHeur+cT0jE7T2eMdRpgey6wwwfM2c3tWgvkxdj3Yh/p+qUrwEdnPKO93CzMb9b+LiQb44XqP9p6WU0m0eW40c2nCZnB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSB5zlqu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710831266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icGFjCa1xrYUbecPG8RFGWPxGwZQyKoWyFdK0JxSbj4=;
	b=NSB5zlquofWIklgQoeLOvuVbecU3tmqJ3OT4DaOUnAGE45uaVMzgRazxj434Mw6Pc8LeCm
	oLd8qk61LyiTuN2Igp5ZqgFHOIjCGJGw4O5Y2Bgdtjerxz+8EUck9mDS3kszGJibOK6Kqg
	57rfLJ5SwWrlOq9KqIHtNoFhDX7n4ZQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-a5JklLPiNMWVaDz_3CznlQ-1; Tue, 19 Mar 2024 02:54:23 -0400
X-MC-Unique: a5JklLPiNMWVaDz_3CznlQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1defc12f8c1so42711315ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831262; x=1711436062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icGFjCa1xrYUbecPG8RFGWPxGwZQyKoWyFdK0JxSbj4=;
        b=POXLXLd1z4GLIyaZou5iNzU6ojj10qXC4pcem2wwb7XU7R37azJPQzEKsgjlzdnc+V
         y6eKnJTeS1dQ7MGgm8nr7GL0jQ6bIAhHJTjlUtE1hmhR5cC28u9Fiq5wKUJqQdOoENJa
         4g7jlvy+8upWCzziEX2+kj82jyFUs+v+uvcg8q2/lDSKa+a5rZSJPyyXWQoJsTxBFzLR
         cA0QadgdqDutEs5qdKHK+HggV2Clcdl2hQv+xXAJn9BvfURXE/VlKYyU7XMWCKCFdLSV
         bN08r5Gp2TU99UYdWdLZozSsEYZt6SYnnLvRi4VustxZycjtTvW8/bXU/dFfFXfTS6L7
         PoTA==
X-Forwarded-Encrypted: i=1; AJvYcCVzCULhEKgvibYR4WwlTlYfca1DSVh61E0M1IKX0U9eRP2B/UTkZ8Yf7EcRaILoHrkOz3mGGcDX7YBdzjNYf1C+6U5ejwZzdvaRm6na
X-Gm-Message-State: AOJu0YwEYGkK8u7+8QkbXsvKjeyPh1/r7Ome+MMKNJ1Pqp2zKlDsSsNk
	SgLDm+LfE6bX++tjTUxh2IRoU8TdAbTvkrEy7bQPVpkwFq2PElRa7mvoQDDoa0+fiOlbnsN/8aO
	cFhTGtoCI5ZV3yZykbZDWstoP2JYqOsXpgxy7YY5viLfIQ1Z3TwmfI51EjmQvHQ==
X-Received: by 2002:a17:902:e882:b0:1e0:1bfd:c1cd with SMTP id w2-20020a170902e88200b001e01bfdc1cdmr5859889plg.54.1710831262340;
        Mon, 18 Mar 2024 23:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS5nCGnHthe4SH4yG07pw+TKNbzItAryCrM74VL3kORDsmNhqLMKxBM1cXZ8h6C+/DTf6k8g==
X-Received: by 2002:a17:902:e882:b0:1e0:1bfd:c1cd with SMTP id w2-20020a170902e88200b001e01bfdc1cdmr5859880plg.54.1710831262001;
        Mon, 18 Mar 2024 23:54:22 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b001dee4bd73e0sm9335536pla.59.2024.03.18.23.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:54:21 -0700 (PDT)
Message-ID: <6b829cfc-9cbe-42eb-9935-62d2cf5fbcc4@redhat.com>
Date: Tue, 19 Mar 2024 16:54:15 +1000
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
 <20240319020949-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240319020949-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 16:10, Michael S. Tsirkin wrote:
> On Tue, Mar 19, 2024 at 02:09:34AM -0400, Michael S. Tsirkin wrote:
>> On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
>>> On 3/19/24 02:59, Will Deacon wrote:
[...]
>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>> index 49299b1f9ec7..7d852811c912 100644
>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>>>    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>>    	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>> -	/* Descriptors and available array need to be set before we expose the
>>>>> -	 * new available array entries. */
>>>>> -	virtio_wmb(vq->weak_barriers);
>>>>> +	/*
>>>>> +	 * Descriptors and available array need to be set before we expose
>>>>> +	 * the new available array entries. virtio_wmb() should be enough
>>>>> +	 * to ensuere the order theoretically. However, a stronger barrier
>>>>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>>>>> +	 * by the host (vhost). A stronger barrier should work for other
>>>>> +	 * architectures, but performance loss is expected.
>>>>> +	 */
>>>>> +	virtio_mb(false);
>>>>>    	vq->split.avail_idx_shadow++;
>>>>>    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>>    						vq->split.avail_idx_shadow);
>>>>
>>>> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
>>>> here, especially when ordering accesses to coherent memory.
>>>>
>>>> In practice, either the larger timing different from the DSB or the fact
>>>> that you're going from a Store->Store barrier to a full barrier is what
>>>> makes things "work" for you. Have you tried, for example, a DMB SY
>>>> (e.g. via __smb_mb()).
>>>>
>>>> We definitely shouldn't take changes like this without a proper
>>>> explanation of what is going on.
>>>>
>>>
>>> Thanks for your comments, Will.
>>>
>>> Yes, DMB should work for us. However, it seems this instruction has issues on
>>> NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
>>> from hardware level. I agree it's not the solution to replace DMB with DSB
>>> before we fully understand the root cause.
>>>
>>> I tried the possible replacement like below. __smp_mb() can avoid the issue like
>>> __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
>>>
>>> static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
>>> {
>>>      :
>>>          /* Put entry in available array (but don't update avail->idx until they
>>>           * do sync). */
>>>          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>
>>>          /* Descriptors and available array need to be set before we expose the
>>>           * new available array entries. */
>>>          // Broken: virtio_wmb(vq->weak_barriers);
>>>          // Broken: __dma_mb();
>>>          // Work:   __mb();
>>>          // Work:   __smp_mb();
> 
> Did you try __smp_wmb ? And wmb?
> 

virtio_wmb(false) is equivalent to __smb_wmb(), which is broken.

__wmb() works either. No issue found with it.

>>>          // Work:   __ndelay(100);
>>>          // Work:   __ndelay(10);
>>>          // Broken: __ndelay(9);
>>>
>>>         vq->split.avail_idx_shadow++;
>>>          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>                                                  vq->split.avail_idx_shadow);
>>
>> What if you stick __ndelay here?
> 
> And keep virtio_wmb above?
> 

The result has been shared through a separate reply.

>>
>>>          vq->num_added++;
>>>
>>>          pr_debug("Added buffer head %i to %p\n", head, vq);
>>>          END_USE(vq);
>>>          :
>>> }
>>>
>>> I also tried to measure the consumed time for various barrier-relative instructions using
>>> ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
>>> __smp_wmb() but faster than __mb()
>>>
>>>      Instruction           Range of used time in ns
>>>      ----------------------------------------------
>>>      __smp_wmb()           [32  1128032]
>>>      __smp_mb()            [32  1160096]
>>>      __mb()                [32  1162496]
>>>

Thanks,
Gavin


