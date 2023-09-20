Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6687A7001
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 03:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjITBPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 21:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITBPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 21:15:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C5AC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 18:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695172503; x=1726708503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lA+14hohHu5S8812drCkV8Tr88aACel8SEr2nOsWFLk=;
  b=NT6WFyz9XIcLYcRFGGNOAoS6xyXNN/ahQn0FyFVreMsvP9yf6CM8n7eZ
   COxchMIW1AhyW/J3VWtg+Ms7qaIgsPFu5UF6QCQwS/+AvUT0IrHkamuY1
   A5sZk+hXsKW6Xg0JPDfajI4pj3hDy25sSV1fE9hmY4StEZ9uVzxHA0IfI
   HWTRmsRy6qZmo/csVPe+BoGpBMRIglwHBL4vp8nE1IAJuumf38xDbENTX
   MCSGdEtFytKPm9UFUydLIo8C3cMR7MeSIOa4OiGLx0hNuGszAdpdRz2i3
   fWApDgH00z72vaxatrML/uHqL3zJquKdHuaBa0bFasgx7fPL4jZM7lZXh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="378985136"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="378985136"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 18:15:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="836641330"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="836641330"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2023 18:14:59 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qilnp-000882-30;
        Wed, 20 Sep 2023 01:14:55 +0000
Date:   Wed, 20 Sep 2023 09:14:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <202309200825.vOa3t8Sx-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on tip/master tip/auto-latest linus/master v6.6-rc2 next-20230919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Don/sched-fix-warning-in-bandwidth-distribution/20230920-080712
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20230920000559.3872416-1-joshdon%40google.com
patch subject: [PATCH] sched: fix warning in bandwidth distribution
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230920/202309200825.vOa3t8Sx-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200825.vOa3t8Sx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200825.vOa3t8Sx-lkp@intel.com/

All warnings (new ones prefixed by >>):

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
   include/linux/compiler_types.h:366:27: error: expression in static assertion is not an integer
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
   In file included from include/linux/preempt.h:12,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:17,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:13:
>> include/linux/list.h:857:64: warning: left-hand operand of comma expression has no effect [-Wunused-value]
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


vim +857 include/linux/list.h

