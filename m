Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0D784EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjHWCW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjHWCWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:22:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF1BCF9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692757370; x=1724293370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OD8bw0wTF/Q2WB/5GNSQYtkOlHoA6snsT+zGEzUo0v0=;
  b=LJYADj4Yi3+vUs7AhepTCe/maFtJkaSTxZXzwxcyQbi/h5p282mjKiHv
   L2+tha1NEvUBy5FcCRwZyqjH5UKoGhXg4DAyvHwzeb7YvTYgiNllQn2o8
   b11BDRaHaTCTjsvB+RTeEFhMzZ8hqxJ6lcoD23UdX1LZ5XxNWPqnrAWTz
   vcMXhVhj1kPc4J68N3qgsYbI5chf33VfnbOqXDy7TnEdnYPXhbTQ0Q3hD
   q3kTZB58AlyQDmsq3v5KGb1Jb2QdOFIYlg5CnDAlFrSUi6wg1h1kkftm7
   iICnwaoWBoycqL63qWc1ZPPl7vKEFaxH05fu7m/GEE1+I7IvlqMLWNpzd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="377802013"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="377802013"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880211027"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2023 19:22:51 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYdWA-0000kw-0l;
        Wed, 23 Aug 2023 02:22:46 +0000
Date:   Wed, 23 Aug 2023 10:22:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 2/2] fork: group allocation of per-cpu counters for mm
 struct
Message-ID: <202308231004.tg0zQ8e9-lkp@intel.com>
References: <20230822184152.2194558-3-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822184152.2194558-3-mjguzik@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20230823/202308231004.tg0zQ8e9-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308231004.tg0zQ8e9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308231004.tg0zQ8e9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:34:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/fork.c:34:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/fork.c:34:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> kernel/fork.c:926:2: error: implicit declaration of function 'percpu_counter_destroy_many' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
           ^
   kernel/fork.c:926:2: note: did you mean 'percpu_counter_destroy'?
   include/linux/percpu_counter.h:136:20: note: 'percpu_counter_destroy' declared here
   static inline void percpu_counter_destroy(struct percpu_counter *fbc)
                      ^
>> kernel/fork.c:1299:6: error: implicit declaration of function 'percpu_counter_init_many' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT, NR_MM_COUNTERS))
               ^
   kernel/fork.c:1299:6: note: did you mean 'percpu_counter_init'?
   include/linux/percpu_counter.h:129:19: note: 'percpu_counter_init' declared here
   static inline int percpu_counter_init(struct percpu_counter *fbc, s64 amount,
                     ^
   12 warnings and 2 errors generated.


vim +/percpu_counter_destroy_many +926 kernel/fork.c

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
