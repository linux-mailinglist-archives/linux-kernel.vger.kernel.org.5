Return-Path: <linux-kernel+bounces-69146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8A985850E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6F71C20DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263761350D8;
	Fri, 16 Feb 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSuZsAhf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3F1350C8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107915; cv=none; b=pcGLHUmg7I+PrFcKARmPp1jJHuaq5FZfxSU4Lci4skupO8kVveybgg16EMNYMvfI0bnFJxKi34cZ6T2+Co92+atfTcMoU2DxQ+/VGR/rl9ehPKCDtq668MVExlDhQgWnc6PP+SAcZv/CwJSRADlQbgQwCdzY5YSRFdmEHu0hTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107915; c=relaxed/simple;
	bh=DOxnNP69L+uOYhHE7iO0B5EICXQp5z0lcE9Ulq5UR+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mKCkP7xL0yofY4czgA3C8g9IhLGTCyKHqOxzLN04yoGbKjhorzBzn87LkhXTaVDWsFyEKxuPEXPyUgzHIOn4CjGqkUVKNW9PGu0Bc7XTqipg5F797iT14iutBPqeJLpV/VVpOgymF9aX+ttDURmqkxY3xcdUQBi8mKgsm0d5YE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSuZsAhf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708107913; x=1739643913;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DOxnNP69L+uOYhHE7iO0B5EICXQp5z0lcE9Ulq5UR+A=;
  b=KSuZsAhfINYjThu3PE49CSHroNHNlJJlcGJL8mtJ+9lyQufv+2AkrYt6
   1oqe/+51SkznnnJdTq4++ROsuz+5tFmb5Z99woXpjDXdAE1ocZkah99Fd
   5cwdJnNad4Yk9coVnECDtKHGWQQILxjA36LgxQAtd6P1gNpskG8WXRwdt
   xIpdM7EArn9ipHgKJF9eC8P+YEw2BIDMDX7cVNpNZ07E47rr2thQNefc0
   lpCUIcMH/O0E+WjG6xAlC3N1eGJXM9WCchQnEfrPiKpS7GZ6E7eq0Diu4
   Y65fUzRXNll9Q/XZtUIZgJTTjy7Hx9Y8Ou0B5Tn9eQFcxV/5xhv3PGB9C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2118089"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2118089"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 10:25:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="912402291"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="912402291"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2024 10:25:11 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rb2tZ-0001Xk-0v;
	Fri, 16 Feb 2024 18:25:09 +0000
Date: Sat, 17 Feb 2024 02:24:41 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast
 truncates bits from constant value (8000000000000000 becomes 0)
Message-ID: <202402170208.0xYZculA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0f1dd5e91e2ba3990143645faff2bcce2d99778e
commit: 453924de6212ac159f946b75c6b59918e2e30944 afs: Overhaul invalidation handling to better support RO volumes
date:   7 weeks ago
config: powerpc64-randconfig-r111-20240216 (https://download.01.org/0day-ci/archive/20240217/202402170208.0xYZculA-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240217/202402170208.0xYZculA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402170208.0xYZculA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/afs/callback.c: note: in included file (through arch/powerpc/include/asm/pgtable-be-types.h, arch/powerpc/include/asm/page.h, arch/powerpc/include/asm/mmu.h, ...):
>> arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/powerpc/include/asm/cmpxchg.h:243:48: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   fs/afs/callback.c:146:22: sparse: sparse: context imbalance in 'afs_lookup_volume_rcu' - different lock contexts for basic block
--
   fs/afs/rotate.c: note: in included file (through arch/powerpc/include/asm/pgtable-be-types.h, arch/powerpc/include/asm/page.h, arch/powerpc/include/asm/mmu.h, ...):
>> arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/powerpc/include/asm/cmpxchg.h:243:48: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   fs/afs/rotate.c:655:42: sparse: sparse: self-comparison always evaluates to true

vim +241 arch/powerpc/include/asm/cmpxchg.h

ae3a197e3d0bfe David Howells 2012-03-28  235  
ae3a197e3d0bfe David Howells 2012-03-28  236  static __always_inline unsigned long
26760fc19a7e66 Boqun Feng    2015-12-15  237  __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
ae3a197e3d0bfe David Howells 2012-03-28  238  {
ae3a197e3d0bfe David Howells 2012-03-28  239  	switch (size) {
d0563a1297e234 Pan Xinhui    2016-04-27  240  	case 1:
d0563a1297e234 Pan Xinhui    2016-04-27 @241  		return __xchg_u8_relaxed(ptr, x);
d0563a1297e234 Pan Xinhui    2016-04-27  242  	case 2:
d0563a1297e234 Pan Xinhui    2016-04-27  243  		return __xchg_u16_relaxed(ptr, x);
ae3a197e3d0bfe David Howells 2012-03-28  244  	case 4:
26760fc19a7e66 Boqun Feng    2015-12-15  245  		return __xchg_u32_relaxed(ptr, x);
ae3a197e3d0bfe David Howells 2012-03-28  246  #ifdef CONFIG_PPC64
ae3a197e3d0bfe David Howells 2012-03-28  247  	case 8:
26760fc19a7e66 Boqun Feng    2015-12-15  248  		return __xchg_u64_relaxed(ptr, x);
ae3a197e3d0bfe David Howells 2012-03-28  249  #endif
ae3a197e3d0bfe David Howells 2012-03-28  250  	}
068550631fbe0b Andrzej Hajda 2023-01-18  251  	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_relaxed");
ae3a197e3d0bfe David Howells 2012-03-28  252  	return x;
ae3a197e3d0bfe David Howells 2012-03-28  253  }
9eaa82935dccb7 Mark Rutland  2021-05-25  254  #define arch_xchg_local(ptr,x)						     \
ae3a197e3d0bfe David Howells 2012-03-28  255    ({									     \
ae3a197e3d0bfe David Howells 2012-03-28  256       __typeof__(*(ptr)) _x_ = (x);					     \
26760fc19a7e66 Boqun Feng    2015-12-15  257       (__typeof__(*(ptr))) __xchg_local((ptr),				     \
26760fc19a7e66 Boqun Feng    2015-12-15  258       		(unsigned long)_x_, sizeof(*(ptr))); 			     \
ae3a197e3d0bfe David Howells 2012-03-28  259    })
ae3a197e3d0bfe David Howells 2012-03-28  260  

:::::: The code at line 241 was first introduced by commit
:::::: d0563a1297e234ed37f6b51c2e9321accebd1839 powerpc: Implement {cmp}xchg for u8 and u16

:::::: TO: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

