Return-Path: <linux-kernel+bounces-125446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D5892606
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E768DB2320D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C3113BAFC;
	Fri, 29 Mar 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEwfdHvc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88213B2B8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747630; cv=none; b=HhcIg39p2zm9vp7wuRRmy5yuvn6kguiRPND+Oc+QNfndskE7H+Qmz0eJPxz4zDueqfmUbq++7c/RJ3J7iTm0gWXQFvcCBJUNMD7GUlxME38d8d9pcvQbD6Y7MEyKy3M2N8rhd320DSelYs5FjqjEV4ibHfIwSAagQ65vBlkRm74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747630; c=relaxed/simple;
	bh=LetMHBPBQXz6ixIsInVumoaExZfUK1GJsZvW08MI+m4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZNaLcXHrH/pI2V8B4Mpg4KULZ4GDqaUbEJpjjobX8W7rr7esuNhuqZN20GOPPPXuhNIiCendozxIMl0PF3YkoOMV8zlGdpMN1vNPD9u20QmiefxvpMVBiT+3y+oHT7SWf2rEDEs9eiV9/uSw9wQjbVLsKmE8tiXCh5xahE2QJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEwfdHvc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711747629; x=1743283629;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LetMHBPBQXz6ixIsInVumoaExZfUK1GJsZvW08MI+m4=;
  b=EEwfdHvcpPJhrPRqGLuhdR7hrkAU07XPH4QR6TPrSTuftJilzC3mqcv5
   cHoVLZ4QmONIISidOqz8rVts4T8piqFvObvvym70xHMyJ8lVIfcMLFalG
   oOWWS6tST3zkL9sjTZo32yOFbr5ro8D3BZ9uXDwRQnWuVnsV+3cBB79VK
   yMlHCRBdHJ0U3vCCsscEymChhgfNQkQ/hRrAYhG4WXF7ZN4H2rNAYo22l
   ZQsxPbH3lBZyq9Uic1og/lhDEM8lhSe1Q/izKhAfbYOEgbgYbAnTHBTl9
   GYXi0g/zsGI5NhnRU1plKCvuM1Opalv6fk2v270HeJZGwLdcMKc9HMHYr
   w==;
X-CSE-ConnectionGUID: niDxB5GzSOutHDpZK/RWcg==
X-CSE-MsgGUID: 4tgjrxNgQC+Fk5GAr85dWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="29430416"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="29430416"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 14:27:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="48055763"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Mar 2024 14:27:07 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqJke-0003e2-1y;
	Fri, 29 Mar 2024 21:27:04 +0000
Date: Sat, 30 Mar 2024 05:26:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.03.27b 61/69] lib/cmpxchg-emu.c:24:11:
 warning: no previous prototype for 'cmpxchg_emu_u8'
Message-ID: <202403300508.Xz7XNp71-lkp@intel.com>
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
commit: b48ffed4c636b96d2be7a93806870772ce34961f [61/69] csky: Emulate one-byte and two-byte cmpxchg
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20240330/202403300508.Xz7XNp71-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403300508.Xz7XNp71-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403300508.Xz7XNp71-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/cmpxchg-emu.c:24:11: warning: no previous prototype for 'cmpxchg_emu_u8' [-Wmissing-prototypes]
      24 | uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
         |           ^~~~~~~~~~~~~~
>> lib/cmpxchg-emu.c:51:11: warning: no previous prototype for 'cmpxchg_emu_u16' [-Wmissing-prototypes]
      51 | uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
         |           ^~~~~~~~~~~~~~~


vim +/cmpxchg_emu_u8 +24 lib/cmpxchg-emu.c

0bbce967f3ecfc Paul E. McKenney 2024-03-17  22  
0bbce967f3ecfc Paul E. McKenney 2024-03-17  23  /* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
0bbce967f3ecfc Paul E. McKenney 2024-03-17 @24  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
0bbce967f3ecfc Paul E. McKenney 2024-03-17  25  {
0bbce967f3ecfc Paul E. McKenney 2024-03-17  26  	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  27  	int i = ((uintptr_t)p) & 0x3;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  28  	union u8_32 old32;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  29  	union u8_32 new32;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  30  	u32 ret;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  31  
0bbce967f3ecfc Paul E. McKenney 2024-03-17  32  	old32.w = READ_ONCE(*p32);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  33  	do {
0bbce967f3ecfc Paul E. McKenney 2024-03-17  34  		if (old32.b[i] != old)
0bbce967f3ecfc Paul E. McKenney 2024-03-17  35  			return old32.b[i];
0bbce967f3ecfc Paul E. McKenney 2024-03-17  36  		new32.w = old32.w;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  37  		new32.b[i] = new;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  38  		instrument_atomic_read_write(p, 1);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  39  		ret = data_race(cmpxchg(p32, old32.w, new32.w));
0bbce967f3ecfc Paul E. McKenney 2024-03-17  40  	} while (ret != old32.w);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  41  	return old;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  42  }
0bbce967f3ecfc Paul E. McKenney 2024-03-17  43  EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
0bbce967f3ecfc Paul E. McKenney 2024-03-17  44  
0bbce967f3ecfc Paul E. McKenney 2024-03-17  45  union u16_32 {
0bbce967f3ecfc Paul E. McKenney 2024-03-17  46  	u16 h[2];
0bbce967f3ecfc Paul E. McKenney 2024-03-17  47  	u32 w;
0bbce967f3ecfc Paul E. McKenney 2024-03-17  48  };
0bbce967f3ecfc Paul E. McKenney 2024-03-17  49  
0bbce967f3ecfc Paul E. McKenney 2024-03-17  50  /* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
0bbce967f3ecfc Paul E. McKenney 2024-03-17 @51  uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)

:::::: The code at line 24 was first introduced by commit
:::::: 0bbce967f3ecfc6da1e7e8756b0d398e791b8dee lib: Add one-byte and two-byte cmpxchg() emulation functions

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

