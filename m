Return-Path: <linux-kernel+bounces-107112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F0987F79D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF71B22528
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53357CF08;
	Tue, 19 Mar 2024 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvKPPN7/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E607CF25
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830340; cv=none; b=sBlrZ4lx724kmiOQ6UaFJP7Ad61jWy05uQUe1BWNf3CKvI2mmmvfwOMbnpTHy/AMnwXkTmMnxvSVG/i5hfQIsHrZ2ex7uU9d5sf8pjRQpv9V8h5cA1SpsDJmMGsIvEUqU/i9OgDEGH4jUPKBOduRnyEww3W9Oe0eVaCjlVPZfyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830340; c=relaxed/simple;
	bh=QgucDFrEr/SvLAZY1wBdMptDb13bGtRFhwoS3CnfYNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PITrePI3dfPub8ijfvEtYnQgHtkP+6ZDf/DtZlhnLSSYLrcVZdbtNZ/3JtfZx32X4aG8iGV1vXezGWLelwfjzhCLMlEkfEgmNZhTpqw+WFFHDbuiRRUE7K2pyCAgrYlJQoqtCRllVtm0t3IQtoDXUs4ez+EmRx8TVJY+1d7Q5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvKPPN7/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710830337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PWFWfjNWiRH0RK0T1uriWMCNRFoVCxB1MnvhpCDvFQ=;
	b=hvKPPN7/X4RBR2qEe50dzR5TTXOGdm0t8U+YHdlU78QtybURq1X5SBSixLS/iSib1ApG+e
	5RWRq73erimWIqoZXkynF7ALMOlMX6aTQz7WLIMWSSlorWcksXzKyRTdBE196wXk9uXTh4
	fiYJgo1lfpVrDdvWoWYfDFQdVotBzvo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-mY06-Ue7MYW1GQAE02riAA-1; Tue, 19 Mar 2024 02:38:56 -0400
X-MC-Unique: mY06-Ue7MYW1GQAE02riAA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e6bf91a8dfso5324608b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830335; x=1711435135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PWFWfjNWiRH0RK0T1uriWMCNRFoVCxB1MnvhpCDvFQ=;
        b=PfckpZLtBaf7sEsIstU7vkH6IDQhmQoDaVtNYzMOHB3NM5K32JGkta+tdPVzNk9+Bn
         vD9wqwTJVc0PMDYMBfJHdOojvYmL7J08R9h7FNQ2lj994bGzF6NVizFSvoD89L9L4gII
         DbCYo1vbZEy+yQYYv9LHAehwLKHHKxvpBeRnrQ8Mz79hRJnzQl2Olcy5h4pPrf0KLMzr
         aWgIlWAD1m2fCFT/RtBmrkY296a8FnBS7FrHfsPLxj0pK19/EuYgQzhlaEN4XACKETxc
         vEeUQCrIPFpMnd4DdK/ef1E+CzCnuWgPO2jnBFz/ZxwkEv7Hk5jpa/kGb4LLWK5oi2lm
         hRsA==
X-Forwarded-Encrypted: i=1; AJvYcCXkXm6tkYpDA4TOU2x9vEy1zE2UdseuUQENq6Hv+F5ZY/psAirwCPpF+AoDblMC1zzO9U4v1UxfXLeGSf+FfijA21rbXGDB93+//Usi
X-Gm-Message-State: AOJu0YxgpTvcO7FHHJqlkTC2AOMOTFwJl1qxl13u1CDZWDmI11rPDpT7
	mWYmi066f7RfurEhzcIvc/N5znAZmR4Y5u6Hr9lW9XlMHndGD7Nlh6TXK7MAeE5yNNYdQAyrJ6p
	6JzNt4Xe9xHuUoIX1ln0hoqj1bdAVgKMqy9kNR6dYG6rQEgYTY6Qqq3ITn+AmXA==
X-Received: by 2002:a05:6a21:78a9:b0:1a3:5299:1648 with SMTP id bf41-20020a056a2178a900b001a352991648mr11972189pzc.16.1710830335509;
        Mon, 18 Mar 2024 23:38:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4CuCVJiYhCSgYrUKlARZPvazBultLs5Ehqesd5coo9WIACzRgb9oUYr+Q8e3TOtm1pisQnQ==
X-Received: by 2002:a05:6a21:78a9:b0:1a3:5299:1648 with SMTP id bf41-20020a056a2178a900b001a352991648mr11972179pzc.16.1710830335114;
        Mon, 18 Mar 2024 23:38:55 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b001db8f7720e2sm10759114pln.288.2024.03.18.23.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:38:54 -0700 (PDT)
Message-ID: <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>
Date: Tue, 19 Mar 2024 16:38:49 +1000
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
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240319020905-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 16:09, Michael S. Tsirkin wrote:

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
>>>>    	vq->split.avail_idx_shadow++;
>>>>    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>    						vq->split.avail_idx_shadow);
>>>
>>> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
>>> here, especially when ordering accesses to coherent memory.
>>>
>>> In practice, either the larger timing different from the DSB or the fact
>>> that you're going from a Store->Store barrier to a full barrier is what
>>> makes things "work" for you. Have you tried, for example, a DMB SY
>>> (e.g. via __smb_mb()).
>>>
>>> We definitely shouldn't take changes like this without a proper
>>> explanation of what is going on.
>>>
>>
>> Thanks for your comments, Will.
>>
>> Yes, DMB should work for us. However, it seems this instruction has issues on
>> NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
>> from hardware level. I agree it's not the solution to replace DMB with DSB
>> before we fully understand the root cause.
>>
>> I tried the possible replacement like below. __smp_mb() can avoid the issue like
>> __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
>>
>> static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
>> {
>>      :
>>          /* Put entry in available array (but don't update avail->idx until they
>>           * do sync). */
>>          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>
>>          /* Descriptors and available array need to be set before we expose the
>>           * new available array entries. */
>>          // Broken: virtio_wmb(vq->weak_barriers);
>>          // Broken: __dma_mb();
>>          // Work:   __mb();
>>          // Work:   __smp_mb();
>>          // Work:   __ndelay(100);
>>          // Work:   __ndelay(10);
>>          // Broken: __ndelay(9);
>>
>>         vq->split.avail_idx_shadow++;
>>          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>                                                  vq->split.avail_idx_shadow);
> 
> What if you stick __ndelay here?
> 

        /* Put entry in available array (but don't update avail->idx until they
          * do sync). */
         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
         vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);

         /* Descriptors and available array need to be set before we expose the
          * new available array entries. */
         virtio_wmb(vq->weak_barriers);
         vq->split.avail_idx_shadow++;
         vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
                                                 vq->split.avail_idx_shadow);
         /* Try __ndelay(x) here as Michael suggested
          *
          * Work:      __ndelay(200);    possiblly make it hard to reproduce
          * Broken:    __ndelay(100);
          * Broken:    __ndelay(20);
          * Broken:    __ndelay(10);
          */
         __ndelay(200);


> 
>>          vq->num_added++;
>>
>>          pr_debug("Added buffer head %i to %p\n", head, vq);
>>          END_USE(vq);
>>          :
>> }
>>
>> I also tried to measure the consumed time for various barrier-relative instructions using
>> ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
>> __smp_wmb() but faster than __mb()
>>
>>      Instruction           Range of used time in ns
>>      ----------------------------------------------
>>      __smp_wmb()           [32  1128032]
>>      __smp_mb()            [32  1160096]
>>      __mb()                [32  1162496]
>>

Thanks,
Gavin


