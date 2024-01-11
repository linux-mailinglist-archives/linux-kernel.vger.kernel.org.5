Return-Path: <linux-kernel+bounces-23991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C109682B4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706DC1F2267B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424A50249;
	Thu, 11 Jan 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zul+I/cv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC653E06
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704998689; x=1736534689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BLWkV4FwFpaHlahGmNWz/euarj5Ekb2SfjPuJA4VwmQ=;
  b=Zul+I/cv0uj1Jx7QVKGzuL3he30Yx6RXde9S72JXT1fhMBxOapxEL8XG
   6K8ew1kUvWqF4MakKSaaeSEePe+k35Xbcnc8Ff8nXilH/Rz5262Q3D9Ip
   2jq0b3lYqrvUhtMlbtLaQ6VZurkkwtvBnyfcWUmq82tIdyYEs1r4dICur
   8suWbwYOaVELCHQmgsY6xPAxu1nFBI5Fysg3/Z/OhF9VNSA8uP3/hJHR9
   KMvc1hVtcsIcCxsLRV8Gxz0SahLqsgBoOpFv6Wiscow0A9iMWFFtjN/HD
   1FGWwHf2L7ifl0urcgrW4vZR1x/G7yi5S3V/rK+GAzr15gWBQdjkKDprx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6036464"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="6036464"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 10:44:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="906047037"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="906047037"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2024 10:44:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO02Z-0008cU-2C;
	Thu, 11 Jan 2024 18:44:31 +0000
Date: Fri, 12 Jan 2024 02:44:30 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: Re: [v5 6/7] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <202401120213.rCOV7YQI-lkp@intel.com>
References: <20240111060757.13563-7-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111060757.13563-7-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on tip/sched/core tip/x86/core arm64/for-next/core tip/x86/mm linus/master v6.7 next-20240111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/x86-tlb-Add-APIs-manipulating-tlb-batch-s-arch-data/20240111-141049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240111060757.13563-7-byungchul%40sk.com
patch subject: [v5 6/7] mm: Defer TLB flush by keeping both src and dst folios at migration
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20240112/202401120213.rCOV7YQI-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401120213.rCOV7YQI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401120213.rCOV7YQI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: migrc_flush_start
   >>> referenced by tlb.c
   >>>               arch/x86/mm/tlb.o:(arch_tlbbatch_flush) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: migrc_flush_end
   >>> referenced by tlb.c
   >>>               arch/x86/mm/tlb.o:(arch_tlbbatch_flush) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: migrc_flush_free_folios
   >>> referenced by memory.c
   >>>               mm/memory.o:(handle_mm_fault) in archive vmlinux.a
   >>> referenced by page_alloc.c
   >>>               mm/page_alloc.o:(get_page_from_freelist) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

