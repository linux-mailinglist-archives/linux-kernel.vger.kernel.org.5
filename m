Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10A47AC6D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjIXGoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXGoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:44:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2580F107
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695537852; x=1727073852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=86g9FpOzZI6bqzZb1otAqFGoX2mHTdI/u5snVzJyeJo=;
  b=Mty1cwSJTGd/vQlbWOqZMzNuLkJ2MroD+bxLZg07egtZQRXM5lNsXVue
   wjHKCPCE8nM6v1ukzEMLIgjqby268AZppM4PiBlV/igSYVPsN6l0JbAuE
   KjwgtioudNLV0Lyij5fyoHtISYi7fdr8zGKNgkR6Y/TWblYZkT5f1bWSw
   2bEEGjYjSlEufz1hxx3nQxvGL8gsA82HzQvsBSSP29FVP3QoqiUXoHQia
   CCmBd8Q1PtqIO17NKzVcEguB0RZcrsAZxFOWB9oD1d3NtS9l8DMaviksQ
   nYjUI9ui1k4MuBFi1/QGWJISXMQmmvi1uSdnTzQMPeJdklGe1F2xQ+LU+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="445183765"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="445183765"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 23:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="1078848116"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="1078848116"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2023 23:44:08 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkIqc-0003KG-19;
        Sun, 24 Sep 2023 06:44:06 +0000
Date:   Sun, 24 Sep 2023 14:44:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     riel@surriel.com, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, leit@meta.com,
        willy@infradead.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with
 invalidate_lock
Message-ID: <202309241415.pQmcSx8R-lkp@intel.com>
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
[also build test ERROR on linus/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/riel-surriel-com/hugetlbfs-extend-hugetlb_vma_lock-to-private-VMAs/20230923-030756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230922190552.3963067-4-riel%40surriel.com
patch subject: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with invalidate_lock
config: i386-buildonly-randconfig-004-20230924 (https://download.01.org/0day-ci/archive/20230924/202309241415.pQmcSx8R-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309241415.pQmcSx8R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309241415.pQmcSx8R-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/jump_label.h:256,
                    from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/irqflags.h:9,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/audit.h:12,
                    from security/commoncap.c:6:
   include/linux/hugetlb.h: In function 'hugetlb_walk':
>> include/linux/hugetlb.h:1285:56: error: invalid use of undefined type 'struct hugetlb_vma_lock'
    1285 |                 WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
         |                                                        ^~
   include/asm-generic/bug.h:168:32: note: in definition of macro 'WARN_ON'
     168 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/hugetlb.h:1285:17: note: in expansion of macro 'WARN_ON_ONCE'
    1285 |                 WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
         |                 ^~~~~~~~~~~~
   include/linux/hugetlb.h:1285:31: note: in expansion of macro 'lockdep_is_held'
    1285 |                 WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
         |                               ^~~~~~~~~~~~~~~
--
   In file included from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from mm/rmap.c:56:
   include/linux/hugetlb.h: In function 'hugetlb_walk':
>> include/linux/hugetlb.h:1285:56: error: invalid use of undefined type 'struct hugetlb_vma_lock'
    1285 |                 WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
         |                                                        ^~
   include/asm-generic/bug.h:168:32: note: in definition of macro 'WARN_ON'
     168 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/hugetlb.h:1285:17: note: in expansion of macro 'WARN_ON_ONCE'
    1285 |                 WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
         |                 ^~~~~~~~~~~~
   include/linux/hugetlb.h:1285:31: note: in expansion of macro 'lockdep_is_held'
    1285 |                 WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
         |                               ^~~~~~~~~~~~~~~
   In file included from mm/rmap.c:85:
   mm/internal.h: In function 'shrinker_debugfs_name_alloc':
   mm/internal.h:1223:9: warning: function 'shrinker_debugfs_name_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1223 |         shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
         |         ^~~~~~~~


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
