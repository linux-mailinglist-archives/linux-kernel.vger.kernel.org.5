Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531967F86DA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbjKXXkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjKXXkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:40:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42E71988
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700869224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsNn83uVzegyrMAxmthRza05bc6xMx7My6riRjbiWxM=;
        b=bhMMOa88q1XA4OTew6UlqbWK+raLc1IS3hoXERXJp0owovNvdEdfXLm/orhCBftLRWanq+
        x/EbZa0iQcD6g4Q+7vW6HQ2UGRggwLL4HavcME+f6S503CQUMRtMUOnHSLhV+i0Cr6hVqr
        hnvNbkqvbgnqXhXAKz1FYvtd9s0ZsyM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-HxeVTkc7MYe6-QPdleQNBA-1; Fri, 24 Nov 2023 18:40:22 -0500
X-MC-Unique: HxeVTkc7MYe6-QPdleQNBA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507cee14477so2390344e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700869220; x=1701474020;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsNn83uVzegyrMAxmthRza05bc6xMx7My6riRjbiWxM=;
        b=HkuEjfJrDV6nvxXRlU4UGgVeJ6BJ/gzx2nAsoF+3IhIF6hePKLZjEU5T6BGSkA7lw4
         ZRb74IpA/3zV3IWdiPQNEh7YGDYSWy92KyjelqexJEC7Ud9kQqXmUdAaMvvURmicBudB
         +TdZajLw6Qw5C+OZ7+RjOs2BYMyMBtoCvl0fIWCLd+/ivCA9MKpkNXhtV/XUbXHmI7Qd
         5vK2oi5Tqts8bbgeGQGVQasphao9RI/KNA+KlPgX+4yZOjvb8cmLkSoug42zZZJJHfsP
         5f9nHLFb4yprFZm6n+D/zWT5oma9SPTwAsVPPPmwat2Z/aSEHLAN5VQRWjF1DKBhLssX
         zvKg==
X-Gm-Message-State: AOJu0YzHXwkuPuGpI+kUbUSdO+5If7U3LxXr6NNVwWGX2ucV+wKLfMx6
        Gc3JarK4p1CuvG/X74MnsqvZDiuSoxv7fHJW029f5zTqszCX/GdHjISV+PubhR5aqwJAkcLL7E4
        u8eZCMKVF3bnsWf2yU/xqAXuHFJj2nXgE
X-Received: by 2002:ac2:5e66:0:b0:509:115c:51de with SMTP id a6-20020ac25e66000000b00509115c51demr2442994lfr.25.1700869220281;
        Fri, 24 Nov 2023 15:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE43TACgtQqni4gIc//CIbNfXYGQLDp8MQ9/Q7mckrKAY+RLB0ZlCTXb9rABMWA5a/tegKkDw==
X-Received: by 2002:ac2:5e66:0:b0:509:115c:51de with SMTP id a6-20020ac25e66000000b00509115c51demr2442983lfr.25.1700869219959;
        Fri, 24 Nov 2023 15:40:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906050a00b009fc54390966sm2673473eja.145.2023.11.24.15.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 15:40:19 -0800 (PST)
Message-ID: <3c7b7683-da36-4ffe-a250-91eef019499f@redhat.com>
Date:   Sat, 25 Nov 2023 00:40:18 +0100
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
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20231124233650.152653-5-dakr@redhat.com>
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

Hi Christian,

do you think it makes sense to handle this in drm_exec_prepare_obj() or
even dma_resv_reserve_fences() even?

- Danilo

