Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9AE7B8645
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjJDRST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbjJDRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D81A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696439851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPno0DbjR8sc9C28uYBqw2IPXySsSDuMsnExiXjbaCk=;
        b=dwdp+og4nKTOc1MoE98g/0TxfNL3dDWKHqzXj0vyU8kPtColc0QcuekTaYL9rGY9Q7iIr5
        psjiURxUYoljUdDcu3WYS7vFvQ3Kmox8EwbhiSjo2mDZfsL/fejQhS9vYQwMEKkosZfI97
        EPrCmpcwJQulx5V6P5SndJZZIb8zuko=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-_7tzY2sDOg2cEu0FQwYIAg-1; Wed, 04 Oct 2023 13:17:30 -0400
X-MC-Unique: _7tzY2sDOg2cEu0FQwYIAg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-538128e18e9so2149505a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 10:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696439849; x=1697044649;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPno0DbjR8sc9C28uYBqw2IPXySsSDuMsnExiXjbaCk=;
        b=NXPgEus39Nf8LH3hD6ZgQV5IRKnfh5VjJyz4CNf5417KpGyfF5IPJnNS9BU+OBt0XC
         ydMDJOqfn/H85WvELk2DNMnn3lAsjYRu22l8hKNuODTiJZi5IdTWyB2d5TEbWIddg88T
         voB6ZD17NssNYH1RqYeu4bxSZ6oRn7cI0cAH7JljKGXyMTNoXMvDo/zQtRUvdNRnvJ3g
         31xZYJYdEnNoIvrS3TBU6x/FcSbDub0YFwJlews32ecPpcMmPXcXpNbiYyAni+NOOlf5
         K1ApMW9O3ze0kzYzRBLtEGlnRiGMdJfUcloIZYP/ZWZ4dxWhenJpbJYEX02h8fgREGyF
         8qXw==
X-Gm-Message-State: AOJu0Yys2H98JNoEtog79aiKetJH1xqs3JIZWRG4XEJtlo9jgY5xZ7AW
        Zsotv91WtVXpooXOu9G5GU14tPqzFOgUoO2MWX/Q/yXEiFYB/VqG07jbamWLMKi6AOPbUb4dAQh
        sHAgjJN/IBs03xICcwJlDn/e2OYJQCLSV
X-Received: by 2002:a05:6402:355:b0:523:d51:bb2 with SMTP id r21-20020a056402035500b005230d510bb2mr2286261edw.15.1696439848818;
        Wed, 04 Oct 2023 10:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkl0j11vz68R1X5NW+lmaJ8bDJJJ8AjsoayC5leFdHqxUWbsCLDnHip93FBol947fk53E1Lg==
X-Received: by 2002:a05:6402:355:b0:523:d51:bb2 with SMTP id r21-20020a056402035500b005230d510bb2mr2286239edw.15.1696439848407;
        Wed, 04 Oct 2023 10:17:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402344800b0053537ad3936sm158162edc.21.2023.10.04.10.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:17:27 -0700 (PDT)
Message-ID: <74d79ced-e811-bed9-6fb0-db694428c10f@redhat.com>
Date:   Wed, 4 Oct 2023 19:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v5 4/6] drm/gpuvm: track/lock/validate
 external/evicted objects
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230928191624.13703-1-dakr@redhat.com>
 <20230928191624.13703-5-dakr@redhat.com>
 <e4e68970-c7c9-55e2-9483-01252f38c956@linux.intel.com>
 <6b16ab6f-b1a2-efdb-04bf-5af4c3de381b@linux.intel.com>
 <6489f31f-8929-3e59-fbef-a22049cccbe3@redhat.com>
 <36233651a7675ab894134e41fc711fdcc71eefec.camel@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <36233651a7675ab894134e41fc711fdcc71eefec.camel@linux.intel.com>
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

On 10/4/23 17:29, Thomas Hellström wrote:
> 
> On Wed, 2023-10-04 at 14:57 +0200, Danilo Krummrich wrote:
>> On 10/3/23 11:11, Thomas Hellström wrote:
>>
>> <snip>
>>
>>>>> +
>>>>> +/**
>>>>> + * drm_gpuvm_bo_evict() - add / remove a &drm_gpuvm_bo to /
>>>>> from the &drm_gpuvms
>>>>> + * evicted list
>>>>> + * @vm_bo: the &drm_gpuvm_bo to add or remove
>>>>> + * @evict: indicates whether the object is evicted
>>>>> + *
>>>>> + * Adds a &drm_gpuvm_bo to or removes it from the &drm_gpuvms
>>>>> evicted list.
>>>>> + */
>>>>> +void
>>>>> +drm_gpuvm_bo_evict(struct drm_gpuvm_bo *vm_bo, bool evict)
>>>>> +{
>>>>> +    struct drm_gem_object *obj = vm_bo->obj;
>>>>> +
>>>>> +    dma_resv_assert_held(obj->resv);
>>>>> +
>>>>> +    /* Always lock list transactions, even if
>>>>> DRM_GPUVM_RESV_PROTECTED is
>>>>> +     * set. This is required to protect multiple concurrent
>>>>> calls to
>>>>> +     * drm_gpuvm_bo_evict() with BOs with different dma_resv.
>>>>> +     */
>>>>
>>>> This doesn't work. The RESV_PROTECTED case requires the evicted
>>>> flag we discussed before. The list is either protected by the
>>>> spinlock or the resv. Otherwise a list add could race with a list
>>>> removal elsewhere.
>>
>> I think it does unless I miss something, but it might be a bit subtle
>> though.
>>
>> Concurrent drm_gpuvm_bo_evict() are protected by the spinlock.
>> Additionally, when
>> drm_gpuvm_bo_evict() is called we hold the dma-resv of the
>> corresponding GEM object.
>>
>> In drm_gpuvm_validate() I assert that we hold *all* dma-resv, which
>> implies that no
>> one can call drm_gpuvm_bo_evict() on any of the VM's objects and no
>> one can add a new
>> one and directly call drm_gpuvm_bo_evict() on it either.
> 
> But translated into how the data (the list in this case) is protected
> it becomes
> 
> "Either the spinlock and the bo resv of a single list item OR the bo
> resvs of all bos that can potentially be on the list",
> 
> while this is certainly possible to assert, any new / future code that
> manipulates the evict list will probably get this wrong and as a result
> the code becomes pretty fragile. I think drm_gpuvm_bo_destroy() already
> gets it wrong in that it, while holding a single resv, doesn't take the
> spinlock.

That's true and I don't like it either. Unfortunately, with the dma-resv
locking scheme we can't really protect the evict list without the
drm_gpuvm_bo::evicted trick properly.

But as pointed out in my other reply, I'm a bit worried about the
drm_gpuvm_bo::evicted trick being too restrictive, but maybe it's fine
doing it in the RESV_PROTECTED case.

> 
> So I think that needs fixing, and if keeping that protection I think it
> needs to be documented with the list member and ideally an assert. But
> also note that lockdep_assert_held will typically give false true for
> dma_resv locks; as long as the first dma_resv lock locked in a drm_exec
> sequence  remains locked, lockdep thinks *all* dma_resv locks are held.
> (or something along those lines), so the resv lockdep asserts are
> currently pretty useless.
> 
> /Thomas
> 
> 
> 
>>
>>>>
>>>> Thanks,
>>>>
>>>> Thomas
>>>>
>>>>
>>>
>>
> 

