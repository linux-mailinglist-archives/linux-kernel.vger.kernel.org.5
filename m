Return-Path: <linux-kernel+bounces-51037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08CA848567
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5509A1F22FF8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA065D90C;
	Sat,  3 Feb 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btXJjrnF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40F1CAA4;
	Sat,  3 Feb 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706961602; cv=none; b=mea3E6TuI5aMGMLjFkOLGs7eiAWk9MWXd2XHkkkW55zGrF77SyfuAVjtRj1NmlQ1QpIy7WSsCphgKqhWb/HHe4KCrf9P436uCqGwxbBuMf5qi9uWaTzm0IVL88HUmAgemlboYNlC2e/VTEx9YAMDqUaIqOJ0YKZK0oaCtIaeNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706961602; c=relaxed/simple;
	bh=OaM3NQPREDdpKg0JK+QSLTqUnxO///RJV6jgIGAqKH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzwMsAmMSqjw/6gAnPE+BTyaQNPBd8fCDMg7RXl4bsvbv8Q7jYtobQRkdw1YS4IQ6pR0/RlW0xJ7UPZohq3spxumrJTctnQL1UPnToMDH6TGQbVbqhOFqgf5l1d8CLBqpEJkTk1LMFzAksoFaBWFNpgNKNQQz6axxLp4G+mMVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btXJjrnF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706961600; x=1738497600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OaM3NQPREDdpKg0JK+QSLTqUnxO///RJV6jgIGAqKH8=;
  b=btXJjrnFM9KelXjPU22Mz/JdfICOQKyAJrrHqTvH6R3DdjvnMabiJEpe
   K+z9NXOo/Nie4TeWRkvmZD8VAElyfoBBupMH97Gfu1BwtJyZqra9RQpsA
   xGafuKiQIeGUuKOdh8ZHRvO+lyBLpfftZcCN5KOUcugVIFrs/ch/CEVEU
   3anw4xm01/LJxgBl1E80QC7OpO6/d5DvAG0jjFtWQiqd4qUGUJntf34xm
   qYuZlnAZxepckPH2wR9mT9SH6/RyO4tEUn9gSyAFEzbFii2AQHmU1s8o7
   Fo0DMBFJMlVeueuWBBYUjAYAcQGu3dEfuFPOvU2RsCEo9G70vJLbTEfWz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17835200"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="17835200"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="4911402"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 03 Feb 2024 03:59:55 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWEga-000506-0C;
	Sat, 03 Feb 2024 11:59:52 +0000
Date: Sat, 3 Feb 2024 19:59:18 +0800
From: kernel test robot <lkp@intel.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow drivers to provide a
 default AXI configuration
Message-ID: <202402031948.IySiUm4u-lkp@intel.com>
References: <20240201-stmmac-axi-config-v1-2-822e97b2d26e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-stmmac-axi-config-v1-2-822e97b2d26e@nvidia.com>

Hi Thierry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 51b70ff55ed88edd19b080a524063446bcc34b62]

url:    https://github.com/intel-lab-lkp/linux/commits/Thierry-Reding/net-stmmac-Pass-resources-to-DT-parsing-code/20240202-025357
base:   51b70ff55ed88edd19b080a524063446bcc34b62
patch link:    https://lore.kernel.org/r/20240201-stmmac-axi-config-v1-2-822e97b2d26e%40nvidia.com
patch subject: [PATCH net-next 2/3] net: stmmac: Allow drivers to provide a default AXI configuration
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240203/202402031948.IySiUm4u-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402031948.IySiUm4u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402031948.IySiUm4u-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:96: warning: Function parameter or struct member 'res' not described in 'stmmac_axi_setup'


vim +96 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

