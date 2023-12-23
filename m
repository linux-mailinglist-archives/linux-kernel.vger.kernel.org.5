Return-Path: <linux-kernel+bounces-10147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60FB81D0BA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744491F22C00
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121463D;
	Sat, 23 Dec 2023 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbcbG1E7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F32377
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703290441; x=1734826441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NrMzLPA3hbarJ9Ylrq6L+LPDRbGxSNdOoiG9UAD95qM=;
  b=AbcbG1E7rxL/klcSh8bStyZPrN+BbMl6BjCpWfnekFj/abVnk+zK/CkX
   UjEYeVyFwQT65hiVU9ucpj/mRFeNOcjzn3fp15XlGMeDXgZHOrulDZCqI
   ggy/4Zn5F2+LpueD6pxE9NmnY3XknZuuSmJULa8dID2FFEjWmUSLyNwlf
   nyRLYM60wySVBfnOjXzh1+phCQ4qoREqMqjkL9vkyq41B0koLnbobZVn6
   mBWMtPdXsSVRthKZcOW+YxQNtTRueGahhiLnXWvVUCvZmIWY++4qJre//
   Yz4gLXKKLRFUstBThLI5E2TZJt0iTrldTy6EANOoF5wvXUbPA/wSppyN7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="17740250"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="17740250"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:14:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="920821666"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="920821666"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2023 16:13:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGpcd-000A1l-1w;
	Sat, 23 Dec 2023 00:12:20 +0000
Date: Sat, 23 Dec 2023 08:11:35 +0800
From: kernel test robot <lkp@intel.com>
To: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Zeng Heng <zengheng4@huawei.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/osq_lock: Minimize access to node->prev's
 cacheline
Message-ID: <202312230806.Vokn7Nz3-lkp@intel.com>
References: <20231221011953.1611615-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221011953.1611615-1-longman@redhat.com>

Hi Waiman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/master arm-perf/for-next/perf tip/auto-latest linus/master v6.7-rc6 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/locking-osq_lock-Minimize-access-to-node-prev-s-cacheline/20231222-165756
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20231221011953.1611615-1-longman%40redhat.com
patch subject: [PATCH] locking/osq_lock: Minimize access to node->prev's cacheline
config: arc-defconfig (https://download.01.org/0day-ci/archive/20231223/202312230806.Vokn7Nz3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230806.Vokn7Nz3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230806.Vokn7Nz3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/locking/osq_lock.c: In function 'osq_lock':
>> kernel/locking/osq_lock.c:112:18: warning: variable 'pvcpu' set but not used [-Wunused-but-set-variable]
     112 |         int old, pvcpu;
         |                  ^~~~~


vim +/pvcpu +112 kernel/locking/osq_lock.c

   106	
   107	bool osq_lock(struct optimistic_spin_queue *lock)
   108	{
   109		struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
   110		struct optimistic_spin_node *prev, *next;
   111		int curr = encode_cpu(smp_processor_id());
 > 112		int old, pvcpu;
   113	
   114		node->locked = 0;
   115		node->next = NULL;
   116		node->cpu = curr;
   117	
   118		/*
   119		 * We need both ACQUIRE (pairs with corresponding RELEASE in
   120		 * unlock() uncontended, or fastpath) and RELEASE (to publish
   121		 * the node fields we just initialised) semantics when updating
   122		 * the lock tail.
   123		 */
   124		old = atomic_xchg(&lock->tail, curr);
   125		if (old == OSQ_UNLOCKED_VAL)
   126			return true;
   127	
   128		prev = decode_cpu(old);
   129		node->prev = prev;
   130		pvcpu = node_cpu(prev);
   131	
   132		/*
   133		 * osq_lock()			unqueue
   134		 *
   135		 * node->prev = prev		osq_wait_next()
   136		 * WMB				MB
   137		 * prev->next = node		next->prev = prev // unqueue-C
   138		 *
   139		 * Here 'node->prev' and 'next->prev' are the same variable and we need
   140		 * to ensure these stores happen in-order to avoid corrupting the list.
   141		 */
   142		smp_wmb();
   143	
   144		WRITE_ONCE(prev->next, node);
   145	
   146		/*
   147		 * Normally @prev is untouchable after the above store; because at that
   148		 * moment unlock can proceed and wipe the node element from stack.
   149		 *
   150		 * However, since our nodes are static per-cpu storage, we're
   151		 * guaranteed their existence -- this allows us to apply
   152		 * cmpxchg in an attempt to undo our queueing.
   153		 */
   154	
   155		/*
   156		 * Wait to acquire the lock or cancellation. Note that need_resched()
   157		 * will come with an IPI, which will wake smp_cond_load_relaxed() if it
   158		 * is implemented with a monitor-wait. vcpu_is_preempted() relies on
   159		 * polling, be careful.
   160		 */
   161		if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
   162					  prev_vcpu_is_preempted(node, &prev, &pvcpu)))
   163			return true;
   164	
   165		/* unqueue */
   166		/*
   167		 * Step - A  -- stabilize @prev
   168		 *
   169		 * Undo our @prev->next assignment; this will make @prev's
   170		 * unlock()/unqueue() wait for a next pointer since @lock points to us
   171		 * (or later).
   172		 */
   173	
   174		for (;;) {
   175			/*
   176			 * cpu_relax() below implies a compiler barrier which would
   177			 * prevent this comparison being optimized away.
   178			 */
   179			if (data_race(prev->next) == node &&
   180			    cmpxchg(&prev->next, node, NULL) == node)
   181				break;
   182	
   183			/*
   184			 * We can only fail the cmpxchg() racing against an unlock(),
   185			 * in which case we should observe @node->locked becoming
   186			 * true.
   187			 */
   188			if (smp_load_acquire(&node->locked))
   189				return true;
   190	
   191			cpu_relax();
   192	
   193			/*
   194			 * Or we race against a concurrent unqueue()'s step-B, in which
   195			 * case its step-C will write us a new @node->prev pointer.
   196			 */
   197			prev = READ_ONCE(node->prev);
   198		}
   199	
   200		/*
   201		 * Step - B -- stabilize @next
   202		 *
   203		 * Similar to unlock(), wait for @node->next or move @lock from @node
   204		 * back to @prev.
   205		 */
   206	
   207		next = osq_wait_next(lock, node, prev);
   208		if (!next)
   209			return false;
   210	
   211		/*
   212		 * Step - C -- unlink
   213		 *
   214		 * @prev is stable because its still waiting for a new @prev->next
   215		 * pointer, @next is stable because our @node->next pointer is NULL and
   216		 * it will wait in Step-A.
   217		 */
   218	
   219		WRITE_ONCE(next->prev, prev);
   220		WRITE_ONCE(prev->next, next);
   221	
   222		return false;
   223	}
   224	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

