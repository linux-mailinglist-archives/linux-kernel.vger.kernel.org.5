Return-Path: <linux-kernel+bounces-89227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D386ECF7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D09BB24BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8673D5EE91;
	Fri,  1 Mar 2024 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8JiJ+3F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A91DDFF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336351; cv=none; b=EiWbYu1gte/m0TCFZ3xVrOs5VvnytZQIyquMiRh+0LABuSWK+GZVB088u12rQZH/olyGpGoJqh16MKqA/yksp2uldOTDIaOw0QJz/mGJpSbOtB9+G2XUg/fQICDsVVJnUyWCFz49aot82PT60oFktrfELmgxtjlN8+ATMs26QEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336351; c=relaxed/simple;
	bh=Xpwvyla5lFNXJfYIBFpVAkRNrmDnzHSbXe+jg6R+9Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MaddvwGjeBLt5t2tTRLPqP/ozNRuqB17qVVN8CpylbhU3BVgohPYQD+eC580Un0lqq+M5tEO9npguiCFd7jtQOj/Qq3lFXyWrwr4ZTek0YxXsf2W38Op/FE1/lfmtrsNw+xy+Qe8vEGc/B8Yofm84x9Hg4E02/ITS0ZCRoeqsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8JiJ+3F; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709336350; x=1740872350;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xpwvyla5lFNXJfYIBFpVAkRNrmDnzHSbXe+jg6R+9Dk=;
  b=F8JiJ+3FxpsKSpPzZ1uEnGjbsdHs8U6xsoGBsorYTbHSZobgnPO/qn7B
   99kYMR0nRfU5WhqtzaiENE0YZ6ENn/Wj41GqFEdi1BnVjm2Q7jYxHcLH3
   JRRbGRuvFkugfHADOadqs8ht5Ck+kmt8WZe2QVMeTxau9Ky6op15Qcfcr
   nKro7dGW3h7e0oXfiqm8mVyuTOcnkRIPIo5MpIly1nE+NHQfdN7mqmo+L
   92XAzzexAW0Rlu/eYqdzEYHDWFtN3I0SsSBChqASh7H6nkxBCU0lOoDI6
   IvCuyv8C8oX3ePjClebsZl9EOa5XYMcNJBx0bfq493kCoPsHVZmPcsakB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="26359079"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="26359079"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 15:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="39359054"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 01 Mar 2024 15:39:08 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgCT4-000EB1-0G;
	Fri, 01 Mar 2024 23:39:06 +0000
Date: Sat, 2 Mar 2024 07:38:31 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/x86/kernel/cpu/debugfs.c:11:33: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202403020747.CxX5V2dB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d17468c6f1f49e6259698f6401b8d7a5b90eac68
commit: 48525fd1ea1cfa059a580e77b10ea8790914efa2 x86/cpu: Provide debug interface
date:   5 months ago
config: x86_64-randconfig-121-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020747.CxX5V2dB-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020747.CxX5V2dB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403020747.CxX5V2dB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)


vim +11 arch/x86/kernel/cpu/debugfs.c

     7	
     8	static int cpu_debug_show(struct seq_file *m, void *p)
     9	{
    10		unsigned long cpu = (unsigned long)m->private;
  > 11		struct cpuinfo_x86 *c = per_cpu_ptr(&cpu_info, cpu);
    12	
    13		seq_printf(m, "online:              %d\n", cpu_online(cpu));
    14		if (!c->initialized)
    15			return 0;
    16	
    17		seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
    18		seq_printf(m, "apicid:              %x\n", c->topo.apicid);
    19		seq_printf(m, "pkg_id:              %u\n", c->topo.pkg_id);
    20		seq_printf(m, "die_id:              %u\n", c->topo.die_id);
    21		seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
    22		seq_printf(m, "core_id:             %u\n", c->topo.core_id);
    23		seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
    24		seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
    25		seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
    26		seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
    27		seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
    28		seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
    29		seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
    30		return 0;
    31	}
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

