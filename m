Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD007A8CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjITT3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjITT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D7EB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695238151; x=1726774151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PUcW9mG/BSXV2j0arFHe6YcIhOAu5GzjJn08mAWeLhA=;
  b=dPP2FcIh7B1VxNzhYt8wmFr0D3QnmUT9EIq83RWpDha6OaEdFgkV+Y3X
   qheBhhG5noGidbZ42jdSzrV0r8qF5K811hNhELLLfWWykftzDMJxwTqOI
   /gr9YbMiriQXyI7yv8JFyjoKOWQo8WgDAdm7iuoc7GXGqk9Z74ZXHSCiw
   yte3ayKL8hUOotfsNEjEuwJf+5hHV/MZ2FDYVydR994TqGv/wP4P1tlgY
   c44tnmNZIUC6Ppx9qjBsFVqRL2Am6fNYySYRy6z0tNTplyEb8oZo2+hnO
   42bO2qc9Qibl/9ofJcNqya+bBIcRQ1eq31fTTRQMBat7cJFDymP3eLgBx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="380232177"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="380232177"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 12:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="837004159"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="837004159"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Sep 2023 12:29:06 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj2sh-00093w-3B;
        Wed, 20 Sep 2023 19:29:03 +0000
Date:   Thu, 21 Sep 2023 03:28:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Subject: Re: [PATCH] sched: fix warning in bandwidth distribution
Message-ID: <202309210339.XihTnzE3-lkp@intel.com>
References: <20230920000559.3872416-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920000559.3872416-1-joshdon@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/master tip/auto-latest linus/master v6.6-rc2 next-20230920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Don/sched-fix-warning-in-bandwidth-distribution/20230920-080712
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20230920000559.3872416-1-joshdon%40google.com
patch subject: [PATCH] sched: fix warning in bandwidth distribution
config: arm-bcm2835_defconfig (https://download.01.org/0day-ci/archive/20230921/202309210339.XihTnzE3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309210339.XihTnzE3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309210339.XihTnzE3-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'distribute_cfs_runtime':
   kernel/sched/fair.c:5808:56: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5808 |                                 list_add_tail(&cfs_rq->throttled_csd_list,
         |                                                        ^~~~~~~~~~~~~~~~~~
         |                                                        throttled_list
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:21,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:612:9: note: in expansion of macro 'list_entry'
     612 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:857:20: note: in expansion of macro 'list_first_entry'
     857 |         for (pos = list_first_entry(head, typeof(*pos), member),        \
         |                    ^~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:366:27: error: expression in static assertion is not an integer
     366 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:612:9: note: in expansion of macro 'list_entry'
     612 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:857:20: note: in expansion of macro 'list_first_entry'
     857 |         for (pos = list_first_entry(head, typeof(*pos), member),        \
         |                    ^~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/limits.h:6,
                    from include/linux/kernel.h:16,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                          ^~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:612:9: note: in expansion of macro 'list_entry'
     612 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:857:20: note: in expansion of macro 'list_first_entry'
     857 |         for (pos = list_first_entry(head, typeof(*pos), member),        \
         |                    ^~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:21,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:858:21: note: in expansion of macro 'list_next_entry'
     858 |                 n = list_next_entry(pos, member);                       \
         |                     ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:21,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:858:21: note: in expansion of macro 'list_next_entry'
     858 |                 n = list_next_entry(pos, member);                       \
         |                     ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:858:21: note: in expansion of macro 'list_next_entry'
     858 |                 n = list_next_entry(pos, member);                       \
         |                     ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:858:21: note: in expansion of macro 'list_next_entry'
     858 |                 n = list_next_entry(pos, member);                       \
         |                     ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:366:27: error: expression in static assertion is not an integer
     366 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:858:21: note: in expansion of macro 'list_next_entry'
     858 |                 n = list_next_entry(pos, member);                       \
         |                     ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/limits.h:6,
                    from include/linux/kernel.h:16,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                          ^~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:858:21: note: in expansion of macro 'list_next_entry'
     858 |                 n = list_next_entry(pos, member);                       \
         |                     ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/rculist.h:10,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/energy_model.h:5,
                    from kernel/sched/fair.c:23:
   include/linux/list.h:857:64: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     857 |         for (pos = list_first_entry(head, typeof(*pos), member),        \
         |                                                                ^
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/list.h:761:16: note: in definition of macro 'list_entry_is_head'
     761 |         (&pos->member == (head))
         |                ^~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:21,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:860:27: note: in expansion of macro 'list_next_entry'
     860 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:21,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:860:27: note: in expansion of macro 'list_next_entry'
     860 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:860:27: note: in expansion of macro 'list_next_entry'
     860 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:860:27: note: in expansion of macro 'list_next_entry'
     860 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:366:27: error: expression in static assertion is not an integer
     366 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:860:27: note: in expansion of macro 'list_next_entry'
     860 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/limits.h:6,
                    from include/linux/kernel.h:16,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c:5820:34: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5820 |                                  throttled_csd_list) {
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                          ^~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:860:27: note: in expansion of macro 'list_next_entry'
     860 |              pos = n, n = list_next_entry(n, member))
         |                           ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5819:9: note: in expansion of macro 'list_for_each_entry_safe'
    5819 |         list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5825:40: error: 'struct cfs_rq' has no member named 'throttled_csd_list'; did you mean 'throttled_list'?
    5825 |                 list_del_init(&cfs_rq->throttled_csd_list);
         |                                        ^~~~~~~~~~~~~~~~~~
         |                                        throttled_list


vim +366 include/linux/compiler_types.h

eb111869301e15 Rasmus Villemoes 2019-09-13  364  
d15155824c5014 Will Deacon      2017-10-24  365  /* Are two types/vars the same type (ignoring qualifiers)? */
d15155824c5014 Will Deacon      2017-10-24 @366  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
d15155824c5014 Will Deacon      2017-10-24  367  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
