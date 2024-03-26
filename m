Return-Path: <linux-kernel+bounces-118681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C046588BDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF411B27E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928196BFCB;
	Tue, 26 Mar 2024 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JE5kP8Qx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBE54BF0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445040; cv=none; b=MMpGsa2aAWoznmTOwHIbPuvTXbDUOu//+97njSX5FTuHSbenXbTJ/3C2UmiryeJ1ZsYbg6bYtZpubBqdqUyU4gjEoVFjBddwvmvuxvV2XQIz4nNMzO8IaGVZaxn6a6jWoqOObNvx70OKD9RCWNWjKTSgrSRSHIOyDf2Gfi4HZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445040; c=relaxed/simple;
	bh=DVIsdHBrhzqE0XkF/Wz5os15anubMI+xu7YrHRpJtMk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dabNDsa9X22CMd41kozZSyAPgHzfsIXrED6GHA522UgJ6K8bBwVi075dTkXASFC85w26Xk1pGIWGzq1gqQJ92nmOHWwaVtu+VfRvytWuAAL7r7nX9Hi78Syy5Wwfw4+bgXIqWeKuEse5rkFYfVwQSgB5OTOLF0pm4iVevbYyXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JE5kP8Qx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711445036; x=1742981036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DVIsdHBrhzqE0XkF/Wz5os15anubMI+xu7YrHRpJtMk=;
  b=JE5kP8QxRC8qjWbRRnU9DJXo9FdiOdb4nB/i/GJ9v9bripUTUI6dmGN2
   u0puJgGJ2eSCo7wr4jkcZzqXoQSRpZuo4gACMk4hZ+2GVFkUYc6GjmlEg
   Lv9Ol7DuoToKdfAw8kdKXuJPLIddS87shOdTvzK/sCslNCDp+qMZaiAtZ
   SCJkL7lWpFWsZLLKhTBnva05KVe8qRQZifuRRWMVv/FJ5R2X2s72KJoAs
   vpUoGehTvEgGqfV3SRyRIMMHFFMsUYetD1q7QDRtOaDRvcuTOqfy+iK0o
   7RGZabAvd7pb56d1014deO9pexc0JKOKZ6YJd/nPhkD/RlPMLlMazhO8R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6696704"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6696704"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="15882288"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Mar 2024 02:23:53 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp327-000NGc-28;
	Tue, 26 Mar 2024 09:23:51 +0000
Date: Tue, 26 Mar 2024 17:23:46 +0800
From: kernel test robot <lkp@intel.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x5a):
 dangerous relocation: windowed longcall crosses 1GB boundary; return may
 fail: __tsan_read4
Message-ID: <202403261744.QfnJ5AEO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   928a87efa42302a23bb9554be081a28058495f22
commit: 03ce34cf8f50e4c62f9a4b62caffdba1165ca977 xtensa: add XIP-aware MTD support
date:   7 months ago
config: xtensa-randconfig-r032-20221230 (https://download.01.org/0day-ci/archive/20240326/202403261744.QfnJ5AEO-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403261744.QfnJ5AEO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403261744.QfnJ5AEO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x4e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
>> drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x5a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x68): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x7c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x9b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0xac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x102): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x128): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc
>> drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x137): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
>> drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x149): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memset
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x152): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:198:(.xiptext+0x162): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_probe.o: in function `cfi_read_query':
   include/linux/mtd/cfi.h:309:(.xiptext+0x18a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:200:(.xiptext+0x194): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_read_query':
   include/linux/mtd/cfi.h:311:(.xiptext+0x1aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:314:(.xiptext+0x1bc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:204:(.xiptext+0x20e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_probe.c:211:(.xiptext+0x22c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `kmalloc':