4d70c74659d974 Andy Shevchenko          2022-11-30  753  
e130816164e244 Andy Shevchenko          2020-10-15  754  /**
e130816164e244 Andy Shevchenko          2020-10-15  755   * list_entry_is_head - test if the entry points to the head of the list
e130816164e244 Andy Shevchenko          2020-10-15  756   * @pos:	the type * to cursor
e130816164e244 Andy Shevchenko          2020-10-15  757   * @head:	the head for your list.
e130816164e244 Andy Shevchenko          2020-10-15  758   * @member:	the name of the list_head within the struct.
e130816164e244 Andy Shevchenko          2020-10-15  759   */
e130816164e244 Andy Shevchenko          2020-10-15  760  #define list_entry_is_head(pos, head, member)				\
e130816164e244 Andy Shevchenko          2020-10-15  761  	(&pos->member == (head))
e130816164e244 Andy Shevchenko          2020-10-15  762  
^1da177e4c3f41 Linus Torvalds           2005-04-16  763  /**
^1da177e4c3f41 Linus Torvalds           2005-04-16  764   * list_for_each_entry	-	iterate over list of given type
8e3a67a99231f9 Randy Dunlap             2006-06-25  765   * @pos:	the type * to use as a loop cursor.
^1da177e4c3f41 Linus Torvalds           2005-04-16  766   * @head:	the head for your list.
3943f42c11896c Andrey Utkin             2014-11-14  767   * @member:	the name of the list_head within the struct.
^1da177e4c3f41 Linus Torvalds           2005-04-16  768   */
^1da177e4c3f41 Linus Torvalds           2005-04-16  769  #define list_for_each_entry(pos, head, member)				\
93be3c2eb3371f Oleg Nesterov            2013-11-12  770  	for (pos = list_first_entry(head, typeof(*pos), member);	\
e130816164e244 Andy Shevchenko          2020-10-15  771  	     !list_entry_is_head(pos, head, member);			\
8120e2e5141a42 Oleg Nesterov            2013-11-12  772  	     pos = list_next_entry(pos, member))
^1da177e4c3f41 Linus Torvalds           2005-04-16  773  
^1da177e4c3f41 Linus Torvalds           2005-04-16  774  /**
^1da177e4c3f41 Linus Torvalds           2005-04-16  775   * list_for_each_entry_reverse - iterate backwards over list of given type.
8e3a67a99231f9 Randy Dunlap             2006-06-25  776   * @pos:	the type * to use as a loop cursor.
^1da177e4c3f41 Linus Torvalds           2005-04-16  777   * @head:	the head for your list.
3943f42c11896c Andrey Utkin             2014-11-14  778   * @member:	the name of the list_head within the struct.
^1da177e4c3f41 Linus Torvalds           2005-04-16  779   */
^1da177e4c3f41 Linus Torvalds           2005-04-16  780  #define list_for_each_entry_reverse(pos, head, member)			\
93be3c2eb3371f Oleg Nesterov            2013-11-12  781  	for (pos = list_last_entry(head, typeof(*pos), member);		\
e130816164e244 Andy Shevchenko          2020-10-15  782  	     !list_entry_is_head(pos, head, member); 			\
8120e2e5141a42 Oleg Nesterov            2013-11-12  783  	     pos = list_prev_entry(pos, member))
^1da177e4c3f41 Linus Torvalds           2005-04-16  784  
^1da177e4c3f41 Linus Torvalds           2005-04-16  785  /**
72fd4a35a82433 Robert P. J. Day         2007-02-10  786   * list_prepare_entry - prepare a pos entry for use in list_for_each_entry_continue()
^1da177e4c3f41 Linus Torvalds           2005-04-16  787   * @pos:	the type * to use as a start point
^1da177e4c3f41 Linus Torvalds           2005-04-16  788   * @head:	the head of the list
3943f42c11896c Andrey Utkin             2014-11-14  789   * @member:	the name of the list_head within the struct.
fe96e57d77481c Randy Dunlap             2006-06-25  790   *
72fd4a35a82433 Robert P. J. Day         2007-02-10  791   * Prepares a pos entry for use as a start point in list_for_each_entry_continue().
^1da177e4c3f41 Linus Torvalds           2005-04-16  792   */
^1da177e4c3f41 Linus Torvalds           2005-04-16  793  #define list_prepare_entry(pos, head, member) \
^1da177e4c3f41 Linus Torvalds           2005-04-16  794  	((pos) ? : list_entry(head, typeof(*pos), member))
^1da177e4c3f41 Linus Torvalds           2005-04-16  795  
^1da177e4c3f41 Linus Torvalds           2005-04-16  796  /**
fe96e57d77481c Randy Dunlap             2006-06-25  797   * list_for_each_entry_continue - continue iteration over list of given type
8e3a67a99231f9 Randy Dunlap             2006-06-25  798   * @pos:	the type * to use as a loop cursor.
^1da177e4c3f41 Linus Torvalds           2005-04-16  799   * @head:	the head for your list.
3943f42c11896c Andrey Utkin             2014-11-14  800   * @member:	the name of the list_head within the struct.
fe96e57d77481c Randy Dunlap             2006-06-25  801   *
fe96e57d77481c Randy Dunlap             2006-06-25  802   * Continue to iterate over list of given type, continuing after
fe96e57d77481c Randy Dunlap             2006-06-25  803   * the current position.
^1da177e4c3f41 Linus Torvalds           2005-04-16  804   */
^1da177e4c3f41 Linus Torvalds           2005-04-16  805  #define list_for_each_entry_continue(pos, head, member) 		\
8120e2e5141a42 Oleg Nesterov            2013-11-12  806  	for (pos = list_next_entry(pos, member);			\
e130816164e244 Andy Shevchenko          2020-10-15  807  	     !list_entry_is_head(pos, head, member);			\
8120e2e5141a42 Oleg Nesterov            2013-11-12  808  	     pos = list_next_entry(pos, member))
^1da177e4c3f41 Linus Torvalds           2005-04-16  809  
768f3591e2b1cc Pavel Emelyanov          2007-09-18  810  /**
768f3591e2b1cc Pavel Emelyanov          2007-09-18  811   * list_for_each_entry_continue_reverse - iterate backwards from the given point
768f3591e2b1cc Pavel Emelyanov          2007-09-18  812   * @pos:	the type * to use as a loop cursor.
768f3591e2b1cc Pavel Emelyanov          2007-09-18  813   * @head:	the head for your list.
3943f42c11896c Andrey Utkin             2014-11-14  814   * @member:	the name of the list_head within the struct.
768f3591e2b1cc Pavel Emelyanov          2007-09-18  815   *
768f3591e2b1cc Pavel Emelyanov          2007-09-18  816   * Start to iterate over list of given type backwards, continuing after
768f3591e2b1cc Pavel Emelyanov          2007-09-18  817   * the current position.
768f3591e2b1cc Pavel Emelyanov          2007-09-18  818   */
768f3591e2b1cc Pavel Emelyanov          2007-09-18  819  #define list_for_each_entry_continue_reverse(pos, head, member)		\
8120e2e5141a42 Oleg Nesterov            2013-11-12  820  	for (pos = list_prev_entry(pos, member);			\
e130816164e244 Andy Shevchenko          2020-10-15  821  	     !list_entry_is_head(pos, head, member);			\
8120e2e5141a42 Oleg Nesterov            2013-11-12  822  	     pos = list_prev_entry(pos, member))
768f3591e2b1cc Pavel Emelyanov          2007-09-18  823  
e229c2fb3370a0 Arnaldo Carvalho de Melo 2006-03-20  824  /**
fe96e57d77481c Randy Dunlap             2006-06-25  825   * list_for_each_entry_from - iterate over list of given type from the current point
8e3a67a99231f9 Randy Dunlap             2006-06-25  826   * @pos:	the type * to use as a loop cursor.
e229c2fb3370a0 Arnaldo Carvalho de Melo 2006-03-20  827   * @head:	the head for your list.
3943f42c11896c Andrey Utkin             2014-11-14  828   * @member:	the name of the list_head within the struct.
fe96e57d77481c Randy Dunlap             2006-06-25  829   *
fe96e57d77481c Randy Dunlap             2006-06-25  830   * Iterate over list of given type, continuing from current position.
e229c2fb3370a0 Arnaldo Carvalho de Melo 2006-03-20  831   */
e229c2fb3370a0 Arnaldo Carvalho de Melo 2006-03-20  832  #define list_for_each_entry_from(pos, head, member) 			\
e130816164e244 Andy Shevchenko          2020-10-15  833  	for (; !list_entry_is_head(pos, head, member);			\
8120e2e5141a42 Oleg Nesterov            2013-11-12  834  	     pos = list_next_entry(pos, member))
e229c2fb3370a0 Arnaldo Carvalho de Melo 2006-03-20  835  
b862815c3ee7b4 Jiri Pirko               2017-02-03  836  /**
b862815c3ee7b4 Jiri Pirko               2017-02-03  837   * list_for_each_entry_from_reverse - iterate backwards over list of given type
b862815c3ee7b4 Jiri Pirko               2017-02-03  838   *                                    from the current point
b862815c3ee7b4 Jiri Pirko               2017-02-03  839   * @pos:	the type * to use as a loop cursor.
b862815c3ee7b4 Jiri Pirko               2017-02-03  840   * @head:	the head for your list.
b862815c3ee7b4 Jiri Pirko               2017-02-03  841   * @member:	the name of the list_head within the struct.
b862815c3ee7b4 Jiri Pirko               2017-02-03  842   *
b862815c3ee7b4 Jiri Pirko               2017-02-03  843   * Iterate backwards over list of given type, continuing from current position.
b862815c3ee7b4 Jiri Pirko               2017-02-03  844   */
b862815c3ee7b4 Jiri Pirko               2017-02-03  845  #define list_for_each_entry_from_reverse(pos, head, member)		\
e130816164e244 Andy Shevchenko          2020-10-15  846  	for (; !list_entry_is_head(pos, head, member);			\
b862815c3ee7b4 Jiri Pirko               2017-02-03  847  	     pos = list_prev_entry(pos, member))
b862815c3ee7b4 Jiri Pirko               2017-02-03  848  
^1da177e4c3f41 Linus Torvalds           2005-04-16  849  /**
^1da177e4c3f41 Linus Torvalds           2005-04-16  850   * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
8e3a67a99231f9 Randy Dunlap             2006-06-25  851   * @pos:	the type * to use as a loop cursor.
^1da177e4c3f41 Linus Torvalds           2005-04-16  852   * @n:		another type * to use as temporary storage
^1da177e4c3f41 Linus Torvalds           2005-04-16  853   * @head:	the head for your list.
3943f42c11896c Andrey Utkin             2014-11-14  854   * @member:	the name of the list_head within the struct.
^1da177e4c3f41 Linus Torvalds           2005-04-16  855   */
^1da177e4c3f41 Linus Torvalds           2005-04-16  856  #define list_for_each_entry_safe(pos, n, head, member)			\
93be3c2eb3371f Oleg Nesterov            2013-11-12 @857  	for (pos = list_first_entry(head, typeof(*pos), member),	\
8120e2e5141a42 Oleg Nesterov            2013-11-12  858  		n = list_next_entry(pos, member);			\
e130816164e244 Andy Shevchenko          2020-10-15  859  	     !list_entry_is_head(pos, head, member); 			\
8120e2e5141a42 Oleg Nesterov            2013-11-12  860  	     pos = n, n = list_next_entry(n, member))
^1da177e4c3f41 Linus Torvalds           2005-04-16  861  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
