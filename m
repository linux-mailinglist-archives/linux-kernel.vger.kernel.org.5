Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6287E0E0E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 07:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjKDGVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 02:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDGVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 02:21:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BA1184;
        Fri,  3 Nov 2023 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699078899; x=1730614899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fWXfOWmYj+Ds8e7KIPLMXDjCzFoz16RM+HQare7RBnQ=;
  b=OUF+WN3QJyOXjWcfgs7fKxz0sLTq8xeUw32yeB4N26G7U4Qjs1joQ547
   7d0l1aMA739MeqCm7LBEUvxGrM8JwOCHgILku6e7nn17rFqb13gAJHk0x
   SEKD/ujssn6+BXs77qffeXP1JlsySwQimhmZVaJKe5niIYofNe7iP9/4l
   kfJ2mpM7chKJAQQNF8ouNXZVgMPdlTCQxyJacVaaFlL5WRh9QDsdnh2qr
   RRgswJRsSHANtiFiFHP9l9oD/jLqeCfUT9XU7t84Bol6x6kUCg8GGi74C
   sFrNlCGXzC57HGPB1rPh3+hd3FAaP/uZZdBag5WVNYUb93vUP9swBhdor
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="369272430"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="369272430"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 23:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832230965"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="832230965"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2023 23:21:36 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzA2J-0003Y0-0E;
        Sat, 04 Nov 2023 06:21:35 +0000
Date:   Sat, 4 Nov 2023 14:20:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edward Adam Davis <eadavis@qq.com>, richardcochran@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
        habetsm.xilinx@gmail.com, jeremy@jcline.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V4] ptp: fix corrupted list in ptp_open
Message-ID: <202311041344.zDyYh5Ty-lkp@intel.com>
References: <tencent_8A38BBB333189E6E1B4A4B821BF82569BA08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8A38BBB333189E6E1B4A4B821BF82569BA08@qq.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/ptp-fix-corrupted-list-in-ptp_open/20231104-112916
base:   net-next/main
patch link:    https://lore.kernel.org/r/tencent_8A38BBB333189E6E1B4A4B821BF82569BA08%40qq.com
patch subject: [PATCH net-next V4] ptp: fix corrupted list in ptp_open
config: arc-randconfig-001-20231104 (https://download.01.org/0day-ci/archive/20231104/202311041344.zDyYh5Ty-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041344.zDyYh5Ty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041344.zDyYh5Ty-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/ptp/ptp_chardev.c: In function 'ptp_release':
>> drivers/ptp/ptp_chardev.c:148:23: warning: unused variable 'flags' [-Wunused-variable]
     148 |         unsigned long flags;
         |                       ^~~~~


vim +/flags +148 drivers/ptp/ptp_chardev.c

8f5de6fb245326 Xabier Marquiegui 2023-10-12  142  
8f5de6fb245326 Xabier Marquiegui 2023-10-12  143  int ptp_release(struct posix_clock_context *pccontext)
8f5de6fb245326 Xabier Marquiegui 2023-10-12  144  {
8f5de6fb245326 Xabier Marquiegui 2023-10-12  145  	struct timestamp_event_queue *queue = pccontext->private_clkdata;
f0e5eaa3097d80 Edward Adam Davis 2023-11-04  146  	struct ptp_clock *ptp =
f0e5eaa3097d80 Edward Adam Davis 2023-11-04  147  		container_of(pccontext->clk, struct ptp_clock, clock);
8f5de6fb245326 Xabier Marquiegui 2023-10-12 @148  	unsigned long flags;
8f5de6fb245326 Xabier Marquiegui 2023-10-12  149  
8f5de6fb245326 Xabier Marquiegui 2023-10-12  150  	if (queue) {
f0e5eaa3097d80 Edward Adam Davis 2023-11-04  151  		mutex_lock(&ptp->tsevq_mux);
403376ddb4221b Xabier Marquiegui 2023-10-12  152  		debugfs_remove(queue->debugfs_instance);
8f5de6fb245326 Xabier Marquiegui 2023-10-12  153  		pccontext->private_clkdata = NULL;
8f5de6fb245326 Xabier Marquiegui 2023-10-12  154  		list_del(&queue->qlist);
f0e5eaa3097d80 Edward Adam Davis 2023-11-04  155  		mutex_unlock(&ptp->tsevq_mux);
c5a445b1e9347b Xabier Marquiegui 2023-10-12  156  		bitmap_free(queue->mask);
8f5de6fb245326 Xabier Marquiegui 2023-10-12  157  		kfree(queue);
8f5de6fb245326 Xabier Marquiegui 2023-10-12  158  	}
d94ba80ebbea17 Richard Cochran   2011-04-22  159  	return 0;
d94ba80ebbea17 Richard Cochran   2011-04-22  160  }
d94ba80ebbea17 Richard Cochran   2011-04-22  161  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
