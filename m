Return-Path: <linux-kernel+bounces-32064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF78355ED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3001F22FC4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB3737159;
	Sun, 21 Jan 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vbpn10cQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F332A8D3;
	Sun, 21 Jan 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705843639; cv=none; b=SwJOobf+2658phMKa54aO/vEhDbTEFMM9zufh/RE/TicRaLVBJhpkDMrVuXobKr5N8C4fZnIP7bMBp3HAmMP53+r4BOe8q5R+iBP1ZKQQ89+md75l/n6ucnHRD4jz5drac7Ko+uLfHfUWe9xPCoI1SwgRrDSMXAtXs7Iyr7sbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705843639; c=relaxed/simple;
	bh=YvEOmwEWqmM2FzYz9JyLhCNzNVvl/cz5AWUT5qlVscQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpEFatjGC73KmZ/ImIcyelXzRtCZb7hXfWrkLXt729R4zuzxaKfEWtQHkXP5LrJGy/TNhBsz3FUDM0q+7ClTInsy3ylcpeqKw8Va4B0utPTXPz83LK+evTJcO0abIyqcvIN8nB8eK+fdNDvZ4Xm6wIEQPPPnt4WR0150vgZrDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vbpn10cQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705843636; x=1737379636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YvEOmwEWqmM2FzYz9JyLhCNzNVvl/cz5AWUT5qlVscQ=;
  b=Vbpn10cQH5JnCNXLNrTbko8OAc6VMBpBmPtlNDRjI9ZoLW8QOihM4KJ7
   9pSU2/MdvSyHsMy9C19j2hRZUbQZahiIWSlhUoLpooN84uauvRngKWcUg
   0+C7nJqF50O8Lwif7vs5JQyUqKLa9+cDitkGfFsmJwWh3riuTuocIw/js
   zuzzsokYdpzJvUXriJAv1bxmCbvK6b34PitxKyvo+XivCk6yC3AV91pX5
   bmaUBbTRXkvI/MaF9xgIgirnlE7vtDreAxvo8xeJ1DPQBeKoDv9Des4lv
   1AjXgiOGrbiCNToLy9OTX651wrIncANmwJMzQ7os6cg501irbYTAfxV0w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="927559"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="927559"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 05:27:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="33799535"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 Jan 2024 05:27:13 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRXqw-0005wm-0r;
	Sun, 21 Jan 2024 13:27:10 +0000
Date: Sun, 21 Jan 2024 21:27:04 +0800
From: kernel test robot <lkp@intel.com>
To: Pohsun Su <pohsuns@nvidia.com>, daniel.lezcano@linaro.org,
	tglx@linutronix.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, sumitg@nvidia.com,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Pohsun Su <pohsuns@nvidia.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/timer-tegra186: fix watchdog
 self-pinging.
Message-ID: <202401212150.DUcfhGzx-lkp@intel.com>
References: <20240116115838.16544-3-pohsuns@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116115838.16544-3-pohsuns@nvidia.com>

Hi Pohsun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on linus/master v6.7 next-20240119]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pohsun-Su/clocksource-drivers-timer-tegra186-add-WDIOC_GETTIMELEFT-support/20240116-200217
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20240116115838.16544-3-pohsuns%40nvidia.com
patch subject: [PATCH 2/2] clocksource/drivers/timer-tegra186: fix watchdog self-pinging.
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240121/202401212150.DUcfhGzx-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240121/202401212150.DUcfhGzx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401212150.DUcfhGzx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-tegra186.c:264:15: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     264 |         expiration = FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, readl_relaxed(wdt->regs + WDTSR));
         |                      ^
>> drivers/clocksource/timer-tegra186.c:414:15: warning: variable 'irq' set but not used [-Wunused-but-set-variable]
     414 |         unsigned int irq;
         |                      ^
   1 warning and 1 error generated.


vim +/irq +414 drivers/clocksource/timer-tegra186.c

