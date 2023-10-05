Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E347BA056
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjJEOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjJEOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281D12D4A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513854; x=1728049854;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s+8GEIU8kbyVPJj5X0oIaH9jUge71VFa1cd57LE7Cdg=;
  b=NNONXfoQFUD5nKMF6yRLtZwCyaVWvT4EnG+bEkdEWpxxpvw6T87RoWKd
   8tnWvL8ofI0xe9sQ0U7kcshtO681uM9OiC9tOlsSZLpjMWCbMEZe5FoaW
   B3uOtvE7phld58i1GJwpY7HpF2UvQQxlF+5ajU1dJ2EMTWtG+j2iM+CD9
   fU0kBydrpl4t6LHAq6ILV5w8SJii8kUuh43ze+ZEUpKW70ILF0LHcPW/V
   GIWG0vqIN87fHSDCh/tqih3Sb+4Qy+MiaOFVEoiJkHVQhFn6BLFY+bRTx
   WvCDHP4aPoQgEODeHnofiCsZCA3m/3sF5m79KoA7XbUiI6G8tDnKi6CLi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="368525743"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="368525743"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 02:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="822058580"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="822058580"
Received: from vstill-mobl.ger.corp.intel.com (HELO [10.249.254.26]) ([10.249.254.26])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 02:36:01 -0700
Message-ID: <95bfbf5c-286c-57a4-0170-19d775cf8d6b@linux.intel.com>
Date:   Thu, 5 Oct 2023 11:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v5 0/6] [RFC] DRM GPUVM features
Content-Language: en-US
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230928191624.13703-1-dakr@redhat.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20230928191624.13703-1-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Danilo

On 9/28/23 21:16, Danilo Krummrich wrote:
> Currently GPUVM offers common infrastructure to track GPU VA allocations
> and mappings, generically connect GPU VA mappings to their backing
> buffers and perform more complex mapping operations on the GPU VA space.
>
> However, there are more design patterns commonly used by drivers, which
> can potentially be generalized in order to make GPUVM represent the
> basis of a VM implementation. In this context, this patch series aims at
> generalizing the following elements.
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
> The implementation introduces struct drm_gpuvm_bo, which serves as abstraction
> combining a struct drm_gpuvm and struct drm_gem_object, similar to what
> amdgpu does with struct amdgpu_bo_vm. While this adds a bit of complexity it
> improves the efficiency of tracking external and evicted GEM objects.
>
> This patch series is also available at [3].
>
> [1] https://gitlab.freedesktop.org/nouvelles/kernel/-/commits/gpuvm-next
>
> Changes in V2:
> ==============
>    - rename 'drm_gpuva_manager' -> 'drm_gpuvm' which generally leads to more
>      consistent naming
>    - properly separate commits (introduce common dma-resv, drm_gpuvm_bo
>      abstraction, etc.)
>    - remove maple tree for tracking external objects, use a list drm_gpuvm_bos
>      per drm_gpuvm instead
>    - rework dma-resv locking helpers (Thomas)
>    - add a locking helper for a given range of the VA space (Christian)
>    - make the GPUVA manager buildable as module, rather than drm_exec
>      builtin (Christian)
>
> Changes in V3:
> ==============
>    - rename missing function and files (Boris)
>    - warn if vm_obj->obj != obj in drm_gpuva_link() (Boris)
>    - don't expose drm_gpuvm_bo_destroy() (Boris)
>    - unlink VM_BO from GEM in drm_gpuvm_bo_destroy() rather than
>      drm_gpuva_unlink() and link within drm_gpuvm_bo_obtain() to keep
>      drm_gpuvm_bo instances unique
>    - add internal locking to external and evicted object lists to support drivers
>      updating the VA space from within the fence signalling critical path (Boris)
>    - unlink external objects and evicted objects from the GPUVM's list in
>      drm_gpuvm_bo_destroy()
>    - add more documentation and fix some kernel doc issues
>
> Changes in V4:
> ==============
>    - add a drm_gpuvm_resv() helper (Boris)
>    - add a drm_gpuvm::<list_name>::local_list field (Boris)
>    - remove drm_gpuvm_bo_get_unless_zero() helper (Boris)
>    - fix missing NULL assignment in get_next_vm_bo_from_list() (Boris)
>    - keep a drm_gem_object reference on potential vm_bo destroy (alternatively we
>      could free the vm_bo and drop the vm_bo's drm_gem_object reference through
>      async work)
>    - introduce DRM_GPUVM_RESV_PROTECTED flag to indicate external locking through
>      the corresponding dma-resv locks to optimize for drivers already holding
>      them when needed; add the corresponding lock_assert_held() calls (Thomas)
>    - make drm_gpuvm_bo_evict() per vm_bo and add a drm_gpuvm_bo_gem_evict()
>      helper (Thomas)
>    - pass a drm_gpuvm_bo in drm_gpuvm_ops::vm_bo_validate() (Thomas)
>    - documentation fixes
>
> Changes in V5:
> ==============
>    - use a root drm_gem_object provided by the driver as a base for the VM's
>      common dma-resv (Christian)
>    - provide a helper to allocate a "dummy" root GEM object in case a driver
>      specific root GEM object isn't available
>    - add a dedicated patch for nouveau to make use of the GPUVM's shared dma-resv
>    - improve documentation (Boris)
>    - the following patches are removed from the series, since they already landed
>      in drm-misc-next
>      - f72c2db47080 ("drm/gpuvm: rename struct drm_gpuva_manager to struct drm_gpuvm")
>      - fe7acaa727e1 ("drm/gpuvm: allow building as module")
>      - 78f54469b871 ("drm/nouveau: uvmm: rename 'umgr' to 'base'")
>
> Danilo Krummrich (6):
>    drm/gpuvm: add common dma-resv per struct drm_gpuvm
>    drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm
>    drm/gpuvm: add an abstraction for a VM / BO combination
>    drm/gpuvm: track/lock/validate external/evicted objects
>    drm/nouveau: make use of the GPUVM's shared dma-resv
>    drm/nouveau: use GPUVM common infrastructure
>
>   drivers/gpu/drm/drm_gpuvm.c             | 1036 +++++++++++++++++++++--
>   drivers/gpu/drm/nouveau/nouveau_bo.c    |   15 +-
>   drivers/gpu/drm/nouveau/nouveau_bo.h    |    5 +
>   drivers/gpu/drm/nouveau/nouveau_exec.c  |   52 +-
>   drivers/gpu/drm/nouveau/nouveau_exec.h  |    4 -
>   drivers/gpu/drm/nouveau/nouveau_gem.c   |   10 +-
>   drivers/gpu/drm/nouveau/nouveau_sched.h |    4 +-
>   drivers/gpu/drm/nouveau/nouveau_uvmm.c  |  183 ++--
>   drivers/gpu/drm/nouveau/nouveau_uvmm.h  |    1 -
>   include/drm/drm_gem.h                   |   32 +-
>   include/drm/drm_gpuvm.h                 |  465 +++++++++-
>   11 files changed, 1625 insertions(+), 182 deletions(-)
>
>
> base-commit: a4ead6e37e3290cff399e2598d75e98777b69b37

One comment I had before on the GPUVM code in general was the licensing, 
but I'm not sure there was a reply. Is it possible to have this code 
dual MIT / GPLV2?

Thanks,

Thomas



