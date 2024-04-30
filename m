Return-Path: <linux-kernel+bounces-163245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847ED8B6799
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FEE1C20E10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C8C20EB;
	Tue, 30 Apr 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAF/HbZh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C71113
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441324; cv=none; b=eJ33rpOGX8D14jNLUmePaIjTAhXNRu1uf8VKfyigUleyd4F0kWYiIvXvJNE1P9NR/9u+CS5SGvQSVGJvPpqBW2FHYo/py4kXQi4UPS0qgWElddpmv3ynAYuN18z3iAjn1Zkyd/BqSwKitwB6BLPs+y9tQCVYazT3sHL9BQJflQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441324; c=relaxed/simple;
	bh=5XoiHpSMYh2/uBEkMR7qjxCtCALdCO7yqmhoIHn7TC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k9jUdh4QlvxicAe2LgrGR+xYPRI31GbseGMu0tt9DpE0AGqOhwg0U1phbk7hgyXcdSm+KMjiEyL1KR4V1mkHVaSD/t/Q50xAlMQWWfqDgKIC5eHzK+w264ZXQ7YJc/+tjjX+nRRioxPo8KbD5UIZZ2gDiP9ZuFhlnsmTpKwR+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAF/HbZh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714441323; x=1745977323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5XoiHpSMYh2/uBEkMR7qjxCtCALdCO7yqmhoIHn7TC4=;
  b=nAF/HbZhGkTvUW4JE/L0qK8rZvkQjUfeo+Sf/Bd6tKrUklN9NW6q86/j
   Y2WG+QMQ7DNrF4Z9oUxUOyY5hfL+pAM6vCDCpisLKC3Qx7n1DOSSC6c5o
   K4dxzAdp2DWAqXt6ndDvvaRfHkXp97DGLk/jf13/eNSzcrcLcIP1g4tEF
   Go32+JCy9+u/ZPssoCtAv08fTxAwcd3PaMvGrvOKI2bzgmUIE6H+9Le2H
   xSwFk6s7syUgfHuA8GeMMn1QIbrsnwn8ZBhkKs0gPcKvZ62rwTihcgKOq
   goCMUIvo5AjqzvrRUE/eYdw2bNf9aybQZGm0qj8z72na2J6SyUYFJX2lh
   A==;
X-CSE-ConnectionGUID: frBTXdKxShWEODSY0dh4Kw==
X-CSE-MsgGUID: gsi0PLEWQjG/1/zukOybvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10294638"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10294638"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 18:42:02 -0700
X-CSE-ConnectionGUID: Yfo6QYM4S7Cv/awlpz6EIA==
X-CSE-MsgGUID: Ik8NyoYoSIaCz/+IqPSdwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30749717"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2024 18:42:00 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1cVK-0007bk-11;
	Tue, 30 Apr 2024 01:41:58 +0000
Date: Tue, 30 Apr 2024 09:41:32 +0800
From: kernel test robot <lkp@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Phil Auld <pauld@redhat.com>
Subject: kernel/sched/isolation.c:143 housekeeping_setup() warn: always true
 condition '(first_cpu >= 0) => (0-u32max >= 0)'
Message-ID: <202404300915.WNvfwBz3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98369dccd2f8e16bf4c6621053af7aa4821dcf8e
commit: 257bf89d84121280904800acd25cc2c444c717ae sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU
date:   2 days ago
config: xtensa-randconfig-r081-20240429 (https://download.01.org/0day-ci/archive/20240430/202404300915.WNvfwBz3-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404300915.WNvfwBz3-lkp@intel.com/

New smatch warnings:
kernel/sched/isolation.c:143 housekeeping_setup() warn: always true condition '(first_cpu >= 0) => (0-u32max >= 0)'

Old smatch warnings:
arch/xtensa/include/asm/thread_info.h:97 current_thread_info() warn: inconsistent indenting

vim +143 kernel/sched/isolation.c

   117	
   118	static int __init housekeeping_setup(char *str, unsigned long flags)
   119	{
   120		cpumask_var_t non_housekeeping_mask, housekeeping_staging;
   121		unsigned int first_cpu;
   122		int err = 0;
   123	
   124		if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
   125			if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
   126				pr_warn("Housekeeping: nohz unsupported."
   127					" Build with CONFIG_NO_HZ_FULL\n");
   128				return 0;
   129			}
   130		}
   131	
   132		alloc_bootmem_cpumask_var(&non_housekeeping_mask);
   133		if (cpulist_parse(str, non_housekeeping_mask) < 0) {
   134			pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
   135			goto free_non_housekeeping_mask;
   136		}
   137	
   138		alloc_bootmem_cpumask_var(&housekeeping_staging);
   139		cpumask_andnot(housekeeping_staging,
   140			       cpu_possible_mask, non_housekeeping_mask);
   141	
   142		first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
 > 143		if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
   144			__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
   145			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
   146			if (!housekeeping.flags) {
   147				pr_warn("Housekeeping: must include one present CPU, "
   148					"using boot CPU:%d\n", smp_processor_id());
   149			}
   150		}
   151	
   152		if (cpumask_empty(non_housekeeping_mask))
   153			goto free_housekeeping_staging;
   154	
   155		if (!housekeeping.flags) {
   156			/* First setup call ("nohz_full=" or "isolcpus=") */
   157			enum hk_type type;
   158	
   159			for_each_set_bit(type, &flags, HK_TYPE_MAX)
   160				housekeeping_setup_type(type, housekeeping_staging);
   161		} else {
   162			/* Second setup call ("nohz_full=" after "isolcpus=" or the reverse) */
   163			enum hk_type type;
   164			unsigned long iter_flags = flags & housekeeping.flags;
   165	
   166			for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
   167				if (!cpumask_equal(housekeeping_staging,
   168						   housekeeping.cpumasks[type])) {
   169					pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
   170					goto free_housekeeping_staging;
   171				}
   172			}
   173	
   174			iter_flags = flags & ~housekeeping.flags;
   175	
   176			for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
   177				housekeeping_setup_type(type, housekeeping_staging);
   178		}
   179	
   180		if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK))
   181			tick_nohz_full_setup(non_housekeeping_mask);
   182	
   183		housekeeping.flags |= flags;
   184		err = 1;
   185	
   186	free_housekeeping_staging:
   187		free_bootmem_cpumask_var(housekeeping_staging);
   188	free_non_housekeeping_mask:
   189		free_bootmem_cpumask_var(non_housekeeping_mask);
   190	
   191		return err;
   192	}
   193	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

