Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB1277AACF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjHMTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjHMTKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:10:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05742EA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691953844; x=1723489844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xg4mFYd0bSzUJ6T2rDTewtz03S+l8kY6TLXsMswBTio=;
  b=BW5xKKbwSEbtvZ5FFLRdFahvRM4T1cIWM7XXg3jlNzgt5ztn+IZf8ery
   JCyYHF/y4Xt4hNhRBMqZLAVXimdR1q+cP+url0qM1f1An+im7GENcS+4s
   /Z2EDXVGCS6FqBrzpRBgGX/k7tHV2odrX2TaGOwxboEsJWRg5LRZVf+38
   eWMbJw58SuEMuqTztV7/7rS79H2JYkW6+Due+YJqRYBr6Y35T6osLe1R5
   Y5z/6h5OeIJioy67VxXKLIq7cGxebO3DkDcWAAySVPEXewU7xafeHcx/m
   TmFbAD1mM227nPMm2a6BchvFLGyyRcu9xzbAi792Uu/NMqfd2PoFnj5FU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="438249037"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="438249037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 12:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="733216691"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="733216691"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2023 12:10:40 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVGU4-0009C4-22;
        Sun, 13 Aug 2023 19:10:40 +0000
Date:   Mon, 14 Aug 2023 03:10:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [RESEND v3 4/5] drm/amdgpu: Move coredump code to amdgpu_reset
 file
Message-ID: <202308140200.o4DoWaAQ-lkp@intel.com>
References: <20230810192330.198326-5-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810192330.198326-5-andrealmeid@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/drm-amdgpu-Create-a-module-param-to-disable-soft-recovery/20230811-032440
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230810192330.198326-5-andrealmeid%40igalia.com
patch subject: [RESEND v3 4/5] drm/amdgpu: Move coredump code to amdgpu_reset file
config: alpha-randconfig-r062-20230814 (https://download.01.org/0day-ci/archive/20230814/202308140200.o4DoWaAQ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230814/202308140200.o4DoWaAQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308140200.o4DoWaAQ-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:228:12-19: WARNING: kzalloc should be used for 
    
>> 	 coredump  , instead of kmalloc/memset

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
