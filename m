Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774FA7CC480
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbjJQNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbjJQNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CB218F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697548710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSDCThVMKQCFxzqiWQfQEUEQKvusAuTk/t5OleFl9og=;
        b=PXp9IsjoLSwKNCtXpY7CzYtg8oVUXyZFuEXpekYPdUZ/wxOZX2LA8tHOA4Gqw9ZSHKL9ry
        aOKc5Rq6Lx9XesE+VwJTN4tJbK1twWNXwIreSZlL9Vm9zU5Duze+CkUQQG+fH6SdNdM8C9
        rOeLfxJp1c/PaJyE2DJ+fnoe/bpaAVA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-RDndSh18MoeF3iFCBevp5Q-1; Tue, 17 Oct 2023 09:18:24 -0400
X-MC-Unique: RDndSh18MoeF3iFCBevp5Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-407558fe418so39510285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548703; x=1698153503;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSDCThVMKQCFxzqiWQfQEUEQKvusAuTk/t5OleFl9og=;
        b=xAbfOprUnM9yVdzpsppzoi8z/huytCFBpQy0gn5j54Cf6Wr2CoDqtXkghjYnYtPo2/
         vdlK1BT8lCJd0GBPSA2HNBAXF4Qkdg6YK2vrHNkF82B81OPSmkNribBlCfuKFbVsJLOR
         623eSknfa9AQBtw1gkazLzF4YbWgKcbKzgS3HJEJfFC6cNRfPNm2zjmxp5DIOSMOntIp
         VwpQFwrdpasZDsSqJ89RfaVr/2rsVasbcQMBnxnsXTz3KQlkT4Aor4qfZsupcs9+uPMT
         Nt1zCsvxgjgY5SKTSwHiBlRWFTmIl1xR9AExRVhEjtb2/Ct8H54tpTpULvu9BFYFlv0x
         9Ocw==
X-Gm-Message-State: AOJu0YzVH4+qrWTLUwIGPVCaG5hmbZMGtX9TMCFI1ntW8pCaA1DIranL
        lStn8mG9Cy95lHc+OFcyvQsh9hlKx52RN7qIGtaszP73F91bz/SABKg6+wtlH93xracwaBq5TD0
        dIrj+66UvPF1NBsi8e19lQvUe
X-Received: by 2002:a05:600c:19c6:b0:407:8e85:899f with SMTP id u6-20020a05600c19c600b004078e85899fmr1684912wmq.16.1697548702884;
        Tue, 17 Oct 2023 06:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3Tj9kqPQlNn1u3th/1xXAhRP9637rUy1wj50ZhBwl/PLcnhJlng6UrdoSTQ2K69K3RbKcEw==
X-Received: by 2002:a05:600c:19c6:b0:407:8e85:899f with SMTP id u6-20020a05600c19c600b004078e85899fmr1684871wmq.16.1697548701851;
        Tue, 17 Oct 2023 06:18:21 -0700 (PDT)
Received: from [10.0.20.172] (198.red-81-39-42.dynamicip.rima-tde.net. [81.39.42.198])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00405bbfd5d16sm1977218wmb.7.2023.10.17.06.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 06:18:21 -0700 (PDT)
Message-ID: <9ab3b403-5837-4449-b26a-5af49a016f0f@redhat.com>
Date:   Tue, 17 Oct 2023 15:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v6 1/6] drm/gpuvm: add common dma-resv per
 struct drm_gpuvm
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231008233212.13815-1-dakr@redhat.com>
 <20231008233212.13815-2-dakr@redhat.com>
 <65e96c3465a47440ca44b3182e257cb40e745f8b.camel@linux.intel.com>
 <d3409417-444b-4a7a-adde-8d6fab8f1e77@redhat.com>
 <7e57e077c2a56689a07be7da06d78b049125dfe7.camel@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <7e57e077c2a56689a07be7da06d78b049125dfe7.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 15:00, Thomas Hellström wrote:
> On Fri, 2023-10-13 at 13:51 +0200, Danilo Krummrich wrote:
>> On 10/13/23 13:38, Thomas Hellström wrote:
>>> On Mon, 2023-10-09 at 01:32 +0200, Danilo Krummrich wrote:
>>>> Provide a common dma-resv for GEM objects not being used outside
>>>> of
>>>> this
>>>> GPU-VM. This is used in a subsequent patch to generalize dma-
>>>> resv,
>>>> external and evicted object handling and GEM validation.
>>>>
>>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_gpuvm.c            | 56
>>>> +++++++++++++++++++++++++-
>>>>    drivers/gpu/drm/nouveau/nouveau_uvmm.c | 13 +++++-
>>>>    include/drm/drm_gpuvm.h                | 35 +++++++++++++++-
>>>>    3 files changed, 99 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_gpuvm.c
>>>> b/drivers/gpu/drm/drm_gpuvm.c
>>>> index 02ecb45a2544..ebda9d594165 100644
>>>> --- a/drivers/gpu/drm/drm_gpuvm.c
>>>> +++ b/drivers/gpu/drm/drm_gpuvm.c
>>>> @@ -61,6 +61,15 @@
>>>>     * contained within struct drm_gpuva already. Hence, for
>>>> inserting
>>>> &drm_gpuva
>>>>     * entries from within dma-fence signalling critical sections
>>>> it is
>>>> enough to
>>>>     * pre-allocate the &drm_gpuva structures.
>>>> + *
>>>> + * &drm_gem_objects which are private to a single VM can share a
>>>> common
>>>> + * &dma_resv in order to improve locking efficiency (e.g. with
>>>> &drm_exec).
>>>> + * For this purpose drivers must pass a &drm_gem_object to
>>>> drm_gpuvm_init(), in
>>>> + * the following called 'root object', which serves as the
>>>> container
>>>
>>> Nit: Perhaps resv object altough it might typically be the root
>>> page-
>>> table object, that doesn't have any meaning to drm_gpuvm, which
>>> uses it
>>> solely as a container for the resv?
>>
>> With "root" I didn't want to refer to the object representing the
>> root
>> page-table object, but being *the* object every other (internal)
>> object
>> needs to keep a reference to.
> 
> OK, yes but the reason they need a reference is because of the shared
> resv, so IMO resv_object is a good fit. (I later noticed there's even
> the function name drm_gpuvm_resv_obj()). And it will probably get
> confused with the driver's "root" page table object, but up to you.

Yeah, maybe 'resv object' is better, gonna change it.

