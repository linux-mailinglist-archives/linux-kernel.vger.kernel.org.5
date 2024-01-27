Return-Path: <linux-kernel+bounces-41361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E0683EFA3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B882841DB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF82E419;
	Sat, 27 Jan 2024 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFeFLkg2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3629029CEE;
	Sat, 27 Jan 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706382150; cv=none; b=noeNkD5JL4pmUGJOfapF+lZEt0an0pgWV2AZ/uareO0yyjOIItaFC1hxx5TJyPPqu0lOITWpDoDzOXJyg24bt8AubXf7QhtmH18PJSOhLcSt5BWv3M4dQXxvLgb1x3hZMzHkmQDoCHmhPYdINEYaF1mFATzJpl3jP5494c1kIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706382150; c=relaxed/simple;
	bh=bVSkgtWaDc4HiE/gfuQmggubh0l2IydsPMAF0Xm/Z0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEdqBNlgpAyPoH8AJcodqOKBpjuTxredwq769n6YJ1WVkhCD0WdvaJwUFEqy/IEn1/hkS3S5WDbMk8XKOZQ+j5zj5m1Va9BhvyAN9eAVsznfOdoXabcEfqljiP0CzDVVEvXxm6GsfFXZWlynJmCJrAMAxlK9KHNW981ou7L+SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFeFLkg2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706382148; x=1737918148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bVSkgtWaDc4HiE/gfuQmggubh0l2IydsPMAF0Xm/Z0E=;
  b=PFeFLkg2iHTLiu/s7b0pNn7I1fZCBlc4hm+0xZ6mWsixyBzdS1z735dQ
   Uh5SUD951Qnq4K6SZfX/UtQ+78ws1k5CsNYDvXybG/iL6i2Zv9Ug+AojB
   px2xopVDTr3Am0Nqc4gKoebIw/0lktvmUfSAZjbSQgP7DZbjrPY3z9kIS
   Inus0aq+bcf4T+onifkcWQPf/UcsiwFFFbwrtrFN9uZ7UYa8z4LrjxCCL
   OzWD1t2q0uhBUvE4qK23398tOEDrq/6OVg41vDd4AZbihTGTJmqGEmC4O
   UKW/rlZ9I1dXfMOXfb2BLCOBQtsaHZ77gxeyXoo8jsz1LbKij2eylLT6n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="16230663"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16230663"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 11:02:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="857712413"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="857712413"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2024 11:01:55 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTnw9-0002dy-1Q;
	Sat, 27 Jan 2024 19:01:53 +0000
Date: Sun, 28 Jan 2024 03:01:06 +0800
From: kernel test robot <lkp@intel.com>
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
	Mario.Limonciello@amd.com, viresh.kumar@linaro.org,
	Ray.Huang@amd.com, gautham.shenoy@amd.com, Borislav.Petkov@amd.com
Cc: oe-kbuild-all@lists.linux.dev, Alexander.Deucher@amd.com,
	Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] cpufreq: amd-pstate: initialize new core precision
 boost state
Message-ID: <202401280215.WvGTuIEq-lkp@intel.com>
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
[also build test ERROR on v6.8-rc1 next-20240125]
[cannot apply to rafael-pm/linux-next linus/master rafael-pm/devprop]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Perry-Yuan/cpufreq-amd-pstate-remove-set_boost-callback-for-passive-mode/20240126-171412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-bus
patch link:    https://lore.kernel.org/r/0409d40c500eeb8d4d84ecb028b73f2eee147822.1706255676.git.perry.yuan%40amd.com
patch subject: [PATCH 2/7] cpufreq: amd-pstate: initialize new core precision boost state
config: i386-randconfig-141-20240127 (https://download.01.org/0day-ci/archive/20240128/202401280215.WvGTuIEq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401280215.WvGTuIEq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401280215.WvGTuIEq-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cpufreq/amd-pstate-ut.c: In function 'amd_pstate_ut_check_freq':
>> drivers/cpufreq/amd-pstate-ut.c:229:28: error: 'struct amd_cpudata' has no member named 'boost_supported'
     229 |                 if (cpudata->boost_supported) {
         |                            ^~
   In file included from drivers/cpufreq/amd-pstate-ut.c:29:
   include/linux/amd-pstate.h: At top level:
   include/linux/amd-pstate.h:104:27: warning: 'amd_pstate_mode_string' defined but not used [-Wunused-const-variable=]
     104 | static const char * const amd_pstate_mode_string[] = {
         |                           ^~~~~~~~~~~~~~~~~~~~~~


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

