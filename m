Return-Path: <linux-kernel+bounces-103832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2C087C51B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E65D1F21D28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCF576908;
	Thu, 14 Mar 2024 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3g78vW5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C0768FB;
	Thu, 14 Mar 2024 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455030; cv=none; b=IyK7LRWVYr/ygRAf3+lL7mieEAW8+dCiBU2BuoDDOnKRWDbt4+0YtNXwGoayH8ooNu6SyTj7BtkRJLdhnSQzTqrmiEFCJxdQz+nXgJTZjZqEIqXuDI05StczCNeyeeHabRaTwhOIlZYn+uSV5GBss3UQXcW/zkwhxD4NXswfujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455030; c=relaxed/simple;
	bh=1UvIatx4kpXKXQ8b0xv9aC+YyzrYn0tYZ+udZOWdEus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDBjbOyLo60Y2UOp4kxhv5uf+H0B98DmaBATCDOGDUOO4Mwerf3jLDIAj0JGAO5vWwOSMo6UyWICg653BQXw0y0mjMh62p6pgF2v0Om9VjCUfpjiDiPF1s4c5YVgZgNWhPm9byGD95WvVZX4TCSCH0FXBAFujkYMNzjiYqSg4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3g78vW5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710455029; x=1741991029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1UvIatx4kpXKXQ8b0xv9aC+YyzrYn0tYZ+udZOWdEus=;
  b=H3g78vW5+CsEzJvkBjymxqCfcDxRw7DxrybtWnwcjiN+irwvDTe3K1L/
   vwOcXlfPaI7Ncf4H9cFTo8CccEIm6ibosKMyh3f8nwDOjgCTgu4OEpnKD
   WdIVSV+0XbSCU6GbBW72ULtJ0GWJXSqm31KTLvh1bFqa3N7Php/GhJbZh
   GL+kH8WRg0kVXLStxOnbNgpo1t+/mq9X23NE78Wm+Rx0d/XyAvXRoX9Ru
   Au9QZ7LNBVuO1lh6q5gyRNTBYhRa74irhvzAuhem9rNsSxio2Sziyx1So
   BYpyqL3n5QP89k4dUbAhSkBkNWpuGuk8NAVm/SMmXPaOERLWr5XH4gTuW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5171640"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="5171640"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 15:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="43358107"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Mar 2024 15:23:45 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rktUF-000Dpx-1m;
	Thu, 14 Mar 2024 22:23:43 +0000
Date: Fri, 15 Mar 2024 06:22:48 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 04/11] pinctrl: aw9523: Make use of struct pinfunction
 and PINCTRL_PINFUNCTION()
Message-ID: <202403150648.HPQmT2Ob-lkp@intel.com>
References: <20240313235422.180075-5-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313235422.180075-5-andy.shevchenko@gmail.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next linus/master next-20240314]
[cannot apply to v6.8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-aw9523-Destroy-mutex-on-remove/20240314-075853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20240313235422.180075-5-andy.shevchenko%40gmail.com
patch subject: [PATCH v1 04/11] pinctrl: aw9523: Make use of struct pinfunction and PINCTRL_PINFUNCTION()
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240315/202403150648.HPQmT2Ob-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240315/202403150648.HPQmT2Ob-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403150648.HPQmT2Ob-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-aw9523.c: In function 'aw9523_pmx_get_groups':
>> drivers/pinctrl/pinctrl-aw9523.c:170:36: error: 'const struct pinfunction' has no member named 'ngrpoups'; did you mean 'ngroups'?
     170 |         *ngroups = aw9523_pmx[sel].ngrpoups;
         |                                    ^~~~~~~~
         |                                    ngroups


vim +170 drivers/pinctrl/pinctrl-aw9523.c

   164	
   165	static int aw9523_pmx_get_groups(struct pinctrl_dev *pctl, unsigned int sel,
   166					 const char * const **groups,
   167					 unsigned int * const ngroups)
   168	{
   169		*groups = aw9523_pmx[sel].groups;
 > 170		*ngroups = aw9523_pmx[sel].ngrpoups;
   171		return 0;
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

