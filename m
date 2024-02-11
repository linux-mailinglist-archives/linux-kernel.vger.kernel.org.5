Return-Path: <linux-kernel+bounces-60903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8606F850ACB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7241F219E2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2125D470;
	Sun, 11 Feb 2024 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEgTWRUh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E24C5D460;
	Sun, 11 Feb 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707675611; cv=none; b=u4BnWhpGd2O13GlPzROSgE6yEUcMW1jOv0kWQh2JZs/h7Ht3snig4rnXZSa9RESWWVxGtlO8GLq0vFLWd/8Lh1hpEy5nKAaR3ipC2ranFb7HqcqxsCe3cxU5fTU/iIk+jZEof6baPX79U/NAOGfWGL7Q536LT/SdWWbM1oY5HUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707675611; c=relaxed/simple;
	bh=oU3+pTwOlDgbtW1/NcvyIj7JX7BmSedhjcnRgv/xZEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elkjQ072uqROXwdBwZIUd3Z9CXleMiR7OWwkxPgL7VbJ6/ONwk6CLONG64dru4tNt/fU/PIeLB/G7Rub7Aq2iBFqRL7kXsVHRrjVzl2pEHbZiTmy+qPQG51nwPqxnBYm07ioq9KYVGU73PyAVktpYIA1nBZNWdxeo81/DhtfRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEgTWRUh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707675609; x=1739211609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oU3+pTwOlDgbtW1/NcvyIj7JX7BmSedhjcnRgv/xZEk=;
  b=OEgTWRUhm1wtyCSYhYeom2MAimpf3eEWzZRSr2GPaIZe/TPri+IZSwV9
   IfLfK80zBC4xa/r3cwxXa4lt3WyesG45Ks066wm9SjsnNgIEVYWYoxu+Y
   k+ZhUUU9fxM0O5ezFeF3QlH6QVUTuyUrwXSlELXzkdlc8uo15Tjodv+4c
   Zq5+V4ZiuG7TB6vYJlf7954rfWCbvjSC4eAqrHe2Ny1oaUyw38PlryBlh
   kEp8HRhoEH/mqrgVvNXyjodYcWxtZ+7Cf0pfwGLXubMpj8/r0jpkmy3TU
   3Gb3Hs7prooyjszQr2YrqwDyydmw7P3gsJ2I1kJh7RK2NdOZG0oyyDF9F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1501625"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="1501625"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 10:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="39856770"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Feb 2024 10:20:05 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZEQs-0006ig-1b;
	Sun, 11 Feb 2024 18:20:02 +0000
Date: Mon, 12 Feb 2024 02:19:37 +0800
From: kernel test robot <lkp@intel.com>
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
	Mario.Limonciello@amd.com, viresh.kumar@linaro.org,
	Ray.Huang@amd.com, gautham.shenoy@amd.com, Borislav.Petkov@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] cpufreq: amd-pstate: initialize new core precision
 boost state
Message-ID: <202402120216.mjdQyGCs-lkp@intel.com>
References: <0409d40c500eeb8d4d84ecb028b73f2eee147822.1706255676.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0409d40c500eeb8d4d84ecb028b73f2eee147822.1706255676.git.perry.yuan@amd.com>

