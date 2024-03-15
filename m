Return-Path: <linux-kernel+bounces-104601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67187D0B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89201281E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F57405FF;
	Fri, 15 Mar 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRJi+fCt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814C405FC;
	Fri, 15 Mar 2024 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518062; cv=none; b=h+pl6uhxnG4hEWnrXltj0qE7jMisIoLvOYx14QDF74KpyKGkUEIEyKXhRH/cM/MdgIKwE98Oc4/gM+w2WD1Fms+ESaQHbhzqLntnxgwRNU3Wc2nzlcOXvMM477r7bqss8FB+Qg9mEAqmJxboz+RsRgRszZMuHn1GGukoUAxhONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518062; c=relaxed/simple;
	bh=s0OIHKNEwGIa5s7KPpYL0a1H8D5CL9bczCXQZrpz4DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsDnSom28CXaZ+xh6TREcbhfkxCvHlEHgDSWKZFEwtoby+l7/ebvsPM+dz4aJIjcDxtohEfkGDt752LuPUD77bPXEUNovew2QjW8OI9W4zUWWjJ9xdJKc8UlZaV1Gae9JkXbTA1G0aBei5sKmUqxtSns6X/tD64xWBeHJEzWNYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRJi+fCt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710518059; x=1742054059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s0OIHKNEwGIa5s7KPpYL0a1H8D5CL9bczCXQZrpz4DY=;
  b=ZRJi+fCtAmSb22rJktzFBgA44wzYeI0ldssmlX+v+oxdJMd48jxRnbre
   pbFKFch6wFfABugiPKsjIO+bYOJkPsCXJj81xDy+ocCK4J+hRrKlejShk
   KLsf9LqLwtyeuqKrHegfr282s+VUfWNq6XZcUyQGoI1gJoRyyMwgvigTP
   j45pzbYeM/KDvoCNT1Qhl1so3sTG4bEmNUEQEOAjPWstOk6WtucRUo8zJ
   w3hadSbEb4nxlU29m/71e3RfnBUIqrbs1XJfR/+Zk07Uwfm7gvzi0t8CE
   G6hUPHBl2Kqgu9pWp16x3hsg93pEV3Os3E5Lmpb/MGJUyHFVh6mkZl45T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5529419"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5529419"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 08:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="43750025"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Mar 2024 08:54:14 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl9sq-000EZF-1E;
	Fri, 15 Mar 2024 15:54:12 +0000
