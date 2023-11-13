Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E837EA1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjKMRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjKMRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB712D59
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699895412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G65WustLE2dEQVp8ysLE58NJMc/t5tEbPzYhJeMqn9s=;
        b=BM/zZdltFX665drRbvAQcli70L7aEfT9Vc+ZcQDPG7p1zN3y7Yqt/n+u5EqJX6T+m3J+SN
        eY0G9O4hhqIGn/YnWmmvEkAFCySAwC4RHxZijRybxvsgPh9SM2wdG5WB65QC5FLkl1o3Us
        YPqP5Vc84euMUn6N74Fz5y6IP4II5Jg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-jD4OONugNMycL5GWDL1HyA-1; Mon, 13 Nov 2023 12:10:10 -0500
X-MC-Unique: jD4OONugNMycL5GWDL1HyA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c506abc320so36862561fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699895409; x=1700500209;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G65WustLE2dEQVp8ysLE58NJMc/t5tEbPzYhJeMqn9s=;
        b=glZXnCOJ96B+HbIHYSdGHz1tOaAxgsNsoXmK4zTmRzuJS3zj2ePliyEoFiu4jMmk1d
         Y1PDZn07P52KS0Am5S6Z9JofBa0mTkY1m8wDnN7SqPfAhXXobb1tGW2SDcVtz8az259C
         gIgRAeoS/1X4tFSZOTb9dOzVIYGCaXSOf+f2rWmF8/RAtxdXwmuw4arg6AltFjX2qC0P
         2ydQvFp/H+1xXE5Mdhy/8qorC5ooAQAXOZLtXfaem7cXZz077Ry7ZaH29Wi9iWejV2Fv
         wXfViKbl09dOZBQ21Cq7H83Xzsmzk36FNRD42Cfu3RXsRDf5jjtDWNAdwOvcYYbbMu8M
         bMKw==
X-Gm-Message-State: AOJu0Yz5TatLPZrkki/+OAJNcNL25DqS5zsg260ws0VSKU7YRQNu2soF
        s7i17JBDnpVBZbw+hgTf6OnNRHyjGQUpyD/OdRB1lfohgXCrbJ05HlKR+Z6rsQhQj5q0RI/pqzx
        jpFsRTIPCL+UlCMJMySkqdlzH
X-Received: by 2002:a05:6512:4014:b0:500:7a21:3e78 with SMTP id br20-20020a056512401400b005007a213e78mr6100252lfb.55.1699895409166;
        Mon, 13 Nov 2023 09:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/xPxDvcc33kOc3ZeaYYvr9EKONgzFQPtiIPoNDj3O2aUw5WCUYtxdrDIZshZQrDyJOu4hpw==
X-Received: by 2002:a05:6512:4014:b0:500:7a21:3e78 with SMTP id br20-20020a056512401400b005007a213e78mr6100236lfb.55.1699895408838;
        Mon, 13 Nov 2023 09:10:08 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id b1-20020a0565120b8100b004fdde1db756sm1029983lfv.26.2023.11.13.09.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 09:10:08 -0800 (PST)
Message-ID: <d33fc41b-5a1f-4186-a0b2-3c82dcb8f00b@redhat.com>
Date:   Mon, 13 Nov 2023 18:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: gpu: Fixing warning directly dereferencing a rcu
 pointer
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Abhinav Singh <singhabhinav9051571833@gmail.com>,
        kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     nouveau@lists.freedesktop.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231113081040.2947143-1-singhabhinav9051571833@gmail.com>
 <f229d1ed-b71e-434a-acca-06ee81826260@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <f229d1ed-b71e-434a-acca-06ee81826260@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/23 09:24, Maarten Lankhorst wrote:
> Hey,
> 
> Den 2023-11-13 kl. 09:10, skrev Abhinav Singh:
>> This patch fixes a sparse warning with this message
>> "warning:dereference of noderef expression". In this context it means we
>> are dereferencing a __rcu tagged pointer directly.
>>
>> We should not be directly dereferencing a rcu pointer, rather we should
>> be using rcu helper function rcu_dereferece() inside rcu read critical
>> section to get a normal pointer which can be dereferenced.
>>
>> I tested with qemu with this command
>> qemu-system-x86_64 \
>>     -m 2G \
>>     -smp 2 \
>>     -kernel bzImage \
>>     -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>>     -drive file=bullseye.img,format=raw \
>>     -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
>>     -net nic,model=e1000 \
>>     -enable-kvm \
>>     -nographic \
>>     -pidfile vm.pid \
>>     2>&1 | tee vm.log
>> with lockdep enabled.
>>
>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>> ---
>>   drivers/gpu/drm/nouveau/nv04_fence.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c b/drivers/gpu/drm/nouveau/nv04_fence.c
>> index 5b71a5a5cd85..e62bad1ac720 100644
>> --- a/drivers/gpu/drm/nouveau/nv04_fence.c
>> +++ b/drivers/gpu/drm/nouveau/nv04_fence.c
>> @@ -39,7 +39,9 @@ struct nv04_fence_priv {
>>   static int
>>   nv04_fence_emit(struct nouveau_fence *fence)
>>   {
>> -    struct nvif_push *push = fence->channel->chan.push;
>> +    rcu_read_lock();
>> +    struct nvif_push *push = rcu_dereference(fence->channel)->chan.push;
>> +    rcu_read_unlock();
>>       int ret = PUSH_WAIT(push, 2);
>>       if (ret == 0) {
>>           PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);
> 
> I'm not an expert in nouveau fence channel lifetime, but I'm pretty sure this should probably be a rcu_dereference_protected, since a fence likely can't lose its channel before its command to signal is submitted.

Yes, before nouveau_fence_emit() did not add this fence to the fence context's
pending list ->channel doesn't need any protection. We can probably just use
unrcu_pointer(), as in [1].

[1] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/nouveau_fence.c#L210

> 
> But in case it's not, I would at least advise to check for fence->channel lifetime before submitting a patch like this. At least the original code warned about it not being 100% correct.
> 
> Cheers,
> 
> ~Maarten
> 

