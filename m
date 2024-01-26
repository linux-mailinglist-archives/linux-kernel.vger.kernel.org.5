Return-Path: <linux-kernel+bounces-40851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8B83E6FA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CCC1C22B82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FC557309;
	Fri, 26 Jan 2024 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crsQYyNQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023141C73
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311852; cv=none; b=OsfSLFrfgO52xsVp0Sujj9q+acOSIkAr3/r2D39R7dwqr6H+/rmcTrAPIXcPW/hFdPf7Na+X+2xqN4Ewudfe7Gw1pxryegFg2GyS3mVVWvpA0NEzK58jSxRmzt9WwDx5RbfWBI0rpBiiqxgeW/CKmnAo4tk4c9aytszWeNoQR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311852; c=relaxed/simple;
	bh=A6hHQWTJMqbEgybv0lQ1bMJA2+Df7+PjA+eZp+fvjXI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZDfu1AWYgv0yU2ED1rWSvfk8dwKEPuYaqiPGrNMc/4uk3o0/VE4Ol4Dp7WbbYa4c3gf6gk7wM6W7lExw140n7HD9cQXDumRpWIuaCFmb/AXrPI00O4QT0uj+Myp6IEEu2fVTu7tQunaOUjFH5z8IXx7+wwJcBD4WAohEaxuo9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crsQYyNQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706311850; x=1737847850;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A6hHQWTJMqbEgybv0lQ1bMJA2+Df7+PjA+eZp+fvjXI=;
  b=crsQYyNQNBcILIMg7hyoqDuvCYfZDM51Hfch8PGktBZNJDSBxQdFaMG7
   ogYev6+lsyPDjednBTZ/OOBZgQ/cLqPnyd+HUXbwzGXKrO8cTKHe2Uuzj
   XPydmPJFhIPgnCnYkqDkZX9lAGM+9wVbLFhBDtSF3bkMVFEONHmRs1k5v
   hqe855dJcn9kGmNdXA17gEAXh5h2S9eqit5frYtlCOv9/O/Qz+Q256JzJ
   +OW9d2XOZQeAJLKkpqsESxlbAhYbFlYlKRwZL1aw36QsfvVCaYyVO/eup
   He9U6T9Z2Rm1SNAGIPuDnM9VPbiXLbR90lCjvpIJDEojYOYvDmyDIun4T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9263630"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9263630"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="28956168"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Jan 2024 15:30:44 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTVej-0001Ri-07;
	Fri, 26 Jan 2024 23:30:41 +0000
Date: Sat, 27 Jan 2024 07:30:27 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/irqchip/irq-stm32-exti.c:870:1-6: WARNING: invalid free of
 devm_ allocated data