>> include/linux/slab.h:586:(.xiptext+0x23b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:215:(.xiptext+0x25b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.c:217:(.xiptext+0x26c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:219:(.xiptext+0x27b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:223:(.xiptext+0x29b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.o: in function `cfi_read_query':
   include/linux/mtd/cfi.h:309:(.xiptext+0x2ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:309:(.xiptext+0x2bb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   include/linux/mtd/cfi.h:313:(.xiptext+0x2db): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   include/linux/mtd/cfi.h:314:(.xiptext+0x2ec): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:314:(.xiptext+0x2fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.o: in function `__arch_swab32':
>> arch/xtensa/include/uapi/asm/swab.h:24:(.xiptext+0x31b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:223:(.xiptext+0x32c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:223:(.xiptext+0x33b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:227:(.xiptext+0x35b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.o: in function `__arch_swab16':
   arch/xtensa/include/uapi/asm/swab.h:60:(.xiptext+0x36c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:227:(.xiptext+0x37b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:229:(.xiptext+0x39a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.o: in function `__arch_swab16':
   arch/xtensa/include/uapi/asm/swab.h:60:(.xiptext+0x3ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:229:(.xiptext+0x3b6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_probe.c:230:(.xiptext+0x3db): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:231:(.xiptext+0x412): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.o: in function `__arch_swab16':
   arch/xtensa/include/uapi/asm/swab.h:60:(.xiptext+0x42f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:231:(.xiptext+0x43e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_probe.c:232:(.xiptext+0x457): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:232:(.xiptext+0x483): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:233:(.xiptext+0x49a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.c:233:(.xiptext+0x4a2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:233:(.xiptext+0x4b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.c:233:(.xiptext+0x4bf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:240:(.xiptext+0x4d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x4db): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x4f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x4f8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x50c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `__arch_swab32':
   arch/xtensa/include/uapi/asm/swab.h:24:(.xiptext+0x520): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x56c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x577): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x58a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:263:(.xiptext+0x59e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:265:(.xiptext+0x5ec): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:266:(.xiptext+0x5f6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_read_query16':
   include/linux/mtd/cfi.h:325:(.xiptext+0x612): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:327:(.xiptext+0x62a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:330:(.xiptext+0x63e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:325:(.xiptext+0x690): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:327:(.xiptext+0x6aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:330:(.xiptext+0x6c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:271:(.xiptext+0x713): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_read_query':
   include/linux/mtd/cfi.h:309:(.xiptext+0x72b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:309:(.xiptext+0x73f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:311:(.xiptext+0x74c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:313:(.xiptext+0x75c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text.unlikely+0x4)
   include/linux/mtd/cfi.h:314:(.xiptext+0x764): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `__arch_swab16':
   arch/xtensa/include/uapi/asm/swab.h:60:(.xiptext+0x770): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_read_query':
   include/linux/mtd/cfi.h:314:(.xiptext+0x77a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/cfi.h:319:(.xiptext+0x787): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `__arch_swab32':
   arch/xtensa/include/uapi/asm/swab.h:24:(.xiptext+0x794): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   arch/xtensa/include/uapi/asm/swab.h:24:(.xiptext+0x79e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_read_query':
   include/linux/mtd/cfi.h:309:(.xiptext+0x7b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
>> include/linux/mtd/cfi.h:314:(.xiptext+0x7ee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_probe.o: in function `__arch_swab16':
   arch/xtensa/include/uapi/asm/swab.h:60:(.xiptext+0x7f8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_read_query':
   include/linux/mtd/cfi.h:319:(.xiptext+0x80e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:272:(.xiptext+0x828): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_probe.c:277:(.xiptext+0x853): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_early_fixup':
   drivers/mtd/chips/cfi_probe.c:85:(.xiptext+0x873): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:281:(.xiptext+0x884): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:281:(.xiptext+0x8ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x907): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x91e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x92f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x93c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_probe_chip':
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x970): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x97b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:102:(.xiptext+0x993): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:108:(.xiptext+0x9ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:105:(.xiptext+0x9b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:115:(.xiptext+0x9c3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:116:(.xiptext+0x9d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:116:(.xiptext+0x9eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
>> drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0xe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x18): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_present':
   drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x2c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:222:(.xiptext+0x3c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:226:(.xiptext+0x4a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:227:(.xiptext+0x57): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:228:(.xiptext+0x74): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:230:(.xiptext+0x8a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:240:(.xiptext+0xd2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_util.c:244:(.xiptext+0xdf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:244:(.xiptext+0xec): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:287:(.xiptext+0x106): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:287:(.xiptext+0x110): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x124): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x133): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x15c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x167): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_off':
   drivers/mtd/chips/cfi_util.c:292:(.xiptext+0x18a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_util.c:292:(.xiptext+0x197): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x1a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x1ba): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_off':
   drivers/mtd/chips/cfi_util.c:294:(.xiptext+0x1c8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x1e8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x1f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x21c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x228): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x240): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x24c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x25f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x26b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x28b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x297): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x2bc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x2c8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:44:(.xiptext+0x2db): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x2e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x30b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x317): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x340): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x34c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x35f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x36b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x390): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:207:(.xiptext+0x39c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x3b4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   drivers/mtd/chips/cfi_util.c:259:(.xiptext+0x3c0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x3cc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:43:(.xiptext+0x3f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:44:(.xiptext+0x403): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x416): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:207:(.xiptext+0x422): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   drivers/mtd/chips/cfi_util.c:264:(.xiptext+0x447): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x453): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:43:(.xiptext+0x478): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:44:(.xiptext+0x484): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x497): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x4a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:42:(.xiptext+0x4c7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:42:(.xiptext+0x4d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:44:(.xiptext+0x4e6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:54:(.xiptext+0x4f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:55:(.xiptext+0x500): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:43:(.xiptext+0x52c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:44:(.xiptext+0x538): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x54c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:207:(.xiptext+0x558): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x577): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   drivers/mtd/chips/cfi_util.c:271:(.xiptext+0x583): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:44:(.xiptext+0x5ba): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x5c3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x5d4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x5df): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x5fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:43:(.xiptext+0x606): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:207:(.xiptext+0x643): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x658): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:43:(.xiptext+0x66e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   drivers/mtd/chips/cfi_util.c:282:(.xiptext+0x6c3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_util.c:299:(.xiptext+0x6e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0020.o: in function `cfi_staa_erase_varsize':
   drivers/mtd/chips/cfi_cmdset_0020.c:952:(.text+0x2987): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_read_pri
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_erase_varsize':
   drivers/mtd/chips/cfi_cmdset_0002.c:132:(.text+0xd47): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x140)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_use_status_reg':
   drivers/mtd/chips/cfi_cmdset_0002.c:123:(.text+0xd8b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x140)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `kmalloc_array':
   drivers/mtd/chips/cfi_cmdset_0002.c:292:(.text+0xf27): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x140)
   drivers/mtd/chips/cfi_cmdset_0002.c:292:(.text+0xf3a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x140)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_panic_write_oneword':
   drivers/mtd/chips/cfi_cmdset_0002.c:2278:(.text+0x131a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x140)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `fixup_sst38vf640x_sectorsize':
   drivers/mtd/chips/cfi_cmdset_0002.c:392:(.text+0x142a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x140)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_atmel_unlock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2682:(.text+0x1b2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xea0)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_atmel_lock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2657:(.text+0x1db0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x140)
   drivers/mtd/chips/cfi_cmdset_0002.c:2666:(.text+0x1de8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x2d8)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_panic_write':
   drivers/mtd/chips/cfi_cmdset_0002.c:2348:(.text+0x2d64): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xe3c)
   drivers/mtd/chips/cfi_cmdset_0002.c:2388:(.text+0x2ec4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_on
   drivers/mtd/chips/cfi_cmdset_0002.c:2401:(.text+0x2f57): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_off
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_otp_walk':
   drivers/mtd/chips/cfi_cmdset_0002.c:1484:(.text+0x392e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xe3c)
   drivers/mtd/chips/cfi_cmdset_0002.c:1512:(.text+0x3a3b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xe3c)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_read_query':
   include/linux/mtd/cfi.h:313:(.text+0x3c12): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xe3c)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_otp_walk':
   drivers/mtd/chips/cfi_cmdset_0002.c:1589:(.text+0x3dbf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x1368)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_read_secsi_onechip':
   drivers/mtd/chips/cfi_cmdset_0002.c:1313:(.text+0x4092): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x140)
   drivers/mtd/chips/cfi_cmdset_0002.c:1313:(.text+0x40c9): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x2d8)
   drivers/mtd/chips/cfi_cmdset_0002.c:1818:(.text+0x444c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_read_pri
   drivers/mtd/chips/cfi_cmdset_0002.o:drivers/mtd/chips/cfi_cmdset_0002.c:1032:(.xiptext+0x6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
>> drivers/mtd/chips/cfi_cmdset_0002.o:drivers/mtd/chips/cfi_cmdset_0002.c:1032:(.xiptext+0x12): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_enable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1032:(.xiptext+0x24): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1035:(.xiptext+0x30): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1033:(.xiptext+0x3f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1036:(.xiptext+0x50): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1036:(.xiptext+0x5f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1039:(.xiptext+0x86): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1042:(.xiptext+0x94): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1998:(.xiptext+0x9e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1998:(.xiptext+0xac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1998:(.xiptext+0xc3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1998:(.xiptext+0xcc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_reset':
   drivers/mtd/chips/cfi_cmdset_0002.c:1998:(.xiptext+0xd6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2007:(.xiptext+0xe2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2007:(.xiptext+0xf6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2007:(.xiptext+0xfe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2007:(.xiptext+0x108): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2007:(.xiptext+0x112): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2009:(.xiptext+0x127): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2009:(.xiptext+0x146): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:2011:(.xiptext+0x14f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2011:(.xiptext+0x15a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2011:(.xiptext+0x167): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:2011:(.xiptext+0x178): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:2015:(.xiptext+0x18f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:834:(.xiptext+0x19a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:834:(.xiptext+0x1a7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:834:(.xiptext+0x1b3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_ready':
   drivers/mtd/chips/cfi_cmdset_0002.c:834:(.xiptext+0x1ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:834:(.xiptext+0x1d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_use_status_reg':
   drivers/mtd/chips/cfi_cmdset_0002.c:126:(.xiptext+0x1fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:126:(.xiptext+0x20e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_ready':
   drivers/mtd/chips/cfi_cmdset_0002.c:845:(.xiptext+0x228): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:845:(.xiptext+0x256): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:847:(.xiptext+0x25f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:847:(.xiptext+0x26b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:865:(.xiptext+0x2de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_good':
   drivers/mtd/chips/cfi_cmdset_0002.c:865:(.xiptext+0x2ea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:866:(.xiptext+0x2fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:870:(.xiptext+0x30c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x348): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x35a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x36f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x37e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x392): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x3a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x3e6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1060:(.xiptext+0x40c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1061:(.xiptext+0x41e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1068:(.xiptext+0x42f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1068:(.xiptext+0x43f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_cmdset_0002.c:1068:(.xiptext+0x454): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1068:(.xiptext+0x466): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1069:(.xiptext+0x47b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1070:(.xiptext+0x496): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1081:(.xiptext+0x4a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __might_resched
   drivers/mtd/chips/cfi_cmdset_0002.c:1081:(.xiptext+0x4b0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1081:(.xiptext+0x4b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1083:(.xiptext+0x4e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x10a4)
   drivers/mtd/chips/cfi_cmdset_0002.c:1085:(.xiptext+0x4eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1094:(.xiptext+0x500): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1099:(.xiptext+0x53c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_cmdset_0002.c:1102:(.xiptext+0x550): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1102:(.xiptext+0x55a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1103:(.xiptext+0x564): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1103:(.xiptext+0x578): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1103:(.xiptext+0x580): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1104:(.xiptext+0x58e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `arch_local_irq_enable':
>> arch/xtensa/include/asm/irqflags.h:61:(.xiptext+0x5a0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1107:(.xiptext+0x5aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1109:(.xiptext+0x5b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1117:(.xiptext+0x5c0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1117:(.xiptext+0x5c6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x5d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x5da): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1082:(.xiptext+0x5e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1134:(.xiptext+0x614): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x672): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1120:(.xiptext+0x683): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1120:(.xiptext+0x68f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __usecs_to_jiffies
   drivers/mtd/chips/cfi_cmdset_0002.c:1120:(.xiptext+0x69c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0x6b2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1120:(.xiptext+0x6c4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_cmdset_0002.c:1122:(.xiptext+0x6d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1124:(.xiptext+0x6e0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1125:(.xiptext+0x6ea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x6fe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x706): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x713): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1142:(.xiptext+0x724): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1144:(.xiptext+0x72f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0x743): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1147:(.xiptext+0x74e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1147:(.xiptext+0x754): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:1147:(.xiptext+0x75f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1147:(.xiptext+0x767): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1147:(.xiptext+0x776): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1943:(.xiptext+0x787): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1943:(.xiptext+0x7ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:1943:(.xiptext+0x7c8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xa88)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_wait':
   drivers/mtd/chips/cfi_cmdset_0002.c:1953:(.xiptext+0x80a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1953:(.xiptext+0x81c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1956:(.xiptext+0x82a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1958:(.xiptext+0x838): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1958:(.xiptext+0x852): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1958:(.xiptext+0x85b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1960:(.xiptext+0x868): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0x874): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_wait':
   drivers/mtd/chips/cfi_cmdset_0002.c:1960:(.xiptext+0x88a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0x893): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_wait':
   drivers/mtd/chips/cfi_cmdset_0002.c:1960:(.xiptext+0x8a2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1961:(.xiptext+0x8ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1962:(.xiptext+0x8c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1964:(.xiptext+0x8cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1966:(.xiptext+0x8e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1967:(.xiptext+0x8ef): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1975:(.xiptext+0x907): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1976:(.xiptext+0x913): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1982:(.xiptext+0x926): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_cmdset_0002.c:1983:(.xiptext+0x940): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1989:(.xiptext+0x94e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1993:(.xiptext+0x95c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1993:(.xiptext+0x970): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1993:(.xiptext+0x978): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x98a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x99e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x9a8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x9bb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x9ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x9d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x9db): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x9e3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x9f3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0xa03): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_once':
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0xa2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:1663:(.xiptext+0xa37): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1663:(.xiptext+0xa62): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xa88)
   drivers/mtd/chips/cfi_cmdset_0002.c:1664:(.xiptext+0xa9a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1665:(.xiptext+0xaa7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1665:(.xiptext+0xab7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1665:(.xiptext+0xad3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1666:(.xiptext+0xae0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1667:(.xiptext+0xaf3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1669:(.xiptext+0xb06): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `current_thread_info':
   arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0xb44): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_once':
   drivers/mtd/chips/cfi_cmdset_0002.c:1678:(.xiptext+0xb53): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1678:(.xiptext+0xb5f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0xb92): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_once':
   drivers/mtd/chips/cfi_cmdset_0002.c:1680:(.xiptext+0xba3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0xbb2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_once':
   drivers/mtd/chips/cfi_cmdset_0002.c:1680:(.xiptext+0xbc4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1681:(.xiptext+0xbd0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1682:(.xiptext+0xbde): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1684:(.xiptext+0xbf3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

