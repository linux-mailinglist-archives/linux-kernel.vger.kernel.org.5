Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABBA761DED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjGYQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjGYQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:00:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F427E4D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300810; x=1721836810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hwVaMZpylyqjbSlLNuQIT5HhTs+112ayYUlHlUKyMag=;
  b=buHTT1KjCsVUT7o5wwHIgvfjHMHz/amybOlUd/3tb9FvE//av3U4k0kq
   GOk78iT0ZqIfhfyx+oQJOJ87ILmzB8ZYaOQ97ya8zxbVnfUUP1y11ihya
   +irwvHrROlkkAylDFTfPJA8HnI4h10PvzavVTng/FDMjEBxLncFJS+H7z
   WMZkAn7V2dALB6h8/iacN9wpsE1jwBT5dlSYI42RoyW+KUuLLPZpI9XvG
   HDSOLyfHzVNnQcZ0W2dWmoaiT20AP6xJkchzD4AIOEBrL3EZt7exKiUFL
   M8BLg5oT9p/AqR3A+BQhmde7RTOWSV+nEj6Vacg9bUpO3VnSuh3Isp9Bv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367797250"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367797250"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="676276296"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="676276296"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2023 08:59:40 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOKRU-00006x-2R;
        Tue, 25 Jul 2023 15:59:24 +0000
