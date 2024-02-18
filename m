Return-Path: <linux-kernel+bounces-70276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B485957D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12181C20C03
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF9BF9CF;
	Sun, 18 Feb 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enSBJw6Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88091DDB8;
	Sun, 18 Feb 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243554; cv=none; b=SxCng3/ejDxLyWvtAbjB06lWEkzcdE6RqDirKIsGGSDKawoVNGc8RmQSzQBMDdVWOz0f9o+PLpPWMyIH5j6ocHzHNiq9InlAOE4UqZIupjffQvuMr7wHLp6/njUmiWCUYXP1gIb6Srwdv/SZyysFNvJkjBqcfPjgc2da6UMzWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243554; c=relaxed/simple;
	bh=ttnZGnH/KEDMCu9kI5+L2dr0PEX11yWRxMG0Mkdt0AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m33UPgIuTx/Xgm0LfPi2V23jL3/akuToiCHZ8RqfnJTjng7A9ak692rkDZPJpo29j+QTKo9P3cdLjWO+dBA/rRxqUuox+fvmB+BDoxjhJr/R0dqpBDAVFIjd5TxWUQ80mhBcNUHOgtkFs94kiRiOyNJG28+6LsEB1tTZrwxAZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enSBJw6Y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708243552; x=1739779552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ttnZGnH/KEDMCu9kI5+L2dr0PEX11yWRxMG0Mkdt0AQ=;
  b=enSBJw6YmZZQELyM4/Hnsfl2eo2X4GBb+Ei+dzQlIs9NGkhOifNPSp7q
   qRAMr/ky6WYuCBl4n1W0KIoeU8n/aQTL0q/YEArgdJFSQCF5TYX7xH2R9
   8Eg9xw7qH168oWLMCf/ut2DF7NV4KkHl6lOPP4yJhtVuErLw6LjPqcgmu
   zA9wE472PQSG/qYZLs+Do19CKZNDyIb8Szu3m3pjT12N4xNQ7Y/0WCGNZ
   DD/ey3RcHDUe+blAFWyg3nlLhQ1ExQgKgVL5kGexfoJaMOsJ8/BhzIChC
   8dKxdG1uWDPkO7RijInQROJv5sIUEjfZOwfzdjnH+8Umtr7EUG3cZvUVo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="6109381"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="6109381"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 00:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="8904608"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 18 Feb 2024 00:05:46 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbcAR-0002sq-05;
	Sun, 18 Feb 2024 08:05:10 +0000
Date: Sun, 18 Feb 2024 16:03:00 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Igor Opaniuk <igor.opaniuk@linaro.org>,
	tianshuliang <tianshuliang@hisilicon.com>,
	David Yang <mmyangfl@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: add support for hi3798mv200
Message-ID: <202402181540.H4Ose96P-lkp@intel.com>
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
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20240218/202402181540.H4Ose96P-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240218/202402181540.H4Ose96P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402181540.H4Ose96P-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/dw_mmc-hi3798mv200.c: In function 'dw_mci_hi3798mv200_init':
>> drivers/mmc/host/dw_mmc-hi3798mv200.c:178:36: error: passing argument 1 of 'mmc_of_parse_clk_phase' from incompatible pointer type [-Werror=incompatible-pointer-types]
     178 |         mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
         |                                ~~~~^~~~~
         |                                    |
         |                                    struct device *
   In file included from drivers/mmc/host/dw_mmc-hi3798mv200.c:11:
   include/linux/mmc/host.h:542:46: note: expected 'struct mmc_host *' but argument is of type 'struct device *'
     542 | void mmc_of_parse_clk_phase(struct mmc_host *host,
         |                             ~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/mmc_of_parse_clk_phase +178 drivers/mmc/host/dw_mmc-hi3798mv200.c

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

