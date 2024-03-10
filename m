Return-Path: <linux-kernel+bounces-98136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239EE877585
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 07:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBD61F22F18
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB82818646;
	Sun, 10 Mar 2024 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gApQwLft"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E11DFD6;
	Sun, 10 Mar 2024 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710051484; cv=none; b=l+kf7XZ2nh+HI3foEq8JJSkpWnrheONuu3LSDeeYWn4GLiYgyetLGPwj1W6evmMe7qAmriaTS8MAh66rqtpfV4+/R6BsHNkaBL0qQ6ctuZdZ7GtTTmxF7AssMU1SvwbZf2ZLiWgA3ncqBWsVhCb582koT2Fv5J04ci46T9zbKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710051484; c=relaxed/simple;
	bh=Qd7HC+q9d5knYtY9e/+g+fegud7ueRr738wWcWZ6po8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCVag6TvDuzlOGifIjHGIkbAHnp4Er1084CIttlBit2XyIih3vvrPnakFXk3SUk4rQEp0uoLUDO/eXA7DZhVv0x/re1MlSJplITLXcNOnQGKJdtfSTkHW0wyFS6ztN5EbOYWiy9V7ir2Q4mSj2jBLU0O/pHMf+GsYL4t5SZbFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gApQwLft; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710051483; x=1741587483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qd7HC+q9d5knYtY9e/+g+fegud7ueRr738wWcWZ6po8=;
  b=gApQwLft/Fq9I9Sbc8rgj6iZmTXICJZoRSK3nosB7ysQ8HQzwVMH0bkl
   XQojjwqktVwx3pkhfEGn3M2S5FB9BDp4zZUQ92NarJ5JBC+d6gLo+30ra
   0E4xXcE214N/9VTujEF1fQiorIsCdrZ2/OdMdBFeWb04wymRqbTvyndla
   d5f+bq88DcklKlBfCCVemTVbEqWlDVJhDWLmi9MH4sM5FGeowvmQUf+4+
   SBreCbfdG5ThBaZDQmpLVZeDw7Com/j9gpWoPllh1yFgxE0eG1PRJwpjO
   dP365y187bhBYQn9CanbtS0XzDXRhLfBp7rmUp5PEilmaTeo8awgPpOwZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="16165726"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="16165726"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 22:18:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="48307298"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Mar 2024 22:17:57 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjCVO-000807-2e;
	Sun, 10 Mar 2024 06:17:54 +0000
Date: Sun, 10 Mar 2024 14:16:55 +0800
From: kernel test robot <lkp@intel.com>
To: Howard Yen <howardyen@google.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, mathias.nyman@intel.com, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com,
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com,
	masahiroy@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	iommu@lists.linux.dev, Howard Yen <howardyen@google.com>
Subject: Re: [PATCH v4 2/2] usb: host: xhci-plat: add support for multi
 memory regions
Message-ID: <202403101417.3D62qONB-lkp@intel.com>
References: <20240308095320.1961469-3-howardyen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308095320.1961469-3-howardyen@google.com>

Hi Howard,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.8-rc7 next-20240308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Howard-Yen/dma-coherent-add-support-for-multi-coherent-rmems-per-dev/20240308-175649
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240308095320.1961469-3-howardyen%40google.com
patch subject: [PATCH v4 2/2] usb: host: xhci-plat: add support for multi memory regions
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240310/202403101417.3D62qONB-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 503c55e17037436dcd45ac69dea8967e67e3f5e8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240310/202403101417.3D62qONB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403101417.3D62qONB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/usb/host/xhci-plat.c:12:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/usb/host/xhci-plat.c:201:9: error: call to undeclared function 'of_reserved_mem_device_init_by_idx'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     201 |                 ret = of_reserved_mem_device_init_by_idx(sysdev, sysdev->of_node, i);
         |                       ^
>> drivers/usb/host/xhci-plat.c:205:5: error: call to undeclared function 'of_reserved_mem_device_release'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     205 |                                 of_reserved_mem_device_release(sysdev);
         |                                 ^
   drivers/usb/host/xhci-plat.c:169:42: warning: shift count >= width of type [-Wshift-count-overflow]
     169 |         ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
         |                                                 ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   drivers/usb/host/xhci-plat.c:409:46: warning: shift count >= width of type [-Wshift-count-overflow]
     409 |                 ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
         |                                                            ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   drivers/usb/host/xhci-plat.c:449:2: error: call to undeclared function 'of_reserved_mem_device_release'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     449 |         of_reserved_mem_device_release(hcd->self.sysdev);
         |         ^
   3 warnings and 3 errors generated.


