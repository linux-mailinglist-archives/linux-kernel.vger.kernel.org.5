Return-Path: <linux-kernel+bounces-122233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159988F3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1CC2A7B37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B142554B;
	Thu, 28 Mar 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkHUjONk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228A1B7FD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585588; cv=none; b=o/BPC6O8HfTT7mETKOTqVxgoubcHCmtFYfmNDhBmUT70pGIaNof34lIxohyPMsqIVhQeL9ohAs20DK8yEZK4Y5woZ4MLlWFKLxUUUMcmDotLoOUgBCeJpBle5gkM2PlqEISs/AnOTXtFG3RsOwHKenJLpey0wNORNxp1/JnQJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585588; c=relaxed/simple;
	bh=AzUVCPq4alUlr/fy2N4j1Rsho5Dmw2Doq/Njidb3450=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU4SVoO9G6/UPOIMKCvY/D+uKjkyyXT0P6zBjvjGZoxJ1p65dPfHHZgz131FvjlwwyZFCBJcReUfAecr4lPNB+W3y+da9fQztq92QmFdpcSJHD8x+S1xQUbeIsIxeBMMtI6Q+PTmMJYFAU84Tab8s+c2OBuj+lNIR0Rpjo1g5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkHUjONk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711585586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcBhQV8eVYyeZ5qV8HbQJX0V8TUiJ78zQtrKVfKV7pQ=;
	b=QkHUjONkS7SnEkRamvd752Or+zyvIrEZOypmF2LntssLjQsf98oXQGk9fAWQlxY427PY68
	u0LbWSaFW7/xFb8hByY/v9kkwjr0O2YMvWEaNnMdO/4lTxjDtOaQ+Kxfbauq1oZ12pTEUH
	RtRW8Id5/fAbT3m9PQGprzwr9NhL9Pg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-Pjj4v8qzOHK-1pEvPVAChw-1; Wed, 27 Mar 2024 20:26:24 -0400
X-MC-Unique: Pjj4v8qzOHK-1pEvPVAChw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e6a865d967so382249a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711585583; x=1712190383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcBhQV8eVYyeZ5qV8HbQJX0V8TUiJ78zQtrKVfKV7pQ=;
        b=PmzqQhq1u5tFxubqFKQxMJuhEL3O9JZXZAFzWeGXlLNsK9cqVHzKdaZHStG9YovtU4
         69i0sdbu6KjntBszA+xVxuRUCNi3mEJ47I458ffr37/crHBfPMG02CJB5fY5ccZZ+zj7
         5g7AsXvyd9X9VtsJ6H5J3giQocOd/OToW/wkUa/JpS/e3o5lCzM9yVgH2S4za/qoNAHm
         AevZNCgypzhIJ5iLWcoIxV8M2/S74gjKz8QiD3aDxX/qVLT77+KEE4yAi1cyZ2KdGYbC
         2k2IfCCUDUibQUoiRMgEQgGNdpDlT1I6oUHkf0Xzm9La+zNWp1jHgC7E4j+ioHQZ/GJl
         93nw==
X-Forwarded-Encrypted: i=1; AJvYcCW+rgihbnheVCMRsWavTl9GBB+FpBQ0NUfL5/3qNf/QpBAiq3H8WPsXOZCaQRlgFFNhOD5lUptCy5dS2WQjwkt8h8AU1Fc2Vo7kCSZ4
X-Gm-Message-State: AOJu0YyMpCQgrBcqxQN+o5a9IrfC1Q7qE1stsE9RP2iOu/3jYyzLGQPR
	JTHY0D0M/AG0qLshywPEV0FJ+81S5mILp2bAIaAbsgQWVLTTkXcvIsHa1ieoLRhIg/XriqtCo5M
	cm9fAzp8tnFCsXjSMxNMiOqIvi6gS3HV8NFXfFOw1ZyBecF3kg3mtHUo8D+lSxQ==
X-Received: by 2002:a05:6870:b50e:b0:22a:a1bd:a0a1 with SMTP id v14-20020a056870b50e00b0022aa1bda0a1mr601737oap.4.1711585583740;
        Wed, 27 Mar 2024 17:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfRAKQ/NAhgcVoMJjul2Pg5XivzNL80VVk+rmY3ikeXQxKkAURQV5Zlzcz5wVcxd/eD6lixQ==
X-Received: by 2002:a05:6870:b50e:b0:22a:a1bd:a0a1 with SMTP id v14-20020a056870b50e00b0022aa1bda0a1mr601725oap.4.1711585583451;
        Wed, 27 Mar 2024 17:26:23 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b006eac433b2casm146099pfg.128.2024.03.27.17.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 17:26:22 -0700 (PDT)
Message-ID: <4d1adff0-b842-4b09-bfe8-02ea62c6c393@redhat.com>
Date: Thu, 28 Mar 2024 10:26:16 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, davem@davemloft.net, stefanha@redhat.com,
 sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
References: <20240326233846.1086253-1-gshan@redhat.com>
 <20240326233846.1086253-2-gshan@redhat.com>
 <20240327075940-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240327075940-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 22:07, Michael S. Tsirkin wrote:
> On Wed, Mar 27, 2024 at 09:38:45AM +1000, Gavin Shan wrote:
>> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
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
>> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
>> should be safe until vq->avail_idx is changed by commit 275bf960ac697
>> ("vhost: better detection of available buffers").
>>
>> Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
>> Cc: <stable@kernel.org> # v4.11+
>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/vhost/vhost.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 045f666b4f12..00445ab172b3 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>   	r = vhost_get_avail_idx(vq, &avail_idx);
>>   	if (unlikely(r))
>>   		return false;
>> +
>>   	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> +	if (vq->avail_idx != vq->last_avail_idx) {
>> +		/* Similar to what's done in vhost_get_vq_desc(), we need
>> +		 * to ensure the available ring entries have been exposed
>> +		 * by guest.
>> +		 */
> 
> A slightly clearer comment:
> 
> /* Since we have updated avail_idx, the following call to
>   * vhost_get_vq_desc will read available ring entries.
>   * Make sure that read happens after the avail_idx read.
>   */
> 
> Pls repost with that, and I will apply.
> 
> Also add suggested-by for will.
> 

Sure, the suggested comments have been included to v3.

> 
>> +		smp_rmb();
>> +		return false;
>> +	}
>>   
>> -	return vq->avail_idx == vq->last_avail_idx;
>> +	return true;
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
> 
> As a follow-up patch, we should clean out code duplication that
> accumulated with 3 places reading avail idx in essentially
> the same way - this duplication is what causes the mess in
> the 1st place.
> 

Yes, nice idea. I've added PATCH[v3 3/3] to improve vhost_get_avail_idx()
to handle the memory barrier since all the callers have the concern.

v3: https://lore.kernel.org/virtualization/20240328002149.1141302-1-gshan@redhat.com/

Thanks,
Gavin


