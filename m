Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620097B8001
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbjJDM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbjJDM6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A3DD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696424243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UocplIidO7zTE/4ZN7c3P31bQ70zOq+bV6Role3kEz0=;
        b=IYZWPiepPI3PVPYLMjmFlDHyqMT3UfEE5QEH3i/BvLgrFT3J/TMWft36sG6mDljaXGo5z4
        /NIVu+BrHpKu1IqwpX9l/Vqkz2im9++yorD38mg2744eWGXgXPSwkCABG/RL1lU8ASb9L0
        iNXc6g9h1ZHr9/JAdDMyGd/FnntnJ9Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-cXjCU4ekMFynQP-34WZcEg-1; Wed, 04 Oct 2023 08:57:12 -0400
X-MC-Unique: cXjCU4ekMFynQP-34WZcEg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b95fa56bd5so11071466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424231; x=1697029031;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UocplIidO7zTE/4ZN7c3P31bQ70zOq+bV6Role3kEz0=;
        b=i2KNyKKmx17ZORYXnJxTMqEarmCmc9jK3gQ1ts2NGRL5HIJaVchjgWgpV/7T6gWbnr
         B7+WCHLbUTE5i4AHboIJ8U04DIgt/B3tAmd6jaev3bh2GIdoOrn5ZHHNPZd9tqJFOqYF
         c0zDFbXFQDjMDUB6j57fZ71eK+B6VHYKC9aIqSLDxwPZV+WwuJJk3V/2EDM9OfxuPKK8
         13SpVxGuowNcSe74y9LvnRYLGwWmPDQ8HGr8FBDwgl26UpO030KvBGHPE6/JP8sUiIA0
         IWBVzgI9tScmyv8JDMMDrclESv/Qc10up3qCGUYk6ArSbGYnOCQuR7xtC8zvA3FCfk+1
         9t/w==
X-Gm-Message-State: AOJu0YxTaOEb1FFjTkzvBivQChYOzhag7SG/UxtdL8+Aqf5n6yzEKIEm
        F9c88PltmHVyTBAYeU54q/wwl5tc1X5949kanObpVjX9nh6AiTpKiUiyX+KPaK0aggGMo2FGnhN
        3KAESrdUCEFELsxP7XwZhc26Hc3iVf2Fl
X-Received: by 2002:a17:906:4d2:b0:9a2:26d8:f184 with SMTP id g18-20020a17090604d200b009a226d8f184mr1535501eja.51.1696424230993;
        Wed, 04 Oct 2023 05:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmt8ptQ+NpMGEA8WwD3MopWfb9O4X8+QQKV5V2rPVZNgpUR9p7BK5+q5JqnyoFPOngtFGAoA==
X-Received: by 2002:a17:906:4d2:b0:9a2:26d8:f184 with SMTP id g18-20020a17090604d200b009a226d8f184mr1535481eja.51.1696424230614;
        Wed, 04 Oct 2023 05:57:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id va17-20020a17090711d100b0099d804da2e9sm2828850ejb.225.2023.10.04.05.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:57:09 -0700 (PDT)
Message-ID: <6489f31f-8929-3e59-fbef-a22049cccbe3@redhat.com>
Date:   Wed, 4 Oct 2023 14:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH drm-misc-next v5 4/6] drm/gpuvm: track/lock/validate
 external/evicted objects
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
Content-Language: en-US
Organization: RedHat
In-Reply-To: <6b16ab6f-b1a2-efdb-04bf-5af4c3de381b@linux.intel.com>
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

On 10/3/23 11:11, Thomas Hellström wrote:

<snip>

>>> +
>>> +/**
>>> + * drm_gpuvm_bo_evict() - add / remove a &drm_gpuvm_bo to / from the &drm_gpuvms
>>> + * evicted list
>>> + * @vm_bo: the &drm_gpuvm_bo to add or remove
>>> + * @evict: indicates whether the object is evicted
>>> + *
>>> + * Adds a &drm_gpuvm_bo to or removes it from the &drm_gpuvms evicted list.
>>> + */
>>> +void
>>> +drm_gpuvm_bo_evict(struct drm_gpuvm_bo *vm_bo, bool evict)
>>> +{
>>> +    struct drm_gem_object *obj = vm_bo->obj;
>>> +
>>> +    dma_resv_assert_held(obj->resv);
>>> +
>>> +    /* Always lock list transactions, even if DRM_GPUVM_RESV_PROTECTED is
>>> +     * set. This is required to protect multiple concurrent calls to
>>> +     * drm_gpuvm_bo_evict() with BOs with different dma_resv.
>>> +     */
>>
>> This doesn't work. The RESV_PROTECTED case requires the evicted flag we discussed before. The list is either protected by the spinlock or the resv. Otherwise a list add could race with a list removal elsewhere.

I think it does unless I miss something, but it might be a bit subtle though.

Concurrent drm_gpuvm_bo_evict() are protected by the spinlock. Additionally, when
drm_gpuvm_bo_evict() is called we hold the dma-resv of the corresponding GEM object.

In drm_gpuvm_validate() I assert that we hold *all* dma-resv, which implies that no
one can call drm_gpuvm_bo_evict() on any of the VM's objects and no one can add a new
one and directly call drm_gpuvm_bo_evict() on it either.

>>
>> Thanks,
>>
>> Thomas
>>
>>
> 

