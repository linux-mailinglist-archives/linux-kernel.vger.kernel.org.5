Return-Path: <linux-kernel+bounces-31766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAFD8333B4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3641F21C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF3D53C;
	Sat, 20 Jan 2024 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyztcjRf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F4D304
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705747721; cv=none; b=aFK61oP3nd2TuRSBDaOqnU+1WO+yOzk65eSFjzCQQQ/0NWkPWk4MI9hTs9zTP+3llkQaPHjvTHUwKbK2FTZ6+sPAwkl65pfMwggSMkPRD7DcnE0m7smQnkqUEQtf7Brmjxc8lcqZ0FYBSf7+iQ//6jRFpAb2RkkIsM+tL0ydmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705747721; c=relaxed/simple;
	bh=a9eg8CTv19GpHeLK2y2je5uhnvD/AEYKfV4AbqH3LLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY+2kWkpaJlQxXrebrqxQJvcFrq5uqCDTiyUD0M4BsUSuofftvUz2G5fhCpjel08Ygy6q6LcdYBskgEOinzfjVVtCEMmNKSkbo08bfLMd7Wpl9jdb1FeD4md6xSkpmsFTrufPWfYYY/jeAJof5Q+MlpzyRbmv3SS7F1RgIDY4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyztcjRf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705747719; x=1737283719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a9eg8CTv19GpHeLK2y2je5uhnvD/AEYKfV4AbqH3LLU=;
  b=CyztcjRfb17Oq7Vw1jtN+GgyndK534KcuYQksbc3JpclrngibaY7r98+
   +OCz2NLCwTkIaY+VOKexNrXf3Jl436sCdmnIJ8cULFMpO4I7ljGPPzF0A
   XVyLE+m1vpIGtl/35C9uKvCzA9tu2RGUY5Yy3HCLtJmZdcXRdr9p/9bN7
   PbXk9fOHQ025SXNSxChvcyCffRNT6Dy2Bdpq/m07HEqyiEFiy+FirWt7M
   hFAkrgYqVYT4MNiHOfy86IGDg9tb7TwCDQ7nF/8jEnmWE/83GPldFw2Hj
   4veA5RtrDyoFX6+69pdLTXpTQKu1F/cz+1IwcUaElZ2rhurAC8ad0QPBF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="823702"
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="823702"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 02:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="928596427"
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="928596427"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2024 02:48:36 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rR8tu-00051C-15;
	Sat, 20 Jan 2024 10:48:34 +0000
Date: Sat, 20 Jan 2024 18:48:18 +0800
From: kernel test robot <lkp@intel.com>
To: Pranav Prasad <pranavpp@google.com>, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Pranav Prasad <pranavpp@google.com>,
	Kelly Rossmoyer <krossmo@google.com>
Subject: Re: [PATCH] alarmtimer: Expose information about next alarm to
 userspace via sysfs
Message-ID: <202401201804.0DPduM16-lkp@intel.com>
References: <20240118181459.1663313-1-pranavpp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118181459.1663313-1-pranavpp@google.com>

Hi Pranav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pranav-Prasad/alarmtimer-Expose-information-about-next-alarm-to-userspace-via-sysfs/20240119-021809
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20240118181459.1663313-1-pranavpp%40google.com
patch subject: [PATCH] alarmtimer: Expose information about next alarm to userspace via sysfs
config: sh-randconfig-002-20240120 (https://download.01.org/0day-ci/archive/20240120/202401201804.0DPduM16-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401201804.0DPduM16-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401201804.0DPduM16-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/time/alarmtimer.c:37:19: warning: 'alarmtimer_group_name' defined but not used [-Wunused-const-variable=]
      37 | static const char alarmtimer_group_name[] = "alarmtimer";
         |                   ^~~~~~~~~~~~~~~~~~~~~


vim +/alarmtimer_group_name +37 kernel/time/alarmtimer.c

    36	
  > 37	static const char alarmtimer_group_name[] = "alarmtimer";
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

