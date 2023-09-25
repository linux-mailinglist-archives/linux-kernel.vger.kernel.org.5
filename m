Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978C87ACDCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjIYCEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:04:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2350BD
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695607471; x=1727143471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5N1MVnoLtn6COPC+Z9AaoRWzoVIYhiBRP33WVklB48=;
  b=hK8oa/SyYBFgEBR4XWTIZGjwz9VDwf1T/PcLemofkv9ozL1WYiqMvT8C
   BMX5rogVNa0skrWLhDrAtHKr9IFgrKkRrDlpUnuxuQiF/gJ+LLyauJ/ST
   TxcPpWBExXzNrS3vkGhMajM7wwdeGIVaZjJVP3hDCJKURkUI0e1TE/epp
   twKHrxU2Gsr3mER6Rft2EMt2z/KgQ8d4/akfGzCt3S+svF+WpAjCEF/qM
   SMdecIa+xMVV4n8rVmwwG72mgWPpWxjvJzT1Jsn+zqS9aaVGIPw8YLI1C
   RCxK3Ex1zgzlpfCEwTJubwOwn2VHhbIWFOCuUsMuP3WpFqeNckWmPs/mX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467433261"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="467433261"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="751499138"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="751499138"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 24 Sep 2023 19:04:14 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkaxI-0000lZ-1W;
        Mon, 25 Sep 2023 02:04:12 +0000
Date:   Mon, 25 Sep 2023 10:04:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     riel@surriel.com, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, leit@meta.com,
        willy@infradead.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with
 invalidate_lock
Message-ID: <202309250923.NEPT0ip2-lkp@intel.com>
References: <20230922190552.3963067-4-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922190552.3963067-4-riel@surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.6-rc3 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/riel-surriel-com/hugetlbfs-extend-hugetlb_vma_lock-to-private-VMAs/20230923-030756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230922190552.3963067-4-riel%40surriel.com
patch subject: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with invalidate_lock
config: x86_64-randconfig-013-20230925 (https://download.01.org/0day-ci/archive/20230925/202309250923.NEPT0ip2-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309250923.NEPT0ip2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309250923.NEPT0ip2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from arch/x86/include/asm/preempt.h:9,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from fs/nfs/write.c:11:
   include/linux/hugetlb.h: In function 'hugetlb_walk':
>> include/linux/hugetlb.h:1285:42: error: dereferencing pointer to incomplete type 'struct hugetlb_vma_lock'
    1285 |   WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
         |                                          ^~
   include/asm-generic/bug.h:111:25: note: in definition of macro 'WARN_ON_ONCE'
     111 |  int __ret_warn_on = !!(condition);   \
         |                         ^~~~~~~~~
   include/linux/hugetlb.h:1285:17: note: in expansion of macro 'lockdep_is_held'
    1285 |   WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
         |                 ^~~~~~~~~~~~~~~


vim +1285 include/linux/hugetlb.h

185d8dcce62020 Rik van Riel 2023-09-22  1265  
9c67a20704e763 Peter Xu     2022-12-16  1266  /*
9c67a20704e763 Peter Xu     2022-12-16  1267   * Safe version of huge_pte_offset() to check the locks.  See comments
9c67a20704e763 Peter Xu     2022-12-16  1268   * above huge_pte_offset().
9c67a20704e763 Peter Xu     2022-12-16  1269   */
9c67a20704e763 Peter Xu     2022-12-16  1270  static inline pte_t *
9c67a20704e763 Peter Xu     2022-12-16  1271  hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
9c67a20704e763 Peter Xu     2022-12-16  1272  {
9c67a20704e763 Peter Xu     2022-12-16  1273  #if defined(CONFIG_HUGETLB_PAGE) && \
9c67a20704e763 Peter Xu     2022-12-16  1274  	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
9c67a20704e763 Peter Xu     2022-12-16  1275  	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
9c67a20704e763 Peter Xu     2022-12-16  1276  
9c67a20704e763 Peter Xu     2022-12-16  1277  	/*
9c67a20704e763 Peter Xu     2022-12-16  1278  	 * If pmd sharing possible, locking needed to safely walk the
9c67a20704e763 Peter Xu     2022-12-16  1279  	 * hugetlb pgtables.  More information can be found at the comment
9c67a20704e763 Peter Xu     2022-12-16  1280  	 * above huge_pte_offset() in the same file.
9c67a20704e763 Peter Xu     2022-12-16  1281  	 *
9c67a20704e763 Peter Xu     2022-12-16  1282  	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
9c67a20704e763 Peter Xu     2022-12-16  1283  	 */
9c67a20704e763 Peter Xu     2022-12-16  1284  	if (__vma_shareable_lock(vma))
9c67a20704e763 Peter Xu     2022-12-16 @1285  		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
9c67a20704e763 Peter Xu     2022-12-16  1286  			     !lockdep_is_held(
9c67a20704e763 Peter Xu     2022-12-16  1287  				 &vma->vm_file->f_mapping->i_mmap_rwsem));
9c67a20704e763 Peter Xu     2022-12-16  1288  #endif
9c67a20704e763 Peter Xu     2022-12-16  1289  	return huge_pte_offset(vma->vm_mm, addr, sz);
9c67a20704e763 Peter Xu     2022-12-16  1290  }
9c67a20704e763 Peter Xu     2022-12-16  1291  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
