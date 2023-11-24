Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93567F850B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346057AbjKXUEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjKXUEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:04:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFE8A4;
        Fri, 24 Nov 2023 12:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700856293; x=1732392293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NCnXLYGOPqhUuq5g4D00rGmocQWPsR60qAv9mGEqos=;
  b=c0QpepHdfi5HWeMUlNbQOATllzsPMc/08JPFBivR/RTvFua2NyRsJ2RW
   glsKwsKeiROqAdQf0DaaByIcyfO7jOvaz7gBoGrm1t6c6KL8nqpYGrn7u
   IKRZIyNsCU9bekAhpXiZlPZAdlpiW3BgzpQ+LTfl+kUDn4StNTjsDsPA7
   NNh1n5jM43FyT4QZoC0TXAtH6i4wVqsFnvu+IXEGAHkercA8Jr9PeWAWz
   Appj6PBNXSNDpRSMkWBhnTnz/joc18rV46AJzrLKdcjyleYbFIaHwhcG7
   l4iQGW9GTcH85ED/AxPfxZu2DxJ1ZtpHdCuFigbXK1qbJDm86reG7BHLC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="392225839"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="392225839"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="761031432"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="761031432"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2023 12:04:49 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6cPv-0003F9-07;
        Fri, 24 Nov 2023 20:04:47 +0000
Date:   Sat, 25 Nov 2023 04:04:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 1/3] driver core: move core part of device_shutdown()
 to a separate function
Message-ID: <202311250213.Ba7c2l5R-lkp@intel.com>
References: <20231124145338.3112416-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124145338.3112416-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/driver-core-move-core-part-of-device_shutdown-to-a-separate-function/20231124-225602
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20231124145338.3112416-2-o.rempel%40pengutronix.de
patch subject: [PATCH v1 1/3] driver core: move core part of device_shutdown() to a separate function
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231125/202311250213.Ba7c2l5R-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311250213.Ba7c2l5R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311250213.Ba7c2l5R-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/core.c:4731: warning: expecting prototype for device_shutdown_one(). Prototype was for device_shutdown_one_locked() instead


vim +4731 drivers/base/core.c

