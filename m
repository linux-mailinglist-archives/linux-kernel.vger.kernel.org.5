Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5A793FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjIFPG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjIFPG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:06:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C7E49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694012782; x=1725548782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gw9VPFGulL9SMj3bg/qb7UVUBLhbdyxQTjG8dgwPDs4=;
  b=W/14AjnFVDlx6Pa3iXGLLMcPWd89kfeHRkz6latxXV8riuXskAbbg29q
   YD6FSV8oA/kEX+4fL8upw58DyFIsWVi4laNQdyh9m0RW+v/Owl7bKs+Pm
   wIcIPKC00rP3gDP8BzFFO2O74UHntltoG7pkzzS0QiQlEJCoXr7cR87XA
   UAwiMVJefpWq68z7U+SUVE3baZqBburVNA+H5Bt5mz26+PNeI5GIIZfIr
   LQl1g1ZWhWSGSWcrTqJ5rtmYpITahA9fP7oc5ZeAq31vx66t2LaSxs24i
   7KhG7xeW+1yoGoRTM05plqT2GkmebXWMh1I8pfjG7CjvoEEsI5rYlZtQf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="443478255"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="443478255"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:06:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="865171164"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="865171164"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Sep 2023 08:06:15 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdu6f-0000Jb-1I;
        Wed, 06 Sep 2023 15:06:13 +0000
Date:   Wed, 6 Sep 2023 23:05:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Clear invalid tlb when set huge page PTE entry
Message-ID: <202309062224.jKf5JY7H-lkp@intel.com>
References: <20230905044828.1460721-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905044828.1460721-1-maobibo@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bibo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.5 next-20230906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-Clear-invalid-tlb-when-set-huge-page-PTE-entry/20230906-013753
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230905044828.1460721-1-maobibo%40loongson.cn
patch subject: [PATCH] LoongArch: Clear invalid tlb when set huge page PTE entry
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20230906/202309062224.jKf5JY7H-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309062224.jKf5JY7H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309062224.jKf5JY7H-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/loongarch/mm/tlb.c:204:6: error: redefinition of 'set_huge_pte_at'
     204 | void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
         |      ^~~~~~~~~~~~~~~
   In file included from arch/loongarch/mm/tlb.c:9:
   include/linux/hugetlb.h:1175:20: note: previous definition of 'set_huge_pte_at' with type 'void(struct mm_struct *, long unsigned int,  pte_t *, pte_t)'
    1175 | static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
         |                    ^~~~~~~~~~~~~~~
   arch/loongarch/mm/tlb.c: In function 'set_huge_pte_at':
>> arch/loongarch/mm/tlb.c:215:29: error: implicit declaration of function 'huge_pte_none'; did you mean 'huge_pte_lock'? [-Werror=implicit-function-declaration]
     215 |         if (!cpu_has_ptw && huge_pte_none(*ptep))
         |                             ^~~~~~~~~~~~~
         |                             huge_pte_lock
   arch/loongarch/mm/tlb.c: At top level:
   arch/loongarch/mm/tlb.c:281:6: warning: no previous prototype for 'setup_tlb_handler' [-Wmissing-prototypes]
     281 | void setup_tlb_handler(int cpu)
         |      ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/set_huge_pte_at +204 arch/loongarch/mm/tlb.c

   203	
 > 204	void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
   205			pte_t *ptep, pte_t pte)
   206	{
   207		/*
   208		 * If huge pte entry is none, tlb entry with normal page size is filled
   209		 * for machines which does not support hardware page walking.
   210		 *
   211		 * Thread maybe migrates to other CPUs after page fault happends and
   212		 * migrates back again after hugepage pte is set, tlbs with normal page
   213		 * about invalid_pte_table need be flushed
   214		 */
 > 215		if (!cpu_has_ptw && huge_pte_none(*ptep))
   216			flush_tlb_mm(mm);
   217	
   218		set_pte_at(mm, addr, ptep, pte);
   219	}
   220	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
