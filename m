Return-Path: <linux-kernel+bounces-120012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E31E88D01E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EF31C30978
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A182813D881;
	Tue, 26 Mar 2024 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PokYdn/U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C513D62B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488788; cv=none; b=VD3IMIJLkmggxhYcSN2z9URDS8IwBf1F1RNTkmq5vQayYrvIHA3LFI47b1YT8TCuFSoagZksOri2SZrCv6zg2N4pgdxbau/TjQ/Y1dBwHi9WRs1uJdDLRjFWQDknsxecB/yjehGFSDy8Hp8vews8g7iN/RhxCGHQYeaG8FgFv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488788; c=relaxed/simple;
	bh=GZYY7L7hB+TuZGSXE4Nc3v/uSxJZ5hH2WXz4W0FIqyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fPmGuzYwt7uwC+tAKqHCbRpFQFrovNvvNf5bYm6+gNQrXT9CexIOAzYpuUdG0AbygDklp41I2/8NU7louRMR+Hh/RYRptW1e2b6sNmc356YHoLugH5d331jZetWXWl9nNOTlumi4HH4LGk5pNmZ7egm82EOiFOGxq6iCtNGojlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PokYdn/U; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711488785; x=1743024785;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GZYY7L7hB+TuZGSXE4Nc3v/uSxJZ5hH2WXz4W0FIqyI=;
  b=PokYdn/Uq/7wf0i44enSJCIzw/oInQF58ktXcT+HC5w+SOFakXZQpqwx
   hGK9rW7oii/tyXZLpvlLwyigoHJ1wiXoDzTsyGJ1/PLwG4FU4PnYLUKDR
   zQ4/4ELmnjyfJH2b6kBCf8Ak4x5078w3k1CEYSK+JiEa5ehDeUaoDZfeC
   KBPtEcBSpVeBDh4+O4/65HpmgynVxAHYyG6l6U6bpkOD7dlttNbdeHAm7
   8TjZM7J9vSPRwga0YL9s/zikWmkzKrJUaiDohDjMh4tcXheWh2cG5h1tN
   hAXADwajFVLfrLhXwRaQnwsie+ilsmrGQs5UlWriUwen5BESZT8jqZECq
   w==;
X-CSE-ConnectionGUID: oA588sh8TlWCHoJI7oj1Uw==
X-CSE-MsgGUID: dFVRwlsLScuIsydmQNyHHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10363747"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="10363747"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 14:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16524508"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Mar 2024 14:33:02 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpEPj-0000Qe-1k;
	Tue, 26 Mar 2024 21:32:59 +0000
Date: Wed, 27 Mar 2024 05:32:31 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: arch/xtensa/include/asm/irqflags.h:47:(.xiptext+0x13be): dangerous
 relocation: windowed longcall crosses 1GB boundary; return may fail:
 __tsan_read1
