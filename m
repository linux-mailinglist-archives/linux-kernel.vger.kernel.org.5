Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09187878FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbjHXTzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243229AbjHXTzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:55:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285C1BE6;
        Thu, 24 Aug 2023 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692906922; x=1724442922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHxd+sRQno+zlKMlOXPg8GU8rShd+SQCJ3iQuiwJQoA=;
  b=iqr37zVJlwf4CSAlXcHKqADe8xmuDJCGA26pe9jGasuKVcTu9QvhNnr6
   H/mjeF5MqmpHpFnkMxIg5N+hC7560b7CotTsDx68En8eUNEta7Y5B8Zpx
   hjuDPL0TlI2u6hJ1eQUGv3+Ga8kzUwBXB8IPmGFroXcbPgA3xlvMZYPe6
   dzyp2aqsP7pK27r4kNXVXszCwPY6KeqnWq+GqT59NXRgsea2lIC3qYtxT
   SoHI5+zlvBuT7lbvZySsVRq8fs44eWS2etrcF6g/wsKJCUFu5ulXKjCxM
   MXTOMMnpUDRGTiLqnFMvqfyBFaTNZABEgWSp13r+ry9tfQr5BJ9XybK3m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359543617"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359543617"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:55:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="740339883"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="740339883"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 24 Aug 2023 12:55:18 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZGQH-0002wA-1Q;
        Thu, 24 Aug 2023 19:55:17 +0000
Date:   Fri, 25 Aug 2023 03:54:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202308250317.taQ9kshJ-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230825/202308250317.taQ9kshJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308250317.taQ9kshJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308250317.taQ9kshJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/amba/bus.c: In function 'amba_device_release':
>> drivers/amba/bus.c:532:46: error: expected ')' before ';' token
     532 |         fwnode_handle_put(dev_fwnode(&d->dev);
         |                          ~                   ^
>> drivers/amba/bus.c:536:18: error: expected ';' before '}' token
     536 |         kfree(d);
         |                  ^
         |                  ;
     537 | }
         | ~                 


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
 > 536		kfree(d);
   537	}
   538	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
