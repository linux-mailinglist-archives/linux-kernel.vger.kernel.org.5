Return-Path: <linux-kernel+bounces-40429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3407783E001
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EE91C2258A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C720328;
	Fri, 26 Jan 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgsaCKwE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722E20312;
	Fri, 26 Jan 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290033; cv=none; b=SUOy1rt9yNeyZRUKTrdk5lYYxI87mJoTy0sckqynzzMnZQOLu3RDEliNVvNh+LvN5+gJFRk4DBEeyl5BNeKebdoV2tBeyk5lusU/Xo4gY1oOrBkXZz+PkPwVT8A7yT4Yw9snx3LfT0fmyn/U7a0KaeuEKkbE4uR5fac+uKRAm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290033; c=relaxed/simple;
	bh=ExosIx/Tv+HMtpYZXXx/Nr7K+HPt5okvEH3K8cRZO8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/E53RH2zcq1oDQ4lRx3PS2K2OHXJL35OJ2kd91VpK8xyF9RPOGVx2lPOf+x/CS0NbTtAlsmcQxUjdfQFR+1wEqnk0E4DRDBkq4/H7z2tfVnxfEGuBV5oTUutsK5sjO11sxTHa7kmiGuyemhHhlCTeEQpg4NnVtPg5F3KWPadBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgsaCKwE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706290030; x=1737826030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ExosIx/Tv+HMtpYZXXx/Nr7K+HPt5okvEH3K8cRZO8M=;
  b=fgsaCKwEBtdt4hmubdpzvo99h8ndm7j0lT2SER30rNvFK6YN5qWL4HRw
   CdBIVkXe//2Y9ADbuJe6YMGBuCKBaVPpw/alzLTGNA0LolIK96Maupk2B
   pbdgsya/v3T08pgiSzs/3BR2JTyfZBfwDdKApK3Jk6uXxGrSgKZ3a8ggi
   6vMMVXfZZsLPM4h5yOyLV5JB4hXBqo8FWLZXX+euMuz6BrLym7YSMA+yS
   RVeLhmeceHxV+o5VZkqq4M581Gx6ifhXXgbCPgMj80x4opTCA/grjL44G
   d95B2e7JpncSM9ymuG27HIDtMYFHOd0I5pI3gk5ZHQwIOopRnQPdTsUzj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="23989055"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="23989055"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 09:27:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787172240"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="787172240"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2024 09:27:04 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTPyo-0001Ew-1L;
	Fri, 26 Jan 2024 17:27:02 +0000
Date: Sat, 27 Jan 2024 01:26:21 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux@roeck-us.net, wim@linux-watchdog.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com,
	chanho61.park@samsung.com, semen.protsenko@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel-team@android.com, peter.griffin@linaro.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	saravanak@google.com, willmcvicker@google.com, linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/9] soc: samsung: exynos-pmu: Add
 exynos_pmu_update/read/write APIs and SoC quirks
Message-ID: <202401270110.YlAvkNYL-lkp@intel.com>
References: <20240122225710.1952066-3-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122225710.1952066-3-peter.griffin@linaro.org>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on robh/for-next soc/for-next linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Griffin/dt-bindings-watchdog-samsung-wdt-deprecate-samsung-syscon-phandle/20240123-070052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20240122225710.1952066-3-peter.griffin%40linaro.org
patch subject: [PATCH 2/9] soc: samsung: exynos-pmu: Add exynos_pmu_update/read/write APIs and SoC quirks
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240127/202401270110.YlAvkNYL-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401270110.YlAvkNYL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401270110.YlAvkNYL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pmu_base_addr
   >>> referenced by exynos.c
   >>>               arch/arm/mach-exynos/exynos.o:(exynos_set_delayed_reset_assertion) in archive vmlinux.a
   >>> referenced by exynos.c
   >>>               arch/arm/mach-exynos/exynos.o:(exynos_set_delayed_reset_assertion) in archive vmlinux.a
   >>> referenced by exynos.c
   >>>               arch/arm/mach-exynos/exynos.o:(exynos_init_irq) in archive vmlinux.a
   >>> referenced 75 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

