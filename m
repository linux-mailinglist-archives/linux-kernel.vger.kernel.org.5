Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542607B647F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbjJCIjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjJCIjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:39:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E527C97;
        Tue,  3 Oct 2023 01:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696322377; x=1727858377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SnpNVBUF66nW+RhzxAtvjdqNqvomxWSemJuUTLpDNSM=;
  b=I3G6yuENMyy4A6kphHzWByIw3e5OVoOJPP+vqcFS/T4lArDY3nrLn/dX
   Y6crIgThvdNdY/bQA3vIDD70cG0AmMZy7cxTdO1piQ/8+SPytZxy+naLN
   Q+zRlqxYHJ6M/4zAvFkEcGO68V7SBzZRlBOvkw+l6pgBDBsYCOw865DXZ
   lItKMeoXrSfgxGl92mMxlLJti9Gkf3ioZDA4gSJNJvk4iJuUYT5GfP93X
   4kIYsurzZLQL9r0fxV6zGTX3Wd//TIJdNNO4aWWo64KCXcPC0UwswaVY5
   0uFIf14FHtR5LmG1ttW1yPLa3/I/al4J/RrTTjxN58ugTgUF2Mg+ugpVn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362193503"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="362193503"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816605201"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="816605201"
Received: from fhoeg-mobl1.ger.corp.intel.com (HELO [10.249.254.234]) ([10.249.254.234])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:39:23 -0700
Message-ID: <3ab13ec8-40ec-2952-5b1c-0d20d99c512a@linux.intel.com>
Date:   Tue, 3 Oct 2023 10:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/ttm: Make sure the mapped tt pages are decrypted
 when needed
Content-Language: en-US
To:     Zack Rusin <zackr@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230926040359.3040017-1-zack@kde.org>
 <20230926175113.679880-1-zack@kde.org>
 <2b5648aa-f83d-d8f7-b0fd-39c859f32f33@linux.intel.com>
 <09fedce26475023fb1089f8b0b77801e1d2363c0.camel@linux.intel.com>
 <1679743e607097b967a932d2aefacbbc7913e5cb.camel@vmware.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <1679743e607097b967a932d2aefacbbc7913e5cb.camel@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/23 06:13, Zack Rusin wrote:
