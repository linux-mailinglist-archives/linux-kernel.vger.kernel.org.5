Return-Path: <linux-kernel+bounces-77753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931D08609C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46E71C24638
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA831111AD;
	Fri, 23 Feb 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFx9cQwu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166510A09;
	Fri, 23 Feb 2024 04:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708661772; cv=none; b=H8Bg1JB4dbO6SLoNCxXgpkhWNOeRBoNZKMuC24sa9WxCs2sd8EmE/FLQG7KK3yGc9e1+wEJcysu5OukiGMNEfyrcc3wRmebSZvgZQkT0oZTvQmjQADNshSWExHz4Z3Dohq6fmaioWWnyDGETqDFUKuXpj5IB45E9T4476l0fcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708661772; c=relaxed/simple;
	bh=uQACqv/LN4pItI55fLVPYnrPZUxn/xcwGYiuzp+fwPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOzCe+Wh/tqqtQnjIW5uuVD7hnJPP1YgjhBq1zgKmUgGuhiKcZeodA5IDkYx9r0n0KCSNFs6UdMOeKwQrNBhjdy2WRurEnI4rE2aTdwjGCAgb9u7tcpwrJ349DtcDQN4anf8S9fVpbp518efQQBYY24aaWwm3b/95mHGcapAFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFx9cQwu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708661769; x=1740197769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uQACqv/LN4pItI55fLVPYnrPZUxn/xcwGYiuzp+fwPs=;
  b=BFx9cQwuYbhOl2zGW9MpBVBynH6SdmItn2FabY1HT0kP36ZdSbpdLq84
   5+I1U0C+8o46mQeaQzkSmY4zPx1qxt+zRKdJm7cWS7W72TNAiy/iXMljb
   t2xAH0vTGtaeQ7fLOZI1bHI4a+bJKeeeq3611P6kabChQ7uz7hQmEFMiy
   fUhd+bXS6/1PqcUS4dKutcUj3/2igBKikVyUpMa4blyU9Vskdub+rLo0C
   AFpBNJW1tiz9FvptdXfohWytiCdK/RFfCIyX8RiCeSJIqFdhZ4GUtt9qU
   gVJtpJeP8MIGq6K/oNEaR++uNW9bPuOmgX726ChtGtjS4MdhFMvn5+MC3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6744880"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6744880"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 20:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="936999972"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="936999972"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 20:15:53 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdMyG-00073A-2W;
	Fri, 23 Feb 2024 04:15:43 +0000
Date: Fri, 23 Feb 2024 12:14:38 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v1 06/14] serial: 8250_bcm7271: Switch to use
 uart_read_port_properties()
