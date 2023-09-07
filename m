Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5CA796DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 02:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjIGANb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 20:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIGANa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:13:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BDF199F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 17:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694045605; x=1725581605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HB9WRsoIrlGJ+5WpybSh9YtkMLIYFIaTA1DHeFNa7II=;
  b=eKwDmPq6GRgT5xwCCHhiqyMEcAfnwa5r1lWvWEneKhwTtcVTDhz5VxIG
   6GptDFJAW75y9ncsj+GX4sRqjNpvQI8gJ9dug5R0AyikgZs/9LTiDjxoL
   s3vRVHXEHLcbmOkjmItH6QHgliJbvUbJPtY2YS+fa1j2v8IOoJM8hyqsN
   eb1G7Oy+LpbtwPuEwKDnsXYnASNtYqpM0Egsr0Ed2OM0v+wKCKdhSughu
   iAaLq8yeU6J/ILsu/Xr7IfOdPoqVACf1Th2qw9wVkm/dslvteNsDvO0X+
   ct/7zafhNmjl0tUbjaNVSRmK+NCKYVpdpQcWyMBT0Axlv+zdALdDxaCF8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357532055"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="357532055"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 17:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="1072624257"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="1072624257"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2023 17:13:22 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qe2e8-0000iv-0H;
        Thu, 07 Sep 2023 00:13:20 +0000
Date:   Thu, 7 Sep 2023 08:12:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, nouveau@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v2 6/7] drm/gpuvm: generalize
 dma_resv/extobj handling and GEM validation
Message-ID: <202309070844.arxMNmRa-lkp@intel.com>
References: <20230906214723.4393-7-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906214723.4393-7-dakr@redhat.com>
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

[auto build test WARNING on 6bd3d8da51ca1ec97c724016466606aec7739b9f]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-gpuva_mgr-allow-building-as-module/20230907-054931
base:   6bd3d8da51ca1ec97c724016466606aec7739b9f
patch link:    https://lore.kernel.org/r/20230906214723.4393-7-dakr%40redhat.com
patch subject: [PATCH drm-misc-next v2 6/7] drm/gpuvm: generalize dma_resv/extobj handling and GEM validation
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20230907/202309070844.arxMNmRa-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070844.arxMNmRa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070844.arxMNmRa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gpuva_mgr.c:998: warning: Function parameter or member 'exec' not described in 'drm_gpuvm_resv_add_fence'


vim +998 drivers/gpu/drm/drm_gpuva_mgr.c

   983	
   984	/**
   985	 * drm_gpuvm_resv_add_fence - add fence to private and all extobj
   986	 * dma-resv
   987	 * @gpuvm: the &drm_gpuvm to add a fence to
   988	 * @fence: fence to add
   989	 * @private_usage: private dma-resv usage
   990	 * @extobj_usage: extobj dma-resv usage
   991	 */
   992	void
   993	drm_gpuvm_resv_add_fence(struct drm_gpuvm *gpuvm,
   994				 struct drm_exec *exec,
   995				 struct dma_fence *fence,
   996				 enum dma_resv_usage private_usage,
   997				 enum dma_resv_usage extobj_usage)
 > 998	{
   999		struct drm_gem_object *obj;
  1000		unsigned long index;
  1001	
  1002		drm_exec_for_each_locked_object(exec, index, obj) {
  1003				dma_resv_assert_held(obj->resv);
  1004				dma_resv_add_fence(obj->resv, fence,
  1005						   drm_gpuvm_is_extobj(gpuvm, obj) ?
  1006						   private_usage : extobj_usage);
  1007		}
  1008	}
  1009	EXPORT_SYMBOL_GPL(drm_gpuvm_resv_add_fence);
  1010	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
