Return-Path: <linux-kernel+bounces-103107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F787BB1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E561F23310
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B66E61E;
	Thu, 14 Mar 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBYRvSHH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B06F06C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411333; cv=none; b=qciqk6dLUmnbbIDBPW7gN8qgRPLqfxgqAscRD2L5X8XjC7MhSndMFYSCp5zB7IPbTuEBJicFiXwR4PHiXT/zAuLoOOrI+fOD2WsUzbTnFtZIdzRqz0KJy3au2qplUC68btpd3fu9LfXYYBiwJ5kai/HWijy+CgC+mBZaqacGeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411333; c=relaxed/simple;
	bh=ycsW7LzYI2X7GBwi/xPk4fdSIDiJftf7KAKOzrECOFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soNBgzUxcaCG59qgUtGD9xZNbjbVA79T/S6h8Pwkot7A2Tmphdkts9GBF/a6vXWuONn0+Cy+NGlSj0WD8aZj3qbWlTRLVN+rx/6sME8klgmfKxRO6C4oxt7/j1CeI/q6AwW0VwU7jTujE0wxHEpwjB7AVeSsOpbMLG6nHbOdp4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBYRvSHH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710411330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1Uxb+6viRMpNE9ltOLx40J6IZsgLFNrkQ0OvLIySyw=;
	b=fBYRvSHHduQyqgVDQ+YLPHEK8PBQ3jzIAXxdtnruIvm4tgNzZBmykV0nvhbafst+cfcqnH
	k/B+FjiT43O5ecwQZui85n6yFytJvXW4ofS2PVFnlXTTlkmVuTcK2IxPFNx1V4/hv7V/Te
	s4n1LusnY6xnXblMEgAnQQZoFqvYiV0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-Mo-HSep8MOmL2uJu3LsZyA-1; Thu, 14 Mar 2024 06:15:29 -0400
X-MC-Unique: Mo-HSep8MOmL2uJu3LsZyA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dbddee3694so489889a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710411328; x=1711016128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Uxb+6viRMpNE9ltOLx40J6IZsgLFNrkQ0OvLIySyw=;
        b=epqwDHpZDeQG5o9P6tW3AXNjde9s7YFhdZQX+zkBPXn+opAHaJ0JksDICXPVvefOLU
         ClrL05Iyi1Y0Isp75+iEvjZ2FBpGG3SuSxCXBl63C2ffGIbg+CyMHcKTOeF6vsYfn/oq
         Ex+SCeYu8y9TRpuPcnynYcndxqpqDWiQLVGIMcWfjyOOLWf0kXDZbHG2eReD6ENhk33V
         +Iz+uYa62jp9KpBmhZK1o4EBSAWiDInIvc/zxebjgu8HMloU12OROdpGbScTdS9yR0VY
         tePxZWlegkL9PvvgIn/ekVIDGcnp07ilUP7sTFEuZObD2l90I4hremgYqKLnB2NOKqlO
         xNqw==
X-Forwarded-Encrypted: i=1; AJvYcCW9XJHUZySQcwV9//93JR4bHEeCaSWy1sRaLXfWhUh6p4+zMtkE3ZVANltq6Xuow0VCqdUKfW4YENqWrJeU9MsypVC9wYIo2dz3HVv1
X-Gm-Message-State: AOJu0YxZYsmjBTlLa8yb0yZEguDBYqwY/KjBKVmMlKssfA50OnhVILEP
	fh9m1BDOOFtyQMBBnXwz5+r3e0kiW7rpC5J4rc7VPTLY14rwkV3YwgpdG7P2m/Rdiq1C8TbhLae
	vzeGGZ407cgFwGHrD1MCMNl0n+kcRd41BjsvssOkSdOKaUdmBDfBrGfq/eW5mUw==
