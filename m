Return-Path: <linux-kernel+bounces-41389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E283EFF2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A355D284BB4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2102E2E646;
	Sat, 27 Jan 2024 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnyCg2kA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4782E633
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706386444; cv=none; b=EScKp74OTZCfJe97S25Kv2FmHdLKQHA/2TcaV3cFaCw3KHrz5s1yHaHTE/VWp4rzw7nhfGIY+0jtxGIM73Hv1k6dcetPqvtokZ14IvSPgQRrmYqoTcOPxqlfU4RMMBdt9Zvi1If4z2skEPbnrIDM///KvT9lJogw+lEJUqcDPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706386444; c=relaxed/simple;
	bh=mQulpOJjHQwl635YIPhwI826KzecOWi9vVOw//x239k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IvLlcbu3cdyZVh+9myn+nt7zHhtpRaVcRA782j5rcORmbhIWtALHMnE8DAOxXtfRN/hVJxQeLyQcZYRNHupm7er5casiC7Al6fYGW4XrNxwqQ1qIxS7Bcz1HdILwShoE/MDb54fkp1wmNExikivy6e0V5mbZTmMwcyrpe/vjZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnyCg2kA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706386442; x=1737922442;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mQulpOJjHQwl635YIPhwI826KzecOWi9vVOw//x239k=;
  b=dnyCg2kAvLqKcph4OF3AITyvOPq41ufMIqJEO7ZHffEMTv7FeVRIINHH
   xJwWhUwDtScGdhN8mG3gLOKFUCl7pyeSAMNXiQQlxRON7PupsRE61NHXf
   Vs28hsguAkq+eK+F0OBvxg146XoPCFe+ZQcUdpq3C2SqcdfnkRBavuEWw
   nUQf+kK7Au2M7eQdjLOMrXR1PI0E+79P3/NVMhFjbxOC7bBZs96Ui0DIs
   17ElJOcmFQYkaoIkWYEuLj0zrHbPibwfbR96iSnGJW036mqxxzAkVQhV2
   pGo8q1aENnEhJLtSntKDEYC5dY2Pa4UmTuTbK9WNqHO0tFkjRnTairvVg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="16073646"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16073646"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 12:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="857719441"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="857719441"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2024 12:13:59 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTp3s-0002go-31;
	Sat, 27 Jan 2024 20:13:56 +0000
Date: Sun, 28 Jan 2024 04:13:26 +0800
From: kernel test robot <lkp@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: arch/xtensa/include/asm/irqflags.h:47:(.xiptext+0xca0): dangerous
 relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
