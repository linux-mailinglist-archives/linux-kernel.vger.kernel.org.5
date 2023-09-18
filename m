Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701507A4A69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 15:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbjIRNBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 09:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242038AbjIRNAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 09:00:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EF7E103;
        Mon, 18 Sep 2023 05:59:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 692A11FB;
        Mon, 18 Sep 2023 06:00:29 -0700 (PDT)
Received: from [10.57.64.210] (unknown [10.57.64.210])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 290C23F5A1;
        Mon, 18 Sep 2023 05:59:47 -0700 (PDT)
Message-ID: <ea68e477-1e77-563e-81a4-bf6d7af5bd94@arm.com>
Date:   Mon, 18 Sep 2023 13:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 5/6] drm/panfrost: Implement generic DRM object RSS
 reporting function
Content-Language: en-GB
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com
References: <20230914223928.2374933-1-adrian.larumbe@collabora.com>
 <20230914223928.2374933-6-adrian.larumbe@collabora.com>
 <a8d9fe07-7acc-db10-5660-293a449d9dd2@arm.com>
 <20230918123218.14ca9fde@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230918123218.14ca9fde@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 11:32, Boris Brezillon wrote:
> On Mon, 18 Sep 2023 11:01:43 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>> On 14/09/2023 23:38, Adrián Larumbe wrote:
>>> BO's RSS is updated every time new pages are allocated on demand and mapped
>>> for the object at GPU page fault's IRQ handler, but only for heap buffers.
>>> The reason this is unnecessary for non-heap buffers is that they are mapped
>>> onto the GPU's VA space and backed by physical memory in their entirety at
>>> BO creation time.
>>>
>>> This calculation is unnecessary for imported PRIME objects, since heap
>>> buffers cannot be exported by our driver, and the actual BO RSS size is the
>>> one reported in its attached dmabuf structure.
>>>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>  
>>
>> Am I missing something, or are we missing a way of resetting
>> heap_rss_size when the shrinker purges? It looks like after several
>> grow/purge cycles, heap_rss_size could actually grow to be larger than
>> the BO which is clearly wrong.
> 
> Didn't even consider this case since we don't flag heap BOs purgeable
> in mesa(panfrost), but let's assume we did. If the BO is purged, I'd
> expect the core to report 0MB of resident memory anyway. And purged BOs
> are not supposed to be re-used if MADVISE(WILL_NEED) returns
> retained=false, they should be destroyed. Not 100% sure this is
> enforced everywhere though (we might actually miss tests to make sure
> users don't pass purged BOs to jobs, or make the alloc-on-fault logic
> doesn't try to grow a purged GEM).
> 
> If we want to implement transparent BO swap{out,in} (Dmitry's
> patchset), that's be a different story, and we'll indeed have to set
> heap_rss_size back to zero on eviction.

Ah, ok. So we should be safe as things stand - but this is something to
remember about in the future. Looking more closely at the code I can see
an madvise(WILL_NEED) will fail if retained=false
(drm_gem_shmem_madvise() only updates the state it shmem->madv >= 0).

In which case:

Reviewed-by: Steven Price <steven.price@arm.com>

>>
>> Steve
>>
>>> ---
>>>  drivers/gpu/drm/panfrost/panfrost_gem.c | 15 +++++++++++++++
>>>  drivers/gpu/drm/panfrost/panfrost_gem.h |  5 +++++
>>>  drivers/gpu/drm/panfrost/panfrost_mmu.c |  1 +
>>>  3 files changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
>>> index 7d8f83d20539..4365434b48db 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
>>> @@ -208,6 +208,20 @@ static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj
>>>  	return res;
>>>  }
>>>  
>>> +static size_t panfrost_gem_rss(struct drm_gem_object *obj)
>>> +{
>>> +	struct panfrost_gem_object *bo = to_panfrost_bo(obj);
>>> +
>>> +	if (bo->is_heap) {
>>> +		return bo->heap_rss_size;
>>> +	} else if (bo->base.pages) {
>>> +		WARN_ON(bo->heap_rss_size);
>>> +		return bo->base.base.size;
>>> +	} else {
>>> +		return 0;
>>> +	}
>>> +}
>>> +
>>>  static const struct drm_gem_object_funcs panfrost_gem_funcs = {
>>>  	.free = panfrost_gem_free_object,
>>>  	.open = panfrost_gem_open,
>>> @@ -220,6 +234,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
>>>  	.vunmap = drm_gem_shmem_object_vunmap,
>>>  	.mmap = drm_gem_shmem_object_mmap,
>>>  	.status = panfrost_gem_status,
>>> +	.rss = panfrost_gem_rss,
>>>  	.vm_ops = &drm_gem_shmem_vm_ops,
>>>  };
>>>  
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
>>> index ad2877eeeccd..13c0a8149c3a 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
>>> @@ -36,6 +36,11 @@ struct panfrost_gem_object {
>>>  	 */
>>>  	atomic_t gpu_usecount;
>>>  
>>> +	/*
>>> +	 * Object chunk size currently mapped onto physical memory
>>> +	 */
>>> +	size_t heap_rss_size;
>>> +
>>>  	bool noexec		:1;
>>>  	bool is_heap		:1;
>>>  };
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>>> index d54d4e7b2195..7b1490cdaa48 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>>> @@ -522,6 +522,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>>>  		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
>>>  
>>>  	bomapping->active = true;
>>> +	bo->heap_rss_size += SZ_2;
>>>  
>>>  	dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
>>>    
>>
> 