42cee19a9f839f Thierry Reding 2022-07-04  241  
3d6bf45a82fb12 Pohsun Su      2024-01-16  242  static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device *wdd)
3d6bf45a82fb12 Pohsun Su      2024-01-16  243  {
3d6bf45a82fb12 Pohsun Su      2024-01-16  244  	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
3d6bf45a82fb12 Pohsun Su      2024-01-16  245  	u32 timeleft;
3d6bf45a82fb12 Pohsun Su      2024-01-16  246  	u32 expiration;
3d6bf45a82fb12 Pohsun Su      2024-01-16  247  
3d6bf45a82fb12 Pohsun Su      2024-01-16  248  	if (!watchdog_active(&wdt->base)) {
3d6bf45a82fb12 Pohsun Su      2024-01-16  249  		/* return zero if the watchdog timer is not activated. */
3d6bf45a82fb12 Pohsun Su      2024-01-16  250  		return 0;
3d6bf45a82fb12 Pohsun Su      2024-01-16  251  	}
3d6bf45a82fb12 Pohsun Su      2024-01-16  252  
3d6bf45a82fb12 Pohsun Su      2024-01-16  253  	/*
3d6bf45a82fb12 Pohsun Su      2024-01-16  254  	 * System power-on reset occurs on the fifth expiration of the watchdog timer and so
3d6bf45a82fb12 Pohsun Su      2024-01-16  255  	 * when the watchdog timer is configured, the actual value programmed into the counter
3d6bf45a82fb12 Pohsun Su      2024-01-16  256  	 * is 1/5 of the timeout value. Once the counter reaches 0, expiration count will be
3d6bf45a82fb12 Pohsun Su      2024-01-16  257  	 * increased by 1 and the down counter restarts.
3d6bf45a82fb12 Pohsun Su      2024-01-16  258  	 * Hence to get the time left before system reset we must combine 2 parts:
3d6bf45a82fb12 Pohsun Su      2024-01-16  259  	 * 1. value of the current down counter
3d6bf45a82fb12 Pohsun Su      2024-01-16  260  	 * 2. (number of counter expirations remaining) * (timeout/5)
3d6bf45a82fb12 Pohsun Su      2024-01-16  261  	 */
3d6bf45a82fb12 Pohsun Su      2024-01-16  262  
3d6bf45a82fb12 Pohsun Su      2024-01-16  263  	/* Get the current number of counter expirations. Should be a value between 0 and 4. */
3d6bf45a82fb12 Pohsun Su      2024-01-16 @264  	expiration = FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, readl_relaxed(wdt->regs + WDTSR));
3d6bf45a82fb12 Pohsun Su      2024-01-16  265  
3d6bf45a82fb12 Pohsun Su      2024-01-16  266  	/* Convert the current counter value to seconds, rounding up to the nearest second. */
3d6bf45a82fb12 Pohsun Su      2024-01-16  267  	timeleft = FIELD_GET(TMRSR_PCV, readl_relaxed(wdt->tmr->regs + TMRSR));
3d6bf45a82fb12 Pohsun Su      2024-01-16  268  	timeleft = (timeleft + USEC_PER_SEC / 2) / USEC_PER_SEC;
3d6bf45a82fb12 Pohsun Su      2024-01-16  269  
3d6bf45a82fb12 Pohsun Su      2024-01-16  270  	/*
3d6bf45a82fb12 Pohsun Su      2024-01-16  271  	 * Calculate the time remaining by adding the time for the counter value
3d6bf45a82fb12 Pohsun Su      2024-01-16  272  	 * to the time of the counter expirations that remain.
3d6bf45a82fb12 Pohsun Su      2024-01-16  273  	 */
3d6bf45a82fb12 Pohsun Su      2024-01-16  274  	timeleft += wdt->base.timeout * (4 - expiration) / 5;
3d6bf45a82fb12 Pohsun Su      2024-01-16  275  	return timeleft;
3d6bf45a82fb12 Pohsun Su      2024-01-16  276  }
3d6bf45a82fb12 Pohsun Su      2024-01-16  277  
42cee19a9f839f Thierry Reding 2022-07-04  278  static const struct watchdog_ops tegra186_wdt_ops = {
42cee19a9f839f Thierry Reding 2022-07-04  279  	.owner = THIS_MODULE,
42cee19a9f839f Thierry Reding 2022-07-04  280  	.start = tegra186_wdt_start,
42cee19a9f839f Thierry Reding 2022-07-04  281  	.stop = tegra186_wdt_stop,
42cee19a9f839f Thierry Reding 2022-07-04  282  	.ping = tegra186_wdt_ping,
42cee19a9f839f Thierry Reding 2022-07-04  283  	.set_timeout = tegra186_wdt_set_timeout,
3d6bf45a82fb12 Pohsun Su      2024-01-16  284  	.get_timeleft = tegra186_wdt_get_timeleft,
42cee19a9f839f Thierry Reding 2022-07-04  285  };
42cee19a9f839f Thierry Reding 2022-07-04  286  
42cee19a9f839f Thierry Reding 2022-07-04  287  static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
42cee19a9f839f Thierry Reding 2022-07-04  288  						unsigned int index)
42cee19a9f839f Thierry Reding 2022-07-04  289  {
42cee19a9f839f Thierry Reding 2022-07-04  290  	unsigned int offset = 0x10000, source;
42cee19a9f839f Thierry Reding 2022-07-04  291  	struct tegra186_wdt *wdt;
42cee19a9f839f Thierry Reding 2022-07-04  292  	u32 value;
42cee19a9f839f Thierry Reding 2022-07-04  293  	int err;
42cee19a9f839f Thierry Reding 2022-07-04  294  
42cee19a9f839f Thierry Reding 2022-07-04  295  	offset += tegra->soc->num_timers * 0x10000 + index * 0x10000;
42cee19a9f839f Thierry Reding 2022-07-04  296  
42cee19a9f839f Thierry Reding 2022-07-04  297  	wdt = devm_kzalloc(tegra->dev, sizeof(*wdt), GFP_KERNEL);
42cee19a9f839f Thierry Reding 2022-07-04  298  	if (!wdt)
42cee19a9f839f Thierry Reding 2022-07-04  299  		return ERR_PTR(-ENOMEM);
42cee19a9f839f Thierry Reding 2022-07-04  300  
42cee19a9f839f Thierry Reding 2022-07-04  301  	wdt->regs = tegra->regs + offset;
42cee19a9f839f Thierry Reding 2022-07-04  302  	wdt->index = index;
42cee19a9f839f Thierry Reding 2022-07-04  303  
42cee19a9f839f Thierry Reding 2022-07-04  304  	/* read the watchdog configuration since it might be locked down */
42cee19a9f839f Thierry Reding 2022-07-04  305  	value = wdt_readl(wdt, WDTCR);
42cee19a9f839f Thierry Reding 2022-07-04  306  
42cee19a9f839f Thierry Reding 2022-07-04  307  	if (value & WDTCR_LOCAL_INT_ENABLE)
42cee19a9f839f Thierry Reding 2022-07-04  308  		wdt->locked = true;
42cee19a9f839f Thierry Reding 2022-07-04  309  
42cee19a9f839f Thierry Reding 2022-07-04  310  	source = value & WDTCR_TIMER_SOURCE_MASK;
42cee19a9f839f Thierry Reding 2022-07-04  311  
42cee19a9f839f Thierry Reding 2022-07-04  312  	wdt->tmr = tegra186_tmr_create(tegra, source);
42cee19a9f839f Thierry Reding 2022-07-04  313  	if (IS_ERR(wdt->tmr))
42cee19a9f839f Thierry Reding 2022-07-04  314  		return ERR_CAST(wdt->tmr);
42cee19a9f839f Thierry Reding 2022-07-04  315  
42cee19a9f839f Thierry Reding 2022-07-04  316  	wdt->base.info = &tegra186_wdt_info;
42cee19a9f839f Thierry Reding 2022-07-04  317  	wdt->base.ops = &tegra186_wdt_ops;
42cee19a9f839f Thierry Reding 2022-07-04  318  	wdt->base.min_timeout = 1;
42cee19a9f839f Thierry Reding 2022-07-04  319  	wdt->base.max_timeout = 255;
42cee19a9f839f Thierry Reding 2022-07-04  320  	wdt->base.parent = tegra->dev;
42cee19a9f839f Thierry Reding 2022-07-04  321  
42cee19a9f839f Thierry Reding 2022-07-04  322  	err = watchdog_init_timeout(&wdt->base, 5, tegra->dev);
42cee19a9f839f Thierry Reding 2022-07-04  323  	if (err < 0) {
42cee19a9f839f Thierry Reding 2022-07-04  324  		dev_err(tegra->dev, "failed to initialize timeout: %d\n", err);
42cee19a9f839f Thierry Reding 2022-07-04  325  		return ERR_PTR(err);
42cee19a9f839f Thierry Reding 2022-07-04  326  	}
42cee19a9f839f Thierry Reding 2022-07-04  327  
42cee19a9f839f Thierry Reding 2022-07-04  328  	err = devm_watchdog_register_device(tegra->dev, &wdt->base);
42cee19a9f839f Thierry Reding 2022-07-04  329  	if (err < 0) {
42cee19a9f839f Thierry Reding 2022-07-04  330  		dev_err(tegra->dev, "failed to register WDT: %d\n", err);
42cee19a9f839f Thierry Reding 2022-07-04  331  		return ERR_PTR(err);
42cee19a9f839f Thierry Reding 2022-07-04  332  	}
42cee19a9f839f Thierry Reding 2022-07-04  333  
42cee19a9f839f Thierry Reding 2022-07-04  334  	return wdt;
42cee19a9f839f Thierry Reding 2022-07-04  335  }
42cee19a9f839f Thierry Reding 2022-07-04  336  
42cee19a9f839f Thierry Reding 2022-07-04  337  static u64 tegra186_timer_tsc_read(struct clocksource *cs)
42cee19a9f839f Thierry Reding 2022-07-04  338  {
42cee19a9f839f Thierry Reding 2022-07-04  339  	struct tegra186_timer *tegra = container_of(cs, struct tegra186_timer,
42cee19a9f839f Thierry Reding 2022-07-04  340  						    tsc);
42cee19a9f839f Thierry Reding 2022-07-04  341  	u32 hi, lo, ss;
42cee19a9f839f Thierry Reding 2022-07-04  342  
42cee19a9f839f Thierry Reding 2022-07-04  343  	hi = readl_relaxed(tegra->regs + TKETSC1);
42cee19a9f839f Thierry Reding 2022-07-04  344  
42cee19a9f839f Thierry Reding 2022-07-04  345  	/*
42cee19a9f839f Thierry Reding 2022-07-04  346  	 * The 56-bit value of the TSC is spread across two registers that are
42cee19a9f839f Thierry Reding 2022-07-04  347  	 * not synchronized. In order to read them atomically, ensure that the
42cee19a9f839f Thierry Reding 2022-07-04  348  	 * high 24 bits match before and after reading the low 32 bits.
42cee19a9f839f Thierry Reding 2022-07-04  349  	 */
42cee19a9f839f Thierry Reding 2022-07-04  350  	do {
42cee19a9f839f Thierry Reding 2022-07-04  351  		/* snapshot the high 24 bits */
42cee19a9f839f Thierry Reding 2022-07-04  352  		ss = hi;
42cee19a9f839f Thierry Reding 2022-07-04  353  
42cee19a9f839f Thierry Reding 2022-07-04  354  		lo = readl_relaxed(tegra->regs + TKETSC0);
42cee19a9f839f Thierry Reding 2022-07-04  355  		hi = readl_relaxed(tegra->regs + TKETSC1);
42cee19a9f839f Thierry Reding 2022-07-04  356  	} while (hi != ss);
42cee19a9f839f Thierry Reding 2022-07-04  357  
42cee19a9f839f Thierry Reding 2022-07-04  358  	return (u64)hi << 32 | lo;
42cee19a9f839f Thierry Reding 2022-07-04  359  }
42cee19a9f839f Thierry Reding 2022-07-04  360  
42cee19a9f839f Thierry Reding 2022-07-04  361  static int tegra186_timer_tsc_init(struct tegra186_timer *tegra)
42cee19a9f839f Thierry Reding 2022-07-04  362  {
42cee19a9f839f Thierry Reding 2022-07-04  363  	tegra->tsc.name = "tsc";
42cee19a9f839f Thierry Reding 2022-07-04  364  	tegra->tsc.rating = 300;
42cee19a9f839f Thierry Reding 2022-07-04  365  	tegra->tsc.read = tegra186_timer_tsc_read;
42cee19a9f839f Thierry Reding 2022-07-04  366  	tegra->tsc.mask = CLOCKSOURCE_MASK(56);
42cee19a9f839f Thierry Reding 2022-07-04  367  	tegra->tsc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
42cee19a9f839f Thierry Reding 2022-07-04  368  
42cee19a9f839f Thierry Reding 2022-07-04  369  	return clocksource_register_hz(&tegra->tsc, 31250000);
42cee19a9f839f Thierry Reding 2022-07-04  370  }
42cee19a9f839f Thierry Reding 2022-07-04  371  
42cee19a9f839f Thierry Reding 2022-07-04  372  static u64 tegra186_timer_osc_read(struct clocksource *cs)
42cee19a9f839f Thierry Reding 2022-07-04  373  {
42cee19a9f839f Thierry Reding 2022-07-04  374  	struct tegra186_timer *tegra = container_of(cs, struct tegra186_timer,
42cee19a9f839f Thierry Reding 2022-07-04  375  						    osc);
42cee19a9f839f Thierry Reding 2022-07-04  376  
42cee19a9f839f Thierry Reding 2022-07-04  377  	return readl_relaxed(tegra->regs + TKEOSC);
42cee19a9f839f Thierry Reding 2022-07-04  378  }
42cee19a9f839f Thierry Reding 2022-07-04  379  
42cee19a9f839f Thierry Reding 2022-07-04  380  static int tegra186_timer_osc_init(struct tegra186_timer *tegra)
42cee19a9f839f Thierry Reding 2022-07-04  381  {
42cee19a9f839f Thierry Reding 2022-07-04  382  	tegra->osc.name = "osc";
42cee19a9f839f Thierry Reding 2022-07-04  383  	tegra->osc.rating = 300;
42cee19a9f839f Thierry Reding 2022-07-04  384  	tegra->osc.read = tegra186_timer_osc_read;
42cee19a9f839f Thierry Reding 2022-07-04  385  	tegra->osc.mask = CLOCKSOURCE_MASK(32);
42cee19a9f839f Thierry Reding 2022-07-04  386  	tegra->osc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
42cee19a9f839f Thierry Reding 2022-07-04  387  
42cee19a9f839f Thierry Reding 2022-07-04  388  	return clocksource_register_hz(&tegra->osc, 38400000);
42cee19a9f839f Thierry Reding 2022-07-04  389  }
42cee19a9f839f Thierry Reding 2022-07-04  390  
42cee19a9f839f Thierry Reding 2022-07-04  391  static u64 tegra186_timer_usec_read(struct clocksource *cs)
42cee19a9f839f Thierry Reding 2022-07-04  392  {
42cee19a9f839f Thierry Reding 2022-07-04  393  	struct tegra186_timer *tegra = container_of(cs, struct tegra186_timer,
42cee19a9f839f Thierry Reding 2022-07-04  394  						    usec);
42cee19a9f839f Thierry Reding 2022-07-04  395  
42cee19a9f839f Thierry Reding 2022-07-04  396  	return readl_relaxed(tegra->regs + TKEUSEC);
42cee19a9f839f Thierry Reding 2022-07-04  397  }
42cee19a9f839f Thierry Reding 2022-07-04  398  
42cee19a9f839f Thierry Reding 2022-07-04  399  static int tegra186_timer_usec_init(struct tegra186_timer *tegra)
42cee19a9f839f Thierry Reding 2022-07-04  400  {
42cee19a9f839f Thierry Reding 2022-07-04  401  	tegra->usec.name = "usec";
42cee19a9f839f Thierry Reding 2022-07-04  402  	tegra->usec.rating = 300;
42cee19a9f839f Thierry Reding 2022-07-04  403  	tegra->usec.read = tegra186_timer_usec_read;
42cee19a9f839f Thierry Reding 2022-07-04  404  	tegra->usec.mask = CLOCKSOURCE_MASK(32);
42cee19a9f839f Thierry Reding 2022-07-04  405  	tegra->usec.flags = CLOCK_SOURCE_IS_CONTINUOUS;
42cee19a9f839f Thierry Reding 2022-07-04  406  
42cee19a9f839f Thierry Reding 2022-07-04  407  	return clocksource_register_hz(&tegra->usec, USEC_PER_SEC);
42cee19a9f839f Thierry Reding 2022-07-04  408  }
42cee19a9f839f Thierry Reding 2022-07-04  409  
42cee19a9f839f Thierry Reding 2022-07-04  410  static int tegra186_timer_probe(struct platform_device *pdev)
42cee19a9f839f Thierry Reding 2022-07-04  411  {
42cee19a9f839f Thierry Reding 2022-07-04  412  	struct device *dev = &pdev->dev;
42cee19a9f839f Thierry Reding 2022-07-04  413  	struct tegra186_timer *tegra;
42cee19a9f839f Thierry Reding 2022-07-04 @414  	unsigned int irq;
42cee19a9f839f Thierry Reding 2022-07-04  415  	int err;
42cee19a9f839f Thierry Reding 2022-07-04  416  
42cee19a9f839f Thierry Reding 2022-07-04  417  	tegra = devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);
42cee19a9f839f Thierry Reding 2022-07-04  418  	if (!tegra)
42cee19a9f839f Thierry Reding 2022-07-04  419  		return -ENOMEM;
42cee19a9f839f Thierry Reding 2022-07-04  420  
42cee19a9f839f Thierry Reding 2022-07-04  421  	tegra->soc = of_device_get_match_data(dev);
42cee19a9f839f Thierry Reding 2022-07-04  422  	dev_set_drvdata(dev, tegra);
42cee19a9f839f Thierry Reding 2022-07-04  423  	tegra->dev = dev;
42cee19a9f839f Thierry Reding 2022-07-04  424  
42cee19a9f839f Thierry Reding 2022-07-04  425  	tegra->regs = devm_platform_ioremap_resource(pdev, 0);
42cee19a9f839f Thierry Reding 2022-07-04  426  	if (IS_ERR(tegra->regs))
42cee19a9f839f Thierry Reding 2022-07-04  427  		return PTR_ERR(tegra->regs);
42cee19a9f839f Thierry Reding 2022-07-04  428  
42cee19a9f839f Thierry Reding 2022-07-04  429  	err = platform_get_irq(pdev, 0);
42cee19a9f839f Thierry Reding 2022-07-04  430  	if (err < 0)
42cee19a9f839f Thierry Reding 2022-07-04  431  		return err;
42cee19a9f839f Thierry Reding 2022-07-04  432  
42cee19a9f839f Thierry Reding 2022-07-04  433  	irq = err;
42cee19a9f839f Thierry Reding 2022-07-04  434  
42cee19a9f839f Thierry Reding 2022-07-04  435  	/* create a watchdog using a preconfigured timer */
42cee19a9f839f Thierry Reding 2022-07-04  436  	tegra->wdt = tegra186_wdt_create(tegra, 0);
42cee19a9f839f Thierry Reding 2022-07-04  437  	if (IS_ERR(tegra->wdt)) {
42cee19a9f839f Thierry Reding 2022-07-04  438  		err = PTR_ERR(tegra->wdt);
42cee19a9f839f Thierry Reding 2022-07-04  439  		dev_err(dev, "failed to create WDT: %d\n", err);
42cee19a9f839f Thierry Reding 2022-07-04  440  		return err;
42cee19a9f839f Thierry Reding 2022-07-04  441  	}
42cee19a9f839f Thierry Reding 2022-07-04  442  
42cee19a9f839f Thierry Reding 2022-07-04  443  	err = tegra186_timer_tsc_init(tegra);
42cee19a9f839f Thierry Reding 2022-07-04  444  	if (err < 0) {
42cee19a9f839f Thierry Reding 2022-07-04  445  		dev_err(dev, "failed to register TSC counter: %d\n", err);
42cee19a9f839f Thierry Reding 2022-07-04  446  		return err;
42cee19a9f839f Thierry Reding 2022-07-04  447  	}
42cee19a9f839f Thierry Reding 2022-07-04  448  
42cee19a9f839f Thierry Reding 2022-07-04  449  	err = tegra186_timer_osc_init(tegra);
42cee19a9f839f Thierry Reding 2022-07-04  450  	if (err < 0) {
42cee19a9f839f Thierry Reding 2022-07-04  451  		dev_err(dev, "failed to register OSC counter: %d\n", err);
42cee19a9f839f Thierry Reding 2022-07-04  452  		goto unregister_tsc;
42cee19a9f839f Thierry Reding 2022-07-04  453  	}
42cee19a9f839f Thierry Reding 2022-07-04  454  
42cee19a9f839f Thierry Reding 2022-07-04  455  	err = tegra186_timer_usec_init(tegra);
42cee19a9f839f Thierry Reding 2022-07-04  456  	if (err < 0) {
42cee19a9f839f Thierry Reding 2022-07-04  457  		dev_err(dev, "failed to register USEC counter: %d\n", err);
42cee19a9f839f Thierry Reding 2022-07-04  458  		goto unregister_osc;
42cee19a9f839f Thierry Reding 2022-07-04  459  	}
42cee19a9f839f Thierry Reding 2022-07-04  460  
42cee19a9f839f Thierry Reding 2022-07-04  461  	return 0;
42cee19a9f839f Thierry Reding 2022-07-04  462  
42cee19a9f839f Thierry Reding 2022-07-04  463  unregister_osc:
42cee19a9f839f Thierry Reding 2022-07-04  464  	clocksource_unregister(&tegra->osc);
42cee19a9f839f Thierry Reding 2022-07-04  465  unregister_tsc:
42cee19a9f839f Thierry Reding 2022-07-04  466  	clocksource_unregister(&tegra->tsc);
42cee19a9f839f Thierry Reding 2022-07-04  467  	return err;
42cee19a9f839f Thierry Reding 2022-07-04  468  }
42cee19a9f839f Thierry Reding 2022-07-04  469  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

