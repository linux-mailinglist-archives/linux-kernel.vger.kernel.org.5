Return-Path: <linux-kernel+bounces-39403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E704B83D073
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB1828F349
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D0E11C82;
	Thu, 25 Jan 2024 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwoJ4bBR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70736125B2;
	Thu, 25 Jan 2024 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224473; cv=none; b=Cf+0nmCq/ES7AE301f31hF3UyUy9qoF/+4tdRMyLAwHfOCxaL+kZAxIVdsVSwxxu29a4pO0klgUv9gbugfCNgcZkv7JHT3JuZwiSlJ0VNcL8Qp8BPPlIs7Q6T4PBFGfeHOf1WEn3uCYCSv5cjcnDD7eF71DZwoGcXw7UEVsnRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224473; c=relaxed/simple;
	bh=5TnZm/zMc/1hQRVbD/rLWhtDb4PubIr84zw4ArNpM/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ0TRaLHFhfkh74Lx3D6Zq9VgX9gmr2zVp0rncNOeqHaztnak+zPRCkT7O0DyTsdOY0OUQs7H3djYTVnWl4BFqaIvqyR8Uu8a2UbHROMuXHykZ63Gt2+cL1zecIOsBN/Ej1j4H29l3MP97HSXqeXf1CLdPF5TjRfrG2HI69ZghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwoJ4bBR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706224472; x=1737760472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5TnZm/zMc/1hQRVbD/rLWhtDb4PubIr84zw4ArNpM/A=;
  b=LwoJ4bBRFy6drI0b7aqwALsXbo/EdXd9aFa+Rc96WH7mM8Ru2vzvQt5c
   NeOCirwERif7e2kzDwKqQ4XB9x7W72pgMmN+a4Z7fKQ8wVBofsEZGYLbb
   TaPWJ+28W5nJXb9uTtMgUvv1KMWT3EtbXssY3OckmMkRYwMQlDR2AR+Je
   Ju8Zy8kMsGNGWuZDBSZj901befnkqMEq/B6iT4w4w3ALyFnZXQb1u0Igc
   N21l08EjmVUGqyqJdz7Ba1IzFf1fwUC45/VPz6z9Fd7MdvAHmQZu5p1Vp
   BNfAKO7UfdS1EU57g+BSA8CuaBbDFTd+jkuZMpDqpCkBR2fKUu4dwWFVj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15694663"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15694663"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:14:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910161510"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="910161510"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2024 15:14:24 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT8vN-0000UK-2R;
	Thu, 25 Jan 2024 23:14:21 +0000
Date: Fri, 26 Jan 2024 07:13:43 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Aleksandr Shubin <privatesub2@gmail.com>,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	John Watts <contact@jookia.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <202401260632.l2X5DTxa-lkp@intel.com>
References: <20240125072032.1151383-3-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125072032.1151383-3-privatesub2@gmail.com>

Hi Aleksandr,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on sunxi/sunxi/for-next linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksandr-Shubin/dt-bindings-pwm-Add-binding-for-Allwinner-D1-T113-S3-R329-PWM-controller/20240125-152445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240125072032.1151383-3-privatesub2%40gmail.com
patch subject: [PATCH v7 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240126/202401260632.l2X5DTxa-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401260632.l2X5DTxa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401260632.l2X5DTxa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pwm/pwm-sun20i.c:288:10: error: 'const struct pwm_ops' has no member named 'owner'
     288 |         .owner = THIS_MODULE,
         |          ^~~~~
   In file included from include/linux/printk.h:6,
                    from include/linux/kernel.h:31,
                    from include/linux/clk.h:13,
                    from drivers/pwm/pwm-sun20i.c:14:
>> include/linux/init.h:186:21: error: initialization of 'int (*)(struct pwm_chip *, struct pwm_device *, struct pwm_state *)' from incompatible pointer type 'struct module *' [-Werror=incompatible-pointer-types]
     186 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/pwm/pwm-sun20i.c:288:18: note: in expansion of macro 'THIS_MODULE'
     288 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   include/linux/init.h:186:21: note: (near initialization for 'sun20i_pwm_ops.get_state')
     186 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/pwm/pwm-sun20i.c:288:18: note: in expansion of macro 'THIS_MODULE'
     288 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   include/linux/init.h:186:21: warning: initialized field overwritten [-Woverride-init]
     186 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/pwm/pwm-sun20i.c:288:18: note: in expansion of macro 'THIS_MODULE'
     288 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   include/linux/init.h:186:21: note: (near initialization for 'sun20i_pwm_ops.get_state')
     186 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/pwm/pwm-sun20i.c:288:18: note: in expansion of macro 'THIS_MODULE'
     288 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c:297:36: warning: 'struct platform_device' declared inside parameter list will not be visible outside of this definition or declaration
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^~~~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c: In function 'sun20i_pwm_probe':
>> drivers/pwm/pwm-sun20i.c:302:23: error: implicit declaration of function 'devm_kzalloc' [-Werror=implicit-function-declaration]
     302 |         sun20i_chip = devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERNEL);
         |                       ^~~~~~~~~~~~
