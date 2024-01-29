Return-Path: <linux-kernel+bounces-42071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD583FBED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A0E1F2209F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A35DF69;
	Mon, 29 Jan 2024 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5KrTmKc"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9077DDCA;
	Mon, 29 Jan 2024 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492760; cv=none; b=kV0atJn326Hc2a03R0/k7CT+pvLwhaCrm+uA/Wl23cfFoyWXg1+puwkK84ymAU7KtAVn/8260MFKzvOMg4uDBg60aab7PVM1kISQ7HZKAZ/CeGWS04ZRJBAEd4nvISGH+igiWDo5Ir1cxeZYCbWYFUaYLRNvDUavzHbUVvOr2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492760; c=relaxed/simple;
	bh=/X9maGrA+Lh7slthhc+oyBV/Kxlz/28CEirMyL/2Fhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD1+EACpGRp5YjpBrgCkPQIX1ekA0KSL4NGxPB/xmV0JUkqyEskFW0v9fqxgUD3ToIVmDZs8il2cQMb1bclqyCYlaPJuHHMDMtYJ8F+tF62AC8P+yEqoxkPsdVOwOXeO92g3HRaRgqoTk2atI0vWW0I3STp79/wCepqPKVFoZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5KrTmKc; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706492758; x=1738028758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/X9maGrA+Lh7slthhc+oyBV/Kxlz/28CEirMyL/2Fhw=;
  b=f5KrTmKcX79r63o+Hi6yxy9EZoTLGM58ITGmCETHqs+KyNuTUKXkPGiC
   Hgr6XAClijGMt2QXuZuS2ss9FCEapatb9szn2IRQfeVpILwgpd9SFRHTB
   zCuvBfNA56gLHM1cI/3Z3EzxE+aL9ro5YgkjACjsACrj90d+2MlteakAs
   A8FsTw5MumuS+Sf6pyQyIJqWZwYRmRu8pWRKR0VJ0nBZrZnj8smG070YV
   H7UDHN/hV1sLy/Ng0QavxMOWfI4SdzxyXmRVCBMrUA1d5gkoKYX2NkJZi
   MiS6o0OrlQ3iyJpAEeRj0B7ey5uf7EZIvTPhU8nsmQu2cHgESNGf/zB2O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="393262429"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="393262429"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 17:45:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="910898340"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="910898340"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2024 17:45:54 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUGie-0003wC-1R;
	Mon, 29 Jan 2024 01:45:52 +0000
Date: Mon, 29 Jan 2024 09:45:33 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ychuang3@nuvoton.com,
	schung@nuvoton.com
Subject: Re: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
Message-ID: <202401290933.pxXzpfAD-lkp@intel.com>
References: <20240123080637.1902578-5-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123080637.1902578-5-ychuang570808@gmail.com>

Hi Jacky,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next robh/for-next linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/dt-bindings-reset-Add-syscon-to-nuvoton-ma35d1-system-management-node/20240123-161939
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20240123080637.1902578-5-ychuang570808%40gmail.com
patch subject: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver
config: x86_64-randconfig-121-20240128 (https://download.01.org/0day-ci/archive/20240129/202401290933.pxXzpfAD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401290933.pxXzpfAD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401290933.pxXzpfAD-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pinctrl/nuvoton/pinctrl-ma35.c: In function 'ma35_gpiolib_register':
>> drivers/pinctrl/nuvoton/pinctrl-ma35.c:523:27: error: 'struct gpio_chip' has no member named 'of_gpio_n_cells'
     523 |                 bank->chip.of_gpio_n_cells = 2;
         |                           ^
   drivers/pinctrl/nuvoton/pinctrl-ma35.c: At top level:
>> drivers/pinctrl/nuvoton/pinctrl-ma35.c:1008:10: error: 'const struct pinconf_ops' has no member named 'is_generic'
    1008 |         .is_generic = true,
         |          ^~~~~~~~~~
   drivers/pinctrl/nuvoton/pinctrl-ma35.c:1008:23: warning: initialization of 'int (*)(struct pinctrl_dev *, unsigned int,  long unsigned int *)' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1008 |         .is_generic = true,
         |                       ^~~~
   drivers/pinctrl/nuvoton/pinctrl-ma35.c:1008:23: note: (near initialization for 'ma35_pinconf_ops.pin_config_group_get')
   drivers/pinctrl/nuvoton/pinctrl-ma35.c: In function 'ma35_pinctrl_parse_groups':
>> drivers/pinctrl/nuvoton/pinctrl-ma35.c:1024:15: error: implicit declaration of function 'pinconf_generic_parse_dt_config'; did you mean 'pinconf_generic_dump_config'? [-Werror=implicit-function-declaration]
    1024 |         ret = pinconf_generic_parse_dt_config(np, NULL, &configs, &nconfigs);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               pinconf_generic_dump_config
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PINCTRL_MA35
   Depends on [n]: PINCTRL [=y] && (ARCH_MA35 || COMPILE_TEST [=n]) && OF [=n]
   Selected by [y]:
   - PINCTRL_MA35D1 [=y] && PINCTRL [=y]


vim +523 drivers/pinctrl/nuvoton/pinctrl-ma35.c

   506	
   507	static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinctrl *npctl)
   508	{
   509		struct ma35_pin_ctrl *ctrl = npctl->ctrl;
   510		struct ma35_pin_bank *bank = ctrl->pin_banks;
   511		int ret;
   512		int i;
   513	
   514		for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
   515			if (!bank->valid) {
   516				dev_warn(&pdev->dev, "bank %s is not valid\n",
   517					 bank->np->name);
   518				continue;
   519			}
   520			bank->irqtype = 0;
   521			bank->irqinten = 0;
   522			bank->chip.label = bank->name;
 > 523			bank->chip.of_gpio_n_cells = 2;
   524			bank->chip.parent = &pdev->dev;
   525			bank->chip.request = ma35_gpio_core_to_request;
   526			bank->chip.direction_input = ma35_gpio_core_direction_in;
   527			bank->chip.direction_output = ma35_gpio_core_direction_out;
   528			bank->chip.get = ma35_gpio_core_get;
   529			bank->chip.set = ma35_gpio_core_set;
   530			bank->chip.base = -1;
   531			bank->chip.ngpio = bank->nr_pins;
   532			bank->chip.can_sleep = false;
   533			spin_lock_init(&bank->lock);
   534	
   535			if (bank->irq > 0) {
   536				struct gpio_irq_chip *girq;
   537	
   538				girq = &bank->chip.irq;
   539				gpio_irq_chip_set_chip(girq, &ma35_gpio_irqchip);
   540				girq->parent_handler = ma35_irq_demux_intgroup;
   541				girq->num_parents = 1;
   542	
   543				girq->parents = devm_kcalloc(&pdev->dev, 1, sizeof(*girq->parents),
   544							     GFP_KERNEL);
   545				if (!girq->parents)
   546					return -ENOMEM;
   547	
   548				girq->parents[0] = bank->irq;
   549				girq->default_type = IRQ_TYPE_NONE;
   550				girq->handler = handle_level_irq;
   551			}
   552	
   553			ret = gpiochip_add_data(&bank->chip, bank);
   554			if (ret) {
   555				dev_err(&pdev->dev, "failed to register gpio_chip %s, error code: %d\n",
   556					bank->chip.label, ret);
   557				goto fail;
   558			}
   559		}
   560		return 0;
   561	
   562	fail:
   563		for (--i, --bank; i >= 0; --i, --bank) {
   564			if (!bank->valid)
   565				continue;
   566			gpiochip_remove(&bank->chip);
   567		}
   568		return ret;
   569	}
   570	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