Message-ID: <202402231238.AWqLyIoM-lkp@intel.com>
References: <20240221183442.4124354-7-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221183442.4124354-7-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.8-rc5 next-20240222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/serial-core-Move-struct-uart_port-quirks-closer-to-possible-values/20240222-023850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240221183442.4124354-7-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 06/14] serial: 8250_bcm7271: Switch to use uart_read_port_properties()
config: hexagon-randconfig-r123-20240222 (https://download.01.org/0day-ci/archive/20240223/202402231238.AWqLyIoM-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 36adfec155de366d722f2bac8ff9162289dcf06c)
reproduce: (https://download.01.org/0day-ci/archive/20240223/202402231238.AWqLyIoM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402231238.AWqLyIoM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/serial/8250/8250_bcm7271.c:15:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from drivers/tty/serial/8250/8250_bcm7271.c:15:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/tty/serial/8250/8250_bcm7271.c:15:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
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
>> drivers/tty/serial/8250/8250_bcm7271.c:938:22: warning: unused variable 'np' [-Wunused-variable]
     938 |         struct device_node *np = pdev->dev.of_node;
         |                             ^~
   7 warnings generated.


vim +/np +938 drivers/tty/serial/8250/8250_bcm7271.c

41a469482de257e Al Cooper       2021-03-25   933  
41a469482de257e Al Cooper       2021-03-25   934  
41a469482de257e Al Cooper       2021-03-25   935  static int brcmuart_probe(struct platform_device *pdev)
41a469482de257e Al Cooper       2021-03-25   936  {
41a469482de257e Al Cooper       2021-03-25   937  	struct resource *regs;
41a469482de257e Al Cooper       2021-03-25  @938  	struct device_node *np = pdev->dev.of_node;
41a469482de257e Al Cooper       2021-03-25   939  	const struct of_device_id *of_id = NULL;
41a469482de257e Al Cooper       2021-03-25   940  	struct uart_8250_port *new_port;
41a469482de257e Al Cooper       2021-03-25   941  	struct device *dev = &pdev->dev;
41a469482de257e Al Cooper       2021-03-25   942  	struct brcmuart_priv *priv;
41a469482de257e Al Cooper       2021-03-25   943  	struct clk *baud_mux_clk;
41a469482de257e Al Cooper       2021-03-25   944  	struct uart_8250_port up;
8a66b31a15966ea Colin Ian King  2021-07-19   945  	void __iomem *membase = NULL;
41a469482de257e Al Cooper       2021-03-25   946  	resource_size_t mapbase = 0;
41a469482de257e Al Cooper       2021-03-25   947  	int ret;
41a469482de257e Al Cooper       2021-03-25   948  	int x;
41a469482de257e Al Cooper       2021-03-25   949  	int dma_irq;
41a469482de257e Al Cooper       2021-03-25   950  	static const char * const reg_names[REGS_MAX] = {
41a469482de257e Al Cooper       2021-03-25   951  		"uart", "dma_rx", "dma_tx", "dma_intr2", "dma_arb"
41a469482de257e Al Cooper       2021-03-25   952  	};
41a469482de257e Al Cooper       2021-03-25   953  
41a469482de257e Al Cooper       2021-03-25   954  	priv = devm_kzalloc(dev, sizeof(struct brcmuart_priv),
41a469482de257e Al Cooper       2021-03-25   955  			GFP_KERNEL);
41a469482de257e Al Cooper       2021-03-25   956  	if (!priv)
41a469482de257e Al Cooper       2021-03-25   957  		return -ENOMEM;
41a469482de257e Al Cooper       2021-03-25   958  
41a469482de257e Al Cooper       2021-03-25   959  	of_id = of_match_node(brcmuart_dt_ids, np);
41a469482de257e Al Cooper       2021-03-25   960  	if (!of_id || !of_id->data)
41a469482de257e Al Cooper       2021-03-25   961  		priv->rate_table = brcmstb_rate_table;
41a469482de257e Al Cooper       2021-03-25   962  	else
41a469482de257e Al Cooper       2021-03-25   963  		priv->rate_table = of_id->data;
41a469482de257e Al Cooper       2021-03-25   964  
41a469482de257e Al Cooper       2021-03-25   965  	for (x = 0; x < REGS_MAX; x++) {
41a469482de257e Al Cooper       2021-03-25   966  		regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
41a469482de257e Al Cooper       2021-03-25   967  						reg_names[x]);
41a469482de257e Al Cooper       2021-03-25   968  		if (!regs)
41a469482de257e Al Cooper       2021-03-25   969  			break;
41a469482de257e Al Cooper       2021-03-25   970  		priv->regs[x] =	devm_ioremap(dev, regs->start,
41a469482de257e Al Cooper       2021-03-25   971  					     resource_size(regs));
64b1510642f845d Wei Yongjun     2021-03-29   972  		if (!priv->regs[x])
64b1510642f845d Wei Yongjun     2021-03-29   973  			return -ENOMEM;
41a469482de257e Al Cooper       2021-03-25   974  		if (x == REGS_8250) {
41a469482de257e Al Cooper       2021-03-25   975  			mapbase = regs->start;
41a469482de257e Al Cooper       2021-03-25   976  			membase = priv->regs[x];
41a469482de257e Al Cooper       2021-03-25   977  		}
41a469482de257e Al Cooper       2021-03-25   978  	}
41a469482de257e Al Cooper       2021-03-25   979  
41a469482de257e Al Cooper       2021-03-25   980  	/* We should have just the uart base registers or all the registers */
c77247a52be2359 Andy Shevchenko 2023-09-18   981  	if (x != 1 && x != REGS_MAX)
c77247a52be2359 Andy Shevchenko 2023-09-18   982  		return dev_err_probe(dev, -EINVAL, "%s registers not specified\n",
c77247a52be2359 Andy Shevchenko 2023-09-18   983  				     reg_names[x]);
41a469482de257e Al Cooper       2021-03-25   984  
41a469482de257e Al Cooper       2021-03-25   985  	/* if the DMA registers were specified, try to enable DMA */
41a469482de257e Al Cooper       2021-03-25   986  	if (x > REGS_DMA_RX) {
41a469482de257e Al Cooper       2021-03-25   987  		if (brcmuart_arbitration(priv, 1) == 0) {
41a469482de257e Al Cooper       2021-03-25   988  			u32 txrev = 0;
41a469482de257e Al Cooper       2021-03-25   989  			u32 rxrev = 0;
41a469482de257e Al Cooper       2021-03-25   990  
41a469482de257e Al Cooper       2021-03-25   991  			txrev = udma_readl(priv, REGS_DMA_RX, UDMA_RX_REVISION);
41a469482de257e Al Cooper       2021-03-25   992  			rxrev = udma_readl(priv, REGS_DMA_TX, UDMA_TX_REVISION);
41a469482de257e Al Cooper       2021-03-25   993  			if ((txrev >= UDMA_TX_REVISION_REQUIRED) &&
41a469482de257e Al Cooper       2021-03-25   994  				(rxrev >= UDMA_RX_REVISION_REQUIRED)) {
41a469482de257e Al Cooper       2021-03-25   995  
41a469482de257e Al Cooper       2021-03-25   996  				/* Enable the use of the DMA hardware */
41a469482de257e Al Cooper       2021-03-25   997  				priv->dma_enabled = true;
41a469482de257e Al Cooper       2021-03-25   998  			} else {
41a469482de257e Al Cooper       2021-03-25   999  				brcmuart_arbitration(priv, 0);
41a469482de257e Al Cooper       2021-03-25  1000  				dev_err(dev,
41a469482de257e Al Cooper       2021-03-25  1001  					"Unsupported DMA Hardware Revision\n");
41a469482de257e Al Cooper       2021-03-25  1002  			}
41a469482de257e Al Cooper       2021-03-25  1003  		} else {
41a469482de257e Al Cooper       2021-03-25  1004  			dev_err(dev,
41a469482de257e Al Cooper       2021-03-25  1005  				"Timeout arbitrating for UART DMA hardware\n");
41a469482de257e Al Cooper       2021-03-25  1006  		}
41a469482de257e Al Cooper       2021-03-25  1007  	}
41a469482de257e Al Cooper       2021-03-25  1008  
19010c5b7125670 Andy Shevchenko 2024-02-21  1009  	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
19010c5b7125670 Andy Shevchenko 2024-02-21  1010  
19010c5b7125670 Andy Shevchenko 2024-02-21  1011  	memset(&up, 0, sizeof(up));
19010c5b7125670 Andy Shevchenko 2024-02-21  1012  	up.port.type = PORT_BCM7271;
19010c5b7125670 Andy Shevchenko 2024-02-21  1013  	up.port.dev = dev;
19010c5b7125670 Andy Shevchenko 2024-02-21  1014  	up.port.mapbase = mapbase;
19010c5b7125670 Andy Shevchenko 2024-02-21  1015  	up.port.membase = membase;
19010c5b7125670 Andy Shevchenko 2024-02-21  1016  	up.port.handle_irq = brcmuart_handle_irq;
19010c5b7125670 Andy Shevchenko 2024-02-21  1017  	up.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
19010c5b7125670 Andy Shevchenko 2024-02-21  1018  	up.port.private_data = priv;
19010c5b7125670 Andy Shevchenko 2024-02-21  1019  
19010c5b7125670 Andy Shevchenko 2024-02-21  1020  	ret = uart_read_port_properties(&up.port, true);
19010c5b7125670 Andy Shevchenko 2024-02-21  1021  	if (ret)
19010c5b7125670 Andy Shevchenko 2024-02-21  1022  		goto release_dma;
19010c5b7125670 Andy Shevchenko 2024-02-21  1023  
19010c5b7125670 Andy Shevchenko 2024-02-21  1024  	up.port.regshift = 2;
19010c5b7125670 Andy Shevchenko 2024-02-21  1025  	up.port.iotype = device_is_big_endian(dev) ? UPIO_MEM32BE : UPIO_MEM32;
41a469482de257e Al Cooper       2021-03-25  1026  
41a469482de257e Al Cooper       2021-03-25  1027  	/* See if a Baud clock has been specified */
1f34e3defb5c0a0 Andy Shevchenko 2023-10-05  1028  	baud_mux_clk = devm_clk_get_optional_enabled(dev, "sw_baud");
1f34e3defb5c0a0 Andy Shevchenko 2023-10-05  1029  	ret = PTR_ERR_OR_ZERO(baud_mux_clk);
41a469482de257e Al Cooper       2021-03-25  1030  	if (ret)
15ac1122fd6d4bf Doug Berger     2023-03-09  1031  		goto release_dma;
1f34e3defb5c0a0 Andy Shevchenko 2023-10-05  1032  	if (baud_mux_clk) {
1f34e3defb5c0a0 Andy Shevchenko 2023-10-05  1033  		dev_dbg(dev, "BAUD MUX clock found\n");
1f34e3defb5c0a0 Andy Shevchenko 2023-10-05  1034  
41a469482de257e Al Cooper       2021-03-25  1035  		priv->baud_mux_clk = baud_mux_clk;
41a469482de257e Al Cooper       2021-03-25  1036  		init_real_clk_rates(dev, priv);
19010c5b7125670 Andy Shevchenko 2024-02-21  1037  		up.port.uartclk = priv->default_mux_rate;
1f34e3defb5c0a0 Andy Shevchenko 2023-10-05  1038  	} else {
1f34e3defb5c0a0 Andy Shevchenko 2023-10-05  1039  		dev_dbg(dev, "BAUD MUX clock not specified\n");
41a469482de257e Al Cooper       2021-03-25  1040  	}
41a469482de257e Al Cooper       2021-03-25  1041  
41a469482de257e Al Cooper       2021-03-25  1042  	/* setup HR timer */
41a469482de257e Al Cooper       2021-03-25  1043  	hrtimer_init(&priv->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
41a469482de257e Al Cooper       2021-03-25  1044  	priv->hrt.function = brcmuart_hrtimer_func;
41a469482de257e Al Cooper       2021-03-25  1045  
41a469482de257e Al Cooper       2021-03-25  1046  	up.port.shutdown = brcmuart_shutdown;
41a469482de257e Al Cooper       2021-03-25  1047  	up.port.startup = brcmuart_startup;
41a469482de257e Al Cooper       2021-03-25  1048  	up.port.throttle = brcmuart_throttle;
41a469482de257e Al Cooper       2021-03-25  1049  	up.port.unthrottle = brcmuart_unthrottle;
41a469482de257e Al Cooper       2021-03-25  1050  	up.port.set_termios = brcmstb_set_termios;
41a469482de257e Al Cooper       2021-03-25  1051  
41a469482de257e Al Cooper       2021-03-25  1052  	if (priv->dma_enabled) {
41a469482de257e Al Cooper       2021-03-25  1053  		priv->rx_size = RX_BUF_SIZE * RX_BUFS_COUNT;
41a469482de257e Al Cooper       2021-03-25  1054  		priv->rx_bufs = dma_alloc_coherent(dev,
41a469482de257e Al Cooper       2021-03-25  1055  						   priv->rx_size,
41a469482de257e Al Cooper       2021-03-25  1056  						   &priv->rx_addr, GFP_KERNEL);
c195438f1e84de8 Lad Prabhakar   2021-12-24  1057  		if (!priv->rx_bufs) {
0e479b460e342c5 Lad Prabhakar   2022-01-05  1058  			ret = -ENOMEM;
41a469482de257e Al Cooper       2021-03-25  1059  			goto err;
c195438f1e84de8 Lad Prabhakar   2021-12-24  1060  		}
41a469482de257e Al Cooper       2021-03-25  1061  		priv->tx_size = UART_XMIT_SIZE;
41a469482de257e Al Cooper       2021-03-25  1062  		priv->tx_buf = dma_alloc_coherent(dev,
41a469482de257e Al Cooper       2021-03-25  1063  						  priv->tx_size,
41a469482de257e Al Cooper       2021-03-25  1064  						  &priv->tx_addr, GFP_KERNEL);
c195438f1e84de8 Lad Prabhakar   2021-12-24  1065  		if (!priv->tx_buf) {
0e479b460e342c5 Lad Prabhakar   2022-01-05  1066  			ret = -ENOMEM;
41a469482de257e Al Cooper       2021-03-25  1067  			goto err;
41a469482de257e Al Cooper       2021-03-25  1068  		}
c195438f1e84de8 Lad Prabhakar   2021-12-24  1069  	}
41a469482de257e Al Cooper       2021-03-25  1070  
41a469482de257e Al Cooper       2021-03-25  1071  	ret = serial8250_register_8250_port(&up);
41a469482de257e Al Cooper       2021-03-25  1072  	if (ret < 0) {
c77247a52be2359 Andy Shevchenko 2023-09-18  1073  		dev_err_probe(dev, ret, "unable to register 8250 port\n");
41a469482de257e Al Cooper       2021-03-25  1074  		goto err;
41a469482de257e Al Cooper       2021-03-25  1075  	}
41a469482de257e Al Cooper       2021-03-25  1076  	priv->line = ret;
41a469482de257e Al Cooper       2021-03-25  1077  	new_port = serial8250_get_port(ret);
41a469482de257e Al Cooper       2021-03-25  1078  	priv->up = &new_port->port;
41a469482de257e Al Cooper       2021-03-25  1079  	if (priv->dma_enabled) {
41a469482de257e Al Cooper       2021-03-25  1080  		dma_irq = platform_get_irq_byname(pdev,  "dma");
41a469482de257e Al Cooper       2021-03-25  1081  		if (dma_irq < 0) {
c77247a52be2359 Andy Shevchenko 2023-09-18  1082  			ret = dev_err_probe(dev, dma_irq, "no IRQ resource info\n");
41a469482de257e Al Cooper       2021-03-25  1083  			goto err1;
41a469482de257e Al Cooper       2021-03-25  1084  		}
41a469482de257e Al Cooper       2021-03-25  1085  		ret = devm_request_irq(dev, dma_irq, brcmuart_isr,
41a469482de257e Al Cooper       2021-03-25  1086  				IRQF_SHARED, "uart DMA irq", &new_port->port);
41a469482de257e Al Cooper       2021-03-25  1087  		if (ret) {
c77247a52be2359 Andy Shevchenko 2023-09-18  1088  			dev_err_probe(dev, ret, "unable to register IRQ handler\n");
41a469482de257e Al Cooper       2021-03-25  1089  			goto err1;
41a469482de257e Al Cooper       2021-03-25  1090  		}
41a469482de257e Al Cooper       2021-03-25  1091  	}
41a469482de257e Al Cooper       2021-03-25  1092  	platform_set_drvdata(pdev, priv);
41a469482de257e Al Cooper       2021-03-25  1093  	brcmuart_init_debugfs(priv, dev_name(&pdev->dev));
41a469482de257e Al Cooper       2021-03-25  1094  	return 0;
41a469482de257e Al Cooper       2021-03-25  1095  
41a469482de257e Al Cooper       2021-03-25  1096  err1:
41a469482de257e Al Cooper       2021-03-25  1097  	serial8250_unregister_port(priv->line);
41a469482de257e Al Cooper       2021-03-25  1098  err:
41a469482de257e Al Cooper       2021-03-25  1099  	brcmuart_free_bufs(dev, priv);
15ac1122fd6d4bf Doug Berger     2023-03-09  1100  release_dma:
15ac1122fd6d4bf Doug Berger     2023-03-09  1101  	if (priv->dma_enabled)
41a469482de257e Al Cooper       2021-03-25  1102  		brcmuart_arbitration(priv, 0);
c195438f1e84de8 Lad Prabhakar   2021-12-24  1103  	return ret;
41a469482de257e Al Cooper       2021-03-25  1104  }
41a469482de257e Al Cooper       2021-03-25  1105  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