b8f33e5d76a7a1 Christian Brauner  2020-02-27  4721  
37b0c020343080 Greg Kroah-Hartman 2007-11-26  4722  /**
52950bfb3bedfc Oleksij Rempel     2023-11-24  4723   * device_shutdown_one - shut down a device
52950bfb3bedfc Oleksij Rempel     2023-11-24  4724   * @dev: device to shut down
52950bfb3bedfc Oleksij Rempel     2023-11-24  4725   *
52950bfb3bedfc Oleksij Rempel     2023-11-24  4726   * It is called with the device lock held.
52950bfb3bedfc Oleksij Rempel     2023-11-24  4727   *
52950bfb3bedfc Oleksij Rempel     2023-11-24  4728   * The device must be on the devices_kset list.
37b0c020343080 Greg Kroah-Hartman 2007-11-26  4729   */
52950bfb3bedfc Oleksij Rempel     2023-11-24  4730  static void device_shutdown_one_locked(struct device *dev)
37b0c020343080 Greg Kroah-Hartman 2007-11-26 @4731  {
52950bfb3bedfc Oleksij Rempel     2023-11-24  4732  	struct device *parent;
d1c6c030fcec6f Ming Lei           2012-06-22  4733  
52950bfb3bedfc Oleksij Rempel     2023-11-24  4734  	lockdep_assert_held(&devices_kset->list_lock);
d1c6c030fcec6f Ming Lei           2012-06-22  4735  	/*
d1c6c030fcec6f Ming Lei           2012-06-22  4736  	 * hold reference count of device's parent to
d1c6c030fcec6f Ming Lei           2012-06-22  4737  	 * prevent it from being freed because parent's
d1c6c030fcec6f Ming Lei           2012-06-22  4738  	 * lock is to be held
d1c6c030fcec6f Ming Lei           2012-06-22  4739  	 */
f123db8e9d6c84 Benson Leung       2013-09-24  4740  	parent = get_device(dev->parent);
6245838fe4d2ce Hugh Daschbach     2010-03-22  4741  	get_device(dev);
6245838fe4d2ce Hugh Daschbach     2010-03-22  4742  	/*
6245838fe4d2ce Hugh Daschbach     2010-03-22  4743  	 * Make sure the device is off the kset list, in the
6245838fe4d2ce Hugh Daschbach     2010-03-22  4744  	 * event that dev->*->shutdown() doesn't remove it.
6245838fe4d2ce Hugh Daschbach     2010-03-22  4745  	 */
6245838fe4d2ce Hugh Daschbach     2010-03-22  4746  	list_del_init(&dev->kobj.entry);
6245838fe4d2ce Hugh Daschbach     2010-03-22  4747  	spin_unlock(&devices_kset->list_lock);
fe6b91f47080eb Alan Stern         2011-12-06  4748  
d1c6c030fcec6f Ming Lei           2012-06-22  4749  	/* hold lock to avoid race with probe/release */
f123db8e9d6c84 Benson Leung       2013-09-24  4750  	if (parent)
f123db8e9d6c84 Benson Leung       2013-09-24  4751  		device_lock(parent);
d1c6c030fcec6f Ming Lei           2012-06-22  4752  	device_lock(dev);
d1c6c030fcec6f Ming Lei           2012-06-22  4753  
fe6b91f47080eb Alan Stern         2011-12-06  4754  	/* Don't allow any more runtime suspends */
fe6b91f47080eb Alan Stern         2011-12-06  4755  	pm_runtime_get_noresume(dev);
fe6b91f47080eb Alan Stern         2011-12-06  4756  	pm_runtime_barrier(dev);
37b0c020343080 Greg Kroah-Hartman 2007-11-26  4757  
7521621e600aee Michal Suchanek    2017-08-11  4758  	if (dev->class && dev->class->shutdown_pre) {
f77af151658474 Josh Zimmerman     2017-06-25  4759  		if (initcall_debug)
7521621e600aee Michal Suchanek    2017-08-11  4760  			dev_info(dev, "shutdown_pre\n");
7521621e600aee Michal Suchanek    2017-08-11  4761  		dev->class->shutdown_pre(dev);
7521621e600aee Michal Suchanek    2017-08-11  4762  	}
7521621e600aee Michal Suchanek    2017-08-11  4763  	if (dev->bus && dev->bus->shutdown) {
0246c4fafccd6c ShuoX Liu          2012-11-23  4764  		if (initcall_debug)
0246c4fafccd6c ShuoX Liu          2012-11-23  4765  			dev_info(dev, "shutdown\n");
37b0c020343080 Greg Kroah-Hartman 2007-11-26  4766  		dev->bus->shutdown(dev);
37b0c020343080 Greg Kroah-Hartman 2007-11-26  4767  	} else if (dev->driver && dev->driver->shutdown) {
0246c4fafccd6c ShuoX Liu          2012-11-23  4768  		if (initcall_debug)
0246c4fafccd6c ShuoX Liu          2012-11-23  4769  			dev_info(dev, "shutdown\n");
37b0c020343080 Greg Kroah-Hartman 2007-11-26  4770  		dev->driver->shutdown(dev);
37b0c020343080 Greg Kroah-Hartman 2007-11-26  4771  	}
d1c6c030fcec6f Ming Lei           2012-06-22  4772  
d1c6c030fcec6f Ming Lei           2012-06-22  4773  	device_unlock(dev);
f123db8e9d6c84 Benson Leung       2013-09-24  4774  	if (parent)
f123db8e9d6c84 Benson Leung       2013-09-24  4775  		device_unlock(parent);
d1c6c030fcec6f Ming Lei           2012-06-22  4776  
6245838fe4d2ce Hugh Daschbach     2010-03-22  4777  	put_device(dev);
f123db8e9d6c84 Benson Leung       2013-09-24  4778  	put_device(parent);
6245838fe4d2ce Hugh Daschbach     2010-03-22  4779  
6245838fe4d2ce Hugh Daschbach     2010-03-22  4780  	spin_lock(&devices_kset->list_lock);
37b0c020343080 Greg Kroah-Hartman 2007-11-26  4781  }
52950bfb3bedfc Oleksij Rempel     2023-11-24  4782  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
