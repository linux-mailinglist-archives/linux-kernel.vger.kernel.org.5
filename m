Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF480DD7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbjLKVnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345444AbjLKVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:43:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161AD0;
        Mon, 11 Dec 2023 13:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702330996; x=1733866996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BTizvhdPXR2BP6L8x0BBdEatPT+ym1i641aGFNAGnFE=;
  b=NIcPUt35rw6ZpEOo5x21CqepPZJTgVVuV2TsYa6pw5OpMalsIpXaO81V
   2q9Er08D63ZcD/vcAiz6tMlvpw/1e6FST1wH9EdSumvcgpzXOx5la5l6Q
   z6Q+qJ36Xyf2+J3fEbtitsv63KK8exTwA5kWWHYgUCMZSUc4aJGJM1gkw
   4TnTmK0imobFQ5gYxUDoyBoYCDJkBzmWoV9oN9NtnqLJG87nG+U4lG0nL
   To68wIp+igO1APDtX+esjvv35ILJja/G6gvtgpE1a+Z6ol6BV3M/CcZGd
   koIlljttUPNfnx5E2ZGfqwxC+/u+GoFg7d7H5CzhApNYb9bcqYXFcrbsz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1862500"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1862500"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 13:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="722964431"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="722964431"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Dec 2023 13:43:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCo3K-000IV9-0L;
        Mon, 11 Dec 2023 21:43:02 +0000
Date:   Tue, 12 Dec 2023 05:42:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     linan666@huaweicloud.com, song@kernel.org, axboe@kernel.dk
Cc:     oe-kbuild-all@lists.linux.dev, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linan666@huaweicloud.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 2/2] md: don't account sync_io if iostats of the disk is
 disabled
Message-ID: <202312120536.VqOKGsPZ-lkp@intel.com>
References: <20231211075614.1850003-3-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211075614.1850003-3-linan666@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on song-md/md-next]
[also build test ERROR on axboe-block/for-next linus/master v6.7-rc5 next-20231211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/linan666-huaweicloud-com/md-Fix-overflow-in-is_mddev_idle/20231211-155833
base:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
patch link:    https://lore.kernel.org/r/20231211075614.1850003-3-linan666%40huaweicloud.com
patch subject: [PATCH 2/2] md: don't account sync_io if iostats of the disk is disabled
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231212/202312120536.VqOKGsPZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231212/202312120536.VqOKGsPZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120536.VqOKGsPZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:23,
                    from include/linux/sched/mm.h:5,
                    from drivers/md/md.c:40:
   drivers/md/md.h: In function 'md_sync_acct_bio':
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:31: error: 'disk' undeclared (first use in this function)
     587 |         if (blk_queue_io_stat(disk—>queue))
         |                               ^~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
   drivers/md/md.h:587:31: note: each undeclared identifier is reported only once for each function it appears in
     587 |         if (blk_queue_io_stat(disk—>queue))
         |                               ^~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:37: error: 'queue' undeclared (first use in this function); did you mean 'sigqueue'?
     587 |         if (blk_queue_io_stat(disk—>queue))
         |                                     ^~~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:51:23: note: in definition of macro 'bitop'
      51 |           (uintptr_t)(addr) != (uintptr_t)NULL &&                       \
         |                       ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:52:57: note: in definition of macro 'bitop'
      52 |           __builtin_constant_p(*(const unsigned long *)(addr))) ?       \
         |                                                         ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:53:24: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                        ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:53:39: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                                       ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
   drivers/md/md.c: In function 'is_mddev_idle':
>> drivers/md/md.c:8517:43: error: stray '\342' in program
    8517 |                 if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                           ^~~~~~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.c:8517:21: note: in expansion of macro 'blk_queue_io_stat'
    8517 |                 if (blk_queue_io_stat(disk—>queue))
         |                     ^~~~~~~~~~~~~~~~~
