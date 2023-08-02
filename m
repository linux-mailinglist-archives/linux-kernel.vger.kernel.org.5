Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730F176C2ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjHBCcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHBCcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08000213F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690943518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcqUrB73EGo+CGDSoBboVKT2TpZHWRlR4nKAEmHOjEw=;
        b=YITBg9VsmJ+rxNhIaIKDk8hLD7nCvx2So2SJMjTd2MrwKnaoCrR865LA9zVWu4I0goD/KS
        X9fJodubcff9ZNan3gHsYFth2p7VK0xceiylzWXe5yvpJQZgZ+f0V0p5W/upVqQuBRcbG8
        LCrjxcvCLS4a/hc2gy3tv+WUQXSOTyg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-wImidQCQOdWQn4EOb3XJpw-1; Tue, 01 Aug 2023 22:31:56 -0400
X-MC-Unique: wImidQCQOdWQn4EOb3XJpw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9cde8a457so43406331fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 19:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690943515; x=1691548315;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcqUrB73EGo+CGDSoBboVKT2TpZHWRlR4nKAEmHOjEw=;
        b=LBO9bsKfS5MHNl2NfOCkhLzMmlsZ7v8+Z5DM64THvaDBAK6AmakEUSY4h7o8V+0QtJ
         fP5lHDTRkpFNPJPS13eViELTcZ0JiO0e1upjuDPYcGmYVBk9a3MgepHntUtnw0/GhyES
         SMDKBGntVKOxD6qaMWE7xs9R4C1pEFw0oKiOVCKslhg9UKH84zSNJTeaGxhGUHa8DDZx
         EgCrcATTT8Qel/pmvf1Ov/0csFVlv1QoK9BsJPYyVzKrHg5/sHh3tE+3tE61h/eijIS0
         SBl5me6+CWqA5b6FfxMUvXtrQYo7B7Pnv4JkjwaGsei5x2GAWcnKrkSnFvTJf1PslFBK
         x0Ng==
X-Gm-Message-State: ABy/qLai8yK6ulgM6Dh4OI1wshNFu2S7RCelN5S2OzF4ADbAXcHK44aq
        REBzWXTeoBks/+pjc355Q9St+42SfOEtpqSVlEaIpDP6tK0R6O1Mc4QJae6OCagkeyBg45Z91T1
        lGhBoGLgMXGv2w1qVyDrzAWhx
X-Received: by 2002:a2e:889a:0:b0:2b9:df53:4c2a with SMTP id k26-20020a2e889a000000b002b9df534c2amr4161928lji.20.1690943515290;
        Tue, 01 Aug 2023 19:31:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFY6dxSp77KdBBhmMIfOGBR5VhOzJJ7uo4VtKoY6OdtNI5qlUW7S4XBRnOLnNvz9hN5D2dGGg==
X-Received: by 2002:a2e:889a:0:b0:2b9:df53:4c2a with SMTP id k26-20020a2e889a000000b002b9df534c2amr4161915lji.20.1690943514952;
        Tue, 01 Aug 2023 19:31:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906139500b00992dcae806bsm8438774ejc.5.2023.08.01.19.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 19:31:54 -0700 (PDT)
Message-ID: <156f9560-b219-7459-d06a-5a8fe07f24cf@redhat.com>
Date:   Wed, 2 Aug 2023 04:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v14 02/12] drm/shmem-helper: Add pages_pin_count field
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
 <20230722234746.205949-3-dmitry.osipenko@collabora.com>
 <20230725092709.51356f39@collabora.com>
 <20230725103234.0c8923f1@collabora.com>
 <4c5fa735-9bfd-f92a-8deb-888c7368f89e@collabora.com>
 <20230731153551.7365daa4@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230731153551.7365daa4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 15:35, Boris Brezillon wrote:
> +Danilo, to confirm my understanding of the gpuva remap operation is
> correct.

Your understanding is correct.

Unfortunately, re-mapping things has such implications.

I'm currently working on tracking external GEM objects in the GPUVA 
manager, where, ideally, you'd want to add the extobj to the VM when the 
first mapping being backed by this GEM is created and removed when the 
last mapping being backed by this GEM is removed. Hence, extobjs need to 
be ref-counted based on how many mappings they back.

However, when re-mapping such a mapping, the reference counter might 
drop to 0 temporarily and the slot of the data structure tracking the 
extobj is cleaned up and needs to be re-allocated. Surely, we could just 
increase the reference count while re-mapping or for the whole 
transaction (job), but this would make the API kinda bulky.

