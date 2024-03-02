Return-Path: <linux-kernel+bounces-89408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2686EFF9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6473E1F21F40
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A9F14F7A;
	Sat,  2 Mar 2024 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAe2Ibyg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF91428F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709373799; cv=none; b=GH/rG6dSJ5Q7KYMC/NoE1SzNxNsP3nY54OX8OEujbFRPfM06rN4+E8bCxM1AnGeloqgqp958/ibir3jqrz2kfxiOQVBSR1KcD2yqeiWPJJdVH+h0JnsGvyP+uagtGMDg9MiIGvgjZO0jlvdvkLmnTQAZbL8f3rP7ci/gpdx4qIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709373799; c=relaxed/simple;
	bh=owtbmwnkqBQIEEhVjaBcQP5Mczo6NAI0kUKeE8N0GgA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rnFMf4fkKQ26WJsOsgHscnGWhYGiaQSMothQgjmqqiFWJU1we9whRg1QgGgl7RaFqtQyGTgO1jhBysjtIWUb5QSqv5JpJM/dLmoueLxYMpe0rHHyumDA7ed6uLIepGkwm8urFM/Igj2UPoUxMbErmBphNP1L4NMQ2OGeXM/oQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAe2Ibyg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709373797; x=1740909797;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=owtbmwnkqBQIEEhVjaBcQP5Mczo6NAI0kUKeE8N0GgA=;
  b=AAe2IbygzaDF+ullDDjYBdVLkkioSvF7xhLtwbCArDQy3UaTNKoAh8Gf
   R/UvdBOVexMIA4mLjPsZtrnhRJ3wcfQ6b886ZMrCJEc32zdosbobreubw
   jF4aC/+gklPQDg1/jGNDlXQM/jm3Vmn39SSOrDinLs+oClDwCfXzOVh3h
   XkY6RHEuZaTOvCSfsGp4GhtaVICr6psUIsZwfvnJERkR320e5bm3zWTR9
   Fu4XMqvD0XpXNkLpaZQ8vcuIy4cJxSOmwFUjSPFZaQ8fIwZ3/oJxO3qC9
   4cwQi0AUpsnycaB9qgR6O0O/KJEBzER/bfHUrF0fEcywPcbKr7wNCxjSP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3785996"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="3785996"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 02:03:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8400885"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 02 Mar 2024 02:03:15 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgMD1-000EW1-0X;
	Sat, 02 Mar 2024 10:03:12 +0000
Date: Sat, 2 Mar 2024 18:02:27 +0800
From: kernel test robot <lkp@intel.com>
To: Rob Herring <robh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/usb/host/uhci-grlib.c:92:36: error: invalid use of undefined
 type 'struct platform_device'
