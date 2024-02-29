Return-Path: <linux-kernel+bounces-86133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C82E86C021
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF55828335D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE739AD5;
	Thu, 29 Feb 2024 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVuPTr/c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECE3BBE8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709184094; cv=none; b=N1VDyf/AM7VbwzAFXi1Jn8bB6L2YcRjoN64rGWO4wley36+zxIS8HUbDb739uWjWrgh+vt42hF+6FgrcvEi8KkTE+OdiTxZvep6bb7lWR0BC8mg15CjMSdrYFpOxcVudH2jGzg/O4PVn1/uRcRapsFQiQh3yoy2Bdnf1GWHsoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709184094; c=relaxed/simple;
	bh=+OKbZBg8INtp2Ye+Yftr/WMz8Wbb90mWnLDPuYct/UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtss1KTpYzvTBC80h3zftWnueVjAlRAlUAYDuFARLcqzPdP8p0+d+YgK9zP0i5IpaIpGhP3/k5tbq23Q6q0m0AYlRH6/2mdeOIF+2e50VaU1/Lu+LaDk46nMBDIkITmWsS2GsKVNv/4vEFbmWFtTV0MeDafiqrO042ZGSjCicSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVuPTr/c; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709184093; x=1740720093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+OKbZBg8INtp2Ye+Yftr/WMz8Wbb90mWnLDPuYct/UY=;
  b=FVuPTr/cYdiMHpDCKkFYSsq6YOCrTSQ7cwT+MmeEyRl3aDJsMvMCn99b
   7GI4mYj2wo5h4thU1pAck+wa6bs9zp7xearsMhOfrR/VHp1RWJgFxFCNf
   m6/8DMqaqVhIFjrQzro+xrez1hoYxm6jP0TcBrzgInP3GC+TWDpU8Dd6n
   vNbgpoQLeF5MB4Lyu470+iId/UXgBiuDEYnjTLRecIZmeDk0tt+Y6OsJ8
   6r+iSDOfIrfs3vIpdc/ecLPFIUlapSbGYe/dbGzS7rXIRSgl9uetj9OSz
   k7xq2TgATsQL00IBNRafh0XKfwbx7O013wUjfk4PsygI5gxjSwwsVeSng
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="26097756"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="26097756"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 21:21:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7735235"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 28 Feb 2024 21:21:26 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfYrD-000CfY-1k;
	Thu, 29 Feb 2024 05:21:23 +0000
Date: Thu, 29 Feb 2024 13:17:36 +0800
From: kernel test robot <lkp@intel.com>
To: peterx@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Yang Shi <shy828301@gmail.com>, Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	peterx@redhat.com
Subject: Re: [PATCH 5/5] mm/treewide: Drop pXd_large()
Message-ID: <202402291233.CVhChP2c-lkp@intel.com>
References: <20240228085350.520953-6-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228085350.520953-6-peterx@redhat.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/peterx-redhat-com/mm-ppc-Define-pXd_large-with-pXd_leaf/20240228-170049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240228085350.520953-6-peterx%40redhat.com
patch subject: [PATCH 5/5] mm/treewide: Drop pXd_large()
config: i386-buildonly-randconfig-001-20240228 (https://download.01.org/0day-ci/archive/20240229/202402291233.CVhChP2c-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240229/202402291233.CVhChP2c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402291233.CVhChP2c-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:13:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/x86/include/asm/uaccess.h:17:
   In file included from arch/x86/include/asm/tlbflush.h:16:
>> arch/x86/include/asm/pgtable.h:1099:19: error: redefinition of 'pud_leaf'
    1099 | static inline int pud_leaf(pud_t pud)
         |                   ^
   include/asm-generic/pgtable-nopmd.h:34:19: note: previous definition is here
      34 | static inline int pud_leaf(pud_t pud)           { return 0; }
         |                   ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:116: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=298844285
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1191: prepare0] Error 2 shuffle=298844285
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2 shuffle=298844285
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2 shuffle=298844285
   make: Target 'prepare' not remade because of errors.


vim +/pud_leaf +1099 arch/x86/include/asm/pgtable.h

  1093	
  1094	static inline int pud_bad(pud_t pud)
  1095	{
  1096		return (pud_flags(pud) & ~(_KERNPG_TABLE | _PAGE_USER)) != 0;
  1097	}
  1098	#else
> 1099	static inline int pud_leaf(pud_t pud)
  1100	{
  1101		return 0;
  1102	}
  1103	#endif	/* CONFIG_PGTABLE_LEVELS > 2 */
  1104	#define pud_leaf pud_leaf
  1105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

