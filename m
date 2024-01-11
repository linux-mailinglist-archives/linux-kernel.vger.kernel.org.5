Return-Path: <linux-kernel+bounces-24105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212F682B701
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461501C24225
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4C058225;
	Thu, 11 Jan 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmUrfBFn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5A58106
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705011183; x=1736547183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=77gniDFqbAtVKzXvNwUuWmc8OSijBmmZsRKorTWArWU=;
  b=bmUrfBFnk5JI3nsIRDpwDQOb1BuSlJE7ML62c2kTPRVwoU8IAlIwuqfi
   qFuAothMfW/F8X6Si0zMJVs/kFUO7Y8UBGgL5UNsqoZDiEyO/Ke6kWCRA
   YUde9VZvpcQY87y8/6JvzzKv3SrIcAUKxAaUO+jZOg6QctZIVInU13iMa
   ZujqOx1BNu3bDt0jvo0OvYyX4bF3xN3KkaiMz4P40fcxde1L1x3nWXmH+
   H281LWV1juHoDbW3b34BBc/KN7yKs2BgeqiG/5SVbUY21Ng89t40awBps
   sL8CeeIpO2TCYdeFO4QnRW3kkCbeUiocTiLxO9st0+ODTmaspPQ2qKaed
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="20479402"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="20479402"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 14:13:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029716548"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="1029716548"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jan 2024 14:12:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO3IG-0008mg-1Q;
	Thu, 11 Jan 2024 22:12:56 +0000
Date: Fri, 12 Jan 2024 06:12:40 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
	akpm@linux-foundation.org, ying.huang@intel.com, namit@vmware.com,
	xhao@linux.alibaba.com, mgorman@techsingularity.net,
	hughd@google.com, willy@infradead.org, david@redhat.com,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: Re: [v5 6/7] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <202401120637.ZuSqfagi-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tip/sched/core tip/x86/core arm64/for-next/core tip/x86/mm linus/master v6.7 next-20240111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/x86-tlb-Add-APIs-manipulating-tlb-batch-s-arch-data/20240111-141049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240111060757.13563-7-byungchul%40sk.com
patch subject: [v5 6/7] mm: Defer TLB flush by keeping both src and dst folios at migration
config: x86_64-randconfig-161-20240111 (https://download.01.org/0day-ci/archive/20240112/202401120637.ZuSqfagi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401120637.ZuSqfagi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401120637.ZuSqfagi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/migrate.c:152:6: warning: no previous prototype for 'migrc_flush_start' [-Wmissing-prototypes]
     152 | void migrc_flush_start(void)
         |      ^~~~~~~~~~~~~~~~~
>> mm/migrate.c:161:6: warning: no previous prototype for 'migrc_flush_end' [-Wmissing-prototypes]
     161 | void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch)
         |      ^~~~~~~~~~~~~~~


vim +/migrc_flush_start +152 mm/migrate.c

   151	
 > 152	void migrc_flush_start(void)
   153	{
   154		unsigned long flags;
   155	
   156		spin_lock_irqsave(&migrc_lock, flags);
   157		migrc_flushing++;
   158		spin_unlock_irqrestore(&migrc_lock, flags);
   159	}
   160	
 > 161	void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch)
   162	{
   163		LIST_HEAD(folios);
   164		struct folio *f, *f2;
   165		unsigned long flags;
   166	
   167		spin_lock_irqsave(&migrc_lock, flags);
   168		if (!arch_tlbbatch_done(&migrc_ubc.arch, arch)) {
   169			list_splice_init(&migrc_folios, &folios);
   170			migrc_ubc.flush_required = false;
   171			migrc_ubc.writable = false;
   172		}
   173		migrc_flushing--;
   174		spin_unlock_irqrestore(&migrc_lock, flags);
   175	
   176		list_for_each_entry_safe(f, f2, &folios, lru) {
   177			folio_put_small_nopcp(f);
   178			atomic_dec(&folio_zone(f)->migrc_pending_nr);
   179		}
   180	}
   181	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