Message-ID: <202401270747.eBM5wlwo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   1 year, 10 months ago
config: arm-randconfig-r062-20240117 (https://download.01.org/0day-ci/archive/20240127/202401270747.eBM5wlwo-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401270747.eBM5wlwo-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-stm32-exti.c:870:1-6: WARNING: invalid free of devm_ allocated data
   drivers/irqchip/irq-stm32-exti.c:871:1-6: WARNING: invalid free of devm_ allocated data
--
>> drivers/bus/arm-cci.c:458:1-33: WARNING: Function "for_each_available_child_of_node" should have of_node_put() before break around line 465.
--
>> arch/arm/kernel/topology.c:94:1-15: alloc with no test, possible model on line 102
--
>> drivers/cpufreq/armada-37xx-cpufreq.c:274:23-24: WARNING opportunity for max()
   drivers/cpufreq/armada-37xx-cpufreq.c:282:23-24: WARNING opportunity for max()
--
>> drivers/gpio/gpio-zynq.c:800:12-13: WARNING opportunity for min()
--
>> arch/arm/mach-omap2/dma.c:82:10-16: Unneeded variable: "errata". Return "  0" on line 161

vim +870 drivers/irqchip/irq-stm32-exti.c

f9fc1745501e7b Ludovic Barre    2018-04-26  801  
f9fc1745501e7b Ludovic Barre    2018-04-26  802  static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
f9fc1745501e7b Ludovic Barre    2018-04-26  803  				  struct device_node *node)
f9fc1745501e7b Ludovic Barre    2018-04-26  804  {
f9fc1745501e7b Ludovic Barre    2018-04-26  805  	struct stm32_exti_host_data *host_data;
e072041688ca73 Alexandre TORGUE 2016-09-20  806  	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
f9fc1745501e7b Ludovic Barre    2018-04-26  807  	int nr_irqs, ret, i;
e072041688ca73 Alexandre TORGUE 2016-09-20  808  	struct irq_chip_generic *gc;
e072041688ca73 Alexandre TORGUE 2016-09-20  809  	struct irq_domain *domain;
e072041688ca73 Alexandre TORGUE 2016-09-20  810  
f9fc1745501e7b Ludovic Barre    2018-04-26  811  	host_data = stm32_exti_host_init(drv_data, node);
4096165d55218a Dan Carpenter    2018-08-08  812  	if (!host_data)
4096165d55218a Dan Carpenter    2018-08-08  813  		return -ENOMEM;
e072041688ca73 Alexandre TORGUE 2016-09-20  814  
f9fc1745501e7b Ludovic Barre    2018-04-26  815  	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
e072041688ca73 Alexandre TORGUE 2016-09-20  816  				       &irq_exti_domain_ops, NULL);
e072041688ca73 Alexandre TORGUE 2016-09-20  817  	if (!domain) {
f9c75bca44d475 Yangtao Li       2018-11-23  818  		pr_err("%pOFn: Could not register interrupt domain.\n",
f9c75bca44d475 Yangtao Li       2018-11-23  819  		       node);
e072041688ca73 Alexandre TORGUE 2016-09-20  820  		ret = -ENOMEM;
e072041688ca73 Alexandre TORGUE 2016-09-20  821  		goto out_unmap;
e072041688ca73 Alexandre TORGUE 2016-09-20  822  	}
e072041688ca73 Alexandre TORGUE 2016-09-20  823  
6dd64ee17e04c3 Ludovic Barre    2017-11-06  824  	ret = irq_alloc_domain_generic_chips(domain, IRQS_PER_BANK, 1, "exti",
e072041688ca73 Alexandre TORGUE 2016-09-20  825  					     handle_edge_irq, clr, 0, 0);
e072041688ca73 Alexandre TORGUE 2016-09-20  826  	if (ret) {
e81f54c668d89e Rob Herring      2017-07-18  827  		pr_err("%pOF: Could not allocate generic interrupt chip.\n",
e81f54c668d89e Rob Herring      2017-07-18  828  		       node);
e072041688ca73 Alexandre TORGUE 2016-09-20  829  		goto out_free_domain;
e072041688ca73 Alexandre TORGUE 2016-09-20  830  	}
e072041688ca73 Alexandre TORGUE 2016-09-20  831  
f9fc1745501e7b Ludovic Barre    2018-04-26  832  	for (i = 0; i < drv_data->bank_nr; i++) {
f9fc1745501e7b Ludovic Barre    2018-04-26  833  		const struct stm32_exti_bank *stm32_bank;
f9fc1745501e7b Ludovic Barre    2018-04-26  834  		struct stm32_exti_chip_data *chip_data;
6dd64ee17e04c3 Ludovic Barre    2017-11-06  835  
f9fc1745501e7b Ludovic Barre    2018-04-26  836  		stm32_bank = drv_data->exti_banks[i];
cfbf9e497094dc Fabien Dessenne  2019-04-17  837  		chip_data = stm32_exti_chip_init(host_data, i, node);
d9e2b19b027440 Ludovic Barre    2018-04-26  838  
6dd64ee17e04c3 Ludovic Barre    2017-11-06  839  		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
6dd64ee17e04c3 Ludovic Barre    2017-11-06  840  
f9fc1745501e7b Ludovic Barre    2018-04-26  841  		gc->reg_base = host_data->base;
e072041688ca73 Alexandre TORGUE 2016-09-20  842  		gc->chip_types->type = IRQ_TYPE_EDGE_BOTH;
be6230f0c2bd5d Ludovic Barre    2018-04-26  843  		gc->chip_types->chip.irq_ack = stm32_irq_ack;
e072041688ca73 Alexandre TORGUE 2016-09-20  844  		gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
e072041688ca73 Alexandre TORGUE 2016-09-20  845  		gc->chip_types->chip.irq_unmask = irq_gc_mask_set_bit;
e072041688ca73 Alexandre TORGUE 2016-09-20  846  		gc->chip_types->chip.irq_set_type = stm32_irq_set_type;
d9e2b19b027440 Ludovic Barre    2018-04-26  847  		gc->chip_types->chip.irq_set_wake = irq_gc_set_wake;
d9e2b19b027440 Ludovic Barre    2018-04-26  848  		gc->suspend = stm32_irq_suspend;
d9e2b19b027440 Ludovic Barre    2018-04-26  849  		gc->resume = stm32_irq_resume;
d9e2b19b027440 Ludovic Barre    2018-04-26  850  		gc->wake_enabled = IRQ_MSK(IRQS_PER_BANK);
d9e2b19b027440 Ludovic Barre    2018-04-26  851  
6dd64ee17e04c3 Ludovic Barre    2017-11-06  852  		gc->chip_types->regs.mask = stm32_bank->imr_ofst;
d9e2b19b027440 Ludovic Barre    2018-04-26  853  		gc->private = (void *)chip_data;
6dd64ee17e04c3 Ludovic Barre    2017-11-06  854  	}
e072041688ca73 Alexandre TORGUE 2016-09-20  855  
e072041688ca73 Alexandre TORGUE 2016-09-20  856  	nr_irqs = of_irq_count(node);
e072041688ca73 Alexandre TORGUE 2016-09-20  857  	for (i = 0; i < nr_irqs; i++) {
e072041688ca73 Alexandre TORGUE 2016-09-20  858  		unsigned int irq = irq_of_parse_and_map(node, i);
e072041688ca73 Alexandre TORGUE 2016-09-20  859  
e072041688ca73 Alexandre TORGUE 2016-09-20  860  		irq_set_handler_data(irq, domain);
e072041688ca73 Alexandre TORGUE 2016-09-20  861  		irq_set_chained_handler(irq, stm32_irq_handler);
e072041688ca73 Alexandre TORGUE 2016-09-20  862  	}
e072041688ca73 Alexandre TORGUE 2016-09-20  863  
e072041688ca73 Alexandre TORGUE 2016-09-20  864  	return 0;
e072041688ca73 Alexandre TORGUE 2016-09-20  865  
e072041688ca73 Alexandre TORGUE 2016-09-20  866  out_free_domain:
e072041688ca73 Alexandre TORGUE 2016-09-20  867  	irq_domain_remove(domain);
e072041688ca73 Alexandre TORGUE 2016-09-20  868  out_unmap:
f9fc1745501e7b Ludovic Barre    2018-04-26  869  	iounmap(host_data->base);
f9fc1745501e7b Ludovic Barre    2018-04-26 @870  	kfree(host_data->chips_data);
f9fc1745501e7b Ludovic Barre    2018-04-26  871  	kfree(host_data);
e072041688ca73 Alexandre TORGUE 2016-09-20  872  	return ret;
e072041688ca73 Alexandre TORGUE 2016-09-20  873  }
e072041688ca73 Alexandre TORGUE 2016-09-20  874  

:::::: The code at line 870 was first introduced by commit
:::::: f9fc1745501e7b91e5b853e790de63ff9e1a3404 irqchip/stm32: Add host and driver data structures

:::::: TO: Ludovic Barre <ludovic.barre@st.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

