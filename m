Return-Path: <linux-kernel+bounces-120176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A874388D3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CD71C256CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02EF1F60A;
	Wed, 27 Mar 2024 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWCTMbX0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270601B7E9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711503132; cv=none; b=UYRJsiHZQ9sa9wXOqBBpBW7woaxilblvFhHeo9aRkMZKu97crpEdietTDiKU484r77UA9DY6YRS/zzx/MqrDVyD4NOq0poVEDKumc46StveoGYbKcm2HcH9ds97USdQrUc1ySyQfKFD+DXbiZl2t483mWWhVIwIGLCoRpCB8RNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711503132; c=relaxed/simple;
	bh=oyJhkrf5+4q6Rj00ipS4yr2mBgxGEjpmjv8jYMXPJXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AT1xhCBNhj5lzLJzrdtgVNnDPZpD7tzSs14uyvR8OMUT45YuqFxT0SbzM7nSQO54SLgXfFU6ohLrwYvaJtRT+kZWDkT7VHm7l1DU+pKSvV5F/Cu9eYZKt8gxPDbu93ZhIqMlY8bJk91c8wQ1/Fxd6esFMCDyetig+pCnBHvJAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWCTMbX0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711503130; x=1743039130;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oyJhkrf5+4q6Rj00ipS4yr2mBgxGEjpmjv8jYMXPJXM=;
  b=HWCTMbX0zvZPuoYZ3j1TXUCKKYXgUiaQgdm4YXNzosw0SH6HVxIml3Zb
   Y0vdElNULsMeKFKxS9MClqHFm85R7RhoWHxJ95LZlo33NiIoCIZ+MvVsQ
   yuzuBje86780dTEkiZble+T7X9QgEv/aKgCBKckq4k2k0K8vcuDGVSJnZ
   2DhH7N42blvJhgx5pIJSPQHlz0vCT41G4n6WCb5iob13BDI4kHpI3Tb+p
   7V/JAr8yauRrQ2POUESB9WOYr+D83icWSbLoz+j6IimmbXqgdw7OTh873
   RmsE34BBjMcxh9OFF7WlFQKGbcbpPs5xMkZxML8aBNdQMwxT+Xwy+si5B
   w==;
X-CSE-ConnectionGUID: m6MCYs6cTe6jeppHRQqc/Q==
X-CSE-MsgGUID: czrkdTFYTx6Er+lxY68VWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17128748"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="17128748"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 18:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="53599545"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Mar 2024 18:32:07 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpI96-0000bm-3C;
	Wed, 27 Mar 2024 01:32:04 +0000
Date: Wed, 27 Mar 2024 09:31:24 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0xe4f): dangerous
 relocation: windowed longcall crosses 1GB boundary; return may fail:
 cfi_send_gen_cmd
