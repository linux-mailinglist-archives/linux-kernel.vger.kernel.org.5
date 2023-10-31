Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C67DC8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjJaIv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjJaIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:51:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D7FD8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698742314; x=1730278314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0rcELH9wTkygIGf5Hlhr+4M1BwdozgJqHutiY4kxTbE=;
  b=HKVkQIuQUgczvrLG0j03/UIw1S+vd78c8dp8bQQZJ4N1/LrfoESBp1ry
   htrRKNOJZdNBIC/U3nNNuMLVkp7llOGgpZOV2p4Mj6RL5wyEWLohyjcCm
   bGvNsgmgz0cWHNt0LhAIKxMAovCrrHbKb+unUV3cXlxeCyiITndtVzwVo
   SxgrWG2YF86bQ56Uegh7NV8NV7zVfOnoGWH6oh3iKr7gk/nMRlu0Xp1pf
   4Y/jwyF96UBrRU03So6m0LYVWdgyv5aqPNzvTIgjt8lk/2EwG6dTURFmN
   Ofj0FPAz3YWVNuDKnZ5vuTGJ6/6N8/XD0Ujf6icX3WOudolnWlwyC+RM/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="368449899"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="368449899"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789723342"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="789723342"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 Oct 2023 01:51:34 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxkTE-000040-1B;
        Tue, 31 Oct 2023 08:51:32 +0000
Date:   Tue, 31 Oct 2023 16:51:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        boris.brezillon@collabora.com, christian.koenig@amd.com,
        faith@gfxstrand.net, luben.tuikov@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v4] drm/sched: implement dynamic job-flow
 control
Message-ID: <202310311632.RpEHvHMk-lkp@intel.com>
References: <20231031002655.38707-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031002655.38707-1-dakr@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build errors:

[auto build test ERROR on b2139fb5051554a7f297e4ad584ef1bc26c76d5d]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-sched-implement-dynamic-job-flow-control/20231031-082915
base:   b2139fb5051554a7f297e4ad584ef1bc26c76d5d
patch link:    https://lore.kernel.org/r/20231031002655.38707-1-dakr%40redhat.com
patch subject: [PATCH drm-misc-next v4] drm/sched: implement dynamic job-flow control
config: loongarch-randconfig-002-20231031 (https://download.01.org/0day-ci/archive/20231031/202310311632.RpEHvHMk-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310311632.RpEHvHMk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310311632.RpEHvHMk-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/etnaviv/etnaviv_gpu.c: In function 'etnaviv_gpu_rpm_suspend':
>> drivers/gpu/drm/etnaviv/etnaviv_gpu.c:1920:36: error: 'struct drm_gpu_scheduler' has no member named 'hw_rq_count'
    1920 |         if (atomic_read(&gpu->sched.hw_rq_count))
         |                                    ^


vim +1920 drivers/gpu/drm/etnaviv/etnaviv_gpu.c

a8c21a5451d831 The etnaviv authors 2015-12-03  1913  
a8c21a5451d831 The etnaviv authors 2015-12-03  1914  static int etnaviv_gpu_rpm_suspend(struct device *dev)
a8c21a5451d831 The etnaviv authors 2015-12-03  1915  {
a8c21a5451d831 The etnaviv authors 2015-12-03  1916  	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
a8c21a5451d831 The etnaviv authors 2015-12-03  1917  	u32 idle, mask;
a8c21a5451d831 The etnaviv authors 2015-12-03  1918  
f4163814813fb3 Lucas Stach         2018-11-05  1919  	/* If there are any jobs in the HW queue, we're not idle */
f4163814813fb3 Lucas Stach         2018-11-05 @1920  	if (atomic_read(&gpu->sched.hw_rq_count))
a8c21a5451d831 The etnaviv authors 2015-12-03  1921  		return -EBUSY;
a8c21a5451d831 The etnaviv authors 2015-12-03  1922  
1a910c11d35bfa Guido Günther       2020-03-02  1923  	/* Check whether the hardware (except FE and MC) is idle */
1a910c11d35bfa Guido Günther       2020-03-02  1924  	mask = gpu->idle_mask & ~(VIVS_HI_IDLE_STATE_FE |
1a910c11d35bfa Guido Günther       2020-03-02  1925  				  VIVS_HI_IDLE_STATE_MC);
a8c21a5451d831 The etnaviv authors 2015-12-03  1926  	idle = gpu_read(gpu, VIVS_HI_IDLE_STATE) & mask;
78f2bfa3181cd7 Guido Günther       2020-03-02  1927  	if (idle != mask) {
78f2bfa3181cd7 Guido Günther       2020-03-02  1928  		dev_warn_ratelimited(dev, "GPU not yet idle, mask: 0x%08x\n",
78f2bfa3181cd7 Guido Günther       2020-03-02  1929  				     idle);
a8c21a5451d831 The etnaviv authors 2015-12-03  1930  		return -EBUSY;
78f2bfa3181cd7 Guido Günther       2020-03-02  1931  	}
a8c21a5451d831 The etnaviv authors 2015-12-03  1932  
7cb544946a138d Lucas Stach         2023-06-07  1933  	etnaviv_gpu_hw_suspend(gpu);
7cb544946a138d Lucas Stach         2023-06-07  1934  
647d817d807127 Lucas Stach         2023-06-07  1935  	gpu->state = ETNA_GPU_STATE_IDENTIFIED;
647d817d807127 Lucas Stach         2023-06-07  1936  
7cb544946a138d Lucas Stach         2023-06-07  1937  	return etnaviv_gpu_clk_disable(gpu);
a8c21a5451d831 The etnaviv authors 2015-12-03  1938  }
a8c21a5451d831 The etnaviv authors 2015-12-03  1939  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
