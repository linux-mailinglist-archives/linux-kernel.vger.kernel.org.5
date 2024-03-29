Return-Path: <linux-kernel+bounces-124253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB4689146B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16AE1C22992
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EA34086E;
	Fri, 29 Mar 2024 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyGqzBo4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F740866;
	Fri, 29 Mar 2024 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697927; cv=none; b=qISOp775fgOP9BBlPqmBG1rJvr0TvxNaICkSwfEXdd2DXMuQ1z7YLpq6/g4Dr0D7cPI3W3IHsYGiRXurbi7/TOT7azu3Mo+V863dTQ5QqnCRf3tesEs2ZdrVSrcNIYVb8e150Gm2Qb5dsEhn5qs8B05aF64aSfZt6uv2s6y0OR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697927; c=relaxed/simple;
	bh=OtiL7hYIGDS1cNsv/IDRa43LiaIOTcDvq0KTA6y72sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaD49fRh+ndr2+G6AtZGRrMEJ2/vSxpXK+EnX/B7MuI2IFlUOZ5f4LH+ibboNkU86dpTELUb2yleFtC2JRV5HaxDaOuQrCO/lH9ifuAawFyd8XjHvPnvpSYY52LuB8YVeTw4xgBbuovzykZppLlDesqG3mvUaxhnQGrcAs4lAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyGqzBo4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711697926; x=1743233926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OtiL7hYIGDS1cNsv/IDRa43LiaIOTcDvq0KTA6y72sA=;
  b=eyGqzBo4R9dvGgIgaVEzuCralb+Ma5RM9R7Y/TyET5lC33mm1pAxQyjr
   PXpvYguMyq7USpOmWL/PbqHNQANQp4pqPgHh5MzkjWSVHV4H1RUvX+H/+
   Qp9lSv0B2O9rxClL0FTxO84UcLiXB5IL81zaTAFHoaeH11H+m/eYy6Rlo
   e1XCKDI1OM3+zJ3jSSUMwOpBBLv7eNLREJZooeRiVKZ53L3LXxVM+51QX
   MHHd5iimEjIoeXKMhZlbhoSOlVb3FZ/l+5eRengVCMb4qEHGsSjmIZ9uD
   GeMfZMGNMnm+yq2lFm3+WiO51FOFaGGBk8Aj/cK3JYpDh7YHLPbHWmjCH
   g==;
X-CSE-ConnectionGUID: uAo9vU6hRWWawPkJQozE+Q==
X-CSE-MsgGUID: zSSfN6EEQCOoGJitWggWYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="9837902"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="9837902"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 00:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16962746"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Mar 2024 00:38:40 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rq6ov-0002xC-1I;
	Fri, 29 Mar 2024 07:38:37 +0000
Date: Fri, 29 Mar 2024 15:37:54 +0800
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
Message-ID: <202403291422.SOVYexxO-lkp@intel.com>
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
config: x86_64-randconfig-161-20240328 (https://download.01.org/0day-ci/archive/20240329/202403291422.SOVYexxO-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403291422.SOVYexxO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403291422.SOVYexxO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/common.c:1998:3: error: 'struct pcpu_hot' has no member named 'rcu_preempt_count'; did you mean 'preempt_count'?
    1998 |  .rcu_preempt_count = RCU_PREEMPT_INIT,
         |   ^~~~~~~~~~~~~~~~~
         |   preempt_count
>> arch/x86/kernel/cpu/common.c:1998:23: error: 'RCU_PREEMPT_INIT' undeclared here (not in a function); did you mean 'RCUREF_INIT'?
    1998 |  .rcu_preempt_count = RCU_PREEMPT_INIT,
         |                       ^~~~~~~~~~~~~~~~
         |                       RCUREF_INIT
>> arch/x86/kernel/cpu/common.c:1998:23: warning: excess elements in struct initializer
   arch/x86/kernel/cpu/common.c:1998:23: note: (near initialization for 'pcpu_hot')


vim +1998 arch/x86/kernel/cpu/common.c

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

