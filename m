Return-Path: <linux-kernel+bounces-120436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDD88D75A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B43296AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB6928DD5;
	Wed, 27 Mar 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bq4sDJ+M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259918E0E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711524948; cv=none; b=IIxCpZ5YA3ByxBvWCCOBxnbhZN+cRKwIOaliqhsmDWcUlbZqAufHVWab5ZljKJNvROBHn71iXExaqFqROEzpaTqcmxl2RvInLuWzVK/agTDXexTrAh36SWgQHK7j59P9lFTx0tix+W1hyVoNyxejYG9Xj6kPfiCJ/6DLYh/7fWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711524948; c=relaxed/simple;
	bh=bEIESxajHi7+7uF5dtuaErz6weAJvZP3ZUqWqn6MtMg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KjuJ8SnIL80Zo3Wabl+lpfMcYooVWbpuwV1nESxMwl1DBagQbESFXDd69Ebr2GvJ47xKrNoP5g5FYQq9dEbo+5HOAojjhSyE9CL2SE6LowWO/gGjc1uRYXDG9/NvTNf1tiuC+YepLYm8vJuXR7yOBUoM+qdVCiqxHWOaFq8Rvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bq4sDJ+M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711524945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBHWpEolUlxHl5JRkXZCUqHVrIqZhka0kKbL3ylcBdg=;
	b=Bq4sDJ+Mz3X/MpS5TtB4B9f2GAKpL/Q95qp7pgUtGimEH9n4vt34qAIr/ILM+iHAp8Sxlr
	VIgnBvYQHarcLpP01xl0B7K5IjO84lzP8m0ihNpuI31DNtOjvHEjbJMfrKFtJUSz6ngzds
	EohYIRtQ7urcVC+AbV97uxTncIR2NtI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-Ohpk9gpiP8-wuSCfhUyLvQ-1; Wed, 27 Mar 2024 03:35:41 -0400
X-MC-Unique: Ohpk9gpiP8-wuSCfhUyLvQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ea844bfbb7so4261706b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711524940; x=1712129740;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBHWpEolUlxHl5JRkXZCUqHVrIqZhka0kKbL3ylcBdg=;
        b=EjRvzUwXECRRSzdmawTQw8TVywYggW8Ji2oCT3JVUmosC0R7xDce32rc3nv7NJWpDm
         qSkePbCT7np2K0h49v99aRlaVoW846UNYtRZlZbYz8uuaz37o8+UVRP/H9FDPqIxeuzQ
         w7/OTUsK9c95EG+aDQkPDkHxRW2pRV9U9dE5kHeyxxAyjnbcUFyl4ej6Re4KJaBDAwQw
         ChO9k9fyr47FdFfgyr1F4w9HO/7ssw+kpcojUA7Q75TnPvK2nKuxwl8qG14FmCS4WRPg
         9cK4G20wLTXGntvooumIhqZgUH64xgIlYHdxD0XS/p9XLtCwVGatyBmp8YXyXXBkz9Vz
         DUsg==
X-Forwarded-Encrypted: i=1; AJvYcCX2GepqexwvjOhb2tF1hBwFWaM/a+xghAaAWpJJxjh8dNZeXlsK5YY3iin0TdKVqLioZOmCL0lCDDBHlJN85iSQF+FTbW48QrEjC6d4
X-Gm-Message-State: AOJu0YxPQdgZfnir+LlxJKc7BWFavw2ncl/y78kp09kBu7KR/WahtWhm
	S3IVquGKfMw2j9WPiy7UfgwOIpEIxDgS0qQrHpqpYBog1Q14z2znnTgwv70qXgu8XRUywfAW/qI
	LVfPhMj14sTPaks5zu29TwKkzAg+ZcT8ooPhq8OqvRPjuxcbg9ovzizLejFB5og==
X-Received: by 2002:a05:6a00:2d82:b0:6e5:faca:3683 with SMTP id fb2-20020a056a002d8200b006e5faca3683mr704780pfb.26.1711524940636;
        Wed, 27 Mar 2024 00:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjt4K1Cq6NY6Cd/AaDyAh0HsKkEeyoejGT6KcrCd5wHX1enX12T6bxxZRugOpdNA2FLdEubA==
X-Received: by 2002:a05:6a00:2d82:b0:6e5:faca:3683 with SMTP id fb2-20020a056a002d8200b006e5faca3683mr704765pfb.26.1711524940258;
        Wed, 27 Mar 2024 00:35:40 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id h3-20020a655183000000b005e83b3ce8d9sm7544142pgq.8.2024.03.27.00.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 00:35:39 -0700 (PDT)
