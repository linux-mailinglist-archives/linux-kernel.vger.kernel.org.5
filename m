Return-Path: <linux-kernel+bounces-36547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFAF83A2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24741C22EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8F2168CC;
	Wed, 24 Jan 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/6htkrm"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA25168AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081362; cv=none; b=cBC398r7ie4xdlMaSizUJYDZLQDpc9lCHTR4OKvzT8ZrfHXGLdtPakfT/qZiC24Fu/6VVSakn6fKiT/ZN2DoXSgRddEXEc5r1sX36dODrUXdKSD6cq1qCTcAIgTxrd+4QnXe1mH99PgZ0H95DpszjYo4WLuIHCHYAMRLa6lb2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081362; c=relaxed/simple;
	bh=a226tXJZ4iLS7vLP38b/eUui/aT8TFVKeypyO2iv26U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhJiuC2eLepDmXOnG3g9unP6zfXWG8ftHAc5XZxTRD77baqVjDlEswfVlH83g5mjRRrAXCklmhYq5g344t5UTvK5RHQANLQIKAV4rOLVNnnLU50TmLSjEMJOvq8myBSf+2LJaZR489POXmeMEAfrR1FcD8mApOF6L1iXCkktC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/6htkrm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ec6a002a7so2526745e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706081358; x=1706686158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DRGXaVxKMFHx2hiT7iy2bNi9Kyy1UbBqRbOG7bk9EA=;
        b=Y/6htkrmJ6ci1nKKDPW7v7urpkcpGHr3LboQP7R5JvVrNGKsFis7l+/Gm06SwUDG6A
         8pGYYcAPcdJ7bFM9ILl4d5P8HZbL7qtW0KLWQbMEWswSTZAwBqPSKPB1L3yyEwSzPMCT
         lnWO+c/odQM/oQShfsOeHMTUU5YY04ytBr1OR0ohLMObdihX+BkPoJN1+HXr32mZzwrE
         mYdBQe5zGlBhWuT6GPvO1IQ2ODUg97MzePmoZMuVGk6tE5G1G5tXR5gdhZPOp7PpUAZr
         u2GeFsJ5UNSdgKO8pdpKzO1c0EutnTBsmT4fjNMW+R8hNrU7xQ1y984JXB/K4CT9ZXww
         KCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081358; x=1706686158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DRGXaVxKMFHx2hiT7iy2bNi9Kyy1UbBqRbOG7bk9EA=;
        b=CgiulpJLQ5FZea1R5bui1CAhMNEge5CJofuNNY1FuPsBeGqta7xqDBXreQ21g7IZiv
         5rAybo6X4weoPDd/DZMVlqYuvJnBryHseZPjRduZ51jPyIJ3j8UR4Ejqy+ygSGRTOKTM
         CrcEOIqmeESGaFhTEGWY3oHC93MJKnMJuiSlp1k1KRbRXYYfYVuOiHEFgoPmFhE48v7X
         3KmJRHkd2Mnt6HooAemi7n4QZaMbtoI+g4yKhYOVnMIljBkI823J6F3G2OXOpy8hfPdq
         zCzp4dsqDksnh2WSnhx/rlf6VsgaIOYhaoYZ7OGirGWvX3zixy0jFgETp1YP/+JPhbt7
         /MZg==
X-Gm-Message-State: AOJu0YwgGx2JEgydA2XayrlmVTuFm7y4xalrQ3Ld/iSpQnQ0J8x3OlUS
	P6pAMriaJ2auCfoxGG4/CUh0AweVJNkHRcXk+fJe/KAeAIGSHuuN
X-Google-Smtp-Source: AGHT+IHyzerc8ODlelT9LcIwOXuNITuEKHKrpG9psQo5pdYryIcUoR+iK8dwa6wgUjXdTp7WS5B1lg==
X-Received: by 2002:a05:600c:33a5:b0:40e:43e4:d9ca with SMTP id o37-20020a05600c33a500b0040e43e4d9camr560010wmp.179.1706081357705;
        Tue, 23 Jan 2024 23:29:17 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b0040e63226f6dsm303045wmq.1.2024.01.23.23.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 23:29:17 -0800 (PST)
