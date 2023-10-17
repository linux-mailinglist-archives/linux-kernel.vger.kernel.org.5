Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D90F7CBC53
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjJQHe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQHe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:34:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4CA93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697528066; x=1729064066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e/PVemFSRf7jQJqLRTWI6D7+mX3GaDafbHIm6KGFToo=;
  b=Lp/H8tvOsCwaMre6QY9FY34naoWtPslMCo38PK7tCgahILBLBRHcvWRJ
   JbRBqIy4ot9KYK3Z4sKc3qQJDU50HEglLUZtLyCwA7lAdHcYlm944PVoz
   GqdPf9/4otnXRDSe2wy9fnSDJ/cLAPjrJBVh0M+V9wFU5W5GnwxD5tWIp
   pJ3Wx1pAJhn1WDfCCADvaIm6jz6jPsUjN0H2BW2FyACqeLAjgEhxpAi8Z
   N3lgy5B9WDytDkK5VRRfQ/AJW8x+3u6szhbmiPjIt1aH5LUHIuc41RRZ6
   7PyTM6Fp8Bp8orfNmvRRD5Yem1AjroO/yUJgmdgpq4I2PXjfX9W4ULDVg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="471940490"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="471940490"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 00:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087401273"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1087401273"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2023 00:34:21 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qseao-0009GF-0B;
        Tue, 17 Oct 2023 07:34:18 +0000
Date:   Tue, 17 Oct 2023 15:33:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, david@redhat.com, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH -next v2 17/19] mm: convert wp_page_reuse() and
 finish_mkwrite_fault() to take a folio
Message-ID: <202310171537.XhmrkImn-lkp@intel.com>
References: <20231013085603.1227349-18-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013085603.1227349-18-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm_types-add-virtual-and-_last_cpupid-into-struct-folio/20231017-121040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231013085603.1227349-18-wangkefeng.wang%40huawei.com
patch subject: [PATCH -next v2 17/19] mm: convert wp_page_reuse() and finish_mkwrite_fault() to take a folio
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310171537.XhmrkImn-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171537.XhmrkImn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310171537.XhmrkImn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memory.c:3276: warning: Function parameter or member 'folio' not described in 'finish_mkwrite_fault'


vim +3276 mm/memory.c

2f38ab2c3c7fef Shachar Raindel 2015-04-14  3258  
66a6197c118540 Jan Kara        2016-12-14  3259  /**
66a6197c118540 Jan Kara        2016-12-14  3260   * finish_mkwrite_fault - finish page fault for a shared mapping, making PTE
66a6197c118540 Jan Kara        2016-12-14  3261   *			  writeable once the page is prepared
66a6197c118540 Jan Kara        2016-12-14  3262   *
66a6197c118540 Jan Kara        2016-12-14  3263   * @vmf: structure describing the fault
66a6197c118540 Jan Kara        2016-12-14  3264   *
66a6197c118540 Jan Kara        2016-12-14  3265   * This function handles all that is needed to finish a write page fault in a
66a6197c118540 Jan Kara        2016-12-14  3266   * shared mapping due to PTE being read-only once the mapped page is prepared.
a862f68a8b3600 Mike Rapoport   2019-03-05  3267   * It handles locking of PTE and modifying it.
66a6197c118540 Jan Kara        2016-12-14  3268   *
66a6197c118540 Jan Kara        2016-12-14  3269   * The function expects the page to be locked or other protection against
66a6197c118540 Jan Kara        2016-12-14  3270   * concurrent faults / writeback (such as DAX radix tree locks).
a862f68a8b3600 Mike Rapoport   2019-03-05  3271   *
2797e79f1a491f Liu Xiang       2021-06-28  3272   * Return: %0 on success, %VM_FAULT_NOPAGE when PTE got changed before
a862f68a8b3600 Mike Rapoport   2019-03-05  3273   * we acquired PTE lock.
66a6197c118540 Jan Kara        2016-12-14  3274   */
60fe935fc6b035 Kefeng Wang     2023-10-13  3275  static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf, struct folio *folio)
66a6197c118540 Jan Kara        2016-12-14 @3276  {
66a6197c118540 Jan Kara        2016-12-14  3277  	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
66a6197c118540 Jan Kara        2016-12-14  3278  	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
66a6197c118540 Jan Kara        2016-12-14  3279  				       &vmf->ptl);
3db82b9374ca92 Hugh Dickins    2023-06-08  3280  	if (!vmf->pte)
3db82b9374ca92 Hugh Dickins    2023-06-08  3281  		return VM_FAULT_NOPAGE;
66a6197c118540 Jan Kara        2016-12-14  3282  	/*
66a6197c118540 Jan Kara        2016-12-14  3283  	 * We might have raced with another page fault while we released the
66a6197c118540 Jan Kara        2016-12-14  3284  	 * pte_offset_map_lock.
66a6197c118540 Jan Kara        2016-12-14  3285  	 */
c33c794828f212 Ryan Roberts    2023-06-12  3286  	if (!pte_same(ptep_get(vmf->pte), vmf->orig_pte)) {
7df676974359f9 Bibo Mao        2020-05-27  3287  		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
66a6197c118540 Jan Kara        2016-12-14  3288  		pte_unmap_unlock(vmf->pte, vmf->ptl);
a19e25536ed3a2 Jan Kara        2016-12-14  3289  		return VM_FAULT_NOPAGE;
66a6197c118540 Jan Kara        2016-12-14  3290  	}
60fe935fc6b035 Kefeng Wang     2023-10-13  3291  	wp_page_reuse(vmf, folio);
a19e25536ed3a2 Jan Kara        2016-12-14  3292  	return 0;
66a6197c118540 Jan Kara        2016-12-14  3293  }
66a6197c118540 Jan Kara        2016-12-14  3294  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