Message-ID: <92ac171a-0004-45ef-a6c8-01b1c135a8ca@redhat.com>
Date: Wed, 27 Mar 2024 17:35:32 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
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
In-Reply-To: <b6f4e8c1-bdd1-496e-aa1a-68349674671c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/24 14:08, Gavin Shan wrote:
> On 3/27/24 12:44, Jason Wang wrote:
>> On Wed, Mar 27, 2024 at 10:34 AM Jason Wang <jasowang@redhat.com> wrote:
>>> On Wed, Mar 27, 2024 at 7:39 AM Gavin Shan <gshan@redhat.com> wrote:
>>>>
>>>> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
>>>> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
>>>> available ring entries pushed by guest can be observed by vhost
>>>> in time, leading to stale available ring entries fetched by vhost
>>>> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
>>>> grace-hopper (ARM64) platform.
>>>>
>>>>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>>>>    -accel kvm -machine virt,gic-version=host -cpu host          \
>>>>    -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>>>>    -m 4096M,slots=16,maxmem=64G                                 \
>>>>    -object memory-backend-ram,id=mem0,size=4096M                \
>>>>     :                                                           \
>>>>    -netdev tap,id=vnet0,vhost=true                              \
>>>>    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
>>>>     :
>>>>    guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>>>>    virtio_net virtio0: output.0:id 100 is not a head!
>>>>
>>>> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
>>>> should be safe until vq->avail_idx is changed by commit 275bf960ac697
>>>> ("vhost: better detection of available buffers").
>>>>
>>>> Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
>>>> Cc: <stable@kernel.org> # v4.11+
>>>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>   drivers/vhost/vhost.c | 11 ++++++++++-
>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>> index 045f666b4f12..00445ab172b3 100644
>>>> --- a/drivers/vhost/vhost.c
>>>> +++ b/drivers/vhost/vhost.c
>>>> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>>>          r = vhost_get_avail_idx(vq, &avail_idx);
>>>>          if (unlikely(r))
>>>>                  return false;
>>>> +
>>>>          vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>>>> +       if (vq->avail_idx != vq->last_avail_idx) {
>>>> +               /* Similar to what's done in vhost_get_vq_desc(), we need
>>>> +                * to ensure the available ring entries have been exposed
>>>> +                * by guest.
>>>> +                */
>>>
>>> We need to be more verbose here. For example, which load needs to be
>>> ordered with which load.
>>>
>>> The rmb in vhost_get_vq_desc() is used to order the load of avail idx
>>> and the load of head. It is paired with e.g virtio_wmb() in
>>> virtqueue_add_split().
>>>
>>> vhost_vq_avail_empty() are mostly used as a hint in
>>> vhost_net_busy_poll() which is under the protection of the vq mutex.
>>>
>>> An exception is the tx_can_batch(), but in that case it doesn't even
>>> want to read the head.
>>
>> Ok, if it is needed only in that path, maybe we can move the barriers there.
>>
> 
> [cc Will Deacon]
> 
> Jason, appreciate for your review and comments. I think PATCH[1/2] is
> the fix for the hypothesis, meaning PATCH[2/2] is the real fix. However,
> it would be nice to fix all of them in one shoot. I will try with PATCH[2/2]
> only to see if our issue will disappear or not. However, the issue still
> exists if PATCH[2/2] is missed.
> 

Jason, PATCH[2/2] is sufficient to fix our current issue. I tried with PATCH[2/2]
only and unable to hit the issue. However, PATCH[1/2] may be needed by other scenarios.
So it would be nice to fix them in one shoot.


> Firstly, We were failing on the transmit queue and {tvq, rvq}->busyloop_timeout
> == false if I remember correctly. So the added smp_rmb() in vhost_vq_avail_empty()
> is only a concern to tx_can_batch(). A mutex isn't enough to ensure the order
> for the available index and available ring entry (head). For example, vhost_vq_avail_empty()
> called by tx_can_batch() can see next available index, but its corresponding
> available ring entry (head) may not be seen by vhost yet if smp_rmb() is missed.
> The next call to get_tx_bufs(), where the available ring entry (head) doesn't
> arrived yet, leading to stale available ring entry (head) being fetched.
> 
>    handle_tx_copy
>      get_tx_bufs                 // smp_rmb() won't be executed when vq->avail_idx != vq->last_avail_idx
>      tx_can_batch
>        vhost_vq_avail_empty      // vq->avail_idx is updated from vq->avail->idx
> 
> The reason why I added smp_rmb() to vhost_vq_avail_empty() is because the function
> is a exposed API, even it's only used by drivers/vhost/net.c at present. It means
> the API has been broken internally. So it seems more appropriate to fix it up in
> vhost_vq_avail_empty() so that the API's users needn't worry about the memory access
> order.
> 
>>>
>>>
>>>> +               smp_rmb();
>>>> +               return false;
>>>> +       }
>>>>
>>>> -       return vq->avail_idx == vq->last_avail_idx;
>>>> +       return true;
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);

Thanks,
Gavin


