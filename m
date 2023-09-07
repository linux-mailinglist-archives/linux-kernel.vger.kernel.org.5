Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E642879749E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjIGPkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245445AbjIGPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F371FCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694100825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YnyTRR6tMkGERN8b/9+xcC7xMqnGekjmEizvTb1pzc=;
        b=AMZWfAM+a7uOzdh/6QYNWogJFxEDUFecVjbfRrLNIOH0zrL+oSrG0huYStcqC1LnIeWk4r
        xy9or5Dm2Uk3o0SuJN1zKRI6QfYNFzPLs9Fe+Ltvs056wJuy3ennJUw90H9eooLLlpobA/
        jtQ1yWYm2yYOO1+pxFkMsDLwjVSwFe0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-xmht-fQ3NrayrQX_KSx8Bg-1; Thu, 07 Sep 2023 05:11:42 -0400
X-MC-Unique: xmht-fQ3NrayrQX_KSx8Bg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a62adedadbso44819666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 02:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694077901; x=1694682701;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YnyTRR6tMkGERN8b/9+xcC7xMqnGekjmEizvTb1pzc=;
        b=c/9WlUsWmLvNkhW2luqdoBY2sWVyY1qjNU6KXnxkf7XW132rYEIqGpe9TLDTyfcSCW
         IqenlKWNZtJzqcJNBStm+g+yQSOX+ZH3Rvp/eddyel1Rj6OHdWmVMtLuZiZrynZ9gyCz
         S8JaslEEqdjdVp3XSjYjqNsokAR1mKWamNW4HcyX7fOQSMV7XP8t8arctTCHyht95xbn
         8jtkHLusNWB74y1HM/GE1vljlLFl7Wz9h8MsmzvSMOLrtvK1RnHd81uNyh3IUTpr/BMd
         70F3ak3ZuSNVaQiwaT/R99xuOR2APDteO1LsuQdUEMClSXVkofIb8W9rfqs4Ok2NvKwx
         SOxw==
X-Gm-Message-State: AOJu0Yz2Eg1jMGbjoL4eX1EkFBjcw+iYl283rHjYJHuz2RZIFWpmdjnt
        X1Stwq3MZCgpYp3t4xHZzT8id/XNFd4y8CJ1IEA6VNFtXES09VXqenl5XIzNtgnwlka6cRAoP3L
        YBtVUZuR3AQTXbMNRfPlIsZgs
X-Received: by 2002:a17:906:5a70:b0:9a1:c352:b6a5 with SMTP id my48-20020a1709065a7000b009a1c352b6a5mr4656301ejc.69.1694077901273;
        Thu, 07 Sep 2023 02:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPbdeLZzS8ttk/yjs2IW+39K0hV5ihSPugQejYTnmMfrcEgSvEwCcItJyfPVPbdXGAhjaTKg==
X-Received: by 2002:a17:906:5a70:b0:9a1:c352:b6a5 with SMTP id my48-20020a1709065a7000b009a1c352b6a5mr4656280ejc.69.1694077900967;
        Thu, 07 Sep 2023 02:11:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id j26-20020a1709064b5a00b00988be3c1d87sm10198891ejv.116.2023.09.07.02.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 02:11:40 -0700 (PDT)
Message-ID: <2a473b06-69c1-f620-7595-b119c639669b@redhat.com>
Date:   Thu, 7 Sep 2023 11:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v2 5/7] drm/gpuvm: add an abstraction for a
 VM / BO combination
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230906214723.4393-1-dakr@redhat.com>
 <20230906214723.4393-6-dakr@redhat.com>
 <20230907101630.7213c919@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230907101630.7213c919@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 10:16, Boris Brezillon wrote:
