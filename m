Return-Path: <linux-kernel+bounces-80061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ACC862A52
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E50B20D6C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8211C94;
	Sun, 25 Feb 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgekoWYw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7F10A3C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708864053; cv=none; b=f78Pl4xUa2erel2rjcCg0szh41/Xo8olPGF953+SUS3LYtgAp+B8zHoGCbRuRTgeqHDD+YfyZm0X0j3waoW7CGpYs3Yc5TNrCaCMLqd3EHVmrB/0vNaLKWzzM8GSemuotajUrUmkr3W2AiLccZfT78omZVCzEHMLsk+V72KtIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708864053; c=relaxed/simple;
	bh=Ila8XHMHQS98EyyxVLd87jbwGM+TtuluuiUsbSskovY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oyFtdcE7b0FFfOun8CXsgkGfT253pRw4KliQSBZrUznV2r/oGYeiF3zl0TCnHcX/uAwPdnvMvC2uDl0m4uYhvMji3qky+jDuwX9WVmHZfvkQY6oJNnze6p7NhjY9uPx2idBV9QXE0J34DGtUDSc5j3nTQ66FCvyHVXN+5cq9qaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgekoWYw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708864051; x=1740400051;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ila8XHMHQS98EyyxVLd87jbwGM+TtuluuiUsbSskovY=;
  b=RgekoWYwhUIb5Klt1GkUWXBDXlYf8XpCN7YTzXRrwVYWJdUgocs/3lIR
   Cz7q+UYAWLlfTPJ3WlLjXE/WY5P9M3G55fhJxfW71ccWX0OkzoG/Wyd7X
   eRLlBJhHktSi+p1KGpPe6fjZ9BSuuDC0/OUXQ5321oHrRWm4zaqVFRUEx
   DFeiiOmxDlx2gR62r6aC8H6qMYbKqqtUWiPuAKLwqgTRTzjqmR2Vzs26d
   X/KThSMnsr4lBkGoOJF3cRKEIYk1AmMIy8E/1tFSHv5eTDJzenjuxHGvP
   NmyK8XvlESw01bqEfZADppLF0cYUvnHxgP+He51NZD14xBZzuo8lHcBfp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="6936087"
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="6936087"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 04:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="11096253"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 25 Feb 2024 04:27:29 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reDbK-0009WA-06;
	Sun, 25 Feb 2024 12:27:26 +0000
Date: Sun, 25 Feb 2024 20:27:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240223 1/1] mm/mmu_gather.c:23:39:
 warning: comparison of distinct pointer types ('struct mmu_gather_batch *'
 and 'struct mmu_gather_batch_hdr *')
