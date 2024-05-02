Return-Path: <linux-kernel+bounces-165957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC6B8B93C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD07A1C20EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2581BDDB;
	Thu,  2 May 2024 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKWmVjQG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2A1865A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622601; cv=none; b=dGVQIUI7H9KRenYHBK1pjh6Ttox7iMqfwDUHbqAwuHPCYgvBA3Lf/l7J8KC0xohAnTgTCfZ/ZPKBV90gXNIblrOCsePuAqwsMkqoKUkZvfzgYlGkc7RjRgmIfyWx0L72I8kH7Uo9NIFUQt0NWFrQOWUSEniJusXUx7mgqUJGZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622601; c=relaxed/simple;
	bh=DJ/uAH8SydFD3/HgsmNr0ujarGup1hsbT2Xgl78xkvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JAkW6c/CFR7M9NrUZnKCkTpiYa4eZ5QbmmoUdZqo11mndTDSrdHFn+wV2uLxOTyolQvdYnrg/ex3+ZbiJScgHCdlGE6ugfC3+OOnYc7J2sqRL3xcF/r5vKFLj7kJnPMNk73O+VcRJvYq++BZR3u0dvbZcD+xEl/JNGU3xtk5L9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKWmVjQG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714622600; x=1746158600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DJ/uAH8SydFD3/HgsmNr0ujarGup1hsbT2Xgl78xkvU=;
  b=mKWmVjQGicbczaQJHYxwwqCKWfICi1BmHCgRIU8gCfSePxbPl9HF7GJE
   j4Rgjk19x3Q6o1+QZ+2m8keoiagTSaD3jFsNnmvICP1YNkavcGZKJcgUI
   FuxZ8/Buoovu5Tx6V161XBYd1TVzmyYLfqO0G5pSEXaxSRnSd1veFBQZD
   aqYHYh4q2Tz84FSJRhtgm4rMKPSIheP5LiSfRm+mJxjIfKZj4TmCseKrW
   JLBE0prGGOIbynPt0E18Czi1DNSegf9Ooc3OwgFEJn7ZOHEWQfrm2bC7v
   9lCYfxgz7R2+GExd/mKjtkxxuUjvzxyGAUlbRUCrNokTJxwqlbhl3yQom
   g==;
X-CSE-ConnectionGUID: BDcmI1OASNWzfWm4I4t2kA==
X-CSE-MsgGUID: mpCy7mbyTv2YHZY7YCbLPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="21062578"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21062578"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 21:03:19 -0700
X-CSE-ConnectionGUID: Y9kLkyNbRYyfR1TEkdTwQQ==
X-CSE-MsgGUID: sL/Mx3BvRtG92zp9tC3gPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="64437361"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 May 2024 21:03:18 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2Nf8-000ANI-23;
	Thu, 02 May 2024 04:03:14 +0000
Date: Thu, 2 May 2024 12:02:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.04.18a 34/34]
 arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned
 int' from 'struct fs_pin *' makes integer from pointer without a cast
Message-ID: <202405021142.NAwlap1u-lkp@intel.com>
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
config: arc-randconfig-001-20240502 (https://download.01.org/0day-ci/archive/20240502/202405021142.NAwlap1u-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240502/202405021142.NAwlap1u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405021142.NAwlap1u-lkp@intel.com/

All warnings (new ones prefixed by >>):

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
                    from include/linux/mm.h:7,
                    from kernel/acct.c:47:
   kernel/acct.c: In function 'acct_pin_kill':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct fs_pin *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   kernel/acct.c:196:9: note: in expansion of macro 'cmpxchg'
     196 |         cmpxchg(&acct->ns->bacct, pin, NULL);
         |         ^~~~~~~
--
   In file included from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/linux/page_counter.h:5,
                    from mm/memcontrol.c:28:
   mm/memcontrol.c: In function 'mem_cgroup_iter':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   mm/memcontrol.c:1200:31: note: in expansion of macro 'cmpxchg'
    1200 |                         (void)cmpxchg(&iter->position, pos, NULL);
         |                               ^~~~~~~
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   mm/memcontrol.c:1240:23: note: in expansion of macro 'cmpxchg'
    1240 |                 (void)cmpxchg(&iter->position, pos, memcg);
         |                       ^~~~~~~
   mm/memcontrol.c: In function '__invalidate_reclaim_iterators':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   mm/memcontrol.c:1281:17: note: in expansion of macro 'cmpxchg'
    1281 |                 cmpxchg(&iter->position, dead_memcg, NULL);
         |                 ^~~~~~~
   mm/memcontrol.c: In function 'current_objcg_update':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct obj_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
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
   mm/memcontrol.c:3184:19: note: in expansion of macro 'try_cmpxchg'
    3184 |         } while (!try_cmpxchg(&current->objcg, &old, objcg));
         |                   ^~~~~~~~~~~
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
                    from include/linux/mm.h:7,
                    from mm/page_io.c:14:
   mm/page_io.c: In function 'sio_pool_init':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'mempool_t *' {aka 'struct mempool_s *'} makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   mm/page_io.c:256:21: note: in expansion of macro 'cmpxchg'
     256 |                 if (cmpxchg(&sio_pool, NULL, pool))
         |                     ^~~~~~~
