Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA37E76666C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjG1IJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjG1IJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:09:01 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3930DB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690531740; x=1722067740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7H1DGTtPz3o+QAj240HysVc/w83lxlzbiBKVni7/XEY=;
  b=DAgkVRyI5KD5rebYeeKKLGO5DOQuJJBQtRwJ2xK2Zh4KxM8C3dhgTtsZ
   KeNAPUxL8uNlW6CIW/4dk2vtur+LPppwJK8RB1zQKTzQDVEUqaAmnnrdk
   CEeYIQbBvxpsEUWHXbDSeEvFZqROD1+O/Jh3B2jfSnCtAj6nDvn99+4hp
   /uMkqpmSGmhodItUFb3phxx4JhbVO1fiujwQX5Cebit9OXIXlRZ/0VMxZ
   yAcTcaaEI6Z+ohKQKxOwRBsLXClZNJJju2DONbqRYDbnEeJL+HlY8DzO/
   7Vu+MNcnmbJGftmqzDXt5kkAwC+Zzau3QCe4XTlJhvx0Jr718JqeauNPa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372156414"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="372156414"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 01:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="797357757"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="797357757"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2023 01:08:57 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPIWu-000313-2R;
        Fri, 28 Jul 2023 08:08:56 +0000
Date:   Fri, 28 Jul 2023 16:08:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Levi Yun <ppbuk5246@gmail.com>, sj@kernel.org,
        akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Levi Yun <ppbuk5246@gmail.com>
Subject: Re: [PATCH] damon: Use pmdp_get instead of drect dereferencing pmd.
Message-ID: <202307281532.pVsrTsL2-lkp@intel.com>
References: <20230727183745.682880-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727183745.682880-1-ppbuk5246@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.5-rc3 next-20230728]
[cannot apply to sj/damon/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Levi-Yun/damon-Use-pmdp_get-instead-of-drect-dereferencing-pmd/20230728-024044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230727183745.682880-1-ppbuk5246%40gmail.com
patch subject: [PATCH] damon: Use pmdp_get instead of drect dereferencing pmd.
config: i386-randconfig-i016-20230727 (https://download.01.org/0day-ci/archive/20230728/202307281532.pVsrTsL2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281532.pVsrTsL2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307281532.pVsrTsL2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/damon/vaddr.c: In function 'damon_young_pmd_entry':
>> mm/damon/vaddr.c:440:15: warning: unused variable 'pmde' [-Wunused-variable]
     440 |         pmd_t pmde;
         |               ^~~~


vim +/pmde +440 mm/damon/vaddr.c

   434	
   435	static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
   436			unsigned long next, struct mm_walk *walk)
   437	{
   438		pte_t *pte;
   439		pte_t ptent;
 > 440		pmd_t pmde;
   441		spinlock_t *ptl;
   442		struct folio *folio;
   443		struct damon_young_walk_private *priv = walk->private;
   444	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
