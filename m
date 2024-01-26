Return-Path: <linux-kernel+bounces-39636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24283D3EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A8A2895A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE510A34;
	Fri, 26 Jan 2024 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrimRavc"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392C10799
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706246799; cv=none; b=V7wj8QaW10EpIgXz7LAM7tYZn9MFiOrX9RwiwyqLcMRHPR7sQ37z/x635GBaZp0RTLzdJbWO8j5jiA9yZFrDPkYIJiEf2uMDc4DE9ezo4eXW9IQuhcrmEjNBsy6EktIrsdaRA9IUkTu/wmNLbRp2b219TXHcSe2Y/65qTZYDpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706246799; c=relaxed/simple;
	bh=T6pFkLTZJz7H/RFcbVN8xkONdim8Rlw6Nh+ztR2exnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5xsUuSYMv0nM3ETYcTtBItnbAZR/eK+AIIf+xkhdNx9cE+HIyIAIoItMoXTsKZAhnFs0v1O8508nlmHc9kb5Z9hmW+btIZqIErywtB0mtta859LRj05QmdP5gTipLCJiH3HPPS5ghTAU7L85wsH7+U4oVhxXsKhCxfmkR1MOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrimRavc; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706246797; x=1737782797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T6pFkLTZJz7H/RFcbVN8xkONdim8Rlw6Nh+ztR2exnM=;
  b=FrimRavcwOsZQuczpWwjQhxtS3QDyumPZEZcB7KwX6J8sfWhq3EceCNv
   Ya3kq2/Vff33VFxtUUHDeqHMNfX283InaslGeQ5FVSb8atuH55EoMsy88
   oZXapgQORJi/dmx0fE2gGZtZohwOveVgNUgZnjp4d1+2wtsFpQvQTHHgw
   1ErK/h79GHF6EqpQheRpb7ovvqlSYC5jtiHnI0HyPU1eIVYsMNn6RumNS
   yxytMo55b1LYYw8xuEi05M9Wwlm1sbf5Zjo8u/FGxoPngEe/9M5/Tz5vu
   1PRh1A3725MUqdWik57HoSnFOECZ5myfriBc+b2RnxkHWT3N50FvOh26+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399556922"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399556922"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 21:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960113140"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960113140"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2024 21:26:33 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTEjX-0000is-0T;
	Fri, 26 Jan 2024 05:26:31 +0000
Date: Fri, 26 Jan 2024 13:25:42 +0800
From: kernel test robot <lkp@intel.com>
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
	akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de,
	maz@kernel.org, liusong@linux.alibaba.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCH 3/3] watchdog/softlockup: add parameter to control the
 reporting of time-consuming hardirq
Message-ID: <202401261359.eaU4UnjQ-lkp@intel.com>
References: <20240123121223.22318-4-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123121223.22318-4-yaoma@linux.alibaba.com>

Hi Bitao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on akpm-mm/mm-everything linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitao-Hu/watchdog-softlockup-low-overhead-detection-of-interrupt-storm/20240123-201509
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20240123121223.22318-4-yaoma%40linux.alibaba.com
patch subject: [PATCH 3/3] watchdog/softlockup: add parameter to control the reporting of time-consuming hardirq
config: i386-buildonly-randconfig-003-20240126 (https://download.01.org/0day-ci/archive/20240126/202401261359.eaU4UnjQ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401261359.eaU4UnjQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261359.eaU4UnjQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/watchdog.c:1088:5: warning: no previous prototype for function 'proc_softlockup_irqtrace' [-Wmissing-prototypes]
    1088 | int proc_softlockup_irqtrace(struct ctl_table *table, int write,
         |     ^
   kernel/watchdog.c:1088:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1088 | int proc_softlockup_irqtrace(struct ctl_table *table, int write,
         | ^
         | static 
   1 warning generated.


vim +/proc_softlockup_irqtrace +1088 kernel/watchdog.c

  1084	
  1085	/*
  1086	 * /proc/sys/kernel/softlockup_irqtrace
  1087	 */
> 1088	int proc_softlockup_irqtrace(struct ctl_table *table, int write,
  1089				 void *buffer, size_t *lenp, loff_t *ppos)
  1090	{
  1091		int err, old;
  1092	
  1093		mutex_lock(&watchdog_mutex);
  1094	
  1095		old = READ_ONCE(softlockup_irqtrace);
  1096		err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
  1097	
  1098		if (!err && write && old != READ_ONCE(softlockup_irqtrace))
  1099			proc_watchdog_update();
  1100	
  1101		mutex_unlock(&watchdog_mutex);
  1102		return err;
  1103	}
  1104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