--
   In file included from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from fs/posix_acl.c:14:
   fs/posix_acl.c: In function '__get_acl':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct posix_acl *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   fs/posix_acl.c:146:9: note: in expansion of macro 'cmpxchg'
     146 |         cmpxchg(p, ACL_NOT_CACHED, sentinel);
         |         ^~~~~~~
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct posix_acl *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   fs/posix_acl.c:169:17: note: in expansion of macro 'cmpxchg'
     169 |                 cmpxchg(p, sentinel, ACL_NOT_CACHED);
         |                 ^~~~~~~
   In file included from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16:
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct posix_acl *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
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
   fs/posix_acl.c:177:23: note: in expansion of macro 'try_cmpxchg'
     177 |         if (unlikely(!try_cmpxchg(p, &sentinel, acl)))
         |                       ^~~~~~~~~~~
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
                    from drivers/accessibility/speakup/selection.c:2:
   drivers/accessibility/speakup/selection.c: In function 'speakup_set_selection':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct tty_struct *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   drivers/accessibility/speakup/selection.c:71:13: note: in expansion of macro 'cmpxchg'
      71 |         if (cmpxchg(&speakup_sel_work.tty, NULL, tty)) {
         |             ^~~~~~~
   drivers/accessibility/speakup/selection.c: In function 'speakup_paste_selection':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct tty_struct *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   drivers/accessibility/speakup/selection.c:124:13: note: in expansion of macro 'cmpxchg'
     124 |         if (cmpxchg(&speakup_paste_work.tty, NULL, tty)) {
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
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/nvme/target/fabrics-cmd.c:7:
   drivers/nvme/target/fabrics-cmd.c: In function 'nvmet_install_queue':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct nvmet_ctrl *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   drivers/nvme/target/fabrics-cmd.c:169:15: note: in expansion of macro 'cmpxchg'
     169 |         old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
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
                    from fs/notify/mark.c:63:
   fs/notify/mark.c: In function 'fsnotify_attach_connector_to_object':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct fsnotify_mark_connector *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   fs/notify/mark.c:559:13: note: in expansion of macro 'cmpxchg'
     559 |         if (cmpxchg(connp, NULL, conn)) {
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
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/usb/gadget/function/f_fs.c:17:
   drivers/usb/gadget/function/f_fs.c: In function '__ffs_epfile_read_buffered':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct ffs_buffer *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   drivers/usb/gadget/function/f_fs.c:922:13: note: in expansion of macro 'cmpxchg'
     922 |         if (cmpxchg(&epfile->read_buffer, NULL, buf))
         |             ^~~~~~~
   drivers/usb/gadget/function/f_fs.c: In function '__ffs_epfile_read_data':
>> arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct ffs_buffer *' makes integer from pointer without a cast [-Wint-conversion]
      74 |                 __flags = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);       \
         |                         ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
    4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~
   drivers/usb/gadget/function/f_fs.c:960:13: note: in expansion of macro 'cmpxchg'
     960 |         if (cmpxchg(&epfile->read_buffer, NULL, buf))
         |             ^~~~~~~
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

