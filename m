Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1577ECBC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbjHPWIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346750AbjHPWIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:08:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3AB2705
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692223696; x=1723759696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lll5KAQi4W7vfzba71CF5AHgH0JmiwGvHE7bYnj7pIw=;
  b=Tvovckp8wkr6e7ktxcDpV5NbpVkk2/pVh6XHewYS8UhXSSB5RcbD5Tje
   B2t0ikB5iG5nELpNhnIRvXLlH6X/4Xj5YkdThOk+cinlDXvpE2Hx23nQp
   dKWksaSBX20nbV+5M2qWdLl8G9Yj/W3ImsLaiujI1Nvf9a7An+9tx2BVQ
   IzWfEZOl+iS6hEWWq7guc7HJw/vr1Jfwrjf+pHjTmxg7hEv3pPq5Y/hWT
   6yFn3PvBmqvTKb/pejlOAHbacusKdN+Vv+S2LWlFIawq7OoiEie7UDqsW
   jvouJo02mK151sPH+/mTdFo4cUtZPniCebA879vXUKZzNFlNHhEry5qV+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436550451"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="436550451"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 15:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824385593"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="824385593"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2023 15:08:13 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWOgW-0000bZ-1A;
        Wed, 16 Aug 2023 22:08:12 +0000
Date:   Thu, 17 Aug 2023 06:07:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH] driver core: shut down devices asynchronously
Message-ID: <202308170534.naCLTFzQ-lkp@intel.com>
References: <20230816154518.3487-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816154518.3487-1-stuart.w.hayes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stuart,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.5-rc6 next-20230816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stuart-Hayes/driver-core-shut-down-devices-asynchronously/20230816-234737
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20230816154518.3487-1-stuart.w.hayes%40gmail.com
patch subject: [PATCH] driver core: shut down devices asynchronously
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230817/202308170534.naCLTFzQ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170534.naCLTFzQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308170534.naCLTFzQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/core.c:4762:6: warning: no previous prototype for 'shutdown_dev_work' [-Wmissing-prototypes]
    4762 | void shutdown_dev_work(struct work_struct *work)
         |      ^~~~~~~~~~~~~~~~~


vim +/shutdown_dev_work +4762 drivers/base/core.c

  4761	
> 4762	void shutdown_dev_work(struct work_struct *work)
  4763	{
  4764		struct shutdown_work *sd_work = container_of(work, struct shutdown_work, work);
  4765		struct shutdown_work *child_sd_work;
  4766		struct device *dev = sd_work->dev;
  4767	
  4768		/*
  4769		 * wait for child devices to finish shutdown
  4770		 */
  4771		list_for_each_entry(child_sd_work, &sd_work->children, node) {
  4772			wait_for_completion(&child_sd_work->complete);
  4773		}
  4774	
  4775		if (dev) {
  4776			/*
  4777			 * Make sure the device is off the kset list, in the
  4778			 * event that dev->*->shutdown() doesn't remove it.
  4779			 */
  4780			spin_lock(&devices_kset->list_lock);
  4781			list_del_init(&dev->kobj.entry);
  4782			spin_unlock(&devices_kset->list_lock);
  4783	
  4784			shutdown_device(dev, dev->parent);
  4785		}
  4786	
  4787		complete(&sd_work->complete);
  4788	}
  4789	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