Date: Fri, 15 Mar 2024 23:54:04 +0800
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
Message-ID: <202403152322.1OIlZSAj-lkp@intel.com>
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
config: x86_64-randconfig-123-20240315 (https://download.01.org/0day-ci/archive/20240315/202403152322.1OIlZSAj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240315/202403152322.1OIlZSAj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403152322.1OIlZSAj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/power/energy_model.c:168:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct em_perf_table [noderef] __rcu *table @@     got struct em_perf_table * @@
   kernel/power/energy_model.c:168:15: sparse:     expected struct em_perf_table [noderef] __rcu *table
   kernel/power/energy_model.c:168:15: sparse:     got struct em_perf_table *
   kernel/power/energy_model.c:169:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct em_perf_table [noderef] __rcu *table @@
   kernel/power/energy_model.c:169:15: sparse:     expected void const *objp
   kernel/power/energy_model.c:169:15: sparse:     got struct em_perf_table [noderef] __rcu *table
   kernel/power/energy_model.c:177:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct em_perf_table [noderef] __rcu *table @@     got struct em_perf_table * @@
   kernel/power/energy_model.c:177:15: sparse:     expected struct em_perf_table [noderef] __rcu *table
   kernel/power/energy_model.c:177:15: sparse:     got struct em_perf_table *
   kernel/power/energy_model.c:179:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
   kernel/power/energy_model.c:179:19: sparse:     expected struct callback_head *head
   kernel/power/energy_model.c:179:19: sparse:     got struct callback_head [noderef] __rcu *
   kernel/power/energy_model.c:190:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct kref *kref @@     got struct kref [noderef] __rcu * @@
   kernel/power/energy_model.c:190:19: sparse:     expected struct kref *kref
   kernel/power/energy_model.c:190:19: sparse:     got struct kref [noderef] __rcu *
   kernel/power/energy_model.c:208:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct em_perf_table [noderef] __rcu *table @@     got void * @@
   kernel/power/energy_model.c:208:15: sparse:     expected struct em_perf_table [noderef] __rcu *table
   kernel/power/energy_model.c:208:15: sparse:     got void *
   kernel/power/energy_model.c:212:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct kref *kref @@     got struct kref [noderef] __rcu * @@
   kernel/power/energy_model.c:212:20: sparse:     expected struct kref *kref
   kernel/power/energy_model.c:212:20: sparse:     got struct kref [noderef] __rcu *
   kernel/power/energy_model.c:328:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct kref *kref @@     got struct kref [noderef] __rcu * @@
   kernel/power/energy_model.c:328:19: sparse:     expected struct kref *kref
   kernel/power/energy_model.c:328:19: sparse:     got struct kref [noderef] __rcu *
   kernel/power/energy_model.c:333:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct em_perf_state *table @@     got struct em_perf_state [noderef] __rcu * @@
   kernel/power/energy_model.c:333:45: sparse:     expected struct em_perf_state *table
   kernel/power/energy_model.c:333:45: sparse:     got struct em_perf_state [noderef] __rcu *
   kernel/power/energy_model.c:433:45: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct em_perf_state *table @@     got struct em_perf_state [noderef] __rcu * @@
   kernel/power/energy_model.c:433:45: sparse:     expected struct em_perf_state *table
   kernel/power/energy_model.c:433:45: sparse:     got struct em_perf_state [noderef] __rcu *
   kernel/power/energy_model.c:450:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct em_perf_table [noderef] __rcu *[assigned] em_table @@
   kernel/power/energy_model.c:450:15: sparse:     expected void const *objp
   kernel/power/energy_model.c:450:15: sparse:     got struct em_perf_table [noderef] __rcu *[assigned] em_table
   kernel/power/energy_model.c:621:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct em_perf_state *table @@     got struct em_perf_state [noderef] __rcu * @@
   kernel/power/energy_model.c:621:55: sparse:     expected struct em_perf_state *table
   kernel/power/energy_model.c:621:55: sparse:     got struct em_perf_state [noderef] __rcu *
   kernel/power/energy_model.c:676:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct em_perf_state *new_ps @@     got struct em_perf_state [noderef] __rcu * @@
   kernel/power/energy_model.c:676:16: sparse:     expected struct em_perf_state *new_ps
   kernel/power/energy_model.c:676:16: sparse:     got struct em_perf_state [noderef] __rcu *
   kernel/power/energy_model.c:694:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct em_perf_state *table @@     got struct em_perf_state [noderef] __rcu * @@
   kernel/power/energy_model.c:694:37: sparse:     expected struct em_perf_state *table
   kernel/power/energy_model.c:694:37: sparse:     got struct em_perf_state [noderef] __rcu *
   kernel/power/energy_model.c:729:38: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct em_perf_state *table @@     got struct em_perf_state [noderef] __rcu * @@
   kernel/power/energy_model.c:729:38: sparse:     expected struct em_perf_state *table
   kernel/power/energy_model.c:729:38: sparse:     got struct em_perf_state [noderef] __rcu *
>> kernel/power/energy_model.c:836:53: sparse: sparse: dereference of noderef expression
   kernel/power/energy_model.c:845:32: sparse: sparse: dereference of noderef expression

vim +836 kernel/power/energy_model.c

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
   824			dev_warn(dev, "Couldn't find Energy Model %d\n", ret);
   825			return -EINVAL;
   826		}
   827	
   828		em_table = em_table_dup(pd);
   829		if (!em_table) {
   830			dev_warn(dev, "EM: allocation failed\n");
   831			return -ENOMEM;
   832		}
   833	
   834		/* Update power values which might change due to new voltage in OPPs */
   835		for (i = 0; i < pd->nr_perf_states; i++) {
 > 836			unsigned long freq = em_table->state[i].frequency;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

