Return-Path: <linux-kernel+bounces-124289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA19289151D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B86B22403
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C3E4AEFE;
	Fri, 29 Mar 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRQUdcm0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F94120C;
	Fri, 29 Mar 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700447; cv=none; b=i0XoYp9x/wPlJz0ekG9+77uKLbLDizmcTbSq0mEViLCX6O1In6iOfz7Et/Z8RQAs5Q8BcG1FAESc8/TJsxrudo9TfcMG0rRuikRDNDDHUi1j8U4Uq34mraStpARSLHGymC6fzbG3lsSTBTbs8saJp3uH6gUEkc214kfRkpwRMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700447; c=relaxed/simple;
	bh=euIDv/bMlAG8q7AVNBouQvwowUNC5bhdLSI7uMJKXkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibcQIbeVkpHvKfl5FnPEG3WEqQIUgN9OXrd2CEofGiuxZx96A1Uu5Mb4086ZQgh8KWDyqnwaZwQ7NJaMEUDFWW5VXu9hm53LHhcjlKXQX7XNCGQRVyyxg40dzZ8K4Wpzbjh2Znb9X/24+r2VKAhU0IYE06rk2Uw0cdmYZgUWCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRQUdcm0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711700446; x=1743236446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=euIDv/bMlAG8q7AVNBouQvwowUNC5bhdLSI7uMJKXkY=;
  b=kRQUdcm0QMS41bnnkYwC3P7wUXPmXUwHIUCzh4lnesi+5dZeSyxK7nHf
   Bem4TLD/hVeOzROxcprZB1D/hX7jk+2ur0evLGYF5VOUIFHEvzBVSOCN9
   iLlHcOUdbINQVcg90R7AAK1Z6z1yxwBIUVJW7lK/XRN5X1Dxv4k1+8lpC
   WNlKoCnPDCk6xX/rvU3LOevpEVQvCES7+PTFGHVEYRCkZ3QXkXLnN3hP5
   q2YDn06Px+oJtHHJ4ZGUzjrsJHez7ZxthEMQIOOhkN3mNPjCtOxMBP275
   b0nRJidiewcTyNISa1kEtd9u23a+VGBGDRQQ9UkZZ9TJhoDTvs5dKtbb3
   g==;
X-CSE-ConnectionGUID: fb5AyJCjSg2yvspa9vstEw==
X-CSE-MsgGUID: u9UYH76oSKO/DdI7qOAB+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="10698887"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="10698887"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 01:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="17369022"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Mar 2024 01:20:41 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rq7Tb-0002ze-0G;
	Fri, 29 Mar 2024 08:20:39 +0000
Date: Fri, 29 Mar 2024 16:20:29 +0800
From: kernel test robot <lkp@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lukasz.luba@arm.com,
	dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	m.szyprowski@samsung.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 3/4] PM: EM: Add em_dev_update_chip_binning()
Message-ID: <202403291602.UyrrrpzO-lkp@intel.com>
References: <20240328085112.3873050-4-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328085112.3873050-4-lukasz.luba@arm.com>

Hi Lukasz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on krzk/for-next clk/clk-next linus/master v6.9-rc1 next-20240328]
[cannot apply to soc/for-next rafael-pm/acpi-bus rafael-pm/devprop]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Luba/OPP-OF-Export-dev_opp_pm_calc_power-for-usage-from-EM/20240328-165357
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240328085112.3873050-4-lukasz.luba%40arm.com
patch subject: [PATCH v3 3/4] PM: EM: Add em_dev_update_chip_binning()
config: i386-buildonly-randconfig-002-20240328 (https://download.01.org/0day-ci/archive/20240329/202403291602.UyrrrpzO-lkp@intel.com/config)
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403291602.UyrrrpzO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403291602.UyrrrpzO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/power/energy_model.c:814: warning: bad line:                                 information is present in the OPPs.


vim +814 kernel/power/energy_model.c

   811	
   812	/**
   813	 * em_dev_update_chip_binning() - Update Energy Model after the new voltage
 > 814					information is present in the OPPs.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