> On Mon, 2023-10-02 at 16:27 +0200, Thomas Hellström wrote:
>> !! External Email
>>
>> On Mon, 2023-10-02 at 10:16 +0200, Thomas Hellström wrote:
>>> Hi, Zack
>>>
>>> On 9/26/23 19:51, Zack Rusin wrote:
>>>> From: Zack Rusin <zackr@vmware.com>
>>>>
>>>> Some drivers require the mapped tt pages to be decrypted. In an
>>>> ideal
>>>> world this would have been handled by the dma layer, but the TTM
>>>> page
>>>> fault handling would have to be rewritten to able to do that.
>>>>
>>>> A side-effect of the TTM page fault handling is using a dma
>>>> allocation
>>>> per order (via ttm_pool_alloc_page) which makes it impossible to
>>>> just
>>>> trivially use dma_mmap_attrs. As a result ttm has to be very
>>>> careful
>>>> about trying to make its pgprot for the mapped tt pages match what
>>>> the dma layer thinks it is. At the ttm layer it's possible to
>>>> deduce the requirement to have tt pages decrypted by checking
>>>> whether coherent dma allocations have been requested and the system
>>>> is running with confidential computing technologies.
>>>>
>>>> This approach isn't ideal but keeping TTM matching DMAs
>>>> expectations
>>>> for the page properties is in general fragile, unfortunately proper
>>>> fix would require a rewrite of TTM's page fault handling.
>>>>
>>>> Fixes vmwgfx with SEV enabled.
>>>>
>>>> v2: Explicitly include cc_platform.h
>>>>
>>>> Signed-off-by: Zack Rusin <zackr@vmware.com>
>>>> Fixes: 3bf3710e3718 ("drm/ttm: Add a generic TTM memcpy move for
>>>> page-based iomem")
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>> Cc: dri-devel@lists.freedesktop.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: <stable@vger.kernel.org> # v5.14+
>>>> ---
>>>>    drivers/gpu/drm/ttm/ttm_bo_util.c | 13 +++++++++++--
>>>>    drivers/gpu/drm/ttm/ttm_tt.c      |  8 ++++++++
>>>>    include/drm/ttm/ttm_tt.h          |  9 ++++++++-
>>>>    3 files changed, 27 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>> b/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>> index fd9fd3d15101..0b3f4267130c 100644
>>>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>> @@ -294,7 +294,13 @@ pgprot_t ttm_io_prot(struct ttm_buffer_object
>>>> *bo, struct ttm_resource *res,
>>>>          enum ttm_caching caching;
>>>>
>>>>          man = ttm_manager_type(bo->bdev, res->mem_type);
>>>> -       caching = man->use_tt ? bo->ttm->caching : res-
>>>>> bus.caching;
>>>> +       if (man->use_tt) {
>>>> +               caching = bo->ttm->caching;
>>>> +               if (bo->ttm->page_flags & TTM_TT_FLAG_DECRYPTED)
>>>> +                       tmp = pgprot_decrypted(tmp);
>>>> +       } else  {
>>>> +               caching = res->bus.caching;
>>>> +       }
>>>>
>>>>          return ttm_prot_from_caching(caching, tmp);
>>>>    }
>>>> @@ -337,6 +343,8 @@ static int ttm_bo_kmap_ttm(struct
>>>> ttm_buffer_object *bo,
>>>>                  .no_wait_gpu = false
>>>>          };
>>>>          struct ttm_tt *ttm = bo->ttm;
>>>> +       struct ttm_resource_manager *man =
>>>> +                       ttm_manager_type(bo->bdev, bo->resource-
>>>>> mem_type);
>>>>          pgprot_t prot;
>>>>          int ret;
>>>>
>>>> @@ -346,7 +354,8 @@ static int ttm_bo_kmap_ttm(struct
>>>> ttm_buffer_object *bo,
>>>>          if (ret)
>>>>                  return ret;
>>>>
>>>> -       if (num_pages == 1 && ttm->caching == ttm_cached) {
>>>> +       if (num_pages == 1 && ttm->caching == ttm_cached &&
>>>> +           !(man->use_tt && (ttm->page_flags &
>>>> TTM_TT_FLAG_DECRYPTED))) {
>>>>                  /*
>>>>                   * We're mapping a single page, and the desired
>>>>                   * page protection is consistent with the bo.
>>>> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c
>>>> b/drivers/gpu/drm/ttm/ttm_tt.c
>>>> index e0a77671edd6..e4966e2c988d 100644
>>>> --- a/drivers/gpu/drm/ttm/ttm_tt.c
>>>> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
>>>> @@ -31,6 +31,7 @@
>>>>
>>>>    #define pr_fmt(fmt) "[TTM] " fmt
>>>>
>>>> +#include <linux/cc_platform.h>
>>>>    #include <linux/sched.h>
>>>>    #include <linux/shmem_fs.h>
>>>>    #include <linux/file.h>
>>>> @@ -81,6 +82,13 @@ int ttm_tt_create(struct ttm_buffer_object *bo,
>>>> bool zero_alloc)
>>>>                  pr_err("Illegal buffer object type\n");
>>>>                  return -EINVAL;
>>>>          }
>>>> +       /*
>>>> +        * When using dma_alloc_coherent with memory encryption the
>>>> +        * mapped TT pages need to be decrypted or otherwise the
>>>> drivers
>>>> +        * will end up sending encrypted mem to the gpu.
>>>> +        */
>>>> +       if (bdev->pool.use_dma_alloc &&
>>>> cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>>> You need to use CC_ATTR_GUEST_MEM_ENCRYPT here rather than
>>> CC_ATTR_MEM_ENCRYPT to avoid touching and breaking the SME case and
>>> only
>>> fix the SEV / SEV-ES case. I'd also hold off the stable inclusion
>>> until
>>> it's completely verified that this doesn't break anything because if
>>> it
>>> does, I suspect all hell will break loose.
>>>
>>> With that said, for the functionality
>>>
>>> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>
>>> But I think this needs a wider Ack at the ttm / drm level for the
>>> approach taken.
>>>
>>> /Thomas.
>> FWIW, I think that if TTM_TT_FLAG_DECRYPTED is set, it should be
>> possible to add a debug WARN_ON_ONCE() if the first PTE of the dma
>> page's kernel virtual address does not use a decrypted pgprot_t. One
>> way of accessing the PTEs in a platform-generic fashion is
>> apply_to_page_range().
> Good point.
>
> Another, trivial solution to that problem of possible regression would simply be
> introducing:
>
> #define TTM_DEVICE_USE_DMA_ALLOC          BIT(0)
> #define TTM_DEVICE_USE_GFP_DMA32          BIT(1)
> #define TTM_DEVICE_USE_DECRYPTED_SYS_MEM  BIT(2)
>
> and changing ttm_device_init from:
>
> int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *funcs,
> 		    struct device *dev, struct address_space *mapping,
> 		    struct drm_vma_offset_manager *vma_manager,
> 		    bool use_dma_alloc, bool use_dma32);
> to:
> int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *funcs,
> 		    struct device *dev, struct address_space *mapping,
> 		    struct drm_vma_offset_manager *vma_manager,
> 		    u32 use_flags);
>
> The driver should have a lot clearer picture of whether
> TTM_DEVICE_USE_DECRYPTED_SYS_MEM should be used. That change requires porting the
> drivers to the new ttm_device_init (which is trivial) but guarantees no regressions
> simply by virture of having vmwgfx use TTM_DEVICE_USE_DECRYPTED_SYS_MEM only (at
> least initially, I imagine at least qxl would need it as well).

I've been thinking along those lines as well. But the current direction 
appears to be to hide all of the encryption interaction in the dma 
layer, so when / once we do it right, those driver overrides will 
probably cause even more grief.

/Thomas


>
> Christian, any thoughts?
>
> z
