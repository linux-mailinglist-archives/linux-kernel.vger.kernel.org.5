Return-Path: <linux-kernel+bounces-41087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1C83EB9F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3996C1C221BB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8A21D698;
	Sat, 27 Jan 2024 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEc0y3IH"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE801429C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706339687; cv=none; b=dPGTKTejm7ekNXE5ev/108xo5grfxjsJIOuowxtSiIeLZSNXHgoXUi8k32UgcHwVJM9B1kPMwulA5JrH8GWeC+4lHVdIr4ucYznhjThhaZUxQLVIag5cgkUFJu5ao0eVQYrFVUspRvyfSHudGJM5W35y6PHny+EyipF3PbvbSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706339687; c=relaxed/simple;
	bh=zpW4yjsR4RLVc4Czp+3ICSyemOjtQIlB8Ti2oPxfaXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NuPr0j4S2VC0QUvZSS1iWWZTCFa/J1PJ3Ivda1qaF25ju3IL6qJH4excRADWOuybJKJ5ltkxE9d+O2dyTEodG218bIrVnCwV+Y3sh1DGNsR3aI/9yhuuA/7G1S3jAvX+M1HBjlLL9nbPe1W7qVbw20L8nV2Hojw99qRD54wub2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEc0y3IH; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706339683; x=1737875683;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zpW4yjsR4RLVc4Czp+3ICSyemOjtQIlB8Ti2oPxfaXM=;
  b=VEc0y3IHC31YI5sl1vwI9mTtTRnqoDB8m/c3sKjP8piBOMfRepIvoDuB
   ew2AllyhY4bsr8JO5v0xOw5ujhkr2IA52jUBPDinKUSPXh6rZY6qGxjtj
   4Z/dZMvKEbp1sgyTJuQLLUnqf3lwZUvB9Q9mi0Ppf4F5X34JOiFvMuyMe
   ee20vc07rCbxyilP7XYlX/8hf1Gd3wt47OYPq8VPO3dJ1B8q1dnRN7pqn
   btZE4zcRkIyX07EDTaDqxdjJJU6NQQwfK272D19KdxuTXxrXnNxrZODmI
   20cHYa/TSdLyCTIFZmy4k5hvnuhytTeAjH5UdwmklcCQ/AWF9bnfMFmz9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399817242"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="399817242"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 23:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="906536720"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="906536720"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2024 23:14:40 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTcti-0001j8-2X;
	Sat, 27 Jan 2024 07:14:38 +0000
Date: Sat, 27 Jan 2024 15:14:34 +0800
From: kernel test robot <lkp@intel.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/xtensa/include/asm/irqflags.h:61:(.xiptext+0x5eb): dangerous
 relocation: windowed longcall crosses 1GB boundary; return may fail:
 (.text.unlikely+0x4)
