Return-Path: <linux-kernel+bounces-165168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0F28B88E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D3D1F24A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3057304;
	Wed,  1 May 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGyiA7wo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402755E74
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561690; cv=none; b=mQJP9WGC06HF+NS8h3fES/+DUeRe0kG5O2aw8t6yznKg1zCNIMVpjAT8ECVMFBJACWUxdzJuZn3UKJQhLCBDgMh1anqWyttpzQDHkJfUs5s2/Bbw7tCGK1vLkmAPGki2I1bXAchdN6y0ZPjwU60DZ1o5eAa+NfHuOQQGvekG4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561690; c=relaxed/simple;
	bh=oSHcnyMAhNUtD+692xdwPmctpOh6QYODsHbccexhZm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dg22E8RBS1JPdY4qU8kZfe+KMcU62If8alYuBhxjLf0inw15Xbr6bpmlk/1kjpYlrwZyzIRtFHd/fYlaEFR1u1GiLEz5d/++tjlgmV2Sn8RYb4RvGK2bj6uoiRRtY80zD63+Vb+VlqLzASsN7cODKzEYGDj4PyILf2x/NYJRTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGyiA7wo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714561688; x=1746097688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oSHcnyMAhNUtD+692xdwPmctpOh6QYODsHbccexhZm0=;
  b=kGyiA7woOclB1QTsAaEnXcWC/ayEbdmCmQRImrzkT3cTmGuymNa9lSdO
   B4QWk+a3YTEBWWxWhkPvjTexlHKVBb3s84UqAZ0ExiMGlp9frU02LUmZr
   ByCc6gwvUqQK7KSuNvIjwbmBK6CjybkZmqum7TPfIn2vR5skWX3Vc5aVh
   rBcSqRtAcmpM1x6CnyDEZWtVB2i4MiTs7ITRwnLN8Ckr/Ia4J1lvT5XPB
   KPqJxntke2lMkQwTDFo2BrE8BPde5xnLhqzUl4tIfMeT7WFtSrkjZY2Kc
   T/AAQvM5ULowRlDjMJ6V7RUCOHgxzD68UhGN3Vb8+EHK0+sdsq3nz1S/r
   w==;
X-CSE-ConnectionGUID: kwTDDPvnSIarIYmcQgGhTw==
X-CSE-MsgGUID: wfI9bS5dRUmA57QEd96sJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10136797"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="10136797"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 04:08:07 -0700
X-CSE-ConnectionGUID: dudeG1UFR6qWMGLxw8PdEQ==
X-CSE-MsgGUID: YCwb/iILTKuubR8p0zC1LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="57647951"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 01 May 2024 04:08:06 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s27oh-0009Sq-1W;
	Wed, 01 May 2024 11:08:03 +0000
Date: Wed, 1 May 2024 19:07:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.04.18a 34/34]
 arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned
 int' from 'struct request *' makes integer from pointer without a cast
Message-ID: <202405011801.nWVMOtGS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.18a
head:   274af360588db0dafe36ffb5c61799fa77757ce7
commit: 274af360588db0dafe36ffb5c61799fa77757ce7 [34/34] fixup! xtensa: Emulate one-byte cmpxchg
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240501/202405011801.nWVMOtGS-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405011801.nWVMOtGS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405011801.nWVMOtGS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from block/blk-mq.c:8:
   block/blk-mq.c: In function 'blk_mq_clear_rq_mapping':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct request *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   block/blk-mq.c:3237:33: note: in expansion of macro 'cmpxchg'
    3237 |                                 cmpxchg(&drv_tags->rqs[i], rq, NULL);
         |                                 ^~~~~~~
   block/blk-mq.c: In function 'blk_mq_clear_flush_rq_mapping':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct request *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   block/blk-mq.c:3602:17: note: in expansion of macro 'cmpxchg'
    3602 |                 cmpxchg(&tags->rqs[i], flush_rq, NULL);
         |                 ^~~~~~~
--
   In file included from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from fs/super.c:25:
   fs/super.c: In function 'sb_init_dio_done_wq':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct workqueue_struct *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   fs/super.c:2222:15: note: in expansion of macro 'cmpxchg'
    2222 |         old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
         |               ^~~~~~~
