Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F633770BC1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjHDWJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHDWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:09:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40455E4D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691186992; x=1722722992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/BS+Rvisp7L8UgJflJZ7ycoucyI445uJGyTgag8Swg=;
  b=W65I2iexxYuXqVfrDtGuNYOjfSV5eWqqe9G6DxF22h8jsYcEe+q/RJEO
   wXFDNiXwET5wfHp76QhyttfLMLGlpEfx1jjUuT3X754mVpqgj081l3ogh
   Kctm8ufkKqDYqM0o8Z90mTZOO4soRQ9/H5WuURKpQJV8UL7WqSTFrO6ea
   09qzVxD7Q+97FjASgNcvLDEVX0wfNjlm4/UNobzMJH/R+1Nw71Itka9oQ
   ZzDOq1gpvLWz1E50FTfBkM2F0Ei00m8sW/49x3TjJGUZCvuBwISUg2yN3
   HO54E3A6r2VVJeqheNR3p83njOH19ylb/qt4RvlI1nz2kR8M5H2Sb7nZB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="401215262"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="401215262"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 15:09:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="765297877"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="765297877"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 15:09:46 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS2zT-00038h-0n;
        Fri, 04 Aug 2023 22:09:47 +0000
Date:   Sat, 5 Aug 2023 06:09:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org,
        ivan.orlov0322@gmail.com
Subject: Re: [PATCH] staging: greybus: Refactor gb_audio_gb_get_topology()
 into separate calls
Message-ID: <202308050511.y5Yb9otW-lkp@intel.com>
References: <20230804203134.GA618419@madhu-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804203134.GA618419@madhu-kernel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Madhumitha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Madhumitha-Prabakaran/staging-greybus-Refactor-gb_audio_gb_get_topology-into-separate-calls/20230805-043242
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20230804203134.GA618419%40madhu-kernel
patch subject: [PATCH] staging: greybus: Refactor gb_audio_gb_get_topology() into separate calls
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230805/202308050511.y5Yb9otW-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308050511.y5Yb9otW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308050511.y5Yb9otW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/staging/greybus/audio_gb.c:11:5: warning: no previous prototype for 'gb_audio_gb_get_topology_size' [-Wmissing-prototypes]
      11 | int gb_audio_gb_get_topology_size(struct gb_connection *connection, u16 *size)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/greybus/audio_gb.c:25:27: warning: no previous prototype for 'gb_audio_gb_alloc_topology' [-Wmissing-prototypes]
      25 | struct gb_audio_topology *gb_audio_gb_alloc_topology(u16 size)
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/gb_audio_gb_get_topology_size +11 drivers/staging/greybus/audio_gb.c

    10	
  > 11	int gb_audio_gb_get_topology_size(struct gb_connection *connection, u16 *size)
    12	{
    13	    struct gb_audio_get_topology_size_response size_resp;
    14	    int ret;
    15	
    16	    ret = gb_operation_sync(connection, GB_AUDIO_TYPE_GET_TOPOLOGY_SIZE,
    17	                            NULL, 0, &size_resp, sizeof(size_resp));
    18	    if (ret)
    19	        return ret;
    20	
    21	    *size = le16_to_cpu(size_resp.size);
    22	    return 0;
    23	}
    24	
  > 25	struct gb_audio_topology *gb_audio_gb_alloc_topology(u16 size)
    26	{
    27	    struct gb_audio_topology *topo;
    28	
    29	    if (size < sizeof(struct gb_audio_topology))
    30	        return NULL;
    31	
    32	    topo = kzalloc(size, GFP_KERNEL);
    33	    return topo;
    34	}
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
