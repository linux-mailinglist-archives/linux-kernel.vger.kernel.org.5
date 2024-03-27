Return-Path: <linux-kernel+bounces-120289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0388D560
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0615B21FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67732376A;
	Wed, 27 Mar 2024 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEQiZ6lW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8522EEF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512650; cv=none; b=N5fFqKiVnwrrut32PzATm+tlWnwBqS7TThlM4/8XXac48spcKK1yjNdxhsgL1t7weHaBVsXHn6yEfHeiX0paAwcXOAYS7Ol0nObFGmYVpWwd+0fowcJIZcy1qMU8fNj9DifP6rsecM+qPt4kVRWYS5n3JYFKqPG0IGFj3pv+4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512650; c=relaxed/simple;
	bh=p51JGKplShDetR3HvIlnBfRqUx7dnkAQPuvdWuaxSdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFcHjWpTq58tJwU72tqWb1Fwss2YmSs0ejrwGV1diIJltBmxJOAhhvfIqlK6sJ4/Ew8cTjCXjUm0H59bpgjT7lwX1fAN2zWz3dgDR11LoC3eAeubUt1bBzmTSTspDztff9kv2WqIR1w7n5cO7BlehD8bvwKjc+Pq6qLCS4hFeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEQiZ6lW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711512647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5+1XpJ1QDmRZjMIApoly5kAN/ysXdALmVG61MmSu6w=;
	b=dEQiZ6lWEstHsoxl60phzIvUh69GBUgFcASA9H4x6nPXApntG00AX0zE7oJniP8RKubH4I
	g2AwcYY1xJJA87F/0sdDbHSH+UI5B0wAM9rHA28S30kB9yl9qDK69huAReSIDp2OiOPGaY
	CgMNkOUEfjYT9bkyjKUyiun7/650tLs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-MiqsXc6lPv6AtTbdLc_dJQ-1; Wed, 27 Mar 2024 00:10:45 -0400
X-MC-Unique: MiqsXc6lPv6AtTbdLc_dJQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29de4f107b7so5045018a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711512644; x=1712117444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5+1XpJ1QDmRZjMIApoly5kAN/ysXdALmVG61MmSu6w=;
        b=eqrU8HHBd8pBCFgIz5qvGsF3Wy6os/76F8tjq616OyUHugFV3Ur8XlwVHNzksVphMA
         r66dTbwh/X0zufqBAsjMMBREwMZN/o+rTE2OCX0n14jrRcWMD9g0sl0fHPGlLugxumEj
         nACkffJJWXjK38XOb6C7F4P3hHGLCS+O7fQUwicVfYvvETRaowRiQ5vqXMskdp5+zQBQ
         yIaegdmWfGdJi+tj2SaH3WbAOckuAflBAAvfJNUvNR+8J5SOVgewCtxjbvG1279iCTQ3
         +4WIH28kKoikR+1u+UgzyNhYc5c2K7CVrZjFwAV7jSyK8YmHbKCQ2hd/NrhWwFoRbYt/
         VSMA==
X-Forwarded-Encrypted: i=1; AJvYcCUPDKPpJtHfz8BOgoRoE7H1Xt/gPn+jOVmdXZkt3P1+W8Ug81LhkC8DdQpCZOgWowrOh9bsguSErIR0MCUPc9yAsZo1Qf36YCq54KXB
X-Gm-Message-State: AOJu0YzoiO+7bSYD9GCCixi0w1tQArphUDGIu2TZddM0bvOWF+BnVeUI
	WcLolqtXtb5uJ5/jbh6c1AnHCEEyIVxIqwCe9skOqxkepZmTl4WVbjffDCsqeLP1SlcqzNmMHjM
	4BlzED5Y2Coei4Mj+Cx+kT7FMo7Upnr92wl6nLhtCeWSwaxUhQcHSNR1R0lbWlw==