>> drivers/md/md.c:8517:45: error: 'queue' undeclared (first use in this function); did you mean 'sigqueue'?
    8517 |                 if (blk_queue_io_stat(disk—>queue))
         |                                             ^~~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.c:8517:21: note: in expansion of macro 'blk_queue_io_stat'
    8517 |                 if (blk_queue_io_stat(disk—>queue))
         |                     ^~~~~~~~~~~~~~~~~
>> drivers/md/md.c:8517:43: error: stray '\342' in program
    8517 |                 if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                           ^~~~~~~~
   include/linux/bitops.h:51:23: note: in definition of macro 'bitop'
      51 |           (uintptr_t)(addr) != (uintptr_t)NULL &&                       \
         |                       ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.c:8517:21: note: in expansion of macro 'blk_queue_io_stat'
    8517 |                 if (blk_queue_io_stat(disk—>queue))
         |                     ^~~~~~~~~~~~~~~~~
>> drivers/md/md.c:8517:43: error: stray '\342' in program
    8517 |                 if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                           ^~~~~~~~
   include/linux/bitops.h:52:57: note: in definition of macro 'bitop'
      52 |           __builtin_constant_p(*(const unsigned long *)(addr))) ?       \
         |                                                         ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.c:8517:21: note: in expansion of macro 'blk_queue_io_stat'
    8517 |                 if (blk_queue_io_stat(disk—>queue))
         |                     ^~~~~~~~~~~~~~~~~
>> drivers/md/md.c:8517:43: error: stray '\342' in program
    8517 |                 if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                           ^~~~~~~~
   include/linux/bitops.h:53:24: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                        ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.c:8517:21: note: in expansion of macro 'blk_queue_io_stat'
    8517 |                 if (blk_queue_io_stat(disk—>queue))
         |                     ^~~~~~~~~~~~~~~~~
>> drivers/md/md.c:8517:43: error: stray '\342' in program
    8517 |                 if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                           ^~~~~~~~
   include/linux/bitops.h:53:39: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                                       ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.c:8517:21: note: in expansion of macro 'blk_queue_io_stat'
    8517 |                 if (blk_queue_io_stat(disk—>queue))
         |                     ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/thread_info.h:27,
                    from arch/arm64/include/asm/preempt.h:6,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/md/md-bitmap.c:19:
   drivers/md/md.h: In function 'md_sync_acct_bio':
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:31: error: 'disk' undeclared (first use in this function)
     587 |         if (blk_queue_io_stat(disk—>queue))
         |                               ^~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
   drivers/md/md.h:587:31: note: each undeclared identifier is reported only once for each function it appears in
     587 |         if (blk_queue_io_stat(disk—>queue))
         |                               ^~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:37: error: 'queue' undeclared (first use in this function); did you mean 'sigqueue'?
     587 |         if (blk_queue_io_stat(disk—>queue))
         |                                     ^~~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:51:23: note: in definition of macro 'bitop'
      51 |           (uintptr_t)(addr) != (uintptr_t)NULL &&                       \
         |                       ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:52:57: note: in definition of macro 'bitop'
      52 |           __builtin_constant_p(*(const unsigned long *)(addr))) ?       \
         |                                                         ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:53:24: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                        ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~
>> drivers/md/md.h:587:35: error: stray '\342' in program
     587 |         if (blk_queue_io_stat(disk<U+2014>>queue))
         |                                   ^~~~~~~~
   include/linux/bitops.h:53:39: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                                       ^~~~
   include/linux/blkdev.h:567:33: note: in expansion of macro 'test_bit'
     567 | #define blk_queue_io_stat(q)    test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
         |                                 ^~~~~~~~
   drivers/md/md.h:587:13: note: in expansion of macro 'blk_queue_io_stat'
     587 |         if (blk_queue_io_stat(disk—>queue))
         |             ^~~~~~~~~~~~~~~~~


vim +/342 +587 drivers/md/md.h

   584	
   585	static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
   586	{
 > 587		if (blk_queue_io_stat(disk—>queue))
   588			md_sync_acct(bio->bi_bdev, nr_sectors);
   589	}
   590	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
