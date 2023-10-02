Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9A7B57A6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjJBPlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbjJBPlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:41:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8EFAC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696261267; x=1727797267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SDh69gAchoeUmTBcUVCtw20M7uUtrPDrCXD7/sO8i4g=;
  b=MAbYna6LNw7y0C5kOnncPWbmi/6UhHxC2xx5KvcqXkcdBbXyHbPrTydv
   tXzU2dHAnhKm7RyV1SKopPmdhVQ78iWF/OtgsYhby0D0FxP5OsvPtCbRJ
   U7gatSuqJWFGonVmaAn1NYcm6JhJoq0aYdcM6f/TfSO8+yS/45jEv0m9Q
   wePN2eX138mtjBp4aZ285BJyJ5BzSi71i3TRKRKJG6p7uwPbDja66tCEs
   gQ+QCqTKQn/oYoH0z4V49hHuL4GswEuP56RTP0Y2iI298ZEw3dxjRZSV5
   KA9mTL0n7WiA4k3FlKZ/+IGb/27/193o8ZiGfD0YBm+f1tOzL2dubdtXl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="379950226"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="379950226"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="727314202"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="727314202"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Oct 2023 08:41:02 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnL2a-0006A9-2D;
        Mon, 02 Oct 2023 15:41:00 +0000
Date:   Mon, 2 Oct 2023 23:40:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     oe-kbuild-all@lists.linux.dev, nouveau@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v5 4/6] drm/gpuvm: track/lock/validate
 external/evicted objects
Message-ID: <202310022331.lPOA8kRt-lkp@intel.com>
References: <20230928191624.13703-5-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928191624.13703-5-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a4ead6e37e3290cff399e2598d75e98777b69b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-gpuvm-add-common-dma-resv-per-struct-drm_gpuvm/20230929-031831
base:   a4ead6e37e3290cff399e2598d75e98777b69b37
patch link:    https://lore.kernel.org/r/20230928191624.13703-5-dakr%40redhat.com
patch subject: [PATCH drm-misc-next v5 4/6] drm/gpuvm: track/lock/validate external/evicted objects
reproduce: (https://download.01.org/0day-ci/archive/20231002/202310022331.lPOA8kRt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310022331.lPOA8kRt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./include/drm/drm_gpuvm.h:563: warning: Function parameter or member 'vm_exec' not described in 'drm_gpuvm_exec_unlock'
>> ./include/drm/drm_gpuvm.h:563: warning: expecting prototype for drm_gpuvm_lock(). Prototype was for drm_gpuvm_exec_unlock() instead
>> ./include/drm/drm_gpuvm.h:601: warning: expecting prototype for drm_gpuvm_exec_resv_add_fence(). Prototype was for drm_gpuvm_exec_validate() instead

vim +563 ./include/drm/drm_gpuvm.h

   527	
   528	int drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
   529				      struct drm_exec *exec,
   530				      unsigned int num_fences);
   531	
   532	int drm_gpuvm_prepare_range(struct drm_gpuvm *gpuvm,
   533				    struct drm_exec *exec,
   534				    u64 addr, u64 range,
   535				    unsigned int num_fences);
   536	
   537	int drm_gpuvm_exec_lock(struct drm_gpuvm_exec *vm_exec,
   538				unsigned int num_fences,
   539				bool interruptible);
   540	
   541	int drm_gpuvm_exec_lock_array(struct drm_gpuvm_exec *vm_exec,
   542				      struct drm_gem_object **objs,
   543				      unsigned int num_objs,
   544				      unsigned int num_fences,
   545				      bool interruptible);
   546	
   547	int drm_gpuvm_exec_lock_range(struct drm_gpuvm_exec *vm_exec,
   548				      u64 addr, u64 range,
   549				      unsigned int num_fences,
   550				      bool interruptible);
   551	
   552	/**
   553	 * drm_gpuvm_lock() - lock all dma-resv of all assoiciated BOs
   554	 * @gpuvm: the &drm_gpuvm
   555	 *
   556	 * Releases all dma-resv locks of all &drm_gem_objects previously acquired
   557	 * through drm_gpuvm_lock() or its variants.
   558	 *
   559	 * Returns: 0 on success, negative error code on failure.
   560	 */
   561	static inline void
   562	drm_gpuvm_exec_unlock(struct drm_gpuvm_exec *vm_exec)
 > 563	{
   564		drm_exec_fini(&vm_exec->exec);
   565	}
   566	
   567	int drm_gpuvm_validate(struct drm_gpuvm *gpuvm, struct drm_exec *exec);
   568	void drm_gpuvm_resv_add_fence(struct drm_gpuvm *gpuvm,
   569				      struct drm_exec *exec,
   570				      struct dma_fence *fence,
   571				      enum dma_resv_usage private_usage,
   572				      enum dma_resv_usage extobj_usage);
   573	
   574	/**
   575	 * drm_gpuvm_exec_resv_add_fence()
   576	 * @vm_exec: the &drm_gpuvm_exec abstraction
   577	 * @fence: fence to add
   578	 * @private_usage: private dma-resv usage
   579	 * @extobj_usage: extobj dma-resv usage
   580	 *
   581	 * See drm_gpuvm_resv_add_fence().
   582	 */
   583	static inline void
   584	drm_gpuvm_exec_resv_add_fence(struct drm_gpuvm_exec *vm_exec,
   585				      struct dma_fence *fence,
   586				      enum dma_resv_usage private_usage,
   587				      enum dma_resv_usage extobj_usage)
   588	{
   589		drm_gpuvm_resv_add_fence(vm_exec->vm, &vm_exec->exec, fence,
   590					 private_usage, extobj_usage);
   591	}
   592	
   593	/**
   594	 * drm_gpuvm_exec_resv_add_fence()
   595	 * @vm_exec: the &drm_gpuvm_exec abstraction
   596	 *
   597	 * See drm_gpuvm_validate().
   598	 */
   599	static inline int
   600	drm_gpuvm_exec_validate(struct drm_gpuvm_exec *vm_exec)
 > 601	{
   602		return drm_gpuvm_validate(vm_exec->vm, &vm_exec->exec);
   603	}
   604	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
