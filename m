Return-Path: <linux-kernel+bounces-13572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5B820836
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 19:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47251C219D0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF91C2E6;
	Sat, 30 Dec 2023 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQFFVgGl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921BEBA57
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703962667; x=1735498667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oBCLXGfu9hfFgJN38PAf0M6urI0ug/8QDPepj6L1MIg=;
  b=fQFFVgGlMnJAxOqHm1UkO/nJwXsv2GyA9m6S+CRiWqyCiYkaVxy3PMqV
   L3Ss8R3R9kXvXL4d9PHMU2UNJYmkLV18intmTsF1ZLhivBlZpTkiAkPhv
   ISbLNnFDhkoopdRaJL9HTYq8TNu5xWHBHb5nl632vfESx9NCeOSnGYMU0
   G+MDMJaxpTt9qc+QsY92U4fLVpbm9JgQaDm1bP+czp7f//VHI3pihqzCW
   mWARZ2QYqs0RSeZnTjLAlxZISmp3LEjOkhpa9KQ1HprYTER8hGZ/45Sza
   Y2iKlxAOsxhilY2mGEYawQgxk0tcqxZ0dFO8rSl5XtODvjh57cRRAvQax
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="15365873"
X-IronPort-AV: E=Sophos;i="6.04,318,1695711600"; 
   d="scan'208";a="15365873"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2023 10:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="772212695"
X-IronPort-AV: E=Sophos;i="6.04,318,1695711600"; 
   d="scan'208";a="772212695"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Dec 2023 10:56:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJeVM-000Ih7-0O;
	Sat, 30 Dec 2023 18:56:16 +0000
Date: Sun, 31 Dec 2023 02:55:23 +0800
From: kernel test robot <lkp@intel.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-imx@nxp.com, peng.fan@nxp.com, treding@nvidia.com,
	yibin.gong@nxp.com, robh@kernel.org, ranjani.vaidyanathan@nxp.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: imx: scu: ensure wakeup procedure calls
 pm_system_wakeup()
Message-ID: <202312310208.zIVggTP2-lkp@intel.com>
References: <20231230053831.67661-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230053831.67661-1-xiaolei.wang@windriver.com>

Hi Xiaolei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaolei-Wang/firmware-imx-scu-ensure-wakeup-procedure-calls-pm_system_wakeup/20231230-134202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20231230053831.67661-1-xiaolei.wang%40windriver.com
patch subject: [PATCH] firmware: imx: scu: ensure wakeup procedure calls pm_system_wakeup()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20231231/202312310208.zIVggTP2-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231231/202312310208.zIVggTP2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312310208.zIVggTP2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/imx/imx-scu.c:365:32: warning: 'imx_scu_pm_ops' defined but not used [-Wunused-const-variable=]
     365 | static const struct dev_pm_ops imx_scu_pm_ops = {
         |                                ^~~~~~~~~~~~~~


vim +/imx_scu_pm_ops +365 drivers/firmware/imx/imx-scu.c

   364	
 > 365	static const struct dev_pm_ops imx_scu_pm_ops = {
   366		SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_scu_suspend_noirq,
   367					      imx_scu_resume_noirq)
   368	};
   369	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