Hi Perry,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/acpi-bus]
[also build test ERROR on v6.8-rc3]
[cannot apply to rafael-pm/linux-next linus/master rafael-pm/devprop next-20240209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Perry-Yuan/cpufreq-amd-pstate-remove-set_boost-callback-for-passive-mode/20240126-171412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-bus
patch link:    https://lore.kernel.org/r/0409d40c500eeb8d4d84ecb028b73f2eee147822.1706255676.git.perry.yuan%40amd.com
patch subject: [PATCH 2/7] cpufreq: amd-pstate: initialize new core precision boost state
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240212/202402120216.mjdQyGCs-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402120216.mjdQyGCs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402120216.mjdQyGCs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate-ut.c:229:16: error: no member named 'boost_supported' in 'struct amd_cpudata'
     229 |                 if (cpudata->boost_supported) {
         |                     ~~~~~~~  ^
   1 error generated.


vim +229 drivers/cpufreq/amd-pstate-ut.c

14eb1c96e3a3fd Meng Li        2022-08-17  193  
14eb1c96e3a3fd Meng Li        2022-08-17  194  /*
14eb1c96e3a3fd Meng Li        2022-08-17  195   * Check if frequency values are reasonable.
14eb1c96e3a3fd Meng Li        2022-08-17  196   * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
14eb1c96e3a3fd Meng Li        2022-08-17  197   * check max freq when set support boost mode.
14eb1c96e3a3fd Meng Li        2022-08-17  198   */
14eb1c96e3a3fd Meng Li        2022-08-17  199  static void amd_pstate_ut_check_freq(u32 index)
14eb1c96e3a3fd Meng Li        2022-08-17  200  {
14eb1c96e3a3fd Meng Li        2022-08-17  201  	int cpu = 0;
14eb1c96e3a3fd Meng Li        2022-08-17  202  	struct cpufreq_policy *policy = NULL;
14eb1c96e3a3fd Meng Li        2022-08-17  203  	struct amd_cpudata *cpudata = NULL;
14eb1c96e3a3fd Meng Li        2022-08-17  204  
14eb1c96e3a3fd Meng Li        2022-08-17  205  	for_each_possible_cpu(cpu) {
14eb1c96e3a3fd Meng Li        2022-08-17  206  		policy = cpufreq_cpu_get(cpu);
14eb1c96e3a3fd Meng Li        2022-08-17  207  		if (!policy)
14eb1c96e3a3fd Meng Li        2022-08-17  208  			break;
14eb1c96e3a3fd Meng Li        2022-08-17  209  		cpudata = policy->driver_data;
14eb1c96e3a3fd Meng Li        2022-08-17  210  
14eb1c96e3a3fd Meng Li        2022-08-17  211  		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
14eb1c96e3a3fd Meng Li        2022-08-17  212  			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
14eb1c96e3a3fd Meng Li        2022-08-17  213  			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
14eb1c96e3a3fd Meng Li        2022-08-17  214  			(cpudata->min_freq > 0))) {
14eb1c96e3a3fd Meng Li        2022-08-17  215  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
14eb1c96e3a3fd Meng Li        2022-08-17  216  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
14eb1c96e3a3fd Meng Li        2022-08-17  217  				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
14eb1c96e3a3fd Meng Li        2022-08-17  218  				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
60dd283804479c Swapnil Sapkal 2023-08-18  219  			goto skip_test;
14eb1c96e3a3fd Meng Li        2022-08-17  220  		}
14eb1c96e3a3fd Meng Li        2022-08-17  221  
14eb1c96e3a3fd Meng Li        2022-08-17  222  		if (cpudata->min_freq != policy->min) {
14eb1c96e3a3fd Meng Li        2022-08-17  223  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
14eb1c96e3a3fd Meng Li        2022-08-17  224  			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d, they should be equal!\n",
14eb1c96e3a3fd Meng Li        2022-08-17  225  				__func__, cpu, cpudata->min_freq, policy->min);
60dd283804479c Swapnil Sapkal 2023-08-18  226  			goto skip_test;
14eb1c96e3a3fd Meng Li        2022-08-17  227  		}
14eb1c96e3a3fd Meng Li        2022-08-17  228  
14eb1c96e3a3fd Meng Li        2022-08-17 @229  		if (cpudata->boost_supported) {
14eb1c96e3a3fd Meng Li        2022-08-17  230  			if ((policy->max == cpudata->max_freq) ||
14eb1c96e3a3fd Meng Li        2022-08-17  231  					(policy->max == cpudata->nominal_freq))
14eb1c96e3a3fd Meng Li        2022-08-17  232  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
14eb1c96e3a3fd Meng Li        2022-08-17  233  			else {
14eb1c96e3a3fd Meng Li        2022-08-17  234  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
14eb1c96e3a3fd Meng Li        2022-08-17  235  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
14eb1c96e3a3fd Meng Li        2022-08-17  236  					__func__, cpu, policy->max, cpudata->max_freq,
14eb1c96e3a3fd Meng Li        2022-08-17  237  					cpudata->nominal_freq);
60dd283804479c Swapnil Sapkal 2023-08-18  238  				goto skip_test;
14eb1c96e3a3fd Meng Li        2022-08-17  239  			}
14eb1c96e3a3fd Meng Li        2022-08-17  240  		} else {
14eb1c96e3a3fd Meng Li        2022-08-17  241  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
14eb1c96e3a3fd Meng Li        2022-08-17  242  			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
60dd283804479c Swapnil Sapkal 2023-08-18  243  			goto skip_test;
14eb1c96e3a3fd Meng Li        2022-08-17  244  		}
60dd283804479c Swapnil Sapkal 2023-08-18  245  		cpufreq_cpu_put(policy);
14eb1c96e3a3fd Meng Li        2022-08-17  246  	}
14eb1c96e3a3fd Meng Li        2022-08-17  247  
14eb1c96e3a3fd Meng Li        2022-08-17  248  	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
60dd283804479c Swapnil Sapkal 2023-08-18  249  	return;
60dd283804479c Swapnil Sapkal 2023-08-18  250  skip_test:
60dd283804479c Swapnil Sapkal 2023-08-18  251  	cpufreq_cpu_put(policy);
14eb1c96e3a3fd Meng Li        2022-08-17  252  }
14eb1c96e3a3fd Meng Li        2022-08-17  253  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

