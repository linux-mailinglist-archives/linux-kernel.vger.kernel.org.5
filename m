Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD379804D56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjLEJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLEJOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:14:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52335C6;
        Tue,  5 Dec 2023 01:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701767681; x=1733303681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p4stTAxg/E6CGJ2w183041PPmkmXBFYcKXIEEcx8kFE=;
  b=OUrt7c0tLLosuC+vqix9tqnBMe0+pBiurEW4yj1i0h9VbUQwjS2AQzFn
   W1ejcxM9TirBehz6DUMuMBE0npy4NIw0I7hwr803DjKzyqzoTxnzEE4a1
   V7YNoW/29lKSqHwIQvQjwCBTZi+GVXFQ6PCMiiRaon3kqlI8aLkEAiBD5
   ZtoGswmuCG7N4KoLD8jUhHgXK4SMtzHcODOIdqIo/z0NtnKiRuUY3ujNu
   gD9D8WjaiAi4lshS6IxGT8DAHlfaleM5nT8wmyDDl2A30teHIZhU1EA7L
   Kfby9MMcwVYWxHz8YXQ4btSm25v/cExnwPV9Z0TOcxVwjWk3HiwBikEaA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="945185"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="945185"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1102389833"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="1102389833"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Dec 2023 01:14:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rARVc-0008dg-05;
        Tue, 05 Dec 2023 09:14:28 +0000
Date:   Tue, 5 Dec 2023 17:14:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org, xni@redhat.com,
        yukuai3@huawei.com, neilb@suse.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 md-fixes 3/3] md: fix stopping sync thread
Message-ID: <202312051758.ZlpYxGpJ-lkp@intel.com>
References: <20231204135732.3647886-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204135732.3647886-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on song-md/md-next]
[also build test WARNING on linus/master v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/md-fix-missing-flush-of-sync_work/20231204-215956
base:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
patch link:    https://lore.kernel.org/r/20231204135732.3647886-4-yukuai1%40huaweicloud.com
patch subject: [PATCH v4 md-fixes 3/3] md: fix stopping sync thread
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231205/202312051758.ZlpYxGpJ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051758.ZlpYxGpJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051758.ZlpYxGpJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/md/md.c: In function 'idle_sync_thread':
>> drivers/md/md.c:4897:13: warning: unused variable 'sync_seq' [-Wunused-variable]
    4897 |         int sync_seq = atomic_read(&mddev->sync_seq);
         |             ^~~~~~~~


vim +/sync_seq +4897 drivers/md/md.c

64e5e09afc14f8 Yu Kuai 2023-05-29  4894  
64e5e09afc14f8 Yu Kuai 2023-05-29  4895  static void idle_sync_thread(struct mddev *mddev)
64e5e09afc14f8 Yu Kuai 2023-05-29  4896  {
130443d60b1b8c Yu Kuai 2023-05-29 @4897  	int sync_seq = atomic_read(&mddev->sync_seq);
130443d60b1b8c Yu Kuai 2023-05-29  4898  
6f56f0c4f1241f Yu Kuai 2023-05-29  4899  	mutex_lock(&mddev->sync_mutex);
64e5e09afc14f8 Yu Kuai 2023-05-29  4900  	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
130443d60b1b8c Yu Kuai 2023-05-29  4901  
fde7b408a7cb14 Yu Kuai 2023-12-04  4902  	if (mddev_lock(mddev)) {
fde7b408a7cb14 Yu Kuai 2023-12-04  4903  		mutex_unlock(&mddev->sync_mutex);
fde7b408a7cb14 Yu Kuai 2023-12-04  4904  		return;
fde7b408a7cb14 Yu Kuai 2023-12-04  4905  	}
130443d60b1b8c Yu Kuai 2023-05-29  4906  
fde7b408a7cb14 Yu Kuai 2023-12-04  4907  	stop_sync_thread(mddev, false, true);
6f56f0c4f1241f Yu Kuai 2023-05-29  4908  	mutex_unlock(&mddev->sync_mutex);
64e5e09afc14f8 Yu Kuai 2023-05-29  4909  }
64e5e09afc14f8 Yu Kuai 2023-05-29  4910  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
