Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373917DFD4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjKBX36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjKBX35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:29:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB5136
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698967791; x=1730503791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DIQS84CVb0x5SQ4e3KNKtovKju7h4sTP0fFvMJcE8i0=;
  b=OD9Qp0NIZyVKnb29Dfb3iAD0xoQl/6tcH5RdI4Hr1hI9Ba8q8omJopOb
   po55YBtMW0gsbklsIce+yYZRqdRuIm1+As7IC5pKXcH3mIkwrEwbtT8Hp
   0xEYPwHxu7Sr9pEeOkYayvUWzg2bOOgbw8TAxfBP2M5ONHgOdzvTskeI0
   2OprQdDdV/Bqx/mUNCl3+2gvYDL+x+coA4f5ZJddlv1k7CbMBZVLnWWHz
   6Kl+CfAV8BMLS5WYKNfA6kLa3xGluZmVcHPA5UFH/QzP/dpTSWDf0263G
   zjeobO2pYmIBFdDVJNY+zGUwWD0UKpQaz9d1JY8pUgeydqnoljUq+Nefn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="10375322"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="10375322"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 16:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1092889542"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1092889542"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2023 16:29:47 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyh8C-00020C-2r;
        Thu, 02 Nov 2023 23:29:44 +0000
Date:   Fri, 3 Nov 2023 07:29:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edward Adam Davis <eadavis@qq.com>, riel@surriel.com
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        eadavis@qq.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
Message-ID: <202311030737.my9iglMI-lkp@intel.com>
References: <tencent_164A247533766D667C3D873798968236C409@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_164A247533766D667C3D873798968236C409@qq.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/mm-hugetlb-fix-null-ptr-defer-in-hugetlb_vma_lock_write/20231103-003152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/tencent_164A247533766D667C3D873798968236C409%40qq.com
patch subject: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
config: um-defconfig (https://download.01.org/0day-ci/archive/20231103/202311030737.my9iglMI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030737.my9iglMI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030737.my9iglMI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:52:
   include/linux/hugetlb.h: In function '__vma_private_lock':
>> include/linux/hugetlb.h:1276:17: error: implicit declaration of function 'is_vma_resv_set' [-Werror=implicit-function-declaration]
    1276 |                 is_vma_resv_set(vma, HPAGE_RESV_OWNER);
         |                 ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/is_vma_resv_set +1276 include/linux/hugetlb.h

  1271	
  1272	#define HPAGE_RESV_OWNER    (1UL << 0)
  1273	static inline bool __vma_private_lock(struct vm_area_struct *vma)
  1274	{
  1275		return (!(vma->vm_flags & VM_MAYSHARE)) && vma->vm_private_data && 
> 1276			is_vma_resv_set(vma, HPAGE_RESV_OWNER);
  1277	}
  1278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
