Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677317A9D89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjIUTj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjIUTjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C513110197
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBKsdILJK6LKx44dAAFeiD0fpocwmyg5JOsB2LeutZk=;
        b=HhnB3MfmXYl76q5Vmt6Mq+K+ofu5KVH7blMRLz9MdNB0Uz4jrpHa/YlW/wbGkgRo1GLvYm
        wJi3oIwUtQVWY5XLrxZ1yDWAKuxPnd2nwkAG5V5LNTJsCbMLwfUjSohlyCWk7hq/6OWvLR
        kQiEGIbAqcK3WbU13pQ4ZUE4lIhaS/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-9Fj0yP9XMTy0w1uw-7irBQ-1; Thu, 21 Sep 2023 09:34:49 -0400
X-MC-Unique: 9Fj0yP9XMTy0w1uw-7irBQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4011fa32e99so8007475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 06:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695303287; x=1695908087;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBKsdILJK6LKx44dAAFeiD0fpocwmyg5JOsB2LeutZk=;
        b=Eigr1AEYDsoXfuAPWbFtNGWjghzpvMXC4qVtAaSI8Y+Z68aj8R+2FwEs2/7SPzVxCa
         dGCCgBeh42oXY0MVy3dsnTdXXcTju+yAgJGoD0sSLFrhgN+HSELEhWM5GfKrw4seV5VL
         kAJnSQ9vur5AKbrBWsUQQ7r3wTHo0eXNOFi4/RNMLhfSs+WI5Ykg5yUp44q9C0kOB/eb
         r7gI3EiqeYi26W4idwXHkj7G84da9k1okz2WbA60O6UDY74UaLdOVacZJLV1lZm7ffGP
         LbnYoF5n5Z7Q0slBRjRERAowV8M21fqPqqkTPe71DWl6lLJgKo/2wVj2x+gLFdvJZFP4
         wq8Q==
X-Gm-Message-State: AOJu0YwHBvbdHwlViXH6hAKqeSFYQW3Xiy1m0vC74IY5CPjnWJNpXUeN
        AMJ7zI1nsVYW2iDaMuuu7Ut2as9gooG3pB8QfnXQS+zZTSsgUdXceiKp/G/UhPuyWvgRyeHyGse
        v5ulXYHWQGD7jOTuqyqF3D8PT
X-Received: by 2002:a1c:7c10:0:b0:3fe:d448:511a with SMTP id x16-20020a1c7c10000000b003fed448511amr5479203wmc.9.1695303287507;
        Thu, 21 Sep 2023 06:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPhKs7kUSD/c9EvHVaCK5+Xg89zj57rO8hV6C3J6+TctNMDOVwvE9voXgn70mWKeLHpb6lOQ==
X-Received: by 2002:a1c:7c10:0:b0:3fe:d448:511a with SMTP id x16-20020a1c7c10000000b003fed448511amr5479169wmc.9.1695303287031;
        Thu, 21 Sep 2023 06:34:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d69d1000000b003141e629cb6sm1776922wrw.101.2023.09.21.06.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 06:34:46 -0700 (PDT)
Message-ID: <964a1bdd-549d-7850-9a8c-8278c4cd32ec@redhat.com>
Date:   Thu, 21 Sep 2023 15:34:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v4 4/8] drm/gpuvm: add common dma-resv per
 struct drm_gpuvm
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230920144343.64830-1-dakr@redhat.com>
 <20230920144343.64830-5-dakr@redhat.com>
 <7951dc11-6047-6beb-8ef8-98c862e26ec3@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <7951dc11-6047-6beb-8ef8-98c862e26ec3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 09:39, Christian König wrote:
> Am 20.09.23 um 16:42 schrieb Danilo Krummrich:
>> Provide a common dma-resv for GEM objects not being used outside of this
>> GPU-VM. This is used in a subsequent patch to generalize dma-resv,
>> external and evicted object handling and GEM validation.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_gpuvm.c            |  9 +++++++--
>>   drivers/gpu/drm/nouveau/nouveau_uvmm.c |  2 +-
>>   include/drm/drm_gpuvm.h                | 17 ++++++++++++++++-
>>   3 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
>> index bfea4a8a19ec..cbf4b738a16c 100644
>> --- a/drivers/gpu/drm/drm_gpuvm.c
>> +++ b/drivers/gpu/drm/drm_gpuvm.c
>> @@ -655,6 +655,7 @@ drm_gpuva_range_valid(struct drm_gpuvm *gpuvm,
>>   /**
>>    * drm_gpuvm_init() - initialize a &drm_gpuvm
>>    * @gpuvm: pointer to the &drm_gpuvm to initialize
>> + * @drm: the drivers &drm_device
>>    * @name: the name of the GPU VA space
>>    * @start_offset: the start offset of the GPU VA space
>>    * @range: the size of the GPU VA space
>> @@ -668,7 +669,7 @@ drm_gpuva_range_valid(struct drm_gpuvm *gpuvm,
>>    * &name is expected to be managed by the surrounding driver structures.
>>    */
>>   void
>> -drm_gpuvm_init(struct drm_gpuvm *gpuvm,
>> +drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_device *drm,
>>              const char *name,
>>              u64 start_offset, u64 range,
>>              u64 reserve_offset, u64 reserve_range,
>> @@ -694,6 +695,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm,
>>                                reserve_range)))
>>               __drm_gpuva_insert(gpuvm, &gpuvm->kernel_alloc_node);
>>       }
>> +
>> +    drm_gem_private_object_init(drm, &gpuvm->d_obj, 0);
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpuvm_init);
>> @@ -713,7 +716,9 @@ drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
>>           __drm_gpuva_remove(&gpuvm->kernel_alloc_node);
>>       WARN(!RB_EMPTY_ROOT(&gpuvm->rb.tree.rb_root),
>> -         "GPUVA tree is not empty, potentially leaking memory.");
>> +         "GPUVA tree is not empty, potentially leaking memory.\n");
>> +
>> +    drm_gem_private_object_fini(&gpuvm->d_obj);
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpuvm_destroy);
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>> index 6c86b64273c3..a80ac8767843 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>> @@ -1836,7 +1836,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
>>       uvmm->kernel_managed_addr = kernel_managed_addr;
>>       uvmm->kernel_managed_size = kernel_managed_size;
>> -    drm_gpuvm_init(&uvmm->base, cli->name,
>> +    drm_gpuvm_init(&uvmm->base, cli->drm->dev, cli->name,
>>                  NOUVEAU_VA_SPACE_START,
>>                  NOUVEAU_VA_SPACE_END,
>>                  kernel_managed_addr, kernel_managed_size,
>> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
>> index 0e802676e0a9..6666c07d7c3e 100644
>> --- a/include/drm/drm_gpuvm.h
>> +++ b/include/drm/drm_gpuvm.h
>> @@ -240,14 +240,29 @@ struct drm_gpuvm {
>>        * @ops: &drm_gpuvm_ops providing the split/merge steps to drivers
>>        */
>>       const struct drm_gpuvm_ops *ops;
>> +
>> +    /**
>> +     * @d_obj: Dummy GEM object; used internally to pass the GPU VMs
>> +     * dma-resv to &drm_exec. Provides the GPUVM's &dma-resv.
>> +     */
>> +    struct drm_gem_object d_obj;
> 
> Yeah, as pointed out in the other mail that won't work like this.

Which one? Seems that I missed it.

> 
> The GPUVM contains GEM objects and therefore should probably have a reference to those objects.
> 
> When those GEM objects now use the dma-resv object embedded inside the GPUVM then they also need a reference to the GPUVM to make sure the dma-resv object won't be freed before they are freed.

My assumption here is that GEM objects being local to a certain VM never out-live the VM. We never share it with anyone, otherwise it would be external and hence wouldn't carray the VM's dma-resv. The only references I see are from the VM itself (which is fine) and from userspace. The latter isn't a problem as long as all GEM handles are closed before the VM is destroyed on FD close.

Do I miss something? Do we have use cases where this isn't true?

> 
> This is a circle reference dependency.
> 
> The simplest solution I can see is to let the driver provide the GEM object to use. Amdgpu uses the root page directory object for this.

Sure, we can do that, if we see cases where VM local GEM objects can out-live the VM.

> 
> Apart from that I strongly think that we shouldn't let the GPUVM code create a driver GEM object. We did that in TTM for the ghost objects and it turned out to be a bad idea.

You mean let GPUVM create a dummy GEM based on the drm_device from the driver? What were the problems that were encountered?

- Danilo

> 
> Regards,
> Christian.
> 
>>   };
>> -void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
>> +void drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_device *drm,
>> +            const char *name,
>>               u64 start_offset, u64 range,
>>               u64 reserve_offset, u64 reserve_range,
>>               const struct drm_gpuvm_ops *ops);
>>   void drm_gpuvm_destroy(struct drm_gpuvm *gpuvm);
>> +/**
>> + * drm_gpuvm_resv() - returns the &drm_gpuvm's &dma_resv
>> + * @gpuvm__: the &drm_gpuvm
>> + *
>> + * Returns: a pointer to the &drm_gpuvm's &dma_resv
>> + */
>> +#define drm_gpuvm_resv(gpuvm__) (&(gpuvm__)->d_obj._resv)
>> +
>>   static inline struct drm_gpuva *
>>   __drm_gpuva_next(struct drm_gpuva *va)
>>   {
> 

