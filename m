Return-Path: <linux-kernel+bounces-56823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C484CFBC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E304328A641
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF0782C76;
	Wed,  7 Feb 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4oKTarT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99782D6C;
	Wed,  7 Feb 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326651; cv=none; b=ivn4V6+N0zxipzJmm95+N5aUF8nF5CfT+SUjQWbO3+pV0hEMVIZhxCELVqHgpSGnD/X5sEu156ahh8VZPUhPC2azByfCFEwJhMfSknorEIPGQKSevbV9LA52Wmskc+FlaF0TKlRdGrlUIFfgC355e1my4tUvDwIc4f2akZHkyeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326651; c=relaxed/simple;
	bh=x5ppnwsf4pgCGz1yIwdCpgLN6d2nBaj7v+QHJdweFuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msBAeduk2i2FYa0KvJlSMFZE1ylWoJlzOT2MH+tFOoKa10mJdGhMLMkTbv1zBEbUTjAgJxr6gFGmP1ITkowMY1hjJqQeDXFtmXA+3qiW8JH9mc7Chmwfv30y3n2Zw4GYGOMhRYYSCyI6lRhaEp23By9RCE+lZznQBWlUg2K0I8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4oKTarT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707326649; x=1738862649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x5ppnwsf4pgCGz1yIwdCpgLN6d2nBaj7v+QHJdweFuk=;
  b=X4oKTarTWUHZhNvq8YFPpHtlpoADWeyGDEKwjEwKpiJLlFL5wg5oQRZ6
   hxm9jHJYOnG1p4wr+USexSXf+2yLFP06JfRyVnvXyc86VzzIB5Okzanxc
   H0iR9RvXXLsxChiON36XGFgmyQwpJiKEKm1mbKQKBtkhPQ+chVYlzI2al
   NzT89PWgCcS0NYKz54VxTZWgOr6lztDrWG6D8ie1IKQ72ZYzUB+wRheTL
   T57esk+lKBnaaULMt22yZC/9jFi0BuoZtPMTE5g37J+NlAv+If1zvvmuJ
   kDpE7akn6gt2Q5KC4EmPrIo1IioCdpiZX2rjPx7GUUKZP9NHRvL6m6Jvh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="23512961"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="23512961"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:24:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="32196969"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Feb 2024 09:24:06 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXleV-0002sS-1O;
	Wed, 07 Feb 2024 17:24:03 +0000
Date: Thu, 8 Feb 2024 01:23:53 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 3/4] serial: sc16is7xx: split into core and I2C/SPI parts
 (sc16is7xx_lines)
Message-ID: <202402080139.jQSw8VKg-lkp@intel.com>
References: <20240206214208.2141067-4-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206214208.2141067-4-hugo@hugovil.com>

Hi Hugo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 52b56990d214c7403b20f691ac61861a37c0f0db]