X-Received: by 2002:a17:902:ce87:b0:1dc:7101:58c0 with SMTP id f7-20020a170902ce8700b001dc710158c0mr7610153plg.22.1710411328139;
        Thu, 14 Mar 2024 03:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBfGxwiSyPHkLnxtwxkJJyRl1lXhku6m/rd49AH3cwYX8QYQ0bzga29lt8nOAFDxAXNKvfIA==
X-Received: by 2002:a17:902:ce87:b0:1dc:7101:58c0 with SMTP id f7-20020a170902ce8700b001dc710158c0mr7610128plg.22.1710411327738;
        Thu, 14 Mar 2024 03:15:27 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id v2-20020a170903238200b001dc3c4e7a12sm1302622plh.14.2024.03.14.03.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 03:15:26 -0700 (PDT)
Message-ID: <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
Date: Thu, 14 Mar 2024 20:15:22 +1000
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
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240314040443-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 18:05, Michael S. Tsirkin wrote:
> On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
>> The issue is reported by Yihuang Yu who have 'netperf' test on
>> NVidia's grace-grace and grace-hopper machines. The 'netperf'
>> client is started in the VM hosted by grace-hopper machine,
>> while the 'netperf' server is running on grace-grace machine.
>>
>> The VM is started with virtio-net and vhost has been enabled.
>> We observe a error message spew from VM and then soft-lockup
>> report. The error message indicates the data associated with
>> the descriptor (index: 135) has been released, and the queue
>> is marked as broken. It eventually leads to the endless effort
>> to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
>> and soft-lockup. The stale index 135 is fetched from the available
>> ring and published to the used ring by vhost, meaning we have
>> disordred write to the available ring element and available index.
>>
>>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
>>    -accel kvm -machine virt,gic-version=host                            \
>>       :                                                                 \
>>    -netdev tap,id=vnet0,vhost=on                                        \
>>    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
>>
>>    [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
>>
>> Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
>> virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
>> ARM64. It should work for other architectures, but performance loss is
>> expected.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 49299b1f9ec7..7d852811c912 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>   	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>   	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>   
>> -	/* Descriptors and available array need to be set before we expose the
>> -	 * new available array entries. */
>> -	virtio_wmb(vq->weak_barriers);
>> +	/*
>> +	 * Descriptors and available array need to be set before we expose
>> +	 * the new available array entries. virtio_wmb() should be enough
>> +	 * to ensuere the order theoretically. However, a stronger barrier
>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>> +	 * by the host (vhost). A stronger barrier should work for other
>> +	 * architectures, but performance loss is expected.
>> +	 */
>> +	virtio_mb(false);
> 
> 
> I don't get what is going on here. Any explanation why virtio_wmb is not
> enough besides "it does not work"?
> 

The change is replacing instruction "dmb" with "dsb". "dsb" is stronger barrier
than "dmb" because "dsb" ensures that all memory accesses raised before this
instruction is completed when the 'dsb' instruction completes. However, "dmb"
doesn't guarantee the order of completion of the memory accesses.

So 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
can be completed before 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
The stronger barrier 'dsb' ensures the completion order as we expected.

     virtio_wmb(true)         virt_mb(false)
       virt_wmb                 mb
         __smp_wmb               __mb
           dmb(ishst)              dsb(sy)
       

Extraced from ARMv9 specificaton
================================
The DMB instruction is a memory barrier instruction that ensures the relative
order of memory accesses before the barrier with memory accesses after the
barrier. The DMB instruction _does not_ ensure the completion of any of the
memory accesses for which it ensures relative order.

A DSB instruction is a memory barrier that ensures that memory accesses that
occur before the DSB instruction have __completed__ before the completion of
the DSB instruction. In doing this, it acts as a stronger barrier than a DMB
and all ordering that is created by a DMB with specific options is also generated
by a DSB with the same options.

>>   	vq->split.avail_idx_shadow++;
>>   	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>   						vq->split.avail_idx_shadow);
>> -- 
>> 2.44.0
> 

Thanks,
Gavin


