Return-Path: <linux-kernel+bounces-41862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F7683F8EF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB0B1C21A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628F2E400;
	Sun, 28 Jan 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEb9qVMU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7932D05E;
	Sun, 28 Jan 2024 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706464726; cv=none; b=pPPsJetkvjC0Qznb7e3zHLEuZsTOjK1D2si9nyXClayJ3riKDI9Ah2CgfBmlxz3um+T+n26RFu/zwkHW1u5YJYMIAWMzsvT9izz3Bz3Jsbjw6UxlXA/HfszmHW2gYG/6Y3Nvzp0Z3e6HTjO96IlhbEpQ7SOndvUJD1R9fGCs1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706464726; c=relaxed/simple;
	bh=5cEP+zWFr/nlAcAv00WyKAUSHk9AI618LLTjG1LtvxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2inkDcAc/ai1DezCaAJbXk218TnMR+YoTbcRvKwuV3WHcX6cBuze9OIL74tRqOr4xpCUviIZhkMo1BamSbA9qxDgwudRGQpUelIBkpp1UrGV6m7JJL1y7YES2fkNo7Fjz3NuaFt0OcHzEqHzG0bD/byppUQB/AeO7ZxngIX5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEb9qVMU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706464725; x=1738000725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5cEP+zWFr/nlAcAv00WyKAUSHk9AI618LLTjG1LtvxI=;
  b=BEb9qVMUL2wTPdn0Ini3p++w2SS/mD7iBpID5EXzULckXsOBfDasMPir
   +1gqwgrIgFMWK4asep7mOLXlkVn4ld8nRxTl1OIWC2SN7JkRSiN7KNq+j
   8ABTCOcspHLPjds+mJ5Ch1TVpM4CNaw6k8K5OerTRH7VMEUfmgCvsIjpp
   hdmJQkkywE0BpfB/NTI5PjtHacSMBKiioNUj39BgpHGoGv01uFFfDA+FK
   KbGKE24kTF/ReSgZ5LaJEBgO/iGWHUnpVLsmQlKumYfVfwF5UaqsfiPqm
   kf+VyYU2iZv1B17EoAXU82URpc1Q13rLx5OncYv/PRwZGunveJIZYOqCC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2683755"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2683755"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 09:58:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="737165941"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="737165941"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jan 2024 09:58:35 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU9QP-0003cs-1f;
	Sun, 28 Jan 2024 17:58:33 +0000
Date: Mon, 29 Jan 2024 01:58:09 +0800
From: kernel test robot <lkp@intel.com>
To: Huang Shijie <shijie@os.amperecomputing.com>,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	patches@amperecomputing.com, rafael@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	yury.norov@gmail.com, kuba@kernel.org, vschneid@redhat.com,
	mingo@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
	rppt@kernel.org, tglx@linutronix.de, jpoimboe@kernel.org,
	ndesaulniers@google.com, mikelley@microsoft.com,
	mhiramat@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org
Subject: Re: [PATCH] init: refactor the generic cpu_to_node for NUMA
Message-ID: <202401290116.GpUOCzGd-lkp@intel.com>
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
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240129/202401290116.GpUOCzGd-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401290116.GpUOCzGd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401290116.GpUOCzGd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: cpu_to_node
   >>> referenced by main.c:880 (init/main.c:880)
   >>>               init/main.o:(start_kernel) in archive vmlinux.a
   >>> referenced by main.c:1542 (init/main.c:1542)
   >>>               init/main.o:(kernel_init_freeable) in archive vmlinux.a
   >>> referenced by core.c:550 (arch/x86/events/amd/core.c:550)
   >>>               arch/x86/events/amd/core.o:(amd_pmu_cpu_prepare) in archive vmlinux.a
   >>> referenced 179 more times
--
>> ld.lld: error: undefined symbol: _cpu_to_node
   >>> referenced by main.c:1542 (init/main.c:1542)
   >>>               init/main.o:(kernel_init_freeable) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

