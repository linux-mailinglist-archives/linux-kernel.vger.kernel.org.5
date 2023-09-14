Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548307A04BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbjINNBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbjINNBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:01:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EBF1FD5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:01:43 -0700 (PDT)
Received: from [192.168.2.134] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA1766607343;
        Thu, 14 Sep 2023 14:01:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694696502;
        bh=v7DarGRquMfyLEjGWgeGuwbNfFGcYNditgZ8c3FOQkc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MuOydnq9IblIDeVrXJoWXbCc90YL4c+0X+qvYlSpCQSNtCHdfkykV9fyMKZ1v7osv
         9r0arWbahiqks3T9c/BmCN9p22Q7YYbf/dzdTApio/+o3PMEBora1NYlTMA40yUVRx
         1ipiGfyY9Evi7G7X2sXiahvygnSAug+BskUIgUv85lIk9F1erwyL0NYKrkk1T3TUGu
         ll8RQ9toWpzZ4WmNy2tHwLiJZqlUGbJiF3svdASEI4JeiftdBMwLeZNfcE3evFplEx
         0MCNIrbj5vIC/R+UjT0403wA2dCudHcG4ZK+W837YV5ImNkP2R3HW6qlbipmqpVXRe
         B/Lz+QTRBjkew==
Message-ID: <ca7e905b-2809-fce4-1b56-7909efb1a229@collabora.com>
Date:   Thu, 14 Sep 2023 16:01:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v16 15/20] drm/shmem-helper: Add memory shrinker
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
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
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
 <20230903170736.513347-16-dmitry.osipenko@collabora.com>
 <20230905100306.3564e729@collabora.com>
 <26f7ba6d-3520-0311-35e2-ef5706a98232@collabora.com>
 <20230913094832.3317c2df@collabora.com>
 <aa270715-89ae-2aac-e2e3-018c21e1ff0e@collabora.com>
 <20230914093626.19692c24@collabora.com>
 <21dda0bd-4264-b480-dbbc-29a7744bc96c@collabora.com>
 <20230914102737.08e61498@collabora.com>
 <a89cc9c1-5054-e45f-edec-819fdbfef2b5@collabora.com>
 <20230914135840.5e0e11fe@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230914135840.5e0e11fe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 14:58, Boris Brezillon wrote:
> On Thu, 14 Sep 2023 14:36:23 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> On 9/14/23 11:27, Boris Brezillon wrote:
>>> On Thu, 14 Sep 2023 10:50:32 +0300
>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>>   
>>>> On 9/14/23 10:36, Boris Brezillon wrote:  
>>>>> On Thu, 14 Sep 2023 07:02:52 +0300
>>>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>>>>     
>>>>>> On 9/13/23 10:48, Boris Brezillon wrote:    
>>>>>>> On Wed, 13 Sep 2023 03:56:14 +0300
>>>>>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>>>>>>       
>>>>>>>> On 9/5/23 11:03, Boris Brezillon wrote:      
>>>>>>>>>>                * But
>>>>>>>>>> +		 * acquiring the obj lock in drm_gem_shmem_release_pages_locked() can
>>>>>>>>>> +		 * cause a locking order inversion between reservation_ww_class_mutex
>>>>>>>>>> +		 * and fs_reclaim.
>>>>>>>>>> +		 *
>>>>>>>>>> +		 * This deadlock is not actually possible, because no one should
>>>>>>>>>> +		 * be already holding the lock when drm_gem_shmem_free() is called.
>>>>>>>>>> +		 * Unfortunately lockdep is not aware of this detail.  So when the
>>>>>>>>>> +		 * refcount drops to zero, don't touch the reservation lock.
>>>>>>>>>> +		 */
>>>>>>>>>> +		if (shmem->got_pages_sgt &&
>>>>>>>>>> +		    refcount_dec_and_test(&shmem->pages_use_count)) {
>>>>>>>>>> +			drm_gem_shmem_do_release_pages_locked(shmem);
>>>>>>>>>> +			shmem->got_pages_sgt = false;
>>>>>>>>>>  		}        
>>>>>>>>> Leaking memory is the right thing to do if pages_use_count > 1 (it's
>>>>>>>>> better to leak than having someone access memory it no longer owns), but
>>>>>>>>> I think it's worth mentioning in the above comment.        
>>>>>>>>
>>>>>>>> It's unlikely that it will be only a leak without a following up
>>>>>>>> use-after-free. Neither is acceptable.      
>>>>>>>
>>>>>>> Not necessarily, if you have a page leak, it could be that the GPU has
>>>>>>> access to those pages, but doesn't need the GEM object anymore
>>>>>>> (pages are mapped by the iommu, which doesn't need shmem->sgt or
>>>>>>> shmem->pages after the mapping is created). Without a WARN_ON(), this
>>>>>>> can go unnoticed and lead to memory corruptions/information leaks.
>>>>>>>       
>>>>>>>>
>>>>>>>> The drm_gem_shmem_free() could be changed such that kernel won't blow up
>>>>>>>> on a refcnt bug, but that's not worthwhile doing because drivers
>>>>>>>> shouldn't have silly bugs.      
>>>>>>>
>>>>>>> We definitely don't want to fix that, but we want to complain loudly
>>>>>>> (WARN_ON()), and make sure the risk is limited (preventing memory from
>>>>>>> being re-assigned to someone else by not freeing it).      
>>>>>>
>>>>>> That's what the code did and continues to do here. Not exactly sure what
>>>>>> you're trying to say. I'm going to relocate the comment in v17 to
>>>>>> put_pages(), we can continue discussing it there if I'm missing yours point.
>>>>>>    
>>>>>
>>>>> I'm just saying it would be worth mentioning that we're intentionally
>>>>> leaking memory if shmem->pages_use_count > 1. Something like:
>>>>>
>>>>> 	/**
>>>>> 	 * shmem->pages_use_count should be 1 when ->sgt != NULL and
>>>>> 	 * zero otherwise. If some users still hold a pages reference
>>>>> 	 * that's a bug, and we intentionally leak the pages so they
>>>>> 	 * can't be re-allocated to someone else while the GPU/CPU
>>>>> 	 * still have access to it.
>>>>> 	 */
>>>>> 	drm_WARN_ON(drm,
>>>>> 		    refcount_read(&shmem->pages_use_count) == (shmem->sgt ? 1 : 0));
>>>>> 	if (shmem->sgt && refcount_dec_and_test(&shmem->pages_use_count))
>>>>> 		drm_gem_shmem_free_pages(shmem);    
>>>>
>>>> That may be acceptable, but only once there will a driver using this
>>>> feature.  
>>>
>>> Which feature? That's not related to a specific feature, that's just
>>> how drm_gem_shmem_get_pages_sgt() works, it takes a pages ref that can
>>> only be released in drm_gem_shmem_free(), because sgt users are not
>>> refcounted and the sgt stays around until the GEM object is freed or
>>> its pages are evicted. The only valid cases we have at the moment are:
>>>
>>> - pages_use_count == 1 && sgt != NULL
>>> - pages_use_count == 0
>>>
>>> any other situations are buggy.  
>>
>> sgt may belong to dma-buf for which pages_use_count=0, this can't be
>> done until sgt mess is sorted out
> 
> No it can't, not in that path, because the code you're adding is in the
> if (!obj->import_branch) branch:
> 
> 
>  	if (obj->import_attach) {
>  		drm_prime_gem_destroy(obj, shmem->sgt);
>  	} else {
> 		...
> 		// Your changes are here.
> 		...

This branch is taken for the dma-buf in the prime import error code path. But yes, the pages_use_count=0 for the dma-buf and then it can be written as:

	if (obj->import_attach) {
		drm_prime_gem_destroy(obj, shmem->sgt);
	} else {
		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));

		if (shmem->sgt && refcount_read(&shmem->pages_use_count)) {
			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
					  DMA_BIDIRECTIONAL, 0);
			sg_free_table(shmem->sgt);
			kfree(shmem->sgt);

			__drm_gem_shmem_put_pages(shmem);
		}

		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));

Alright, I'll check if it works as expected for fixing the error code path bug for v17

-- 
Best regards,
Dmitry

