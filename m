Return-Path: <linux-kernel+bounces-125112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C88892045
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9782E1C294AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF2E13CFB6;
	Fri, 29 Mar 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDpbK1bg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112813AA52
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724940; cv=none; b=b6SayO3qvp7/l1zPC50m7CIpyUpVjWXZj+h2p6tuEO9a9PeI3L9PetaEqd/j47oujIgcE+sALfEP7NLoWeaWyF37nqe20UOMs5iQY6jJkT+QwAzvENo+foaAD9wI4xfJ3A2Khc3lcTu30L/kiG4rSApeuIaYg86icvFWOuyMwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724940; c=relaxed/simple;
	bh=f6vzbKl527W+p5TqiWnjnnpffD1YURye0M5OLzURURk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mnCe3x1XV/eIelcv1F8NKtJk74bqRVkEI4tTCcnV4yoe0kehzkK5mSlWcS/30RpRzLGh+hTGLybaBl4A0k+kUcQzsVvUFAewLI/zuGMoHRZXZBwTwrqAMjVbx2pMWZsKun+jw1ZvMjXrqBvC2+Bpy5r02WWIgz6hYh30sHnDxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDpbK1bg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711724938; x=1743260938;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f6vzbKl527W+p5TqiWnjnnpffD1YURye0M5OLzURURk=;
  b=MDpbK1bgniSm6eN8p95w3/mkCJgAj44V67WLLAs922DtI29DVTS8Txtn
   iYQuGaSqpCXU4j7QcRcCyaetCFAUMxpNflWn6RnKy9hpKs4b+qL2cUHE6
   D2UM7cFi6pL7LbaMZdZa9Mw3EDBWz1HTkpvwOnTXhFq8O7wghFbxs0aGJ
   hU/EtUs/FIZDJY+g8DYU5FV2sfMMHoFwHOwSOGcHcrGNvCdhD1P047Ecg
   VWI8AYjdfrJy16Os9N4RTufATki2XAH9Zpmo5Itcp+ET/v+/d8EJAg94T
   eCzO+EJyO1ZyACNfodcoLrmIR+dnEDDi7/KhGlFVY7C+U8ejHQPkSOfeO
   A==;
X-CSE-ConnectionGUID: 9ID90JhJSt6ZVlWO3VcsuA==
X-CSE-MsgGUID: OK0aBBNwQ8qYCfjv8TUkcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="17542368"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17542368"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21462486"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 08:08:54 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqDqd-0003J4-27;
	Fri, 29 Mar 2024 15:08:51 +0000
Date: Fri, 29 Mar 2024 23:08:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.03.27b 66/69]
 include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to
 undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202403292322.bwguovKc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
head:   786fab3085d764055a78edb54023420920344333
commit: 032d9f7e1213171131a3f45c5c532ea5d11b4b9a [66/69] riscv: Emulate one-byte and two-byte cmpxchg
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240329/202403292322.bwguovKc-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 79ba323bdd0843275019e16b6e9b35133677c514)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403292322.bwguovKc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403292322.bwguovKc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2026 |         return raw_cmpxchg(&v->counter, old, new);
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^
   arch/riscv/include/asm/cmpxchg.h:367:23: note: expanded from macro 'arch_cmpxchg'
     367 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
         |                              ^
   arch/riscv/include/asm/cmpxchg.h:328:11: note: expanded from macro '__cmpxchg'
     328 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
         |                         ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^
   arch/riscv/include/asm/cmpxchg.h:367:23: note: expanded from macro 'arch_cmpxchg'
     367 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
         |                              ^
   arch/riscv/include/asm/cmpxchg.h:332:11: note: expanded from macro '__cmpxchg'
     332 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
         |                         ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:2055:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2055 |         return raw_cmpxchg_acquire(&v->counter, old, new);
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:65:29: note: expanded from macro 'raw_cmpxchg_acquire'
      65 | #define raw_cmpxchg_acquire arch_cmpxchg_acquire
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:263:23: note: expanded from macro 'arch_cmpxchg_acquire'
     263 |         (__typeof__(*(ptr))) __cmpxchg_acquire((ptr),                   \
         |                              ^
   arch/riscv/include/asm/cmpxchg.h:224:11: note: expanded from macro '__cmpxchg_acquire'
     224 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
         |                         ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:2055:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/atomic/atomic-arch-fallback.h:65:29: note: expanded from macro 'raw_cmpxchg_acquire'
      65 | #define raw_cmpxchg_acquire arch_cmpxchg_acquire
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:263:23: note: expanded from macro 'arch_cmpxchg_acquire'
     263 |         (__typeof__(*(ptr))) __cmpxchg_acquire((ptr),                   \
         |                              ^
   arch/riscv/include/asm/cmpxchg.h:228:11: note: expanded from macro '__cmpxchg_acquire'
     228 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
         |                         ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:2083:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2083 |         return raw_cmpxchg_release(&v->counter, old, new);
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:315:23: note: expanded from macro 'arch_cmpxchg_release'
     315 |         (__typeof__(*(ptr))) __cmpxchg_release((ptr),                   \
         |                              ^
   arch/riscv/include/asm/cmpxchg.h:276:11: note: expanded from macro '__cmpxchg_release'
     276 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
         |                         ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:2083:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:315:23: note: expanded from macro 'arch_cmpxchg_release'
     315 |         (__typeof__(*(ptr))) __cmpxchg_release((ptr),                   \
         |                              ^
   arch/riscv/include/asm/cmpxchg.h:280:11: note: expanded from macro '__cmpxchg_release'
     280 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
         |                         ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:2108:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2108 |         return raw_cmpxchg_relaxed(&v->counter, old, new);


vim +/cmpxchg_emu_u8 +2026 include/linux/atomic/atomic-arch-fallback.h

37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2000  
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2001  /**
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2002   * raw_atomic_cmpxchg() - atomic compare and exchange with full ordering
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2003   * @v: pointer to atomic_t
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2004   * @old: int value to compare with
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2005   * @new: int value to assign
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2006   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2007   * If (@v == @old), atomically updates @v to @new with full ordering.
6dfee110c6cc7a include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2024-02-09  2008   * Otherwise, @v is not modified and relaxed ordering is provided.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2009   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2010   * Safe to use in noinstr code; prefer atomic_cmpxchg() elsewhere.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2011   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2012   * Return: The original value of @v.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2013   */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2014  static __always_inline int
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2015  raw_atomic_cmpxchg(atomic_t *v, int old, int new)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2016  {
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2017  #if defined(arch_atomic_cmpxchg)
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2018  	return arch_atomic_cmpxchg(v, old, new);
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2019  #elif defined(arch_atomic_cmpxchg_relaxed)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2020  	int ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2021  	__atomic_pre_full_fence();
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2022  	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2023  	__atomic_post_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2024  	return ret;
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2025  #else
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05 @2026  	return raw_cmpxchg(&v->counter, old, new);
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2027  #endif
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2028  }
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2029  

:::::: The code at line 2026 was first introduced by commit
:::::: 9257959a6e5b4fca6fc8e985790bff62c2046f20 locking/atomic: scripts: restructure fallback ifdeffery

:::::: TO: Mark Rutland <mark.rutland@arm.com>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