On 11/25/23 00:36, Danilo Krummrich wrote:
> Fall back to drm_exec_lock_obj() if num_fences is zero for the
> drm_gpuvm_prepare_* function family.
> 
> Otherwise dma_resv_reserve_fences() would actually allocate slots even
> though num_fences is zero.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>   drivers/gpu/drm/drm_gpuvm.c | 36 +++++++++++++++++++++++++++++++++---
>   include/drm/drm_gpuvm.h     | 23 +++--------------------
>   2 files changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index 54f5e8851de5..d1d1c2379e44 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -1085,6 +1085,36 @@ drm_gpuvm_put(struct drm_gpuvm *gpuvm)
>   }
>   EXPORT_SYMBOL_GPL(drm_gpuvm_put);
>   
> +static int
> +exec_prepare_obj(struct drm_exec *exec, struct drm_gem_object *obj,
> +		 unsigned int num_fences)
> +{
> +	return num_fences ? drm_exec_prepare_obj(exec, obj, num_fences) :
> +			    drm_exec_lock_obj(exec, obj);
> +}
> +
> +/**
> + * drm_gpuvm_prepare_vm() - prepare the GPUVMs common dma-resv
> + * @gpuvm: the &drm_gpuvm
> + * @exec: the &drm_exec context
> + * @num_fences: the amount of &dma_fences to reserve
> + *
> + * Calls drm_exec_prepare_obj() for the GPUVMs dummy &drm_gem_object.
> + *
> + * Using this function directly, it is the drivers responsibility to call
> + * drm_exec_init() and drm_exec_fini() accordingly.
> + *
> + * Returns: 0 on success, negative error code on failure.
> + */
> +int
> +drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
> +		     struct drm_exec *exec,
> +		     unsigned int num_fences)
> +{
> +	return exec_prepare_obj(exec, gpuvm->r_obj, num_fences);
> +}
> +EXPORT_SYMBOL_GPL(drm_gpuvm_prepare_vm);
> +
>   static int
>   __drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
>   			    struct drm_exec *exec,
> @@ -1095,7 +1125,7 @@ __drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
>   	int ret = 0;
>   
>   	for_each_vm_bo_in_list(gpuvm, extobj, &extobjs, vm_bo) {
> -		ret = drm_exec_prepare_obj(exec, vm_bo->obj, num_fences);
> +		ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
>   		if (ret)
>   			break;
>   	}
> @@ -1116,7 +1146,7 @@ drm_gpuvm_prepare_objects_locked(struct drm_gpuvm *gpuvm,
>   
>   	drm_gpuvm_resv_assert_held(gpuvm);
>   	list_for_each_entry(vm_bo, &gpuvm->extobj.list, list.entry.extobj) {
> -		ret = drm_exec_prepare_obj(exec, vm_bo->obj, num_fences);
> +		ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
>   		if (ret)
>   			break;
>   
> @@ -1186,7 +1216,7 @@ drm_gpuvm_prepare_range(struct drm_gpuvm *gpuvm, struct drm_exec *exec,
>   	drm_gpuvm_for_each_va_range(va, gpuvm, addr, end) {
>   		struct drm_gem_object *obj = va->gem.obj;
>   
> -		ret = drm_exec_prepare_obj(exec, obj, num_fences);
> +		ret = exec_prepare_obj(exec, obj, num_fences);
>   		if (ret)
>   			return ret;
>   	}
> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> index f94fec9a8517..b3f82ec7fb17 100644
> --- a/include/drm/drm_gpuvm.h
> +++ b/include/drm/drm_gpuvm.h
> @@ -544,26 +544,9 @@ struct drm_gpuvm_exec {
>   	} extra;
>   };
>   
> -/**
> - * drm_gpuvm_prepare_vm() - prepare the GPUVMs common dma-resv
> - * @gpuvm: the &drm_gpuvm
> - * @exec: the &drm_exec context
> - * @num_fences: the amount of &dma_fences to reserve
> - *
> - * Calls drm_exec_prepare_obj() for the GPUVMs dummy &drm_gem_object.
> - *
> - * Using this function directly, it is the drivers responsibility to call
> - * drm_exec_init() and drm_exec_fini() accordingly.
> - *
> - * Returns: 0 on success, negative error code on failure.
> - */
> -static inline int
> -drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
> -		     struct drm_exec *exec,
> -		     unsigned int num_fences)
> -{
> -	return drm_exec_prepare_obj(exec, gpuvm->r_obj, num_fences);
> -}
> +int drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
> +			 struct drm_exec *exec,
> +			 unsigned int num_fences);
>   
>   int drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
>   			      struct drm_exec *exec,

