Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0796B7BD10A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbjJHWt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53377A3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696805349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RoCeCoMX24/5hVyJobJrqkSrDRXDwE+1UdG/KoqV90=;
        b=BcE0x8SFe2kusgJ+lhAKCcLkYyipGu/lNpZ/8mkBvPqkjuyoSz/90zj8VVGXBoktm9Q3YO
        rOM1e3hIP2HdT4TOYxJPgzUzRH2lf7Ak/PVF3HAkCTJrFtX6jDTZqE8UNj7myBFbKWPYBx
        gQJmBN2yzCHsqe7xetPJeJ+Mv9/3yok=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-0qqzrqimOq6zfmJCtAvNpw-1; Sun, 08 Oct 2023 18:49:02 -0400
X-MC-Unique: 0qqzrqimOq6zfmJCtAvNpw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b2e030e4caso538186266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 15:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696805342; x=1697410142;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RoCeCoMX24/5hVyJobJrqkSrDRXDwE+1UdG/KoqV90=;
        b=Nbcnd58MBnSzes9SyGlSe+Coa3i2nsVgydsaCqBEqneSZk4NX0ckGukjn46pe2Abi/
         +HABmqGM+mXpa9xozxh0fGk1wCEENnJuFWkgJIUaaSWFZMrMu6d3Dtk1tml4r7x++QGW
         ohKyEZ1D3HItyr6ETh37NXM84XEKsKDjFzQ7tcPqESrSs6nNVUOaXsrHFbkOiu92rpHV
         AeDj8VOGFzXG691Vr2RczpHbWWdZgt3Vns+mWHW8u0Ty27lCA/zmDIJGcjMMeLAtxA06
         NzNwLXzOdrKnWpNeaN5NVMKwnUrm/eScZwrRvkbHfEt4VoneqNALWv8fuuZ2dQayH+J0
         8KIA==
X-Gm-Message-State: AOJu0YwNwaZqo94inWrjTPyWjz0jxqKlbjUv/sXD6oh9UUMOhaVaHcVz
        oqgIDGX25hNPghvPCKaq4c3s633eN6qZ6V/3LuVaBVnj6SMyGFQVMowvDbvqtGtorQKAm0fdEzp
        7QHVUf7xCY+N7j88PmJYcAdrH
X-Received: by 2002:a17:907:9491:b0:9a5:962c:cb6c with SMTP id dm17-20020a170907949100b009a5962ccb6cmr9517882ejc.31.1696805341908;
        Sun, 08 Oct 2023 15:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxCqadhL+eBtO1UnN5jQ0+5sVr4DxJPJn1QuUXhLYYWy1tVT37JkrCntS4Ig7ahTqbpbyayg==
X-Received: by 2002:a17:907:9491:b0:9a5:962c:cb6c with SMTP id dm17-20020a170907949100b009a5962ccb6cmr9517865ejc.31.1696805341476;
        Sun, 08 Oct 2023 15:49:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id p7-20020a056402074700b0052f3471ccf6sm5426490edy.6.2023.10.08.15.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 15:49:00 -0700 (PDT)
Message-ID: <ec74271d-93b3-1c37-969b-aecc2d3deb7d@redhat.com>
Date:   Mon, 9 Oct 2023 00:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v5 0/6] [RFC] DRM GPUVM features
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230928191624.13703-1-dakr@redhat.com>
 <95bfbf5c-286c-57a4-0170-19d775cf8d6b@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <95bfbf5c-286c-57a4-0170-19d775cf8d6b@linux.intel.com>
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

Hi Thomas,

