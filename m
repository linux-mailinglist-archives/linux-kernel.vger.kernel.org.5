Return-Path: <linux-kernel+bounces-41913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D643383F988
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E9C1C20D61
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAC1321B0;
	Sun, 28 Jan 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjPPy9uC"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530831A82;
	Sun, 28 Jan 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471029; cv=none; b=CbvaDEnEGPPeimbVoeIrFlgg4ShVpQ5JIONG8GXUFdCXruMj/mEdmdCFodMYINwJCu+fY3z9BMV9rK0wh8au8jc+K0qHnAXx8YGL3IKznz5jZ/jJVcQZOEH9EFSMm+ZQe2hWscVHTUjmfmMIYhEBfGIYrKpuE4CZeuoMjXd85R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471029; c=relaxed/simple;
	bh=gAznsvvIw+2Ntm0oZe02zil1LYT+hELlj3+NPCQBn34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO8cya1PdKJBp7d67Am8ytGuQWwHCojjy5dKZckwASpX7n7xTqFal06sz6OU7UC/2xrnDI/PyoYh3lrgSEa7w0CgxJDBMg3lc6PHqnVQt3CWypMukUNtH1Z+6/ctND7XpHU+KUyoNdxKUNbnq8m/c1Yj3EeIDRWsihiP1CHd5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjPPy9uC; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706471026; x=1738007026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gAznsvvIw+2Ntm0oZe02zil1LYT+hELlj3+NPCQBn34=;
  b=JjPPy9uCOl+vQfJEaG7VmXREGPqssinJipG83fCBU+IvWOAcG8m+kq0R
   JDJD3qZASeeD4hOdqt0C3UygHVT9p0N1nleElcO+58s2nEu3VFkJyaUtS
   K4z2q8qEyi7F5ysFGzMeFNc1ezEpI0A3iLkOVGd7NmPgjOiEvTWGHvNN8
   5xWm1niqJil86H+QDPKevHSO9TsgV+zc0fdN7JT7GAuBH2M5Pybil178k
   KpJr1RBY6CQmOOYilGbnyCIv0KGQvhVXnKnYnj4T02rn51ODRMuoIwtjN
   mRCrCLbrRNjifXk+rKaQs86wEPapZC6gOZZEzJqUJBublcZdL5Rdk2HZG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="393233513"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="393233513"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 11:43:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="930888327"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="930888327"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2024 11:43:38 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUB43-0003hO-31;
	Sun, 28 Jan 2024 19:43:35 +0000
Date: Mon, 29 Jan 2024 03:43:25 +0800
From: kernel test robot <lkp@intel.com>
To: Huang Shijie <shijie@os.amperecomputing.com>,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, patches@amperecomputing.com,
	rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, yury.norov@gmail.com, kuba@kernel.org,
	vschneid@redhat.com, mingo@kernel.org, akpm@linux-foundation.org,
	vbabka@suse.cz, rppt@kernel.org, tglx@linutronix.de,
	jpoimboe@kernel.org, ndesaulniers@google.com,
	mikelley@microsoft.com, mhiramat@kernel.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org
Subject: Re: [PATCH] init: refactor the generic cpu_to_node for NUMA
Message-ID: <202401290316.0eu1Mue2-lkp@intel.com>
References: <20240118031412.3300-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118031412.3300-1-shijie@os.amperecomputing.com>

Hi Huang,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huang-Shijie/init-refactor-the-generic-cpu_to_node-for-NUMA/20240118-111802
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20240118031412.3300-1-shijie%40os.amperecomputing.com
patch subject: [PATCH] init: refactor the generic cpu_to_node for NUMA
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240129/202401290316.0eu1Mue2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401290316.0eu1Mue2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401290316.0eu1Mue2-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `amd_pmu_cpu_prepare':
>> arch/x86/events/amd/core.c:549: undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `amd_alloc_nb':
   arch/x86/events/amd/core.c:507: undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `amd_uncore_ctx_init':
>> arch/x86/events/amd/uncore.c:476: undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `allocate_shared_regs':
>> arch/x86/events/intel/core.c:4520: undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `intel_cpuc_prepare':
   arch/x86/events/intel/core.c:4561: undefined reference to `cpu_to_node'
   ld: vmlinux.o:arch/x86/events/intel/core.c:4538: more undefined references to `cpu_to_node' follow
   ld: vmlinux.o: in function `smp_prepare_cpus_done':
>> init/main.c:1542: undefined reference to `_cpu_to_node'
   ld: vmlinux.o: in function `check_timer':
>> arch/x86/kernel/apic/io_apic.c:2169: undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `kvm_alloc_cpumask':
>> arch/x86/kernel/kvm.c:687: undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `fork_idle':
>> kernel/fork.c:2826: undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `cpus_share_numa':
>> kernel/workqueue.c:6768: undefined reference to `cpu_to_node'
>> ld: kernel/workqueue.c:6768: undefined reference to `cpu_to_node'
   ld: vmlinux.o:kernel/workqueue.c:6748: more undefined references to `cpu_to_node' follow


vim +549 arch/x86/events/amd/core.c

21d59e3e2c403c arch/x86/events/amd/core.c           Sandipan Das    2022-04-21  544  
b38b24ead33417 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-03-23  545  static int amd_pmu_cpu_prepare(int cpu)
b38b24ead33417 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-03-23  546  {
b38b24ead33417 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-03-23  547  	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
b38b24ead33417 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-03-23  548  
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11 @549  	cpuc->lbr_sel = kzalloc_node(sizeof(struct er_account), GFP_KERNEL,
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  550  				     cpu_to_node(cpu));
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  551  	if (!cpuc->lbr_sel)
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  552  		return -ENOMEM;
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  553  
b38b24ead33417 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-03-23  554  	WARN_ON_ONCE(cpuc->amd_nb);
b38b24ead33417 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-03-23  555  
32b62f446827f6 arch/x86/events/amd/core.c           Peter Zijlstra  2016-03-25  556  	if (!x86_pmu.amd_nb_constraints)
95ca792c7582fd arch/x86/events/amd/core.c           Thomas Gleixner 2016-07-13  557  		return 0;
b38b24ead33417 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-03-23  558  
c079c791c5a062 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-11-25  559  	cpuc->amd_nb = amd_alloc_nb(cpu);
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  560  	if (cpuc->amd_nb)
95ca792c7582fd arch/x86/events/amd/core.c           Thomas Gleixner 2016-07-13  561  		return 0;
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  562  
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  563  	kfree(cpuc->lbr_sel);
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  564  	cpuc->lbr_sel = NULL;
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  565  
f4f925dae7419f arch/x86/events/amd/core.c           Sandipan Das    2022-08-11  566  	return -ENOMEM;
b38b24ead33417 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-03-23  567  }
b38b24ead33417 arch/x86/kernel/cpu/perf_event_amd.c Peter Zijlstra  2010-03-23  568  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

