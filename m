Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF37B8114
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbjJDNgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242477AbjJDNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F3CAB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696426522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORQDcr70YGNo+ZQcxSesakbtmJulbXWtki8WFW4pJD0=;
        b=R9MgnLh7Q3veznUbF6Mv2rULd3K7bF4u0DnB4PL/+7SseMos+zinjRx7yEV+J3cM41/6xt
        jWZJNXTLenTHj9E2/hWaMQed4V3Blz0Mvfms24KzyDcIfgU+RhAiNNGQVh2XEE3g3Ow+AK
        t9iXpyvIWsn8onTFdwGSmvHs7jzv3vs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-9cHJFWbzOTWHpx6yx7h9tQ-1; Wed, 04 Oct 2023 09:35:10 -0400
X-MC-Unique: 9cHJFWbzOTWHpx6yx7h9tQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b95fa56bd5so15337566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 06:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696426510; x=1697031310;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORQDcr70YGNo+ZQcxSesakbtmJulbXWtki8WFW4pJD0=;
        b=BemjVLylzNTkXEcfPKMIkeykf940bz8GlWKDB7CSQdHSjhmgH/T5RCnOlhphFf14QQ
         YdLLITAiit7n173UvxTh2cczCizTFeLg6imIlgDtj2rM+yqPREPCmm73JwMCNJDO39IT
         Vkx97Iq8q3mS87rih5B5mDsC56ZPLBAiinLv0foXr6V4zRLwiJ8d32GThjTufCbqO5ld
         M7E+BBdo12fbZp/EX4MXDZe8RAEWiV1sjtXdeRUuPjNibUbyggplvXtUJuB3TSUZKk1Y
         42eQJhbCrnXf65voh/VqTBZastYbLlgkdGu2hfgsmL4evuZ9TF3gehzmNtILIwBJlXzG
         PmPg==
X-Gm-Message-State: AOJu0YxyYjoDH/E5G3rVlVJh4HXNnOY+RnKFhz9JmTVbaFIgpcfTj8Yz
        1bxoYccHohNK2a+olpngV+dQ6oq9PP23gOei70tF6SdW68vzCsph52YTT9YkAOFDL8a2knCBd8c
        FT16/sTltc0WUvqiBvg2MZWxn
X-Received: by 2002:a17:906:5188:b0:9a5:c9a4:ba1b with SMTP id y8-20020a170906518800b009a5c9a4ba1bmr2481592ejk.8.1696426509635;
        Wed, 04 Oct 2023 06:35:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOXBMF56DjhgkeBjB0zpiCqMDV1wGsez80FaOzIRmVjuZ7EFQd+BxHQ704QiClL4DJ2V0Sdw==
X-Received: by 2002:a17:906:5188:b0:9a5:c9a4:ba1b with SMTP id y8-20020a170906518800b009a5c9a4ba1bmr2481561ejk.8.1696426509135;
        Wed, 04 Oct 2023 06:35:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l5-20020a1709061c4500b0099ce025f8ccsm2811629ejg.186.2023.10.04.06.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:35:08 -0700 (PDT)
Message-ID: <05d4115c-3329-1044-6066-f7020695c4ca@redhat.com>
Date:   Wed, 4 Oct 2023 15:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v5 4/6] drm/gpuvm: track/lock/validate
 external/evicted objects
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     matthew.brost@intel.com, sarah.walker@imgtec.com,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, faith@gfxstrand.net,
        donald.robson@imgtec.com, christian.koenig@amd.com
References: <20230928191624.13703-1-dakr@redhat.com>
 <20230928191624.13703-5-dakr@redhat.com>
 <e4e68970-c7c9-55e2-9483-01252f38c956@linux.intel.com>
 <20231003120554.547090bc@collabora.com>
 <f551ee9059e52d46343f5fa997b7d9f8ab6654d9.camel@linux.intel.com>
 <20231003162143.490e3ef0@collabora.com> <ZRxHcwYUbp5/fS+v@pollux>
 <02ed9fce1f9e37c7f9f3a16943871b5bfe491c8a.camel@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <02ed9fce1f9e37c7f9f3a16943871b5bfe491c8a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 19:37, Thomas Hellström wrote:
> Hi, Danilo
> 
> On Tue, 2023-10-03 at 18:55 +0200, Danilo Krummrich wrote:
>> It seems like we're mostly aligned on this series, except for the key
>> controversy we're discussing for a few versions now: locking of the
>> internal
>> lists. Hence, let's just re-iterate the options we have to get this
>> out of the
>> way.
>>
>> (1) The spinlock dance. This basically works for every use case,
>> updating the VA
>>      space from the IOCTL, from the fence signaling path or anywhere
>> else.
>>      However, it has the downside of requiring spin_lock() /
>> spin_unlock() for
>>      *each* list element when locking all external objects and
>> validating all
>>      evicted objects. Typically, the amount of extobjs and evicted
>> objects
>>      shouldn't be excessive, but there might be exceptions, e.g. Xe.
>>
>> (2) The dma-resv lock dance. This is convinient for drivers updating
>> the VA
>>      space from a VM_BIND ioctl() and is especially efficient if such
>> drivers
>>      have a huge amount of external and/or evicted objects to manage.
>> However,
>>      the downsides are that it requires a few tricks in drivers
>> updating the VA
>>      space from the fence signaling path (e.g. job_run()). Design
>> wise, I'm still
>>      skeptical that it is a good idea to protect internal data
>> structures with
>>      external locks in a way that it's not clear to callers that a
>> certain
>>      function would access one of those resources and hence needs
>> protection.
>>      E.g. it is counter intuitive that drm_gpuvm_bo_put() would
>> require both the
>>      dma-resv lock of the corresponding object and the VM's dma-resv
>> lock held.
>>      (Additionally, there were some concerns from amdgpu regarding
>> flexibility in
>>      terms of using GPUVM for non-VM_BIND uAPIs and compute, however,
>> AFAICS
>>      those discussions did not complete and to me it's still unclear
>> why it
>>      wouldn't work.)
>>
>> (3) Simply use an internal mutex per list. This adds a tiny (IMHO
>> negligible)
>>      overhead for drivers updating the VA space from a VM_BIND
>> ioctl(), namely
>>      a *single* mutex_lock()/mutex_unlock() when locking all external
>> objects
>>      and validating all evicted objects. And it still requires some
>> tricks for
>>      drivers updating the VA space from the fence signaling path.
>> However, it's
>>      as simple as it can be and hence way less error prone as well as
>>      self-contained and hence easy to use. Additionally, it's flexible
>> in a way
>>      that we don't have any expections on drivers to already hold
>> certain locks
>>      that the driver in some situation might not be able to acquire in
>> the first
>>      place.
> 
> Such an overhead is fully OK IMO, But didn't we conclude at some point
> that using a mutex in this way isn't possible due to the fact that
> validate() needs to be able to lock dma_resv, and then we have
> dma_resv()->mutex->dma_resv()?

Oh, yes. I already forgot about it. I think it would work for protecting the
evicted list. But it breaks with the external object list, because we'd hold
the mutex while acquiring the dma-resv locks. Hence, there'd be a potential
lock inversion when drm_gpuvm_bo_put() is called with the corrsponding
dma-resv lock held. Then this option is indeed gone as well, unfortunately.

> 
> 
>>
>> (4) Arbitrary combinations of the above. For instance, the current V5
>> implements
>>      both (1) and (2) (as either one or the other). But also (1) and
>> (3) (as in
>>      (1) additionally to (3)) would be an option, where a driver could
>> opt-in for
>>      the spinlock dance in case it updates the VA space from the fence
>> signaling
>>      path.
>>
>> I also considered a few other options as well, however, they don't
>> seem to be
>> flexible enough. For instance, as by now we could use SRCU for the
>> external
>> object list. However, this falls apart once a driver wants to remove
>> and re-add
>> extobjs for the same VM_BO instance. (For the same reason it wouldn't
>> work for
>> evicted objects.)
>>
>> Personally, after seeing the weird implications of (1), (2) and a
>> combination of
>> both, I tend to go with (3). Optionally, with an opt-in for (1). The
>> reason for
>> the latter is that with (3) the weirdness of (1) by its own mostly
>> disappears.
>>
>> Please let me know what you think, and, of course, other ideas than
>> the
>> mentioned ones above are still welcome.
> 
> Personally, after converting xe to version 5, I think it's pretty
> convenient for the driver, (although had to add the evict trick), so I

With evict trick you mean a field drm_gpuvm_bo::evicted? I think we don't
need it necessarily (see my previous reply). But I agree it'd be a bit
cleaner locking wise.

My only concern with that is that it would restrict the context in which
the evict list is useful, because it implies that in order to even see the
actual state of the evict list all external objects must be locked first.

What if a driver wants to only lock and validate only a certain range of
the VA space? Surely, it can just call validate() for each drm_gpuva's BO,
but depending on the size of the range we might still want to accelerate
it using the evicted list.

Honestly, I don't know if there are drivers having this need, but Christians
concerns about this way of updating the evict list seemed to go in this
direction.

> think I'd vote for this, even if not currently using the opt-in for
> (1).

Yeah, also due to the lack of other options, I think we need to stick with
what V5 already does. Either with or without drm_gpuvm_bo::evicted field.

Keeping the dma-resv locking scheme, I think we'd want some helpers around
drm_gpuvm_bo_put() for the drm_exec dance that is required for external
objects. Maybe add a drm_gpuvm_bo_put_locked() which can be called with the
dma-resv locks held and let drm_gpuvm_bo_put() do the drm_exec dance?

> 
> /Thomas
> 
> 
>>
>> - Danilo
>>
>> On Tue, Oct 03, 2023 at 04:21:43PM +0200, Boris Brezillon wrote:
>>> On Tue, 03 Oct 2023 14:25:56 +0200
>>> Thomas Hellström <thomas.hellstrom@linux.intel.com> wrote:
>>>
>>>>>>> +/**
>>>>>>> + * get_next_vm_bo_from_list() - get the next vm_bo element
>>>>>>> + * @__gpuvm: The GPU VM
>>>>>>> + * @__list_name: The name of the list we're iterating on
>>>>>>> + * @__local_list: A pointer to the local list used to
>>>>>>> store
>>>>>>> already iterated items
>>>>>>> + * @__prev_vm_bo: The previous element we got from
>>>>>>> drm_gpuvm_get_next_cached_vm_bo()
>>>>>>> + *
>>>>>>> + * This helper is here to provide lockless list iteration.
>>>>>>> Lockless as in, the
>>>>>>> + * iterator releases the lock immediately after picking
>>>>>>> the
>>>>>>> first element from
>>>>>>> + * the list, so list insertion deletion can happen
>>>>>>> concurrently.
>>>>>>> + *
>>>>>>> + * Elements popped from the original list are kept in a
>>>>>>> local
>>>>>>> list, so removal
>>>>>>> + * and is_empty checks can still happen while we're
>>>>>>> iterating
>>>>>>> the list.
>>>>>>> + */
>>>>>>> +#define get_next_vm_bo_from_list(__gpuvm, __list_name,
>>>>>>> __local_list, __prev_vm_bo)     \
>>>>>>> +       ({
>>>>>>>        
>>>>>>>                         \
>>>>>>> +               struct drm_gpuvm_bo *__vm_bo =
>>>>>>> NULL;                                    \
>>>>>>> +
>>>>>>>        
>>>>>>>                         \
>>>>>>> +               drm_gpuvm_bo_put(__prev_vm_bo);
>>>>>>>        
>>>>>>>                         \
>>>>>>> +
>>>>>>>        
>>>>>>>                         \
>>>>>>> +               spin_lock(&(__gpuvm)-
>>>>>>>> __list_name.lock);                                \
>>>>>>
>>>>>> Here we unconditionally take the spinlocks while iterating,
>>>>>> and the
>>>>>> main
>>>>>> point of DRM_GPUVM_RESV_PROTECTED was really to avoid that?
>>>>>>
>>>>>>    
>>>>>>> +               if (!(__gpuvm)-
>>>>>>>> __list_name.local_list)                                 \
>>>>>>>>    
>>>>>>> +                       (__gpuvm)->__list_name.local_list =
>>>>>>> __local_list;               \
>>>>>>> +               else
>>>>>>>        
>>>>>>>                         \
>>>>>>> +                       WARN_ON((__gpuvm)-
>>>>>>>> __list_name.local_list
>>>>>>> != __local_list);     \
>>>>>>> +
>>>>>>>        
>>>>>>>                         \
>>>>>>> +               while (!list_empty(&(__gpuvm)-
>>>>>>>> __list_name.list))
>>>>>>> {                     \
>>>>>>> +                       __vm_bo =
>>>>>>> list_first_entry(&(__gpuvm)-
>>>>>>>> __list_name.list,        \
>>>>>>> +                                                  struct
>>>>>>> drm_gpuvm_bo,                 \
>>>>>>> +
>>>>>>> list.entry.__list_name);             \
>>>>>>> +                       if (kref_get_unless_zero(&__vm_bo-
>>>>>>>> kref))
>>>>>>> {
>>>>>> And unnecessarily grab a reference in the RESV_PROTECTED
>>>>>> case.
>>>>>>>                          \
>>>>>>> +                               list_move_tail(&(__vm_bo)-
>>>>>>>> list.entry.__list_name,      \
>>>>>>> +
>>>>>>> __local_list);                           \
>>>>>>> +                               break;
>>>>>>>        
>>>>>>>                         \
>>>>>>> +                       } else
>>>>>>> {                                                        \
>>>>>>> +                               list_del_init(&(__vm_bo)-
>>>>>>>> list.entry.__list_name);      \
>>>>>>> +                               __vm_bo =
>>>>>>> NULL;                                         \
>>>>>>> +                       }
>>>>>>>        
>>>>>>>                         \
>>>>>>> +               }
>>>>>>>        
>>>>>>>                         \
>>>>>>> +               spin_unlock(&(__gpuvm)-
>>>>>>>> __list_name.lock);                              \
>>>>>>> +
>>>>>>>        
>>>>>>>                         \
>>>>>>> +               __vm_bo;
>>>>>>>        
>>>>>>>                         \
>>>>>>> +       })
>>>>>>
>>>>>> IMHO this lockless list iteration looks very complex and
>>>>>> should be
>>>>>> pretty difficult to maintain while moving forward, also since
>>>>>> it
>>>>>> pulls
>>>>>> the gpuvm_bos off the list, list iteration needs to be
>>>>>> protected by
>>>>>> an
>>>>>> outer lock anyway.
>>>>>
>>>>> As being partly responsible for this convoluted list iterator,
>>>>> I must
>>>>> say I agree with you. There's so many ways this can go wrong if
>>>>> the
>>>>> user doesn't call it the right way, or doesn't protect
>>>>> concurrent
>>>>> list
>>>>> iterations with a separate lock (luckily, this is a private
>>>>> iterator). I
>>>>> mean, it works, so there's certainly a way to get it right, but
>>>>> gosh,
>>>>> this is so far from the simple API I had hoped for.
>>>>>    
>>>>>> Also from what I understand from Boris, the extobj
>>>>>> list would typically not need the fine-grained locking; only
>>>>>> the
>>>>>> evict
>>>>>> list?
>>>>>
>>>>> Right, I'm adding the gpuvm_bo to extobj list in the ioctl
>>>>> path, when
>>>>> the GEM and VM resvs are held, and I'm deferring the
>>>>> drm_gpuvm_bo_put()
>>>>> call to a work that's not in the dma-signalling path. This
>>>>> being
>>>>> said,
>>>>> I'm still not comfortable with the
>>>>>
>>>>> gem = drm_gem_object_get(vm_bo->gem);
>>>>> dma_resv_lock(gem->resv);
>>>>> drm_gpuvm_bo_put(vm_bo);
>>>>> dma_resv_unlock(gem->resv);
>>>>> drm_gem_object_put(gem);
>>>>>
>>>>> dance that's needed to avoid a UAF when the gpuvm_bo is the
>>>>> last GEM
>>>>> owner, not to mention that drm_gpuva_unlink() calls
>>>>> drm_gpuvm_bo_put()
>>>>> after making sure the GEM gpuvm_list lock is held, but this
>>>>> lock
>>>>> might
>>>>> differ from the resv lock (custom locking so we can call
>>>>> gpuvm_unlink() in the dma-signalling path). So we now have
>>>>> paths
>>>>> where
>>>>> drm_gpuvm_bo_put() are called with the resv lock held, and
>>>>> others
>>>>> where
>>>>> they are not, and that only works because we're relying on the
>>>>> the
>>>>> fact
>>>>> those drm_gpuvm_bo_put() calls won't make the refcount drop to
>>>>> zero,
>>>>> because the deferred vm_bo_put() work still owns a vm_bo ref.
>>>>
>>>> I'm not sure I follow to 100% here, but in the code snippet above
>>>> it's
>>>> pretty clear to me that it needs to hold an explicit gem object
>>>> reference when calling dma_resv_unlock(gem->resv). Each time you
>>>> copy a
>>>> referenced pointer (here from vm_bo->gem to gem) you need to up
>>>> the
>>>> refcount unless you make sure (by locks or other means) that the
>>>> source
>>>> of the copy has a strong refcount and stays alive, so that's no
>>>> weird
>>>> action to me. Could possibly add a drm_gpuvm_bo_get_gem() to
>>>> access the
>>>> gem member (and that also takes a refcount) for driver users to
>>>> avoid
>>>> the potential pitfall.
>>>
>>> Except this is only needed because of the GEM-resv-must-be-held
>>> locking
>>> constraint that was added on vm_bo_put(). I mean, the usual way we
>>> do
>>> object un-referencing is by calling _put() and letting the internal
>>> logic undo things when the refcount drops to zero. If the object
>>> needs
>>> to be removed from some list, it's normally the responsibility of
>>> the
>>> destruction method to lock the list, remove the object and unlock
>>> the
>>> list. Now, we have a refcounted object that's referenced by vm_bo,
>>> and
>>> whose lock needs to be taken when the destruction happens, which
>>> leads
>>> to this weird dance described above, when, in normal situations,
>>> we'd
>>> just call drm_gpuvm_bo_put(vm_bo) and let drm_gpuvm do its thing.
>>>
>>>>
>>>>>
>>>>> All these tiny details add to the overall complexity of this
>>>>> common
>>>>> layer, and to me, that's not any better than the
>>>>> get_next_vm_bo_from_list() complexity you were complaining
>>>>> about
>>>>> (might
>>>>> be even worth, because this sort of things leak to users).
>>>>>
>>>>> Having an internal lock partly solves that, in that the locking
>>>>> of
>>>>> the
>>>>> extobj list is now entirely orthogonal to the GEM that's being
>>>>> removed
>>>>> from this list, and we can lock/unlock internally without
>>>>> forcing the
>>>>> caller to take weird actions to make sure things don't explode.
>>>>> Don't
>>>>> get me wrong, I get that this locking overhead is not
>>>>> acceptable for
>>>>> Xe, but I feel like we're turning drm_gpuvm into a white
>>>>> elephant
>>>>> that
>>>>> only few people will get right.
>>>>
>>>> I tend to agree, but to me the big complication comes from the
>>>> async
>>>> (dma signalling path) state updates.
>>>
>>> I don't deny updating the VM state from the dma signalling path
>>> adds
>>> some amount of complexity, but the fact we're trying to use
>>> dma_resv
>>> locks for everything, including protection of internal datasets
>>> doesn't
>>> help. Anyway, I think both of us are biased when it comes to
>>> judging
>>> which approach adds the most complexity :P.
>>>
>>> Also note that, right now, the only thing I'd like to be able to
>>> update
>>> from the dma signalling path is the VM mapping tree. Everything
>>> else
>>> (drm_gpuva_[un]link(), add/remove extobj), we could do outside this
>>> path:
>>>
>>> - for MAP operations, we could call drm_gpuva_link() in the ioctl
>>> path
>>>    (we'd just need to initialize the drm_gpuva object)
>>> - for MAP operations, we're already calling drm_gpuvm_bo_obtain()
>>> from
>>>    the ioctl path
>>> - for UNMAP operations, we could add the drm_gpuva_unlink() call to
>>> the
>>>    VM op cleanup worker
>>>
>>> The only problem we'd have is that drm_gpuva_link() needs to be
>>> called
>>> inside drm_gpuvm_ops::sm_step_remap() when a remap with next/prev
>>> !=
>>> NULL occurs, otherwise we lose track of these mappings.
>>>
>>>>
>>>> Let's say for example we have a lower level lock for the gem
>>>> object's
>>>> gpuvm_bo list. Some drivers grab it from the dma fence signalling
>>>> path,
>>>> other drivers need to access all vm's of a bo to grab their
>>>> dma_resv
>>>> locks using a WW transaction. There will be problems, although
>>>> probably
>>>> solveable.
>>>
>>> To me, the gpuvm extobj vm_bo list is just an internal list and has
>>> an
>>> internal lock associated. The lock that's protecting the GEM vm_bo
>>> list
>>> is a bit different in that the driver gets to decide when a vm_bo
>>> is
>>> inserted/removed by calling drm_gpuvm_[un]link(), and can easily
>>> make
>>> sure the lock is held when this happens, while the gpuvm internal
>>> lists
>>> are kinda transparently updated (for instance, the first caller of
>>> drm_gpuvm_bo_obtain() adds the vm_bo to the extobj and the last
>>> vm_bo
>>> owner calling drm_gpuvm_bo_put() removes it from this list, which
>>> is
>>> certainly not obvious based on the name of these functions).
>>>
>>> If we want to let drivers iterate over the extobj/evict lists, and
>>> assuming they are considered internal lists maintained by the core
>>> and
>>> protected with an internal lock, we should indeed provide iteration
>>> helpers that:
>>>
>>> 1/ make sure all the necessary external locks are held (VM resv, I
>>>     guess)
>>> 2/ make sure the internal lock is not held during iteration (the
>>> sort
>>>     of snapshot list trick you're using for the evict list in Xe)
>>>
>>>>>> Also it seems that if we are to maintain two modes here, for
>>>>>> reasonably clean code we'd need two separate instances of
>>>>>> get_next_bo_from_list().
>>>>>>
>>>>>> For the !RESV_PROTECTED case, perhaps one would want to
>>>>>> consider
>>>>>> the
>>>>>> solution used currently in xe, where the VM maintains two
>>>>>> evict
>>>>>> lists.
>>>>>> One protected by a spinlock and one protected by the VM resv.
>>>>>> When
>>>>>> the
>>>>>> VM resv is locked to begin list traversal, the spinlock is
>>>>>> locked
>>>>>> *once*
>>>>>> and the spinlock-protected list is looped over and copied
>>>>>> into the
>>>>>> resv
>>>>>> protected one. For traversal, the resv protected one is
>>>>>> used.
>>>>>
>>>>> Oh, so you do have the same sort of trick where you move the
>>>>> entire
>>>>> list to another list, such that you can let other paths update
>>>>> the
>>>>> list
>>>>> while you're iterating your own snapshot. That's
>>>>> interesting...
>>>>
>>>> Yes, it's instead of the "evicted" bool suggested here. I thought
>>>> the
>>>> latter would be simpler. Although that remains to be seen after
>>>> all
>>>> use-cases are implemented.
>>>>
>>>> But in general I think the concept of copying from a staging list
>>>> to
>>>> another with different protection rather than traversing the
>>>> first list
>>>> and unlocking between items is a good way of solving the locking
>>>> inversion problem with minimal overhead. We use it also for O(1)
>>>> userptr validation.
>>>
>>> That's more or less the idea behind get_next_vm_bo_from_list()
>>> except
>>> it's dequeuing one element at a time, instead of moving all items
>>> at
>>> once. Note that, if you allow concurrent removal protected only by
>>> the
>>> spinlock, you still need to take/release this spinlock when
>>> iterating
>>> over elements of this snapshot list, because all the remover needs
>>> to
>>> remove an element is the element itself, and it doesn't care in
>>> which
>>> list it's currently inserted (real or snapshot/staging list), so
>>> you'd
>>> be iterating over a moving target if you don't protect the
>>> iteration
>>> with the spinlock.
>>>
>>
> 

