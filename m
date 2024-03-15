Return-Path: <linux-kernel+bounces-104630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D558487D140
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B3B226EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4610D4596F;
	Fri, 15 Mar 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOtSs5Dh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A51B7EA;
	Fri, 15 Mar 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520583; cv=none; b=ozqqRojh9zPm3GZPMP3jlz+968dE9zW/FB+ls2Y4f7m9IxDoyy+IBqcNjXJZjTfIhuahkTAnj6Fw8uVuCVPjCyYoWjqN0r0UMQqYJe17Vib/nGuwWOV9WOS073Gd5hBri9CSIZi3lK2cnbXLc5WyGyqVNVRoh8JTxuGp1uN81TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520583; c=relaxed/simple;
	bh=Fa9Ztd/K1MwNoFLIeksl2r8/Q4sGwApcc9Q86oCxLK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jagav95BoYKOTgTKGD9mz4dAgef5+6RYDETYoUwoz8IlaZmQcBLdsE76JuDuqpC+sFxHWFJVURTLOBZEIU+A46yO+hKuchKxrbY7PHVkScP+KnThanB6EhvAplZSK5qm5w3DVEmX/qNpt1yRcEF0A353bgDVgR7GcjTLc3r5bs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOtSs5Dh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710520581; x=1742056581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fa9Ztd/K1MwNoFLIeksl2r8/Q4sGwApcc9Q86oCxLK4=;
  b=mOtSs5Dh8fWjNKHX23gEYsFPUt9dfh93djy1pZvYSIHwGrfeTJp3fBNb
   yU74Anc6vOdND8zd8cMxmHvJIzNjeDErUBsIWZsuFkDMnWfHaKlOdpv/3
   XceZ0uddTH6wIGO8IjG97yecnUE33zk2wMFGHnDJM9m0vtcqlheRx34FT
   NUTZNoWAGxDb8UXI5+V76SchEmb1TzCRWjyfOxWMUtpBT9UZ/fjLFyf92
   FcreEjV/3zoQXO0pu5w7Pt2ZZGz61fS3fWMXa43WpNJajACeUqfkfoe1f
   TAl0dnRILOkgS038ZMWgOMR6/LZvk6CRdq90slVdc9se6cNqUnDyp0ZYQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5257660"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5257660"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 09:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="35852964"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2024 09:36:17 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlAXW-000Ecq-0w;
	Fri, 15 Mar 2024 16:36:14 +0000
Date: Sat, 16 Mar 2024 00:36:05 +0800
From: kernel test robot <lkp@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lukasz.luba@arm.com,
	dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org, rafael@kernel.org,
	viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com, m.szyprowski@samsung.com,
	mhiramat@kernel.org
Subject: Re: [PATCH 3/4] PM: EM: Add em_dev_update_chip_binning()
Message-ID: <202403160033.Kh6R75dh-lkp@intel.com>
References: <20240314140421.3563571-4-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314140421.3563571-4-lukasz.luba@arm.com>

Hi Lukasz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master next-20240315]
[cannot apply to krzk/for-next clk/clk-next soc/for-next rafael-pm/acpi-bus rafael-pm/devprop v6.8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Luba/OPP-OF-Export-dev_opp_pm_calc_power-for-usage-from-EM/20240314-220719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240314140421.3563571-4-lukasz.luba%40arm.com
patch subject: [PATCH 3/4] PM: EM: Add em_dev_update_chip_binning()
config: i386-randconfig-141-20240315 (https://download.01.org/0day-ci/archive/20240316/202403160033.Kh6R75dh-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403160033.Kh6R75dh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403160033.Kh6R75dh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/power/energy_model.c:824:52: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     824 |                 dev_warn(dev, "Couldn't find Energy Model %d\n", ret);
         |                                                                  ^~~
   include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                             ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   kernel/power/energy_model.c:817:12: note: initialize the variable 'ret' to silence this warning
     817 |         int i, ret;
         |                   ^
         |                    = 0
   1 warning generated.


vim +/ret +824 kernel/power/energy_model.c

   800	
   801	/**
   802	 * em_dev_update_chip_binning() - Update Energy Model with new values after
   803	 *			the new voltage information is present in the OPPs.
   804	 * @dev		: Device for which the Energy Model has to be updated.
   805	 *
   806	 * This function allows to update easily the EM with new values available in
   807	 * the OPP framework and DT. It can be used after the chip has been properly
   808	 * verified by device drivers and the voltages adjusted for the 'chip binning'.
   809	 * It uses the "dynamic-power-coefficient" DT property to calculate the power
   810	 * values for EM. For power calculation it uses the new adjusted voltage
   811	 * values known for OPPs, which might be changed after boot.
   812	 */
   813	int em_dev_update_chip_binning(struct device *dev)
   814	{
   815		struct em_perf_table __rcu *em_table;
   816		struct em_perf_domain *pd;
   817		int i, ret;
   818	
   819		if (IS_ERR_OR_NULL(dev))
   820			return -EINVAL;
   821	
   822		pd = em_pd_get(dev);
   823		if (!pd) {
 > 824			dev_warn(dev, "Couldn't find Energy Model %d\n", ret);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

