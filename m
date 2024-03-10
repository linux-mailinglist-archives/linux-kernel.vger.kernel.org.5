Return-Path: <linux-kernel+bounces-98138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C3887758A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 07:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6560B28367E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE061C6AD;
	Sun, 10 Mar 2024 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huC9GH0W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8C125CB;
	Sun, 10 Mar 2024 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710052145; cv=none; b=IEPedzFOVcJgZpufkgE8uKhsL+XLdJHeI2xu1m95asH2BC+CN8t6atI1bXRm7S7CWOGM9b6lrsHW1mpa5uUUctF9Xix8yBGbQeGytIWR7d3VsLwWYGYcxlb6nhIgWifEizkTyCNoznD/6yR7l0RcH3f3KkCCmuv/ngKoqp/oRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710052145; c=relaxed/simple;
	bh=01m+kPN27F7ulBBXRzWG+6qNsRfLAik1JnnMPebFFRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbjvoBOrGUyZ7/D1UPL5r+nrmFql+ExBbfNrE9FkO1HNN/tePj5OhkearRmrJdalylL7pRAeq4+M2oc1ZMenhtiIwY3rC4NOqIDswLY2hSyQh7mIDDan0wvdsyYzalFU+xyXZ9H09vD61Iyw0tiMqo8nk/+bUS4zgn918tA0IjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huC9GH0W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710052144; x=1741588144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=01m+kPN27F7ulBBXRzWG+6qNsRfLAik1JnnMPebFFRQ=;
  b=huC9GH0WMPRb5dpGXhKVo16JWHqqWqzV3pWa2Lyv4pA4VwAzdD1kAWJM
   VxlGXT5Rg1IuqrsW0qRXpEmbbozFrKkLvlD+iYkiwqcqVMG6dU2wDks4A
   OENVz/y/5iGkzLKqEcF3hMO651RRYZo7/4BYDY3P2QzE3RdjsyHaFNgA2
   rixcwdJozJWnybDASks5PFBqAxhbI3tVUfuLlJpCMbxH7Xy0qSUI7mh76
   3Pejry96D4BtCJo3kzXsfd6xISuK1Sc5cL4Y3Ka/4DjMqFUSpVyD4JqRy
   9PUBTvXoKpB/INUY9/oLCzzomS3Ln++FxtDI08sAy9OXVJWn0kPwb5RaE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="5329036"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="5329036"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 22:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="11253614"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Mar 2024 22:28:58 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjCg3-00080Z-0T;
	Sun, 10 Mar 2024 06:28:55 +0000
Date: Sun, 10 Mar 2024 14:27:55 +0800
From: kernel test robot <lkp@intel.com>
To: Howard Yen <howardyen@google.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, mathias.nyman@intel.com, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com,
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com,
	masahiroy@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, iommu@lists.linux.dev,
	Howard Yen <howardyen@google.com>
Subject: Re: [PATCH v4 2/2] usb: host: xhci-plat: add support for multi
 memory regions
Message-ID: <202403101400.PHmsnLOh-lkp@intel.com>
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240310/202403101400.PHmsnLOh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240310/202403101400.PHmsnLOh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403101400.PHmsnLOh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/host/xhci-plat.c: In function 'xhci_plat_probe':
>> drivers/usb/host/xhci-plat.c:201:23: error: implicit declaration of function 'of_reserved_mem_device_init_by_idx' [-Werror=implicit-function-declaration]
     201 |                 ret = of_reserved_mem_device_init_by_idx(sysdev, sysdev->of_node, i);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/xhci-plat.c:205:33: error: implicit declaration of function 'of_reserved_mem_device_release' [-Werror=implicit-function-declaration]
     205 |                                 of_reserved_mem_device_release(sysdev);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/of_reserved_mem_device_init_by_idx +201 drivers/usb/host/xhci-plat.c

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