> 
>>   Maybe I should be more explicit here and say
>> that drivers need to make sure every internal object requires a
>> reference
>> to take a reference to this root object.
>>
>>>
>>>> of the
>>>> + * GPUVM's shared &dma_resv. This root object can be a driver
>>>> specific
>>>> + * &drm_gem_object, such as the &drm_gem_object containing the
>>>> root
>>>> page table,
>>>> + * but it can also be a 'dummy' object, which can be allocated
>>>> with
>>>> + * drm_gpuvm_root_object_alloc().
>>>>     */
>>>>    
>>>>    /**
>>>> @@ -652,9 +661,47 @@ drm_gpuvm_range_valid(struct drm_gpuvm
>>>> *gpuvm,
>>>>                  !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
>>>>    }
>>>>    
>>>> +static void
>>>> +drm_gpuvm_gem_object_free(struct drm_gem_object *obj)
>>>> +{
>>>> +       drm_gem_object_release(obj);
>>>> +       kfree(obj);
>>>> +}
>>>> +
>>>> +static const struct drm_gem_object_funcs drm_gpuvm_object_funcs
>>>> = {
>>>> +       .free = drm_gpuvm_gem_object_free,
>>>> +};
>>>> +
>>>> +/**
>>>> + * drm_gpuvm_root_object_alloc() - allocate a dummy
>>>> &drm_gem_object
>>>> + * @drm: the drivers &drm_device
>>>> + *
>>>> + * Allocates a dummy &drm_gem_object which can be passed to
>>>> drm_gpuvm_init() in
>>>> + * order to serve as root GEM object providing the &drm_resv
>>>> shared
>>>> across
>>>> + * &drm_gem_objects local to a single GPUVM.
>>>> + *
>>>> + * Returns: the &drm_gem_object on success, NULL on failure
>>>> + */
>>>> +struct drm_gem_object *
>>>> +drm_gpuvm_root_object_alloc(struct drm_device *drm)
>>>> +{
>>>> +       struct drm_gem_object *obj;
>>>> +
>>>> +       obj = kzalloc(sizeof(*obj), GFP_KERNEL);
>>>> +       if (!obj)
>>>> +               return NULL;
>>>> +
>>>> +       obj->funcs = &drm_gpuvm_object_funcs;
>>>> +       drm_gem_private_object_init(drm, obj, 0);
>>>> +
>>>> +       return obj;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(drm_gpuvm_root_object_alloc);
>>>> +
>>>>    /**
>>>>     * drm_gpuvm_init() - initialize a &drm_gpuvm
>>>>     * @gpuvm: pointer to the &drm_gpuvm to initialize
>>>> + * @r_obj: the root &drm_gem_object providing the GPUVM's common
>>>> &dma_resv
>>>>     * @name: the name of the GPU VA space
>>>>     * @start_offset: the start offset of the GPU VA space
>>>>     * @range: the size of the GPU VA space
>>>> @@ -668,7 +715,7 @@ drm_gpuvm_range_valid(struct drm_gpuvm
>>>> *gpuvm,
>>>>     * &name is expected to be managed by the surrounding driver
>>>> structures.
>>>>     */
>>>>    void
>>>> -drm_gpuvm_init(struct drm_gpuvm *gpuvm,
>>>> +drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_gem_object
>>>> *r_obj,
>>>>                  const char *name,
>>>>                  u64 start_offset, u64 range,
>>>>                  u64 reserve_offset, u64 reserve_range,
>>>> @@ -683,6 +730,9 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm,
>>>>    
>>>>           gpuvm->name = name ? name : "unknown";
>>>>           gpuvm->ops = ops;
>>>> +       gpuvm->r_obj = r_obj;
>>>> +
>>>> +       drm_gem_object_get(r_obj);
>>>>    
>>>>           memset(&gpuvm->kernel_alloc_node, 0, sizeof(struct
>>>> drm_gpuva));
>>>>    
>>>> @@ -713,7 +763,9 @@ drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
>>>>                   __drm_gpuva_remove(&gpuvm->kernel_alloc_node);
>>>>    
>>>>           WARN(!RB_EMPTY_ROOT(&gpuvm->rb.tree.rb_root),
>>>> -            "GPUVA tree is not empty, potentially leaking
>>>> memory.");
>>>> +            "GPUVA tree is not empty, potentially leaking
>>>> memory.\n");
>>>
>>> Should we cache the drm device in struct drm_gpuvm and use
>>> drm_warn()
>>> here instead of WARN?
>>
>> I'd guess the additional backtrace of WARN() isn't overly useful in
>> this
>> case. However, it might be a bit more obvious in dmesg due to its
>> verboseness. Not a strong opinion on that, though.
> 
> My bad. I meant drm_WARN(). In a multi-gpu environment it's nice to
> have the extra device info.

Sure, gonna add a separate patch to change that in all places.

> 
> /Thomas
> 
> 
>>
>>>
>>>> +
>>>> +       drm_gem_object_put(gpuvm->r_obj);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(drm_gpuvm_destroy);
>>>>    
>>>> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>>>> b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>>>> index 5cf892c50f43..4dea847ef989 100644
>>>> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>>>> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
>>>> @@ -1808,8 +1808,9 @@ int
>>>>    nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli
>>>> *cli,
>>>>                     u64 kernel_managed_addr, u64
>>>> kernel_managed_size)
>>>>    {
>>>> -       int ret;
>>>> +       struct drm_gem_object *r_obj;
>>>>           u64 kernel_managed_end = kernel_managed_addr +
>>>> kernel_managed_size;
>>>> +       int ret;
>>>>    
>>>>           mutex_init(&uvmm->mutex);
>>>>           dma_resv_init(&uvmm->resv);
>>>> @@ -1833,14 +1834,22 @@ nouveau_uvmm_init(struct nouveau_uvmm
>>>> *uvmm,
>>>> struct nouveau_cli *cli,
>>>>                   goto out_unlock;
>>>>           }
>>>>    
>>>> +       r_obj = drm_gpuvm_root_object_alloc(cli->drm->dev);
>>>> +       if (!r_obj) {
>>>> +               ret = -ENOMEM;
>>>> +               goto out_unlock;
>>>> +       }
>>>> +
>>>>           uvmm->kernel_managed_addr = kernel_managed_addr;
>>>>           uvmm->kernel_managed_size = kernel_managed_size;
>>>>    
>>>> -       drm_gpuvm_init(&uvmm->base, cli->name,
>>>> +       drm_gpuvm_init(&uvmm->base, r_obj, cli->name,
>>>>                          NOUVEAU_VA_SPACE_START,
>>>>                          NOUVEAU_VA_SPACE_END,
>>>>                          kernel_managed_addr, kernel_managed_size,
>>>>                          NULL);
>>>> +       /* GPUVM takes care from here on. */
>>>> +       drm_gem_object_put(r_obj);
>>>>    
>>>>           ret = nvif_vmm_ctor(&cli->mmu, "uvmm",
>>>>                               cli->vmm.vmm.object.oclass, RAW,
>>>> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
>>>> index c7ed6bf441d4..0aec14d8b259 100644
>>>> --- a/include/drm/drm_gpuvm.h
>>>> +++ b/include/drm/drm_gpuvm.h
>>>> @@ -238,9 +238,15 @@ struct drm_gpuvm {
>>>>            * @ops: &drm_gpuvm_ops providing the split/merge steps
>>>> to
>>>> drivers
>>>>            */
>>>>           const struct drm_gpuvm_ops *ops;
>>>> +
>>>> +       /**
>>>> +        * @r_obj: Root GEM object; representing the GPUVM's
>>>> common
>>>> &dma_resv.
>>>> +        */
>>>> +       struct drm_gem_object *r_obj;
>>>>    };
>>>>    
>>>> -void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
>>>> +void drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct
>>>> drm_gem_object
>>>> *r_obj,
>>>> +                   const char *name,
>>>>                       u64 start_offset, u64 range,
>>>>                       u64 reserve_offset, u64 reserve_range,
>>>>                       const struct drm_gpuvm_ops *ops);
>>>> @@ -248,6 +254,33 @@ void drm_gpuvm_destroy(struct drm_gpuvm
>>>> *gpuvm);
>>>>    
>>>>    bool drm_gpuvm_interval_empty(struct drm_gpuvm *gpuvm, u64
>>>> addr, u64
>>>> range);
>>>>    
>>>> +struct drm_gem_object *
>>>> +drm_gpuvm_root_object_alloc(struct drm_device *drm);
>>>> +
>>>> +/**
>>>> + * drm_gpuvm_resv() - returns the &drm_gpuvm's &dma_resv
>>>> + * @gpuvm__: the &drm_gpuvm
>>>> + *
>>>> + * Returns: a pointer to the &drm_gpuvm's shared &dma_resv
>>>> + */
>>>> +#define drm_gpuvm_resv(gpuvm__) ((gpuvm__)->r_obj->resv)
>>>> +
>>>> +/**
>>>> + * drm_gpuvm_resv_obj() - returns the &drm_gem_object holding
>>>> the
>>>> &drm_gpuvm's
>>>> + * &dma_resv
>>>> + * @gpuvm__: the &drm_gpuvm
>>>> + *
>>>> + * Returns: a pointer to the &drm_gem_object holding the
>>>> &drm_gpuvm's shared
>>>> + * &dma_resv
>>>> + */
>>>> +#define drm_gpuvm_resv_obj(gpuvm__) ((gpuvm__)->r_obj)
>>>> +
>>>> +#define drm_gpuvm_resv_held(gpuvm__) \
>>>> +       dma_resv_held(drm_gpuvm_resv(gpuvm__))
>>>> +
>>>> +#define drm_gpuvm_resv_assert_held(gpuvm__) \
>>>> +       dma_resv_assert_held(drm_gpuvm_resv(gpuvm__))
>>>> +
>>>>    static inline struct drm_gpuva *
>>>>    __drm_gpuva_next(struct drm_gpuva *va)
>>>>    {
>>>
>>> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>
>>>
>>
> 

