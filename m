Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354837FA84C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjK0RuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0RuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB812C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701107421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRrmnFrODFs76V+ONVt7h6z4FfX5C6d9b8+U6ygm7mU=;
        b=Fplc3xLXOcyQmtWJW/eGttAk4o64OQSPkC/FpjgTyJfhryUcLSkR6O0S1ZWhneq2igaiD6
        My9+3hKsDi/zNpji+Jvpqja5lTxRUWwBycz29rRzYCS13opXJyvIxjTr6YxeGLLcc5RvKM
        4daoDSjU/w1amy/4xFUntdzayA0fAfA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-ksVN9FmrPnqoauVeXCsUAg-1; Mon, 27 Nov 2023 12:50:19 -0500
X-MC-Unique: ksVN9FmrPnqoauVeXCsUAg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54acdd65e8cso2462529a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107418; x=1701712218;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRrmnFrODFs76V+ONVt7h6z4FfX5C6d9b8+U6ygm7mU=;
        b=NvygXjmB4tlNRnkHcG2oQY9tggkKYoe4Ce7fKDyaPgfM2nZExO0hpZkH/o6UPJT/Rj
         +2/L9p3pj3yo07GUMKs5OOosyUtFrFBVOc/e8OlLdOjmIZN9vBBXtUksT0bF33/KXx9R
         BiyzANsnNxiUm8X3x4pY2ViO4NHhtHgBau+CZkSGsFD0E6On/xMjuZ4Uo1R8BmrjvVRz
         e3QupIhOGG/ry9L9B4df/lA9/MGCGOS7+4+DpK+LdTJPRcoqvSqFuX5O4rDLudcYAt0E
         SJWMy5wcjgo21n07Xc1JpIDijSUfLCTYr+2xflzaaFQfBKtpCNjJ/FCXLU5q6DCGus4D
         s6qw==
X-Gm-Message-State: AOJu0YyGx/GCJwMmUvtq40PmTzWrg10Isf1Y900jahdo4X2ljtN4YizG
        O79gmcSCO3FdZ40EBpWzvjPFkxSjrIM/EvvVQ20pBW3lphDgJ7X3luIr2V4FG104ST41VIAnnxc
        ZftILTIzxW2awnYUl6uPT6rnL
X-Received: by 2002:a50:aac2:0:b0:548:4a43:8c6e with SMTP id r2-20020a50aac2000000b005484a438c6emr8223131edc.5.1701107418599;
        Mon, 27 Nov 2023 09:50:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPK4FxFJY84U6jF2RP0ECMu2gN/ocuxDS4lXEx/ksyXdPig8RJk2QSEVzOtCjY/itBQ/RFzQ==
X-Received: by 2002:a50:aac2:0:b0:548:4a43:8c6e with SMTP id r2-20020a50aac2000000b005484a438c6emr8223123edc.5.1701107418261;
        Mon, 27 Nov 2023 09:50:18 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id n3-20020aa7c783000000b0054901c25d50sm5405285eds.14.2023.11.27.09.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:50:17 -0800 (PST)
Message-ID: <92227297-af97-4d64-bd95-3217de851fe7@redhat.com>
Date:   Mon, 27 Nov 2023 18:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next 4/5] drm/gpuvm: fall back to
 drm_exec_lock_obj()
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231124233650.152653-1-dakr@redhat.com>
 <20231124233650.152653-5-dakr@redhat.com>
 <3c7b7683-da36-4ffe-a250-91eef019499f@redhat.com>
 <762bb5f4-f9f5-4ebc-84d3-5465df3ffbf6@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <762bb5f4-f9f5-4ebc-84d3-5465df3ffbf6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/27/23 14:52, Christian König wrote:
> Am 25.11.23 um 00:40 schrieb Danilo Krummrich:
>> Hi Christian,
>>
>> do you think it makes sense to handle this in drm_exec_prepare_obj() or
>> even dma_resv_reserve_fences() even?
> 
> IIRC for drm_exec the discussion has gone a bit back and forth between handling 0 and having a separate function which doesn't allocate fences.
> 
> We ended up with the solution using separate calls since you either know that you don't need fences (because you for example only need to look something up) or you need fences and eventually calculate the number you need dynamically and if you then end up with 0 it's a bug.

I don't have a strong opinion on that. Though, in GPUVM I'd probably still need some wrapper like

+exec_prepare_obj(struct drm_exec *exec, struct drm_gem_object *obj,
+         unsigned int num_fences)
+{
+    return num_fences ? drm_exec_prepare_obj(exec, obj, num_fences) :
+                drm_exec_lock_obj(exec, obj);
+}

to prevent either duplicate code or rather unnecessary complicated abstractions.

And I'm not sure it's super nice that drm_gpuvm_prepare_objects() allows zero fences, whereas drm_exec_prepare_obj() does not.

> 
> So to sum it up the conclusion was that it's more defensive to complain about 0 fences to reserve (which reminds me that dma_resv_reserve_fences() still needs to get a warning for 0 fences as well).

What's the logic you'd want to apply there? WARN() but still allocate at least 4 slots or WARN() and return doing nothing?

- Danilo

