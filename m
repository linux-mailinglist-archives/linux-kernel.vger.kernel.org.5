Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72215786FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbjHXNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbjHXND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:03:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD4F1BD0;
        Thu, 24 Aug 2023 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692882226; x=1724418226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jHMVu6k8S9w3sW744CRbIo5kUtynAHJhFX02muevFVU=;
  b=fco9wB7K6KX7e5oMDUTOxgW7gnAF8AUAWtPUM4SE2YK7K5D6X5TxqfqB
   d/n2js38ImjtOEeMrhtSAjCwBvm0Cn/yIS6DT79WQuHuPrNGFg1UxnYrK
   UwjXYkr82oRvg/9XJeDP5kLg6pGLkHyG8No/m2DQEutG0akectYzqqDpf
   oao0WKY4qhHJdaneclqTQLAF6r7RMDzFBHNeOSxqzJ6Pu+BlepYchFARN
   Ub5tTRJXW7rfsLinOsKOTPX6E8z3eVI1jzkgX4usq4pnPeaKvt01v+r7f
   QCem6UyDWPAGMXnw+N0nqYNxOKKD9mFy7ZMF6z3Zdo2diEGT8FJdtVyU7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359414863"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359414863"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="807121086"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="807121086"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2023 06:03:41 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZ9zt-0002gS-0G;
        Thu, 24 Aug 2023 13:03:38 +0000
Date:   Thu, 24 Aug 2023 21:03:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] lsm: constify the 'mm' parameter in
 security_vm_enough_memory_mm()
Message-ID: <202308242024.q4KF0YIN-lkp@intel.com>
References: <ZOWtBTKkfcc8sKkY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOWtBTKkfcc8sKkY@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khadija,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on pcmoore-selinux/next pcmoore-audit/next linus/master v6.5-rc7 next-20230824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Khadija-Kamran/lsm-constify-the-mm-parameter-in-security_vm_enough_memory_mm/20230823-145455
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/ZOWtBTKkfcc8sKkY%40gmail.com
patch subject: [PATCH] lsm: constify the 'mm' parameter in security_vm_enough_memory_mm()
config: arc-randconfig-001-20230824 (https://download.01.org/0day-ci/archive/20230824/202308242024.q4KF0YIN-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308242024.q4KF0YIN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308242024.q4KF0YIN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/util.c:928:5: error: conflicting types for '__vm_enough_memory'; have 'int(struct mm_struct *, long int,  int)'
     928 | int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
         |     ^~~~~~~~~~~~~~~~~~
   In file included from mm/util.c:2:
   include/linux/mm.h:3199:12: note: previous declaration of '__vm_enough_memory' with type 'int(const struct mm_struct *, long int,  int)'
    3199 | extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
         |            ^~~~~~~~~~~~~~~~~~


vim +928 mm/util.c

39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  911  
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  912  /*
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  913   * Check that a process has enough memory to allocate a new virtual
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  914   * mapping. 0 means there is enough memory for the allocation to
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  915   * succeed and -ENOMEM implies there is not.
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  916   *
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  917   * We currently support three overcommit policies, which are set via the
ee65728e103bb7 Mike Rapoport   2022-06-27  918   * vm.overcommit_memory sysctl.  See Documentation/mm/overcommit-accounting.rst
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  919   *
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  920   * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  921   * Additional code 2002 Jul 20 by Robert Love.
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  922   *
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  923   * cap_sys_admin is 1 if the process has admin privileges, 0 otherwise.
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  924   *
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  925   * Note this is a helper function intended to be used by LSMs which
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  926   * wish to use this logic.
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  927   */
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17 @928  int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  929  {
8c7829b04c523c Johannes Weiner 2019-05-13  930  	long allowed;
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  931  
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  932  	vm_acct_memory(pages);
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  933  
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  934  	/*
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  935  	 * Sometimes we want to use more memory than we have
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  936  	 */
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  937  	if (sysctl_overcommit_memory == OVERCOMMIT_ALWAYS)
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  938  		return 0;
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  939  
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  940  	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
8c7829b04c523c Johannes Weiner 2019-05-13  941  		if (pages > totalram_pages() + total_swap_pages)
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  942  			goto error;
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  943  		return 0;
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  944  	}
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  945  
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  946  	allowed = vm_commit_limit();
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  947  	/*
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  948  	 * Reserve some for root
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  949  	 */
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  950  	if (!cap_sys_admin)
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  951  		allowed -= sysctl_admin_reserve_kbytes >> (PAGE_SHIFT - 10);
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  952  
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  953  	/*
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  954  	 * Don't let a single process grow so big a user can't recover
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  955  	 */
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  956  	if (mm) {
8c7829b04c523c Johannes Weiner 2019-05-13  957  		long reserve = sysctl_user_reserve_kbytes >> (PAGE_SHIFT - 10);
8c7829b04c523c Johannes Weiner 2019-05-13  958  
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  959  		allowed -= min_t(long, mm->total_vm / 32, reserve);
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  960  	}
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  961  
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  962  	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  963  		return 0;
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  964  error:
6bdfc60cf0f977 Jakub Wilk      2023-02-10  965  	pr_warn_ratelimited("%s: pid: %d, comm: %s, not enough memory for the allocation\n",
44b414c8715c5d Kefeng Wang     2022-07-26  966  			    __func__, current->pid, current->comm);
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  967  	vm_unacct_memory(pages);
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  968  
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  969  	return -ENOMEM;
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  970  }
39a1aa8e194ab6 Andrey Ryabinin 2016-03-17  971  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
