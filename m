Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197AA7BF334
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442285AbjJJGkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442233AbjJJGk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:40:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776E9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696920026; x=1728456026;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qyS78X6kgyN72gNbojsrXZvOfLJcf47vxLUxZFdsRK0=;
  b=LoQPN92xLkHHzmtauf3fImrS9MOlSodoM0lbjWQ0iVU8bm+aWSTxdQV0
   98ivgNDUexwFmGjpqk9h/393scAWkPl2WH7wie2U7Q+3Q41JgnLEnZsx5
   XPUr0MdyrYlTl9Me3cXvo/0d4Cy52KQ0NjOwt1UQ1uFpOwx14xTMihLMo
   e99vw685bpl6LAozWHUvUnLqi7/eg3N9uvvWfIpIoNFn59Sju9vmYhscz
   kR0fh4IfFMOfU6BcTwEbyTB+Ur1AHBdN0FyQebhkb/kzzHQDgUMsA9oZ7
   a1My+dsf0IbkQYGUvrRnNSz4ZJOLwvhc4cYzS7TtjizL3SaKL77vbO1um
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369390597"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="369390597"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 23:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="746962821"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="746962821"
Received: from agargas-mobl.ger.corp.intel.com (HELO [10.249.254.164]) ([10.249.254.164])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 23:40:21 -0700
Message-ID: <c6ce663d-dd69-46a2-7b55-359169b6c03c@linux.intel.com>
Date:   Tue, 10 Oct 2023 08:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v6 4/6] drm/gpuvm: track/lock/validate
 external/evicted objects
Content-Language: en-US
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231008233212.13815-1-dakr@redhat.com>
 <20231008233212.13815-5-dakr@redhat.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20231008233212.13815-5-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/23 01:32, Danilo Krummrich wrote:
> Currently the DRM GPUVM offers common infrastructure to track GPU VA
> allocations and mappings, generically connect GPU VA mappings to their
> backing buffers and perform more complex mapping operations on the GPU VA
> space.
>
> However, there are more design patterns commonly used by drivers, which
> can potentially be generalized in order to make the DRM GPUVM represent
> a basis for GPU-VM implementations. In this context, this patch aims
> at generalizing the following elements.
>
> 1) Provide a common dma-resv for GEM objects not being used outside of
>     this GPU-VM.
>
> 2) Provide tracking of external GEM objects (GEM objects which are
>     shared with other GPU-VMs).
>
> 3) Provide functions to efficiently lock all GEM objects dma-resv the
>     GPU-VM contains mappings of.
>
> 4) Provide tracking of evicted GEM objects the GPU-VM contains mappings
>     of, such that validation of evicted GEM objects is accelerated.
>
> 5) Provide some convinience functions for common patterns.
>
> Big thanks to Boris Brezillon for his help to figure out locking for
> drivers updating the GPU VA space within the fence signalling path.
>
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>
> +/**
> + * drm_gpuvm_resv_add_fence - add fence to private and all extobj
> + * dma-resv
> + * @gpuvm: the &drm_gpuvm to add a fence to
> + * @exec: the &drm_exec locking context
> + * @fence: fence to add
> + * @private_usage: private dma-resv usage
> + * @extobj_usage: extobj dma-resv usage
> + */
> +void
> +drm_gpuvm_resv_add_fence(struct drm_gpuvm *gpuvm,
> +			 struct drm_exec *exec,
> +			 struct dma_fence *fence,
> +			 enum dma_resv_usage private_usage,
> +			 enum dma_resv_usage extobj_usage)
> +{
> +	struct drm_gem_object *obj;
> +	unsigned long index;
> +
> +	drm_exec_for_each_locked_object(exec, index, obj) {
> +		dma_resv_assert_held(obj->resv);
> +		dma_resv_add_fence(obj->resv, fence,
> +				   drm_gpuvm_is_extobj(gpuvm, obj) ?
> +				   private_usage : extobj_usage);

It looks like private_usage and extobj_usage are mixed up above?


> +	}
> +}
> +EXPORT_SYMBOL_GPL(drm_gpuvm_resv_add_fence);
> +

Thanks,

Thomas


