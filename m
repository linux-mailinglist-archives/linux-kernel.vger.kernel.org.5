Return-Path: <linux-kernel+bounces-125097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70049892002
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD3D1F3200F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B8C14A606;
	Fri, 29 Mar 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFyceD+d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1814A4F7;
	Fri, 29 Mar 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723620; cv=none; b=Qf9VgavmVsJQH2fAuzOIbxYAk48GHeU5k9QkHwBQoog+zmresAzfbbCOFNWV7YLtfKelwYVN0s6+j1DNnXFN5sM2mePJ0Azm1s9pn2a05c0M0Flc1qpFmWynE2oTu7JLBGXiyVYtqecJi5nxtK2xPoVxKQlsOi2NAf2LxNXulKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723620; c=relaxed/simple;
	bh=LGMJXyDZTVCuXPUZLYQj+Fw5Q8AJgz3+78O0ba93CKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4++TXEMUBYt9Y73LkkHmdPpKRVI2xwzCarHaNBUUMjPozrBFUN+tMzRqEfAEbRsE+TCGSucOqUZQWMzAAs+WpW1fDfRrVXwqUJNQ5l+6zmFinRi31/YEIWq+UVFIWCC73AI3l3t/HawOyjyR6omIL/xVTWihlrX07f1fnEpX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFyceD+d; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711723618; x=1743259618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGMJXyDZTVCuXPUZLYQj+Fw5Q8AJgz3+78O0ba93CKE=;
  b=GFyceD+deTNXirmfkO8hgTy8hjAyxstAovt/QEBTw7zTqV4FafIT1i6o
   Mn080mVcvEIXnxG1BLEan2bUbj8XAXetOAmqfF1gDLkPIhdzlZpUbGPI0
   xHhjpDDbNowwF75wrqz0tDHaJuVja9msdoi7pM7oQ2uabEe6rogPhTLgm
   fuBd+5sCIHlSqLUfulz3WsUmJB5gomS37BXU2HScGU8spG7gZFjIJ1jQw
   j16Gz/1Qp4ung590nosZpeDSwJr3Rb7eK5f6E2pnqIX7yMz0+OqlhdEJS
   TSh82U81nmsggu6CdPkbhFKGimpmR3l6BZpwxr2gMmObT2PrnkDpkFvQf
   g==;
X-CSE-ConnectionGUID: IdxaVO6RTwaSTeoZY+xXgg==
X-CSE-MsgGUID: 29rkbP8LTTCxDsFY4piyIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="32315449"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="32315449"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 07:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21729837"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Mar 2024 07:46:53 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqDVK-0003HC-1t;
	Fri, 29 Mar 2024 14:46:50 +0000
Date: Fri, 29 Mar 2024 22:46:01 +0800
From: kernel test robot <lkp@intel.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rcu@vger.kernel.org, x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/10] x86/rcu: Add THUNK rcu_read_unlock_special_thunk
Message-ID: <202403292233.1m5tWJY5-lkp@intel.com>
References: <20240328075318.83039-11-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328075318.83039-11-jiangshanlai@gmail.com>

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
patch link:    https://lore.kernel.org/r/20240328075318.83039-11-jiangshanlai%40gmail.com
patch subject: [PATCH 10/10] x86/rcu: Add THUNK rcu_read_unlock_special_thunk
config: i386-alldefconfig (https://download.01.org/0day-ci/archive/20240329/202403292233.1m5tWJY5-lkp@intel.com/config)
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403292233.1m5tWJY5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403292233.1m5tWJY5-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: init/main.o: in function `rest_init':
>> main.c:(.ref.text+0x96): undefined reference to `rcu_read_unlock_special_thunk'
>> ld: main.c:(.ref.text+0x9d): undefined reference to `rcu_read_unlock_special_thunk'
   ld: arch/x86/events/intel/ds.o: in function `intel_pmu_drain_bts_buffer':
>> ds.c:(.text+0x2cd9): undefined reference to `rcu_read_unlock_special_thunk'
   ld: arch/x86/kernel/nmi.o: in function `nmi_handle':
>> nmi.c:(.text+0x2e9): undefined reference to `rcu_read_unlock_special_thunk'
   ld: arch/x86/kernel/alternative.o: in function `__text_poke':
>> alternative.c:(.text+0x531): undefined reference to `rcu_read_unlock_special_thunk'
   ld: arch/x86/mm/init.o:init.c:(.init.text+0xf1): more undefined references to `rcu_read_unlock_special_thunk' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