url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-sc16is7xx-simplify-and-improve-Kconfig-help-text/20240207-061642
base:   52b56990d214c7403b20f691ac61861a37c0f0db
patch link:    https://lore.kernel.org/r/20240206214208.2141067-4-hugo%40hugovil.com
patch subject: [PATCH 3/4] serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_lines)
config: i386-buildonly-randconfig-003-20240207 (https://download.01.org/0day-ci/archive/20240208/202402080139.jQSw8VKg-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402080139.jQSw8VKg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402080139.jQSw8VKg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/sc16is7xx.c:1539:23: error: call to undeclared function 'find_and_set_bit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1539 |                 s->p[i].port.line = find_and_set_bit(sc16is7xx_lines,
         |                                     ^
   drivers/tty/serial/sc16is7xx.c:1539:23: note: did you mean 'test_and_set_bit'?
   include/asm-generic/bitops/instrumented-atomic.h:68:29: note: 'test_and_set_bit' declared here
      68 | static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
         |                             ^
   1 error generated.


vim +/find_and_set_bit +1539 drivers/tty/serial/sc16is7xx.c

  1462	
  1463	int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
  1464			    struct regmap *regmaps[], int irq)
  1465	{
  1466		unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
  1467		unsigned int val;
  1468		u32 uartclk = 0;
  1469		int i, ret;
  1470		struct sc16is7xx_port *s;
  1471		bool port_registered[SC16IS7XX_MAX_PORTS];
  1472	
  1473		for (i = 0; i < devtype->nr_uart; i++)
  1474			if (IS_ERR(regmaps[i]))
  1475				return PTR_ERR(regmaps[i]);
  1476	
  1477		/*
  1478		 * This device does not have an identification register that would
  1479		 * tell us if we are really connected to the correct device.
  1480		 * The best we can do is to check if communication is at all possible.
  1481		 *
  1482		 * Note: regmap[0] is used in the probe function to access registers
  1483		 * common to all channels/ports, as it is guaranteed to be present on
  1484		 * all variants.
  1485		 */
  1486		ret = regmap_read(regmaps[0], SC16IS7XX_LSR_REG, &val);
  1487		if (ret < 0)
  1488			return -EPROBE_DEFER;
  1489	
  1490		/* Alloc port structure */
  1491		s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
  1492		if (!s) {
  1493			dev_err(dev, "Error allocating port structure\n");
  1494			return -ENOMEM;
  1495		}
  1496	
  1497		/* Always ask for fixed clock rate from a property. */
  1498		device_property_read_u32(dev, "clock-frequency", &uartclk);
  1499	
  1500		s->clk = devm_clk_get_optional(dev, NULL);
  1501		if (IS_ERR(s->clk))
  1502			return PTR_ERR(s->clk);
  1503	
  1504		ret = clk_prepare_enable(s->clk);
  1505		if (ret)
  1506			return ret;
  1507	
  1508		freq = clk_get_rate(s->clk);
  1509		if (freq == 0) {
  1510			if (uartclk)
  1511				freq = uartclk;
  1512			if (pfreq)
  1513				freq = *pfreq;
  1514			if (freq)
  1515				dev_dbg(dev, "Clock frequency: %luHz\n", freq);
  1516			else
  1517				return -EINVAL;
  1518		}
  1519	
  1520		s->devtype = devtype;
  1521		dev_set_drvdata(dev, s);
  1522	
  1523		kthread_init_worker(&s->kworker);
  1524		s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
  1525					      "sc16is7xx");
  1526		if (IS_ERR(s->kworker_task)) {
  1527			ret = PTR_ERR(s->kworker_task);
  1528			goto out_clk;
  1529		}
  1530		sched_set_fifo(s->kworker_task);
  1531	
  1532		/* reset device, purging any pending irq / data */
  1533		regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
  1534			     SC16IS7XX_IOCONTROL_SRESET_BIT);
  1535	
  1536		for (i = 0; i < devtype->nr_uart; ++i) {
  1537			port_registered[i] = false;
  1538	
> 1539			s->p[i].port.line = find_and_set_bit(sc16is7xx_lines,
  1540							     SC16IS7XX_MAX_DEVS);
  1541			if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
  1542				ret = -ERANGE;
  1543				goto out_ports;
  1544			}
  1545	
  1546			/* Initialize port data */
  1547			s->p[i].port.dev	= dev;
  1548			s->p[i].port.irq	= irq;
  1549			s->p[i].port.type	= PORT_SC16IS7XX;
  1550			s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
  1551			s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
  1552			s->p[i].port.iobase	= i;
  1553			/*
  1554			 * Use all ones as membase to make sure uart_configure_port() in
  1555			 * serial_core.c does not abort for SPI/I2C devices where the
  1556			 * membase address is not applicable.
  1557			 */
  1558			s->p[i].port.membase	= (void __iomem *)~0;
  1559			s->p[i].port.iotype	= UPIO_PORT;
  1560			s->p[i].port.uartclk	= freq;
  1561			s->p[i].port.rs485_config = sc16is7xx_config_rs485;
  1562			s->p[i].port.rs485_supported = sc16is7xx_rs485_supported;
  1563			s->p[i].port.ops	= &sc16is7xx_ops;
  1564			s->p[i].old_mctrl	= 0;
  1565			s->p[i].regmap		= regmaps[i];
  1566	
  1567			mutex_init(&s->p[i].efr_lock);
  1568	
  1569			ret = uart_get_rs485_mode(&s->p[i].port);
  1570			if (ret)
  1571				goto out_ports;
  1572	
  1573			/* Disable all interrupts */
  1574			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_IER_REG, 0);
  1575			/* Disable TX/RX */
  1576			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
  1577					     SC16IS7XX_EFCR_RXDISABLE_BIT |
  1578					     SC16IS7XX_EFCR_TXDISABLE_BIT);
  1579	
  1580			/* Initialize kthread work structs */
  1581			kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
  1582			kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
  1583			kthread_init_delayed_work(&s->p[i].ms_work, sc16is7xx_ms_proc);
  1584	
  1585			/* Register port */
  1586			ret = uart_add_one_port(&sc16is7xx_uart, &s->p[i].port);
  1587			if (ret)
  1588				goto out_ports;
  1589	
  1590			port_registered[i] = true;
  1591	
  1592			/* Enable EFR */
  1593			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
  1594					     SC16IS7XX_LCR_CONF_MODE_B);
  1595	
  1596			regcache_cache_bypass(regmaps[i], true);
  1597	
  1598			/* Enable write access to enhanced features */
  1599			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFR_REG,
  1600					     SC16IS7XX_EFR_ENABLE_BIT);
  1601	
  1602			regcache_cache_bypass(regmaps[i], false);
  1603	
  1604			/* Restore access to general registers */
  1605			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG, 0x00);
  1606	
  1607			/* Go to suspend mode */
  1608			sc16is7xx_power(&s->p[i].port, 0);
  1609		}
  1610	
  1611		sc16is7xx_setup_irda_ports(s);
  1612	
  1613		ret = sc16is7xx_setup_mctrl_ports(s, regmaps[0]);
  1614		if (ret)
  1615			goto out_ports;
  1616	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

