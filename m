Return-Path: <linux-kernel+bounces-36732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2848583A5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB4C1C272AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AD5182A1;
	Wed, 24 Jan 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZOnnVuR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ACE17C6C;
	Wed, 24 Jan 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089265; cv=none; b=Bw77UBthAogOSuZu8EFqfFtUdS0vGkMO1nB7R14cktHJxKiYUSqqo4V+wb5iVv8v/8zbV8AImigVF9ILjfd9rTeDPerGeraNXf7X/cM7GrfixmajYp+NNcShU6GqFhe2cd19jo53RXplwIrt7ESZLP3G0XVhc4RbXgYkH/x+2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089265; c=relaxed/simple;
	bh=+lkuKTCv3wUHbUhaYST2gExklAngKX84H00lKlFUXx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyCUYwmuKTmSqDgB9iFzaUHz2DIJhlk8N9L8FCxxdexcRJ5ISvAPZta0lOrXmnKUbaCVc89z7Hm95QIn+gItGgUZxdxlxJzf6lxdFBsLbp2JTwIaK3R02GUK5fx/PDRAQ9mEn76C9dlsdlcE5BeVCjJo66AFC+pHdI7PbzyIHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZOnnVuR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706089264; x=1737625264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+lkuKTCv3wUHbUhaYST2gExklAngKX84H00lKlFUXx4=;
  b=gZOnnVuRoxS62GQ3XR9eHGJzwTQVBwGfZoBcnL1NndO3TPZ4aUHmZUOb
   /ztTT3KIEXlK24s26ehFLPS2Sf0IDLCU8mcv2ZJnFMfhcMICluI6doIfA
   xJQfnbo2JoPRDoElgxg5tecE1Xnq5A9doA2BSxHhCRs90JRxC4RLNXAcT
   k2hE0Cjl490h4zUwsQrOdIwAJOBr7IaG2aigBqm37xtocuO6hKKA6Sozr
   lf42wMPrTcydBT0lYSuCIulv8IE11CWAzS/G7rg34jGiRuktTgvX05QkF
   aV6yvH2xqLJKEE1/WrBeruDOXe2aL9OD1uLPDk2pBXBWYDiEutZSfqe5O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="693417"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="693417"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 01:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735868699"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735868699"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2024 01:40:58 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSZke-00081p-13;
	Wed, 24 Jan 2024 09:40:56 +0000
Date: Wed, 24 Jan 2024 17:40:39 +0800
From: kernel test robot <lkp@intel.com>
To: Ziyang Huang <hzyitc@outlook.com>, mcoquelin.stm32@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [PATCH 3/8] net: stmmac: Introduce Qualcomm IPQ50xx DWMAC driver
Message-ID: <202401241733.H4p1Af19-lkp@intel.com>
References: <TYZPR01MB5556B8833322A83632709631C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB5556B8833322A83632709631C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

Hi Ziyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on clk/clk-next pza/reset/next linus/master v6.8-rc1 next-20240123]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziyang-Huang/net-phy-Introduce-Qualcomm-IPQ5018-internal-PHY-driver/20240121-204840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/TYZPR01MB5556B8833322A83632709631C9762%40TYZPR01MB5556.apcprd01.prod.exchangelabs.com
patch subject: [PATCH 3/8] net: stmmac: Introduce Qualcomm IPQ50xx DWMAC driver
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20240124/202401241733.H4p1Af19-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240124/202401241733.H4p1Af19-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401241733.H4p1Af19-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-ipq50xx.c: In function 'ipq50xx_gmac_probe':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-ipq50xx.c:94:20: error: implicit declaration of function 'stmmac_probe_config_dt'; did you mean 'devm_stmmac_probe_config_dt'? [-Werror=implicit-function-declaration]
      94 |         plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
         |                    ^~~~~~~~~~~~~~~~~~~~~~
         |                    devm_stmmac_probe_config_dt
>> drivers/net/ethernet/stmicro/stmmac/dwmac-ipq50xx.c:94:18: warning: assignment to 'struct plat_stmmacenet_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      94 |         plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
         |                  ^
   cc1: some warnings being treated as errors


vim +94 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq50xx.c

    80	
    81	static int ipq50xx_gmac_probe(struct platform_device *pdev)
    82	{
    83		struct device *dev = &pdev->dev;
    84		struct stmmac_resources stmmac_res;
    85		struct plat_stmmacenet_data *plat_dat;
    86		struct ipq50xx_gmac *gmac;
    87		int ret;
    88	
    89		ret = stmmac_get_platform_resources(pdev, &stmmac_res);
    90		if (ret)
    91			return dev_err_probe(dev, ret,
    92					     "failed to get stmmac platform resources\n");
    93	
  > 94		plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
    95		if (IS_ERR_OR_NULL(plat_dat))
    96			return dev_err_probe(dev, PTR_ERR(plat_dat),
    97					     "failed to parse stmmac dt parameters\n");
    98	
    99		gmac = devm_kzalloc(dev, sizeof(*gmac), GFP_KERNEL);
   100		if (!gmac)
   101			return dev_err_probe(dev, -ENOMEM,
   102					     "failed to allocate priv\n");
   103	
   104		gmac->dev = dev;
   105	
   106		memcpy(gmac->clks, ipq50xx_gmac_clks, sizeof(gmac->clks));
   107		ret = devm_clk_bulk_get_optional(dev, ARRAY_SIZE(gmac->clks), gmac->clks);
   108		if (ret)
   109			return dev_err_probe(dev, ret,
   110					     "failed to acquire clocks\n");
   111	
   112		ret = clk_bulk_prepare_enable(ARRAY_SIZE(gmac->clks), gmac->clks);
   113		if (ret)
   114			return dev_err_probe(dev, ret,
   115					     "failed to enable clocks\n");
   116	
   117		gmac->rst = devm_reset_control_array_get_exclusive(dev);
   118		if (IS_ERR_OR_NULL(gmac->rst))
   119			return dev_err_probe(dev, PTR_ERR(gmac->rst),
   120					     "failed to acquire reset\n");
   121	
   122		ret = reset_control_reset(gmac->rst);
   123		if (ret)
   124			return dev_err_probe(dev, ret,
   125					     "failed to reset\n");
   126	
   127		gmac->uniphy = devm_phy_optional_get(dev, "uniphy");
   128		if (IS_ERR(gmac->uniphy))
   129			return dev_err_probe(dev, PTR_ERR(gmac->uniphy),
   130					     "failed to acquire uniphy\n");
   131	
   132		plat_dat->bsp_priv = gmac;
   133		plat_dat->serdes_powerup = ipq50xx_gmac_powerup;
   134		plat_dat->fix_mac_speed = ipq50xx_gmac_fix_speed;
   135	
   136		return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
   137	}
   138	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