3b57de958e2aa3 Vince Bridgers     2014-07-31   86  
afea03656add70 Giuseppe Cavallaro 2016-02-29   87  /**
afea03656add70 Giuseppe Cavallaro 2016-02-29   88   * stmmac_axi_setup - parse DT parameters for programming the AXI register
afea03656add70 Giuseppe Cavallaro 2016-02-29   89   * @pdev: platform device
afea03656add70 Giuseppe Cavallaro 2016-02-29   90   * Description:
afea03656add70 Giuseppe Cavallaro 2016-02-29   91   * if required, from device-tree the AXI internal register can be tuned
afea03656add70 Giuseppe Cavallaro 2016-02-29   92   * by using platform parameters.
afea03656add70 Giuseppe Cavallaro 2016-02-29   93   */
af49f82367c1e3 Thierry Reding     2024-02-01   94  static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev,
af49f82367c1e3 Thierry Reding     2024-02-01   95  					   struct stmmac_resources *res)
afea03656add70 Giuseppe Cavallaro 2016-02-29  @96  {
afea03656add70 Giuseppe Cavallaro 2016-02-29   97  	struct device_node *np;
afea03656add70 Giuseppe Cavallaro 2016-02-29   98  	struct stmmac_axi *axi;
afea03656add70 Giuseppe Cavallaro 2016-02-29   99  
afea03656add70 Giuseppe Cavallaro 2016-02-29  100  	np = of_parse_phandle(pdev->dev.of_node, "snps,axi-config", 0);
af49f82367c1e3 Thierry Reding     2024-02-01  101  	if (!np && !res->axi)
afea03656add70 Giuseppe Cavallaro 2016-02-29  102  		return NULL;
afea03656add70 Giuseppe Cavallaro 2016-02-29  103  
64f48e593a54a8 Joao Pinto         2017-03-07  104  	axi = devm_kzalloc(&pdev->dev, sizeof(*axi), GFP_KERNEL);
4613b279bee795 Peter Chen         2016-08-01  105  	if (!axi) {
af49f82367c1e3 Thierry Reding     2024-02-01  106  		if (np)
4613b279bee795 Peter Chen         2016-08-01  107  			of_node_put(np);
af49f82367c1e3 Thierry Reding     2024-02-01  108  
afea03656add70 Giuseppe Cavallaro 2016-02-29  109  		return ERR_PTR(-ENOMEM);
4613b279bee795 Peter Chen         2016-08-01  110  	}
afea03656add70 Giuseppe Cavallaro 2016-02-29  111  
af49f82367c1e3 Thierry Reding     2024-02-01  112  	if (res->axi)
af49f82367c1e3 Thierry Reding     2024-02-01  113  		*axi = *res->axi;
af49f82367c1e3 Thierry Reding     2024-02-01  114  
af49f82367c1e3 Thierry Reding     2024-02-01  115  	if (np) {
afea03656add70 Giuseppe Cavallaro 2016-02-29  116  		axi->axi_lpi_en = of_property_read_bool(np, "snps,lpi_en");
afea03656add70 Giuseppe Cavallaro 2016-02-29  117  		axi->axi_xit_frm = of_property_read_bool(np, "snps,xit_frm");
61d4f140943c47 Jisheng Zhang      2022-12-03  118  		axi->axi_kbbe = of_property_read_bool(np, "snps,kbbe");
61d4f140943c47 Jisheng Zhang      2022-12-03  119  		axi->axi_fb = of_property_read_bool(np, "snps,fb");
61d4f140943c47 Jisheng Zhang      2022-12-03  120  		axi->axi_mb = of_property_read_bool(np, "snps,mb");
61d4f140943c47 Jisheng Zhang      2022-12-03  121  		axi->axi_rb =  of_property_read_bool(np, "snps,rb");
afea03656add70 Giuseppe Cavallaro 2016-02-29  122  
af49f82367c1e3 Thierry Reding     2024-02-01  123  		if (of_property_read_u32(np, "snps,wr_osr_lmt", &axi->axi_wr_osr_lmt)) {
af49f82367c1e3 Thierry Reding     2024-02-01  124  			if (!res->axi)
6b3374cb1c0bd4 Niklas Cassel      2016-12-05  125  				axi->axi_wr_osr_lmt = 1;
af49f82367c1e3 Thierry Reding     2024-02-01  126  		}
af49f82367c1e3 Thierry Reding     2024-02-01  127  
af49f82367c1e3 Thierry Reding     2024-02-01  128  		if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt)) {
af49f82367c1e3 Thierry Reding     2024-02-01  129  			if (!res->axi)
6b3374cb1c0bd4 Niklas Cassel      2016-12-05  130  				axi->axi_rd_osr_lmt = 1;
af49f82367c1e3 Thierry Reding     2024-02-01  131  		}
af49f82367c1e3 Thierry Reding     2024-02-01  132  
afea03656add70 Giuseppe Cavallaro 2016-02-29  133  		of_property_read_u32_array(np, "snps,blen", axi->axi_blen, AXI_BLEN);
af49f82367c1e3 Thierry Reding     2024-02-01  134  
4613b279bee795 Peter Chen         2016-08-01  135  		of_node_put(np);
af49f82367c1e3 Thierry Reding     2024-02-01  136  	}
afea03656add70 Giuseppe Cavallaro 2016-02-29  137  
afea03656add70 Giuseppe Cavallaro 2016-02-29  138  	return axi;
afea03656add70 Giuseppe Cavallaro 2016-02-29  139  }
afea03656add70 Giuseppe Cavallaro 2016-02-29  140  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

