Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25117E0A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjKCU7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjKCU7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:59:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F19D53
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699045105; x=1730581105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YVoHDiXMFphBPSc6DDbq+p7WzgQJWFxDW8V33M/OCjI=;
  b=i9v7sTR6qWZMaWiUMlRbE8H4vtmYEVIwCbXtjxIRsfqpf51vivUjpzPo
   vWoPNkWlSfzGKhhHSOqYdKb58CUii9AYBRiAAqhucARI7aLiE+YAREerN
   190uRY4oVAR2QewI9rLK4MY4TrmO++q6zXYXsF9wvC4VLOkYtfQPzgYil
   R64y1qiw8yoIdsqb7GpVI0QyGf385hZbT3QlInFKSEuovKm1OqucvDO0j
   Hj3YU9P6+a9QMUmALZqRDCOQVnAM6WCw4qfKtlc9bfMNOypQYmaIwfJ+G
   VPF4UCEaRbEqznseKBPZ0R7ndIxc+9Ohq7Ob4t251vSSDrwvEPDWNFL5y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="374055134"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="374055134"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832141257"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="832141257"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2023 13:58:18 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz1FA-0002vy-2E;
        Fri, 03 Nov 2023 20:58:16 +0000
Date:   Sat, 4 Nov 2023 04:57:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>,
        Jason Baron <jbaron@akamai.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: Re: [PATCH v1 08/12] dyndbg: move flags field to a new structure
