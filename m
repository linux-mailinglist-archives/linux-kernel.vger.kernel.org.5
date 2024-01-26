Return-Path: <linux-kernel+bounces-39464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4D183D191
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED961C234D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F56EDE;
	Fri, 26 Jan 2024 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrA1jvxB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E4B362;
	Fri, 26 Jan 2024 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706229517; cv=none; b=McU7Uv6UfG6AINDV9lMOPKMxeiY6bj7mi9JTEJIb8Y6HFVliPb4fZ0hj5VXxa4+AF1YWFgBDGIxq7YIEbGxr9XF5tfi7/x/Gy2CFFs2yZI8mnR36fiUir89SDw5+ncsXwZWJznnECUpArCgXDGue0bF+Xs+moMHQepYaJqtR6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706229517; c=relaxed/simple;
	bh=rOEX1bgvfa5pZYrTf4/IA0sPQBNBW81LFwqj7o3ESTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQDMMRykZ/PgY40qwcuyJDF83gxNon4Wk4a0d3ddog3WoPuuoW/yNJocHnsngzhq96wc2ZImDP3kRuufP/tdN2wc/Qaj3HsSMTJ5mUlaEJXS+lfsQELAPC+geAHXKYVsbjbMzCOobXmhwFVK1cu6ZNDPCgRxaKIURxogTnGXKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrA1jvxB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706229514; x=1737765514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rOEX1bgvfa5pZYrTf4/IA0sPQBNBW81LFwqj7o3ESTU=;
  b=YrA1jvxBD1LfwjpoWJ2+qs1/H2HMPFgm4DFEm39CRrxAYqyDWIjvQ6Z0
   HJ+jkyvf9GbWIV0r3zqXWMzg3dCZdWHPMjSdoRlvRy/o1gYaaJYDTp5Nd
   8kl+i/C2sy5wYGKRw5RPCic6TDTzdaVhdIQBo+SwHSQEGEO3HVhw88FKC
   WbdLEkrhYvM3SGSVD9wZWp0se10XN8Pt29ylsM55cgf+UnwD4K9gtOEDR
   D2rpKi86CabgqfHtXSq+83hmqaeDDQafDbJ1GABiMk/eT2tpt5T3Wy3qL
   K1dlmEsXJ0WkezQo5XXSpJ3Di2M4H8wkI50jtBneb0l1uhvvpmaAiNEWg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9462221"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9462221"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857252586"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="857252586"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2024 16:38:25 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTAEh-0000Wq-2P;
	Fri, 26 Jan 2024 00:38:23 +0000
Date: Fri, 26 Jan 2024 08:38:04 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Aleksandr Shubin <privatesub2@gmail.com>,
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
Message-ID: <202401260832.fN2PCI3u-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240126/202401260832.fN2PCI3u-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project a31a60074717fc40887cfe132b77eec93bedd307)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401260832.fN2PCI3u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401260832.fN2PCI3u-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/pwm/pwm-sun20i.c:16:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-sun20i.c:16:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-sun20i.c:16:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/pwm/pwm-sun20i.c:288:3: error: field designator 'owner' does not refer to any field in type 'const struct pwm_ops'
     288 |         .owner = THIS_MODULE,
         |         ~^~~~~~~~~~~~~~~~~~~
>> drivers/pwm/pwm-sun20i.c:297:36: warning: declaration of 'struct platform_device' will not be visible outside of this function [-Wvisibility]
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
>> drivers/pwm/pwm-sun20i.c:302:16: error: call to undeclared function 'devm_kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     302 |         sun20i_chip = devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERNEL);
         |                       ^
>> drivers/pwm/pwm-sun20i.c:302:34: error: incomplete definition of type 'struct platform_device'
     302 |         sun20i_chip = devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERNEL);
         |                                     ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
>> drivers/pwm/pwm-sun20i.c:306:22: error: call to undeclared function 'devm_platform_ioremap_resource'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     306 |         sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
         |                             ^
>> drivers/pwm/pwm-sun20i.c:306:20: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
     306 |         sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
         |                           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-sun20i.c:310:51: error: incomplete definition of type 'struct platform_device'
     310 |         sun20i_chip->clk_bus = devm_clk_get_enabled(&pdev->dev, "bus");
         |                                                      ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
>> drivers/pwm/pwm-sun20i.c:312:10: error: call to undeclared function 'dev_err_probe'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     312 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
         |                        ^
   drivers/pwm/pwm-sun20i.c:312:29: error: incomplete definition of type 'struct platform_device'
     312 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
         |                                       ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:315:52: error: incomplete definition of type 'struct platform_device'
     315 |         sun20i_chip->clk_hosc = devm_clk_get_enabled(&pdev->dev, "hosc");
         |                                                       ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:317:29: error: incomplete definition of type 'struct platform_device'
     317 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
         |                                       ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:320:52: error: incomplete definition of type 'struct platform_device'
     320 |         sun20i_chip->clk_apb0 = devm_clk_get_enabled(&pdev->dev, "apb0");
         |                                                       ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:322:29: error: incomplete definition of type 'struct platform_device'
     322 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb0),
         |                                       ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:325:59: error: incomplete definition of type 'struct platform_device'
     325 |         sun20i_chip->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
         |                                                              ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:327:29: error: incomplete definition of type 'struct platform_device'
     327 |                 return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
         |                                       ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:330:33: error: incomplete definition of type 'struct platform_device'
     330 |         ret = of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels",
         |                                    ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:341:29: error: incomplete definition of type 'struct platform_device'
     341 |                 return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");
         |                                       ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:343:31: error: incomplete definition of type 'struct platform_device'
     343 |         sun20i_chip->chip.dev = &pdev->dev;
         |                                  ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
   drivers/pwm/pwm-sun20i.c:351:29: error: incomplete definition of type 'struct platform_device'
     351 |                 return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
         |                                       ~~~~^
   drivers/pwm/pwm-sun20i.c:297:36: note: forward declaration of 'struct platform_device'
     297 | static int sun20i_pwm_probe(struct platform_device *pdev)
         |                                    ^
>> drivers/pwm/pwm-sun20i.c:354:2: error: call to undeclared function 'platform_set_drvdata'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     354 |         platform_set_drvdata(pdev, sun20i_chip);
         |         ^
   drivers/pwm/pwm-sun20i.c:359:38: warning: declaration of 'struct platform_device' will not be visible outside of this function [-Wvisibility]
     359 | static void sun20i_pwm_remove(struct platform_device *pdev)
         |                                      ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   8 warnings and 20 errors generated.


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
 > 297	static int sun20i_pwm_probe(struct platform_device *pdev)
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

