Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9D879986B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjIINMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 09:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjIINM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 09:12:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF58819C;
        Sat,  9 Sep 2023 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694265144; x=1725801144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15t7zWA9xu82ZCsQXv78V6pCDtb/+pClxIL7uf0dfsk=;
  b=TXFxw1n7C6Uhh8VgWrmHxr0u3qJKHVx8B7ppEc2faeRmY7e226UwgkwX
   9v0PYmWqJs3tYIXocAgTpGWoa6bddZQGcINjq3TIuRmjM9kXkXL7Jc0bi
   bPg3zKPA624ngI2iuCjFsWqUzIYhaGq/pgkYQccuoSmJXRiPEtObNSbDV
   h9qFXeAEh56YoxrYoU7kHg7BFYYt36NcJa324l9dR9fwfhnNhrBKRFlXL
   ZGmnLIaEPEkoe59R8WSbuZU0Zgkrqrmgqjpqu89LbKSuy0xlflD47zaC3
   YXH+ySAWrn0zToBGXhqlpyJVKFqqsNIl55SUWprRUp35NGetj72MEX0df
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376728905"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="376728905"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 06:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="866407085"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="866407085"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Sep 2023 06:12:21 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qexl5-0003Wz-1J;
        Sat, 09 Sep 2023 13:12:19 +0000
Date:   Sat, 9 Sep 2023 21:12:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, linus.walleij@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: pinmux: Use dev_err_probe() in pin_request()
Message-ID: <202309092056.azXQNtDr-lkp@intel.com>
References: <20230909063613.2867-3-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909063613.2867-3-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next linus/master v6.5 next-20230908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jernej-Skrabec/pinctrl-pinmux-Remove-duplicate-error-message-in-pin_request/20230909-143817
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230909063613.2867-3-jernej.skrabec%40gmail.com
patch subject: [PATCH 2/2] pinctrl: pinmux: Use dev_err_probe() in pin_request()
config: arm-randconfig-001-20230909 (https://download.01.org/0day-ci/archive/20230909/202309092056.azXQNtDr-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309092056.azXQNtDr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309092056.azXQNtDr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/pinmux.c:191:31: warning: incompatible pointer to integer conversion passing 'char[23]' to parameter of type 'int' [-Wint-conversion]
                   dev_err_probe(pctldev->dev, "pin-%d (%s) status %d\n",
                                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1218:64: note: passing argument to parameter 'err' here
   __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
                                                                  ^
>> drivers/pinctrl/pinmux.c:192:10: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'const char *' [-Wint-conversion]
                                 pin, owner, status);
                                 ^~~
   include/linux/device.h:1218:81: note: passing argument to parameter 'fmt' here
   __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
                                                                                   ^
   2 warnings generated.


vim +191 drivers/pinctrl/pinmux.c

   101	
   102	/**
   103	 * pin_request() - request a single pin to be muxed in, typically for GPIO
   104	 * @pctldev: the associated pin controller device
   105	 * @pin: the pin number in the global pin space
   106	 * @owner: a representation of the owner of this pin; typically the device
   107	 *	name that controls its mux function, or the requested GPIO name
   108	 * @gpio_range: the range matching the GPIO pin if this is a request for a
   109	 *	single GPIO pin
   110	 */
   111	static int pin_request(struct pinctrl_dev *pctldev,
   112			       int pin, const char *owner,
   113			       struct pinctrl_gpio_range *gpio_range)
   114	{
   115		struct pin_desc *desc;
   116		const struct pinmux_ops *ops = pctldev->desc->pmxops;
   117		int status = -EINVAL;
   118	
   119		desc = pin_desc_get(pctldev, pin);
   120		if (desc == NULL) {
   121			dev_err(pctldev->dev,
   122				"pin %d is not registered so it cannot be requested\n",
   123				pin);
   124			goto out;
   125		}
   126	
   127		dev_dbg(pctldev->dev, "request pin %d (%s) for %s\n",
   128			pin, desc->name, owner);
   129	
   130		if ((!gpio_range || ops->strict) &&
   131		    desc->mux_usecount && strcmp(desc->mux_owner, owner)) {
   132			dev_err(pctldev->dev,
   133				"pin %s already requested by %s; cannot claim for %s\n",
   134				desc->name, desc->mux_owner, owner);
   135			goto out;
   136		}
   137	
   138		if ((gpio_range || ops->strict) && desc->gpio_owner) {
   139			dev_err(pctldev->dev,
   140				"pin %s already requested by %s; cannot claim for %s\n",
   141				desc->name, desc->gpio_owner, owner);
   142			goto out;
   143		}
   144	
   145		if (gpio_range) {
   146			desc->gpio_owner = owner;
   147		} else {
   148			desc->mux_usecount++;
   149			if (desc->mux_usecount > 1)
   150				return 0;
   151	
   152			desc->mux_owner = owner;
   153		}
   154	
   155		/* Let each pin increase references to this module */
   156		if (!try_module_get(pctldev->owner)) {
   157			dev_err(pctldev->dev,
   158				"could not increase module refcount for pin %d\n",
   159				pin);
   160			status = -EINVAL;
   161			goto out_free_pin;
   162		}
   163	
   164		/*
   165		 * If there is no kind of request function for the pin we just assume
   166		 * we got it by default and proceed.
   167		 */
   168		if (gpio_range && ops->gpio_request_enable)
   169			/* This requests and enables a single GPIO pin */
   170			status = ops->gpio_request_enable(pctldev, gpio_range, pin);
   171		else if (ops->request)
   172			status = ops->request(pctldev, pin);
   173		else
   174			status = 0;
   175	
   176		if (status)
   177			module_put(pctldev->owner);
   178	
   179	out_free_pin:
   180		if (status) {
   181			if (gpio_range) {
   182				desc->gpio_owner = NULL;
   183			} else {
   184				desc->mux_usecount--;
   185				if (!desc->mux_usecount)
   186					desc->mux_owner = NULL;
   187			}
   188		}
   189	out:
   190		if (status)
 > 191			dev_err_probe(pctldev->dev, "pin-%d (%s) status %d\n",
 > 192				      pin, owner, status);
   193	
   194		return status;
   195	}
   196	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
