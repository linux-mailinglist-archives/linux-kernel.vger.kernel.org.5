Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2182F784F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjHWESB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjHWER7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:17:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87AE56
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692764277; x=1724300277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gde8+Me9mAhkHv6ln8PbeGxW9veh4ia2XPcgBnZZSPw=;
  b=eYfUwVx6gOzSdfstv3V4dtHbAbPiL2MzwG/902bRGLGLA/ovxfovU5wR
   uPK9O3sw/RkYRQsQMWdsO56b8ppz9yrZC/1FqrfojOqUA3l+o94ALbMYE
   3G/Z4bokTMaGKalwMzPWKP3Hz3OfFSoAXbZWz7sShYZeK2C8nD4riv2wL
   dkaTGYj/3IWIIHh+YqxKupylNY09hFyFTOuceo67419w8C2j4lpOiWwe6
   n+hUH/kVj00Uv5YWy98umsg5ZJKP0DoGEUq37gARe44i4pS27PXIPC5o8
   4XZOb5M+rfiVVFq0iLOx4YUoxEb2ZoklN5QDoQTM3/Fc7X5ZswhewsvIt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="372950113"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="372950113"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 21:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="771569513"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="771569513"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2023 21:06:27 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYf8U-0000pY-2O;
        Wed, 23 Aug 2023 04:06:26 +0000
Date:   Wed, 23 Aug 2023 12:05:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, shakeelb@google.com,
        linux-mm@kvack.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 2/2] fork: group allocation of per-cpu counters for mm
 struct
Message-ID: <202308231154.SM8fedb1-lkp@intel.com>
References: <20230822184152.2194558-3-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822184152.2194558-3-mjguzik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on dennis-percpu/for-next]
[also build test ERROR on linus/master v6.5-rc7 next-20230822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/pcpcntr-add-group-allocation-free/20230823-024312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-next
patch link:    https://lore.kernel.org/r/20230822184152.2194558-3-mjguzik%40gmail.com
patch subject: [PATCH v2 2/2] fork: group allocation of per-cpu counters for mm struct
config: arm-randconfig-r005-20230823 (https://download.01.org/0day-ci/archive/20230823/202308231154.SM8fedb1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308231154.SM8fedb1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308231154.SM8fedb1-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/fork.c: In function '__mmdrop':
>> kernel/fork.c:926:9: error: implicit declaration of function 'percpu_counter_destroy_many'; did you mean 'percpu_counter_destroy'? [-Werror=implicit-function-declaration]
     926 |         percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         percpu_counter_destroy
   kernel/fork.c: In function 'mm_init':
>> kernel/fork.c:1299:13: error: implicit declaration of function 'percpu_counter_init_many'; did you mean 'percpu_counter_init'? [-Werror=implicit-function-declaration]
    1299 |         if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT, NR_MM_COUNTERS))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
         |             percpu_counter_init
   cc1: some warnings being treated as errors


vim +926 kernel/fork.c

   904	
   905	/*
   906	 * Called when the last reference to the mm
   907	 * is dropped: either by a lazy thread or by
   908	 * mmput. Free the page directory and the mm.
   909	 */
   910	void __mmdrop(struct mm_struct *mm)
   911	{
   912		BUG_ON(mm == &init_mm);
   913		WARN_ON_ONCE(mm == current->mm);
   914	
   915		/* Ensure no CPUs are using this as their lazy tlb mm */
   916		cleanup_lazy_tlbs(mm);
   917	
   918		WARN_ON_ONCE(mm == current->active_mm);
   919		mm_free_pgd(mm);
   920		destroy_context(mm);
   921		mmu_notifier_subscriptions_destroy(mm);
   922		check_mm(mm);
   923		put_user_ns(mm->user_ns);
   924		mm_pasid_drop(mm);
   925		mm_destroy_cid(mm);
 > 926		percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
   927	
   928		free_mm(mm);
   929	}
   930	EXPORT_SYMBOL_GPL(__mmdrop);
   931	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
