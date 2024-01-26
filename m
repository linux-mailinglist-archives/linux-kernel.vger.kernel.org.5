Return-Path: <linux-kernel+bounces-40255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8783DD45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD2FB24E12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242361CF90;
	Fri, 26 Jan 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f315VzSK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38581CF83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282309; cv=none; b=TdqinmDNdySa8fVflpK9bNPvUpIWjp8OfMvmuFhiP30t9bOhImxihWhBSzArvbwTyAsqMdVic7GIORpWigkLTthH9aR2Hah2pviyYRHBEsj97cB0SschOCXghPmwATuixy4aiSvAql15xtJyEkvHZOs99Xz/H3dJnbb7iJR3vxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282309; c=relaxed/simple;
	bh=cgWM7DcDj7rsTPS70SdmpjpwkbO21DeTFURwfMQpIhc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DMu48rcYonsKwrahalsGi3tZKAK1+0NLQJ3azWlz6d8CtrNjTUiFCK7OBRijDULgMwA0M5bdKTGFYy23xpIsRoPzP6xC1XPgdHVTeRrxyco73nH4/cxd988AyMxuXJIemLrwlsHfkzZJa6F5q/HYDtNt+XFUmul2PdpXcIMbo1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f315VzSK; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706282307; x=1737818307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cgWM7DcDj7rsTPS70SdmpjpwkbO21DeTFURwfMQpIhc=;
  b=f315VzSKi0NUwWd2SZwYtLz5nlOMywdg+3zQYVnFu9FCaj2PA6MMvTgQ
   jJbtuGlTcYw8dcF5B4r7ZrQMRavdVpX42RgDgBgb1iAhPvpfvQ+FpWmaP
   5Wzf7xDO/JxkERqMALh5jat0OYQCWUfRSnMeCefvLTjtq8d5BLhd8UDiD
   Ot0niyaYeIkfY0KnbOJPNENkdSbN7MIXjrTyNrXUuz6XuHJYoSLozjns/
   RmVXjzEmhtw3eO9AaGjh1b4Q7x/gqwlwZqQK0s5vPsZuBKrPqkQzob7gF
   d99i4mCV5zQb8XSwNF19N5ApEuh/QIJo2a3twX/DhL0ghUJbvO3Y415DA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399652781"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399652781"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 07:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1118282384"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1118282384"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2024 07:18:25 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTNyJ-00018S-2b;
	Fri, 26 Jan 2024 15:18:23 +0000
Date: Fri, 26 Jan 2024 23:17:34 +0800
From: kernel test robot <lkp@intel.com>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>
Subject: arch/microblaze/kernel/entry.S:945: Error: unknown opcode "suspend"
Message-ID: <202401262320.cBtYOWUA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Appana,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
commit: 88707ebe77e23e856981e597f322cabbf6415662 microblaze: Add custom break vector handler for mb manager
date:   1 year, 4 months ago
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240126/202401262320.cBtYOWUA-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401262320.cBtYOWUA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401262320.cBtYOWUA-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/microblaze/kernel/entry.S: Assembler messages:
>> arch/microblaze/kernel/entry.S:945: Error: unknown opcode "suspend"