Message-ID: <202403270911.zJulbFv9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7033999ecd7b8cf9ea59265035a0150961e023ee
commit: 2416a2e7be9b27157f173268f5c7f769bd72a8dc mtd: chips: remove redundant assignment to variable timeo
date:   4 weeks ago
config: xtensa-randconfig-r006-20221106 (https://download.01.org/0day-ci/archive/20240327/202403270911.zJulbFv9-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240327/202403270911.zJulbFv9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403270911.zJulbFv9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_cmdset_0002.c:1862:(.text+0x329a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x1474)
   drivers/mtd/chips/cfi_cmdset_0002.c:1904:(.text+0x343b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_on
   drivers/mtd/chips/cfi_cmdset_0002.c:1916:(.text+0x34c3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_off
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_otp_walk':
   drivers/mtd/chips/cfi_cmdset_0002.c:1587:(.text+0x3c87): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x518)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_lock_user_prot_reg':
   drivers/mtd/chips/cfi_cmdset_0002.c:1638:(.text+0x3cda): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x11c)
   drivers/mtd/chips/cfi_cmdset_0002.o:drivers/mtd/chips/cfi_cmdset_0002.c:1031:(.xiptext+0xa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_enable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1035:(.xiptext+0x2c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x6e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_reset':
   drivers/mtd/chips/cfi_cmdset_0002.c:1997:(.xiptext+0x86): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2006:(.xiptext+0x9a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2008:(.xiptext+0xaf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1058:(.xiptext+0x122): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1058:(.xiptext+0x144): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x1a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1084:(.xiptext+0x226): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x262): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x286): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1102:(.xiptext+0x294): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __might_resched
   drivers/mtd/chips/cfi_cmdset_0002.c:1102:(.xiptext+0x29a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __cond_resched
   drivers/mtd/chips/cfi_cmdset_0002.c:1102:(.xiptext+0x2a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1108:(.xiptext+0x2ce): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x4b0)
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x33f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x35b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x363): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x369): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x374): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x37e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1143:(.xiptext+0x3f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:1144:(.xiptext+0x422): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0x44f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1738:(.xiptext+0x463): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_done':
   drivers/mtd/chips/cfi_cmdset_0002.c:1738:(.xiptext+0x478): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `otp_exit':
   drivers/mtd/chips/cfi_cmdset_0002.c:1295:(.xiptext+0x48c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1301:(.xiptext+0x4e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1178)
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0x4eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_done':
   drivers/mtd/chips/cfi_cmdset_0002.c:1743:(.xiptext+0x51e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1747:(.xiptext+0x54f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1747:(.xiptext+0x56b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_ready':
   drivers/mtd/chips/cfi_cmdset_0002.c:848:(.xiptext+0x622): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_good':
   drivers/mtd/chips/cfi_cmdset_0002.c:868:(.xiptext+0x692): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:868:(.xiptext+0x6aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __usecs_to_jiffies
   drivers/mtd/chips/cfi_cmdset_0002.c:872:(.xiptext+0x6ec): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1942:(.xiptext+0x70b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1942:(.xiptext+0x71a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_wait':
   drivers/mtd/chips/cfi_cmdset_0002.c:1942:(.xiptext+0x720): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `usecs_to_jiffies':
   include/linux/jiffies.h:571:(.xiptext+0x72b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   include/linux/jiffies.h:571:(.xiptext+0x73e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_wait':
   drivers/mtd/chips/cfi_cmdset_0002.c:1959:(.xiptext+0x776): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:1961:(.xiptext+0x7a2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x9ec)
   drivers/mtd/chips/cfi_cmdset_0002.c:1973:(.xiptext+0x7e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:1981:(.xiptext+0x822): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1988:(.xiptext+0x84a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1977:(.xiptext+0x85e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1992:(.xiptext+0x873): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1648:(.xiptext+0x8db): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_once':
   drivers/mtd/chips/cfi_cmdset_0002.c:1648:(.xiptext+0x8fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1662:(.xiptext+0x907): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1662:(.xiptext+0x90d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:1648:(.xiptext+0x918): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1663:(.xiptext+0x92a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1673:(.xiptext+0x96f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:1677:(.xiptext+0x9aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x9ec)
   drivers/mtd/chips/cfi_cmdset_0002.c:1685:(.xiptext+0x9f6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:1695:(.xiptext+0xa2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1713:(.xiptext+0xaf3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_retry':
   drivers/mtd/chips/cfi_cmdset_0002.c:1771:(.xiptext+0xb5a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1771:(.xiptext+0xb68): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1772:(.xiptext+0xb77): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1250)
   drivers/mtd/chips/cfi_cmdset_0002.c:1772:(.xiptext+0xb8e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1779:(.xiptext+0xbc0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1779:(.xiptext+0xbd4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1777:(.xiptext+0xbea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1718:(.xiptext+0xc36): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `otp_enter':
   drivers/mtd/chips/cfi_cmdset_0002.c:1284:(.xiptext+0xcd6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword':
   drivers/mtd/chips/cfi_cmdset_0002.c:1804:(.xiptext+0xd44): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1804:(.xiptext+0xd52): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1250)
   drivers/mtd/chips/cfi_cmdset_0002.c:1809:(.xiptext+0xd67): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0xdeb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0xe03): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0xe1c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2412:(.xiptext+0xe36): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `current_thread_info':
>> arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0xe4f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_ff':
   include/linux/mtd/map.h:378:(.xiptext+0xe67): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2426:(.xiptext+0xec3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:2433:(.xiptext+0xeea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2433:(.xiptext+0xef2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2434:(.xiptext+0xef8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:2434:(.xiptext+0xf04): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2434:(.xiptext+0xf0e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2440:(.xiptext+0xf66): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x9ec)
   drivers/mtd/chips/cfi_cmdset_0002.c:2443:(.xiptext+0xfb6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:2448:(.xiptext+0xfea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2460:(.xiptext+0x104a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1178)
   drivers/mtd/chips/cfi_cmdset_0002.c:2461:(.xiptext+0x1052): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2463:(.xiptext+0x1063): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:2474:(.xiptext+0x10ba): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:2480:(.xiptext+0x1124): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2488:(.xiptext+0x1132): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1250)
   drivers/mtd/chips/cfi_cmdset_0002.c:2493:(.xiptext+0x1147): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x11d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x11e8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x1202): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2509:(.xiptext+0x121c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2513:(.xiptext+0x1234): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2513:(.xiptext+0x129b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_ff':
   include/linux/mtd/map.h:381:(.xiptext+0x12c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   include/linux/mtd/map.h:381:(.xiptext+0x12ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   include/linux/mtd/map.h:381:(.xiptext+0x12d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2521:(.xiptext+0x12dc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2521:(.xiptext+0x12e6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2533:(.xiptext+0x133e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x9ec)
   drivers/mtd/chips/cfi_cmdset_0002.c:2538:(.xiptext+0x138f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:2540:(.xiptext+0x13c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2546:(.xiptext+0x1422): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1178)
   drivers/mtd/chips/cfi_cmdset_0002.c:2546:(.xiptext+0x142a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2550:(.xiptext+0x143b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0x147a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2561:(.xiptext+0x1496): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2563:(.xiptext+0x14a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1250)
   drivers/mtd/chips/cfi_cmdset_0002.c:2567:(.xiptext+0x14bb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2596:(.xiptext+0x15a6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2602:(.xiptext+0x15bc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2604:(.xiptext+0x15cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2605:(.xiptext+0x15ef): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2034:(.xiptext+0x16ba): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2044:(.xiptext+0x173a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1178)
   drivers/mtd/chips/cfi_cmdset_0002.c:2044:(.xiptext+0x1742): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
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


vim +97 arch/xtensa/include/asm/thread_info.h

9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   92  
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   93  /* how to get the thread information struct from C */
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   94  static inline struct thread_info *current_thread_info(void)
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   95  {
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   96  	struct thread_info *ti;
f4431396be5b26 arch/xtensa/include/asm/thread_info.h Max Filippov 2017-12-04  @97  	 __asm__("extui %0, a1, 0, "__stringify(CURRENT_SHIFT)"\n\t"
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   98  	         "xor %0, a1, %0" : "=&r" (ti) : );
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23   99  	return ti;
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23  100  }
9a8fd558990215 include/asm-xtensa/thread_info.h      Chris Zankel 2005-06-23  101  

:::::: The code at line 97 was first introduced by commit
:::::: f4431396be5b26a9960daf502d129b1b5d126f5e xtensa: consolidate kernel stack size related definitions

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Max Filippov <jcmvbkbc@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

