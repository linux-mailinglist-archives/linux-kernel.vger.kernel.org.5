Return-Path: <linux-kernel+bounces-96873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5E876276
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9383AB2188D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B553E3F;
	Fri,  8 Mar 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehSVVw7E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C695577A;
	Fri,  8 Mar 2024 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895298; cv=none; b=TzdYEvabWUhewvgEbMcBbUvHk/rVB/8qO/cLNHMDii8Rn0fvPjonmPMaOHT/liwMJNNZPnz1ArnXamHEAEv4m1xBRot08g/c6oBeRysqwVcEBcg5XY8B/+z70vCNo72AXyXLPl2iGAt6rv/W3IvQva+wmEKSSuWzDkEuU6mUV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895298; c=relaxed/simple;
	bh=j1ynKLY5env5mTcwYEWX+LZc3E3rIOPqHmFvLqb/PaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg08aZobJC46cZpyLnuCGSzo7+/F7t+IRuc3ZNJOiewPxgPr3NNl39QsBeG3VajvLbmyjHbKOB5Qcd7QpvWCowPVJg4VYCDHsAj3ne6YzAQdv8Dof0Cup7qLlwaPafaG7r7UhbzcoFcKEc8K263+Bg0bq3U1zOLzxkh+VD5mqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehSVVw7E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709895296; x=1741431296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1ynKLY5env5mTcwYEWX+LZc3E3rIOPqHmFvLqb/PaU=;
  b=ehSVVw7EHKj0v6ZB3CRzz4WD1UukwsB1kk5VFEEymqOetHqsAemeJ+nt
   K6fDaaWmM9TB0Dll1n24OsM4oQwU4s3dx3oyizeyyuAvZfJ8OYmymgEY5
   evl2+k9JDde//sC0CDoE/9Fcq3Wc7OxJNO5kUfOQLW8Hih52RPx/6OIBj
   J9eO66i2DcSBilEAgJGvPKdYV4nxJX8GX/wqMpZHU/UBNehnTBYmm6yMM
   uLEGWXtp901UAjU+O5Re/eU53wfy+Jf8six+eOaDDR4CH33BlF3dFMuQt
   9km+BwqZq8hjXYnfargV05/vBD2ZV0mdjBm/FdM0OiKR1oKaaFb2FfeMn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4479459"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4479459"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10874781"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Mar 2024 02:54:49 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riXsD-0006JH-1g;
	Fri, 08 Mar 2024 10:54:45 +0000
