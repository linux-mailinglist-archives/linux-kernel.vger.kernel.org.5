Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E9A776C62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjHIWlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjHIWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D426EDA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691620858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqkWptdyICgKZLcTvquabOW8rAvUOuPeScuQD1YQUKA=;
        b=PsTqNfBJ5zpHMG62WbZ6UO1Qzn95BGLj3M0cRh1R6beuQMOeiaiCeV+yNOObarbS9NTNkt
        E2sGI13R6HiFJgyZf+EZyoCkdHZmdLUeY7RG+Erc++J7aTaqe9woVPT4BrNuPWEt0hJdNo
        4SU1fglHTjesZkdWSim7ExVqKG+mAMM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-qJXZKkU7P-SmAnUDat_8JA-1; Wed, 09 Aug 2023 18:40:56 -0400
X-MC-Unique: qJXZKkU7P-SmAnUDat_8JA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-993831c639aso22108766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 15:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691620855; x=1692225655;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqkWptdyICgKZLcTvquabOW8rAvUOuPeScuQD1YQUKA=;
        b=TKzyBs+fkcNAllwC0h0ogFswa0cSYqTGWm47mr4M/4txHLTY4Ch1j8RsRlC+8RxE3v
         G67n1aaCr3P0n/tc2QGLL0tQ3yo9sX6/BeQzo+1+ZygGOTrR9Nb6S22+Ve+D+ypWXuqt
         gMdfB3As4fHNQuCcgJBWP/5KH9YUz7r/TeWgF62anTWbavzl2rpn0IkOcuJqorJQf/iG
         oVPPOb7FHo5CInr3k8LNKsTTPC3m/AOXG66dPTiKsV9BL+CrnPF4z4p8KTMC9+YekO+n
         M3tQWar4hJUD/95D/dYrzTgdWULo5U56BrsjSfi0MtGsScBLgRTYeZwaO7D3dQFA/8n/
         pnDQ==
X-Gm-Message-State: AOJu0YyGauw0ExwpOWHCC58HjLKAQYFGlJCclRMBdmOUQNG1wxh4/43t
        m9wDwfj2cNzMFF8nlrJuUM6yS5Tn+I1aXzUsnzSF8Pn0AlcVEWQA/yzBt6Fxi90NUwJBiQ2a1P5
        GCMtQ0O+tltl7vydjbjRgLM8Z
X-Received: by 2002:aa7:c687:0:b0:522:4cd7:efb0 with SMTP id n7-20020aa7c687000000b005224cd7efb0mr469650edq.17.1691620855562;
        Wed, 09 Aug 2023 15:40:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbc5d+5Pwrcb2mWJiUCFNf5HjHJlFOgUzg5E8ZB5Bw31sbH+4nAOdQBye19n8yg+HHqaYiFA==
X-Received: by 2002:aa7:c687:0:b0:522:4cd7:efb0 with SMTP id n7-20020aa7c687000000b005224cd7efb0mr469630edq.17.1691620855277;
        Wed, 09 Aug 2023 15:40:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id w26-20020a056402071a00b0052369656ed3sm48675edx.3.2023.08.09.15.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 15:40:54 -0700 (PDT)
Message-ID: <3f4beed9-6aca-b544-80a2-9ea5264da119@redhat.com>
Date:   Thu, 10 Aug 2023 00:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v9 01/11] drm/gem: fix lockdep check for
 dma-resv lock
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, alexdeucher@gmail.com, ogabbay@kernel.org,
        bagasdotme@gmail.com, willy@infradead.org, jason@jlekstrand.net,
        donald.robson@imgtec.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803165238.8798-1-dakr@redhat.com>
 <20230803165238.8798-2-dakr@redhat.com>
 <20230808092117.7f7fdef9@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230808092117.7f7fdef9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 09:21, Boris Brezillon wrote:
> On Thu,  3 Aug 2023 18:52:20 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> When no custom lock is set to protect a GEMs GPUVA list, lockdep checks
>> should fall back to the GEM objects dma-resv lock. With the current
>> implementation we're setting the lock_dep_map of the GEM objects 'resv'
>> pointer (in case no custom lock_dep_map is set yet) on
>> drm_gem_private_object_init().
>>
>> However, the GEM objects 'resv' pointer might still change after
>> drm_gem_private_object_init() is called, e.g. through
>> ttm_bo_init_reserved(). This can result in the wrong lock being tracked.
>>
>> To fix this, call dma_resv_held() directly from
>> drm_gem_gpuva_assert_lock_held() and fall back to the GEMs lock_dep_map
>> pointer only if an actual custom lock is set.
>>
>> Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> but I'm wondering if it wouldn't be a good thing to add a
> drm_gem_set_resv() helper, so the core can control drm_gem_object::resv
> re-assignments (block them if it's happening after the GEM has been
> exposed to the outside world or update auxiliary data if it's happening
> before that).

I agree, this might be a good idea. There are quite a few places where 
drm_gem_object::resv is set from external code.

> 
>> ---
>>   include/drm/drm_gem.h | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>> index c0b13c43b459..bc9f6aa2f3fe 100644
>> --- a/include/drm/drm_gem.h
>> +++ b/include/drm/drm_gem.h
>> @@ -551,15 +551,17 @@ int drm_gem_evict(struct drm_gem_object *obj);
>>    * @lock: the lock used to protect the gpuva list. The locking primitive
>>    * must contain a dep_map field.
>>    *
>> - * Call this if you're not proctecting access to the gpuva list
>> - * with the dma-resv lock, otherwise, drm_gem_gpuva_init() takes care
>> - * of initializing lock_dep_map for you.
>> + * Call this if you're not proctecting access to the gpuva list with the
>> + * dma-resv lock, but with a custom lock.
>>    */
>>   #define drm_gem_gpuva_set_lock(obj, lock) \
>> -	if (!(obj)->gpuva.lock_dep_map) \
>> +	if (!WARN((obj)->gpuva.lock_dep_map, \
>> +		  "GEM GPUVA lock should be set only once.")) \
>>   		(obj)->gpuva.lock_dep_map = &(lock)->dep_map
>>   #define drm_gem_gpuva_assert_lock_held(obj) \
>> -	lockdep_assert(lock_is_held((obj)->gpuva.lock_dep_map))
>> +	lockdep_assert((obj)->gpuva.lock_dep_map ? \
>> +		       lock_is_held((obj)->gpuva.lock_dep_map) : \
>> +		       dma_resv_held((obj)->resv))
>>   #else
>>   #define drm_gem_gpuva_set_lock(obj, lock) do {} while (0)
>>   #define drm_gem_gpuva_assert_lock_held(obj) do {} while (0)
>> @@ -573,11 +575,12 @@ int drm_gem_evict(struct drm_gem_object *obj);
>>    *
>>    * Calling this function is only necessary for drivers intending to support the
>>    * &drm_driver_feature DRIVER_GEM_GPUVA.
>> + *
>> + * See also drm_gem_gpuva_set_lock().
>>    */
>>   static inline void drm_gem_gpuva_init(struct drm_gem_object *obj)
>>   {
>>   	INIT_LIST_HEAD(&obj->gpuva.list);
>> -	drm_gem_gpuva_set_lock(obj, &obj->resv->lock.base);
>>   }
>>   
>>   /**
> 

