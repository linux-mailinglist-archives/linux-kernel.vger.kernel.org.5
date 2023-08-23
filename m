Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE667857CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjHWMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjHWMUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:20:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68EE9;
        Wed, 23 Aug 2023 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692793198; x=1724329198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=58i9UZ4uOkfxY9He9AhTZG1ivpLYgdX1oN+5EKz0+3g=;
  b=ScHqs3GDvi57xsRiYNKKswskR2ZIZ8pIUK9FV4meVjTWbpZ+nXb8ql+q
   7Bxp+U9hBeGFAopfMQwuunJl4t64QMNWsfT76YNd4Whiky48EmMEjw9wU
   nxMBWCmZ4piUkZ8ZVOIknFWyIL9fE1GDoKhhBgEA2eke78/o8ZoMgj39e
   Z7wRvyidrmi7SZ0XBBoLcj55cm0dZ8XSfZw6RgrN6g9XfJL1YgvitjFFs
   kt/FffbQPUAldCPOhrhnoQnbMSe7aElYSJz68dQoVys6py2cvF+TUzCU/
   /coW+2aAnprjAwpoYEgPM6x3o3azhrIsr0MJ5eUjdJ4Sbr5xcWOI2AokE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="438081774"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438081774"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 05:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="802086805"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802086805"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2023 05:19:55 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYmq3-0001BO-0G;
        Wed, 23 Aug 2023 12:19:55 +0000
Date:   Wed, 23 Aug 2023 20:18:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix to avoid wakeup loop in splice read of
 per-cpu buffer
Message-ID: <202308232056.401OxapL-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc7 next-20230823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Fix-to-avoid-wakeup-loop-in-splice-read-of-per-cpu-buffer/20230821-222307
base:   linus/master
patch link:    https://lore.kernel.org/r/169262755804.106231.8245792908363050528.stgit%40devnote2
patch subject: [PATCH] tracing: Fix to avoid wakeup loop in splice read of per-cpu buffer
config: mips-randconfig-r131-20230823 (https://download.01.org/0day-ci/archive/20230823/202308232056.401OxapL-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308232056.401OxapL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308232056.401OxapL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/trace.c:446:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:446:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:446:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:460:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:460:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:460:33: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:2959:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2959:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2959:38: sparse:     got struct event_filter [noderef] __rcu *filter
>> kernel/trace/trace.c:8481:25: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> kernel/trace/trace.c:8481:25: sparse:    unsigned int *
>> kernel/trace/trace.c:8481:25: sparse:    unsigned long long [usertype] *
   kernel/trace/trace.c:400:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:400:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:400:9: sparse:    struct trace_export *
   kernel/trace/trace.c:415:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:415:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:415:9: sparse:    struct trace_export *
>> kernel/trace/trace.c:8481:25: sparse: sparse: shift too big (32) for type unsigned int

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
