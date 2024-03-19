Return-Path: <linux-kernel+bounces-107000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9264E87F67E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67DC282B88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710143FBA5;
	Tue, 19 Mar 2024 04:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd3i17hi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8DE3E493
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824376; cv=none; b=MGMRR9KUPO4ytHWT/MM3nze9MNt54jbCNlJrn6bVjFAo7wf7QpWfwB8xB4zyTLQIq48fmAptU3Q0Iu/x0nUIxPIUZb9xWbuiKzGjE+OMMxYkX4d7qqtgy8850xgvJKsxSXktuYtufekqf9RkmiuMEPCdi4yTImTWGh1j3L+j2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824376; c=relaxed/simple;
	bh=H25pV8GSi6kp97XrxGRMTfAEDXe6ifzhNJrWrlDdp/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFcrzbixehIADFPQGELi/YsSenBs3a2jvt1JvOZB/4tjLRN453XRxf5E47p2tTqmXaf8XZt4uBeB5WTx+py6yiK/gUgsoQSNwPfdiwYNx05n+jK4Sa3qxVOe/LcEW1WTlIkniJyIgmJeaTCJ7eUk57g6bweXI6II7b9mZY+i8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jd3i17hi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710824373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu1fZTuW5w55lZyjKAedr2/F7yOPJnQYv8yLHqlcanI=;
	b=Jd3i17hiPdXeSBr88f2iH7IububSOVui91PPAQGtHTkygiDXEsCb0Xa4w3erEJuzVU7IGT
	qWvU7MeWVi+UQTU2OPJrUX2dgCTF0wsu7cEhSJxt67zbHLAVuGE0CS2Ewl8+2RK4Aa8F1X
	EAt5COuFaDM9FG5qGE/xPbIBZheRqkM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-KNQcD0mENoujdTowYAFKag-1; Tue, 19 Mar 2024 00:59:31 -0400
X-MC-Unique: KNQcD0mENoujdTowYAFKag-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e714ccb73fso1402895b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710824370; x=1711429170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eu1fZTuW5w55lZyjKAedr2/F7yOPJnQYv8yLHqlcanI=;
        b=MRaHg2e8VMzWGMMK2Kh1Ilhfz5OtwcXR7vOChXallLT4RJt0Bg4UW1HwhLpo3Lc/3i
         eJmKwb8SXetagn94bnKNd2npEKTXXHlWU4hSLGPqdwzrThf0OtS2UN6egScAiojcUQc/
         kCcEVTgJj6TFV95ywoldDmsZgR0LR7Yjd/6hXIKpNs6CBtz2G0nxoxLLZns3TDsUwmOV
         oN4hraBv0852wsIdRzW27m8c1LFnlriQttz9ThOQg+nb83KTs9Gr6Jsd4YHJaSki65Z7
         h7l3HvAggm52EGlH36Gb5zhvHKMuC5Uc315HRfDgRxrjBvHT3bQ1ApASKyrP6T2YHgkK
         UpGA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Eq6/F07VgwDsFU8o3Tngde8bgmux80sAshD3UQS7yow5+kLDXJ+Y9fEo0US9bToBKrrN7SKo/oEuWuc44LeM2VVc3+dcFI7CxlyM
X-Gm-Message-State: AOJu0YxQVjllGeiGWJmdNAZ7ae8cPZdFlW+vo52+okIZjOWu9eVLi6xR
	kk2bF9OI7azQAqF/Pf9Yyyk27C/eZW+OfkCtTcl9XL1UuQsNA1rxu2QMAVs3O8LJ6AsKegXG9Hd
	wgS9D9SfV6ubMo+vwJp929/cfQLt/5jSe+uC2TDhGondXA4A5ApJIv4xgKdPnSQ==
X-Received: by 2002:aa7:85c4:0:b0:6e7:2199:6791 with SMTP id z4-20020aa785c4000000b006e721996791mr5561441pfn.21.1710824370515;
        Mon, 18 Mar 2024 21:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDQe1IN2wAF4VXFN5LqilMUu9jTHpCmZYTCvncFnnI71NO8xd5+5kCQNJYibUaJASRkbY8dg==
X-Received: by 2002:aa7:85c4:0:b0:6e7:2199:6791 with SMTP id z4-20020aa785c4000000b006e721996791mr5561425pfn.21.1710824370136;
        Mon, 18 Mar 2024 21:59:30 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id t23-20020a63b257000000b005dcbb699abfsm8145276pgo.34.2024.03.18.21.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 21:59:29 -0700 (PDT)
Message-ID: <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
Date: Tue, 19 Mar 2024 14:59:23 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Content-Language: en-US
To: Will Deacon <will@kernel.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 yihyu@redhat.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240318165924.GA1824@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 02:59, Will Deacon wrote:
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
>>   	vq->split.avail_idx_shadow++;
>>   	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>   						vq->split.avail_idx_shadow);
> 
> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> here, especially when ordering accesses to coherent memory.
> 
> In practice, either the larger timing different from the DSB or the fact
> that you're going from a Store->Store barrier to a full barrier is what
> makes things "work" for you. Have you tried, for example, a DMB SY
> (e.g. via __smb_mb()).
> 
> We definitely shouldn't take changes like this without a proper
> explanation of what is going on.
> 

Thanks for your comments, Will.

Yes, DMB should work for us. However, it seems this instruction has issues on
NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
from hardware level. I agree it's not the solution to replace DMB with DSB
before we fully understand the root cause.

I tried the possible replacement like below. __smp_mb() can avoid the issue like
__mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.

static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
{
     :
         /* Put entry in available array (but don't update avail->idx until they
          * do sync). */
         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
         vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);

         /* Descriptors and available array need to be set before we expose the
          * new available array entries. */
         // Broken: virtio_wmb(vq->weak_barriers);
         // Broken: __dma_mb();
         // Work:   __mb();
         // Work:   __smp_mb();
         // Work:   __ndelay(100);
         // Work:   __ndelay(10);
         // Broken: __ndelay(9);

        vq->split.avail_idx_shadow++;
         vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
                                                 vq->split.avail_idx_shadow);
         vq->num_added++;

         pr_debug("Added buffer head %i to %p\n", head, vq);
         END_USE(vq);
         :
}

I also tried to measure the consumed time for various barrier-relative instructions using
ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
__smp_wmb() but faster than __mb()

     Instruction           Range of used time in ns
     ----------------------------------------------
     __smp_wmb()           [32  1128032]
     __smp_mb()            [32  1160096]
     __mb()                [32  1162496]

Thanks,
Gavin