> 
> Regards,
> Christian.
> 
>>
>> - Danilo
>>
>> On 11/25/23 00:36, Danilo Krummrich wrote:
>>> Fall back to drm_exec_lock_obj() if num_fences is zero for the
>>> drm_gpuvm_prepare_* function family.
>>>
>>> Otherwise dma_resv_reserve_fences() would actually allocate slots even
>>> though num_fences is zero.
>>>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>> ---
>>>   drivers/gpu/drm/drm_gpuvm.c | 36 +++++++++++++++++++++++++++++++++---
>>>   include/drm/drm_gpuvm.h     | 23 +++--------------------
>>>   2 files changed, 36 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
>>> index 54f5e8851de5..d1d1c2379e44 100644
>>> --- a/drivers/gpu/drm/drm_gpuvm.c
>>> +++ b/drivers/gpu/drm/drm_gpuvm.c
>>> @@ -1085,6 +1085,36 @@ drm_gpuvm_put(struct drm_gpuvm *gpuvm)
>>>   }
>>>   EXPORT_SYMBOL_GPL(drm_gpuvm_put);
>>>   +static int
>>> +exec_prepare_obj(struct drm_exec *exec, struct drm_gem_object *obj,
>>> +         unsigned int num_fences)
>>> +{
>>> +    return num_fences ? drm_exec_prepare_obj(exec, obj, num_fences) :
>>> +                drm_exec_lock_obj(exec, obj);
>>> +}
>>> +
>>> +/**
>>> + * drm_gpuvm_prepare_vm() - prepare the GPUVMs common dma-resv
>>> + * @gpuvm: the &drm_gpuvm
>>> + * @exec: the &drm_exec context
>>> + * @num_fences: the amount of &dma_fences to reserve
>>> + *
>>> + * Calls drm_exec_prepare_obj() for the GPUVMs dummy &drm_gem_object.
>>> + *
>>> + * Using this function directly, it is the drivers responsibility to call
>>> + * drm_exec_init() and drm_exec_fini() accordingly.
>>> + *
>>> + * Returns: 0 on success, negative error code on failure.
>>> + */
>>> +int
>>> +drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
>>> +             struct drm_exec *exec,
>>> +             unsigned int num_fences)
>>> +{
>>> +    return exec_prepare_obj(exec, gpuvm->r_obj, num_fences);
>>> +}
>>> +EXPORT_SYMBOL_GPL(drm_gpuvm_prepare_vm);
>>> +
>>>   static int
>>>   __drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
>>>                   struct drm_exec *exec,
>>> @@ -1095,7 +1125,7 @@ __drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
>>>       int ret = 0;
>>>         for_each_vm_bo_in_list(gpuvm, extobj, &extobjs, vm_bo) {
>>> -        ret = drm_exec_prepare_obj(exec, vm_bo->obj, num_fences);
>>> +        ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
>>>           if (ret)
>>>               break;
>>>       }
>>> @@ -1116,7 +1146,7 @@ drm_gpuvm_prepare_objects_locked(struct drm_gpuvm *gpuvm,
>>>         drm_gpuvm_resv_assert_held(gpuvm);
>>>       list_for_each_entry(vm_bo, &gpuvm->extobj.list, list.entry.extobj) {
>>> -        ret = drm_exec_prepare_obj(exec, vm_bo->obj, num_fences);
>>> +        ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
>>>           if (ret)
>>>               break;
>>>   @@ -1186,7 +1216,7 @@ drm_gpuvm_prepare_range(struct drm_gpuvm *gpuvm, struct drm_exec *exec,
>>>       drm_gpuvm_for_each_va_range(va, gpuvm, addr, end) {
>>>           struct drm_gem_object *obj = va->gem.obj;
>>>   -        ret = drm_exec_prepare_obj(exec, obj, num_fences);
>>> +        ret = exec_prepare_obj(exec, obj, num_fences);
>>>           if (ret)
>>>               return ret;
>>>       }
>>> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
>>> index f94fec9a8517..b3f82ec7fb17 100644
>>> --- a/include/drm/drm_gpuvm.h
>>> +++ b/include/drm/drm_gpuvm.h
>>> @@ -544,26 +544,9 @@ struct drm_gpuvm_exec {
>>>       } extra;
>>>   };
>>>   -/**
>>> - * drm_gpuvm_prepare_vm() - prepare the GPUVMs common dma-resv
>>> - * @gpuvm: the &drm_gpuvm
>>> - * @exec: the &drm_exec context
>>> - * @num_fences: the amount of &dma_fences to reserve
>>> - *
>>> - * Calls drm_exec_prepare_obj() for the GPUVMs dummy &drm_gem_object.
>>> - *
>>> - * Using this function directly, it is the drivers responsibility to call
>>> - * drm_exec_init() and drm_exec_fini() accordingly.
>>> - *
>>> - * Returns: 0 on success, negative error code on failure.
>>> - */
>>> -static inline int
>>> -drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
>>> -             struct drm_exec *exec,
>>> -             unsigned int num_fences)
>>> -{
>>> -    return drm_exec_prepare_obj(exec, gpuvm->r_obj, num_fences);
>>> -}
>>> +int drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
>>> +             struct drm_exec *exec,
>>> +             unsigned int num_fences);
>>>     int drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
>>>                     struct drm_exec *exec,
>>
> 

