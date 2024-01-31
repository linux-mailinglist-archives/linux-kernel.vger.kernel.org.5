Return-Path: <linux-kernel+bounces-45577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258584329E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC50F1F27383
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185F1FB3;
	Wed, 31 Jan 2024 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBZSLHjU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55E4C6D;
	Wed, 31 Jan 2024 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663633; cv=none; b=iVkf6NiI1qdhV1jyTypLl75tkgc3vyji0ngzAkmkDv+TFTCq3NnwSdtxBMrm5vLTxeEorJijhM9qT2r0H3ZIqbVhRhVvrH9Pjbx7qfGmxrdw/oR4vGson9dVFkbtozHcQyk56hT/qTt+Ga3B9mP6oiiGAUhhdWhToM/sbgLxs/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663633; c=relaxed/simple;
	bh=Bcw6YbTIDhbyyqhqVI8IXl8r2xanXbR9oEPkMrg3UDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTVaNOuD+rQOC4oxP3SMgewLsQ0Yx+pgz5k5mSI9uFCSdUsMMuRtQWgAOOeY7IakDlhwm/+o39Gq2m+yvstJPGQnzLKdlv2wqB0IOEJNct/M1RBv0TWWYJSZ3ZvK5mHh3YY7FFlzpWOtqaZxpaPtFjcFZoMcmKWVLUF1FmToPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBZSLHjU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706663631; x=1738199631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bcw6YbTIDhbyyqhqVI8IXl8r2xanXbR9oEPkMrg3UDw=;
  b=XBZSLHjUidtGkELBNWmZXs4ckGT4flr74xou7iA841u7ugqD2Vei03iD
   ZQfRo1Ltb4PoU3nRbIpcTi3TVN5nuSHDLPo8kIcTNLb4HH26JuRWyPnf2
   gLS9XrT6KHizLD7petF0uDTUCqiiCBu31fBlWZMCARM704+k+omUsQ/r7
   EnAZDCMsa5FBPzoMqVafjJj1GaNMCA2f8I8VICK67NlInIc1e/E8bHMzs
   MehaItsHG/kre8gjxMDjujpwncsYrVEBusgP3BWHMZnDofkKSys7FDtx1
   Nuil8EZLO0LcxF+aKSyKBL6u1NWL5l3l2UopCx7whH/oqIE5fRpRxVx1X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3296516"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3296516"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 17:13:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3974464"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 30 Jan 2024 17:13:44 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUzAb-00010E-1P;
	Wed, 31 Jan 2024 01:13:41 +0000
Date: Wed, 31 Jan 2024 09:13:20 +0800
From: kernel test robot <lkp@intel.com>
To: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Saravana Kannan <saravanak@google.com>
Cc: oe-kbuild-all@lists.linux.dev, Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <202401310804.bWt7Vf6o-lkp@intel.com>
References: <20240127004321.1902477-3-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127004321.1902477-3-davidai@google.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on robh/for-next linus/master rafael-pm/acpi-bus v6.8-rc2 next-20240130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Dai/dt-bindings-cpufreq-add-virtual-cpufreq-device/20240127-084645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240127004321.1902477-3-davidai%40google.com
patch subject: [PATCH v5 2/2] cpufreq: add virtual-cpufreq driver
config: x86_64-randconfig-121-20240130 (https://download.01.org/0day-ci/archive/20240131/202401310804.bWt7Vf6o-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401310804.bWt7Vf6o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401310804.bWt7Vf6o-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: topology_set_scale_freq_source
   >>> referenced by virtual-cpufreq.c:115 (drivers/cpufreq/virtual-cpufreq.c:115)
   >>>               drivers/cpufreq/virtual-cpufreq.o:(virt_cpufreq_cpu_init) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: topology_clear_scale_freq_source
   >>> referenced by virtual-cpufreq.c:128 (drivers/cpufreq/virtual-cpufreq.c:128)
   >>>               drivers/cpufreq/virtual-cpufreq.o:(virt_cpufreq_cpu_exit) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: arch_freq_scale
   >>> referenced by virtual-cpufreq.c:38 (drivers/cpufreq/virtual-cpufreq.c:38)
   >>>               drivers/cpufreq/virtual-cpufreq.o:(virt_scale_freq_tick) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