Message-ID: <202401280402.B2qzR5x9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8a696a29c6905594e4abf78eaafcb62165ac61f1
commit: 565fe150624ee77dc63a735cc1b3bff5101f38a3 mtd: cfi_cmdset_0001: Byte swap OTP info
date:   3 months ago
config: xtensa-randconfig-r006-20221106 (https://download.01.org/0day-ci/archive/20240128/202401280402.B2qzR5x9-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401280402.B2qzR5x9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401280402.B2qzR5x9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_cmdset_0002.c:2561:(.xiptext+0x149e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2563:(.xiptext+0x14ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1258)
   drivers/mtd/chips/cfi_cmdset_0002.c:2567:(.xiptext+0x14c3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2596:(.xiptext+0x15ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2602:(.xiptext+0x15c4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2604:(.xiptext+0x15d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2605:(.xiptext+0x15f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2034:(.xiptext+0x16c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2044:(.xiptext+0x1742): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x117c)
   drivers/mtd/chips/cfi_cmdset_0002.c:2044:(.xiptext+0x174a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_intelext_restore_locks':
   drivers/mtd/chips/cfi_cmdset_0001.c:2618:(.text+0x8f2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_read_pri
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_point_onechip':
   drivers/mtd/chips/cfi_cmdset_0001.c:1389:(.text+0x29fc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xd74)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_intelext_resume':
   drivers/mtd/chips/cfi_cmdset_0001.c:2632:(.text+0x2c0f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xaac)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_intelext_writev':
   drivers/mtd/chips/cfi_cmdset_0001.c:1898:(.text+0x2d0a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xaac)
   drivers/mtd/chips/cfi_cmdset_0001.c:1925:(.text+0x2e00): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xaac)
   drivers/mtd/chips/cfi_cmdset_0001.o:drivers/mtd/chips/cfi_cmdset_0001.c:1134:(.xiptext+0xa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_enable':
   drivers/mtd/chips/cfi_cmdset_0001.c:1137:(.xiptext+0x2c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1143:(.xiptext+0x76): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0001.c:1128:(.xiptext+0xa4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_getlockstatus_oneblock':
   drivers/mtd/chips/cfi_cmdset_0001.c:2104:(.xiptext+0x18a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:1161:(.xiptext+0x1ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_wait_for_operation':
   drivers/mtd/chips/cfi_cmdset_0001.c:1170:(.xiptext+0x240): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1176:(.xiptext+0x25a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1176:(.xiptext+0x2e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1195:(.xiptext+0x306): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1215:(.xiptext+0x37a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1210:(.xiptext+0x39e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1213:(.xiptext+0x3ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __might_resched
   drivers/mtd/chips/cfi_cmdset_0001.c:1213:(.xiptext+0x3b2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __cond_resched
   drivers/mtd/chips/cfi_cmdset_0001.c:1212:(.xiptext+0x3bc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:1215:(.xiptext+0x3d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1221:(.xiptext+0x3ee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1249:(.xiptext+0x440): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0001.c:1250:(.xiptext+0x45c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0001.c:1250:(.xiptext+0x464): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1250:(.xiptext+0x46a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0001.c:1252:(.xiptext+0x476): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `current_thread_info':
   arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0x480): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_wait_for_operation':
   drivers/mtd/chips/cfi_cmdset_0001.c:1236:(.xiptext+0x503): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0001.c:1264:(.xiptext+0x54a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:1266:(.xiptext+0x564): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:1267:(.xiptext+0x573): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1d9c)
   drivers/mtd/chips/cfi_cmdset_0001.c:1267:(.xiptext+0x58a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:2123:(.xiptext+0x5d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_xxlock_oneblock':
   drivers/mtd/chips/cfi_cmdset_0001.c:2131:(.xiptext+0x5f8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2133:(.xiptext+0x628): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2142:(.xiptext+0x67b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2144:(.xiptext+0x69e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:2163:(.xiptext+0x6dc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x16b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:2163:(.xiptext+0x6e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:2174:(.xiptext+0x746): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:2175:(.xiptext+0x762): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:2176:(.xiptext+0x770): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1d9c)
   drivers/mtd/chips/cfi_cmdset_0001.c:2179:(.xiptext+0x78a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1954:(.xiptext+0x7f3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1954:(.xiptext+0x80a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1954:(.xiptext+0x822): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0001.c:1965:(.xiptext+0x86a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1970:(.xiptext+0x88b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1970:(.xiptext+0x8a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0001.c:1128:(.xiptext+0x8cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0001.c:1978:(.xiptext+0x8ee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_merge_status
   drivers/mtd/chips/cfi_cmdset_0001.c:1978:(.xiptext+0x900): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1981:(.xiptext+0x91c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1993:(.xiptext+0x96f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:2003:(.xiptext+0x9ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:2004:(.xiptext+0x9da): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:2007:(.xiptext+0x9f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:2011:(.xiptext+0xa22): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x16b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:2003:(.xiptext+0xa2a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:2012:(.xiptext+0xa5a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x16b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:2013:(.xiptext+0xa62): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:2021:(.xiptext+0xab2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:2028:(.xiptext+0xada): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2029:(.xiptext+0xae7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2023:(.xiptext+0xafc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:2024:(.xiptext+0xb0a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1d9c)
   drivers/mtd/chips/cfi_cmdset_0001.c:2036:(.xiptext+0xb1f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1569:(.xiptext+0xbc2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_oneword':
   drivers/mtd/chips/cfi_cmdset_0001.c:1580:(.xiptext+0xbe8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1580:(.xiptext+0xc0c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_merge_status
   drivers/mtd/chips/cfi_cmdset_0001.c:1576:(.xiptext+0xc1f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1591:(.xiptext+0xc3a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `arch_local_irq_save':
>> arch/xtensa/include/asm/irqflags.h:47:(.xiptext+0xca0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_oneword':
   drivers/mtd/chips/cfi_cmdset_0001.c:1600:(.xiptext+0xcb8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1609:(.xiptext+0xce6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x16b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:1610:(.xiptext+0xcee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1623:(.xiptext+0xd7a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:1623:(.xiptext+0xda7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x100)
   drivers/mtd/chips/cfi_cmdset_0001.c:1637:(.xiptext+0xdf6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1637:(.xiptext+0xe04): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1641:(.xiptext+0xe18): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:1641:(.xiptext+0xe26): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1d9c)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_oneword.constprop.0':
   drivers/mtd/chips/cfi_cmdset_0001.c:1641:(.xiptext+0xe3b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1726:(.xiptext+0xeb4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1726:(.xiptext+0xee7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0001.c:1727:(.xiptext+0xf12): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1726:(.xiptext+0xf2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1745:(.xiptext+0xf47): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1750:(.xiptext+0xfab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1754:(.xiptext+0xfd3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1757:(.xiptext+0xfeb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1758:(.xiptext+0x100e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1770:(.xiptext+0x1088): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1807:(.xiptext+0x1212): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1814:(.xiptext+0x124a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `map_word_load_partial':
   include/linux/mtd/map.h:352:(.xiptext+0x126e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0001.c:1828:(.xiptext+0x1292): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1819:(.xiptext+0x12b3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_merge_status
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `map_word_ff':
   include/linux/mtd/map.h:378:(.xiptext+0x12c3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   include/linux/mtd/map.h:378:(.xiptext+0x12db): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0001.c:1828:(.xiptext+0x133e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1830:(.xiptext+0x1357): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1835:(.xiptext+0x1386): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x16b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:1840:(.xiptext+0x138e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/maps/map_funcs.o: in function `simple_map_copy_to':
   drivers/mtd/maps/map_funcs.c:29:(.xiptext+0xa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/maps/map_funcs.c:29:(.xiptext+0x18): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memcpy
   drivers/mtd/maps/map_funcs.c:24:(.xiptext+0x32): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/maps/map_funcs.o: in function `simple_map_copy_from':
   drivers/mtd/maps/map_funcs.c:24:(.xiptext+0x4e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memcpy
   drivers/mtd/maps/map_funcs.o: in function `inline_map_copy_from':
   include/linux/mtd/map.h:433:(.xiptext+0x63): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memcpy
   drivers/mtd/maps/map_funcs.o: in function `simple_map_copy_from':
   drivers/mtd/maps/map_funcs.c:26:(.xiptext+0x8a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/maps/map_funcs.o: in function `simple_map_write':
   drivers/mtd/maps/map_funcs.c:21:(.xiptext+0x112): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount


vim +47 arch/xtensa/include/asm/irqflags.h

df9ee29270c11db David Howells 2010-10-07  25  
df9ee29270c11db David Howells 2010-10-07  26  static inline unsigned long arch_local_irq_save(void)
df9ee29270c11db David Howells 2010-10-07  27  {
df9ee29270c11db David Howells 2010-10-07  28  	unsigned long flags;
38fef73c21d117c Max Filippov  2015-07-16  29  #if XTENSA_FAKE_NMI
900f492836df432 Sinan Kaya    2019-05-14  30  #if defined(CONFIG_DEBUG_MISC) && (LOCKLEVEL | TOPLEVEL) >= XCHAL_DEBUGLEVEL
38fef73c21d117c Max Filippov  2015-07-16  31  	unsigned long tmp;
38fef73c21d117c Max Filippov  2015-07-16  32  
38fef73c21d117c Max Filippov  2015-07-16  33  	asm volatile("rsr	%0, ps\t\n"
38fef73c21d117c Max Filippov  2015-07-16  34  		     "extui	%1, %0, 0, 4\t\n"
38fef73c21d117c Max Filippov  2015-07-16  35  		     "bgei	%1, "__stringify(LOCKLEVEL)", 1f\t\n"
38fef73c21d117c Max Filippov  2015-07-16  36  		     "rsil	%0, "__stringify(LOCKLEVEL)"\n"
38fef73c21d117c Max Filippov  2015-07-16  37  		     "1:"
38fef73c21d117c Max Filippov  2015-07-16  38  		     : "=a" (flags), "=a" (tmp) :: "memory");
38fef73c21d117c Max Filippov  2015-07-16  39  #else
38fef73c21d117c Max Filippov  2015-07-16  40  	asm volatile("rsr	%0, ps\t\n"
38fef73c21d117c Max Filippov  2015-07-16  41  		     "or	%0, %0, %1\t\n"
38fef73c21d117c Max Filippov  2015-07-16  42  		     "xsr	%0, ps\t\n"
38fef73c21d117c Max Filippov  2015-07-16  43  		     "rsync"
38fef73c21d117c Max Filippov  2015-07-16  44  		     : "=&a" (flags) : "a" (LOCKLEVEL) : "memory");
38fef73c21d117c Max Filippov  2015-07-16  45  #endif
38fef73c21d117c Max Filippov  2015-07-16  46  #else
df9ee29270c11db David Howells 2010-10-07 @47  	asm volatile("rsil	%0, "__stringify(LOCKLEVEL)
df9ee29270c11db David Howells 2010-10-07  48  		     : "=a" (flags) :: "memory");
38fef73c21d117c Max Filippov  2015-07-16  49  #endif
df9ee29270c11db David Howells 2010-10-07  50  	return flags;
df9ee29270c11db David Howells 2010-10-07  51  }
df9ee29270c11db David Howells 2010-10-07  52  

:::::: The code at line 47 was first introduced by commit
:::::: df9ee29270c11dba7d0fe0b83ce47a4d8e8d2101 Fix IRQ flag handling naming

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

