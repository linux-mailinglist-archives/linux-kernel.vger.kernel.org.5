Return-Path: <linux-kernel+bounces-103253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6334387BD04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867A41C20D71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1AD5914B;
	Thu, 14 Mar 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSSm3Uxi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63718E20
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420627; cv=none; b=XOi97uVXWEMYfj9ZCMaVabJOyWnpyqkWwgxD2jJzZyUrdw8iwLZUvkjlppE9SeOCGpFjIcSf1lMGpB/aBsvvLfsPydHWYkoIYH/ijScctj7t+rsewf2sTD9hfH4lIOqZhzBbMqPhNRj9dFbSimzSxHLbF1bZPXLekyB+2Y7zny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420627; c=relaxed/simple;
	bh=dj1A/fUS1g7cQVRcUGlz9j57twwZfLXHvxcl85dh9bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mI0pCbQm4M5t6VsS5ODJBqAh4LuUziSooc+gKwTHidFMXKN56E/HXGf849QNUmW/un/brVJ3jbW9882JjtjJFjke+KUgm+kIVibQRIMxRaqfSxPa0WgVubAEIdf3zGI/Cv1Zd8p/YIo+3rhK3Sl2DnsgDI0TuYUykqGAU6qvVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSSm3Uxi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710420624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JugQATvY6YilsDeUh+JSk0j4lwCKfjARrjMcGpoo2I=;
	b=ZSSm3UxiY+Ix7/aP3c73+Mok7wEVBsmqB0Gsw+KBv+vjDeTv+yufQmSBzphPxlhgjXzJEf
	cEeBd0/o80PjVWA9qxYd+x/gjrTTc4moFl29ZLKfQNHZn3zS+S62ZpFu9ZCmncCUOvfNVY
	qxtrkVzkRG8EQ3NdD1kBJcNr+7JnC44=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-kwlrLBBYN9SfXEKWpFaqMQ-1; Thu, 14 Mar 2024 08:50:23 -0400
X-MC-Unique: kwlrLBBYN9SfXEKWpFaqMQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5ce12b4c1c9so582783a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710420621; x=1711025421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JugQATvY6YilsDeUh+JSk0j4lwCKfjARrjMcGpoo2I=;
        b=nNdLonqOhF7Z/kt9OM5q0R9vFEpNb/Pr6UWr0DUA8DsGjfCmUNGOjjauiMDkrPBs9c
         JkXvXNiF7aQu0TrOF2kuVQYOy+/hqvaCMLrVy7f6IlmCfeauQURlWIyed6TKcf93RVPH
         yOXS1Zo0XzITWZ6MGENjkZ+7t0ewjHCwAnhtkyj4rylTFR3AxXf2SXPbkQ8FN/bud5Tm
         I/CLl9FSTskieab6USsyDu+FA7w/UQ9h2To79GDmJy08X2/83UZle7lwgHKWV38eWD4T
         2GLvbWMNTToAq9sr6sOw1Vx6NKCc+CRDMoupkaBSNkq7W9yqHG6hfzNhgXmj4PfDCwxW
         zGsA==
X-Forwarded-Encrypted: i=1; AJvYcCVtdAdLPoWsE9PpH0yA8io1cmOqCzMvGpZ5vnxsx0f/AYzt+PJalzM5FbNJX6CJuUiN4e/zrRoE47ZnSqzor20SzTEHQS1FijMQrrME
X-Gm-Message-State: AOJu0YxhCXxZR629J53UTHzxhtkT4vzklGS9Uoot0VNHfZ5nh6QuxWxO
	MWnVK8VVllilij99adUgMhU9sYDlIhIUNopHeHgOuqCkharMSl6ifu/ZUgRmEVqDkJj2y1xC2bb
	82CZWAeuC00pVWXWa75VJ32k/284kRFJqM5YfoUMwiBjdE7LEWFyEXeA9V8ftDPEe+KYGbg==
X-Received: by 2002:a17:902:ba8c:b0:1dd:916d:771f with SMTP id k12-20020a170902ba8c00b001dd916d771fmr1299436pls.39.1710420621263;
        Thu, 14 Mar 2024 05:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqsGU2ry7VV2mdfejjivkYSa8XmnwJOgmDP+Hceb/WTio9PW3VdLpDdDFKJXGaRAfrmAiHuQ==
X-Received: by 2002:a17:902:ba8c:b0:1dd:916d:771f with SMTP id k12-20020a170902ba8c00b001dd916d771fmr1299421pls.39.1710420620870;
        Thu, 14 Mar 2024 05:50:20 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001db2ff16acasm1588244plf.128.2024.03.14.05.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 05:50:20 -0700 (PDT)
Message-ID: <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
Date: Thu, 14 Mar 2024 22:50:15 +1000
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
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
 shan.gavin@gmail.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240314074216-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 21:50, Michael S. Tsirkin wrote:
> On Thu, Mar 14, 2024 at 08:15:22PM +1000, Gavin Shan wrote:
>> On 3/14/24 18:05, Michael S. Tsirkin wrote:
>>> On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
>>>> The issue is reported by Yihuang Yu who have 'netperf' test on
>>>> NVidia's grace-grace and grace-hopper machines. The 'netperf'
>>>> client is started in the VM hosted by grace-hopper machine,
>>>> while the 'netperf' server is running on grace-grace machine.
>>>>
>>>> The VM is started with virtio-net and vhost has been enabled.
>>>> We observe a error message spew from VM and then soft-lockup
>>>> report. The error message indicates the data associated with
>>>> the descriptor (index: 135) has been released, and the queue
>>>> is marked as broken. It eventually leads to the endless effort
>>>> to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
>>>> and soft-lockup. The stale index 135 is fetched from the available
>>>> ring and published to the used ring by vhost, meaning we have
>>>> disordred write to the available ring element and available index.
>>>>
>>>>     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
>>>>     -accel kvm -machine virt,gic-version=host                            \
>>>>        :                                                                 \
>>>>     -netdev tap,id=vnet0,vhost=on                                        \
>>>>     -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
>>>>
>>>>     [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
>>>>
>>>> Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
>>>> virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
>>>> ARM64. It should work for other architectures, but performance loss is
>>>> expected.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    drivers/virtio/virtio_ring.c | 12 +++++++++---
>>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>> index 49299b1f9ec7..7d852811c912 100644
>>>> --- a/drivers/virtio/virtio_ring.c
>>>> +++ b/drivers/virtio/virtio_ring.c
>>>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>>    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>    	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>> -	/* Descriptors and available array need to be set before we expose the
>>>> -	 * new available array entries. */
>>>> -	virtio_wmb(vq->weak_barriers);
>>>> +	/*
>>>> +	 * Descriptors and available array need to be set before we expose
>>>> +	 * the new available array entries. virtio_wmb() should be enough
>>>> +	 * to ensuere the order theoretically. However, a stronger barrier
>>>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>>>> +	 * by the host (vhost). A stronger barrier should work for other
>>>> +	 * architectures, but performance loss is expected.
>>>> +	 */
>>>> +	virtio_mb(false);
>>>
>>>
>>> I don't get what is going on here. Any explanation why virtio_wmb is not
>>> enough besides "it does not work"?
>>>
>>
>> The change is replacing instruction "dmb" with "dsb". "dsb" is stronger barrier
>> than "dmb" because "dsb" ensures that all memory accesses raised before this
>> instruction is completed when the 'dsb' instruction completes. However, "dmb"
>> doesn't guarantee the order of completion of the memory accesses.
>>
>> So 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
>> can be completed before 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
> 
> Completed as observed by which CPU?
> We have 2 writes that we want observed by another CPU in order.
> So if CPU observes a new value of idx we want it to see
> new value in ring.
> This is standard use of smp_wmb()
> How are these 2 writes different?
> 
> What DMB does, is that is seems to ensure that effects
> of 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
> are observed after effects of
> 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
> 
>

Completed as observed by the CPU where vhost worker is running. I don't think DMB
does the work here. If I'm understanding correctly, DMB ensures the order of these
two writes from the local CPU's standpoint. The written data can be stored in local
CPU's cache, not flushed to DRAM and propogated to the cache of the far CPU where
vhost worker is running. So DMB isn't ensuring the write data is observed from the
far CPU.

DSB ensures that the written data is observable from the far CPU immediately.
  
> 
> 
>> The stronger barrier 'dsb' ensures the completion order as we expected.
>>
>>      virtio_wmb(true)         virt_mb(false)
>>        virt_wmb                 mb
>>          __smp_wmb               __mb
>>            dmb(ishst)              dsb(sy)
> 
> First, why would you want a non smp barrier when you are
> synchronizing with another CPU? This is what smp_ means ...
> 
> 
>> Extraced from ARMv9 specificaton
>> ================================
>> The DMB instruction is a memory barrier instruction that ensures the relative
>> order of memory accesses before the barrier with memory accesses after the
>> barrier. The DMB instruction _does not_ ensure the completion of any of the
>> memory accesses for which it ensures relative order.
> 
> Isn't this exactly what we need?
> 

I don't think so. DMB gurantees the order of EXECUTION, but DSB gurantees the
order of COMPLETION. After the data store is executed, the written data can
be stored in local CPU's cache, far from completion. Only the instruction is
completed, the written data is synchronized to the far CPU where vhost worker
is running.

Here is another paper talking about the difference between DMB and DSB. It's
explaining the difference between DMB/DSB better than ARMv9 specification.
However, it's hard for us to understand DMB/DSB work from the hardware level
based on the specification and paper.

https://ipads.se.sjtu.edu.cn/_media/publications/liuppopp20.pdf
(section 2.2  Order-preserving Options)
(I'm extracting the relevant part as below)

Data Memory Barrier (DMB) prevents reordering of memory accesses across the barrier.
Instead of waiting for previous accesses to become observable in the specified domain,
DMB only maintains the relative order between memory accesses. Meanwhile, DMB does
not block any non-memory access operations.

Data Synchronization Barrier (DSB) prevents reordering of any instructions across
the barrier. DSB will make sure that all masters in the specified domain can observe
the previous operations before issuing any subsequent instructions.

>> A DSB instruction is a memory barrier that ensures that memory accesses that
>> occur before the DSB instruction have __completed__ before the completion of
>> the DSB instruction.
> 
> This seems appropriate for when you want to order things more
> strongly. I do not get why it's necessary here.
> 

Please refer to above explanations.

>> In doing this, it acts as a stronger barrier than a DMB
>> and all ordering that is created by a DMB with specific options is also generated
>> by a DSB with the same options.
>>
>>>>    	vq->split.avail_idx_shadow++;
>>>>    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>    						vq->split.avail_idx_shadow);
>>>> -- 
>>>> 2.44.0
>>>

Thanks,
Gavin


