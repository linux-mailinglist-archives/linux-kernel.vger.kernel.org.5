Return-Path: <linux-kernel+bounces-105603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B5087E141
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2042D2825F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B492DF4FB;
	Mon, 18 Mar 2024 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wz+QrkqA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA217547
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710722043; cv=none; b=JImYTojU4LOk/gUl1lfFsAv/irpL9t7pBlKzI8ubJyrecdrzQ3VvP9jxdPm88YPCqj2es782HdAR3PIV5P2q4XOUIOkWib2LBc01DQWYDrgLHGDOI5b2MrJ4vJW6uWcAvE+AZoMa2eQNWLkY6Kp03ylJ7tX0DyCJ6Pn4nbhEzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710722043; c=relaxed/simple;
	bh=MHg0NKKUw3YHEBfoEYMc8wiQax3U8R5I7t7SEw8GybU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U1TiF+oAIb5DwOmmvayuEuObzj7tYeR069UDamDXysorwplVhZZj9n188j55C30EKgnSiZkVEICEScObMnL2ZdunP3mkIo2QvnkYkmDg0eu4NGrehUyakkXuTKfGUzI5nOD0/7BZaRLuHzydlPvA8LJ1CYcyhMBGI32VbW0xvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wz+QrkqA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710722040; x=1742258040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MHg0NKKUw3YHEBfoEYMc8wiQax3U8R5I7t7SEw8GybU=;
  b=Wz+QrkqAMTLa744Klsw5Nr7xwPv0o5//gWe5diYUt834KLt6gWACcTm4
   uCyH0brYWKeGPIHg5mQrMKdp8MeTHF+6ialskGlseGd1bZZ0r9vMnxl+3
   LnlB0pDh5NDbgx70Gkx/ymOpzxpQy78QWH9wwhiuV+spFWN4pvf5nxXPn
   uOH4XAoxRuVO6+GR5LYsH2WBXUO2jzw7t1Cs/xe2G5CjUsOLWNipOWg5Y
   aMvnlaeZXwjtKhHr0XSka6OhpuWvT/1dgSQEFgxzJrvHmfLk2UqFmuMTB
   BtNML2aiaN5QgGB8WaigWPGXqbUPEwI7DS5YXJeYfk2xCEtOcyo/jxIiJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5357931"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="5357931"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 17:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="13773951"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Mar 2024 17:33:58 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rm0wt-000GYh-1h;
	Mon, 18 Mar 2024 00:33:55 +0000
Date: Mon, 18 Mar 2024 08:33:41 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: ERROR: modpost: "ebus_dma_irq_enable"
 [drivers/parport/parport_pc.ko] undefined!
Message-ID: <202403180855.4Mss6APq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   906a93befec826475ab3d4facacc57a0b0a002a5
commit: f73edc8951b2de515b5ecc8a357ccd47dd41077e kbuild: unify two modpost invocations
date:   1 year, 6 months ago
config: sparc-randconfig-002-20240317 (https://download.01.org/0day-ci/archive/20240318/202403180855.4Mss6APq-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240318/202403180855.4Mss6APq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403180855.4Mss6APq-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux.o: section mismatch in reference: leon_pci_init (section: .text) -> pci_assign_unassigned_resources (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: grpci2_of_driver (section: .data) -> grpci2_of_match (section: .init.rodata)
>> ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
>> ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
>> ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
>> ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!
>> ERROR: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!
>> ERROR: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!
>> ERROR: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

