Return-Path: <linux-kernel+bounces-96861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438E876251
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42014283BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF65576B;
	Fri,  8 Mar 2024 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+Cz3GGE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325F53E01;
	Fri,  8 Mar 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894640; cv=none; b=evZNdUShGU2wCxm2BELwVNpelFjO2YHZk8UYS021k3ZID7FUUQUrKje/3RZBobdUbdG2q59wjvG9TGKxi4LuuGjujDabUSrA0KP/dbsofjx9Qx0DhTpO9uKf9DkC3ER3IAJB5845UhqSTDTAUUHLvHNvZaRHTP8xXwV4xtczPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894640; c=relaxed/simple;
	bh=IaAaj7Tsi92YD//SZUxnQaYxfr+Kq1MmRFiJG/TyF0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKfGcpe8rE6d3Cf8Ifir9vBEGyCpiy3ZiaORaFqB48pM78AqL+Rus17kgNtfut9sHLSaFtrdZke26HixZCPDGv/taCjGmyPJYJxmbVRUd8V3S2TFK2CjgBg4sd8ZVpscSj8MPa7uZlRJyedwYzmphxcTCKCi8U4KO7ycj/zsXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+Cz3GGE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709894640; x=1741430640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IaAaj7Tsi92YD//SZUxnQaYxfr+Kq1MmRFiJG/TyF0c=;
  b=W+Cz3GGE0DHUHF1pF9k/zB2pQ88gPgfxnA0MMSZ7Bi5GBCRrBZnAy6IJ
   MSgsheqDKn+yBHUIWbtW9RO4K69dbgEz6o3hRfUqJaKkHrWTbpiQgq3NB
   qvo7aq76vp3eFc/cK1jqMdcvvd1cDJVNjjohgND4c140WJrz0ckmrcHYa
   y4O+KXjXJyOfGP5d1BIYA7jpnRmd0ITO1fpuRotcJp9/2X8tFeEj7kNWP
   smQSG3w9JJeYmowfNsuuZbWtD55FIvJGewq3iuKL7JKd0LN5G0JQ3s4l/
   jycPlnRLef2Dfxzb9eT/n5JLmM7K7XGl/Xk0vQT79G+3MnoWJ2in67B6D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4537008"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4537008"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:43:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10439511"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Mar 2024 02:43:48 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riXhZ-0006Id-0a;
	Fri, 08 Mar 2024 10:43:45 +0000
Date: Fri, 8 Mar 2024 18:42:51 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <202403081831.EWSQPo2a-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240305]
[cannot apply to tip/x86/core akpm-mm/mm-everything linus/master v6.8-rc7 v6.8-rc6 v6.8-rc5 v6.8-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ring-buffer-Allow-mapped-field-to-be-set-without-mapping/20240306-100047
base:   next-20240305
patch link:    https://lore.kernel.org/r/20240306020006.100449500%40goodmis.org
patch subject: [PATCH 5/8] ring-buffer: Add ring_buffer_meta data
config: sh-defconfig (https://download.01.org/0day-ci/archive/20240308/202403081831.EWSQPo2a-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240308/202403081831.EWSQPo2a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403081831.EWSQPo2a-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/ring_buffer.c: In function 'rb_set_commit_to_write':
>> kernel/trace/ring_buffer.c:3224:45: warning: assignment to 'long unsigned int' from 'struct buffer_data_page *' makes integer from pointer without a cast [-Wint-conversion]
    3224 |                         meta->commit_buffer = cpu_buffer->commit_page->page;
         |                                             ^


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

