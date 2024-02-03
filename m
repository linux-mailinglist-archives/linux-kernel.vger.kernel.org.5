Return-Path: <linux-kernel+bounces-50914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8DE8483BB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31101F23A72
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D1511CB7;
	Sat,  3 Feb 2024 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ob/JSzh4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A22F9E9;
	Sat,  3 Feb 2024 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706934072; cv=none; b=hGm5cPbLFWPlzDVCn5UQcheK4SpZZpO2Zd3vg27wTqO0BqjQVmTBFyIL1U4dP7tIZQrMtbAc28Oh0YqXh8bm/UFG8yO29ysqx7MVSzPrkq5cUsopb9tZNPa8z0TT2onZBRx51YIiZXF1u86RxJtsPbvXkiuyY+fyZUkeWczIlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706934072; c=relaxed/simple;
	bh=l8fqb95s8syuE8Cx9UHSXoTZx0Bim/EsdxuGX0FstWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlrzzMn17WcE2+omPjIlPfNkxA0NKTNLHLUghMgDF/+ZPCZDIVCkqZSTb/VKnsiAkcTvvDhgozch9yumz3cd1MH8jWlq6sQrKln6gcS/fClkKlTsU/YTny3GCO3iEH8tiaaBxfiZHrDHgDMWCSTAXHqk2Pajr47r0Ho/S32GrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ob/JSzh4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706934070; x=1738470070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l8fqb95s8syuE8Cx9UHSXoTZx0Bim/EsdxuGX0FstWM=;
  b=Ob/JSzh4WBeKLXmCRYHxj0k/fdIaMYdMwTw8tdPiN6OBBPCRuSofnoie
   S1W2a9wUCnGYYPfO6jYcARhZ+lqAEe3Gl/OwtWWHAN0hotGLHnFB3Br5M
   uSESZkJIcczAzGtKcgbjHv7KCE7PkqYcOVU+6oCessqMcJIX9FLyjM09M
   H54X4/G5CPOSGm16CojGP7Kgr3BWLmXPdbZBuw+Mvp0U6EfYkvPIYVRUA
   bijxowSmPI5RZbHPi4dCPhNXEwDKRQSAn4UC/xuA/WZS8A+1UpkAlsJsc
   NAWyQngE3ZSfJtF1sZf1h+y1D2kapn2p27ZvPdM9MLVCDW9BEem6zoVWo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11655561"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="11655561"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:21:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="31047732"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Feb 2024 20:21:04 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW7WX-0004cQ-0G;
	Sat, 03 Feb 2024 04:21:01 +0000
Date: Sat, 3 Feb 2024 12:20:06 +0800
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
Subject: Re: [PATCH 09/18] power: reset: rmobile-reset: Use
 devm_register_sys_off_handler(RESTART)
Message-ID: <202402031246.nZHDnDnf-lkp@intel.com>
References: <20240201180102.70395-10-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201180102.70395-10-afd@ti.com>

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on mani-mhi/mhi-next soc/for-next linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/power-reset-atc260x-poweroff-Use-devm_register_sys_off_handler-RESTART/20240202-020809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240201180102.70395-10-afd%40ti.com
patch subject: [PATCH 09/18] power: reset: rmobile-reset: Use devm_register_sys_off_handler(RESTART)
config: hexagon-randconfig-r122-20240202 (https://download.01.org/0day-ci/archive/20240203/202402031246.nZHDnDnf-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce: (https://download.01.org/0day-ci/archive/20240203/202402031246.nZHDnDnf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402031246.nZHDnDnf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/power/reset/rmobile-reset.c:24:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *sysc_base2 @@     got void *cb_data @@
   drivers/power/reset/rmobile-reset.c:24:40: sparse:     expected void [noderef] __iomem *sysc_base2
   drivers/power/reset/rmobile-reset.c:24:40: sparse:     got void *cb_data
>> drivers/power/reset/rmobile-reset.c:45:47: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected void *cb_data @@     got void [noderef] __iomem *[assigned] sysc_base2 @@
   drivers/power/reset/rmobile-reset.c:45:47: sparse:     expected void *cb_data
   drivers/power/reset/rmobile-reset.c:45:47: sparse:     got void [noderef] __iomem *[assigned] sysc_base2

vim +24 drivers/power/reset/rmobile-reset.c

    21	
    22	static int rmobile_reset_handler(struct sys_off_data *data)
    23	{
  > 24		void __iomem *sysc_base2 = data->cb_data;
    25	
    26		/* Let's assume we have acquired the HPB semaphore */
    27		writel(RESCNT2_PRES, sysc_base2 + RESCNT2);
    28	
    29		return NOTIFY_DONE;
    30	}
    31	
    32	static int rmobile_reset_probe(struct platform_device *pdev)
    33	{
    34		void __iomem *sysc_base2;
    35		int error;
    36	
    37		sysc_base2 = devm_platform_ioremap_resource(pdev, 0);
    38		if (IS_ERR(sysc_base2))
    39			return PTR_ERR(sysc_base2);
    40	
    41		error = devm_register_sys_off_handler(&pdev->dev,
    42						      SYS_OFF_MODE_RESTART,
    43						      SYS_OFF_PRIO_HIGH,
    44						      rmobile_reset_handler,
  > 45						      sysc_base2);
    46		if (error) {
    47			dev_err(&pdev->dev,
    48				"cannot register restart handler (err=%d)\n", error);
    49			return error;
    50		}
    51	
    52		return 0;
    53	}
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