Message-ID: <202401271505.hI6wsuNX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a5879d495b226d0404098e3564462d5f1daa33b
commit: 03ce34cf8f50e4c62f9a4b62caffdba1165ca977 xtensa: add XIP-aware MTD support
date:   5 months ago
config: xtensa-randconfig-r006-20221106 (https://download.01.org/0day-ci/archive/20240127/202401271505.hI6wsuNX-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401271505.hI6wsuNX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401271505.hI6wsuNX-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x5e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_probe.o: in function `kmalloc':
   include/linux/slab.h:575:(.xiptext+0x130): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:212:(.xiptext+0x156): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memset
   drivers/mtd/chips/cfi_probe.c:212:(.xiptext+0x166): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x36c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.c:263:(.xiptext+0x382): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.c:264:(.xiptext+0x396): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.c:265:(.xiptext+0x3ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.o: in function `arch_local_irq_enable':
>> arch/xtensa/include/asm/irqflags.h:61:(.xiptext+0x5eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text.unlikely+0x4)
   drivers/mtd/chips/cfi_probe.o: in function `cfi_early_fixup':
   drivers/mtd/chips/cfi_probe.c:84:(.xiptext+0x618): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:286:(.xiptext+0x66a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x68a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x6b6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_probe.o: in function `cfi_probe_chip':
   drivers/mtd/chips/cfi_probe.c:142:(.xiptext+0x7da): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_probe.c:154:(.xiptext+0x850): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x26): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_present':
   drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x42): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:226:(.xiptext+0x52): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:227:(.xiptext+0x60): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
>> drivers/mtd/chips/cfi_util.c:240:(.xiptext+0x102): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_util.c:244:(.xiptext+0x126): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_util.c:287:(.xiptext+0x133): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_off':
   drivers/mtd/chips/cfi_util.c:287:(.xiptext+0x14b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:292:(.xiptext+0x18c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:294:(.xiptext+0x1d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_util.c:294:(.xiptext+0x1e3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x20c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   drivers/mtd/chips/cfi_util.c:249:(.xiptext+0x23f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x257): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x280): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x2bb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:207:(.xiptext+0x2e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x317): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x347): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
>> drivers/mtd/chips/cfi_util.c:264:(.xiptext+0x360): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd_addr
   drivers/mtd/chips/cfi_util.c:264:(.xiptext+0x36f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x39f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x3d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x400): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:213:(.xiptext+0x418): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd_addr
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   drivers/mtd/chips/cfi_util.c:271:(.xiptext+0x426): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_build_cmd_addr':
   drivers/mtd/chips/cfi_util.c:47:(.xiptext+0x454): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_send_gen_cmd':
   drivers/mtd/chips/cfi_util.c:208:(.xiptext+0x4aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   drivers/mtd/chips/cfi_util.c:278:(.xiptext+0x4de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_util.c:282:(.xiptext+0x4f2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `fixup_convert_atmel_pri':
   drivers/mtd/chips/cfi_cmdset_0002.c:311:(.text+0xe3e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x518)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `put_chip.isra.0':
   drivers/mtd/chips/cfi_cmdset_0002.c:1007:(.text+0xf34): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x518)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_read_onechip':
   drivers/mtd/chips/cfi_cmdset_0002.c:1215:(.text+0x15f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xcd0)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_destroy':
   drivers/mtd/chips/cfi_cmdset_0002.c:3105:(.text+0x17f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x518)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2624:(.text+0x1846): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x11c)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_ppb_unlock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2803:(.text+0x1bea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x518)
   drivers/mtd/chips/cfi_cmdset_0002.c:2823:(.text+0x1c38): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x518)
   drivers/mtd/chips/cfi_cmdset_0002.c:2863:(.text+0x1db0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x518)
   drivers/mtd/chips/cfi_cmdset_0002.c:2874:(.text+0x1e00): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x518)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_secsi_read':
   drivers/mtd/chips/cfi_cmdset_0002.c:1366:(.text+0x270f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xc30)
   drivers/mtd/chips/cfi_cmdset_0002.c:1389:(.text+0x2932): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xc30)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `otp_exit':
   drivers/mtd/chips/cfi_cmdset_0002.c:1296:(.text+0x2a58): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xc30)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_otp_write':
   drivers/mtd/chips/cfi_cmdset_0002.c:1818:(.text+0x2bfa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xc30)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_write_words':
   drivers/mtd/chips/cfi_cmdset_0002.c:1880:(.text+0x2e22): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x147c)
   drivers/mtd/chips/cfi_cmdset_0002.c:1912:(.text+0x2fc3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_on
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_load_partial':
   include/linux/mtd/map.h:360:(.text+0x304b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_off
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_lock_user_prot_reg':
   drivers/mtd/chips/cfi_cmdset_0002.c:1641:(.text+0x380f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x518)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_write_user_prot_reg':
   drivers/mtd/chips/cfi_cmdset_0002.c:1632:(.text+0x3862): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x11c)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_read_secsi_onechip':
   drivers/mtd/chips/cfi_cmdset_0002.c:1330:(.text+0x3a8f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_read_pri
>> drivers/mtd/chips/cfi_cmdset_0002.o:drivers/mtd/chips/cfi_cmdset_0002.c:1032:(.xiptext+0xa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_enable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1036:(.xiptext+0x2c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
>> drivers/mtd/chips/cfi_cmdset_0002.c:1042:(.xiptext+0x6e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_reset':
   drivers/mtd/chips/cfi_cmdset_0002.c:1998:(.xiptext+0x86): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2007:(.xiptext+0x9a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2009:(.xiptext+0xaf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x122): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x144): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1068:(.xiptext+0x1a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1085:(.xiptext+0x226): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1099:(.xiptext+0x262): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1099:(.xiptext+0x286): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
>> drivers/mtd/chips/cfi_cmdset_0002.c:1103:(.xiptext+0x294): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __might_resched
   drivers/mtd/chips/cfi_cmdset_0002.c:1103:(.xiptext+0x29a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __cond_resched
   drivers/mtd/chips/cfi_cmdset_0002.c:1103:(.xiptext+0x2a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1109:(.xiptext+0x2ce): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x4b0)
   drivers/mtd/chips/cfi_cmdset_0002.c:1099:(.xiptext+0x33f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x35b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x363): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1120:(.xiptext+0x369): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:1120:(.xiptext+0x374): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1120:(.xiptext+0x37e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
>> drivers/mtd/chips/cfi_cmdset_0002.c:1144:(.xiptext+0x3f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:1145:(.xiptext+0x422): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1147:(.xiptext+0x44f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1739:(.xiptext+0x463): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_done':
   drivers/mtd/chips/cfi_cmdset_0002.c:1739:(.xiptext+0x478): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `otp_exit':
   drivers/mtd/chips/cfi_cmdset_0002.c:1296:(.xiptext+0x48c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1302:(.xiptext+0x4e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xd04)
   drivers/mtd/chips/cfi_cmdset_0002.c:1305:(.xiptext+0x4eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_done':
   drivers/mtd/chips/cfi_cmdset_0002.c:1744:(.xiptext+0x51e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1748:(.xiptext+0x54f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1748:(.xiptext+0x56b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_ready':
   drivers/mtd/chips/cfi_cmdset_0002.c:849:(.xiptext+0x622): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_good':
   drivers/mtd/chips/cfi_cmdset_0002.c:869:(.xiptext+0x692): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:869:(.xiptext+0x6aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __usecs_to_jiffies
   drivers/mtd/chips/cfi_cmdset_0002.c:873:(.xiptext+0x6ec): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1943:(.xiptext+0x70b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1943:(.xiptext+0x71a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_wait':
   drivers/mtd/chips/cfi_cmdset_0002.c:1943:(.xiptext+0x720): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `usecs_to_jiffies':
>> include/linux/jiffies.h:417:(.xiptext+0x72b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
>> include/linux/jiffies.h:417:(.xiptext+0x73e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_wait':
   drivers/mtd/chips/cfi_cmdset_0002.c:1960:(.xiptext+0x776): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:1962:(.xiptext+0x7a2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x9ec)
   drivers/mtd/chips/cfi_cmdset_0002.c:1974:(.xiptext+0x7e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:1982:(.xiptext+0x822): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1989:(.xiptext+0x84a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1978:(.xiptext+0x85e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1993:(.xiptext+0x873): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x8db): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_once':
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x8fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1663:(.xiptext+0x907): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1663:(.xiptext+0x90d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:1649:(.xiptext+0x918): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1664:(.xiptext+0x92a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1674:(.xiptext+0x96f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:1678:(.xiptext+0x9aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x9ec)
   drivers/mtd/chips/cfi_cmdset_0002.c:1686:(.xiptext+0x9f6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:1696:(.xiptext+0xa2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1714:(.xiptext+0xaf3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_retry':
   drivers/mtd/chips/cfi_cmdset_0002.c:1772:(.xiptext+0xb5a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1772:(.xiptext+0xb68): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1773:(.xiptext+0xb77): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xddc)
   drivers/mtd/chips/cfi_cmdset_0002.c:1773:(.xiptext+0xb8e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1780:(.xiptext+0xbc0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1780:(.xiptext+0xbd4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1778:(.xiptext+0xbea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1719:(.xiptext+0xc36): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `otp_enter':
   drivers/mtd/chips/cfi_cmdset_0002.c:1285:(.xiptext+0xcd6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword':
   drivers/mtd/chips/cfi_cmdset_0002.c:1805:(.xiptext+0xd48): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1805:(.xiptext+0xd56): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xddc)
   drivers/mtd/chips/cfi_cmdset_0002.c:1810:(.xiptext+0xd6b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2413:(.xiptext+0xdef): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2413:(.xiptext+0xe07): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2413:(.xiptext+0xe20): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2417:(.xiptext+0xe3a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2417:(.xiptext+0xe53): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_ff':
>> include/linux/mtd/map.h:378:(.xiptext+0xe6b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_chip':
   drivers/mtd/chips/cfi_cmdset_0002.c:2427:(.xiptext+0xec7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:2434:(.xiptext+0xeee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2434:(.xiptext+0xef6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2435:(.xiptext+0xefc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.c:2435:(.xiptext+0xf08): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2435:(.xiptext+0xf12): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2441:(.xiptext+0xf6a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x9ec)
   drivers/mtd/chips/cfi_cmdset_0002.c:2444:(.xiptext+0xfbb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:2449:(.xiptext+0xfee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2461:(.xiptext+0x104e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xd04)
   drivers/mtd/chips/cfi_cmdset_0002.c:2462:(.xiptext+0x1056): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2464:(.xiptext+0x1067): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:2475:(.xiptext+0x10be): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:2489:(.xiptext+0x112c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2492:(.xiptext+0x113a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xddc)
   drivers/mtd/chips/cfi_cmdset_0002.c:2494:(.xiptext+0x114f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2510:(.xiptext+0x11d8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2510:(.xiptext+0x11f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2510:(.xiptext+0x120a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2510:(.xiptext+0x1224): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2514:(.xiptext+0x123c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2514:(.xiptext+0x12a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `map_word_ff':
>> include/linux/mtd/map.h:381:(.xiptext+0x12ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   include/linux/mtd/map.h:378:(.xiptext+0x12d2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
>> include/linux/mtd/map.h:381:(.xiptext+0x12d8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2522:(.xiptext+0x12e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:2522:(.xiptext+0x12ee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2534:(.xiptext+0x1344): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x9ec)
   drivers/mtd/chips/cfi_cmdset_0002.c:2539:(.xiptext+0x1397): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0002.c:2541:(.xiptext+0x13ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2547:(.xiptext+0x142a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xd04)
   drivers/mtd/chips/cfi_cmdset_0002.c:2547:(.xiptext+0x1432): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2551:(.xiptext+0x1443): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_current':
>> arch/xtensa/include/asm/current.h:24:(.xiptext+0x1482): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0002.c:2562:(.xiptext+0x149e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:2564:(.xiptext+0x14ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xddc)
   drivers/mtd/chips/cfi_cmdset_0002.c:2568:(.xiptext+0x14c3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:2597:(.xiptext+0x15ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2603:(.xiptext+0x15c4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2605:(.xiptext+0x15d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2606:(.xiptext+0x15f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0002.c:2035:(.xiptext+0x16c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2045:(.xiptext+0x1742): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xd04)
   drivers/mtd/chips/cfi_cmdset_0002.c:2045:(.xiptext+0x174a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_intelext_restore_locks':
   drivers/mtd/chips/cfi_cmdset_0001.c:2602:(.text+0x8f3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_read_pri
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_point_onechip':
   drivers/mtd/chips/cfi_cmdset_0001.c:1374:(.text+0x25fc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xd7c)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_intelext_resume':
   drivers/mtd/chips/cfi_cmdset_0001.c:2624:(.text+0x280f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xab0)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `cfi_intelext_writev':
   drivers/mtd/chips/cfi_cmdset_0001.c:1890:(.text+0x290a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xab0)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `_cond_resched':
   include/linux/sched.h:2099:(.text+0x2a00): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xab0)
>> drivers/mtd/chips/cfi_cmdset_0001.o:drivers/mtd/chips/cfi_cmdset_0001.c:1118:(.xiptext+0xa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_enable':
   drivers/mtd/chips/cfi_cmdset_0001.c:1121:(.xiptext+0x2c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
>> drivers/mtd/chips/cfi_cmdset_0001.c:1127:(.xiptext+0x76): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0001.c:1112:(.xiptext+0xa4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_getlockstatus_oneblock':
   drivers/mtd/chips/cfi_cmdset_0001.c:2088:(.xiptext+0x18a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:1145:(.xiptext+0x1ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_wait_for_operation':
   drivers/mtd/chips/cfi_cmdset_0001.c:1154:(.xiptext+0x240): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1160:(.xiptext+0x25a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1160:(.xiptext+0x2e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1179:(.xiptext+0x306): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1199:(.xiptext+0x37a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1194:(.xiptext+0x39e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
>> drivers/mtd/chips/cfi_cmdset_0001.c:1197:(.xiptext+0x3ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __might_resched
>> drivers/mtd/chips/cfi_cmdset_0001.c:1197:(.xiptext+0x3b2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __cond_resched
   drivers/mtd/chips/cfi_cmdset_0001.c:1196:(.xiptext+0x3bc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:1199:(.xiptext+0x3d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1205:(.xiptext+0x3ee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
>> drivers/mtd/chips/cfi_cmdset_0001.c:1233:(.xiptext+0x440): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0001.c:1234:(.xiptext+0x45c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0001.c:1234:(.xiptext+0x464): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1234:(.xiptext+0x46a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0001.c:1236:(.xiptext+0x476): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `current_thread_info':
>> arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0x480): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_wait_for_operation':
>> drivers/mtd/chips/cfi_cmdset_0001.c:1220:(.xiptext+0x503): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0001.c:1248:(.xiptext+0x54a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:1250:(.xiptext+0x564): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:1251:(.xiptext+0x573): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x199c)
   drivers/mtd/chips/cfi_cmdset_0001.c:1251:(.xiptext+0x58a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:2107:(.xiptext+0x5d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_xxlock_oneblock':
   drivers/mtd/chips/cfi_cmdset_0001.c:2115:(.xiptext+0x5f8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2117:(.xiptext+0x628): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2126:(.xiptext+0x67b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2128:(.xiptext+0x69e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:2147:(.xiptext+0x6de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x12b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:2147:(.xiptext+0x6e6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:2158:(.xiptext+0x74a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:2159:(.xiptext+0x766): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:2160:(.xiptext+0x774): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x199c)
   drivers/mtd/chips/cfi_cmdset_0001.c:2163:(.xiptext+0x78e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1938:(.xiptext+0x7f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1938:(.xiptext+0x80e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1938:(.xiptext+0x826): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0001.c:1949:(.xiptext+0x86e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1954:(.xiptext+0x88f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1954:(.xiptext+0x8a7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `xip_disable':
   drivers/mtd/chips/cfi_cmdset_0001.c:1112:(.xiptext+0x8cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_erase_oneblock':
   drivers/mtd/chips/cfi_cmdset_0001.c:1962:(.xiptext+0x8f2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_merge_status
   drivers/mtd/chips/cfi_cmdset_0001.c:1962:(.xiptext+0x904): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1965:(.xiptext+0x920): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1977:(.xiptext+0x973): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1987:(.xiptext+0x9b2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1988:(.xiptext+0x9de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1991:(.xiptext+0x9fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1995:(.xiptext+0xa26): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x12b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:1987:(.xiptext+0xa2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1996:(.xiptext+0xa5e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x12b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:1997:(.xiptext+0xa66): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:2005:(.xiptext+0xab6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:2012:(.xiptext+0xade): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2013:(.xiptext+0xaeb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:2007:(.xiptext+0xb00): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:2008:(.xiptext+0xb0e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x199c)
   drivers/mtd/chips/cfi_cmdset_0001.c:2020:(.xiptext+0xb23): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1553:(.xiptext+0xbc6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_oneword':
   drivers/mtd/chips/cfi_cmdset_0001.c:1564:(.xiptext+0xbec): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1564:(.xiptext+0xc10): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_merge_status
   drivers/mtd/chips/cfi_cmdset_0001.c:1560:(.xiptext+0xc23): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1575:(.xiptext+0xc3e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1583:(.xiptext+0xca8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1587:(.xiptext+0xcc0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1593:(.xiptext+0xcee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x12b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:1591:(.xiptext+0xcf6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1607:(.xiptext+0xd82): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0001.c:1607:(.xiptext+0xdaf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x100)
   drivers/mtd/chips/cfi_cmdset_0001.c:1621:(.xiptext+0xdfe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1621:(.xiptext+0xe0c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1625:(.xiptext+0xe20): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0001.c:1625:(.xiptext+0xe2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x199c)
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_oneword.constprop.0':
   drivers/mtd/chips/cfi_cmdset_0001.c:1625:(.xiptext+0xe43): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0001.c:1710:(.xiptext+0xebc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1710:(.xiptext+0xeef): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0001.c:1711:(.xiptext+0xf1a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1710:(.xiptext+0xf36): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1729:(.xiptext+0xf4f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1735:(.xiptext+0xfb7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1741:(.xiptext+0xfdf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1741:(.xiptext+0xff7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1742:(.xiptext+0x101a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1755:(.xiptext+0x1094): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1791:(.xiptext+0x121f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1798:(.xiptext+0x1256): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `map_word_load_partial':
   include/linux/mtd/map.h:352:(.xiptext+0x127a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0001.c:1812:(.xiptext+0x129e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.c:1803:(.xiptext+0x12bf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_merge_status
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `map_word_ff':
   include/linux/mtd/map.h:378:(.xiptext+0x12cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   include/linux/mtd/map.h:378:(.xiptext+0x12e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0001.o: in function `do_write_buffer':
   drivers/mtd/chips/cfi_cmdset_0001.c:1812:(.xiptext+0x134a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1814:(.xiptext+0x1363): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_cmdset_0001.c:1819:(.xiptext+0x1392): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x12b0)
   drivers/mtd/chips/cfi_cmdset_0001.c:1824:(.xiptext+0x139a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
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


vim +61 arch/xtensa/include/asm/irqflags.h

df9ee29270c11d David Howells 2010-10-07  57  
df9ee29270c11d David Howells 2010-10-07  58  static inline void arch_local_irq_enable(void)
df9ee29270c11d David Howells 2010-10-07  59  {
df9ee29270c11d David Howells 2010-10-07  60  	unsigned long flags;
df9ee29270c11d David Howells 2010-10-07 @61  	asm volatile("rsil %0, 0" : "=a" (flags) :: "memory");
df9ee29270c11d David Howells 2010-10-07  62  }
df9ee29270c11d David Howells 2010-10-07  63  

:::::: The code at line 61 was first introduced by commit
:::::: df9ee29270c11dba7d0fe0b83ce47a4d8e8d2101 Fix IRQ flag handling naming

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

