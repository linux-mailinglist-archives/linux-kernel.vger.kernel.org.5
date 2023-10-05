Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8DB7B9FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjJEOcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjJEO3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:29:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC51BF2;
        Thu,  5 Oct 2023 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513801; x=1728049801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zqJwU4dVi5etdviVMLZ9xCVCGN1GcyZWLjzWkRCQokk=;
  b=LQwsqXrLpIC+d2dmKw9+t8njQFjT8kgWf8JYXsDN3tazkabpPECV2KcX
   4W8Z+SGY0yNMNJuKCkuq0a68/g0rGYDjWYVI2Kg7uTmexJnVGnsbq/WEe
   ez/wFvwFO+n6oBfzWnW8gZxyIm8U2pEWp99L7ho+4AgWguVExqKH6ZPGq
   p/OwTiul7tC1ELXPBgKUXipJuXYHWqpGHoFtiMldgHU/ysTAZA0uGF8xL
   2MssYdC1C8dYvslPWhlVxNsnxsH7MVRZL3czfqOZeNFXCF47Nob5WKbaf
   WLpbjCkbpSiZSLzj6xfZ1ukz/cMqZCwGxvEorNtOoxAutVY1M7vXWc3Fj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383342461"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="383342461"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786874179"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="786874179"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Oct 2023 01:25:35 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoJfp-000LCC-0S;
        Thu, 05 Oct 2023 08:25:33 +0000
Date:   Thu, 5 Oct 2023 16:24:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v11 5/7] nvmem: core: Rework layouts to become regular
 devices
Message-ID: <202310051638.C8Yz2WIY-lkp@intel.com>
References: <20231004222236.411248-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004222236.411248-6-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.6-rc4 next-20231005]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/of-device-Export-of_device_make_bus_id/20231005-062417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231004222236.411248-6-miquel.raynal%40bootlin.com
patch subject: [PATCH v11 5/7] nvmem: core: Rework layouts to become regular devices
config: sh-defconfig (https://download.01.org/0day-ci/archive/20231005/202310051638.C8Yz2WIY-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310051638.C8Yz2WIY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310051638.C8Yz2WIY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvmem/layouts.c:19:5: warning: "CONFIG_OF" is not defined, evaluates to 0 [-Wundef]
      19 | #if CONFIG_OF
         |     ^~~~~~~~~


vim +/CONFIG_OF +19 drivers/nvmem/layouts.c

    18	
  > 19	#if CONFIG_OF
    20	static int nvmem_layout_bus_match(struct device *dev, struct device_driver *drv)
    21	{
    22		return of_driver_match_device(dev, drv);
    23	}
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
