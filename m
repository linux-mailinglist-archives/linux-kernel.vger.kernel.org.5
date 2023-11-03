Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12847DFDBC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377816AbjKCB1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377822AbjKCB1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:27:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8EA19D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698974829; x=1730510829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rAVRVGoSW1gaNLa3HGP7wGv0TFn7bvX3kinNnymKM0c=;
  b=ddRkSC9Fd9JIKydA+I7KNQxioV5TuL4u9dNYm8R6maBi1hyqtuLhaV92
   sN5w6OA+bAnQK1+ypGonuzpGaRAx4bSInPnFpd4XxTaeecId/XoVP9ebA
   AYcNv4GENvGBs6Qu9O+iQ51hd8byBsHHZQOOQTO0w7sCRtwqByAWpSeni
   9BHGgFzgbiWUWsYtnK59MfRmO1odw8UmkNLFHl6OeGnW15prtAh3px0wt
   4zBYZzH988HgeMJWQS753y4/fve4vrJz39MzN/gB4LI/bZ8EsnrWAmk7A
   yKfcF9smsOrgUgZ9Wd2hLmIqLnzFhFjGB/wGG5X/TIR30x1D+fQ5WcGOT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="391726698"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="391726698"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 18:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="905180659"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="905180659"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2023 18:27:01 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyixf-00025j-1S;
        Fri, 03 Nov 2023 01:26:59 +0000
Date:   Fri, 3 Nov 2023 09:26:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edward Adam Davis <eadavis@qq.com>, riel@surriel.com
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        eadavis@qq.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
Message-ID: <202311030935.4AHgxdxU-lkp@intel.com>
References: <tencent_164A247533766D667C3D873798968236C409@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_164A247533766D667C3D873798968236C409@qq.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/mm-hugetlb-fix-null-ptr-defer-in-hugetlb_vma_lock_write/20231103-003152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/tencent_164A247533766D667C3D873798968236C409%40qq.com
patch subject: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
config: loongarch-randconfig-002-20231103 (https://download.01.org/0day-ci/archive/20231103/202311030935.4AHgxdxU-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030935.4AHgxdxU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030935.4AHgxdxU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/migrate.h:8,
                    from include/linux/balloon_compaction.h:41,
                    from drivers/virtio/virtio_balloon.c:16:
>> include/linux/hugetlb.h:182:12: warning: 'is_vma_resv_set' used but never defined
     182 | static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag);
         |            ^~~~~~~~~~~~~~~


vim +/is_vma_resv_set +182 include/linux/hugetlb.h

   179	
   180	extern int sysctl_hugetlb_shm_group;
   181	extern struct list_head huge_boot_pages;
 > 182	static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag);
   183	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