--
   In file included from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from fs/libfs.c:7:
   fs/libfs.c: In function 'stash_dentry':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct dentry *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   fs/libfs.c:2054:23: note: in expansion of macro 'cmpxchg'
    2054 |                 old = cmpxchg(stashed, NULL, dentry);
         |                       ^~~~~~~
   In file included from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from include/linux/fs.h:5:
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct dentry *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   fs/libfs.c:2063:28: note: in expansion of macro 'try_cmpxchg'
    2063 |                 if (likely(try_cmpxchg(stashed, &old, dentry)))
         |                            ^~~~~~~~~~~
   fs/libfs.c: In function 'stashed_dentry_prune':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct dentry *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   fs/libfs.c:2131:9: note: in expansion of macro 'cmpxchg'
    2131 |         cmpxchg(stashed, dentry, NULL);
         |         ^~~~~~~
--
   In file included from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from fs/eventpoll.c:10:
   fs/eventpoll.c: In function 'list_add_tail_lockless':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct list_head *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   fs/eventpoll.c:1206:14: note: in expansion of macro 'try_cmpxchg'
    1206 |         if (!try_cmpxchg(&new->next, &new, head))
         |              ^~~~~~~~~~~
   fs/eventpoll.c: In function 'chain_epi_lockless':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct epitem *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   fs/eventpoll.c:1245:13: note: in expansion of macro 'cmpxchg'
    1245 |         if (cmpxchg(&epi->next, EP_UNACTIVE_PTR, NULL) != EP_UNACTIVE_PTR)
         |             ^~~~~~~
--
   In file included from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/fdtable.h:11,
                    from fs/locks.c:53:
   fs/locks.c: In function 'locks_get_lock_context':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct file_lock_context *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   fs/locks.c:199:13: note: in expansion of macro 'cmpxchg'
     199 |         if (cmpxchg(&inode->i_flctx, NULL, ctx)) {
         |             ^~~~~~~
--
   In file included from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from kernel/task_work.c:2:
   kernel/task_work.c: In function 'task_work_add':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct callback_head *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   kernel/task_work.c:55:19: note: in expansion of macro 'try_cmpxchg'
      55 |         } while (!try_cmpxchg(&task->task_works, &head, work));
         |                   ^~~~~~~~~~~
   kernel/task_work.c: In function 'task_work_cancel_match':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct callback_head *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   kernel/task_work.c:109:28: note: in expansion of macro 'try_cmpxchg'
     109 |                 } else if (try_cmpxchg(pprev, &work, work->next))
         |                            ^~~~~~~~~~~
   kernel/task_work.c: In function 'task_work_run':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct callback_head *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   kernel/task_work.c:166:27: note: in expansion of macro 'try_cmpxchg'
     166 |                 } while (!try_cmpxchg(&task->task_works, &work, head));
         |                           ^~~~~~~~~~~
--
   In file included from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from lib/llist.c:13:
   lib/llist.c: In function 'llist_add_batch':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct llist_node *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   lib/llist.c:33:19: note: in expansion of macro 'try_cmpxchg'
      33 |         } while (!try_cmpxchg(&head->first, &first, new_first));
         |                   ^~~~~~~~~~~
   lib/llist.c: In function 'llist_del_first':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct llist_node *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   lib/llist.c:62:19: note: in expansion of macro 'try_cmpxchg'
      62 |         } while (!try_cmpxchg(&head->first, &entry, next));
         |                   ^~~~~~~~~~~
   lib/llist.c: In function 'llist_del_first_this':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct llist_node *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   lib/llist.c:90:19: note: in expansion of macro 'try_cmpxchg'
      90 |         } while (!try_cmpxchg(&head->first, &entry, next));
         |                   ^~~~~~~~~~~
.


vim +74 arch/arc/include/asm/cmpxchg.h

    63	
    64	#define arch_cmpxchg(ptr, old, new)				        \
    65	({									\
    66		volatile __typeof__(ptr) _p_ = (ptr);				\
    67		__typeof__(*(ptr)) _o_ = (old);					\
    68		__typeof__(*(ptr)) _n_ = (new);					\
    69		__typeof__(*(ptr)) _prev_;					\
    70		unsigned long __flags;						\
    71										\
    72		switch(sizeof((_p_))) {						\
    73		case 1:								\
  > 74			__flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
    75			_prev_ = (__typeof__(*(ptr)))__flags;			\
    76			break;							\
    77			break;							\
    78		case 4:								\
    79			/*							\
    80			 * spin lock/unlock provide the needed smp_mb()		\
    81			 * before/after						\
    82			 */							\
    83			atomic_ops_lock(__flags);				\
    84			_prev_ = *_p_;						\
    85			if (_prev_ == _o_)					\
    86				*_p_ = _n_;					\
    87			atomic_ops_unlock(__flags);				\
    88			break;							\
    89		default:							\
    90			BUILD_BUG();						\
    91		}								\
    92										\
    93		_prev_;								\
    94	})
    95	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

