Return-Path: <linux-kernel+bounces-106626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A181687F11E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5569B284424
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C857879;
	Mon, 18 Mar 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0CcR4Sh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F525733F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793699; cv=none; b=BrXkOj/URYi+84YXk+LjCVi1zg/tCfXZwgNvTlfwGYpOPVcZvlFSvGsuEqTNekitkdfbefp0pDL2t+AKLsYaK94kg0EAjq60xu0kZCSsyrS/Vu9P9jT3AfLmPw+SXlLfBltm8XiH4LX+07qC0uLv4trJrqW3MlUu9f4hlgVe6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793699; c=relaxed/simple;
	bh=jrxJE9RgRvLO3n7cWCIWdQ9Ydu8jF/meN9NbonVPOBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ/HICYyZ+fKzsJTGwmUPt2o3y/Ksqn/tINuC9uom20iAk7SpAM9uwyhPKYxq3Azm79AoL207jexi8qZXymjqLuvYYiBClg25I4bp2O9mhlr7oP9ZTWfNXdWEyZP7XMGlB9rappHP3iESrJiHabkvL8HMRg+tS7fwKsEh/U2AMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0CcR4Sh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710793698; x=1742329698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jrxJE9RgRvLO3n7cWCIWdQ9Ydu8jF/meN9NbonVPOBg=;
  b=N0CcR4ShYu9W1mJ1IiEdQpo1rKvCDajd+0Q6weRZ/bPMnw0TpNL0fLTB
   IAZvNSK/HnlDDlzBzMyfRF/Cmr0abPBJd64XybWIgk7gfDky3iOgKAW8v
   +3cfCSO+W5j4f3X+3sGfoy/lGiKcUcHwclf5M22DphfpzY2vRI/wTNTST
   oLzbINDhooIdZBM+QB0WUrk5bBgvrtnwJyS/EmEviIyjkfZAvv21KHgdf
   hSBm+8W1MXhlWowIpTaZaeTbf/c6yNynfG9sAVhBY1xrhxeG1bzVSiEbR
   l69L00gO4HK5Jm1gfnInA0tJkSRMGr93OnD/JJpHmAlifubYiYvp/Fa5s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5813062"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5813062"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 13:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13469429"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 18 Mar 2024 13:28:14 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmJad-000HET-1Y;
	Mon, 18 Mar 2024 20:28:11 +0000
Date: Tue, 19 Mar 2024 04:27:55 +0800
From: kernel test robot <lkp@intel.com>
To: Aravinda Prasad <aravinda.prasad@intel.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, sj@kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, aravinda.prasad@intel.com,
	s2322819@ed.ac.uk, sandeep4.kumar@intel.com, ying.huang@intel.com,
	dave.hansen@intel.com, dan.j.williams@intel.com,
	sreenivas.subramoney@intel.com, antti.kervinen@intel.com,
	alexander.kanevskiy@intel.com
Subject: Re: [PATCH v2 1/3] mm/damon: mm infrastructure support
Message-ID: <202403190418.tsSXHwGu-lkp@intel.com>
References: <20240318132848.82686-2-aravinda.prasad@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318132848.82686-2-aravinda.prasad@intel.com>

Hi Aravinda,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Aravinda-Prasad/mm-damon-mm-infrastructure-support/20240318-212723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240318132848.82686-2-aravinda.prasad%40intel.com
patch subject: [PATCH v2 1/3] mm/damon: mm infrastructure support
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240319/202403190418.tsSXHwGu-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240319/202403190418.tsSXHwGu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403190418.tsSXHwGu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/kup.h:43,
                    from arch/powerpc/include/asm/uaccess.h:8,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:13,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/compat.h:17,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> include/linux/pgtable.h:411:19: error: static declaration of 'pudp_test_and_clear_young' follows non-static declaration
     411 | static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:32,
                    from arch/powerpc/include/asm/mmu.h:391,
                    from arch/powerpc/include/asm/paca.h:18,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/mutex.h:14,
                    from include/linux/rhashtable-types.h:14,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1306:12: note: previous declaration of 'pudp_test_and_clear_young' with type 'int(struct vm_area_struct *, long unsigned int,  pud_t *)'
    1306 | extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:116: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1191: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/pudp_test_and_clear_young +411 include/linux/pgtable.h

   409	
   410	#ifndef pudp_test_and_clear_young
 > 411	static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
   412						    unsigned long address,
   413						    pud_t *pudp)
   414	{
   415		return 0;
   416	}
   417	#endif
   418	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