Message-ID: <a307539f-8894-4d5f-a32d-3936e6fba65f@gmail.com>
Date: Wed, 24 Jan 2024 08:29:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove double faults once write a device pfn
Content-Language: en-US
To: "Zhou, Xianrong" <Xianrong.Zhou@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "lee@kernel.org" <lee@kernel.org>, "kherbst@redhat.com"
 <kherbst@redhat.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Huang, Ray" <Ray.Huang@amd.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "zack.rusin@broadcom.com" <zack.rusin@broadcom.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "Li, Huazeng" <Huazeng.Li@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Xu, Colin" <Colin.Xu@amd.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "dakr@redhat.com" <dakr@redhat.com>,
 "matthew.auld@intel.com" <matthew.auld@intel.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>, "Yang, Philip"
 <Philip.Yang@amd.com>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "mripard@kernel.org" <mripard@kernel.org>,
 "luto@kernel.org" <luto@kernel.org>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Zhu, James" <James.Zhu@amd.com>,
 "surenb@google.com" <surenb@google.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "nirmoy.das@intel.com" <nirmoy.das@intel.com>
References: <20240122033210.713530-1-Xianrong.Zhou@amd.com>
 <5ed7d46b-ae26-43f2-81e0-91e3cfc0218a@amd.com>
 <MN2PR12MB4302C529B9F231F85539628EF1742@MN2PR12MB4302.namprd12.prod.outlook.com>
 <76c3658d-2256-49c6-8e4c-49555c0a350a@amd.com>
 <MN2PR12MB4302BBF634B2E3872904872BF17B2@MN2PR12MB4302.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MN2PR12MB4302BBF634B2E3872904872BF17B2@MN2PR12MB4302.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 24.01.24 um 03:43 schrieb Zhou, Xianrong:
> [AMD Official Use Only - General]
>
>>>>> The vmf_insert_pfn_prot could cause unnecessary double faults on a
>>>>> device pfn. Because currently the vmf_insert_pfn_prot does not make
>>>>> the pfn writable so the pte entry is normally read-only or dirty
>>>>> catching.
>>>> What? How do you got to this conclusion?
>>> Sorry. I did not mention that this problem only exists on arm64 platform.
>> Ok, that makes at least a little bit more sense.
>>
>>> Because on arm64 platform the PTE_RDONLY is automatically attached to
>>> the userspace pte entries even through VM_WRITE + VM_SHARE.
>>> The  PTE_RDONLY needs to be cleared in vmf_insert_pfn_prot. However
>>> vmf_insert_pfn_prot do not make the pte writable passing false
>>> @mkwrite to insert_pfn.
>> Question is why is arm64 doing this? As far as I can see they must have some
>> hardware reason for that.
>>
>> The mkwrite parameter to insert_pfn() was added by commit
>> b2770da642540 to make insert_pfn() look more like insert_pfn_pmd() so that
>> the DAX code can insert PTEs which are writable and dirty at the same time.
>>
> This is one scenario to do so. In fact on arm64 there are many scenarios could
> be to do so. So we can let vmf_insert_pfn_prot supporting @mkwrite for drivers
> at core layer and let drivers to decide whether or not to make writable and dirty
> at one time. The patch did this. Otherwise double faults on arm64 when call
> vmf_insert_pfn_prot.

Well, that doesn't answer my question why arm64 is double faulting in 
the first place,.

So as long as this isn't sorted out I'm going to reject this patch.

Regards,
Christian.

