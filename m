Return-Path: <linux-kernel+bounces-107125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D487F7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84233282466
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12250A64;
	Tue, 19 Mar 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6WltMaD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF650251
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831002; cv=none; b=XTZ+LZ6hszC+Qm9oGwOBICDp/3RMM4rOBFDIW7BMNHJeOqHMDVDzYp+AIvv1z5R6Tp1mSp0MZBdF65zbg8jNV0AWv/AlySyNitUEdz/DudEq+w2lr4HHw/XidgiZbt4ak/4IY+5uBptjgB5ABgSoYW0ftL8ne0uOIN8VyzYwRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831002; c=relaxed/simple;
	bh=aAAOjIcdCmrA6w5EYSQrYytslxpwys0/xrXrbpOVw+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mj+fa8hNDq0GRbw0gjIrO28N+Da9RgCkpfp+VhtcN6smYMQa+jiQrnr3u7LqR5FAfx5lTvux2iqlUOufOZ8614w4lhlG8ZUK5znTg5WlJVgJbi5CjAfSkqysfYb0LYxGjZPC2jLjhvl95bMH0ge/fJKocu8gsMjzOeWTFU9X/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6WltMaD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710830999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54K9Aan0cu3REAqcfqTLKTel3R8LJu9NC8k5kcQjpFY=;
	b=D6WltMaDE/C914iqaotWhueD5+m7wGXJCrcHkccMtyHS/FWYupVO2hTvFTm1YN24qlCnQy
	70kd1iYanc42qk6g8n1g2pF10z58WTT3QjV/RkJQbPi2o4SN+i+v8NMhfwkWuWHDzzvPNz
	iDEQtgeITQlx2PK7eONSSbFXWNsZ3Sk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-CwdvntctP1WfA4g-xJgckQ-1; Tue, 19 Mar 2024 02:49:58 -0400
X-MC-Unique: CwdvntctP1WfA4g-xJgckQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso3523996a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830997; x=1711435797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54K9Aan0cu3REAqcfqTLKTel3R8LJu9NC8k5kcQjpFY=;
        b=oP6zEFZIK/vzWxcbcljzXR5VGzb7/f+7oBYik29ImvJm1TbbdleWswvxrmioxPRtg/
         TGnR4vrReYynX0RUA1SA8iDSVD1EoIDD8yvH76AOle1YP/TNQBeMMO+Zvx3tRVMTsG4T
         nQKk8nyVwU+FCyPNTUKDf3hUOLNZZDOdjuDwFcsAminmXR1sKZP8JkKTT+YafYci+ZYK
         W7tEMD/cEehTCwNUZ5g0TzTUzZpru7g8PD7f2EVVAbnY98SeNQ7LbuV/lQYACYmGqwES
         s2I7GnHb79D08g7xmfALY8Jo3e6mOMSOlzh5ntiDf5TZoRFhjTdSd0egF8iMOVUPn1tZ
         09gg==
X-Forwarded-Encrypted: i=1; AJvYcCUAs1PiLjZvUZKbvCHuDtMYyv1lw0Dn+lOOBJhPZByXZUkx4yfxAvKK00R7uOcSQXumaW7GDEDyhx/+8crCGG77pL1ami4MPTiQNoY9
X-Gm-Message-State: AOJu0Yx3Zavv2zr8WJ72KikFoztFh9v8Zw+k5L+NyCYdiJhOjH4GBDjv
	cdizb/3stQ6eIijc1CpTXq41HPjCkbhy7SzdyQh3CVY8tBMEqpbPGcB5LfPLg2YtfQtKgyaVsuN
	PSFPfEpl/F7j608x41n6RuCRVcSmOfoMH5Ckh6b3qBL3fp5HO7ohPN+TCkk3alg==
X-Received: by 2002:a05:6a20:3ca9:b0:1a1:4da9:8d76 with SMTP id b41-20020a056a203ca900b001a14da98d76mr11912686pzj.13.1710830997082;
        Mon, 18 Mar 2024 23:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS+OocIF+N58LhSGTnrl1U7A3D0wb3SIiUeolvJ3UUlQT9d2AHZK5rdxRRvm6v24Qw6GAA2Q==
X-Received: by 2002:a05:6a20:3ca9:b0:1a1:4da9:8d76 with SMTP id b41-20020a056a203ca900b001a14da98d76mr11912677pzj.13.1710830996764;
        Mon, 18 Mar 2024 23:49:56 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b001dd7d66ac95sm10665458plk.78.2024.03.18.23.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:49:56 -0700 (PDT)
