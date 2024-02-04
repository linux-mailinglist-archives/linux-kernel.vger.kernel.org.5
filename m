Return-Path: <linux-kernel+bounces-51803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7436E848F73
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985D91C20FCA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165E23754;
	Sun,  4 Feb 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfsgv0A6"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1597241E0
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707065797; cv=none; b=L9quXVDY8K24yUPDSWA77fLDtDxsOSgIOBt7PAHHp1iEWbq1IOuJ4TR8I1M2dR+/8iM/+9/6M/12ncbsa5PDd36kY/JELCWM6e/NjbqZgGNBAuhCrKQnRPYe4p5Hq/iCEHJvA9MVWGCjd3qM0srK0Juba0NhlVSXrApHiOYGo6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707065797; c=relaxed/simple;
	bh=IZqi9EnH51s+BUaPUQY9mf+Pv3nLCajocI1+s6ntnvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TZF37sj4sUlbgf6WLXCsW1eDFETf9DSG1TZdwDdzVL7xByesXGcvDyvpEOQ4KUB4NtjCZ9FkwwYtAGpdKAu+q2bBPapjvxScBjwPXMIfvs3zd8dSgJYO8u1xxof6Zi8hacbRYKbb/zoFPlyBbDfjAXiZchEmmWJmX98inpWRVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfsgv0A6; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707065794; x=1738601794;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IZqi9EnH51s+BUaPUQY9mf+Pv3nLCajocI1+s6ntnvc=;
  b=kfsgv0A6HPMXZ3wWTlK4czfsr4KST2ncwXIPKM/KlJrIpyFxOTYjweUO
   OUvg4n1zC4TLUXs108jXtkC0Z1bmb3coY2rNeLXCLEy9mVc3tO6PM95rP
   ksWdcD0FFBsiur63Og8eJINVr3OBoVKxEM8BaabCOtGeJlh/+K7JUkZ8S
   mHMgRh/QSPZo5tCw4Q3kzfEg20PPzvCBu88+dyH2sXhIElRdGVcm9h2hk
   RVwUo2a5SCPvujiess/OwtSfsAfZrvwQe5pKno7MLknQ0hkmjQok0u+rA
   gpA5+iw7eKekJj+vFLI415L+F4wA1jo/Wy9usHUHjThndcxdEwRM2Pi0h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="435541655"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="435541655"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 08:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5142422"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Feb 2024 08:56:33 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWfnD-0006YS-0a;
	Sun, 04 Feb 2024 16:56:31 +0000
Date: Mon, 5 Feb 2024 00:56:01 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/powerpc/kernel/entry_64.S:241: Error: operand out of range
 (0xfe10 is not between 0xffffffffffff8000 and 0x7fff)
Message-ID: <202402050021.ZyajE6BS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
commit: 3e8635fb2e072672cbc650989ffedf8300ad67fb powerpc/kasan: Force thread size increase with KASAN
date:   1 year, 8 months ago
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240205/202402050021.ZyajE6BS-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240205/202402050021.ZyajE6BS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402050021.ZyajE6BS-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/entry_64.S: Assembler messages:
>> arch/powerpc/kernel/entry_64.S:241: Error: operand out of range (0xfe10 is not between 0xffffffffffff8000 and 0x7fff)
--
   {standard input}: Assembler messages:
>> {standard input}:7739: Error: operand out of range (0xff90 is not between 0xffffffffffff8000 and 0x7ffc)
   {standard input}:9318: Error: operand out of range (0xff90 is not between 0xffffffffffff8000 and 0x7ffc)
--
   arch/powerpc/kernel/misc_64.S: Assembler messages:
>> arch/powerpc/kernel/misc_64.S:387: Error: operand out of range (0xff90 is not between 0xffffffffffff8000 and 0x7ffc)
--
   arch/powerpc/kvm/book3s_hv_rmhandlers.S: Assembler messages:
