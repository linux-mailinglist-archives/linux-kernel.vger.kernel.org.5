Return-Path: <linux-kernel+bounces-122125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1420088F227
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F4A1C2967E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FCE14EC70;
	Wed, 27 Mar 2024 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYCVgcZ8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1146D12E5B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580089; cv=none; b=eIThxKlH8jmvoikM1fiT8zOb6ZXQL1F8RzdOSiXu3VpxuezT/28sZwad5UG0UyhMe9aP2YaPsdXGCmTt3cvwC2YhGydnoYVO9Wt4KwVNg713pjgGGh7s8I+ySgnj+KgIEMpa0i5t3QeDn0otXZFEf8tzglHSt2A+yo6wton0/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580089; c=relaxed/simple;
	bh=ancmOeO68m/jYuGYzzAFJLG5SA6z3QUCP6Wp4sl5CqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpuJ4GE3/Uxame2Yw2CgNbjRIltj5KgBUC3/UE1d6nW3xJQxDrRZQjr4k4HO/Ac2Ggq104GgQCjn4979PVVvMEB+ZuFXfZORCRsdvcHPlU2ve7nLj9jvnEXERyiMoQ5oELDg1tU/6WmWlVL8sueHKPlUKirTFZTW8y+QSEY32xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYCVgcZ8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711580087; x=1743116087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ancmOeO68m/jYuGYzzAFJLG5SA6z3QUCP6Wp4sl5CqE=;
  b=fYCVgcZ8h8UrFzkl+/KmVjmSmMHhrTAjpNQszAHgyf8gfsby2P8lw4xJ
   yxogifBurSmtsf2TfEXWGx/Fqc2BZwo7QSP1WFiBwTk0AORcugRC0oDF/
   QwHr+D1gfVj8YPH2boiwpnEZ/pUK7uSdyFsMH/uQmkMQhKBiFAlELJX/r
   N21BPUWGsRlnscIRJVepxeKPt3waN2F0czPc4LQSj2DVe880QOM4EojZQ
   fapr7PYKcn/oOm8jbeC3q0iFB8dqmswuCgCgoH04da4cI7R6sfTCvmyyy
   OTs55g+GvHAEw6MM/YT9LzD7cXcAX6weHIrCw82QLQkSmSHOxzql5440C
   A==;
X-CSE-ConnectionGUID: IKbMOHhRQ6+n3P9nKoL8wQ==
X-CSE-MsgGUID: eNfAvotmS8qwYUukJ2HiBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6931339"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6931339"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 15:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21107711"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2024 15:54:44 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpcAL-0001Zq-2g;
	Wed, 27 Mar 2024 22:54:41 +0000
Date: Thu, 28 Mar 2024 06:53:44 +0800
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] clocksource/drivers/timer-clint: Add T-Head C9xx
 clint support
Message-ID: <202403280636.SLv93x6B-lkp@intel.com>
References: <20240325164021.3229-6-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325164021.3229-6-jszhang@kernel.org>

Hi Jisheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9-rc1 next-20240327]
[cannot apply to tip/timers/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/riscv-nommu-remove-PAGE_OFFSET-hardcoding/20240326-021401
base:   linus/master
patch link:    https://lore.kernel.org/r/20240325164021.3229-6-jszhang%40kernel.org
patch subject: [PATCH 5/5] clocksource/drivers/timer-clint: Add T-Head C9xx clint support
config: riscv-randconfig-r131-20240326 (https://download.01.org/0day-ci/archive/20240328/202403280636.SLv93x6B-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240328/202403280636.SLv93x6B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403280636.SLv93x6B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clocksource/timer-clint.c:253:19: warning: 'c900_clint_timer_init_dt' defined but not used [-Wunused-function]
     253 | static int __init c900_clint_timer_init_dt(struct device_node *np)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/c900_clint_timer_init_dt +253 drivers/clocksource/timer-clint.c

   252	
 > 253	static int __init c900_clint_timer_init_dt(struct device_node *np)
   254	{
   255		is_c900_clint = true;
   256		return clint_timer_init_dt(np);
   257	}
   258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