Message-ID: <d8387677-7025-4daa-b8b5-5a8f24a671d5@redhat.com>
Date: Tue, 19 Mar 2024 16:49:50 +1000
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
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240319024025-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/19/24 16:43, Michael S. Tsirkin wrote:
> On Tue, Mar 19, 2024 at 04:38:49PM +1000, Gavin Shan wrote:
>> On 3/19/24 16:09, Michael S. Tsirkin wrote:
>>
>>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>>> index 49299b1f9ec7..7d852811c912 100644
>>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>>>>     	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>>>     	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>>> -	/* Descriptors and available array need to be set before we expose the
>>>>>> -	 * new available array entries. */
>>>>>> -	virtio_wmb(vq->weak_barriers);
>>>>>> +	/*
>>>>>> +	 * Descriptors and available array need to be set before we expose
>>>>>> +	 * the new available array entries. virtio_wmb() should be enough
>>>>>> +	 * to ensuere the order theoretically. However, a stronger barrier
>>>>>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>>>>>> +	 * by the host (vhost). A stronger barrier should work for other
>>>>>> +	 * architectures, but performance loss is expected.
>>>>>> +	 */
>>>>>> +	virtio_mb(false);
>>>>>>     	vq->split.avail_idx_shadow++;
>>>>>>     	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>>>     						vq->split.avail_idx_shadow);
>>>>>
>>>>> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
>>>>> here, especially when ordering accesses to coherent memory.
>>>>>
>>>>> In practice, either the larger timing different from the DSB or the fact
>>>>> that you're going from a Store->Store barrier to a full barrier is what
>>>>> makes things "work" for you. Have you tried, for example, a DMB SY
>>>>> (e.g. via __smb_mb()).
>>>>>
>>>>> We definitely shouldn't take changes like this without a proper
>>>>> explanation of what is going on.
>>>>>
>>>>
>>>> Thanks for your comments, Will.
>>>>
>>>> Yes, DMB should work for us. However, it seems this instruction has issues on
>>>> NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
>>>> from hardware level. I agree it's not the solution to replace DMB with DSB
>>>> before we fully understand the root cause.
>>>>
>>>> I tried the possible replacement like below. __smp_mb() can avoid the issue like
>>>> __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
>>>>
>>>> static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
>>>> {
>>>>       :
>>>>           /* Put entry in available array (but don't update avail->idx until they
>>>>            * do sync). */
>>>>           avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>           vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>
>>>>           /* Descriptors and available array need to be set before we expose the
>>>>            * new available array entries. */
>>>>           // Broken: virtio_wmb(vq->weak_barriers);
>>>>           // Broken: __dma_mb();
>>>>           // Work:   __mb();
>>>>           // Work:   __smp_mb();
>>>>           // Work:   __ndelay(100);
>>>>           // Work:   __ndelay(10);
>>>>           // Broken: __ndelay(9);
>>>>
>>>>          vq->split.avail_idx_shadow++;
>>>>           vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>                                                   vq->split.avail_idx_shadow);
>>>
>>> What if you stick __ndelay here?
>>>
>>
>>         /* Put entry in available array (but don't update avail->idx until they
>>           * do sync). */
>>          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>
>>          /* Descriptors and available array need to be set before we expose the
>>           * new available array entries. */
>>          virtio_wmb(vq->weak_barriers);
>>          vq->split.avail_idx_shadow++;
>>          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>                                                  vq->split.avail_idx_shadow);
>>          /* Try __ndelay(x) here as Michael suggested
>>           *
>>           * Work:      __ndelay(200);    possiblly make it hard to reproduce
>>           * Broken:    __ndelay(100);
>>           * Broken:    __ndelay(20);
>>           * Broken:    __ndelay(10);
>>           */
>>          __ndelay(200);
> 
> So we see that just changing the timing masks the race.
> What are you using on the host side? vhost or qemu?
> 

__ndelay(200) may make the issue harder to be reproduce as I understand.
More delays here will give vhost relief, reducing the race.

The issue is only reproducible when vhost is turned on. Otherwise, we
aren't able to hit the issue.

    -netdev tap,id=vnet0,vhost=true,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0

>>
>>>
>>>>           vq->num_added++;
>>>>
>>>>           pr_debug("Added buffer head %i to %p\n", head, vq);
>>>>           END_USE(vq);
>>>>           :
>>>> }
>>>>
>>>> I also tried to measure the consumed time for various barrier-relative instructions using
>>>> ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
>>>> __smp_wmb() but faster than __mb()
>>>>
>>>>       Instruction           Range of used time in ns
>>>>       ----------------------------------------------
>>>>       __smp_wmb()           [32  1128032]
>>>>       __smp_mb()            [32  1160096]
>>>>       __mb()                [32  1162496]
>>>>

Thanks,
Gavin