vim +/suspend +945 arch/microblaze/kernel/entry.S

   825	
   826		/* restore all the tlb's */
   827		addik	r3, r0, TOPHYS(tlb_skip)
   828		addik	r6, r0, PT_TLBL0
   829		addik	r7, r0, PT_TLBH0
   830	restore_tlb:
   831		add	r6, r6, r1
   832		add	r7, r7, r1
   833		lwi	r2, r6, 0
   834		mts 	rtlblo, r2
   835		lwi	r2, r7, 0
   836		mts	rtlbhi, r2
   837		addik	r6, r6, 4
   838		addik	r7, r7, 4
   839		bgtid	r3, restore_tlb
   840		addik	r3, r3, -1
   841	
   842		lwi  	r5, r0, TOPHYS(xmb_manager_dev)
   843		lwi	r8, r0, TOPHYS(xmb_manager_reset_callback)
   844		set_vms
   845		/* return from reset need -8 to adjust for rtsd r15, 8 */
   846		addik   r15, r0, ret_from_reset - 8
   847		rtbd	r8, 0
   848		nop
   849	
   850	ret_from_reset:
   851		set_bip /* Ints masked for state restore */
   852		VM_OFF
   853		/* MS: Restore all regs */
   854		RESTORE_REGS
   855		lwi	r14, r1, PT_R14
   856		lwi	r16, r1, PT_PC
   857		addik	r1, r1, PT_SIZE + 36
   858		rtbd	r16, 0
   859		nop
   860	
   861	/*
   862	 * Break handler for MB Manager. Enter to _xmb_manager_break by
   863	 * injecting fault in one of the TMR Microblaze core.
   864	 * FIXME: This break handler supports getting
   865	 * called from kernel space only.
   866	 */
   867	C_ENTRY(_xmb_manager_break):
   868		/*
   869		 * Reserve memory in the stack for context store/restore
   870		 * (which includes memory for storing tlbs (max two tlbs))
   871		 */
   872		addik	r1, r1, -PT_SIZE - 36
   873		swi	r1, r0, xmb_manager_stackpointer
   874		SAVE_REGS
   875		swi	r14, r1, PT_R14	/* rewrite saved R14 value */
   876		swi	r16, r1, PT_PC; /* PC and r16 are the same */
   877	
   878		lwi	r6, r0, TOPHYS(xmb_manager_baseaddr)
   879		lwi	r7, r0, TOPHYS(xmb_manager_crval)
   880		/*
   881		 * When the break vector gets asserted because of error injection,
   882		 * the break signal must be blocked before exiting from the
   883		 * break handler, below code configures the tmr manager
   884		 * control register to block break signal.
   885		 */
   886		swi	r7, r6, 0
   887	
   888		/* Save the special purpose registers  */
   889		mfs	r2, rpid
   890		swi	r2, r1, PT_PID
   891	
   892		mfs	r2, rtlbx
   893		swi	r2, r1, PT_TLBI
   894	
   895		mfs	r2, rzpr
   896		swi	r2, r1, PT_ZPR
   897	
   898	#if CONFIG_XILINX_MICROBLAZE0_USE_FPU
   899		mfs	r2, rfsr
   900		swi	r2, r1, PT_FSR
   901	#endif
   902		mfs	r2, rmsr
   903		swi	r2, r1, PT_MSR
   904	
   905		/* Save all the tlb's */
   906		addik	r3, r0, TOPHYS(tlb_skip)
   907		addik	r6, r0, PT_TLBL0
   908		addik	r7, r0, PT_TLBH0
   909	save_tlb:
   910		add	r6, r6, r1
   911		add	r7, r7, r1
   912		mfs	r2, rtlblo
   913		swi	r2, r6, 0
   914		mfs	r2, rtlbhi
   915		swi	r2, r7, 0
   916		addik	r6, r6, 4
   917		addik	r7, r7, 4
   918		bgtid	r3, save_tlb
   919		addik	r3, r3, -1
   920	
   921		lwi  	r5, r0, TOPHYS(xmb_manager_dev)
   922		lwi	r8, r0, TOPHYS(xmb_manager_callback)
   923		/* return from break need -8 to adjust for rtsd r15, 8 */
   924		addik   r15, r0, ret_from_break - 8
   925		rtbd	r8, 0
   926		nop
   927	
   928	ret_from_break:
   929		/* flush the d-cache */
   930		bralid	r15, mb_flush_dcache
   931		nop
   932	
   933		/*
   934		 * To make sure microblaze i-cache is in a proper state
   935		 * invalidate the i-cache.
   936		 */
   937		bralid	r15, mb_invalidate_icache
   938		nop
   939	
   940		set_bip; /* Ints masked for state restore */
   941		VM_OFF;
   942		mbar	1
   943		mbar	2
   944		bri	4
 > 945		suspend
   946		nop
   947	#endif
   948	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

