Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D597879CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbjHXU7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242778AbjHXU7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:59:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1121BC2;
        Thu, 24 Aug 2023 13:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692910760; x=1724446760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8DEArnJeuB0FcMiUzS3W+pvVFOIM+/0b2Mg5YZ+yJ4U=;
  b=guvVqkeo3qgQ3vwQEg6ygBNtHfhMX/8rSEeMomXqnJAwEtAfNbzUtx5/
   0aGPrVyv2aHfzPJ9OzViEbPrcuMNqLk2R6lYAiQM6If+C1FsKUbEvctOe
   wEccIPkfceTJZnpvO/SKDZbJL6B9MNk/MjQo6lAUTMRzo4HPGFrr6moay
   xTv1mMmPH3xCgUzkWz52F/EEd4/9QYgDQoayeBojJ6LQFCTa8JfCz68Uy
   q5sLI9Lp4c0MIGPy6vjoHHubXMIoLAbTj1Yo0TNCo0Y0edNEXJGvFLyiH
   e+Rp6vY/v8aPUL+YJwyK1zoGdtc7ZEa8X3PS0fQAnfPbxSc6NiuVRf4j8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374535716"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374535716"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 13:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="766702088"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="766702088"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2023 13:59:15 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZHQA-0002xc-1L;
        Thu, 24 Aug 2023 20:59:14 +0000
Date:   Fri, 25 Aug 2023 04:59:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Len Brown <lenb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] amba: bus: balance firmware node reference
 counting
Message-ID: <202308250458.VwjoWF3t-lkp@intel.com>
References: <20230824162654.2890992-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824162654.2890992-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230824]
[cannot apply to rafael-pm/linux-next robh/for-next soc/for-next linus/master v6.5-rc7 v6.5-rc6 v6.5-rc5 v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/amba-bus-balance-firmware-node-reference-counting/20230825-003007
base:   next-20230824
patch link:    https://lore.kernel.org/r/20230824162654.2890992-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] amba: bus: balance firmware node reference counting
config: arm-randconfig-001-20230825 (https://download.01.org/0day-ci/archive/20230825/202308250458.VwjoWF3t-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308250458.VwjoWF3t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308250458.VwjoWF3t-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/amba/bus.c:532:39: error: expected ')'
     532 |         fwnode_handle_put(dev_fwnode(&d->dev);
         |                                              ^
   drivers/amba/bus.c:532:19: note: to match this '('
     532 |         fwnode_handle_put(dev_fwnode(&d->dev);
         |                          ^
   1 error generated.


vim +532 drivers/amba/bus.c

   527	
   528	static void amba_device_release(struct device *dev)
   529	{
   530		struct amba_device *d = to_amba_device(dev);
   531	
 > 532		fwnode_handle_put(dev_fwnode(&d->dev);
   533		if (d->res.parent)
   534			release_resource(&d->res);
   535		mutex_destroy(&d->periphid_lock);
   536		kfree(d);
   537	}
   538	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
