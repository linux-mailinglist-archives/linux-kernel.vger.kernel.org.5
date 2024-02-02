Return-Path: <linux-kernel+bounces-50043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2E847396
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9051C23BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA3148300;
	Fri,  2 Feb 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLLUzUU/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE7E1482E1;
	Fri,  2 Feb 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888568; cv=none; b=EWwaOC5cTx32G/crm2NEbxQDgakvNu/0+96mujawX1+ZmN6FUno5Yi5RdTDBJEZ5mo2+O8T2WgO/RsNH+PKo6R7wV79WLRrotKXE7txkQJIqLR2c5IK2Xdjoo1cCRiFlAifHVQ0DdzeOeJl+/ViOghI731Sy0o2ZKQ8y/lKG9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888568; c=relaxed/simple;
	bh=i+fwGDOYXUBBa/SmGUmEeeSRO1FqOePL0sfvubTwHA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9Qaa/qpQNu3eb0YXsn1xasM2enScNLGw7mkRJXQF/tWr4LXWu0DvWD+9qt5GOkq4X6DZ1GRMizGbFxuLzUF+BDSXjoWsMtXzZ4tZ85CZEIWIOUy3KMMhRKd/cumS2SySynTtvKzMyXvQoooggmUWDFDpPiAYVIyX6YMPhEz2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLLUzUU/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706888567; x=1738424567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+fwGDOYXUBBa/SmGUmEeeSRO1FqOePL0sfvubTwHA0=;
  b=HLLUzUU/LNE4ElIFWXxKjRICR8wWGtL4SKzPaWO833kBimDw4Jjloe0M
   2JsyaHWp8Y/NaaF3Rlit5AcNU4WZzHJztJPiDaZD2rgJOqCvYEze9xieZ
   bRsaX7yF4Afnuf7NsJ6rSD5nBXLwf4+RObqM6sJkM7Ybb54Xp/GlIcmy+
   MMcn3wmLdZWmIGgmjQ1ENYnqc0jzAnY1/xhk6apc84tBwoIwMdivQ8B6i
   Zo73CH3pa8u/WXQzU6bYq0GqigCn2Fj++vNjkmq5eOJEvYgPzEgNURp+k
   2PYCb7RUPkBsWsMWHEBC2CFJ1/A5bL3eKDPPNijxyhUQ3XVn9dHyS2OMZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11543304"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="11543304"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:42:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4719672"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 02 Feb 2024 07:42:41 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVvgd-0003zm-1G;
	Fri, 02 Feb 2024 15:42:39 +0000
Date: Fri, 2 Feb 2024 23:42:26 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 06/18] power: reset: brcm-kona-reset: Use
 devm_register_sys_off_handler(RESTART)
Message-ID: <202402022349.daHRuWLB-lkp@intel.com>
References: <20240201180102.70395-7-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201180102.70395-7-afd@ti.com>

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on mani-mhi/mhi-next soc/for-next linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/power-reset-atc260x-poweroff-Use-devm_register_sys_off_handler-RESTART/20240202-020809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240201180102.70395-7-afd%40ti.com
patch subject: [PATCH 06/18] power: reset: brcm-kona-reset: Use devm_register_sys_off_handler(RESTART)
config: arm-randconfig-r121-20240202 (https://download.01.org/0day-ci/archive/20240202/202402022349.daHRuWLB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240202/202402022349.daHRuWLB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402022349.daHRuWLB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/power/reset/brcm-kona-reset.c:18:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *kona_reset_base @@     got void *cb_data @@
   drivers/power/reset/brcm-kona-reset.c:18:45: sparse:     expected void [noderef] __iomem *kona_reset_base
   drivers/power/reset/brcm-kona-reset.c:18:45: sparse:     got void *cb_data
>> drivers/power/reset/brcm-kona-reset.c:43:46: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected void *cb_data @@     got void [noderef] __iomem *[assigned] kona_reset_base @@
   drivers/power/reset/brcm-kona-reset.c:43:46: sparse:     expected void *cb_data
   drivers/power/reset/brcm-kona-reset.c:43:46: sparse:     got void [noderef] __iomem *[assigned] kona_reset_base

vim +18 drivers/power/reset/brcm-kona-reset.c

    15	
    16	static int kona_reset_handler(struct sys_off_data *data)
    17	{
  > 18		void __iomem *kona_reset_base = data->cb_data;
    19	
    20		/*
    21		 * A soft reset is triggered by writing a 0 to bit 0 of the soft reset
    22		 * register. To write to that register we must first write the password
    23		 * and the enable bit in the write access enable register.
    24		 */
    25		writel((RSTMGR_WR_PASSWORD << RSTMGR_WR_PASSWORD_SHIFT) |
    26			RSTMGR_WR_ACCESS_ENABLE,
    27			kona_reset_base + RSTMGR_REG_WR_ACCESS_OFFSET);
    28		writel(0, kona_reset_base + RSTMGR_REG_CHIP_SOFT_RST_OFFSET);
    29	
    30		return NOTIFY_DONE;
    31	}
    32	
    33	static int kona_reset_probe(struct platform_device *pdev)
    34	{
    35		void __iomem *kona_reset_base;
    36	
    37		kona_reset_base = devm_platform_ioremap_resource(pdev, 0);
    38		if (IS_ERR(kona_reset_base))
    39			return PTR_ERR(kona_reset_base);
    40	
    41		return devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
    42						     128, kona_reset_handler,
  > 43						     kona_reset_base);
    44	}
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

