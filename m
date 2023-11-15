Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE07ED608
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbjKOV2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKOV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:28:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880E8F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700083690; x=1731619690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aVQ+ADMhrDZ4kk2S38tTkqmpGbaKt4CUfHleSmAFCiY=;
  b=c3DtsHY04O0pCrXqhESXVsmf0Eqhnqdxow9KV1ebZAogQ2miiPUwjt/O
   L82HXEKgjWaaFNuAPKJk2tiO0aTZH5E+RcGtoG8oKxx/W7MZGwk3hdCQX
   kv0J29+cDEVEUpurK/32b/7kZJu18KDDcGIpiKKtopxEhL5evpzEckXes
   9VJQLBbfliYPNMujgQQ+cMEbPOezMa6qpbgj5KQmYtoGJPN4qgj+uXyWD
   FWnxDS42+A/xY1ZiYsBtiTIomVkFBNJdgROT3/t9BlVNg5EPLInzdw1FN
   31LS+pwSfhE9wRNH6qdBlUsrF/uxGBzqOF0FbVKuhWtuSU/zOFU1YgCVs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="388124671"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="388124671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:28:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="6298239"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Nov 2023 13:28:04 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3NQX-0000ql-1m;
        Wed, 15 Nov 2023 21:28:01 +0000
Date:   Thu, 16 Nov 2023 05:26:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Message-ID: <202311160516.kHhfmjvl-lkp@intel.com>
References: <20231115163018.1303287-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115163018.1303287-2-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.7-rc1 next-20231115]
[cannot apply to arm64/for-next/core efi/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-Batch-copy-PTE-ranges-during-fork/20231116-010123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231115163018.1303287-2-ryan.roberts%40arm.com
patch subject: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
config: arm-randconfig-002-20231116 (https://download.01.org/0day-ci/archive/20231116/202311160516.kHhfmjvl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160516.kHhfmjvl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160516.kHhfmjvl-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/memory.c: In function 'folio_nr_pages_cont_mapped':
>> mm/memory.c:969:16: error: implicit declaration of function 'pte_pgprot'; did you mean 'ptep_get'? [-Werror=implicit-function-declaration]
     969 |         prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
         |                ^~~~~~~~~~
         |                ptep_get
   cc1: some warnings being treated as errors


vim +969 mm/memory.c

   950	
   951	static int folio_nr_pages_cont_mapped(struct folio *folio,
   952					      struct page *page, pte_t *pte,
   953					      unsigned long addr, unsigned long end,
   954					      pte_t ptent, bool *any_dirty)
   955	{
   956		int floops;
   957		int i;
   958		unsigned long pfn;
   959		pgprot_t prot;
   960		struct page *folio_end;
   961	
   962		if (!folio_test_large(folio))
   963			return 1;
   964	
   965		folio_end = &folio->page + folio_nr_pages(folio);
   966		end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
   967		floops = (end - addr) >> PAGE_SHIFT;
   968		pfn = page_to_pfn(page);
 > 969		prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
   970	
   971		*any_dirty = pte_dirty(ptent);
   972	
   973		pfn++;
   974		pte++;
   975	
   976		for (i = 1; i < floops; i++) {
   977			ptent = ptep_get(pte);
   978			ptent = pte_mkold(pte_mkclean(ptent));
   979	
   980			if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
   981			    pgprot_val(pte_pgprot(ptent)) != pgprot_val(prot))
   982				break;
   983	
   984			if (pte_dirty(ptent))
   985				*any_dirty = true;
   986	
   987			pfn++;
   988			pte++;
   989		}
   990	
   991		return i;
   992	}
   993	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