vim +/of_reserved_mem_device_init_by_idx +201 drivers/usb/host/xhci-plat.c

  > 12	#include <linux/dma-mapping.h>
    13	#include <linux/module.h>
    14	#include <linux/pci.h>
    15	#include <linux/of.h>
    16	#include <linux/of_device.h>
    17	#include <linux/platform_device.h>
    18	#include <linux/usb/phy.h>
    19	#include <linux/slab.h>
    20	#include <linux/acpi.h>
    21	#include <linux/usb/of.h>
    22	#include <linux/reset.h>
    23	
    24	#include "xhci.h"
    25	#include "xhci-plat.h"
    26	#include "xhci-mvebu.h"
    27	
    28	static struct hc_driver __read_mostly xhci_plat_hc_driver;
    29	
    30	static int xhci_plat_setup(struct usb_hcd *hcd);
    31	static int xhci_plat_start(struct usb_hcd *hcd);
    32	
    33	static const struct xhci_driver_overrides xhci_plat_overrides __initconst = {
    34		.extra_priv_size = sizeof(struct xhci_plat_priv),
    35		.reset = xhci_plat_setup,
    36		.start = xhci_plat_start,
    37	};
    38	
    39	static void xhci_priv_plat_start(struct usb_hcd *hcd)
    40	{
    41		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
    42	
    43		if (priv->plat_start)
    44			priv->plat_start(hcd);
    45	}
    46	
    47	static int xhci_priv_init_quirk(struct usb_hcd *hcd)
    48	{
    49		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
    50	
    51		if (!priv->init_quirk)
    52			return 0;
    53	
    54		return priv->init_quirk(hcd);
    55	}
    56	
    57	static int xhci_priv_suspend_quirk(struct usb_hcd *hcd)
    58	{
    59		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
    60	
    61		if (!priv->suspend_quirk)
    62			return 0;
    63	
    64		return priv->suspend_quirk(hcd);
    65	}
    66	
    67	static int xhci_priv_resume_quirk(struct usb_hcd *hcd)
    68	{
    69		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
    70	
    71		if (!priv->resume_quirk)
    72			return 0;
    73	
    74		return priv->resume_quirk(hcd);
    75	}
    76	
    77	static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
    78	{
    79		struct xhci_plat_priv *priv = xhci_to_priv(xhci);
    80	
    81		xhci->quirks |= priv->quirks;
    82	}
    83	
    84	/* called during probe() after chip reset completes */
    85	static int xhci_plat_setup(struct usb_hcd *hcd)
    86	{
    87		int ret;
    88	
    89	
    90		ret = xhci_priv_init_quirk(hcd);
    91		if (ret)
    92			return ret;
    93	
    94		return xhci_gen_setup(hcd, xhci_plat_quirks);
    95	}
    96	
    97	static int xhci_plat_start(struct usb_hcd *hcd)
    98	{
    99		xhci_priv_plat_start(hcd);
   100		return xhci_run(hcd);
   101	}
   102	
   103	#ifdef CONFIG_OF
   104	static const struct xhci_plat_priv xhci_plat_marvell_armada = {
   105		.init_quirk = xhci_mvebu_mbus_init_quirk,
   106	};
   107	
   108	static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
   109		.init_quirk = xhci_mvebu_a3700_init_quirk,
   110	};
   111	
   112	static const struct xhci_plat_priv xhci_plat_brcm = {
   113		.quirks = XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS,
   114	};
   115	
   116	static const struct of_device_id usb_xhci_of_match[] = {
   117		{
   118			.compatible = "generic-xhci",
   119		}, {
   120			.compatible = "xhci-platform",
   121		}, {
   122			.compatible = "marvell,armada-375-xhci",
   123			.data = &xhci_plat_marvell_armada,
   124		}, {
   125			.compatible = "marvell,armada-380-xhci",
   126			.data = &xhci_plat_marvell_armada,
   127		}, {
   128			.compatible = "marvell,armada3700-xhci",
   129			.data = &xhci_plat_marvell_armada3700,
   130		}, {
   131			.compatible = "brcm,xhci-brcm-v2",
   132			.data = &xhci_plat_brcm,
   133		}, {
   134			.compatible = "brcm,bcm2711-xhci",
   135			.data = &xhci_plat_brcm,
   136		}, {
   137			.compatible = "brcm,bcm7445-xhci",
   138			.data = &xhci_plat_brcm,
   139		},
   140		{},
   141	};
   142	MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
   143	#endif
   144	
   145	int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const struct xhci_plat_priv *priv_match)
   146	{
   147		const struct hc_driver	*driver;
   148		struct device		*tmpdev;
   149		struct xhci_hcd		*xhci;
   150		struct resource         *res;
   151		struct usb_hcd		*hcd, *usb3_hcd;
   152		int			i, count, ret;
   153		int			irq;
   154		struct xhci_plat_priv	*priv = NULL;
   155		bool			of_match;
   156	
   157		if (usb_disabled())
   158			return -ENODEV;
   159	
   160		driver = &xhci_plat_hc_driver;
   161	
   162		irq = platform_get_irq(pdev, 0);
   163		if (irq < 0)
   164			return irq;
   165	
   166		if (!sysdev)
   167			sysdev = &pdev->dev;
   168	
   169		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
   170		if (ret)
   171			return ret;
   172	
   173		pm_runtime_set_active(&pdev->dev);
   174		pm_runtime_enable(&pdev->dev);
   175		pm_runtime_get_noresume(&pdev->dev);
   176	
   177		hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
   178				       dev_name(&pdev->dev), NULL);
   179		if (!hcd) {
   180			ret = -ENOMEM;
   181			goto disable_runtime;
   182		}
   183	
   184		hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
   185		if (IS_ERR(hcd->regs)) {
   186			ret = PTR_ERR(hcd->regs);
   187			goto put_hcd;
   188		}
   189	
   190		hcd->rsrc_start = res->start;
   191		hcd->rsrc_len = resource_size(res);
   192	
   193		xhci = hcd_to_xhci(hcd);
   194	
   195		xhci->allow_single_roothub = 1;
   196	
   197		count = of_property_count_elems_of_size(sysdev->of_node, "memory-region",
   198							sizeof(u32));
   199	
   200		for (i = 0; i < count; i++) {
 > 201			ret = of_reserved_mem_device_init_by_idx(sysdev, sysdev->of_node, i);
   202			if (ret) {
   203				dev_err(sysdev, "Could not get reserved memory\n");
   204				if (i > 0)
 > 205					of_reserved_mem_device_release(sysdev);
   206	
   207				return ret;
   208			}
   209		}
   210	
   211		/*
   212		 * Not all platforms have clks so it is not an error if the
   213		 * clock do not exist.
   214		 */
   215		xhci->reg_clk = devm_clk_get_optional(&pdev->dev, "reg");
   216		if (IS_ERR(xhci->reg_clk)) {
   217			ret = PTR_ERR(xhci->reg_clk);
   218			goto put_hcd;
   219		}
   220	
   221		xhci->clk = devm_clk_get_optional(&pdev->dev, NULL);
   222		if (IS_ERR(xhci->clk)) {
   223			ret = PTR_ERR(xhci->clk);
   224			goto put_hcd;
   225		}
   226	
   227		xhci->reset = devm_reset_control_array_get_optional_shared(&pdev->dev);
   228		if (IS_ERR(xhci->reset)) {
   229			ret = PTR_ERR(xhci->reset);
   230			goto put_hcd;
   231		}
   232	
   233		ret = reset_control_deassert(xhci->reset);
   234		if (ret)
   235			goto put_hcd;
   236	
   237		ret = clk_prepare_enable(xhci->reg_clk);
   238		if (ret)
   239			goto err_reset;
   240	
   241		ret = clk_prepare_enable(xhci->clk);
   242		if (ret)
   243			goto disable_reg_clk;
   244	
   245		if (priv_match) {
   246			priv = hcd_to_xhci_priv(hcd);
   247			/* Just copy data for now */
   248			*priv = *priv_match;
   249		}
   250	
   251		device_set_wakeup_capable(&pdev->dev, true);
   252	
   253		xhci->main_hcd = hcd;
   254	
   255		/* imod_interval is the interrupt moderation value in nanoseconds. */
   256		xhci->imod_interval = 40000;
   257	
   258		/* Iterate over all parent nodes for finding quirks */
   259		for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
   260	
   261			if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
   262				xhci->quirks |= XHCI_HW_LPM_DISABLE;
   263	
   264			if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
   265				xhci->quirks |= XHCI_LPM_SUPPORT;
   266	
   267			if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
   268				xhci->quirks |= XHCI_BROKEN_PORT_PED;
   269	
   270			if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
   271				xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
   272	
   273			device_property_read_u32(tmpdev, "imod-interval-ns",
   274						 &xhci->imod_interval);
   275		}
   276	
   277		/*
   278		 * Drivers such as dwc3 manages PHYs themself (and rely on driver name
   279		 * matching for the xhci platform device).
   280		 */
   281		of_match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
   282		if (of_match) {
   283			hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
   284			if (IS_ERR(hcd->usb_phy)) {
   285				ret = PTR_ERR(hcd->usb_phy);
   286				if (ret == -EPROBE_DEFER)
   287					goto disable_clk;
   288				hcd->usb_phy = NULL;
   289			} else {
   290				ret = usb_phy_init(hcd->usb_phy);
   291				if (ret)
   292					goto disable_clk;
   293			}
   294		}
   295	
   296		hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
   297	
   298		if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
   299			hcd->skip_phy_initialization = 1;
   300	
   301		if (priv && (priv->quirks & XHCI_SG_TRB_CACHE_SIZE_QUIRK))
   302			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
   303	
   304		ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
   305		if (ret)
   306			goto disable_usb_phy;
   307	
   308		if (!xhci_has_one_roothub(xhci)) {
   309			xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
   310							    dev_name(&pdev->dev), hcd);
   311			if (!xhci->shared_hcd) {
   312				ret = -ENOMEM;
   313				goto dealloc_usb2_hcd;
   314			}
   315	
   316			if (of_match) {
   317				xhci->shared_hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev,
   318											"usb-phy", 1);
   319				if (IS_ERR(xhci->shared_hcd->usb_phy)) {
   320					xhci->shared_hcd->usb_phy = NULL;
   321				} else {
   322					ret = usb_phy_init(xhci->shared_hcd->usb_phy);
   323					if (ret)
   324						dev_err(sysdev, "%s init usb3phy fail (ret=%d)\n",
   325							__func__, ret);
   326				}
   327			}
   328	
   329			xhci->shared_hcd->tpl_support = hcd->tpl_support;
   330		}
   331	
   332		usb3_hcd = xhci_get_usb3_hcd(xhci);
   333		if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4)
   334			usb3_hcd->can_do_streams = 1;
   335	
   336		if (xhci->shared_hcd) {
   337			ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
   338			if (ret)
   339				goto put_usb3_hcd;
   340		}
   341	
   342		device_enable_async_suspend(&pdev->dev);
   343		pm_runtime_put_noidle(&pdev->dev);
   344	
   345		/*
   346		 * Prevent runtime pm from being on as default, users should enable
   347		 * runtime pm using power/control in sysfs.
   348		 */
   349		pm_runtime_forbid(&pdev->dev);
   350	
   351		return 0;
   352	
   353	
   354	put_usb3_hcd:
   355		usb_put_hcd(xhci->shared_hcd);
   356	
   357	dealloc_usb2_hcd:
   358		usb_remove_hcd(hcd);
   359	
   360	disable_usb_phy:
   361		usb_phy_shutdown(hcd->usb_phy);
   362	
   363	disable_clk:
   364		clk_disable_unprepare(xhci->clk);
   365	
   366	disable_reg_clk:
   367		clk_disable_unprepare(xhci->reg_clk);
   368	
   369	err_reset:
   370		reset_control_assert(xhci->reset);
   371	
   372	put_hcd:
   373		usb_put_hcd(hcd);
   374	
   375	disable_runtime:
   376		pm_runtime_put_noidle(&pdev->dev);
   377		pm_runtime_disable(&pdev->dev);
   378	
   379		return ret;
   380	}
   381	EXPORT_SYMBOL_GPL(xhci_plat_probe);
   382	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