Message-ID: <202403270530.uZWDwugD-lkp@intel.com>
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
commit: 2416a2e7be9b27157f173268f5c7f769bd72a8dc mtd: chips: remove redundant assignment to variable timeo
date:   4 weeks ago
config: xtensa-randconfig-r032-20221230 (https://download.01.org/0day-ci/archive/20240327/202403270530.uZWDwugD-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240327/202403270530.uZWDwugD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403270530.uZWDwugD-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_cmdset_0002.c:1779:(.xiptext+0xd97): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1779:(.xiptext+0xda0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1779:(.xiptext+0xdaa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1790:(.xiptext+0xdb6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1738:(.xiptext+0xdca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1738:(.xiptext+0xdd2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1738:(.xiptext+0xdde): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1738:(.xiptext+0xde8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1738:(.xiptext+0xdfe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1738:(.xiptext+0xe07): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1738:(.xiptext+0xe13): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_done':
   drivers/mtd/chips/cfi_cmdset_0002.c:1740:(.xiptext+0xe3e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1740:(.xiptext+0xe47): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `otp_exit':
   drivers/mtd/chips/cfi_cmdset_0002.c:1297:(.xiptext+0xea2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1297:(.xiptext+0xeab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1297:(.xiptext+0xebc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_cmdset_0002.c:1299:(.xiptext+0xed7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1299:(.xiptext+0xee3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1299:(.xiptext+0xeee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1299:(.xiptext+0xefc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1301:(.xiptext+0xf22): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0xf38): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0xf46): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x19f0)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_done':
   drivers/mtd/chips/cfi_cmdset_0002.c:1742:(.xiptext+0xf57): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1743:(.xiptext+0xf68): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1746:(.xiptext+0xf80): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1747:(.xiptext+0xf94): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0xfe2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_start':
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0xfef): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1721:(.xiptext+0xffb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1723:(.xiptext+0x1012): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1724:(.xiptext+0x101b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1729:(.xiptext+0x1027): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1730:(.xiptext+0x1032): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `otp_enter':
   drivers/mtd/chips/cfi_cmdset_0002.c:1280:(.xiptext+0x104a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1280:(.xiptext+0x1053): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1280:(.xiptext+0x105f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1280:(.xiptext+0x106b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1280:(.xiptext+0x1082): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1282:(.xiptext+0x108b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1282:(.xiptext+0x1097): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1282:(.xiptext+0x10a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1284:(.xiptext+0x10ba): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1284:(.xiptext+0x10c3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1284:(.xiptext+0x10cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1284:(.xiptext+0x10da): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1287:(.xiptext+0x10f2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1287:(.xiptext+0x10fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1287:(.xiptext+0x1107): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_start':
   drivers/mtd/chips/cfi_cmdset_0002.c:1733:(.xiptext+0x1112): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword':
   drivers/mtd/chips/cfi_cmdset_0002.c:1795:(.xiptext+0x1128): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1795:(.xiptext+0x1132): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1798:(.xiptext+0x113e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_cmdset_0002.c:1807:(.xiptext+0x1153): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1809:(.xiptext+0x1162): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x116e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x117c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1812:(.xiptext+0x119c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x11ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x11c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x11d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x11e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x11f6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1200): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1212): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x121b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1221): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x122c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1237): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1242): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1250): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x125f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x1286): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xa88)
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x129b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0x12af): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2413:(.xiptext+0x12cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2416:(.xiptext+0x12da): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2416:(.xiptext+0x12e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2416:(.xiptext+0x1306): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_ff':
   include/linux/mtd/map.h:378:(.xiptext+0x131b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2421:(.xiptext+0x1333): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x18b0)
   drivers/mtd/chips/cfi_cmdset_0002.c:2421:(.xiptext+0x133e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2424:(.xiptext+0x135e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:2425:(.xiptext+0x1367): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2433:(.xiptext+0x1378): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2433:(.xiptext+0x138e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2434:(.xiptext+0x139c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x19f0)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1025:(.xiptext+0x13b0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `arch_local_irq_save':
>> arch/xtensa/include/asm/irqflags.h:47:(.xiptext+0x13be): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1027:(.xiptext+0x13d2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2450:(.xiptext+0x13ee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_cmdset_0002.c:2438:(.xiptext+0x141e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2439:(.xiptext+0x1438): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2439:(.xiptext+0x144c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2439:(.xiptext+0x1462): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2440:(.xiptext+0x146e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2440:(.xiptext+0x1480): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2440:(.xiptext+0x149a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2441:(.xiptext+0x14a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2441:(.xiptext+0x14af): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2441:(.xiptext+0x14bb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2441:(.xiptext+0x14d2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2442:(.xiptext+0x14df): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2442:(.xiptext+0x14f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2442:(.xiptext+0x1508): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2443:(.xiptext+0x1514): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2443:(.xiptext+0x1523): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2443:(.xiptext+0x1533): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2443:(.xiptext+0x1544): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2446:(.xiptext+0x155e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:2447:(.xiptext+0x1572): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_cmdset_0002.c:2450:(.xiptext+0x158e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_cmdset_0002.c:2454:(.xiptext+0x15bb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2459:(.xiptext+0x15d2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2459:(.xiptext+0x15fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2459:(.xiptext+0x1608): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2459:(.xiptext+0x161b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2460:(.xiptext+0x162b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2467:(.xiptext+0x1662): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2470:(.xiptext+0x166c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2471:(.xiptext+0x1682): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x18b0)
   drivers/mtd/chips/cfi_cmdset_0002.c:2474:(.xiptext+0x168a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2480:(.xiptext+0x16b6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:2480:(.xiptext+0x16bf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2488:(.xiptext+0x16d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_cmdset_0002.c:2493:(.xiptext+0x16eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2493:(.xiptext+0x16f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2493:(.xiptext+0x1702): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2496:(.xiptext+0x1710): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2503:(.xiptext+0x172e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2504:(.xiptext+0x1744): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2506:(.xiptext+0x1752): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x19f0)
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x1763): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2022:(.xiptext+0x1780): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2022:(.xiptext+0x1794): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2022:(.xiptext+0x17f6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2022:(.xiptext+0x1803): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2022:(.xiptext+0x180f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2022:(.xiptext+0x1826): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2023:(.xiptext+0x182f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2029:(.xiptext+0x183b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2032:(.xiptext+0x1846): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2035:(.xiptext+0x185e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_load':
   include/linux/mtd/map.h:325:(.xiptext+0x1867): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/map.h:326:(.xiptext+0x1873): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/map.h:326:(.xiptext+0x187f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/map.h:328:(.xiptext+0x1896): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   include/linux/mtd/map.h:328:(.xiptext+0x189f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/map.h:330:(.xiptext+0x18ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/map.h:330:(.xiptext+0x18b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   include/linux/mtd/map.h:338:(.xiptext+0x18ce): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2044:(.xiptext+0x18d7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2044:(.xiptext+0x18e3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2045:(.xiptext+0x18ee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1025:(.xiptext+0x1906): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1025:(.xiptext+0x1912): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2048:(.xiptext+0x1927): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2048:(.xiptext+0x1933): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_cmdset_0002.c:2048:(.xiptext+0x1948): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2048:(.xiptext+0x1956): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2049:(.xiptext+0x1964): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2049:(.xiptext+0x1984): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2052:(.xiptext+0x1993): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2052:(.xiptext+0x19aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:2052:(.xiptext+0x19b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2054:(.xiptext+0x19ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2058:(.xiptext+0x19de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2058:(.xiptext+0x19e8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2061:(.xiptext+0x19fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2061:(.xiptext+0x1a03): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2061:(.xiptext+0x1a09): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_load':
   include/linux/mtd/map.h:326:(.xiptext+0x1a14): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   include/linux/mtd/map.h:326:(.xiptext+0x1a1f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   include/linux/mtd/map.h:328:(.xiptext+0x1a2a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   include/linux/mtd/map.h:328:(.xiptext+0x1a38): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   include/linux/mtd/map.h:330:(.xiptext+0x1a47): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   include/linux/mtd/map.h:338:(.xiptext+0x1a6e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xa88)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2063:(.xiptext+0x1a83): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2061:(.xiptext+0x1a97): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:2073:(.xiptext+0x1ab3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4


vim +47 arch/xtensa/include/asm/irqflags.h

df9ee29270c11d David Howells 2010-10-07  25  
df9ee29270c11d David Howells 2010-10-07  26  static inline unsigned long arch_local_irq_save(void)
df9ee29270c11d David Howells 2010-10-07  27  {
df9ee29270c11d David Howells 2010-10-07  28  	unsigned long flags;
38fef73c21d117 Max Filippov  2015-07-16  29  #if XTENSA_FAKE_NMI
900f492836df43 Sinan Kaya    2019-05-14  30  #if defined(CONFIG_DEBUG_MISC) && (LOCKLEVEL | TOPLEVEL) >= XCHAL_DEBUGLEVEL
38fef73c21d117 Max Filippov  2015-07-16  31  	unsigned long tmp;
38fef73c21d117 Max Filippov  2015-07-16  32  
38fef73c21d117 Max Filippov  2015-07-16  33  	asm volatile("rsr	%0, ps\t\n"
38fef73c21d117 Max Filippov  2015-07-16  34  		     "extui	%1, %0, 0, 4\t\n"
38fef73c21d117 Max Filippov  2015-07-16  35  		     "bgei	%1, "__stringify(LOCKLEVEL)", 1f\t\n"
38fef73c21d117 Max Filippov  2015-07-16  36  		     "rsil	%0, "__stringify(LOCKLEVEL)"\n"
38fef73c21d117 Max Filippov  2015-07-16  37  		     "1:"
38fef73c21d117 Max Filippov  2015-07-16  38  		     : "=a" (flags), "=a" (tmp) :: "memory");
38fef73c21d117 Max Filippov  2015-07-16  39  #else
38fef73c21d117 Max Filippov  2015-07-16  40  	asm volatile("rsr	%0, ps\t\n"
38fef73c21d117 Max Filippov  2015-07-16  41  		     "or	%0, %0, %1\t\n"
38fef73c21d117 Max Filippov  2015-07-16  42  		     "xsr	%0, ps\t\n"
38fef73c21d117 Max Filippov  2015-07-16  43  		     "rsync"
38fef73c21d117 Max Filippov  2015-07-16  44  		     : "=&a" (flags) : "a" (LOCKLEVEL) : "memory");
38fef73c21d117 Max Filippov  2015-07-16  45  #endif
38fef73c21d117 Max Filippov  2015-07-16  46  #else
df9ee29270c11d David Howells 2010-10-07 @47  	asm volatile("rsil	%0, "__stringify(LOCKLEVEL)
df9ee29270c11d David Howells 2010-10-07  48  		     : "=a" (flags) :: "memory");
38fef73c21d117 Max Filippov  2015-07-16  49  #endif
df9ee29270c11d David Howells 2010-10-07  50  	return flags;
df9ee29270c11d David Howells 2010-10-07  51  }
df9ee29270c11d David Howells 2010-10-07  52  

:::::: The code at line 47 was first introduced by commit
:::::: df9ee29270c11dba7d0fe0b83ce47a4d8e8d2101 Fix IRQ flag handling naming

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

