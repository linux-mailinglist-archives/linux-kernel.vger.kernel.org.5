Return-Path: <linux-kernel+bounces-87716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C577486D81E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3431F22F11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288D9386;
	Fri,  1 Mar 2024 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkEfifYc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93F629
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251465; cv=none; b=smDp1DXMVV06HiG1Ps9OpujIoNlUR+89dYrNH/RjJrloVPGCWXFA0x4Ojq+RXPF5h18QrKTxXcdfWgYJC5aI3G9cLZVQvAS6dSnPfPRS7MYW6wRC/Tf0YuMY8JyPZxU3hrvkCBobyUjVk1yIIT/WRuZ+ZXNrMw90tN89g0Bg5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251465; c=relaxed/simple;
	bh=J7Z6MgJrfOTC4po2eFseGMRCFvJG7iHI0IxNmfGXVrE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MBeYZuTDYMHSpXh04JMhYkQd+wVF6z7ab4YqedNXTbPIsMY3N05XqtHQ7hSKwJGGKI7I2ej8MeeqkpDcGtq9WyYHMvOZ0e1i4fmUg3gwMxbb+tQ2MCgwsUJHwT98cEB9VkcCaf1Ga/hLxetfMe47pHVyq5cSl3ltD+RDZSDjx6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkEfifYc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709251464; x=1740787464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J7Z6MgJrfOTC4po2eFseGMRCFvJG7iHI0IxNmfGXVrE=;
  b=hkEfifYcs8MlStGwAGXU2y9Fpo4FL2Ao6DMT93qqpzdqCDJV0aaDE6TQ
   +oEISFwZakduq4nd0myICdsyp3MtlijWOuB1kqJnbd37NPtHW8Zxkxzko
   Y0otTPwUXggJ0PTLuX9IATMuZc9/qBui8rEJpgEnJN/otpum+5D38XRhD
   HeTpCgmUNS9+7q5JeJg5eExpBIdTnRHyUzIiRWzg3wpdOZ+2mj1gsEQht
   vNTvwZi8/UiLLpn78JTvpH7YBd4NG/h+jF0hJ4cVPsv1+Nmw/zASRk+j0
   EMsLVSOyrGg2ZQ7M9yvGpBLfNrRlOZtDFV2+19jsEVEjr3l5UCBEk/rwJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7590695"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7590695"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 16:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7893715"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 29 Feb 2024 16:04:18 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfqMQ-000DMx-0E;
	Fri, 01 Mar 2024 00:03:17 +0000
Date: Fri, 1 Mar 2024 08:02:15 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:x86/boot 9/9] arch/x86/include/asm/desc.h:60:16: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202403010704.oGQZPu0P-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
head:   891f8890a4a3663da7056542757022870b499bc1
commit: 11e36b0f7c2150a6453872b79555767b43c846d0 [9/9] x86/boot/64: Load the final kernel GDT during early boot directly, remove startup_gdt[]
config: i386-randconfig-061-20240229 (https://download.01.org/0day-ci/archive/20240301/202403010704.oGQZPu0P-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403010704.oGQZPu0P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403010704.oGQZPu0P-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/events/core.c:2809:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct desc_struct * @@
   arch/x86/events/core.c:2809:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/events/core.c:2809:24: sparse:     got struct desc_struct *
   arch/x86/events/core.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
--
   arch/x86/kernel/doublefault_32.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   arch/x86/kernel/doublefault_32.c: note: in included file (through arch/x86/include/asm/elf.h, include/linux/elf.h, include/linux/module.h, ...):
>> arch/x86/include/asm/desc.h:60:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/include/asm/desc.h:60:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/desc.h:60:16: sparse:     got struct gdt_page *
   arch/x86/include/asm/desc.h:54:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/include/asm/desc.h:54:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/desc.h:54:16: sparse:     got struct gdt_page *
--
   arch/x86/kernel/process.c:798:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct cpuinfo_x86 * @@
   arch/x86/kernel/process.c:798:33: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/process.c:798:33: sparse:     got struct cpuinfo_x86 *
   arch/x86/kernel/process.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   arch/x86/kernel/process.c: note: in included file (through arch/x86/include/asm/elf.h, include/linux/elf.h, include/linux/module.h, ...):
>> arch/x86/include/asm/desc.h:60:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/include/asm/desc.h:60:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/desc.h:60:16: sparse:     got struct gdt_page *

vim +60 arch/x86/include/asm/desc.h

a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28  56  
69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14  57  /* Provide the current original GDT */
69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14  58  static inline struct desc_struct *get_current_gdt_rw(void)
69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14  59  {
69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14 @60  	return this_cpu_ptr(&gdt_page)->gdt;
69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14  61  }
69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14  62  

:::::: The code at line 60 was first introduced by commit
:::::: 69218e47994da614e7af600bf06887750ab6657a x86: Remap GDT tables in the fixmap section

:::::: TO: Thomas Garnier <thgarnie@google.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

