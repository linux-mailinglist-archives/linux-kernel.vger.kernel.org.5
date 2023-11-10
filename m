Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351037E80DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbjKJSTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbjKJSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764F242308
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699635432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eidH9VhysXxXOjL2K7PZ7XLnXajkR8QsCCnv8XsasRs=;
        b=bQuQ8v0J/ngXQSecbwKFh17YsPlGbgnggCLW1YJ1nFzXNpP8O8MzgaMrSezAnwvD4DGK21
        B6JUgUXkCpWSuiQNWp+kZbkMCNHNIhj9H9NxWWLN0QMVzvhitaE5P2npiVFKn0Yg7HDdBD
        OBUQqOpNQO31qIvk3auHie/+86zqem4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-VyfBnF6kPWSddtG1cPU1Cg-1; Fri, 10 Nov 2023 11:57:09 -0500
X-MC-Unique: VyfBnF6kPWSddtG1cPU1Cg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c8321310b6so7614631fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635428; x=1700240228;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eidH9VhysXxXOjL2K7PZ7XLnXajkR8QsCCnv8XsasRs=;
        b=AGtvvE90FGD2eGlGcoSJv/AeQhroYrPlyY88Fb+SGm9U5R7kfxTT50PVBv4N4Ln1+z
         X1wUZOHRX2W+gIE9SqEKQOOU78DkQYZlDneA7QF7fYARVwEJNxwozyuyJWnkUQfGnTAv
         iibBDNZYFQ7mtcZ+ZRboiIjd50t8Hgu3PkTY3XjFJhFVU6My+8iHg92fQn+rjZmVKi4s
         yuvp3AkHHTUzviFhGJqsD6ndoZM95hCSXZ3exopU0YBSTkkYui+pim72MJxd0EzS1j23
         mx0inqLhVBbRc4co2VletwDNZqh3ZADuK/Zo2k+RgBanVpqFqBCW8oW7vwwe2hfUMzy9
         q8tA==
X-Gm-Message-State: AOJu0YxYXpqCALREcIuXrM0evn5fejXFkFVsSe0btb6ytAm4qZltZ0KK
        4WiYL5bp+anRvuv/h1kY0Y77k0WzD/ANLGZLjG7jfqSoHqkyngwJEdf5Ky/2+U8UkWBFUcoSt9A
        fqYIfFV56qU81VMPUQu4h9WEF
X-Received: by 2002:a05:651c:222:b0:2c6:f173:7d90 with SMTP id z2-20020a05651c022200b002c6f1737d90mr7732731ljn.12.1699635427705;
        Fri, 10 Nov 2023 08:57:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyrdH0+LrM5PreEp7tQxlkcT5aqvmj57o3zbMLeMYRB2XWK4I69R2ZHSV/6VMU42JDaix4kw==
X-Received: by 2002:a05:651c:222:b0:2c6:f173:7d90 with SMTP id z2-20020a05651c022200b002c6f1737d90mr7732720ljn.12.1699635427265;
        Fri, 10 Nov 2023 08:57:07 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c320900b00407b93d8085sm5570467wmp.27.2023.11.10.08.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 08:57:06 -0800 (PST)
Message-ID: <987ac707-8f9b-4e33-86c3-decdc1c48a3a@redhat.com>
Date:   Fri, 10 Nov 2023 17:57:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v8 09/12] drm/gpuvm: reference count
 drm_gpuvm structures
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        sarah.walker@imgtec.com, donald.robson@imgtec.com,
        boris.brezillon@collabora.com, faith@gfxstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231101233113.8059-10-dakr@redhat.com>
 <be93d9ef-3d3e-4262-a280-d2922b983ca1@amd.com> <ZUTyGTxcH7WlHKsv@pollux>
 <a2e13a27-d2e5-4ae3-9c11-c18b425b69cc@amd.com>
 <b533af44-0404-49c9-9879-3414d0964acc@redhat.com>
 <51dea5f3-a18b-4797-b4fa-87da7db4624a@amd.com> <ZUjZFFtLM435tTxJ@pollux>
 <8e87d962-c80c-40d9-94d7-58b6cd9dd794@amd.com> <ZUj0DdYZUgjhcvf5@pollux>
 <6d3c48f6-a92d-49b3-b836-ee1bc95b56bf@amd.com> <ZUkXkJ+zT7OFGosC@pollux>
 <44bc28c7-05f4-4419-5183-453c4951aac0@linux.intel.com>
 <6c536c94-7072-403c-9c63-d932252fd66b@amd.com>
 <4532d9d5-4c5a-4639-8136-d3ba9995d7b6@redhat.com>
 <1d4ca394-ee0c-4617-adbe-1d47e295c8fb@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <1d4ca394-ee0c-4617-adbe-1d47e295c8fb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 09:50, Christian König wrote:
> Am 09.11.23 um 19:34 schrieb Danilo Krummrich:
>> On 11/9/23 17:03, Christian König wrote:
>>> Am 09.11.23 um 16:50 schrieb Thomas Hellström:
>>>> [SNIP]
>>>>>>
>>>> Did we get any resolution on this?
>>>>
>>>> FWIW, my take on this is that it would be possible to get GPUVM to work both with and without internal refcounting; If with, the driver needs a vm close to resolve cyclic references, if without that's not necessary. If GPUVM is allowed to refcount in mappings and vm_bos, that comes with a slight performance drop but as Danilo pointed out, the VM lifetime problem iterating over a vm_bo's mapping becomes much easier and the code thus becomes easier to maintain moving forward. That convinced me it's a good thing.
>>>
>>> I strongly believe you guys stumbled over one of the core problems with the VM here and I think that reference counting is the right answer to solving this.
>>>
>>> The big question is that what is reference counted and in which direction does the dependency points, e.g. we have here VM, BO, BO_VM and Mapping objects.
>>>
>>> Those patches here suggest a counted Mapping -> VM reference and I'm pretty sure that this isn't a good idea. What we should rather really have is a BO -> VM or BO_VM ->VM reference. In other words that each BO which is part of the VM keeps a reference to the VM.
>>
>> We have both. Please see the subsequent patch introducing VM_BO structures for that.
>>
>> As I explained, mappings (struct drm_gpuva) keep a pointer to their VM they're mapped
>> in and besides that it doesn't make sense to free a VM that still contains mappings,
>> the reference count ensures that. This simply ensures memory safety.
>>
>>>
>>> BTW: At least in amdgpu we can have BOs which (temporary) doesn't have any mappings, but are still considered part of the VM.
>>
>> That should be possible.
>>
>>>
>>>>
>>>> Another issue Christian brought up is that something intended to be embeddable (a base class) shouldn't really have its own refcount. I think that's a valid point. If you at some point need to derive from multiple such structs each having its own refcount, things will start to get weird. One way to resolve that would be to have the driver's subclass provide get() and put() ops, and export a destructor for the base-class, rather than to have the base-class provide the refcount and a destructor  ops.
>>
>> GPUVM simply follows the same pattern we have with drm_gem_objects. And I think it makes
>> sense. Why would we want to embed two struct drm_gpuvm in a single driver structure?
> 
> Because you need one drm_gpuvm structure for each application using the driver? Or am I missing something?

Right, *one*, but not more than one. Wasn't that the concern? Maybe I misunderstood something. :)

> 
> As far as I can see a driver would want to embed that into your fpriv structure which is allocated during drm_driver.open callback.
> 
>>
>>>
>>> Well, I have never seen stuff like that in the kernel. Might be that this works, but I would rather not try if avoidable.
>>>
>>>>
>>>> That would also make it possible for the driver to decide the context for the put() call: If the driver needs to be able to call put() from irq / atomic context but the base-class'es destructor doesn't allow atomic context, the driver can push freeing out to a work item if needed.
>>>>
>>>> Finally, the refcount overflow Christian pointed out. Limiting the number of mapping sounds like a reasonable remedy to me.
>>>
>>> Well that depends, I would rather avoid having a dependency for mappings.
>>>
>>> Taking the CPU VM handling as example as far as I know vm_area_structs doesn't grab a reference to their mm_struct either. Instead they get automatically destroyed when the mm_struct is destroyed.
>>
>> Certainly, that would be possible. However, thinking about it, this might call for
>> huge trouble.
>>
>> First of all, we'd still need to reference count a GPUVM and take a reference for each
>> VM_BO, as we do already. Now instead of simply increasing the reference count for each
>> mapping as well, we'd need a *mandatory* driver callback that is called when the GPUVM
>> reference count drops to zero. Maybe something like vm_destroy().
>>
>> The reason is that GPUVM can't just remove all mappings from the tree nor can it free them
>> by itself, since drivers might use them for tracking their allocated page tables and/or
>> other stuff.
>>
>> Now, let's think about the scope this callback might be called from. When a VM_BO is destroyed
>> the driver might hold a couple of locks (for Xe it would be the VM's shared dma-resv lock and
>> potentially the corresponding object's dma-resv lock if they're not the same already). If
>> destroying this VM_BO leads to the VM being destroyed, the drivers vm_destroy() callback would
>> be called with those locks being held as well.
>>
>> I feel like doing this finally opens the doors of the locking hell entirely. I think we should
>> really avoid that.
> 
> That's a really good point, but I fear exactly that's the use case.
> 
> I would expect that VM_BO structures are added in the drm_gem_object_funcs.open callback and freed in drm_gem_object_funcs.close.
> 
> Since it is perfectly legal for userspace to close a BO while there are still mappings (can trivial be that the app is killed) I would expect that the drm_gem_object_funcs.close handling is something like asking drm_gpuvm destroying the VM_BO and getting the mappings which should be cleared in the page table in return.

Yes, you can do that. You can ask GPUVM to create a set of operations for you to shut down all
mappings of a given VM_BO. But until this is done the VM_BO structure is kept alive. Semantically,
it's exactly the same though.

> 
> In amdgpu we even go a step further and the VM structure keeps track of all the mappings of deleted VM_BOs so that higher level can query those and clear them later on.
> 
> Background is that the drm_gem_object_funcs.close can't fail, but it can perfectly be that the app is killed because of an OOM situation and we can't do page tables updates in that moment because of this.
> 
>>
>>>
>>> Which makes sense in that case because when the mm_struct is gone the vm_area_struct doesn't make sense any more either.
>>>
>>> What we clearly need is a reference to prevent the VM or at least the shared resv to go away to early.
>>
>> Yeah, that was a good hint and we've covered that.
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> But I think all of this is fixable as follow-ups if needed, unless I'm missing something crucial.
>>
>> Fully agree, I think at this point we should go ahead and land this series.
> 
> Yeah, agree this is not UAPI so not nailed in stone. Feel free to add my acked-by as well if you want.
> 
> Only keep in mind that when you give drivers some functionality in a common component they usually expect to keep that functionality.
> 
> For example changing the dma_resv object to make sure that drivers can't cause use after free errors any more was an extremely annoying experience since every user of those interface had to change at once.
> 
> Regards,
> Christian.
> 
>>
>>>>
>>>> Just my 2 cents.
>>>>
>>>> /Thomas
>>>>
>>>>
>>>
>>
> 

