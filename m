Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86CB783764
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjHVBcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjHVBco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:32:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFBC101
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692667962; x=1724203962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HdoVJOe6WW5DpqEDgj81IB0yoiTd7hbmfF33SK2xsoE=;
  b=gDQWulmH5mwxBv6hTrewcAwOYoxHJCP4Ig+RzADSGrDPfjD8RQplE2Yp
   s5oqmN+yA+KMjr8N0QbCW2qkf3ktFjkRypQ19EKb6VSY/+Ifrol7dpdWj
   ByK4y7wnP/PDg2y44IsEssl2TrUPs+PGfAGNMsrMsGLLR1Vdb6fEAGVH8
   vl5XwDocyYtOxU354qI7QyIXlyLHvjqeM5D+Gd4HHRMV8N41dV5NF69bX
   Hnr1IalItQxKTmwIFftDnByBtMy/lyU4B1G5X5jXSll2EgAtfm9w4T0rw
   cnUyWJM2E+pwlx7mgs++qUQ99b36RAzK5FQAVXXrrE4pR3bWqD8a22uiB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="460120043"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="460120043"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 18:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685865351"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="685865351"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2023 18:32:19 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYGFi-0001AB-0F;
        Tue, 22 Aug 2023 01:32:15 +0000
Date:   Tue, 22 Aug 2023 09:31:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        nouveau@lists.freedesktop.org, Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next 2/3] drm/gpuva_mgr: generalize
 dma_resv/extobj handling and GEM validation
Message-ID: <202308220935.ik8QPkf4-lkp@intel.com>
References: <20230820215320.4187-3-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820215320.4187-3-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 25205087df1ffe06ccea9302944ed1f77dc68c6f]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-drm_exec-build-always-builtin/20230821-123143
base:   25205087df1ffe06ccea9302944ed1f77dc68c6f
patch link:    https://lore.kernel.org/r/20230820215320.4187-3-dakr%40redhat.com
patch subject: [PATCH drm-misc-next 2/3] drm/gpuva_mgr: generalize dma_resv/extobj handling and GEM validation
config: i386-randconfig-r024-20230822 (https://download.01.org/0day-ci/archive/20230822/202308220935.ik8QPkf4-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308220935.ik8QPkf4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308220935.ik8QPkf4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gpuva_mgr.c:750:1: warning: no previous prototype for function 'drm_gpuva_manager_prepare_objects' [-Wmissing-prototypes]
   drm_gpuva_manager_prepare_objects(struct drm_gpuva_manager *mgr,
   ^
   drivers/gpu/drm/drm_gpuva_mgr.c:749:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   drivers/gpu/drm/drm_gpuva_mgr.c:1744:32: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
           struct drm_gpuva *va, *next, *prev = NULL;
                                         ^
   2 warnings generated.
--
>> drivers/gpu/drm/drm_gpuva_mgr.c:1091: warning: Function parameter or member '__vm_bo' not described in 'drm_gpuva_gem_obtain_prealloc'


vim +/drm_gpuva_manager_prepare_objects +750 drivers/gpu/drm/drm_gpuva_mgr.c

   734	
   735	/**
   736	 * drm_gpuva_manager_prepare_objects() - prepare all assoiciated BOs
   737	 * @mgr: the &drm_gpuva_manager
   738	 * @num_fences: the amount of &dma_fences to reserve
   739	 *
   740	 * Calls drm_exec_prepare_obj() for all &drm_gem_objects the given
   741	 * &drm_gpuva_manager contains mappings of.
   742	 *
   743	 * Drivers can obtain the corresponding &drm_exec instance through
   744	 * DRM_GPUVA_EXEC(). It is the drivers responsibility to call drm_exec_init()
   745	 * and drm_exec_fini() accordingly.
   746	 *
   747	 * Returns: 0 on success, negative error code on failure.
   748	 */
   749	int
 > 750	drm_gpuva_manager_prepare_objects(struct drm_gpuva_manager *mgr,
   751					  unsigned int num_fences)
   752	{
   753		struct drm_exec *exec = DRM_GPUVA_EXEC(mgr);
   754		MA_STATE(mas, &mgr->mt_ext, 0, 0);
   755		union {
   756			void *ptr;
   757			uintptr_t cnt;
   758		} ref;
   759		int ret;
   760	
   761		ret = drm_exec_prepare_obj(exec, &mgr->d_obj, num_fences);
   762		if (ret)
   763			goto out;
   764	
   765		rcu_read_lock();
   766		mas_for_each(&mas, ref.ptr, ULONG_MAX) {
   767			struct drm_gem_object *obj;
   768	
   769			mas_pause(&mas);
   770			rcu_read_unlock();
   771	
   772			obj = (struct drm_gem_object *)(uintptr_t)mas.index;
   773			ret = drm_exec_prepare_obj(exec, obj, num_fences);
   774			if (ret)
   775				goto out;
   776	
   777			rcu_read_lock();
   778		}
   779		rcu_read_unlock();
   780	
   781	out:
   782		return ret;
   783	}
   784	EXPORT_SYMBOL_GPL(drm_gpuva_manager_prepare_objects);
   785	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