>
>> This is a completely different use case to what you try to use it here for and
>> that looks extremely fishy to me.
>>
>> Regards,
>> Christian.
>>
>>>>> The first fault only sets up the pte entry which actually is dirty
>>>>> catching. And the second immediate fault to the pfn due to first
>>>>> dirty catching when the cpu re-execute the store instruction.
>>>> It could be that this is done to work around some hw behavior, but
>>>> not because of dirty catching.
>>>>
>>>>> Normally if the drivers call vmf_insert_pfn_prot and also supply
>>>>> 'pfn_mkwrite' callback within vm_operations_struct which requires
>>>>> the pte to be dirty catching then the vmf_insert_pfn_prot and the
>>>>> double fault are reasonable. It is not a problem.
>>>> Well, as far as I can see that behavior absolutely doesn't make sense.
>>>>
>>>> When pfn_mkwrite is requested then the driver should use PAGE_COPY,
>>>> which is exactly what VMWGFX (the only driver using dirty tracking) is
>> doing.
>>>> Everybody else uses PAGE_SHARED which should make the pte writeable
>>>> immediately.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> However the most of drivers calling vmf_insert_pfn_prot do not
>>>>> supply the 'pfn_mkwrite' callback so that the second fault is unnecessary.
>>>>>
>>>>> So just like vmf_insert_mixed and vmf_insert_mixed_mkwrite pair, we
>>>>> should also supply vmf_insert_pfn_mkwrite for drivers as well.
>>>>>
>>>>> Signed-off-by: Xianrong Zhou <Xianrong.Zhou@amd.com>
>>>>> ---
>>>>>     arch/x86/entry/vdso/vma.c                  |  3 ++-
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  2 +-
>>>>>     drivers/gpu/drm/i915/gem/i915_gem_ttm.c    |  2 +-
>>>>>     drivers/gpu/drm/nouveau/nouveau_gem.c      |  2 +-
>>>>>     drivers/gpu/drm/radeon/radeon_gem.c        |  2 +-
>>>>>     drivers/gpu/drm/ttm/ttm_bo_vm.c            |  8 +++++---
>>>>>     drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |  8 +++++---
>>>>>     include/drm/ttm/ttm_bo.h                   |  3 ++-
>>>>>     include/linux/mm.h                         |  2 +-
>>>>>     mm/memory.c                                | 14 +++++++++++---
>>>>>     10 files changed, 30 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
>>>>> index 7645730dc228..dd2431c2975f 100644
>>>>> --- a/arch/x86/entry/vdso/vma.c
>>>>> +++ b/arch/x86/entry/vdso/vma.c
>>>>> @@ -185,7 +185,8 @@ static vm_fault_t vvar_fault(const struct
>>>> vm_special_mapping *sm,
>>>>>               if (pvti && vclock_was_used(VDSO_CLOCKMODE_PVCLOCK))
>>>> {
>>>>>                       return vmf_insert_pfn_prot(vma, vmf->address,
>>>>>                                       __pa(pvti) >> PAGE_SHIFT,
>>>>> -                                   pgprot_decrypted(vma-
>>>>> vm_page_prot));
>>>>> +                                   pgprot_decrypted(vma-
>>>>> vm_page_prot),
>>>>> +                                   true);
>>>>>               }
>>>>>       } else if (sym_offset == image->sym_hvclock_page) {
>>>>>               pfn = hv_get_tsc_pfn(); diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> index 49a5f1c73b3e..adcb20d9e624 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> @@ -64,7 +64,7 @@ static vm_fault_t amdgpu_gem_fault(struct
>> vm_fault
>>>> *vmf)
>>>>>               }
>>>>>
>>>>>               ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma-
>>>>> vm_page_prot,
>>>>> -                                          TTM_BO_VM_NUM_PREFAULT);
>>>>> +                                          TTM_BO_VM_NUM_PREFAULT,
>>>> true);
>>>>>               drm_dev_exit(idx);
>>>>>       } else {
>>>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>>> b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>>> index 9227f8146a58..c6f13ae6c308 100644
>>>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>>>>> @@ -1114,7 +1114,7 @@ static vm_fault_t vm_fault_ttm(struct vm_fault
>>>>> *vmf)
>>>>>
>>>>>       if (drm_dev_enter(dev, &idx)) {
>>>>>               ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma-
>>>>> vm_page_prot,
>>>>> -                                          TTM_BO_VM_NUM_PREFAULT);
>>>>> +                                          TTM_BO_VM_NUM_PREFAULT,
>>>> true);
>>>>>               drm_dev_exit(idx);
>>>>>       } else {
>>>>>               ret = ttm_bo_vm_dummy_page(vmf, vmf->vma-
>>>>> vm_page_prot); diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c
>>>>> b/drivers/gpu/drm/nouveau/nouveau_gem.c
>>>>> index 49c2bcbef129..7e1453762ec9 100644
>>>>> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
>>>>> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
>>>>> @@ -56,7 +56,7 @@ static vm_fault_t nouveau_ttm_fault(struct
>>>>> vm_fault
>>>>> *vmf)
>>>>>
>>>>>       nouveau_bo_del_io_reserve_lru(bo);
>>>>>       prot = vm_get_page_prot(vma->vm_flags);
>>>>> -   ret = ttm_bo_vm_fault_reserved(vmf, prot,
>>>> TTM_BO_VM_NUM_PREFAULT);
>>>>> +   ret = ttm_bo_vm_fault_reserved(vmf, prot,
>>>> TTM_BO_VM_NUM_PREFAULT,
>>>>> +true);
>>>>>       nouveau_bo_add_io_reserve_lru(bo);
>>>>>       if (ret == VM_FAULT_RETRY && !(vmf->flags &
>>>> FAULT_FLAG_RETRY_NOWAIT))
>>>>>               return ret;
>>>>> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c
>>>>> b/drivers/gpu/drm/radeon/radeon_gem.c
>>>>> index 3fec3acdaf28..b21cf00ae162 100644
>>>>> --- a/drivers/gpu/drm/radeon/radeon_gem.c
>>>>> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
>>>>> @@ -62,7 +62,7 @@ static vm_fault_t radeon_gem_fault(struct vm_fault
>>>> *vmf)
>>>>>               goto unlock_resv;
>>>>>
>>>>>       ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
>>>>> -                                  TTM_BO_VM_NUM_PREFAULT);
>>>>> +                                  TTM_BO_VM_NUM_PREFAULT, true);
>>>>>       if (ret == VM_FAULT_RETRY && !(vmf->flags &
>>>> FAULT_FLAG_RETRY_NOWAIT))
>>>>>               goto unlock_mclk;
>>>>>
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>>>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c index
>>>> 4212b8c91dd4..7d14a7d267aa
>>>>> 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>>>> @@ -167,6 +167,7 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
>>>>>      * @num_prefault: Maximum number of prefault pages. The caller
>>>>> may
>>>> want to
>>>>>      * specify this based on madvice settings and the size of the GPU object
>>>>>      * backed by the memory.
>>>>> + * @mkwrite: make the pfn or page writable
>>>>>      *
>>>>>      * This function inserts one or more page table entries pointing to the
>>>>>      * memory backing the buffer object, and then returns a return
>>>>> code @@ -180,7 +181,8 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
>>>>>      */
>>>>>     vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>>>>>                                   pgprot_t prot,
>>>>> -                               pgoff_t num_prefault)
>>>>> +                               pgoff_t num_prefault,
>>>>> +                               bool mkwrite)
>>>>>     {
>>>>>       struct vm_area_struct *vma = vmf->vma;
>>>>>       struct ttm_buffer_object *bo = vma->vm_private_data; @@ -263,7
>>>>> +265,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>>>>>                * at arbitrary times while the data is mmap'ed.
>>>>>                * See vmf_insert_pfn_prot() for a discussion.
>>>>>                */
>>>>> -           ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>>>>> +           ret = vmf_insert_pfn_prot(vma, address, pfn, prot,
>>>>> + mkwrite);
>>>>>
>>>>>               /* Never error on prefaulted PTEs */
>>>>>               if (unlikely((ret & VM_FAULT_ERROR))) { @@ -312,7
>>>>> +314,7
>>>> @@
>>>>> vm_fault_t ttm_bo_vm_dummy_page(struct vm_fault *vmf, pgprot_t
>> prot)
>>>>>       /* Prefault the entire VMA range right away to avoid further faults */
>>>>>       for (address = vma->vm_start; address < vma->vm_end;
>>>>>            address += PAGE_SIZE)
>>>>> -           ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>>>>> +           ret = vmf_insert_pfn_prot(vma, address, pfn, prot,
>>>>> + true);
>>>>>
>>>>>       return ret;
>>>>>     }
>>>>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
>>>>> b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
>>>>> index 74ff2812d66a..bb8e4b641681 100644
>>>>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
>>>>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
>>>>> @@ -452,12 +452,14 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault
>>>> *vmf)
>>>>>        * sure the page protection is write-enabled so we don't get
>>>>>        * a lot of unnecessary write faults.
>>>>>        */
>>>>> -   if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE)
>>>>> +   if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE)
>>>> {
>>>>>               prot = vm_get_page_prot(vma->vm_flags & ~VM_SHARED);
>>>>> -   else
>>>>> +           ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault,
>>>> false);
>>>>> +   } else {
>>>>>               prot = vm_get_page_prot(vma->vm_flags);
>>>>> +           ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault,
>>>> true);
>>>>> +   }
>>>>>
>>>>> -   ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
>>>>>       if (ret == VM_FAULT_RETRY && !(vmf->flags &
>>>> FAULT_FLAG_RETRY_NOWAIT))
>>>>>               return ret;
>>>>>
>>>>> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>>>>> index 0223a41a64b2..66e293db69ee 100644
>>>>> --- a/include/drm/ttm/ttm_bo.h
>>>>> +++ b/include/drm/ttm/ttm_bo.h
>>>>> @@ -386,7 +386,8 @@ vm_fault_t ttm_bo_vm_reserve(struct
>>>> ttm_buffer_object *bo,
>>>>>                            struct vm_fault *vmf);
>>>>>     vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>>>>>                                   pgprot_t prot,
>>>>> -                               pgoff_t num_prefault);
>>>>> +                               pgoff_t num_prefault,
>>>>> +                               bool mkwrite);
>>>>>     vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf);
>>>>>     void ttm_bo_vm_open(struct vm_area_struct *vma);
>>>>>     void ttm_bo_vm_close(struct vm_area_struct *vma); diff --git
>>>>> a/include/linux/mm.h b/include/linux/mm.h index
>>>>> f5a97dec5169..f8868e28ea04 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -3553,7 +3553,7 @@ int vm_map_pages_zero(struct
>> vm_area_struct
>>>> *vma, struct page **pages,
>>>>>     vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned
>>>>> long
>>>> addr,
>>>>>                       unsigned long pfn);
>>>>>     vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma,
>>>>> unsigned
>>>> long addr,
>>>>> -                   unsigned long pfn, pgprot_t pgprot);
>>>>> +                   unsigned long pfn, pgprot_t pgprot, bool
>>>>> + mkwrite);
>>>>>     vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned
>>>>> long
>>>> addr,
>>>>>                       pfn_t pfn);
>>>>>     vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
>>>>> diff --git a/mm/memory.c b/mm/memory.c index
>>>>> 7e1f4849463a..2c28f1a349ff
>>>>> 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -2195,6 +2195,7 @@ static vm_fault_t insert_pfn(struct
>>>> vm_area_struct *vma, unsigned long addr,
>>>>>      * @addr: target user address of this page
>>>>>      * @pfn: source kernel pfn
>>>>>      * @pgprot: pgprot flags for the inserted page
>>>>> + * @mkwrite: make the pfn writable
>>>>>      *
>>>>>      * This is exactly like vmf_insert_pfn(), except that it allows drivers
>>>>>      * to override pgprot on a per-page basis.
>>>>> @@ -2223,7 +2224,7 @@ static vm_fault_t insert_pfn(struct
>>>> vm_area_struct *vma, unsigned long addr,
>>>>>      * Return: vm_fault_t value.
>>>>>      */
>>>>>     vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma,
>>>>> unsigned
>>>> long addr,
>>>>> -                   unsigned long pfn, pgprot_t pgprot)
>>>>> +                   unsigned long pfn, pgprot_t pgprot, bool
>>>>> + mkwrite)
>>>>>     {
>>>>>       /*
>>>>>        * Technically, architectures with pte_special can avoid all
>>>>> these @@ -2246,7 +2247,7 @@ vm_fault_t vmf_insert_pfn_prot(struct
>>>> vm_area_struct *vma, unsigned long addr,
>>>>>       track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
>>>>>
>>>>>       return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
>>>>> -                   false);
>>>>> +                   mkwrite);
>>>>>     }
>>>>>     EXPORT_SYMBOL(vmf_insert_pfn_prot);
>>>>>
>>>>> @@ -2273,10 +2274,17 @@ EXPORT_SYMBOL(vmf_insert_pfn_prot);
>>>>>     vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned
>>>>> long
>>>> addr,
>>>>>                       unsigned long pfn)
>>>>>     {
>>>>> -   return vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
>>>>> +   return vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot,
>>>>> +false);
>>>>>     }
>>>>>     EXPORT_SYMBOL(vmf_insert_pfn);
>>>>>
>>>>> +vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma,
>>>>> +unsigned
>>>> long addr,
>>>>> +                   unsigned long pfn) {
>>>>> +   return vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot,
>>>> true);
>>>>> +} EXPORT_SYMBOL(vmf_insert_pfn_mkwrite);
>>>>> +
>>>>>     static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
>>>>>     {
>>>>>       /* these checks mirror the abort conditions in vm_normal_page
>>>>> */