>> drivers/pwm/pwm-sun20i.c:302:41: error: invalid use of undefined type 'struct platform_device'
     302 |         sun20i_chip = devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERNEL);
         |                                         ^~
>> drivers/pwm/pwm-sun20i.c:306:29: error: implicit declaration of function 'devm_platform_ioremap_resource' [-Werror=implicit-function-declaration]
     306 |         sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c:306:27: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     306 |         sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
         |                           ^
   drivers/pwm/pwm-sun20i.c:310:58: error: invalid use of undefined type 'struct platform_device'
     310 |         sun20i_chip->clk_bus = devm_clk_get_enabled(&pdev->dev, "bus");
         |                                                          ^~
>> drivers/pwm/pwm-sun20i.c:312:24: error: implicit declaration of function 'dev_err_probe' [-Werror=implicit-function-declaration]
     312 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
         |                        ^~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c:312:43: error: invalid use of undefined type 'struct platform_device'
     312 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
         |                                           ^~
   drivers/pwm/pwm-sun20i.c:315:59: error: invalid use of undefined type 'struct platform_device'
     315 |         sun20i_chip->clk_hosc = devm_clk_get_enabled(&pdev->dev, "hosc");
         |                                                           ^~
   drivers/pwm/pwm-sun20i.c:317:43: error: invalid use of undefined type 'struct platform_device'
     317 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
         |                                           ^~
   drivers/pwm/pwm-sun20i.c:320:59: error: invalid use of undefined type 'struct platform_device'
     320 |         sun20i_chip->clk_apb0 = devm_clk_get_enabled(&pdev->dev, "apb0");
         |                                                           ^~
   drivers/pwm/pwm-sun20i.c:322:43: error: invalid use of undefined type 'struct platform_device'
     322 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb0),
         |                                           ^~
   drivers/pwm/pwm-sun20i.c:325:66: error: invalid use of undefined type 'struct platform_device'
     325 |         sun20i_chip->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
         |                                                                  ^~
   drivers/pwm/pwm-sun20i.c:327:43: error: invalid use of undefined type 'struct platform_device'
     327 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
         |                                           ^~
   drivers/pwm/pwm-sun20i.c:330:40: error: invalid use of undefined type 'struct platform_device'
     330 |         ret = of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels",
         |                                        ^~
   drivers/pwm/pwm-sun20i.c:341:43: error: invalid use of undefined type 'struct platform_device'
     341 |                 return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");
         |                                           ^~
   drivers/pwm/pwm-sun20i.c:343:38: error: invalid use of undefined type 'struct platform_device'
     343 |         sun20i_chip->chip.dev = &pdev->dev;
         |                                      ^~
   drivers/pwm/pwm-sun20i.c:351:43: error: invalid use of undefined type 'struct platform_device'
     351 |                 return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
         |                                           ^~
>> drivers/pwm/pwm-sun20i.c:354:9: error: implicit declaration of function 'platform_set_drvdata' [-Werror=implicit-function-declaration]
     354 |         platform_set_drvdata(pdev, sun20i_chip);
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c: At top level:
   drivers/pwm/pwm-sun20i.c:359:38: warning: 'struct platform_device' declared inside parameter list will not be visible outside of this definition or declaration
     359 | static void sun20i_pwm_remove(struct platform_device *pdev)
         |                                      ^~~~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c: In function 'sun20i_pwm_remove':
>> drivers/pwm/pwm-sun20i.c:361:47: error: implicit declaration of function 'platform_get_drvdata' [-Werror=implicit-function-declaration]
     361 |         struct sun20i_pwm_chip *sun20i_chip = platform_get_drvdata(pdev);
         |                                               ^~~~~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c:361:47: warning: initialization of 'struct sun20i_pwm_chip *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/pwm/pwm-sun20i.c: At top level:
>> drivers/pwm/pwm-sun20i.c:368:15: error: variable 'sun20i_pwm_driver' has initializer but incomplete type
     368 | static struct platform_driver sun20i_pwm_driver = {
         |               ^~~~~~~~~~~~~~~
>> drivers/pwm/pwm-sun20i.c:369:10: error: 'struct platform_driver' has no member named 'driver'
     369 |         .driver = {
         |          ^~~~~~
>> drivers/pwm/pwm-sun20i.c:369:19: error: extra brace group at end of initializer
     369 |         .driver = {
         |                   ^
   drivers/pwm/pwm-sun20i.c:369:19: note: (near initialization for 'sun20i_pwm_driver')
   drivers/pwm/pwm-sun20i.c:369:19: warning: excess elements in struct initializer
   drivers/pwm/pwm-sun20i.c:369:19: note: (near initialization for 'sun20i_pwm_driver')
>> drivers/pwm/pwm-sun20i.c:373:10: error: 'struct platform_driver' has no member named 'probe'
     373 |         .probe = sun20i_pwm_probe,
         |          ^~~~~
   drivers/pwm/pwm-sun20i.c:373:18: warning: excess elements in struct initializer
     373 |         .probe = sun20i_pwm_probe,
         |                  ^~~~~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c:373:18: note: (near initialization for 'sun20i_pwm_driver')
>> drivers/pwm/pwm-sun20i.c:374:10: error: 'struct platform_driver' has no member named 'remove_new'
     374 |         .remove_new = sun20i_pwm_remove,
         |          ^~~~~~~~~~
   drivers/pwm/pwm-sun20i.c:374:23: warning: excess elements in struct initializer
     374 |         .remove_new = sun20i_pwm_remove,
         |                       ^~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c:374:23: note: (near initialization for 'sun20i_pwm_driver')
   drivers/pwm/pwm-sun20i.c:376:1: warning: data definition has no type or storage class
     376 | module_platform_driver(sun20i_pwm_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/pwm/pwm-sun20i.c:376:1: error: type defaults to 'int' in declaration of 'module_platform_driver' [-Werror=implicit-int]
   drivers/pwm/pwm-sun20i.c:376:1: warning: parameter names (without types) in function declaration
>> drivers/pwm/pwm-sun20i.c:368:31: error: storage size of 'sun20i_pwm_driver' isn't known
     368 | static struct platform_driver sun20i_pwm_driver = {
         |                               ^~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c:368:31: warning: 'sun20i_pwm_driver' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +288 drivers/pwm/pwm-sun20i.c

   284	
   285	static const struct pwm_ops sun20i_pwm_ops = {
   286		.get_state = sun20i_pwm_get_state,
   287		.apply = sun20i_pwm_apply,
 > 288		.owner = THIS_MODULE,
   289	};
   290	
   291	static const struct of_device_id sun20i_pwm_dt_ids[] = {
   292		{ .compatible = "allwinner,sun20i-d1-pwm" },
   293		{ },
   294	};
   295	MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
   296	
   297	static int sun20i_pwm_probe(struct platform_device *pdev)
   298	{
   299		struct sun20i_pwm_chip *sun20i_chip;
   300		int ret;
   301	
 > 302		sun20i_chip = devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERNEL);
   303		if (!sun20i_chip)
   304			return -ENOMEM;
   305	
 > 306		sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
   307		if (IS_ERR(sun20i_chip->base))
   308			return PTR_ERR(sun20i_chip->base);
   309	
   310		sun20i_chip->clk_bus = devm_clk_get_enabled(&pdev->dev, "bus");
   311		if (IS_ERR(sun20i_chip->clk_bus))
 > 312			return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
   313					     "failed to get bus clock\n");
   314	
   315		sun20i_chip->clk_hosc = devm_clk_get_enabled(&pdev->dev, "hosc");
   316		if (IS_ERR(sun20i_chip->clk_hosc))
   317			return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
   318					     "failed to get hosc clock\n");
   319	
   320		sun20i_chip->clk_apb0 = devm_clk_get_enabled(&pdev->dev, "apb0");
   321		if (IS_ERR(sun20i_chip->clk_apb0))
   322			return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb0),
   323					     "failed to get apb0 clock\n");
   324	
   325		sun20i_chip->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
   326		if (IS_ERR(sun20i_chip->rst))
   327			return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
   328					     "failed to get bus reset\n");
   329	
   330		ret = of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels",
   331					   &sun20i_chip->chip.npwm);
   332		if (ret)
   333			sun20i_chip->chip.npwm = 8;
   334	
   335		if (sun20i_chip->chip.npwm > 16)
   336			sun20i_chip->chip.npwm = 16;
   337	
   338		/* Deassert reset */
   339		ret = reset_control_deassert(sun20i_chip->rst);
   340		if (ret)
   341			return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");
   342	
   343		sun20i_chip->chip.dev = &pdev->dev;
   344		sun20i_chip->chip.ops = &sun20i_pwm_ops;
   345	
   346		mutex_init(&sun20i_chip->mutex);
   347	
   348		ret = pwmchip_add(&sun20i_chip->chip);
   349		if (ret < 0) {
   350			reset_control_assert(sun20i_chip->rst);
   351			return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
   352		}
   353	
 > 354		platform_set_drvdata(pdev, sun20i_chip);
   355	
   356		return 0;
   357	}
   358	
   359	static void sun20i_pwm_remove(struct platform_device *pdev)
   360	{
 > 361		struct sun20i_pwm_chip *sun20i_chip = platform_get_drvdata(pdev);
   362	
   363		pwmchip_remove(&sun20i_chip->chip);
   364	
   365		reset_control_assert(sun20i_chip->rst);
   366	}
   367	
 > 368	static struct platform_driver sun20i_pwm_driver = {
 > 369		.driver = {
   370			.name = "sun20i-pwm",
   371			.of_match_table = sun20i_pwm_dt_ids,
   372		},
 > 373		.probe = sun20i_pwm_probe,
 > 374		.remove_new = sun20i_pwm_remove,
   375	};
 > 376	module_platform_driver(sun20i_pwm_driver);
   377	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