Message-ID: <202311040450.FoHhKIIg-lkp@intel.com>
References: <20231103131011.1316396-9-lb@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103131011.1316396-9-lb@semihalf.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Łukasz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.6 next-20231103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ukasz-Bartosik/dyndbg-add-_DPRINTK_FLAGS_ENABLED/20231103-212105
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231103131011.1316396-9-lb%40semihalf.com
patch subject: [PATCH v1 08/12] dyndbg: move flags field to a new structure
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040450.FoHhKIIg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040450.FoHhKIIg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040450.FoHhKIIg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from mm/page_alloc.c:19:
   mm/page_alloc.c: In function 'zone_pcp_init':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:231:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     231 |         if (DYNAMIC_DEBUG_BRANCH(id))                           \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:256:9: note: in expansion of macro '__dynamic_func_call_cls'
     256 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:258:9: note: in expansion of macro '_dynamic_func_call_cls'
     258 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:277:9: note: in expansion of macro '_dynamic_func_call'
     277 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:579:9: note: in expansion of macro 'dynamic_pr_debug'
     579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   mm/page_alloc.c:5691:17: note: in expansion of macro 'pr_debug'
    5691 |                 pr_debug("  %s zone: %lu pages, LIFO batch:%u\n", zone->name,
         |                 ^~~~~~~~
   mm/page_alloc.c: In function 'alloc_contig_dump_pages':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   mm/page_alloc.c:6250:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
    6250 |         if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
         |             ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:564,
                    from include/asm-generic/bug.h:22:
>> mm/page_alloc.c:6248:39: warning: variable 'descriptor' set but not used [-Wunused-but-set-variable]
    6248 |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "migrate failure");
         |                                       ^~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   mm/page_alloc.c:6248:9: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
    6248 |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "migrate failure");
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/rculist.h:10,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from fs/btrfs/delayed-ref.c:6:
   fs/btrfs/delayed-ref.c: In function 'btrfs_check_delayed_seq':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/delayed-ref.c:519:17: note: in expansion of macro 'btrfs_debug'
     519 |                 btrfs_debug(fs_info,
         |                 ^~~~~~~~~~~
   In file included from include/linux/printk.h:564,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:17,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11:
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug322' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/delayed-ref.c:519:17: note: in expansion of macro 'btrfs_debug'
     519 |                 btrfs_debug(fs_info,
         |                 ^~~~~~~~~~~
--
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/rculist.h:10,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from fs/btrfs/relocation.c:6:
   fs/btrfs/relocation.c: In function 'create_reloc_root':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:833:17: note: in expansion of macro 'btrfs_abort_transaction'
     833 |                 btrfs_abort_transaction(trans, ret);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:564,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:17,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11:
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug320' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:833:17: note: in expansion of macro 'btrfs_abort_transaction'
     833 |                 btrfs_abort_transaction(trans, ret);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/relocation.c: In function 'replace_file_extents':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1167:25: note: in expansion of macro 'btrfs_abort_transaction'
    1167 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug322' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1167:25: note: in expansion of macro 'btrfs_abort_transaction'
    1167 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1178:25: note: in expansion of macro 'btrfs_abort_transaction'
    1178 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug324' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1178:25: note: in expansion of macro 'btrfs_abort_transaction'
    1178 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/relocation.c: In function 'replace_path':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1390:25: note: in expansion of macro 'btrfs_abort_transaction'
    1390 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug326' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1390:25: note: in expansion of macro 'btrfs_abort_transaction'
    1390 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1399:25: note: in expansion of macro 'btrfs_abort_transaction'
    1399 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug328' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1399:25: note: in expansion of macro 'btrfs_abort_transaction'
    1399 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1409:25: note: in expansion of macro 'btrfs_abort_transaction'
    1409 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug330' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1409:25: note: in expansion of macro 'btrfs_abort_transaction'
    1409 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1419:25: note: in expansion of macro 'btrfs_abort_transaction'
    1419 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug332' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1419:25: note: in expansion of macro 'btrfs_abort_transaction'
    1419 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/relocation.c: In function 'merge_reloc_root':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1843:25: note: in expansion of macro 'btrfs_abort_transaction'
    1843 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug336' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1843:25: note: in expansion of macro 'btrfs_abort_transaction'
    1843 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/relocation.c: In function 'prepare_to_merge':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1914:25: note: in expansion of macro 'btrfs_abort_transaction'
    1914 |                         btrfs_abort_transaction(trans, (int)PTR_ERR(root));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug338' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1914:25: note: in expansion of macro 'btrfs_abort_transaction'
    1914 |                         btrfs_abort_transaction(trans, (int)PTR_ERR(root));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1947:25: note: in expansion of macro 'btrfs_abort_transaction'
    1947 |                         btrfs_abort_transaction(trans, -EUCLEAN);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug340' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1947:25: note: in expansion of macro 'btrfs_abort_transaction'
    1947 |                         btrfs_abort_transaction(trans, -EUCLEAN);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1969:25: note: in expansion of macro 'btrfs_abort_transaction'
    1969 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug342' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:1969:25: note: in expansion of macro 'btrfs_abort_transaction'
    1969 |                         btrfs_abort_transaction(trans, ret);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/relocation.c: In function 'do_relocation':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:2532:33: note: in expansion of macro 'btrfs_abort_transaction'
    2532 |                                 btrfs_abort_transaction(trans, ret);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug344' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:2532:33: note: in expansion of macro 'btrfs_abort_transaction'
    2532 |                                 btrfs_abort_transaction(trans, ret);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/relocation.c: In function 'delete_orphan_inode':
   include/linux/dynamic_debug.h:213:28: error: 'struct _ddebug' has no member named 'flags'
     213 |         unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
         |                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dynamic_debug.h:240:13: note: in expansion of macro 'DYNAMIC_DEBUG_BRANCH'
     240 |         if (DYNAMIC_DEBUG_BRANCH(id))                                   \
         |             ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:3868:17: note: in expansion of macro 'btrfs_abort_transaction'
    3868 |                 btrfs_abort_transaction(trans, ret);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:180:45: warning: variable '__UNIQUE_ID_ddebug353' set but not used [-Wunused-but-set-variable]
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/dynamic_debug.h:173:31: note: in definition of macro 'DEFINE_DYNAMIC_DEBUG_METADATA_CLS'
     173 |         __section("__dyndbg") name = {                          \
         |                               ^~~~
   include/linux/dynamic_debug.h:266:9: note: in expansion of macro '__dynamic_func_call_cls_no_desc'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:29: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:75:22: note: in expansion of macro '___PASTE'
      75 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:180:37: note: in expansion of macro '__PASTE'
     180 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/dynamic_debug.h:266:41: note: in expansion of macro '__UNIQUE_ID'
     266 |         __dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,  \
         |                                         ^~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call_cls_no_desc'
     269 |         _dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,        \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/messages.h:110:9: note: in expansion of macro '_dynamic_func_call_no_desc'
     110 |         _dynamic_func_call_no_desc(fmt, btrfs_printk,                   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/transaction.h:222:25: note: in expansion of macro 'btrfs_debug'
     222 |                         btrfs_debug((trans)->fs_info,                   \
         |                         ^~~~~~~~~~~
   fs/btrfs/relocation.c:3868:17: note: in expansion of macro 'btrfs_abort_transaction'
    3868 |                 btrfs_abort_transaction(trans, ret);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
..


vim +/descriptor +6248 mm/page_alloc.c

e95d372c4cd46b6 Kefeng Wang     2023-05-16  6243  
8df995f6bde01de Alexandre Ghiti 2019-05-13  6244  #ifdef CONFIG_CONTIG_ALLOC
a1394bddf9b60e9 Minchan Kim     2021-04-29  6245  /* Usage: See admin-guide/dynamic-debug-howto.rst */
a1394bddf9b60e9 Minchan Kim     2021-04-29  6246  static void alloc_contig_dump_pages(struct list_head *page_list)
a1394bddf9b60e9 Minchan Kim     2021-04-29  6247  {
a1394bddf9b60e9 Minchan Kim     2021-04-29 @6248  	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, "migrate failure");
a1394bddf9b60e9 Minchan Kim     2021-04-29  6249  
a1394bddf9b60e9 Minchan Kim     2021-04-29 @6250  	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
a1394bddf9b60e9 Minchan Kim     2021-04-29  6251  		struct page *page;
a1394bddf9b60e9 Minchan Kim     2021-04-29  6252  
a1394bddf9b60e9 Minchan Kim     2021-04-29  6253  		dump_stack();
a1394bddf9b60e9 Minchan Kim     2021-04-29  6254  		list_for_each_entry(page, page_list, lru)
a1394bddf9b60e9 Minchan Kim     2021-04-29  6255  			dump_page(page, "migration failure");
a1394bddf9b60e9 Minchan Kim     2021-04-29  6256  	}
a1394bddf9b60e9 Minchan Kim     2021-04-29  6257  }
a1394bddf9b60e9 Minchan Kim     2021-04-29  6258  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