Message-ID: <202403021752.PfeD05eu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Rob,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ad3cb0ed525b80c7f66c32b49a68c1f3510bec9
commit: ef175b29a242fea98f467f008237484b03c94834 of: Stop circularly including of_device.h and of_platform.h
date:   6 weeks ago
config: sparc-randconfig-001-20240302 (https://download.01.org/0day-ci/archive/20240302/202403021752.PfeD05eu-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403021752.PfeD05eu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403021752.PfeD05eu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/usb/host/uhci-hcd.c:850:
   drivers/usb/host/uhci-grlib.c: In function 'uhci_hcd_grlib_probe':
>> drivers/usb/host/uhci-grlib.c:92:36: error: invalid use of undefined type 'struct platform_device'
      92 |         struct device_node *dn = op->dev.of_node;
         |                                    ^~
   In file included from include/linux/printk.h:564,
                    from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/usb/host/uhci-hcd.c:26:
   drivers/usb/host/uhci-grlib.c:102:20: error: invalid use of undefined type 'struct platform_device'
     102 |         dev_dbg(&op->dev, "initializing GRUSBHC UHCI USB Controller\n");
         |                    ^~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/usb/host/uhci-grlib.c:102:9: note: in expansion of macro 'dev_dbg'
     102 |         dev_dbg(&op->dev, "initializing GRUSBHC UHCI USB Controller\n");
         |         ^~~~~~~
   drivers/usb/host/uhci-grlib.c:109:11: error: invalid use of undefined type 'struct platform_device'
     109 |         op->dev.dma_mask = &op->dev.coherent_dma_mask;
         |           ^~
   drivers/usb/host/uhci-grlib.c:109:31: error: invalid use of undefined type 'struct platform_device'
     109 |         op->dev.dma_mask = &op->dev.coherent_dma_mask;
         |                               ^~
   drivers/usb/host/uhci-grlib.c:110:56: error: invalid use of undefined type 'struct platform_device'
     110 |         hcd = usb_create_hcd(&uhci_grlib_hc_driver, &op->dev,
         |                                                        ^~
   drivers/usb/host/uhci-grlib.c:125:46: error: invalid use of undefined type 'struct platform_device'
     125 |         hcd->regs = devm_ioremap_resource(&op->dev, &res);
         |                                              ^~
   drivers/usb/host/uhci-grlib.c: In function 'uhci_hcd_grlib_remove':
>> drivers/usb/host/uhci-grlib.c:152:31: error: implicit declaration of function 'platform_get_drvdata'; did you mean 'pci_get_drvdata'? [-Werror=implicit-function-declaration]
     152 |         struct usb_hcd *hcd = platform_get_drvdata(op);
         |                               ^~~~~~~~~~~~~~~~~~~~
         |                               pci_get_drvdata
   drivers/usb/host/uhci-grlib.c:152:31: warning: initialization of 'struct usb_hcd *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/usb/host/uhci-grlib.c:154:20: error: invalid use of undefined type 'struct platform_device'
     154 |         dev_dbg(&op->dev, "stopping GRLIB GRUSBHC UHCI USB Controller\n");
         |                    ^~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/usb/host/uhci-grlib.c:154:9: note: in expansion of macro 'dev_dbg'
     154 |         dev_dbg(&op->dev, "stopping GRLIB GRUSBHC UHCI USB Controller\n");
         |         ^~~~~~~
   drivers/usb/host/uhci-grlib.c: In function 'uhci_hcd_grlib_shutdown':
   drivers/usb/host/uhci-grlib.c:171:31: warning: initialization of 'struct usb_hcd *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     171 |         struct usb_hcd *hcd = platform_get_drvdata(op);
         |                               ^~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/uhci-grlib.c: At top level:
>> drivers/usb/host/uhci-grlib.c:184:15: error: variable 'uhci_grlib_driver' has initializer but incomplete type
     184 | static struct platform_driver uhci_grlib_driver = {
         |               ^~~~~~~~~~~~~~~
>> drivers/usb/host/uhci-grlib.c:185:10: error: 'struct platform_driver' has no member named 'probe'
     185 |         .probe          = uhci_hcd_grlib_probe,
         |          ^~~~~
   drivers/usb/host/uhci-grlib.c:185:27: warning: excess elements in struct initializer
     185 |         .probe          = uhci_hcd_grlib_probe,
         |                           ^~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/uhci-grlib.c:185:27: note: (near initialization for 'uhci_grlib_driver')
>> drivers/usb/host/uhci-grlib.c:186:10: error: 'struct platform_driver' has no member named 'remove_new'
     186 |         .remove_new     = uhci_hcd_grlib_remove,
         |          ^~~~~~~~~~
   drivers/usb/host/uhci-grlib.c:186:27: warning: excess elements in struct initializer
     186 |         .remove_new     = uhci_hcd_grlib_remove,
         |                           ^~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/uhci-grlib.c:186:27: note: (near initialization for 'uhci_grlib_driver')
>> drivers/usb/host/uhci-grlib.c:187:10: error: 'struct platform_driver' has no member named 'shutdown'
     187 |         .shutdown       = uhci_hcd_grlib_shutdown,
         |          ^~~~~~~~
   drivers/usb/host/uhci-grlib.c:187:27: warning: excess elements in struct initializer
     187 |         .shutdown       = uhci_hcd_grlib_shutdown,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/uhci-grlib.c:187:27: note: (near initialization for 'uhci_grlib_driver')
>> drivers/usb/host/uhci-grlib.c:188:10: error: 'struct platform_driver' has no member named 'driver'
     188 |         .driver = {
         |          ^~~~~~
>> drivers/usb/host/uhci-grlib.c:188:19: error: extra brace group at end of initializer
     188 |         .driver = {
         |                   ^
   drivers/usb/host/uhci-grlib.c:188:19: note: (near initialization for 'uhci_grlib_driver')
   drivers/usb/host/uhci-grlib.c:188:19: warning: excess elements in struct initializer
   drivers/usb/host/uhci-grlib.c:188:19: note: (near initialization for 'uhci_grlib_driver')
   drivers/usb/host/uhci-hcd.c: In function 'uhci_hcd_init':
>> drivers/usb/host/uhci-hcd.c:885:18: error: implicit declaration of function 'platform_driver_register' [-Werror=implicit-function-declaration]
     885 |         retval = platform_driver_register(&PLATFORM_DRIVER);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/uhci-hcd.c:902:9: error: implicit declaration of function 'platform_driver_unregister'; did you mean 'driver_unregister'? [-Werror=implicit-function-declaration]
     902 |         platform_driver_unregister(&PLATFORM_DRIVER);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |         driver_unregister
   drivers/usb/host/uhci-grlib.c: At top level:
>> drivers/usb/host/uhci-grlib.c:184:31: error: storage size of 'uhci_grlib_driver' isn't known
     184 | static struct platform_driver uhci_grlib_driver = {
         |                               ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +92 drivers/usb/host/uhci-grlib.c

3db7739c80990e Jan Andersson    2011-05-06   88  
3db7739c80990e Jan Andersson    2011-05-06   89  
41ac7b3ab7fe1d Bill Pemberton   2012-11-19   90  static int uhci_hcd_grlib_probe(struct platform_device *op)
3db7739c80990e Jan Andersson    2011-05-06   91  {
3db7739c80990e Jan Andersson    2011-05-06  @92  	struct device_node *dn = op->dev.of_node;
3db7739c80990e Jan Andersson    2011-05-06   93  	struct usb_hcd *hcd;
3db7739c80990e Jan Andersson    2011-05-06   94  	struct uhci_hcd	*uhci = NULL;
3db7739c80990e Jan Andersson    2011-05-06   95  	struct resource res;
3db7739c80990e Jan Andersson    2011-05-06   96  	int irq;
3db7739c80990e Jan Andersson    2011-05-06   97  	int rv;
3db7739c80990e Jan Andersson    2011-05-06   98  
3db7739c80990e Jan Andersson    2011-05-06   99  	if (usb_disabled())
3db7739c80990e Jan Andersson    2011-05-06  100  		return -ENODEV;
3db7739c80990e Jan Andersson    2011-05-06  101  
3db7739c80990e Jan Andersson    2011-05-06  102  	dev_dbg(&op->dev, "initializing GRUSBHC UHCI USB Controller\n");
3db7739c80990e Jan Andersson    2011-05-06  103  
3db7739c80990e Jan Andersson    2011-05-06  104  	rv = of_address_to_resource(dn, 0, &res);
3db7739c80990e Jan Andersson    2011-05-06  105  	if (rv)
3db7739c80990e Jan Andersson    2011-05-06  106  		return rv;
3db7739c80990e Jan Andersson    2011-05-06  107  
3db7739c80990e Jan Andersson    2011-05-06  108  	/* usb_create_hcd requires dma_mask != NULL */
3db7739c80990e Jan Andersson    2011-05-06  109  	op->dev.dma_mask = &op->dev.coherent_dma_mask;
3db7739c80990e Jan Andersson    2011-05-06  110  	hcd = usb_create_hcd(&uhci_grlib_hc_driver, &op->dev,
3db7739c80990e Jan Andersson    2011-05-06  111  			"GRUSBHC UHCI USB");
3db7739c80990e Jan Andersson    2011-05-06  112  	if (!hcd)
3db7739c80990e Jan Andersson    2011-05-06  113  		return -ENOMEM;
3db7739c80990e Jan Andersson    2011-05-06  114  
3db7739c80990e Jan Andersson    2011-05-06  115  	hcd->rsrc_start = res.start;
28f65c11f2ffb3 Joe Perches      2011-06-09  116  	hcd->rsrc_len = resource_size(&res);
3db7739c80990e Jan Andersson    2011-05-06  117  
3db7739c80990e Jan Andersson    2011-05-06  118  	irq = irq_of_parse_and_map(dn, 0);
8836402d4b208b Christophe Leroy 2022-11-10  119  	if (!irq) {
3db7739c80990e Jan Andersson    2011-05-06  120  		printk(KERN_ERR "%s: irq_of_parse_and_map failed\n", __FILE__);
3db7739c80990e Jan Andersson    2011-05-06  121  		rv = -EBUSY;
ddd94257410fa6 Himangi Saraogi  2014-06-12  122  		goto err_usb;
3db7739c80990e Jan Andersson    2011-05-06  123  	}
3db7739c80990e Jan Andersson    2011-05-06  124  
ddd94257410fa6 Himangi Saraogi  2014-06-12  125  	hcd->regs = devm_ioremap_resource(&op->dev, &res);
ddd94257410fa6 Himangi Saraogi  2014-06-12  126  	if (IS_ERR(hcd->regs)) {
ddd94257410fa6 Himangi Saraogi  2014-06-12  127  		rv = PTR_ERR(hcd->regs);
ddd94257410fa6 Himangi Saraogi  2014-06-12  128  		goto err_irq;
3db7739c80990e Jan Andersson    2011-05-06  129  	}
3db7739c80990e Jan Andersson    2011-05-06  130  
3db7739c80990e Jan Andersson    2011-05-06  131  	uhci = hcd_to_uhci(hcd);
3db7739c80990e Jan Andersson    2011-05-06  132  
3db7739c80990e Jan Andersson    2011-05-06  133  	uhci->regs = hcd->regs;
3db7739c80990e Jan Andersson    2011-05-06  134  
3db7739c80990e Jan Andersson    2011-05-06  135  	rv = usb_add_hcd(hcd, irq, 0);
3db7739c80990e Jan Andersson    2011-05-06  136  	if (rv)
ddd94257410fa6 Himangi Saraogi  2014-06-12  137  		goto err_irq;
3db7739c80990e Jan Andersson    2011-05-06  138  
3c9740a117d40a Peter Chen       2013-11-05  139  	device_wakeup_enable(hcd->self.controller);
3db7739c80990e Jan Andersson    2011-05-06  140  	return 0;
3db7739c80990e Jan Andersson    2011-05-06  141  
3db7739c80990e Jan Andersson    2011-05-06  142  err_irq:
ddd94257410fa6 Himangi Saraogi  2014-06-12  143  	irq_dispose_mapping(irq);
ddd94257410fa6 Himangi Saraogi  2014-06-12  144  err_usb:
3db7739c80990e Jan Andersson    2011-05-06  145  	usb_put_hcd(hcd);
3db7739c80990e Jan Andersson    2011-05-06  146  
3db7739c80990e Jan Andersson    2011-05-06  147  	return rv;
3db7739c80990e Jan Andersson    2011-05-06  148  }
3db7739c80990e Jan Andersson    2011-05-06  149  
18cb7c4d53d061 Uwe Kleine-König 2023-05-18  150  static void uhci_hcd_grlib_remove(struct platform_device *op)
3db7739c80990e Jan Andersson    2011-05-06  151  {
477527baf6a8d4 Jingoo Han       2013-05-23 @152  	struct usb_hcd *hcd = platform_get_drvdata(op);
3db7739c80990e Jan Andersson    2011-05-06  153  
3db7739c80990e Jan Andersson    2011-05-06  154  	dev_dbg(&op->dev, "stopping GRLIB GRUSBHC UHCI USB Controller\n");
3db7739c80990e Jan Andersson    2011-05-06  155  
3db7739c80990e Jan Andersson    2011-05-06  156  	usb_remove_hcd(hcd);
3db7739c80990e Jan Andersson    2011-05-06  157  
3db7739c80990e Jan Andersson    2011-05-06  158  	irq_dispose_mapping(hcd->irq);
3db7739c80990e Jan Andersson    2011-05-06  159  	usb_put_hcd(hcd);
3db7739c80990e Jan Andersson    2011-05-06  160  }
3db7739c80990e Jan Andersson    2011-05-06  161  
3db7739c80990e Jan Andersson    2011-05-06  162  /* Make sure the controller is quiescent and that we're not using it
3db7739c80990e Jan Andersson    2011-05-06  163   * any more.  This is mainly for the benefit of programs which, like kexec,
3db7739c80990e Jan Andersson    2011-05-06  164   * expect the hardware to be idle: not doing DMA or generating IRQs.
3db7739c80990e Jan Andersson    2011-05-06  165   *
3db7739c80990e Jan Andersson    2011-05-06  166   * This routine may be called in a damaged or failing kernel.  Hence we
3db7739c80990e Jan Andersson    2011-05-06  167   * do not acquire the spinlock before shutting down the controller.
3db7739c80990e Jan Andersson    2011-05-06  168   */
3db7739c80990e Jan Andersson    2011-05-06  169  static void uhci_hcd_grlib_shutdown(struct platform_device *op)
3db7739c80990e Jan Andersson    2011-05-06  170  {
477527baf6a8d4 Jingoo Han       2013-05-23  171  	struct usb_hcd *hcd = platform_get_drvdata(op);
3db7739c80990e Jan Andersson    2011-05-06  172  
3db7739c80990e Jan Andersson    2011-05-06  173  	uhci_hc_died(hcd_to_uhci(hcd));
3db7739c80990e Jan Andersson    2011-05-06  174  }
3db7739c80990e Jan Andersson    2011-05-06  175  
3db7739c80990e Jan Andersson    2011-05-06  176  static const struct of_device_id uhci_hcd_grlib_of_match[] = {
3db7739c80990e Jan Andersson    2011-05-06  177  	{ .name = "GAISLER_UHCI", },
3db7739c80990e Jan Andersson    2011-05-06  178  	{ .name = "01_027", },
3db7739c80990e Jan Andersson    2011-05-06  179  	{},
3db7739c80990e Jan Andersson    2011-05-06  180  };
3db7739c80990e Jan Andersson    2011-05-06  181  MODULE_DEVICE_TABLE(of, uhci_hcd_grlib_of_match);
3db7739c80990e Jan Andersson    2011-05-06  182  
3db7739c80990e Jan Andersson    2011-05-06  183  
3db7739c80990e Jan Andersson    2011-05-06 @184  static struct platform_driver uhci_grlib_driver = {
3db7739c80990e Jan Andersson    2011-05-06 @185  	.probe		= uhci_hcd_grlib_probe,
18cb7c4d53d061 Uwe Kleine-König 2023-05-18 @186  	.remove_new	= uhci_hcd_grlib_remove,
3db7739c80990e Jan Andersson    2011-05-06 @187  	.shutdown	= uhci_hcd_grlib_shutdown,
3db7739c80990e Jan Andersson    2011-05-06 @188  	.driver = {

:::::: The code at line 92 was first introduced by commit
:::::: 3db7739c80990ef53621f76f6095a91e70d88546 USB: UHCI: Add support for GRLIB GRUSBHC controller

:::::: TO: Jan Andersson <jan@gaisler.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

