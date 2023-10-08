Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59C7BD114
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 01:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbjJHXJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 19:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJHXJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53780A3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 16:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696806521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q7GtaJkIy713gFSICIWZeftsRFOOx1JuTFu7w/dG7xQ=;
        b=ESgsWozXy34Bnhi21+wtn1ezPTAK+fKD/12/fZsSXRgPD/oBhu1W4WQ4PbfBH/IyU8vnsr
        nmQrUblrYEV7R64+ePxnMpBrI5Bv1forNJZws1LeoZiPOM+rCVtSiergkwynyKd6VQVtuJ
        BdfuodN2IsLfdaKn1BQLROmvi2oMn/E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-1y2lCx43NaW5HuMNUzhp8w-1; Sun, 08 Oct 2023 19:08:30 -0400
X-MC-Unique: 1y2lCx43NaW5HuMNUzhp8w-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5387edc4020so3220150a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 16:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696806508; x=1697411308;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7GtaJkIy713gFSICIWZeftsRFOOx1JuTFu7w/dG7xQ=;
        b=r9JV/DD0wDXTEH3MfX+wKSo7Efx3W4HARO1U2D5FlScRUl4D3Yf+kYvkrGcWICvuZ9
         N3IXdvgfoJvauXEygooUlfgFr8eoH0TX+VIwcUAzTAhjFzh67mQAZ1S93vL41VlDLs+V
         MCouMEhvmxPzOzUfV3U3w3+GVi49p7vlNvsoCgwCLGcVnY5bncZgURYrIaD3iIoa4tZ/
         a1lLi6gTVEiTtPQsotFfvw2VMPiDnL8hTOo15wcPwth8Sig4KyKfK8CCyLs0KOvAL1ZW
         K/igUMxg9yKBuuosmGeykPxP3X0lV/TghJQDs4BEHG11IZQFUNsKWzWMnKl+40HDat2d
         uKXw==
X-Gm-Message-State: AOJu0YxYX4P7WE2Lb8pWyY/VWj1+O98FMcn18y0nbwo/CihcGvi9ktn1
        8qsQR4ZmDZFQjpWlTN2LXP7E22FxmYq2tjoKzsNpCCoNB3eHSPXKkRK2VwtjTBn7JOQ95/eju5i
        mdkNTnZD+zpor2t38OdRSrdJf
X-Received: by 2002:aa7:cf87:0:b0:525:570c:566b with SMTP id z7-20020aa7cf87000000b00525570c566bmr11661226edx.22.1696806507765;
        Sun, 08 Oct 2023 16:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3pdp6lrbOGjURgQkJi2mlTOsb3frHqm4JvTzNETx/rcyF+st35KYtLTHg0cFTX/w052Wv5Q==
X-Received: by 2002:aa7:cf87:0:b0:525:570c:566b with SMTP id z7-20020aa7cf87000000b00525570c566bmr11661211edx.22.1696806507323;
        Sun, 08 Oct 2023 16:08:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id k18-20020a05640212d200b00537fa467ddasm5406612edx.65.2023.10.08.16.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 16:08:26 -0700 (PDT)
Message-ID: <29109179-bdf3-1780-36e6-c76845d47c98@redhat.com>
Date:   Mon, 9 Oct 2023 01:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v5 3/6] drm/gpuvm: add an abstraction for a
 VM / BO combination
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        sarah.walker@imgtec.com, donald.robson@imgtec.com,
        boris.brezillon@collabora.com, christian.koenig@amd.com,
        faith@gfxstrand.net, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230928191624.13703-1-dakr@redhat.com>
 <20230928191624.13703-4-dakr@redhat.com>
 <28528b64-e760-d9a8-c56d-e44672cb02fb@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <28528b64-e760-d9a8-c56d-e44672cb02fb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 13:51, Thomas Hellström wrote:
> Hi,
> 
> On 9/28/23 21:16, Danilo Krummrich wrote:
>> This patch adds an abstraction layer between the drm_gpuva mappings of
> NIT: imperative:  s/This patch adds/Add/
>> a particular drm_gem_object and this GEM object itself. The abstraction
>> represents a combination of a drm_gem_object and drm_gpuvm. The
>> drm_gem_object holds a list of drm_gpuvm_bo structures (the structure
>> representing this abstraction), while each drm_gpuvm_bo contains list of
>> mappings of this GEM object.
>>
>> This has multiple advantages:
>>
>> 1) We can use the drm_gpuvm_bo structure to attach it to various lists
>>     of the drm_gpuvm. This is useful for tracking external and evicted
>>     objects per VM, which is introduced in subsequent patches.
>>
>> 2) Finding mappings of a certain drm_gem_object mapped in a certain
>>     drm_gpuvm becomes much cheaper.
>>
>> 3) Drivers can derive and extend the structure to easily represent
>>     driver specific states of a BO for a certain GPUVM.
>>
>> The idea of this abstraction was taken from amdgpu, hence the credit for
>> this idea goes to the developers of amdgpu.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_gpuvm.c            | 334 +++++++++++++++++++++----
>>   drivers/gpu/drm/nouveau/nouveau_uvmm.c |  64 +++--
>>   include/drm/drm_gem.h                  |  32 +--
>>   include/drm/drm_gpuvm.h                | 177 ++++++++++++-
>>   4 files changed, 523 insertions(+), 84 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
>> index 6368dfdbe9dd..27100423154b 100644
>> --- a/drivers/gpu/drm/drm_gpuvm.c
>> +++ b/drivers/gpu/drm/drm_gpuvm.c
>> @@ -70,6 +70,18 @@
>>    * &drm_gem_object, such as the &drm_gem_object containing the root page table,
>>    * but it can also be a 'dummy' object, which can be allocated with
>>    * drm_gpuvm_root_object_alloc().
>> + *
>> + * In order to connect a struct drm_gpuva its backing &drm_gem_object each
>> + * &drm_gem_object maintains a list of &drm_gpuvm_bo structures, and each
>> + * &drm_gpuvm_bo contains a list of &&drm_gpuva structures.
>> + *
>> + * A &drm_gpuvm_bo is an abstraction that represents a combination of a
>> + * &drm_gpuvm and a &drm_gem_object. Every such combination should be unique.
>> + * This is ensured by the API through drm_gpuvm_bo_obtain() and
>> + * drm_gpuvm_bo_obtain_prealloc() which first look into the corresponding
>> + * &drm_gem_object list of &drm_gpuvm_bos for an existing instance of this
>> + * particular combination. If not existent a new instance is created and linked
>> + * to the &drm_gem_object.
>>    */
>>   /**
>> @@ -395,21 +407,28 @@
>>   /**
>>    * DOC: Locking
>>    *
>> - * Generally, the GPU VA manager does not take care of locking itself, it is
>> - * the drivers responsibility to take care about locking. Drivers might want to
>> - * protect the following operations: inserting, removing and iterating
>> - * &drm_gpuva objects as well as generating all kinds of operations, such as
>> - * split / merge or prefetch.
>> - *
>> - * The GPU VA manager also does not take care of the locking of the backing
>> - * &drm_gem_object buffers GPU VA lists by itself; drivers are responsible to
>> - * enforce mutual exclusion using either the GEMs dma_resv lock or alternatively
>> - * a driver specific external lock. For the latter see also
>> - * drm_gem_gpuva_set_lock().
>> - *
>> - * However, the GPU VA manager contains lockdep checks to ensure callers of its
>> - * API hold the corresponding lock whenever the &drm_gem_objects GPU VA list is
>> - * accessed by functions such as drm_gpuva_link() or drm_gpuva_unlink().
>> + * In terms of managing &drm_gpuva entries DRM GPUVM does not take care of
>> + * locking itself, it is the drivers responsibility to take care about locking.
>> + * Drivers might want to protect the following operations: inserting, removing
>> + * and iterating &drm_gpuva objects as well as generating all kinds of
>> + * operations, such as split / merge or prefetch.
>> + *
>> + * DRM GPUVM also does not take care of the locking of the backing
>> + * &drm_gem_object buffers GPU VA lists and &drm_gpuvm_bo abstractions by
>> + * itself; drivers are responsible to enforce mutual exclusion using either the
>> + * GEMs dma_resv lock or alternatively a driver specific external lock. For the
>> + * latter see also drm_gem_gpuva_set_lock().
>> + *
>> + * However, DRM GPUVM contains lockdep checks to ensure callers of its API hold
>> + * the corresponding lock whenever the &drm_gem_objects GPU VA list is accessed
>> + * by functions such as drm_gpuva_link() or drm_gpuva_unlink(), but also
>> + * drm_gpuvm_bo_obtain() and drm_gpuvm_bo_put().
>> + *
>> + * The latter is required since on creation and destruction of a &drm_gpuvm_bo
>> + * the &drm_gpuvm_bo is attached / removed from the &drm_gem_objects gpuva list.
>> + * Subsequent calls to drm_gpuvm_bo_obtain() for the same &drm_gpuvm and
>> + * &drm_gem_object must be able to observe previous creations and destructions
>> + * of &drm_gpuvm_bos in order to keep instances unique.
>>    */
>>   /**
>> @@ -439,6 +458,7 @@
>>    *    {
>>    *        struct drm_gpuva_ops *ops;
>>    *        struct drm_gpuva_op *op
>> + *        struct drm_gpuvm_bo *vm_bo;
>>    *
>>    *        driver_lock_va_space();
>>    *        ops = drm_gpuvm_sm_map_ops_create(gpuvm, addr, range,
>> @@ -446,6 +466,10 @@
>>    *        if (IS_ERR(ops))
>>    *            return PTR_ERR(ops);
>>    *
>> + *        vm_bo = drm_gpuvm_bo_obtain(gpuvm, obj);
>> + *        if (IS_ERR(vm_bo))
>> + *            return PTR_ERR(vm_bo);
>> + *
>>    *        drm_gpuva_for_each_op(op, ops) {
>>    *            struct drm_gpuva *va;
>>    *
>> @@ -458,7 +482,7 @@
>>    *
>>    *                driver_vm_map();
>>    *                drm_gpuva_map(gpuvm, va, &op->map);
>> - *                drm_gpuva_link(va);
>> + *                drm_gpuva_link(va, vm_bo);
>>    *
>>    *                break;
>>    *            case DRM_GPUVA_OP_REMAP: {
>> @@ -485,11 +509,11 @@
>>    *                driver_vm_remap();
>>    *                drm_gpuva_remap(prev, next, &op->remap);
>>    *
>> - *                drm_gpuva_unlink(va);
>>    *                if (prev)
>> - *                    drm_gpuva_link(prev);
>> + *                    drm_gpuva_link(prev, va->vm_bo);
>>    *                if (next)
>> - *                    drm_gpuva_link(next);
>> + *                    drm_gpuva_link(next, va->vm_bo);
>> + *                drm_gpuva_unlink(va);
>>    *
>>    *                break;
>>    *            }
>> @@ -505,6 +529,7 @@
>>    *                break;
>>    *            }
>>    *        }
>> + *        drm_gpuvm_bo_put(vm_bo);
>>    *        driver_unlock_va_space();
>>    *
>>    *        return 0;
>> @@ -514,6 +539,7 @@
>>    *
>>    *    struct driver_context {
>>    *        struct drm_gpuvm *gpuvm;
>> + *        struct drm_gpuvm_bo *vm_bo;
>>    *        struct drm_gpuva *new_va;
>>    *        struct drm_gpuva *prev_va;
>>    *        struct drm_gpuva *next_va;
>> @@ -534,6 +560,7 @@
>>    *                  struct drm_gem_object *obj, u64 offset)
>>    *    {
>>    *        struct driver_context ctx;
>> + *        struct drm_gpuvm_bo *vm_bo;
>>    *        struct drm_gpuva_ops *ops;
>>    *        struct drm_gpuva_op *op;
>>    *        int ret = 0;
>> @@ -543,16 +570,23 @@
>>    *        ctx.new_va = kzalloc(sizeof(*ctx.new_va), GFP_KERNEL);
>>    *        ctx.prev_va = kzalloc(sizeof(*ctx.prev_va), GFP_KERNEL);
>>    *        ctx.next_va = kzalloc(sizeof(*ctx.next_va), GFP_KERNEL);
>> - *        if (!ctx.new_va || !ctx.prev_va || !ctx.next_va) {
>> + *        ctx.vm_bo = drm_gpuvm_bo_create(gpuvm, obj);
>> + *        if (!ctx.new_va || !ctx.prev_va || !ctx.next_va || !vm_bo) {
>>    *            ret = -ENOMEM;
>>    *            goto out;
>>    *        }
>>    *
>> + *        // Typically protected with a driver specific GEM gpuva lock
>> + *        // used in the fence signaling path for drm_gpuva_link() and
>> + *        // drm_gpuva_unlink(), hence pre-allocate.
>> + *        ctx.vm_bo = drm_gpuvm_bo_obtain_prealloc(ctx.vm_bo);
>> + *
>>    *        driver_lock_va_space();
>>    *        ret = drm_gpuvm_sm_map(gpuvm, &ctx, addr, range, obj, offset);
>>    *        driver_unlock_va_space();
>>    *
>>    *    out:
>> + *        drm_gpuvm_bo_put(ctx.vm_bo);
>>    *        kfree(ctx.new_va);
>>    *        kfree(ctx.prev_va);
>>    *        kfree(ctx.next_va);
>> @@ -565,7 +599,7 @@
>>    *
>>    *        drm_gpuva_map(ctx->vm, ctx->new_va, &op->map);
>>    *
>> - *        drm_gpuva_link(ctx->new_va);
>> + *        drm_gpuva_link(ctx->new_va, ctx->vm_bo);
>>    *
>>    *        // prevent the new GPUVA from being freed in
>>    *        // driver_mapping_create()
>> @@ -577,22 +611,23 @@
>>    *    int driver_gpuva_remap(struct drm_gpuva_op *op, void *__ctx)
>>    *    {
>>    *        struct driver_context *ctx = __ctx;
>> + *        struct drm_gpuva *va = op->remap.unmap->va;
>>    *
>>    *        drm_gpuva_remap(ctx->prev_va, ctx->next_va, &op->remap);
>>    *
>> - *        drm_gpuva_unlink(op->remap.unmap->va);
>> - *        kfree(op->remap.unmap->va);
>> - *
>>    *        if (op->remap.prev) {
>> - *            drm_gpuva_link(ctx->prev_va);
>> + *            drm_gpuva_link(ctx->prev_va, va->vm_bo);
>>    *            ctx->prev_va = NULL;
>>    *        }
>>    *
>>    *        if (op->remap.next) {
>> - *            drm_gpuva_link(ctx->next_va);
>> + *            drm_gpuva_link(ctx->next_va, va->vm_bo);
>>    *            ctx->next_va = NULL;
>>    *        }
>>    *
>> + *        drm_gpuva_unlink(va);
>> + *        kfree(va);
>> + *
>>    *        return 0;
>>    *    }
>>    *
>> @@ -771,6 +806,194 @@ drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpuvm_destroy);
>> +/**
>> + * drm_gpuvm_bo_create() - create a new instance of struct drm_gpuvm_bo
>> + * @gpuvm: The &drm_gpuvm the @obj is mapped in.
>> + * @obj: The &drm_gem_object being mapped in the @gpuvm.
>> + *
>> + * If provided by the driver, this function uses the &drm_gpuvm_ops
>> + * vm_bo_alloc() callback to allocate.
>> + *
>> + * Returns: a pointer to the &drm_gpuvm_bo on success, NULL on failure
>> + */
>> +struct drm_gpuvm_bo *
>> +drm_gpuvm_bo_create(struct drm_gpuvm *gpuvm,
>> +            struct drm_gem_object *obj)
>> +{
>> +    const struct drm_gpuvm_ops *ops = gpuvm->ops;
>> +    struct drm_gpuvm_bo *vm_bo;
>> +
>> +    if (ops && ops->vm_bo_alloc)
>> +        vm_bo = ops->vm_bo_alloc();
>> +    else
>> +        vm_bo = kzalloc(sizeof(*vm_bo), GFP_KERNEL);
>> +
>> +    if (unlikely(!vm_bo))
>> +        return NULL;
>> +
>> +    vm_bo->vm = gpuvm;
>> +    vm_bo->obj = obj;
>> +
>> +    kref_init(&vm_bo->kref);
>> +    INIT_LIST_HEAD(&vm_bo->list.gpuva);
>> +    INIT_LIST_HEAD(&vm_bo->list.entry.gem);
>> +
>> +    drm_gem_object_get(obj);
>> +
>> +    return vm_bo;
>> +}
>> +EXPORT_SYMBOL_GPL(drm_gpuvm_bo_create);
>> +
>> +static void
>> +drm_gpuvm_bo_destroy(struct kref *kref)
>> +{
>> +    struct drm_gpuvm_bo *vm_bo = container_of(kref, struct drm_gpuvm_bo,
>> +                          kref);
>> +    struct drm_gpuvm *gpuvm = vm_bo->vm;
>> +    const struct drm_gpuvm_ops *ops = gpuvm->ops;
>> +    struct drm_gem_object *obj = vm_bo->obj;
>> +    bool lock = !drm_gpuvm_resv_protected(gpuvm);
>> +
>> +    drm_gem_gpuva_assert_lock_held(obj);
>> +    if (!lock)
>> +        drm_gpuvm_resv_assert_held(gpuvm);
>> +
>> +    list_del(&vm_bo->list.entry.gem);
>> +
>> +    drm_gem_object_put(obj);
>> +
>> +    if (ops && ops->vm_bo_free)
>> +        ops->vm_bo_free(vm_bo);
>> +    else
>> +        kfree(vm_bo);
>> +}
>> +
>> +/**
>> + * drm_gpuvm_bo_put() - drop a struct drm_gpuvm_bo reference
>> + * @vm_bo: the &drm_gpuvm_bo to release the reference of
>> + *
>> + * This releases a reference to @vm_bo.
>> + *
>> + * If the reference count drops to zero, the &gpuvm_bo is destroyed, which
>> + * includes removing it from the GEMs gpuva list. Hence, if a call to this
>> + * function can potentially let the reference count to zero the caller must
>> + * hold the dma-resv or driver specific GEM gpuva lock.
>> + */
>> +void
>> +drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo)
>> +{
>> +    if (vm_bo)
>> +        kref_put(&vm_bo->kref, drm_gpuvm_bo_destroy);
>> +}
>> +EXPORT_SYMBOL_GPL(drm_gpuvm_bo_put);
>> +
>> +static struct drm_gpuvm_bo *
>> +__drm_gpuvm_bo_find(struct drm_gpuvm *gpuvm,
>> +            struct drm_gem_object *obj)
>> +{
>> +    struct drm_gpuvm_bo *vm_bo;
>> +
>> +    drm_gem_gpuva_assert_lock_held(obj);
>> +
>> +    drm_gem_for_each_gpuvm_bo(vm_bo, obj)
>> +        if (vm_bo->vm == gpuvm)
>> +            return vm_bo;
>> +
>> +    return NULL;
>> +}
>> +
>> +/**
>> + * drm_gpuvm_bo_find() - find the &drm_gpuvm_bo for the given
>> + * &drm_gpuvm and &drm_gem_object
>> + * @gpuvm: The &drm_gpuvm the @obj is mapped in.
>> + * @obj: The &drm_gem_object being mapped in the @gpuvm.
>> + *
>> + * Find the &drm_gpuvm_bo representing the combination of the given
>> + * &drm_gpuvm and &drm_gem_object. If found, increases the reference
>> + * count of the &drm_gpuvm_bo accordingly.
>> + *
>> + * Returns: a pointer to the &drm_gpuvm_bo on success, NULL on failure
>> + */
>> +struct drm_gpuvm_bo *
>> +drm_gpuvm_bo_find(struct drm_gpuvm *gpuvm,
>> +          struct drm_gem_object *obj)
>> +{
>> +    struct drm_gpuvm_bo *vm_bo = __drm_gpuvm_bo_find(gpuvm, obj);
>> +
>> +    return vm_bo ? drm_gpuvm_bo_get(vm_bo) : NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(drm_gpuvm_bo_find);
>> +
>> +/**
>> + * drm_gpuvm_bo_obtain() - obtains and instance of the &drm_gpuvm_bo for the
>> + * given &drm_gpuvm and &drm_gem_object
>> + * @gpuvm: The &drm_gpuvm the @obj is mapped in.
>> + * @obj: The &drm_gem_object being mapped in the @gpuvm.
>> + *
>> + * Find the &drm_gpuvm_bo representing the combination of the given
>> + * &drm_gpuvm and &drm_gem_object. If found, increases the reference
>> + * count of the &drm_gpuvm_bo accordingly. If not found, allocates a new
>> + * &drm_gpuvm_bo.
>> + *
>> + * A new &drm_gpuvm_bo is added to the GEMs gpuva list.
>> + *
>> + * Returns: a pointer to the &drm_gpuvm_bo on success, an ERR_PTR on failure
>> + */
>> +struct drm_gpuvm_bo *
>> +drm_gpuvm_bo_obtain(struct drm_gpuvm *gpuvm,
>> +            struct drm_gem_object *obj)
>> +{
>> +    struct drm_gpuvm_bo *vm_bo;
>> +
>> +    vm_bo = drm_gpuvm_bo_find(gpuvm, obj);
>> +    if (vm_bo)
>> +        return vm_bo;
>> +
>> +    vm_bo = drm_gpuvm_bo_create(gpuvm, obj);
>> +    if (!vm_bo)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    list_add_tail(&vm_bo->list.entry.gem, &obj->gpuva.list);
>> +
>> +    return vm_bo;
>> +}
>> +EXPORT_SYMBOL_GPL(drm_gpuvm_bo_obtain);
>> +
>> +/**
>> + * drm_gpuvm_bo_obtain_prealloc() - obtains and instance of the &drm_gpuvm_bo
>> + * for the given &drm_gpuvm and &drm_gem_object
>> + * @__vm_bo: A pre-allocated struct drm_gpuvm_bo.
>> + *
>> + * Find the &drm_gpuvm_bo representing the combination of the given
>> + * &drm_gpuvm and &drm_gem_object. If found, increases the reference
>> + * count of the found &drm_gpuvm_bo accordingly, while the @__vm_bo reference
>> + * count is decreased. If not found @__vm_bo is returned without further
>> + * increase of the reference count.
>> + *
>> + * A new &drm_gpuvm_bo is added to the GEMs gpuva list.
>> + *
>> + * Returns: a pointer to the found &drm_gpuvm_bo or @__vm_bo if no existing
>> + * &drm_gpuvm_bo was found
>> + */
>> +struct drm_gpuvm_bo *
>> +drm_gpuvm_bo_obtain_prealloc(struct drm_gpuvm_bo *__vm_bo)
>> +{
>> +    struct drm_gpuvm *gpuvm = __vm_bo->vm;
>> +    struct drm_gem_object *obj = __vm_bo->obj;
>> +    struct drm_gpuvm_bo *vm_bo;
>> +
>> +    vm_bo = drm_gpuvm_bo_find(gpuvm, obj);
>> +    if (vm_bo) {
>> +        drm_gpuvm_bo_put(__vm_bo);
>> +        return vm_bo;
>> +    }
>> +
>> +    list_add_tail(&__vm_bo->list.entry.gem, &obj->gpuva.list);
>> +
>> +    return __vm_bo;
>> +}
>> +EXPORT_SYMBOL_GPL(drm_gpuvm_bo_obtain_prealloc);
>> +
>>   static int
>>   __drm_gpuva_insert(struct drm_gpuvm *gpuvm,
>>              struct drm_gpuva *va)
>> @@ -860,24 +1083,33 @@ EXPORT_SYMBOL_GPL(drm_gpuva_remove);
>>   /**
>>    * drm_gpuva_link() - link a &drm_gpuva
>>    * @va: the &drm_gpuva to link
>> + * @vm_bo: the &drm_gpuvm_bo to add the &drm_gpuva to
>>    *
>> - * This adds the given &va to the GPU VA list of the &drm_gem_object it is
>> - * associated with.
>> + * This adds the given &va to the GPU VA list of the &drm_gpuvm_bo and the
>> + * &drm_gpuvm_bo to the &drm_gem_object it is associated with.
>> + *
>> + * For every &drm_gpuva entry added to the &drm_gpuvm_bo an additional
>> + * reference of the latter is taken.
>>    *
>>    * This function expects the caller to protect the GEM's GPUVA list against
>> - * concurrent access using the GEMs dma_resv lock.
>> + * concurrent access using either the GEMs dma_resv lock or a driver specific
>> + * lock set through drm_gem_gpuva_set_lock().
>>    */
>>   void
>> -drm_gpuva_link(struct drm_gpuva *va)
>> +drm_gpuva_link(struct drm_gpuva *va, struct drm_gpuvm_bo *vm_bo)
>>   {
>>       struct drm_gem_object *obj = va->gem.obj;
>>       if (unlikely(!obj))
>>           return;
>> +    WARN_ON(obj != vm_bo->obj);
>>       drm_gem_gpuva_assert_lock_held(obj);
>> -    list_add_tail(&va->gem.entry, &obj->gpuva.list);
>> +    drm_gpuvm_bo_get(vm_bo);
>> +
>> +    va->vm_bo = vm_bo;
>> +    list_add_tail(&va->gem.entry, &vm_bo->list.gpuva);
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpuva_link);
>> @@ -888,13 +1120,22 @@ EXPORT_SYMBOL_GPL(drm_gpuva_link);
>>    * This removes the given &va from the GPU VA list of the &drm_gem_object it is
>>    * associated with.
>>    *
>> + * This removes the given &va from the GPU VA list of the &drm_gpuvm_bo and
>> + * the &drm_gpuvm_bo from the &drm_gem_object it is associated with in case
>> + * this call unlinks the last &drm_gpuva from the &drm_gpuvm_bo.
>> + *
>> + * For every &drm_gpuva entry removed from the &drm_gpuvm_bo a reference of
>> + * the latter is dropped.
>> + *
>>    * This function expects the caller to protect the GEM's GPUVA list against
>> - * concurrent access using the GEMs dma_resv lock.
>> + * concurrent access using either the GEMs dma_resv lock or a driver specific
>> + * lock set through drm_gem_gpuva_set_lock().
>>    */
>>   void
>>   drm_gpuva_unlink(struct drm_gpuva *va)
>>   {
>>       struct drm_gem_object *obj = va->gem.obj;
> Can we ditch va->gem.obj now and replace it with an accessor to the vm_bo's pointer?

Theoretically, drm_gpuvm could be used to track mappings and create drm_gpuva_ops to
map / unmap stuff only. Not sure if anyone ever does that though.

If we decide to drop it and use the vm_bo's pointer instead, the drm_gpuva must always
carry a pointer to the vm_bo since the drm_gpuvm_sm_map() function family requires the
BO pointer (if any) to work correctly. Also I'm not sure about all the corresponding
lifecycle implications yet.

Either way, I'd prefer to approach this in a separate patch if we decide so.

>> +    struct drm_gpuvm_bo *vm_bo = va->vm_bo;
>>       if (unlikely(!obj))
>>           return;
>> @@ -902,6 +1143,11 @@ drm_gpuva_unlink(struct drm_gpuva *va)
>>       drm_gem_gpuva_assert_lock_held(obj);
>>       list_del_init(&va->gem.entry);
>> +    va->vm_bo = NULL;
>> +
>> +    drm_gem_object_get(obj);
>> +    drm_gpuvm_bo_put(vm_bo);
>> +    drm_gem_object_put(obj);
> 
> This get->put dance is unneccesary? If the caller is required to hold a lock on obj it is also required to hold a reference on obj.

I think I had the case where the driver has a separate (external) GEM gpuva lock to
protect the GEM's VM_BO list and the VM_BO's drm_gpuva list in my mind when writing this.
However, in this case we also don't need to keep a reference on the GEM object I guess...

Will remove it.

> 
> Besides, if the vm_bo's reference on obj is otherwise the last one, it will still be freed before the function exits.
> 
> /Thomas
> 
> 