>> arch/powerpc/kvm/book3s_hv_rmhandlers.S:2689: Error: operand out of range (0x8310 is not between 0xffffffffffff8001 and 0x8000)


vim +241 arch/powerpc/kernel/entry_64.S

2d27cfd3286966 Benjamin Herrenschmidt 2009-07-23  236  
7306e83ccf5ce3 Christophe Leroy       2019-01-17  237  	clrrdi	r7, r8, THREAD_SHIFT	/* base of new stack */
9994a33865f4d5 Paul Mackerras         2005-10-10  238  	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
9994a33865f4d5 Paul Mackerras         2005-10-10  239  	   because we don't need to leave the 288-byte ABI gap at the
9994a33865f4d5 Paul Mackerras         2005-10-10  240  	   top of the kernel stack. */
9994a33865f4d5 Paul Mackerras         2005-10-10 @241  	addi	r7,r7,THREAD_SIZE-SWITCH_FRAME_SIZE
9994a33865f4d5 Paul Mackerras         2005-10-10  242  
e4c0fc5f72bca1 Nicholas Piggin        2017-06-09  243  	/*
e4c0fc5f72bca1 Nicholas Piggin        2017-06-09  244  	 * PMU interrupts in radix may come in here. They will use r1, not
e4c0fc5f72bca1 Nicholas Piggin        2017-06-09  245  	 * PACAKSAVE, so this stack switch will not cause a problem. They
e4c0fc5f72bca1 Nicholas Piggin        2017-06-09  246  	 * will store to the process stack, which may then be migrated to
e4c0fc5f72bca1 Nicholas Piggin        2017-06-09  247  	 * another CPU. However the rq lock release on this CPU paired with
e4c0fc5f72bca1 Nicholas Piggin        2017-06-09  248  	 * the rq lock acquire on the new CPU before the stack becomes
e4c0fc5f72bca1 Nicholas Piggin        2017-06-09  249  	 * active on the new CPU, will order those stores.
e4c0fc5f72bca1 Nicholas Piggin        2017-06-09  250  	 */
9994a33865f4d5 Paul Mackerras         2005-10-10  251  	mr	r1,r8		/* start using new stack pointer */
9994a33865f4d5 Paul Mackerras         2005-10-10  252  	std	r7,PACAKSAVE(r13)
9994a33865f4d5 Paul Mackerras         2005-10-10  253  
714332858bfd40 Anton Blanchard        2012-09-03  254  	ld	r6,_CCR(r1)
714332858bfd40 Anton Blanchard        2012-09-03  255  	mtcrf	0xFF,r6
714332858bfd40 Anton Blanchard        2012-09-03  256  
9994a33865f4d5 Paul Mackerras         2005-10-10  257  	/* r3-r13 are destroyed -- Cort */
5290ae2b8e5fec Jordan Niethe          2019-12-11  258  	REST_NVGPRS(r1)
9994a33865f4d5 Paul Mackerras         2005-10-10  259  
9994a33865f4d5 Paul Mackerras         2005-10-10  260  	/* convert old thread to its task_struct for return value */
9994a33865f4d5 Paul Mackerras         2005-10-10  261  	addi	r3,r3,-THREAD
9994a33865f4d5 Paul Mackerras         2005-10-10  262  	ld	r7,_NIP(r1)	/* Return to _switch caller in new task */
9994a33865f4d5 Paul Mackerras         2005-10-10  263  	mtlr	r7
9994a33865f4d5 Paul Mackerras         2005-10-10  264  	addi	r1,r1,SWITCH_FRAME_SIZE
9994a33865f4d5 Paul Mackerras         2005-10-10  265  	blr
9994a33865f4d5 Paul Mackerras         2005-10-10  266  

:::::: The code at line 241 was first introduced by commit
:::::: 9994a33865f4d55c44c9731c01e1f891543278de powerpc: Introduce entry_{32,64}.S, misc_{32,64}.S, systbl.S

:::::: TO: Paul Mackerras <paulus@samba.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