Message-ID: <202402252018.GR2eyulM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240223
head:   b23fc9e6ff31f4ef9e8de5580963cf53579ef0d4
commit: b23fc9e6ff31f4ef9e8de5580963cf53579ef0d4 [1/1] treewide: Address -Wflexible-array-member-not-at-end warnings
config: x86_64-randconfig-161-20240225 (https://download.01.org/0day-ci/archive/20240225/202402252018.GR2eyulM-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240225/202402252018.GR2eyulM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402252018.GR2eyulM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/mmu_gather.c:23:39: warning: comparison of distinct pointer types ('struct mmu_gather_batch *' and 'struct mmu_gather_batch_hdr *') [-Wcompare-distinct-pointer-types]
      23 |         if (tlb->delayed_rmap && tlb->active != &tlb->local)
         |                                  ~~~~~~~~~~~ ^  ~~~~~~~~~~~
   mm/mmu_gather.c:148:13: error: incompatible pointer types assigning to 'struct mmu_gather_batch *' from 'struct mmu_gather_batch_hdr *' [-Werror,-Wincompatible-pointer-types]
     148 |         for (batch = &tlb->local; batch && batch->nr; batch = batch->next)
         |                    ^ ~~~~~~~~~~~
   mm/mmu_gather.c:150:14: error: incompatible pointer types assigning to 'struct mmu_gather_batch *' from 'struct mmu_gather_batch_hdr *' [-Werror,-Wincompatible-pointer-types]
     150 |         tlb->active = &tlb->local;
         |                     ^ ~~~~~~~~~~~
   mm/mmu_gather.c:387:18: error: incompatible pointer types assigning to 'struct mmu_gather_batch *' from 'struct mmu_gather_batch_hdr *' [-Werror,-Wincompatible-pointer-types]
     387 |         tlb->active     = &tlb->local;
         |                         ^ ~~~~~~~~~~~
   1 warning and 3 errors generated.


vim +23 mm/mmu_gather.c

952a31c9e6fa96 Martin Schwidefsky 2018-09-18  17  
196d9d8bb71dea Peter Zijlstra     2018-09-03  18  static bool tlb_next_batch(struct mmu_gather *tlb)
196d9d8bb71dea Peter Zijlstra     2018-09-03  19  {
196d9d8bb71dea Peter Zijlstra     2018-09-03  20  	struct mmu_gather_batch *batch;
196d9d8bb71dea Peter Zijlstra     2018-09-03  21  
c47454823bd4e3 Linus Torvalds     2022-12-06  22  	/* Limit batching if we have delayed rmaps pending */
c47454823bd4e3 Linus Torvalds     2022-12-06 @23  	if (tlb->delayed_rmap && tlb->active != &tlb->local)
5df397dec7c4c0 Linus Torvalds     2022-11-09  24  		return false;
5df397dec7c4c0 Linus Torvalds     2022-11-09  25  
196d9d8bb71dea Peter Zijlstra     2018-09-03  26  	batch = tlb->active;
196d9d8bb71dea Peter Zijlstra     2018-09-03  27  	if (batch->next) {
196d9d8bb71dea Peter Zijlstra     2018-09-03  28  		tlb->active = batch->next;
196d9d8bb71dea Peter Zijlstra     2018-09-03  29  		return true;
196d9d8bb71dea Peter Zijlstra     2018-09-03  30  	}
196d9d8bb71dea Peter Zijlstra     2018-09-03  31  
196d9d8bb71dea Peter Zijlstra     2018-09-03  32  	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
196d9d8bb71dea Peter Zijlstra     2018-09-03  33  		return false;
196d9d8bb71dea Peter Zijlstra     2018-09-03  34  
dcc1be119071f0 Lorenzo Stoakes    2023-03-13  35  	batch = (void *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
196d9d8bb71dea Peter Zijlstra     2018-09-03  36  	if (!batch)
196d9d8bb71dea Peter Zijlstra     2018-09-03  37  		return false;
196d9d8bb71dea Peter Zijlstra     2018-09-03  38  
196d9d8bb71dea Peter Zijlstra     2018-09-03  39  	tlb->batch_count++;
196d9d8bb71dea Peter Zijlstra     2018-09-03  40  	batch->next = NULL;
196d9d8bb71dea Peter Zijlstra     2018-09-03  41  	batch->nr   = 0;
196d9d8bb71dea Peter Zijlstra     2018-09-03  42  	batch->max  = MAX_GATHER_BATCH;
196d9d8bb71dea Peter Zijlstra     2018-09-03  43  
196d9d8bb71dea Peter Zijlstra     2018-09-03  44  	tlb->active->next = batch;
196d9d8bb71dea Peter Zijlstra     2018-09-03  45  	tlb->active = batch;
196d9d8bb71dea Peter Zijlstra     2018-09-03  46  
196d9d8bb71dea Peter Zijlstra     2018-09-03  47  	return true;
196d9d8bb71dea Peter Zijlstra     2018-09-03  48  }
196d9d8bb71dea Peter Zijlstra     2018-09-03  49  

:::::: The code at line 23 was first introduced by commit
:::::: c47454823bd4e3ab34ed3f795afd4479ab938a3f mm: mmu_gather: allow more than one batch of delayed rmaps

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

