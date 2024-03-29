Return-Path: <linux-kernel+bounces-124264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB67891491
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DA41F21C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594364120C;
	Fri, 29 Mar 2024 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dt+GALQx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4A40BEB;
	Fri, 29 Mar 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698530; cv=none; b=C11Z4Mvvawm9fX+GUrNyjTvN/IsRjR2nKDdAPRRyT71j+7z11jC9TkO2378S7EO/PgvhRMw9iyFJTjCvFZ50OwVf7gvGYwWxgOPM/A2eIEtFc9ppjyd5qd11YASdot/OOw/budVrEZRo+8OwWbr51hQQ5uWSsWLZVcQ1jVti8kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698530; c=relaxed/simple;
	bh=K3lfruPLDXAgbRS/3QXJ1ZZTRwjGi8oDJ8bx0xAHDKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGfqrMtoaCIEL2VO9yn+gQhTWyusilrvd+NgBpbZ5Ty8jJfQF1IjxnrsRcWYKydczt2j61dxsuACQunNtmkwqcrEnoNrd9u+jHtv/fLrYcJjIIRRMiBh2oW0gkZU0cNZ/Mg/zwFcR7qhGlumfBF43xGFMizWENXDpVXstKhwOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dt+GALQx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711698527; x=1743234527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K3lfruPLDXAgbRS/3QXJ1ZZTRwjGi8oDJ8bx0xAHDKY=;
  b=dt+GALQxZ24b9Vwdn0lBjl09bhsjJGoNktjBkqY1A8ozFeEHSFYW8Pfw
   fhghEAu/BEsUCq2mpkWBhuLRBAk0mSQLt7K7urADpqJsSHG5ROJvsUc7g
   wUw7WPN0S2o8sQd1Cv8ud0i4pF4PIlmUGwOivyZutwYEhdgH8M3eBjF92
   bV9fgH4R3doTpLPcU0hkMy18tfKLDnAFTKCK2qDPgup027SLutKFPzVfV
   wU/Wmq03sx1CSgMn+R204r/CDKu1YP1nHuQ4vQFQgGFRhNgSY0W5Y2UnD
   pLwBX7AkEZOtqu5lu2KLXG2nfrOjjhvY4J+d8fugkVu5G+avVITzAMaqC
   A==;
X-CSE-ConnectionGUID: xSfZ5697SmS92VqckP2IYw==
X-CSE-MsgGUID: PSG+9ogLQreyheNyFS0RlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24377002"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="24377002"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 00:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="47876495"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Mar 2024 00:48:40 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rq6yb-0002xm-2i;
	Fri, 29 Mar 2024 07:48:37 +0000
Date: Fri, 29 Mar 2024 15:48:11 +0800
From: kernel test robot <lkp@intel.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rcu@vger.kernel.org, x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Nadav Amit <namit@vmware.com>,
	Breno Leitao <leitao@debian.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 09/10] x86/rcu: Add rcu_preempt_count
Message-ID: <202403291537.fHsEhtlq-lkp@intel.com>
References: <20240328075318.83039-10-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328075318.83039-10-jiangshanlai@gmail.com>

Hi Lai,

kernel test robot noticed the following build errors:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on tip/locking/core tip/sched/core tip/x86/asm tip/master linus/master v6.9-rc1 next-20240328]
[cannot apply to tip/x86/core tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lai-Jiangshan/lib-Use-rcu_preempt_depth-to-replace-current-rcu_read_lock_nesting/20240328-155513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20240328075318.83039-10-jiangshanlai%40gmail.com
patch subject: [PATCH 09/10] x86/rcu: Add rcu_preempt_count
config: i386-randconfig-141-20240328 (https://download.01.org/0day-ci/archive/20240329/202403291537.fHsEhtlq-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403291537.fHsEhtlq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403291537.fHsEhtlq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/common.c:1998:23: error: use of undeclared identifier 'RCU_PREEMPT_INIT'
    1998 |         .rcu_preempt_count      = RCU_PREEMPT_INIT,
         |                                   ^
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [y]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +/RCU_PREEMPT_INIT +1998 arch/x86/kernel/cpu/common.c

  1993	
  1994	DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
  1995		.current_task		= &init_task,
  1996		.preempt_count		= INIT_PREEMPT_COUNT,
  1997		.top_of_stack		= TOP_OF_INIT_STACK,
> 1998		.rcu_preempt_count	= RCU_PREEMPT_INIT,
  1999	};
  2000	EXPORT_PER_CPU_SYMBOL(pcpu_hot);
  2001	EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
  2002	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

