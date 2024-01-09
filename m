Return-Path: <linux-kernel+bounces-21375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55040828E53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B45B22DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499473D574;
	Tue,  9 Jan 2024 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQGWy4iD"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA43D573
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704830493; x=1736366493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZgwhdmubVMTeBH/ez3ZLWVz+MM9fLQkMdpwc1Y5xT4=;
  b=MQGWy4iDKP/VXQ9xT3PXFjSzYKQzcfiX636dZV9D2IysR0Y78G/WUcnR
   zaqPL722DkEIJTpngvBMZZUgOk0XZM9QZ/9OoSCW/A91ynPgTRk11dEKv
   T/6ecdDorJrx3rdueOGrESmOS3GVDoY9YYvMJomwT+AKtt+JprpJLW5eC
   0kDLka5+UtEiKAIki2JOjrhIt8eMlQPA5vEQS2spLoXNHafFw01BLcaVN
   OMUgD+4gKToJ8ebbr54WVSZqCG4qEauPtrfpKOQV6CyYoQ+So9SHWDMg/
   iywAwrWM2NqKVZBYPdGqLC3r7+XYt4BGk/JQvKk/PjGwYoKVImwq7DzFB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429493922"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="429493922"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 12:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="852309014"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="852309014"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2024 12:01:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNIHw-0006Ec-21;
	Tue, 09 Jan 2024 20:01:28 +0000
Date: Wed, 10 Jan 2024 04:00:52 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: arch/x86/include/asm/processor.h:698:16: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202401100305.QgT26dqt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
commit: 6e29032340b60f7aa7475c8234b17273e4424007 x86/cpu: Move cpu_l[l2]c_id into topology info
date:   3 months ago
config: i386-randconfig-062-20240106 (https://download.01.org/0day-ci/archive/20240110/202401100305.QgT26dqt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100305.QgT26dqt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100305.QgT26dqt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/events/amd/uncore.c: note: in included file (through arch/x86/include/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/thread_info.h, ...):
>> arch/x86/include/asm/processor.h:698:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned int * @@
   arch/x86/include/asm/processor.h:698:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/processor.h:698:16: sparse:     got unsigned int *
   arch/x86/events/amd/uncore.c:599:29: sparse: sparse: self-comparison always evaluates to true

vim +698 arch/x86/include/asm/processor.h

   695	
   696	static inline u16 per_cpu_llc_id(unsigned int cpu)
   697	{
 > 698		return per_cpu(cpu_info.topo.llc_id, cpu);
   699	}
   700	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

