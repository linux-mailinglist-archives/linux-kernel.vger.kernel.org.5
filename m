Return-Path: <linux-kernel+bounces-41475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD983F277
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E7D28658A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F8C3C28;
	Sun, 28 Jan 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjKhlDxD"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB7A1373;
	Sun, 28 Jan 2024 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706400982; cv=none; b=GO3P4GCgG3zPZ8mlcqvO2BLU+5nEiFrZ713PnfYfz6JFGRKTzERVTNoe/SuXLM+HClidV+kPyfiY5k8KiacwfavreEGsKWscl1EbwR1O2kSFSAA0oRT/I3KPLA2fYAN0CEqtPP8yT3Z0M+qecdJbzL0v6WkZrYom1MNz1ggMAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706400982; c=relaxed/simple;
	bh=N9deARxE/PkvhxThtTXkY59GJcYHM/nCT8jbvsYUZ/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6L0K71FGxOSzgQf3mxkF27hJsI6rMv1DIvui1zzyp+dwB8qnqrurvVeYLRpmE/4V9nM7umhOJH6U47N4f2sZAhXl3EvkoIQEg3bXg5vwjyUaEjipTYvhqd9E/2BvJpFaX5pJkfMTKDnr094IJZeKg6vwbQm+DJNbTJYGSD4Jj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjKhlDxD; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706400980; x=1737936980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N9deARxE/PkvhxThtTXkY59GJcYHM/nCT8jbvsYUZ/c=;
  b=MjKhlDxDcICdDsc+RQa7PTngtG2dDERNzL/Fon0dueQa3Cuga80hcBuC
   2SyJH2GHP3vchVPX2F6R0VtHyvS4bfuLdwVZHMrVX1TgBkvm+gEtvOPpL
   sv3B6IkXkZU7yhxPl/tcN+3IWz/ZjZ+uALcXfOd/0qngksMs8CQ+XHjCw
   ch2SkO32cposqrf/gQSEI9fEMrlQGJPgbMz8wcSuguYcC6XExte6C+6D9
   JBSuGhXxZdGZw5qgucZNsStn+Ch1QI3ROkGrUsexZl6WSSo6GwXc5/MGL
   u5zcAwjQwdUSqFai9Is5H6WpT1zlmnvwqy6ARH4oOmDG0cIbEZwru41zl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="466994337"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="466994337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 16:16:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="960544688"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="960544688"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2024 16:16:07 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTsqD-0002t4-1r;
	Sun, 28 Jan 2024 00:16:05 +0000
Date: Sun, 28 Jan 2024 08:15:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/3] clocksource/drivers/imx-sysctr: drop use global
 variables
Message-ID: <202401280840.br5xJEeO-lkp@intel.com>
References: <20240125-imx-sysctr-v2-2-7332470cd7ae@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-imx-sysctr-v2-2-7332470cd7ae@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 01af33cc9894b4489fb68fa35c40e9fe85df63dc]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/dt-bindings-timer-nxp-sysctr-timer-support-i-MX95/20240125-191500
base:   01af33cc9894b4489fb68fa35c40e9fe85df63dc
patch link:    https://lore.kernel.org/r/20240125-imx-sysctr-v2-2-7332470cd7ae%40nxp.com
patch subject: [PATCH v2 2/3] clocksource/drivers/imx-sysctr: drop use global variables
config: i386-buildonly-randconfig-001-20240128 (https://download.01.org/0day-ci/archive/20240128/202401280840.br5xJEeO-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401280840.br5xJEeO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401280840.br5xJEeO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clocksource/timer-imx-sysctr.c:135:9: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     135 |         priv = kzalloc(sizeof(struct sysctr_private), GFP_KERNEL);
         |                ^
   drivers/clocksource/timer-imx-sysctr.c:135:9: note: did you mean 'vzalloc'?
   include/linux/vmalloc.h:141:14: note: 'vzalloc' declared here
     141 | extern void *vzalloc(unsigned long size) __alloc_size(1);
         |              ^
>> drivers/clocksource/timer-imx-sysctr.c:135:7: error: incompatible integer to pointer conversion assigning to 'struct sysctr_private *' from 'int' [-Wint-conversion]
     135 |         priv = kzalloc(sizeof(struct sysctr_private), GFP_KERNEL);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-imx-sysctr.c:141:3: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     141 |                 kfree(priv);
         |                 ^
   drivers/clocksource/timer-imx-sysctr.c:141:3: note: did you mean 'vfree'?
   include/linux/vmalloc.h:161:13: note: 'vfree' declared here
     161 | extern void vfree(const void *addr);
         |             ^
   3 errors generated.


vim +/kzalloc +135 drivers/clocksource/timer-imx-sysctr.c

   128	
   129	static int __init sysctr_timer_init(struct device_node *np)
   130	{
   131		struct sysctr_private *priv;
   132		void __iomem *base;
   133		int ret;
   134	
 > 135		priv = kzalloc(sizeof(struct sysctr_private), GFP_KERNEL);
   136		if (!priv)
   137			return -ENOMEM;
   138	
   139		ret = timer_of_init(np, &to_sysctr);
   140		if (ret) {
 > 141			kfree(priv);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