Date: Fri, 8 Mar 2024 18:54:22 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, suleiman@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Youssef Esmat <youssefesmat@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 5/8] ring-buffer: Add ring_buffer_meta data
Message-ID: <202403081843.QYKJKYk4-lkp@intel.com>
References: <20240306020006.100449500@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306020006.100449500@goodmis.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240305]
[cannot apply to tip/x86/core akpm-mm/mm-everything linus/master v6.8-rc7 v6.8-rc6 v6.8-rc5 v6.8-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ring-buffer-Allow-mapped-field-to-be-set-without-mapping/20240306-100047
base:   next-20240305
patch link:    https://lore.kernel.org/r/20240306020006.100449500%40goodmis.org
patch subject: [PATCH 5/8] ring-buffer: Add ring_buffer_meta data
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240308/202403081843.QYKJKYk4-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 503c55e17037436dcd45ac69dea8967e67e3f5e8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240308/202403081843.QYKJKYk4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403081843.QYKJKYk4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/trace/ring_buffer.c:8:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/ring_buffer.c:8:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   In file included from include/linux/security.h:35:
   include/linux/bpf.h:736:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     736 |         ARG_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | ARG_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:737:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     737 |         ARG_PTR_TO_MEM_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:738:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     738 |         ARG_PTR_TO_CTX_OR_NULL          = PTR_MAYBE_NULL | ARG_PTR_TO_CTX,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:739:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     739 |         ARG_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:740:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     740 |         ARG_PTR_TO_STACK_OR_NULL        = PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:741:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     741 |         ARG_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:745:38: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     745 |         ARG_PTR_TO_UNINIT_MEM           = MEM_UNINIT | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:747:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_arg_type') [-Wenum-enum-conversion]
     747 |         ARG_PTR_TO_FIXED_SIZE_MEM       = MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:770:48: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     770 |         RET_PTR_TO_MAP_VALUE_OR_NULL    = PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:771:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     771 |         RET_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:772:47: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     772 |         RET_PTR_TO_TCP_SOCK_OR_NULL     = PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:773:50: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     773 |         RET_PTR_TO_SOCK_COMMON_OR_NULL  = PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:775:49: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     775 |         RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_MEM,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   include/linux/bpf.h:776:45: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     776 |         RET_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:777:43: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_return_type') [-Wenum-enum-conversion]
     777 |         RET_PTR_TO_BTF_ID_TRUSTED       = PTR_TRUSTED    | RET_PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~    ^ ~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:888:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     888 |         PTR_TO_MAP_VALUE_OR_NULL        = PTR_MAYBE_NULL | PTR_TO_MAP_VALUE,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~
   include/linux/bpf.h:889:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     889 |         PTR_TO_SOCKET_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_SOCKET,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   include/linux/bpf.h:890:46: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     890 |         PTR_TO_SOCK_COMMON_OR_NULL      = PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:891:44: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     891 |         PTR_TO_TCP_SOCK_OR_NULL         = PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~
   include/linux/bpf.h:892:42: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
     892 |         PTR_TO_BTF_ID_OR_NULL           = PTR_MAYBE_NULL | PTR_TO_BTF_ID,
         |                                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>> kernel/trace/ring_buffer.c:3224:24: error: incompatible pointer to integer conversion assigning to 'unsigned long' from 'struct buffer_data_page *' [-Wint-conversion]
    3224 |                         meta->commit_buffer = cpu_buffer->commit_page->page;
         |                                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   25 warnings and 1 error generated.


vim +3224 kernel/trace/ring_buffer.c

  3192	
  3193	static __always_inline void
  3194	rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
  3195	{
  3196		unsigned long max_count;
  3197	
  3198		/*
  3199		 * We only race with interrupts and NMIs on this CPU.
  3200		 * If we own the commit event, then we can commit
  3201		 * all others that interrupted us, since the interruptions
  3202		 * are in stack format (they finish before they come
  3203		 * back to us). This allows us to do a simple loop to
  3204		 * assign the commit to the tail.
  3205		 */
  3206	 again:
  3207		max_count = cpu_buffer->nr_pages * 100;
  3208	
  3209		while (cpu_buffer->commit_page != READ_ONCE(cpu_buffer->tail_page)) {
  3210			if (RB_WARN_ON(cpu_buffer, !(--max_count)))
  3211				return;
  3212			if (RB_WARN_ON(cpu_buffer,
  3213				       rb_is_reader_page(cpu_buffer->tail_page)))
  3214				return;
  3215			/*
  3216			 * No need for a memory barrier here, as the update
  3217			 * of the tail_page did it for this page.
  3218			 */
  3219			local_set(&cpu_buffer->commit_page->page->commit,
  3220				  rb_page_write(cpu_buffer->commit_page));
  3221			rb_inc_page(&cpu_buffer->commit_page);
  3222			if (cpu_buffer->ring_meta) {
  3223				struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
> 3224				meta->commit_buffer = cpu_buffer->commit_page->page;
  3225			}
  3226			/* add barrier to keep gcc from optimizing too much */
  3227			barrier();
  3228		}
  3229		while (rb_commit_index(cpu_buffer) !=
  3230		       rb_page_write(cpu_buffer->commit_page)) {
  3231	
  3232			/* Make sure the readers see the content of what is committed. */
  3233			smp_wmb();
  3234			local_set(&cpu_buffer->commit_page->page->commit,
  3235				  rb_page_write(cpu_buffer->commit_page));
  3236			RB_WARN_ON(cpu_buffer,
  3237				   local_read(&cpu_buffer->commit_page->page->commit) &
  3238				   ~RB_WRITE_MASK);
  3239			barrier();
  3240		}
  3241	
  3242		/* again, keep gcc from optimizing */
  3243		barrier();
  3244	
  3245		/*
  3246		 * If an interrupt came in just after the first while loop
  3247		 * and pushed the tail page forward, we will be left with
  3248		 * a dangling commit that will never go forward.
  3249		 */
  3250		if (unlikely(cpu_buffer->commit_page != READ_ONCE(cpu_buffer->tail_page)))
  3251			goto again;
  3252	}
  3253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

