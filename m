Return-Path: <linux-kernel+bounces-106462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C287EEEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049BA1C220C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A075644E;
	Mon, 18 Mar 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kts358Mh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C455E67;
	Mon, 18 Mar 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783196; cv=none; b=oXqF5lM1w6B2nJTWBr1FThUV3hH9bGSP6EHmJoM+nlu3r/sdufp4DCbFYsl6s0OPfcuScugR5TuQ9FvYQoFhFs9hXJzUkLD7/BkQReoMtgY3Nm+81ObI7ZUM2Fmyzd3tfQ2wEFinqMXMOEiPzDksnR9K73a66Kt//Q6M1gtxIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783196; c=relaxed/simple;
	bh=1hmrVQaRTbW0zKlfKJKDoA4Vhe70kFEXF9wECjSBBb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoEgLhVhOXogJxrCh9bokuXx52kjNg0/mb02qd7Of1TjOVnvjqF9niiy9HMUnnT9qt0yJ/TdstVP4cEbLS1IbsQgJljJZclDBzWqMvq71I9/x/Mjt9C2FnsqEkMtJwPBYvp3hJTAOWKVDKuw3jS2zIbQoVV8x5tqYNw1zxod3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kts358Mh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710783194; x=1742319194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hmrVQaRTbW0zKlfKJKDoA4Vhe70kFEXF9wECjSBBb8=;
  b=Kts358Mh+MXtpqqwFfiFCEXsd9WHXzr1XBOhfEge+kDRvWVGNyfcHGnm
   +wbInuOCvElY4m/DGNEq+A6xxC2V63X69e4tTCXPgh8QxB5JdRf/WK50/
   mjNIe8o3SFBn72ZZROfutDiI/8UCvew95dUgsY7rIdWy+tKM7k4w37gUg
   V1fsk/Uo2Knfxnum86v/1TVKumNlVEV1OfSRDKwui9YyEpceU+ghbIuZ/
   sZTLYrXLPgJANg+TTpfHGupWC6UasmElGJ6Mmj7wQ/iBMjyPgsUPPqgZy
   GJTgPMWH1zoUpUZxB50vFn3no6GQwz7Gy5LS0mQmPgem214BrT+dhW/xo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5741750"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5741750"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 10:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13501548"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Mar 2024 10:33:09 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmGrC-000H8N-1L;
	Mon, 18 Mar 2024 17:33:06 +0000
Date: Tue, 19 Mar 2024 01:32:34 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Chiu <andy.chiu@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Vincent Chen <vincent.chen@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greentime Hu <greentime.hu@sifive.com>, Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v3 7/7] riscv: vector: adjust minimum Vector requirement
 to ZVE32X
Message-ID: <202403190142.8MfCnioh-lkp@intel.com>
References: <20240318-zve-detection-v3-7-e12d42107fa8@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-zve-detection-v3-7-e12d42107fa8@sifive.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on 099dbac6e90c620d8ce0bbf75bbdc94da1feb4fb]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Chiu/riscv-vector-add-a-comment-when-calling-riscv_setup_vsize/20240318-184348
base:   099dbac6e90c620d8ce0bbf75bbdc94da1feb4fb
patch link:    https://lore.kernel.org/r/20240318-zve-detection-v3-7-e12d42107fa8%40sifive.com
patch subject: [PATCH v3 7/7] riscv: vector: adjust minimum Vector requirement to ZVE32X
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20240319/202403190142.8MfCnioh-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240319/202403190142.8MfCnioh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403190142.8MfCnioh-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/kernel/process.c: In function 'arch_release_task_struct':
>> arch/riscv/kernel/process.c:181:24: error: 'ZVE32X' undeclared (first use in this function)
     181 |         if (has_vector(ZVE32X))
         |                        ^~~~~~
   arch/riscv/kernel/process.c:181:24: note: each undeclared identifier is reported only once for each function it appears in
   arch/riscv/kernel/process.c: In function 'copy_thread':
   arch/riscv/kernel/process.c:228:24: error: 'ZVE32X' undeclared (first use in this function)
     228 |         if (has_vector(ZVE32X))
         |                        ^~~~~~
--
   arch/riscv/kernel/signal.c: In function 'restore_sigcontext':
>> arch/riscv/kernel/signal.c:191:41: error: 'ZVE32X' undeclared (first use in this function)
     191 |                         if (!has_vector(ZVE32X) || !riscv_v_vstate_query(regs) ||
         |                                         ^~~~~~
   arch/riscv/kernel/signal.c:191:41: note: each undeclared identifier is reported only once for each function it appears in
   arch/riscv/kernel/signal.c: In function 'get_rt_frame_size':
   arch/riscv/kernel/signal.c:213:24: error: 'ZVE32X' undeclared (first use in this function)
     213 |         if (has_vector(ZVE32X)) {
         |                        ^~~~~~
   arch/riscv/kernel/signal.c: In function 'setup_sigcontext':
   arch/riscv/kernel/signal.c:286:24: error: 'ZVE32X' undeclared (first use in this function)
     286 |         if (has_vector(ZVE32X) && riscv_v_vstate_query(regs))
         |                        ^~~~~~
--
   arch/riscv/kernel/sys_hwprobe.c: In function 'hwprobe_isa_ext0':
>> arch/riscv/kernel/sys_hwprobe.c:72:24: error: 'v' undeclared (first use in this function)
      72 |         if (has_vector(v))
         |                        ^
   arch/riscv/kernel/sys_hwprobe.c:72:24: note: each undeclared identifier is reported only once for each function it appears in
>> arch/riscv/kernel/sys_hwprobe.c:119:32: error: 'ZVE32X' undeclared (first use in this function)
     119 |                 if (has_vector(ZVE32X)) {
         |                                ^~~~~~
--
   In file included from kernel/sched/core.c:78:
   kernel/sched/core.c: In function 'context_switch':
>> arch/riscv/include/asm/switch_to.h:81:24: error: 'ZVE32X' undeclared (first use in this function)
      81 |         if (has_vector(ZVE32X))                 \
         |                        ^~~~~~
   kernel/sched/core.c:5400:9: note: in expansion of macro 'switch_to'
    5400 |         switch_to(prev, next, prev);
         |         ^~~~~~~~~
   arch/riscv/include/asm/switch_to.h:81:24: note: each undeclared identifier is reported only once for each function it appears in
      81 |         if (has_vector(ZVE32X))                 \
         |                        ^~~~~~
   kernel/sched/core.c:5400:9: note: in expansion of macro 'switch_to'
    5400 |         switch_to(prev, next, prev);
         |         ^~~~~~~~~


vim +/ZVE32X +181 arch/riscv/kernel/process.c

   177	
   178	void arch_release_task_struct(struct task_struct *tsk)
   179	{
   180		/* Free the vector context of datap. */
 > 181		if (has_vector(ZVE32X))
   182			riscv_v_thread_free(tsk);
   183	}
   184	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

