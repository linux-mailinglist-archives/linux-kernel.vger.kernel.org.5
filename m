Return-Path: <linux-kernel+bounces-89631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA786F344
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 02:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708011F221CE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F7524F;
	Sun,  3 Mar 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NN8ctIDa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF763C;
	Sun,  3 Mar 2024 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709430191; cv=none; b=H2TiJfq3f0KNDA+o+R2NyTKZn3cVKSrNUeW5aAS/DQck1xbjXvJu8h+RsixWxVzJenJiiF3wbGgeQO3H+ZvjXGbUFJHmO/tQ/U0e7ze7QkBEHMnGbVamlDKDTP26fQIPSpoJqWODHpWaaq7UJDMMCV10xU5fjZ0B2IyYhhu9xnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709430191; c=relaxed/simple;
	bh=bPtaNql4S+FrAHjRxxcQH2iuVQisNn3g9p6ODBEDHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shMfmVOktPAyWD5l+IqJddpHYg4Y4lXpo1DMWwmWvaXMuZGGlbwhvvdwgnZkjfwk1ROyxp0HrSbUquyj38h2jLu+5q4cDrLE0TT44NdG4S8zfGAT3LCKI2Vwg6JAogLuiKhtDx6tjInMn8Yro2Zidx6wYokAZvUzDm89I2sC/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NN8ctIDa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709430190; x=1740966190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bPtaNql4S+FrAHjRxxcQH2iuVQisNn3g9p6ODBEDHVU=;
  b=NN8ctIDaNi0LvPfqsxqd52+hM0rOJKU2lKZd50EWWf20VmU7DRIIXW9u
   7pCju84EZxrTgKlNN4Sas6w4+pTVyh7yX6ZzHY6uColmmOq5sqJg015DW
   NWgRolD3BwTDxcNbslHzeSYakE8I3YwWbQzE8KG6pHX8LerhtEauR56kq
   lMjJusOXPPaDK6tmZMrzKP1etQfAJmQrK5KGVqJF4K3P4C30zJYOdnDAn
   2yw6X8AWaQcdXbexAYPMhDQDpW7JA0Fo2WjBAAsZQA3ffRIAL7r1TQzHO
   KGyGTVpncRJnSUP0OphahOXT512ccPpm4r6rychV+JjIzCje6Wceeg5Nl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="4114457"
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="4114457"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 17:43:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="8722174"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2024 17:43:05 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgasY-0000QO-20;
	Sun, 03 Mar 2024 01:43:02 +0000
Date: Sun, 3 Mar 2024 09:42:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx: add i.MX95 BLK CTL clk driver
Message-ID: <202403030856.IfA30QpA-lkp@intel.com>
References: <20240228-imx95-blk-ctl-v1-2-9b5ae3c14d83@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-imx95-blk-ctl-v1-2-9b5ae3c14d83@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 22ba90670a51a18c6b36d285fddf92b9887c0bc3]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/dt-bindindgs-clock-support-NXP-i-MX95-BLK-CTL-module/20240228-122408
base:   22ba90670a51a18c6b36d285fddf92b9887c0bc3
patch link:    https://lore.kernel.org/r/20240228-imx95-blk-ctl-v1-2-9b5ae3c14d83%40nxp.com
patch subject: [PATCH 2/2] clk: imx: add i.MX95 BLK CTL clk driver
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240303/202403030856.IfA30QpA-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240303/202403030856.IfA30QpA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403030856.IfA30QpA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/pm_runtime.h:11,
                    from drivers/clk/imx/clk-imx95-blk-ctl.c:9:
>> drivers/clk/imx/clk-imx95-blk-ctl.c:425:25: error: 'imx95_blk_ctl_match' undeclared here (not in a function); did you mean 'imx95_bc_of_match'?
     425 | MODULE_DEVICE_TABLE(of, imx95_blk_ctl_match);
         |                         ^~~~~~~~~~~~~~~~~~~
   include/linux/module.h:244:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^~~~
>> include/linux/module.h:244:21: error: '__mod_of__imx95_blk_ctl_match_device_table' aliased to undefined symbol 'imx95_blk_ctl_match'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |                     ^~~~~~
   drivers/clk/imx/clk-imx95-blk-ctl.c:425:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     425 | MODULE_DEVICE_TABLE(of, imx95_blk_ctl_match);
         | ^~~~~~~~~~~~~~~~~~~


vim +425 drivers/clk/imx/clk-imx95-blk-ctl.c

   415	
   416	static const struct of_device_id imx95_bc_of_match[] = {
   417		{ .compatible = "nxp,imx95-cameramix-csr", .data = &camblk_dev_data },
   418		{ .compatible = "nxp,imx95-display-master-csr", },
   419		{ .compatible = "nxp,imx95-dispmix-lvds-csr", .data = &lvds_csr_dev_data },
   420		{ .compatible = "nxp,imx95-dispmix-csr", .data = &dispmix_csr_dev_data },
   421		{ .compatible = "nxp,imx95-netcmix-blk-ctrl", },
   422		{ .compatible = "nxp,imx95-vpumix-csr", .data = &vpublk_dev_data },
   423		{ /* Sentinel */ },
   424	};
 > 425	MODULE_DEVICE_TABLE(of, imx95_blk_ctl_match);
   426	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