X-Received: by 2002:a17:90a:8c91:b0:29d:f554:2c6f with SMTP id b17-20020a17090a8c9100b0029df5542c6fmr4890987pjo.9.1711512644459;
        Tue, 26 Mar 2024 21:10:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/3ZBbxMY+6DfmgdcOBMF8ZQO0GR0DKXvxYhITpWYHb489a/NGFcwSiyDgYdq3phG6zaNijQ==
X-Received: by 2002:a17:90a:8c91:b0:29d:f554:2c6f with SMTP id b17-20020a17090a8c9100b0029df5542c6fmr4890970pjo.9.1711512644134;
        Tue, 26 Mar 2024 21:10:44 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id 22-20020a631756000000b005e838955bc4sm8272425pgx.58.2024.03.26.21.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 21:10:43 -0700 (PDT)
Message-ID: <c9d9c47e-6180-4a11-84d9-618e24c5a898@redhat.com>
Date: Wed, 27 Mar 2024 14:10:37 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vhost: Add smp_rmb() in vhost_enable_notify()
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 mst@redhat.com, davem@davemloft.net, stefanha@redhat.com,
 sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com,
 shan.gavin@gmail.com, Will Deacon <will@kernel.org>
References: <20240326233846.1086253-1-gshan@redhat.com>
 <20240326233846.1086253-3-gshan@redhat.com>
 <CACGkMEsh8HguArBNUkxcZ74pWoZWOtfj2Zigenyt_Ehh7qf_YQ@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CACGkMEsh8HguArBNUkxcZ74pWoZWOtfj2Zigenyt_Ehh7qf_YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/24 12:41, Jason Wang wrote:
> On Wed, Mar 27, 2024 at 7:39 AM Gavin Shan <gshan@redhat.com> wrote:
>>
>> A smp_rmb() has been missed in vhost_enable_notify(), inspired by
>> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
>> available ring entries pushed by guest can be observed by vhost
>> in time, leading to stale available ring entries fetched by vhost
>> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
>> grace-hopper (ARM64) platform.
>>
>>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>>    -accel kvm -machine virt,gic-version=host -cpu host          \
>>    -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>>    -m 4096M,slots=16,maxmem=64G                                 \
>>    -object memory-backend-ram,id=mem0,size=4096M                \
>>     :                                                           \
>>    -netdev tap,id=vnet0,vhost=true                              \
>>    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
>>     :
>>    guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>>    virtio_net virtio0: output.0:id 100 is not a head!
>>
>> Add the missed smp_rmb() in vhost_enable_notify(). Note that it
>> should be safe until vq->avail_idx is changed by commit d3bb267bbdcb
>> ("vhost: cache avail index in vhost_enable_notify()").
>>
>> Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
>> Cc: <stable@kernel.org> # v5.18+
>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/vhost/vhost.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 00445ab172b3..58f9d6a435f0 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2847,9 +2847,18 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>                         &vq->avail->idx, r);
>>                  return false;
>>          }
>> +
>>          vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> +       if (vq->avail_idx != vq->last_avail_idx) {
>> +               /* Similar to what's done in vhost_get_vq_desc(), we need
>> +                * to ensure the available ring entries have been exposed
>> +                * by guest.
>> +                */
>> +               smp_rmb();
>> +               return true;
>> +       }
>>
>> -       return vq->avail_idx != vq->last_avail_idx;
>> +       return false;
> 
> So we only care about the case when vhost_enable_notify() returns true.
> 
> In that case, I think you want to order with vhost_get_vq_desc():
> 
> last_avail_idx = vq->last_avail_idx;
> 
> if (vq->avail_idx == vq->last_avail_idx) { /* false */
> }
> 
> vhost_get_avail_head(vq, &ring_head, last_avail_idx)
> 
> Assuming I understand the patch correctly.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 

Jason, thanks for your review and comments. Your understanding is exactly
what I understood.

> 
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_enable_notify);
>>

Thanks,
Gavin