> On Wed,  6 Sep 2023 23:47:13 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> @@ -812,15 +967,20 @@ EXPORT_SYMBOL_GPL(drm_gpuva_remove);
>>   /**
>>    * drm_gpuva_link() - link a &drm_gpuva
>>    * @va: the &drm_gpuva to link
>> + * @vm_bo: the &drm_gpuvm_bo to add the &drm_gpuva to
>>    *
>> - * This adds the given &va to the GPU VA list of the &drm_gem_object it is
>> - * associated with.
>> + * This adds the given &va to the GPU VA list of the &drm_gpuvm_bo and the
>> + * &drm_gpuvm_bo to the &drm_gem_object it is associated with.
>> + *
>> + * For every &drm_gpuva entry added to the &drm_gpuvm_bo an additional
>> + * reference of the latter is taken.
>>    *
>>    * This function expects the caller to protect the GEM's GPUVA list against
>> - * concurrent access using the GEMs dma_resv lock.
>> + * concurrent access using either the GEMs dma_resv lock or a driver specific
>> + * lock set through drm_gem_gpuva_set_lock().
>>    */
>>   void
>> -drm_gpuva_link(struct drm_gpuva *va)
>> +drm_gpuva_link(struct drm_gpuva *va, struct drm_gpuvm_bo *vm_bo)
>>   {
>>   	struct drm_gem_object *obj = va->gem.obj;
>>   
>> @@ -829,7 +989,10 @@ drm_gpuva_link(struct drm_gpuva *va)
>>   
>>   	drm_gem_gpuva_assert_lock_held(obj);
>>   
>> -	list_add_tail(&va->gem.entry, &obj->gpuva.list);
>> +	drm_gpuvm_bo_get(vm_bo);
> 
> Guess we should WARN if vm_obj->obj == obj, at least.
> 
>> +	list_add_tail(&va->gem.entry, &vm_bo->list.gpuva);
>> +	if (list_empty(&vm_bo->list.entry.gem))
>> +		list_add_tail(&vm_bo->list.entry.gem, &obj->gpuva.list);
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpuva_link);
>>   
>> @@ -840,20 +1003,40 @@ EXPORT_SYMBOL_GPL(drm_gpuva_link);
>>    * This removes the given &va from the GPU VA list of the &drm_gem_object it is
>>    * associated with.
>>    *
>> + * This removes the given &va from the GPU VA list of the &drm_gpuvm_bo and
>> + * the &drm_gpuvm_bo from the &drm_gem_object it is associated with in case
>> + * this call unlinks the last &drm_gpuva from the &drm_gpuvm_bo.
>> + *
>> + * For every &drm_gpuva entry removed from the &drm_gpuvm_bo a reference of
>> + * the latter is dropped.
>> + *
>>    * This function expects the caller to protect the GEM's GPUVA list against
>> - * concurrent access using the GEMs dma_resv lock.
>> + * concurrent access using either the GEMs dma_resv lock or a driver specific
>> + * lock set through drm_gem_gpuva_set_lock().
>>    */
>>   void
>>   drm_gpuva_unlink(struct drm_gpuva *va)
>>   {
>>   	struct drm_gem_object *obj = va->gem.obj;
>> +	struct drm_gpuvm_bo *vm_bo;
>>   
>>   	if (unlikely(!obj))
>>   		return;
>>   
>>   	drm_gem_gpuva_assert_lock_held(obj);
>>   
>> +	vm_bo = __drm_gpuvm_bo_find(va->vm, obj);
> 
> Could we add a drm_gpuva::vm_bo field so we don't have to search the
> vm_bo here, and maybe drop the drm_gpuva::vm and drm_gpuva::obj fields,
> since drm_gpuvm_bo contains both the vm and the GEM object. I know that
> means adding an extra indirection + allocation for drivers that don't
> want to use drm_gpuva_[un]link(), but I wonder if it's not preferable
> over having the information duplicated (with potential mismatch)

I was considering that and I think we can add a drm_gpuva::vm_bo field and
get rid of drm_gpuva::obj. However, I think we need to keep drm_gpuva::vm,
since it is valid for ::obj to be NULL, hence it must be valid for ::vm_bo too.
Null objects are used for sparse mappings / userptr.

> 
>> +	if (WARN(!vm_bo, "GPUVA doesn't seem to be linked.\n"))
>> +		return;
>> +
>>   	list_del_init(&va->gem.entry);
>> +
>> +	/* This is the last mapping being unlinked for this GEM object, hence
>> +	 * also remove the VM_BO from the GEM's gpuva list.
>> +	 */
>> +	if (list_empty(&vm_bo->list.gpuva))
>> +		list_del_init(&vm_bo->list.entry.gem);
>> +	drm_gpuvm_bo_put(vm_bo);
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpuva_unlink);
> 

