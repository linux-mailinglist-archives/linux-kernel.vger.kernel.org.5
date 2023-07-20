Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC17775BB4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjGTXiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGTXiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:38:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A5530DB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689896257; x=1721432257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2itLRjqr3PQgC+FNJyKgpaYg8xYUggoWHdV0xSSs0k=;
  b=iUHsqZVk9A8FOECcLpMe/6GIf2PbFLDJbhig1sNAOFMWLpYAubOtINn4
   +xjyJWcYYezYsbBsEU+cqqE35L718fw1weL5Ixj+qjGcMrncXqbkFlEQE
   Q/jQKiBY64P8CcsafJeiUiJGltZejAmJBUpajXFSPLIAUeLspMLcpR7XK
   pPJVBDAeor7oPggruLVbKgw0Gl055ZWRJInoCBCn2nZ2ZZa+ivM5tUrZY
   yGLi6qAGy5Y4pZ5YaO++wobFboJoyrGxbVBxdapJZ+smfQKtJGEktyQ/Y
   h5gs6wys0bpKwJqdL9WkO2GWWTZ+4+20+CBrafGiN0W+HwvCvY0/xGJus
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="430687199"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="430687199"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 16:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="971223643"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="971223643"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2023 16:37:12 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMdCp-0006dG-20;
        Thu, 20 Jul 2023 23:37:11 +0000
Date:   Fri, 21 Jul 2023 07:36:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linke Li <lilinke99@foxmail.com>, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        mike.kravetz@oracle.com, muchun.song@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        Linke Li <lilinke99@gmail.com>
Subject: Re: [PATCH v3] hugetlbfs: Fix integer overflow check in
 hugetlbfs_file_mmap()
Message-ID: <202307210737.HUPwpBdW-lkp@intel.com>
References: <tencent_C2D6865561F23A8141BB145149ACC682B408@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C2D6865561F23A8141BB145149ACC682B408@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linke-Li/hugetlbfs-Fix-integer-overflow-check-in-hugetlbfs_file_mmap/20230720-225128
base:   linus/master
patch link:    https://lore.kernel.org/r/tencent_C2D6865561F23A8141BB145149ACC682B408%40qq.com
patch subject: [PATCH v3] hugetlbfs: Fix integer overflow check in hugetlbfs_file_mmap()
config: s390-randconfig-r024-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210737.HUPwpBdW-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210737.HUPwpBdW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307210737.HUPwpBdW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/hugetlbfs/inode.c:157:25: warning: variable 'vma_len' is uninitialized when used here [-Wuninitialized]
     157 |         if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT, &len))
         |                                ^~~~~~~
   include/linux/overflow.h:67:47: note: expanded from macro 'check_add_overflow'
      67 |         __must_check_overflow(__builtin_add_overflow(a, b, d))
         |                                                      ^
   fs/hugetlbfs/inode.c:123:21: note: initialize the variable 'vma_len' to silence this warning
     123 |         loff_t len, vma_len;
         |                            ^
         |                             = 0
   1 warning generated.


vim +/vma_len +157 fs/hugetlbfs/inode.c

   108	
   109	/*
   110	 * Mask used when checking the page offset value passed in via system
   111	 * calls.  This value will be converted to a loff_t which is signed.
   112	 * Therefore, we want to check the upper PAGE_SHIFT + 1 bits of the
   113	 * value.  The extra bit (- 1 in the shift value) is to take the sign
   114	 * bit into account.
   115	 */
   116	#define PGOFF_LOFFT_MAX \
   117		(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
   118	
   119	static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
   120	{
   121		struct inode *inode = file_inode(file);
   122		struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
   123		loff_t len, vma_len;
   124		int ret;
   125		struct hstate *h = hstate_file(file);
   126	
   127		/*
   128		 * vma address alignment (but not the pgoff alignment) has
   129		 * already been checked by prepare_hugepage_range.  If you add
   130		 * any error returns here, do so after setting VM_HUGETLB, so
   131		 * is_vm_hugetlb_page tests below unmap_region go the right
   132		 * way when do_mmap unwinds (may be important on powerpc
   133		 * and ia64).
   134		 */
   135		vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
   136		vma->vm_ops = &hugetlb_vm_ops;
   137	
   138		ret = seal_check_future_write(info->seals, vma);
   139		if (ret)
   140			return ret;
   141	
   142		/*
   143		 * page based offset in vm_pgoff could be sufficiently large to
   144		 * overflow a loff_t when converted to byte offset.  This can
   145		 * only happen on architectures where sizeof(loff_t) ==
   146		 * sizeof(unsigned long).  So, only check in those instances.
   147		 */
   148		if (sizeof(unsigned long) == sizeof(loff_t)) {
   149			if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
   150				return -EINVAL;
   151		}
   152	
   153		/* must be huge page aligned */
   154		if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
   155			return -EINVAL;
   156	
 > 157		if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT, &len))
   158			return -EINVAL;
   159	
   160		inode_lock(inode);
   161		file_accessed(file);
   162	
   163		ret = -ENOMEM;
   164		if (!hugetlb_reserve_pages(inode,
   165					vma->vm_pgoff >> huge_page_order(h),
   166					len >> huge_page_shift(h), vma,
   167					vma->vm_flags))
   168			goto out;
   169	
   170		ret = 0;
   171		if (vma->vm_flags & VM_WRITE && inode->i_size < len)
   172			i_size_write(inode, len);
   173	out:
   174		inode_unlock(inode);
   175	
   176		return ret;
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
