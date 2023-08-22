Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA3783A38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjHVG5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjHVG5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:57:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1516D1;
        Mon, 21 Aug 2023 23:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692687435; x=1724223435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MMCNSzNyKaRl/6IgFJ7/jUyJusR7tBmhQi9GlVoyxA0=;
  b=CURR/eGp+x4ZlGUysPqNGDlhtlmODHJUy1gXmIq7smoF1ZHKkoqCtn48
   nzESHYnEujTqxp0FVg4Dhydtr6uI3TsGDnPHce3JBZg8Xm9F8qLwTWfwk
   BmbVoEs4K6XhXtKvmwFRVE4v7L+9Y0ae2yjLta+XkOnP1M5p49ofLsmiW
   aiEUQYgEY2phSTQc2+kdU/9NwqQbga6I6mxYgxCfqjq7Z7lFZhOK5jegB
   cK7pHVqZkhKHGlfsXIAi3hzdjy7/RBdaf0fmue7gdQOwWliaLq+gA7ZLi
   orhbjvIwY5lqSPxwqmwM3/05XgQbPRYEp4XaO40zdhOWvsYX43Gax3jkK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437713057"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="437713057"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 23:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="713045190"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="713045190"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2023 23:57:10 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYLJy-0001Tw-1l;
        Tue, 22 Aug 2023 06:57:05 +0000
Date:   Tue, 22 Aug 2023 14:56:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix to avoid wakeup loop in splice read of
 per-cpu buffer
Message-ID: <202308221429.cY9ifC65-lkp@intel.com>
References: <169262755804.106231.8245792908363050528.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169262755804.106231.8245792908363050528.stgit@devnote2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc7 next-20230821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Fix-to-avoid-wakeup-loop-in-splice-read-of-per-cpu-buffer/20230821-222307
base:   linus/master
patch link:    https://lore.kernel.org/r/169262755804.106231.8245792908363050528.stgit%40devnote2
patch subject: [PATCH] tracing: Fix to avoid wakeup loop in splice read of per-cpu buffer
config: arm-randconfig-r004-20230822 (https://download.01.org/0day-ci/archive/20230822/202308221429.cY9ifC65-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221429.cY9ifC65-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221429.cY9ifC65-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> kernel/trace/trace.c:8481:4: warning: comparison of distinct pointer types ('typeof ((full)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
    8481 |                         do_div(full, nr_pages);
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:8481:4: error: incompatible pointer types passing 'size_t *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
    8481 |                         do_div(full, nr_pages);
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   arch/arm/include/asm/div64.h:24:45: note: passing argument to parameter 'n' here
      24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
         |                                             ^
>> kernel/trace/trace.c:8481:4: warning: shift count >= width of type [-Wshift-count-overflow]
    8481 |                         do_div(full, nr_pages);
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   2 warnings and 1 error generated.


vim +8481 kernel/trace/trace.c

  8400	
  8401		if (*ppos & (PAGE_SIZE - 1))
  8402			return -EINVAL;
  8403	
  8404		if (len & (PAGE_SIZE - 1)) {
  8405			if (len < PAGE_SIZE)
  8406				return -EINVAL;
  8407			len &= PAGE_MASK;
  8408		}
  8409	
  8410		if (splice_grow_spd(pipe, &spd))
  8411			return -ENOMEM;
  8412	
  8413	 again:
  8414		trace_access_lock(iter->cpu_file);
  8415		entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
  8416	
  8417		for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= PAGE_SIZE) {
  8418			struct page *page;
  8419			int r;
  8420	
  8421			ref = kzalloc(sizeof(*ref), GFP_KERNEL);
  8422			if (!ref) {
  8423				ret = -ENOMEM;
  8424				break;
  8425			}
  8426	
  8427			refcount_set(&ref->refcount, 1);
  8428			ref->buffer = iter->array_buffer->buffer;
  8429			ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
  8430			if (IS_ERR(ref->page)) {
  8431				ret = PTR_ERR(ref->page);
  8432				ref->page = NULL;
  8433				kfree(ref);
  8434				break;
  8435			}
  8436			ref->cpu = iter->cpu_file;
  8437	
  8438			r = ring_buffer_read_page(ref->buffer, &ref->page,
  8439						  len, iter->cpu_file, 1);
  8440			if (r < 0) {
  8441				ring_buffer_free_read_page(ref->buffer, ref->cpu,
  8442							   ref->page);
  8443				kfree(ref);
  8444				break;
  8445			}
  8446	
  8447			page = virt_to_page(ref->page);
  8448	
  8449			spd.pages[i] = page;
  8450			spd.partial[i].len = PAGE_SIZE;
  8451			spd.partial[i].offset = 0;
  8452			spd.partial[i].private = (unsigned long)ref;
  8453			spd.nr_pages++;
  8454			*ppos += PAGE_SIZE;
  8455	
  8456			entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
  8457		}
  8458	
  8459		trace_access_unlock(iter->cpu_file);
  8460		spd.nr_pages = i;
  8461	
  8462		/* did we read anything? */
  8463		if (!spd.nr_pages) {
  8464			long wait_index;
  8465			size_t nr_pages;
  8466			size_t full;
  8467	
  8468			if (ret)
  8469				goto out;
  8470	
  8471			ret = -EAGAIN;
  8472			if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
  8473				goto out;
  8474	
  8475			wait_index = READ_ONCE(iter->wait_index);
  8476	
  8477			/* For splice, we have to ensure at least 1 page is filled */
  8478			nr_pages = ring_buffer_nr_pages(iter->array_buffer->buffer, iter->cpu_file);
  8479			if (nr_pages * iter->tr->buffer_percent < 100) {
  8480				full = nr_pages + 99;
> 8481				do_div(full, nr_pages);
  8482			} else
  8483				full = iter->tr->buffer_percent;
  8484	
  8485			ret = wait_on_pipe(iter, full);
  8486			if (ret)
  8487				goto out;
  8488	
  8489			/* No need to wait after waking up when tracing is off */
  8490			if (!tracer_tracing_is_on(iter->tr))
  8491				goto out;
  8492	
  8493			/* Make sure we see the new wait_index */
  8494			smp_rmb();
  8495			if (wait_index != iter->wait_index)
  8496				goto out;
  8497	
  8498			goto again;
  8499		}
  8500	
  8501		ret = splice_to_pipe(pipe, &spd);
  8502	out:
  8503		splice_shrink_spd(&spd);
  8504	
  8505		return ret;
  8506	}
  8507	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