On 10/5/23 11:35, Thomas Hellström wrote:
> Hi, Danilo
> 
> On 9/28/23 21:16, Danilo Krummrich wrote:
>> Currently GPUVM offers common infrastructure to track GPU VA allocations
>> and mappings, generically connect GPU VA mappings to their backing
>> buffers and perform more complex mapping operations on the GPU VA space.
>>
>> However, there are more design patterns commonly used by drivers, which
>> can potentially be generalized in order to make GPUVM represent the
>> basis of a VM implementation. In this context, this patch series aims at
>> generalizing the following elements.
>>
>> 1) Provide a common dma-resv for GEM objects not being used outside of
>>     this GPU-VM.
>>
>> 2) Provide tracking of external GEM objects (GEM objects which are
>>     shared with other GPU-VMs).
>>
>> 3) Provide functions to efficiently lock all GEM objects dma-resv the
>>     GPU-VM contains mappings of.
>>
>> 4) Provide tracking of evicted GEM objects the GPU-VM contains mappings
>>     of, such that validation of evicted GEM objects is accelerated.
>>
>> 5) Provide some convinience functions for common patterns.
>>
>> The implementation introduces struct drm_gpuvm_bo, which serves as abstraction
>> combining a struct drm_gpuvm and struct drm_gem_object, similar to what
>> amdgpu does with struct amdgpu_bo_vm. While this adds a bit of complexity it
>> improves the efficiency of tracking external and evicted GEM objects.
>>
>> This patch series is also available at [3].
>>
>> [1] https://gitlab.freedesktop.org/nouvelles/kernel/-/commits/gpuvm-next
>>
>> Changes in V2:
>> ==============
>>    - rename 'drm_gpuva_manager' -> 'drm_gpuvm' which generally leads to more
>>      consistent naming
>>    - properly separate commits (introduce common dma-resv, drm_gpuvm_bo
>>      abstraction, etc.)
>>    - remove maple tree for tracking external objects, use a list drm_gpuvm_bos
>>      per drm_gpuvm instead
>>    - rework dma-resv locking helpers (Thomas)
>>    - add a locking helper for a given range of the VA space (Christian)
>>    - make the GPUVA manager buildable as module, rather than drm_exec
>>      builtin (Christian)
>>
>> Changes in V3:
>> ==============
>>    - rename missing function and files (Boris)
>>    - warn if vm_obj->obj != obj in drm_gpuva_link() (Boris)
>>    - don't expose drm_gpuvm_bo_destroy() (Boris)
>>    - unlink VM_BO from GEM in drm_gpuvm_bo_destroy() rather than
>>      drm_gpuva_unlink() and link within drm_gpuvm_bo_obtain() to keep
>>      drm_gpuvm_bo instances unique
>>    - add internal locking to external and evicted object lists to support drivers
>>      updating the VA space from within the fence signalling critical path (Boris)
>>    - unlink external objects and evicted objects from the GPUVM's list in
>>      drm_gpuvm_bo_destroy()
>>    - add more documentation and fix some kernel doc issues
>>
>> Changes in V4:
>> ==============
>>    - add a drm_gpuvm_resv() helper (Boris)
>>    - add a drm_gpuvm::<list_name>::local_list field (Boris)
>>    - remove drm_gpuvm_bo_get_unless_zero() helper (Boris)
>>    - fix missing NULL assignment in get_next_vm_bo_from_list() (Boris)
>>    - keep a drm_gem_object reference on potential vm_bo destroy (alternatively we
>>      could free the vm_bo and drop the vm_bo's drm_gem_object reference through
>>      async work)
>>    - introduce DRM_GPUVM_RESV_PROTECTED flag to indicate external locking through
>>      the corresponding dma-resv locks to optimize for drivers already holding
>>      them when needed; add the corresponding lock_assert_held() calls (Thomas)
>>    - make drm_gpuvm_bo_evict() per vm_bo and add a drm_gpuvm_bo_gem_evict()
>>      helper (Thomas)
>>    - pass a drm_gpuvm_bo in drm_gpuvm_ops::vm_bo_validate() (Thomas)
>>    - documentation fixes
>>
>> Changes in V5:
>> ==============
>>    - use a root drm_gem_object provided by the driver as a base for the VM's
>>      common dma-resv (Christian)
>>    - provide a helper to allocate a "dummy" root GEM object in case a driver
>>      specific root GEM object isn't available
>>    - add a dedicated patch for nouveau to make use of the GPUVM's shared dma-resv
>>    - improve documentation (Boris)
>>    - the following patches are removed from the series, since they already landed
>>      in drm-misc-next
>>      - f72c2db47080 ("drm/gpuvm: rename struct drm_gpuva_manager to struct drm_gpuvm")
>>      - fe7acaa727e1 ("drm/gpuvm: allow building as module")
>>      - 78f54469b871 ("drm/nouveau: uvmm: rename 'umgr' to 'base'")
>>
>> Danilo Krummrich (6):
>>    drm/gpuvm: add common dma-resv per struct drm_gpuvm
>>    drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm
>>    drm/gpuvm: add an abstraction for a VM / BO combination
>>    drm/gpuvm: track/lock/validate external/evicted objects
>>    drm/nouveau: make use of the GPUVM's shared dma-resv
>>    drm/nouveau: use GPUVM common infrastructure
>>
>>   drivers/gpu/drm/drm_gpuvm.c             | 1036 +++++++++++++++++++++--
>>   drivers/gpu/drm/nouveau/nouveau_bo.c    |   15 +-
>>   drivers/gpu/drm/nouveau/nouveau_bo.h    |    5 +
>>   drivers/gpu/drm/nouveau/nouveau_exec.c  |   52 +-
>>   drivers/gpu/drm/nouveau/nouveau_exec.h  |    4 -
>>   drivers/gpu/drm/nouveau/nouveau_gem.c   |   10 +-
>>   drivers/gpu/drm/nouveau/nouveau_sched.h |    4 +-
>>   drivers/gpu/drm/nouveau/nouveau_uvmm.c  |  183 ++--
>>   drivers/gpu/drm/nouveau/nouveau_uvmm.h  |    1 -
>>   include/drm/drm_gem.h                   |   32 +-
>>   include/drm/drm_gpuvm.h                 |  465 +++++++++-
>>   11 files changed, 1625 insertions(+), 182 deletions(-)
>>
>>
>> base-commit: a4ead6e37e3290cff399e2598d75e98777b69b37
> 
> One comment I had before on the GPUVM code in general was the licensing, but I'm not sure there was a reply. Is it possible to have this code dual MIT / GPLV2?

Personally, I don't have any objections. Please feel free to send a patch to change it, I'm happy to ACK it.

- Danilo

> 
> Thanks,
> 
> Thomas
> 
> 
> 

