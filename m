Return-Path: <linux-kernel+bounces-43060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99DF840AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F30028CA65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455AE155A34;
	Mon, 29 Jan 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmZTr9+s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C8155316;
	Mon, 29 Jan 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544719; cv=none; b=DSvHah43ICESVSxnnFce5yntactFraCyt4yC/RAXhSFqqTtQ5HYsRQwCW2pONsO3uObZpEiVzCw2Y4dknOIevIEj8PhLBH5Y1DaQ4Y/RU49KQ56EwFOoB+IUqCBfKf2ECCC6liu/q3Ut1R9g06CJYu1plLS72iRdgwLLKYUZpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544719; c=relaxed/simple;
	bh=EJuKz+rDfnnrgz4jtF7KK8M8+lKo37WzgpZ8fWKe+go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB+GO7gWznVf1uLUo7DDZhMlCsWOew2DnJD823kDZZqLuhIsD4Z+e6j9AHZf69vhtpei0uO7giXMeQDt1H8coK1LAQRYajRcA/wcF0e1iVz/mo9APHBx0Bg8oioTzX80JOcYExzB7hD6fAckJi0gxa2p1WDOWJSbp7DcmE6X7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmZTr9+s; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706544717; x=1738080717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EJuKz+rDfnnrgz4jtF7KK8M8+lKo37WzgpZ8fWKe+go=;
  b=jmZTr9+s0BH0yotyOal0q9jxcJoA62wy25l1FbdVyMSYrG8n8/5I5iXX
   j6f1Uam6LcnTvGo2QtuQdybq/982+bOjOmiro8aVgfeC/za03w88C5U5F
   0MGWVmSus8W51EfUIEjZVSDBYPoL8e/2N5o60F5D710ImRdsL38rx5RIQ
   zqrV4PPN/KiyHIRtvMwhY9U+wL+Ksvj18xrmdcZN/pmKjqluICEowsKVw
   gjIiuQJbyWMUQsUy0e+m1ye3rkP1aVqCbJwhlC0ZrVeDObPRNslWn3LnY
   PKaaucS09jcnGyHHffyopgrqE/81eywmV6W0Wm1vy1AUk6AlNf/trU4v0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16359739"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="16359739"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:02:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3342415"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jan 2024 08:02:44 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUU5q-0004Oq-0h;
	Mon, 29 Jan 2024 16:02:42 +0000
Date: Tue, 30 Jan 2024 00:02:16 +0800
From: kernel test robot <lkp@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
	linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, corbet@lwn.net,
	u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
	naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v13 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
Message-ID: <202401292303.6SVAncvn-lkp@intel.com>
References: <20240124060705.1342461-4-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124060705.1342461-4-billy_tsai@aspeedtech.com>

Hi Billy,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.8-rc2 next-20240129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-hwmon-fan-Add-fan-binding-to-schema/20240124-141405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240124060705.1342461-4-billy_tsai%40aspeedtech.com
patch subject: [PATCH v13 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach
config: riscv-randconfig-r071-20240129 (https://download.01.org/0day-ci/archive/20240129/202401292303.6SVAncvn-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401292303.6SVAncvn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401292303.6SVAncvn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/aspeed-g6-pwm-tach.c:496:2: error: implicit declaration of function 'of_platform_populate' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           of_platform_populate(dev->of_node, NULL, NULL, dev);
           ^
   1 error generated.


vim +/of_platform_populate +496 drivers/hwmon/aspeed-g6-pwm-tach.c

   446	
   447	static int aspeed_pwm_tach_probe(struct platform_device *pdev)
   448	{
   449		struct device *dev = &pdev->dev, *hwmon;
   450		int ret;
   451		struct device_node *child;
   452		struct aspeed_pwm_tach_data *priv;
   453	
   454		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   455		if (!priv)
   456			return -ENOMEM;
   457		priv->dev = dev;
   458		priv->base = devm_platform_ioremap_resource(pdev, 0);
   459		if (IS_ERR(priv->base))
   460			return PTR_ERR(priv->base);
   461	
   462		priv->clk = devm_clk_get_enabled(dev, NULL);
   463		if (IS_ERR(priv->clk))
   464			return dev_err_probe(dev, PTR_ERR(priv->clk),
   465					     "Couldn't get clock\n");
   466		priv->clk_rate = clk_get_rate(priv->clk);
   467		priv->reset = devm_reset_control_get_exclusive(dev, NULL);
   468		if (IS_ERR(priv->reset))
   469			return dev_err_probe(dev, PTR_ERR(priv->reset),
   470					     "Couldn't get reset control\n");
   471	
   472		ret = reset_control_deassert(priv->reset);
   473		if (ret)
   474			return dev_err_probe(dev, ret,
   475					     "Couldn't deassert reset control\n");
   476	
   477		priv->chip.dev = dev;
   478		priv->chip.ops = &aspeed_pwm_ops;
   479		priv->chip.npwm = PWM_ASPEED_NR_PWMS;
   480	
   481		ret = devm_pwmchip_add(dev, &priv->chip);
   482		if (ret < 0) {
   483			reset_control_assert(priv->reset);
   484			return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
   485		}
   486	
   487		for_each_child_of_node(dev->of_node, child) {
   488			ret = aspeed_tach_create_fan(dev, child, priv);
   489			if (ret < 0) {
   490				of_node_put(child);
   491				dev_warn(dev, "Failed to create fan %d", ret);
   492				return 0;
   493			}
   494		}
   495	
 > 496		of_platform_populate(dev->of_node, NULL, NULL, dev);
   497	
   498		hwmon = devm_hwmon_device_register_with_info(dev, "aspeed_tach", priv,
   499							     &aspeed_tach_chip_info, NULL);
   500		ret = PTR_ERR_OR_ZERO(hwmon);
   501		if (ret) {
   502			reset_control_assert(priv->reset);
   503			return dev_err_probe(dev, ret,
   504					     "Failed to register hwmon device\n");
   505		}
   506	
   507		return 0;
   508	}
   509	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

