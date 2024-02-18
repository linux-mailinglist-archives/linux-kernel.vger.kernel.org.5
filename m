Return-Path: <linux-kernel+bounces-70602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC7F8599B9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735881F22141
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D34745D8;
	Sun, 18 Feb 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyLuHxqh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9FF6F07C;
	Sun, 18 Feb 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294328; cv=none; b=gB41pl97BlLmgoyhVNlf2x/YecO5SBNHu1gBkivhRJ+k2kb0TRXeMau489SJzVv/hz5bh07jT48WTUYnQd3z8d48ID9iGVXFsUZS2DT5NXucjeq8g6ytPqU3qUfbGlcH8RerB/ykbqs5re80AsVCwKtwakBdBiqFwLAfff0bnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294328; c=relaxed/simple;
	bh=tnM0uTy98OwW8DDzCPMTha03h0Xip8yTOAu7yVZB99w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f98sVFZmGIzixuqN6Tj8DsIWjQEWRcC4dBXb8TxaLJwTjO4eDLU5PXpt1BsVfH2Ilf1MdXFdlALrSyOjN4SUsIfnSG5lf82kCMwtO+S9OISSHY7PljcGwjRR/Cfl/dVDM/N9tJJ1GSVcdNzSSv52vhGa+DyhkpMhag2iQNPOfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyLuHxqh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708294327; x=1739830327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tnM0uTy98OwW8DDzCPMTha03h0Xip8yTOAu7yVZB99w=;
  b=PyLuHxqheb1IA5QtGNVxyL1GGvxbFhuh84xRYtIVx7GIP3m48ConPzS6
   dCLsCTJu4ECqB+b64C+3E07MEHBIFqTxXEmwkVh1z63/XLbemi/gkEPZ3
   j9+uikqotjyea4pri0zeAJdl8HKh/1mNJ86KZVrXbMui622HtRzbrGyf9
   ds4sfEX3X+430OVL0KvRwOxkEg3fA71qiscORnt3YF7Ym/IdPQjvJ0xYK
   fPoRsc/HZlv3j4IilUlbdQ8gAMf6i+dAQyT+ojVog3of6XDcMErKtuZbC
   LrgPzcJWQO3FDaqIoe+n0rSo228DAo/005JgXK7yTS+77lObEzJyZXbTi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="12990493"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="12990493"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 14:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="4717299"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 Feb 2024 14:12:02 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbpOB-0003KO-0o;
	Sun, 18 Feb 2024 22:11:59 +0000
Date: Mon, 19 Feb 2024 06:11:30 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Igor Opaniuk <igor.opaniuk@linaro.org>,
	tianshuliang <tianshuliang@hisilicon.com>,
	David Yang <mmyangfl@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: add support for hi3798mv200
Message-ID: <202402190531.qUVUPNDD-lkp@intel.com>
References: <20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6@outlook.com>

Hi Yang,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8d3dea210042f54b952b481838c1e7dfc4ec751d]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Xiwen-via-B4-Relay/mmc-dw_mmc-add-support-for-hi3798mv200/20240216-014744
base:   8d3dea210042f54b952b481838c1e7dfc4ec751d
patch link:    https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6%40outlook.com
patch subject: [PATCH 1/3] mmc: dw_mmc: add support for hi3798mv200
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240219/202402190531.qUVUPNDD-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 36adfec155de366d722f2bac8ff9162289dcf06c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402190531.qUVUPNDD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402190531.qUVUPNDD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/dw_mmc-hi3798mv200.c:178:25: error: incompatible pointer types passing 'struct device *' to parameter of type 'struct mmc_host *' [-Werror,-Wincompatible-pointer-types]
     178 |         mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
         |                                ^~~~~~~~~
   include/linux/mmc/host.h:542:46: note: passing argument to parameter 'host' here
     542 | void mmc_of_parse_clk_phase(struct mmc_host *host,
         |                                              ^
   1 error generated.


vim +178 drivers/mmc/host/dw_mmc-hi3798mv200.c

   168	
   169	static int dw_mci_hi3798mv200_init(struct dw_mci *host)
   170	{
   171		struct dw_mci_hi3798mv200_priv *priv;
   172		struct device_node *np = host->dev->of_node;
   173	
   174		priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
   175		if (!priv)
   176			return -ENOMEM;
   177	
 > 178		mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
   179	
   180		priv->sample_clk = devm_clk_get_enabled(host->dev, "ciu-sample");
   181		if (IS_ERR(priv->sample_clk)) {
   182			dev_err(host->dev, "failed to get enabled ciu-sample clock\n");
   183			return PTR_ERR(priv->sample_clk);
   184		}
   185	
   186		priv->drive_clk = devm_clk_get_enabled(host->dev, "ciu-drive");
   187		if (IS_ERR(priv->drive_clk)) {
   188			dev_err(host->dev, "failed to get enabled ciu-drive clock\n");
   189			return PTR_ERR(priv->drive_clk);
   190		}
   191	
   192		priv->sap_dll_reg = syscon_regmap_lookup_by_phandle(np, "hisilicon,sap-dll-reg");
   193		if (IS_ERR(priv->sap_dll_reg)) {
   194			dev_err(host->dev, "failed to get sap-dll-reg\n");
   195			return PTR_ERR(priv->sap_dll_reg);
   196		}
   197	
   198		host->priv = priv;
   199		return 0;
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

