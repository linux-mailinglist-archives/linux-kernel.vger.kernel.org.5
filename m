Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5051F7EA33A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjKMTBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:01:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5716B10F4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699902038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjJH04gFEMWV/cqlv7v8adTIMmJNmVfPhb2cpZ40Pn0=;
        b=MlmGm2TANJqwGLh4Q8b6ptBydoCYd11tGKoZOVVcc6nrBoBw6hguYw96uTdkA2scHT3q3J
        R+O1JEbMeIYQlvLu3DtoklAjWO4tGEI3IssS/SSvPcXkeZl1/f2KJ9DmO+kD9AelfyjDpV
        Vsq/FZh0AJKedf1Ee9Njpkiknu8bhp0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394--puRWvrLMPmHPV9SKTpzAg-1; Mon, 13 Nov 2023 14:00:36 -0500
X-MC-Unique: -puRWvrLMPmHPV9SKTpzAg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c506abc320so37721901fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699902035; x=1700506835;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjJH04gFEMWV/cqlv7v8adTIMmJNmVfPhb2cpZ40Pn0=;
        b=ZEMsV86ltuTasptsGr2IiWJETTLwDHS449NF8sa5CMM2DRXPL1k6JmaQa76wF3GH8H
         m+H5g0Tr3eJn5ng0oky7ruc9NQUAV/mgbjqtMRr2Z2v/Z8wXTwzg+OLYJRtJ3I3UrQF5
         PrCyTquNzllYiKlurbGRa60O8/kPRnGbqiCvx7eS8SaCkTHTOYnaIFMJmVnmx14Dm+0g
         djxlNpFRY+Xnwr3madLxP66FhSmLhFd+l15GwTaHmKRtNb9VhRGYkdi2r1igFBJttCPW
         Mmi8NjONuaidyFEafbdYeyiyQl7fD04Ca6pJoZWjnqTLg4Zgstn1uQEgea52pZt4lMtS
         sfZA==
X-Gm-Message-State: AOJu0Yy6rrBghCD+A1PnUfN3eaU4LzVmeJiUqk0PKaOdVKnznfgTMdJT
        uqhOgrbROfnYfPNTPg2AnRfB9Cn88JMQx2hI2EV0avi1PtfdOf0hrgW7+CNuFcrZOhAkJdpC3/S
        13Yjy36d5LFXDztiDOe03abpg
X-Received: by 2002:a2e:be8b:0:b0:2bc:f5a0:cc25 with SMTP id a11-20020a2ebe8b000000b002bcf5a0cc25mr135224ljr.2.1699902035082;
        Mon, 13 Nov 2023 11:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKOZlXh+pNOQnEDYBQ7KmjIxq11+FS8KLtk5tk8xefyvp983ehULtBUTIJnRwL82VT3c4gjA==
X-Received: by 2002:a2e:be8b:0:b0:2bc:f5a0:cc25 with SMTP id a11-20020a2ebe8b000000b002bcf5a0cc25mr135210ljr.2.1699902034760;
        Mon, 13 Nov 2023 11:00:34 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090629c300b009b94fe3fc47sm4386719eje.159.2023.11.13.11.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 11:00:34 -0800 (PST)
Message-ID: <8e9efe54-2799-4539-a8b0-aa199f8052f6@redhat.com>
Date:   Mon, 13 Nov 2023 20:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver: gpu: Fixing warning directly dereferencing a
 rcu pointer
Content-Language: en-US
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <d33fc41b-5a1f-4186-a0b2-3c82dcb8f00b@redhat.com>
 <20231113184238.3276835-1-singhabhinav9051571833@gmail.com>
 <373d97fc-0612-40da-ae9d-6702aa4483ba@redhat.com>
 <d0b1fb36-d2a6-446c-8a04-2101981f3a00@gmail.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <d0b1fb36-d2a6-446c-8a04-2101981f3a00@gmail.com>
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

On 11/13/23 19:55, Abhinav Singh wrote:
> On 11/14/23 00:19, Danilo Krummrich wrote:
>> Hi,
>>
>> thanks for sending a v2.
>>
>> On 11/13/23 19:42, Abhinav Singh wrote:
>>> This patch fixes a sparse warning with this message
>>> "warning:dereference of noderef expression". In this context it means we
>>> are dereferencing a __rcu tagged pointer directly.
>>
>> Better use imperative here, e.g. "Fix a sparse warning ...".
>>
>> Wouldn't ask you to send a v3 for that alone...
>>
>>>
>>> We should not be directly dereferencing a rcu pointer, rather we should
>>> be using rcu helper function rcu_dereferece() inside rcu read critical
>>> section to get a normal pointer which can be dereferenced.
>>
>> ...but this doesn't seem accurate anymore as well.
>>
>> - Danilo
>>
>>>
>>> I tested with qemu with this command
>>> qemu-system-x86_64 \
>>>     -m 2G \
>>>     -smp 2 \
>>>     -kernel bzImage \
>>>     -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>>>     -drive file=bullseye.img,format=raw \
>>>     -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
>>>     -net nic,model=e1000 \
>>>     -enable-kvm \
>>>     -nographic \
>>>     -pidfile vm.pid \
>>>     2>&1 | tee vm.log
>>> with lockdep enabled.
>>>
>>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>>> ---
>>> v1 -> v2 : Replaced the rcu_dereference(...) with unrcu_pointer(...) and
>>> also removed the rcu locking and unlocking function call.
>>>
>>>   drivers/gpu/drm/nouveau/nv04_fence.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c b/drivers/gpu/drm/nouveau/nv04_fence.c
>>> index 5b71a5a5cd85..cdbc75e3d1f6 100644
>>> --- a/drivers/gpu/drm/nouveau/nv04_fence.c
>>> +++ b/drivers/gpu/drm/nouveau/nv04_fence.c
>>> @@ -39,7 +39,7 @@ struct nv04_fence_priv {
>>>   static int
>>>   nv04_fence_emit(struct nouveau_fence *fence)
>>>   {
>>> -    struct nvif_push *push = fence->channel->chan.push;
>>> +    struct nvif_push *push = unrcu_pointer(fence->channel)->chan.push;
>>>       int ret = PUSH_WAIT(push, 2);
>>>       if (ret == 0) {
>>>           PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);
>>
> Hi maintainers thanks a lot for reviewing this patch.
> I think I should fix my mistake by sending in another patch so that the code changes and description matches. So should I send another patch ?

Yes, please send a v3.

> 
> Thank You,
> Abhinav Singh
> 

