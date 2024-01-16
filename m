Return-Path: <linux-kernel+bounces-26923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA4782E7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07F0284373
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329BA4411;
	Tue, 16 Jan 2024 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7cgm7UT"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC810FA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705371464; x=1736907464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bnd+0r4fwqlSyS3EZsPS5rfw18q8XJApJd8vw2m7e2Q=;
  b=l7cgm7UT2Gjla5M6qbsq/s04kmSCmCSPYQs4iKSUgifto/7D+ZXOk2tZ
   9BgxLyOrygRcjWRQycmrN6Sr7c5J39Z1kfIh9dwtuNhprvZUBftFEmtme
   yCc6smIY+UnW5sNzCTTiHVN7rQAvBXpyE0dUrS2RCp/UtYhCofJaEhdXw
   TpMrVhxg4lb3mE5GdMT74v5A8DQqX25li78VgH3KmZ6Hm3k/liLcAUvbi
   LlD/CBfTLuJbVE43NiSIHvtrV5Ko0yid3aB6HQwC+sWhR7MCB5Anc06g+
   GqyS/LYBsR9aR4PJfhSedtb2lKanggoepYe+61IADmbQM3yBHuZ5uYyo+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="399408245"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="399408245"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 18:17:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="776874695"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="776874695"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Jan 2024 18:17:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPZ1C-000Ctu-2B;
	Tue, 16 Jan 2024 02:17:36 +0000
Date: Tue, 16 Jan 2024 10:12:19 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
	akpm@linux-foundation.org, ying.huang@intel.com, namit@vmware.com,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v6 6/7] mm: Defer TLB flush by keeping both src and dst
 folios at migration
Message-ID: <202401160941.4iwBnNkq-lkp@intel.com>
References: <20240115081953.2521-7-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115081953.2521-7-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0dd3ee31125508cd67f7e7172247f05b7fd1753a]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/x86-tlb-Add-APIs-manipulating-tlb-batch-s-arch-data/20240115-162220
base:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
patch link:    https://lore.kernel.org/r/20240115081953.2521-7-byungchul%40sk.com
patch subject: [PATCH v6 6/7] mm: Defer TLB flush by keeping both src and dst folios at migration
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240116/202401160941.4iwBnNkq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401160941.4iwBnNkq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401160941.4iwBnNkq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/loongarch/include/asm/vdso.h:10,
                    from arch/loongarch/include/asm/elf.h:13,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from lib/test_bitops.c:9:
>> include/linux/mm.h:2046:43: error: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +2046 include/linux/mm.h

  2040	
  2041	#if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
  2042	extern void migrc_flush_start(void);
  2043	extern void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch);
  2044	#else
  2045	static inline void migrc_flush_start(void) {}
> 2046	static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
  2047	#endif
  2048	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