> 
> On Mon, 31 Jul 2023 15:27:31 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> On 7/25/23 11:32, Boris Brezillon wrote:
>>>> Can we make it an atomic_t, so we can avoid taking the lock when the
>>>> GEM has already been pinned. That's something I need to be able to grab
>>>> a pin-ref in a path where the GEM resv lock is already held[1]. We could
>>>> of course expose the locked version,
>>> My bad, that's actually not true. The problem is not that I call
>>> drm_gem_shmem_pin() with the resv lock already held, but that I call
>>> drm_gem_shmem_pin() in a dma-signaling path where I'm not allowed to
>>> take a resv lock. I know for sure pin_count > 0, because all GEM objects
>>> mapped to a VM have their memory pinned right now, and this should
>>> stand until we decide to add support for live-GEM eviction, at which
>>> point we'll probably have a way to detect when a GEM is evicted, and
>>> avoid calling drm_gem_shmem_pin() on it.
>>>
>>> TLDR; I can't trade the atomic_t for a drm_gem_shmem_pin_locked(),
>>> because that wouldn't solve my problem. The other solution would be to
>>> add an atomic_t at the driver-GEM level, and only call
>>> drm_gem_shmem_[un]pin() on 0 <-> 1 transitions, but I thought using an
>>> atomic at the GEM-shmem level, to avoid locking when we can, would be
>>> beneficial to the rest of the eco-system. Let me know if that's not an
>>> option, and I'll go back to the driver-specific atomic_t.
>>
>> Could you please explain why do you need to pin GEM in a signal handler?
>> This is not something drivers usually do or need to do. You likely also
>> shouldn't need to detect that GEM is evicted in yours driver. I'd expect
>> that Panthor shouldn't differ from Panfrost in regards to how GEM memory
>> management is done and Panfrost doesn't need to do anything special.
> 
> Panthor VM management is completely different, and the case I'm
> referring to is 'asynchronous VM_BIND': mapping a GEM object to a GPU VM
> asynchronously, so we can make it depend on other operations, encoded as
> syncobjs passed to the VM_BIND operation.
> 
> Here is the workflow we have for this use case:
> 
> 1. Create + push a VM_BIND job to the VM_BIND queue (a drm_sched_entity
> that's taking care of asynchronous VM map/unmap operations). Because
> this operation is asynchronous, and the execution itself happens in a
> dma-signaling path (drm_sched::run_job()), we need to pre-allocate the
> MMU page tables for the worst case scenario, and make sure the GEM pages
> are pinned at job creation time.
> 
> 2. The VM operation itself is executed when all dependencies are met
> (drm_sched calls run_job()). In case of a map operation, we call
> drm_gpuva_sm_map(), which might split the map operation into
> remap+unamp+map ones if the region being mapped is covering a region
> that was previously mapped to a different GEM object or a different
> portion of the same GEM object (see the gpuva_mgr doc [1]). A
> remap operation is just a way to split an existing mapping in 2 mappings
> covering the left/right side of the previous mapping, plus a hole in
> the middle. This means that our VM mapping object (drm_gpuva), which
> was pointing to a GEM object that had its pages pinned, is now turned
> into 2 mapping objects, and we need to make sure those 2 mappings own a
> reference to the pages, otherwise we'll have an unbalanced refcount
> when we release those 2 mappings further down the road.
> 
> 3. Release resources attached to mappings that were removed (that
> includes releasing the ref we had on GEM pages) and free the mapping
> objects. We do that asynchronously, outside of the dma-signaling path.
> 
>>
>> Note that patch #14 makes locked pin/unpin functions public and turns
>> the unlocked variants into helpers, you'll be able to experiment with
>> these funcs in the Panthor driver.
> 
> Unfortunately, those won't help. I really need a way to increment the
> refcount without holding the lock, because we're in a dma-signaling
> path when we call drm_gpuva_sm_map(). Note that I could live with a
> drm_shmem_gem_pin_if_already_pinned() variant that would return NULL if
> pin_count == 0 instead of trying to acquire the lock, but I'd still
> need this refcount to be an atomic_t.
> 
> As I said, an alternative to this approach would be to have a separate
> atomic refcount at the panthor_gem_object level, but I feel like we'd
> just be duplicating something that exists already.
> 
> [1]https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/drm_gpuva_mgr.c#n67
> 

