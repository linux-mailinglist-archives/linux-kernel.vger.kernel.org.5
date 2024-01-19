Return-Path: <linux-kernel+bounces-31362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 023CD832D31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EC1B24B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8E433A1;
	Fri, 19 Jan 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M36cCNoO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529A1F60B;
	Fri, 19 Jan 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682007; cv=none; b=YlH+9I2JoEoojkDe1Ngvp/6bHG7YHF2MWeLIc60PMPKap9lq71ySkG11r2JfkrWXVbEFUa3IfP4eIcCzR1SNSHH6oJO4l5nGX5S4OLwbcHGBt/gfAscynkIqM3LJDp/ihkW7bqBLNRkQ8SZA2cR46qcE3K+QPx22H1CdxrVePaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682007; c=relaxed/simple;
	bh=4MTHcTMRo8vaC78u9KaJGas7GabALp0/v9oyhzhuUno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maJZwOPNMCz4aHgZwF2GJ2b44Fvv7hv84lJjTpn+NAIFxir3oIDfwr1HoY70mKMbDAGPSiFmoOX1D1DlT6WQqtMYSQFv1xtrPfUj+Q7l1kC+wvIvR2C7K1uqRttm06YYJWCAOI1AVrF44LqnEox6oCeF2Uj0F5ujDF2+h0Yu/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M36cCNoO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705682004; x=1737218004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4MTHcTMRo8vaC78u9KaJGas7GabALp0/v9oyhzhuUno=;
  b=M36cCNoOtzFdGySNm9/zqm8BA5I3Iq7TT1HH49HDR9PqGPoq3mVUJdCN
   Q7ucOIxS184Xxgve+2V1H1hewwXKTC2oU/tH6ATvDGok8wI99LO91jvFK
   g3H9bGKdWE19ydJeHbjVoVTjxUCptG/OWn3e4IXjjqJb0w3yR4olKOq8S
   KQ7eNt+W8v5X9WhfGLltGvtOxyWNvqHdEtTxM03ntMY++NEBPnsmco1Zg
   XPOemhnmIKm+0COUqPVMoMeDKYlvMBhlmyB9BIyvziGxGb58RM5rahmv1
   BRW1F8HglzViCrigcGEztm9yf9/vkLPRApCNxriuqQfoU8YqRsS7LQdUg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="676878"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="676878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 08:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="27082145"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Jan 2024 08:33:09 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQrnm-0004Fy-2T;
	Fri, 19 Jan 2024 16:33:06 +0000
Date: Sat, 20 Jan 2024 00:32:24 +0800
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
Subject: Re: [PATCH] NUMA: Early use of cpu_to_node() returns 0 instead of
 the correct node id
Message-ID: <202401200006.wOMN1YgH-lkp@intel.com>
References: <20240119033227.14113-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119033227.14113-1-shijie@os.amperecomputing.com>

Hi Huang,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus akpm-mm/mm-everything linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huang-Shijie/NUMA-Early-use-of-cpu_to_node-returns-0-instead-of-the-correct-node-id/20240119-113623
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20240119033227.14113-1-shijie%40os.amperecomputing.com
patch subject: [PATCH] NUMA: Early use of cpu_to_node() returns 0 instead of the correct node id
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240120/202401200006.wOMN1YgH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401200006.wOMN1YgH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401200006.wOMN1YgH-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `rapl_cpu_online':
>> rapl.c:(.text+0x75ec): undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `amd_pmu_cpu_prepare':
>> core.c:(.text+0x8580): undefined reference to `cpu_to_node'
>> ld: core.c:(.text+0x85d6): undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `amd_uncore_ctx_init.part.0':
>> uncore.c:(.text+0xc3bd): undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `intel_cpuc_prepare':
>> (.text+0x129ee): undefined reference to `cpu_to_node'
   ld: vmlinux.o:(.text+0x12a71): more undefined references to `cpu_to_node' follow
   ld: vmlinux.o: in function `kernel_init_freeable':
>> main.c:(.init.text+0x1240): undefined reference to `_cpu_to_node'
   ld: vmlinux.o: in function `check_timer':
>> io_apic.c:(.init.text+0x1ec1d): undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `kvm_alloc_cpumask':
>> kvm.c:(.init.text+0x21678): undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `fork_idle':
>> (.init.text+0x28fe2): undefined reference to `cpu_to_node'
   ld: vmlinux.o: in function `cpus_share_numa':
>> workqueue.c:(.init.text+0x2a4c8): undefined reference to `cpu_to_node'
>> ld: workqueue.c:(.init.text+0x2a4d8): undefined reference to `cpu_to_node'
   ld: vmlinux.o:workqueue.c:(.init.text+0x2a7bc): more undefined references to `cpu_to_node' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