Date:   Tue, 25 Jul 2023 23:58:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Message-ID: <202307252359.Is4T2MXC-lkp@intel.com>
References: <454f967d452548a9acfa7c0a0872507e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454f967d452548a9acfa7c0a0872507e@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.5-rc3 next-20230725]
[cannot apply to next-20230725 hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Add-min_unsigned-a-b-and-max_unsigned-a-b/20230725-180332
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/454f967d452548a9acfa7c0a0872507e%40AcuMS.aculab.com
patch subject: [PATCH next 2/5] minmax: Allow min()/max()/clamp() if the arguments have the same signedness.
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230725/202307252359.Is4T2MXC-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307252359.Is4T2MXC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307252359.Is4T2MXC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from init/calibrate.c:8:
>> include/linux/jiffies.h:427:28: error: call to undeclared function 'static_assert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     427 |         return jiffies_to_clock_t(max(0L, delta));
         |                                   ^
   include/linux/minmax.h:69:19: note: expanded from macro 'max'
      69 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^
   include/linux/minmax.h:36:3: note: expanded from macro '__careful_cmp'
      36 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^
   include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
      29 |                 static_assert(__types_ok(x, y),         \
         |                 ^
   In file included from init/calibrate.c:8:
   include/linux/jiffies.h:432:26: error: call to undeclared function 'static_assert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     432 |         return jiffies_to_msecs(max(0L, delta));
         |                                 ^
   include/linux/minmax.h:69:19: note: expanded from macro 'max'
      69 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^
   include/linux/minmax.h:36:3: note: expanded from macro '__careful_cmp'
      36 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^
   include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
      29 |                 static_assert(__types_ok(x, y),         \
         |                 ^
   2 errors generated.
--
   In file included from fs/signalfd.c:22:
   In file included from include/linux/poll.h:7:
   In file included from include/linux/ktime.h:25:
>> include/linux/jiffies.h:427:28: error: call to undeclared function 'static_assert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     427 |         return jiffies_to_clock_t(max(0L, delta));
         |                                   ^
   include/linux/minmax.h:69:19: note: expanded from macro 'max'
      69 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^
   include/linux/minmax.h:36:3: note: expanded from macro '__careful_cmp'
      36 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^
   include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
      29 |                 static_assert(__types_ok(x, y),         \
         |                 ^
   In file included from fs/signalfd.c:22:
   In file included from include/linux/poll.h:7:
   In file included from include/linux/ktime.h:25:
   include/linux/jiffies.h:432:26: error: call to undeclared function 'static_assert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     432 |         return jiffies_to_msecs(max(0L, delta));
         |                                 ^
   include/linux/minmax.h:69:19: note: expanded from macro 'max'
      69 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^
   include/linux/minmax.h:36:3: note: expanded from macro '__careful_cmp'
      36 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^
   include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
      29 |                 static_assert(__types_ok(x, y),         \
         |                 ^
   In file included from fs/signalfd.c:22:
   In file included from include/linux/poll.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      97 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from fs/signalfd.c:22:
   In file included from include/linux/poll.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      97 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from fs/signalfd.c:22:
   In file included from include/linux/poll.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from fs/signalfd.c:22:
   In file included from include/linux/poll.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:100:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     100 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from fs/signalfd.c:22:
   In file included from include/linux/poll.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     113 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from fs/signalfd.c:22:
   In file included from include/linux/poll.h:10:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     113 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from fs/signalfd.c:22:
   In file included from include/linux/poll.h:10:
--
   In file included from kernel/irq/spurious.c:8:
>> include/linux/jiffies.h:427:28: error: call to undeclared function 'static_assert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     427 |         return jiffies_to_clock_t(max(0L, delta));
         |                                   ^
   include/linux/minmax.h:69:19: note: expanded from macro 'max'
      69 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^
   include/linux/minmax.h:36:3: note: expanded from macro '__careful_cmp'
      36 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^
   include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
      29 |                 static_assert(__types_ok(x, y),         \
         |                 ^
   In file included from kernel/irq/spurious.c:8:
   include/linux/jiffies.h:432:26: error: call to undeclared function 'static_assert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     432 |         return jiffies_to_msecs(max(0L, delta));
         |                                 ^
   include/linux/minmax.h:69:19: note: expanded from macro 'max'
      69 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^
   include/linux/minmax.h:36:3: note: expanded from macro '__careful_cmp'
      36 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^
   include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
      29 |                 static_assert(__types_ok(x, y),         \
         |                 ^
   In file included from kernel/irq/spurious.c:9:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/irq/spurious.c:9:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/irq/spurious.c:9:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   12 warnings and 2 errors generated.
--
   In file included from kernel/time/alarmtimer.c:16:
   In file included from include/linux/hrtimer.h:15:
   In file included from include/linux/hrtimer_defs.h:5:
   In file included from include/linux/ktime.h:25:
>> include/linux/jiffies.h:427:28: error: call to undeclared function 'static_assert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     427 |         return jiffies_to_clock_t(max(0L, delta));
         |                                   ^
   include/linux/minmax.h:69:19: note: expanded from macro 'max'
      69 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^
   include/linux/minmax.h:36:3: note: expanded from macro '__careful_cmp'
      36 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^
   include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
      29 |                 static_assert(__types_ok(x, y),         \
         |                 ^
   In file included from kernel/time/alarmtimer.c:16:
   In file included from include/linux/hrtimer.h:15:
   In file included from include/linux/hrtimer_defs.h:5:
   In file included from include/linux/ktime.h:25:
   include/linux/jiffies.h:432:26: error: call to undeclared function 'static_assert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     432 |         return jiffies_to_msecs(max(0L, delta));
         |                                 ^
   include/linux/minmax.h:69:19: note: expanded from macro 'max'
      69 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^
   include/linux/minmax.h:36:3: note: expanded from macro '__careful_cmp'
      36 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^
   include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
      29 |                 static_assert(__types_ok(x, y),         \
         |                 ^
   In file included from kernel/time/alarmtimer.c:18:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/time/alarmtimer.c:18:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/time/alarmtimer.c:18:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from kernel/time/alarmtimer.c:18:
   In file included from include/linux/rtc.h:38:
   In file included from include/linux/seq_file.h:12:
   In file included from include/linux/fs.h:33:


vim +/static_assert +427 include/linux/jiffies.h

ae60d6a0e3a919 Nicholas Mc Guire 2015-05-28  420  
9ca308506062fc Baolin Wang       2015-07-29  421  extern unsigned long timespec64_to_jiffies(const struct timespec64 *value);
9ca308506062fc Baolin Wang       2015-07-29  422  extern void jiffies_to_timespec64(const unsigned long jiffies,
9ca308506062fc Baolin Wang       2015-07-29  423  				  struct timespec64 *value);
cbbc719fccdb8c hank              2011-09-20  424  extern clock_t jiffies_to_clock_t(unsigned long x);
a399a8053164ec Eric Dumazet      2012-08-08  425  static inline clock_t jiffies_delta_to_clock_t(long delta)
a399a8053164ec Eric Dumazet      2012-08-08  426  {
a399a8053164ec Eric Dumazet      2012-08-08 @427  	return jiffies_to_clock_t(max(0L, delta));
a399a8053164ec Eric Dumazet      2012-08-08  428  }
a399a8053164ec Eric Dumazet      2012-08-08  429  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
