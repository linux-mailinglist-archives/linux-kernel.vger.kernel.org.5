Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959C177EE22
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 02:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbjHQAMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 20:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347225AbjHQAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 20:12:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDB5119
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692231124; x=1723767124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hEd2Il4Hy5IZnPTJYwBs+3HQvcw4UgZuNJe0WqbDbj0=;
  b=Y/8FVpt35cMnAQab85dB2BhF/+eWeaaDVka4iwb4Knu4vfTy7wKYTG+F
   TbE7IlbaXDEiyJ2y8ol453TD+/r0O1zEYwa3cHyq5cbDbphCJT4FWV0en
   u4qpUK3VVElt0wY0W72lWp27NILleSQgpI5jizzdHX9Suw3S22eukzW/F
   ndboJvULhn6J5xm6gVcOawfEDEh4tx5AuDRMxKW8iEJHhAZ4qSZgNGDFd
   Cn7cMA08rl6z6LhMRcISY6JMZJt5BtH2UPNUYMJihOQCC493DX5ICyrnW
   CULCZl8S0mWmIdqvVY+VEgefzZk0HO0UJS+On52sSeYCC4NULjEKXBQsQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372673770"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="372673770"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 17:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734431572"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="734431572"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2023 17:11:16 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWQbY-0000fL-2e;
        Thu, 17 Aug 2023 00:11:14 +0000
Date:   Thu, 17 Aug 2023 08:10:02 +0800
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
Message-ID: <202308170710.K525oxZ5-lkp@intel.com>
References: <20230816154518.3487-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816154518.3487-1-stuart.w.hayes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-defconfig (https://download.01.org/0day-ci/archive/20230817/202308170710.K525oxZ5-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170710.K525oxZ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308170710.K525oxZ5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/core.c:4762:6: warning: no previous declaration for 'shutdown_dev_work' [-Wmissing-declarations]
    void shutdown_dev_work(struct work_struct *work)
         ^~~~~~~~~~~~~~~~~


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
