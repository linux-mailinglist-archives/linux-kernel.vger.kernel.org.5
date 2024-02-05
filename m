Return-Path: <linux-kernel+bounces-52021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE148492E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1FCB21594
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1669944D;
	Mon,  5 Feb 2024 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/eAVmjP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751F9455
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707106454; cv=none; b=EpK9LCHY7g4WYgRehiexZXs8G3LGR+j2gYz9kce/ekNSGzyJPBmHgfud6hx1MW4K3acI3zxb4CpBM2sRvxXHB7zkVWki0z40w3UfqQIQI0IWiHakhGPyG1qwv9SK+sORhCd9CVXAR8VqRGtADvL74Sy2J2IEBxL3IFB91TtQNJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707106454; c=relaxed/simple;
	bh=Ab/yahujIPlo0ZSnxbwuNiJ88afNhH3/rOXNFkhdz/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aRMG6uUmdJcRn0ChKmpUDGeSFlHvIHQOfxl0dbefobbrEd6JOzDXN7ewrZE45GvZKSSWHFMeTZPR7VdHz/yBh25d//mW4XhQEkebxnFQkm0EY9GjgOP/1Ky1q6lVfTmwXhoZ1DoOrFdCVGkDOX5m9XTcvkv9FCMS2oW0U0W3Xa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/eAVmjP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707106453; x=1738642453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ab/yahujIPlo0ZSnxbwuNiJ88afNhH3/rOXNFkhdz/A=;
  b=k/eAVmjPTWBx6BoAynEivO3x2eb5yaEX9XSo1vJXPee0e2u9ovD+nmOg
   Z23kjaSxCi90nrfduKWmZMQW8Xy162ArCstlE4DNYEW7FApzCrAqeOzb5
   RdNWkUs9roNORrxukS/2ansflJaNlvgeCPCwJnv8vcXsFRWjH05j4VwxO
   yug+foCI1X2XaknD0CekRHluFKIA3NVQ0OESwozJwC+nhHuCeUFcbFcJR
   iP87JzWY089sDqJ9WQIC7MV89aq17Tf3zCpIpFJBFIOKB1JgylsFqdv1l
   F/CFJfKhlW0CD7Cp/HaZACeFU4vFDY9QSyDGmhO82dCLMmjaTxOcgdpAb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="25892744"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25892744"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 20:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="31711602"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Feb 2024 20:14:11 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWqMy-00008C-2x;
	Mon, 05 Feb 2024 04:14:08 +0000
Date: Mon, 5 Feb 2024 12:13:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: sparc-linux-ld: arch/sparc/include/asm/parport.h:91:undefined
 reference to `ebus_dma_prepare'
Message-ID: <202402051222.ciCAY8Tj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Maciej,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
commit: f01dda1cb85e14a1d51c3cedad0feaaf71a93b4b parport_pc: Let chipset drivers mask unsupported modes
date:   1 year, 1 month ago
config: sparc-randconfig-r034-20230704 (https://download.01.org/0day-ci/archive/20240205/202402051222.ciCAY8Tj-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240205/202402051222.ciCAY8Tj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402051222.ciCAY8Tj-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/kernel/head_32.o: in function `current_pc':
   arch/sparc/kernel/head_32.S:121:(.head.text+0x5040): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
   arch/sparc/kernel/head_32.o: in function `halt_notsup':
   arch/sparc/kernel/head_32.S:198:(.head.text+0x5100): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
   arch/sparc/kernel/head_32.o: in function `leon_init':
   arch/sparc/kernel/head_32.S:434:(.init.text+0xa4): relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o
   arch/sparc/kernel/process_32.o:(.fixup+0x4): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/process_32.o:(.fixup+0xc): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x0): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x8): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x10): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x18): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x20): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x28): additional relocation overflows omitted from the output
   sparc-linux-ld: drivers/parport/parport_pc.o: in function `ecpp_probe':
   arch/sparc/include/asm/parport.h:152:(.text+0x14b4): undefined reference to `ebus_dma_register'
   sparc-linux-ld: arch/sparc/include/asm/parport.h:155:(.text+0x14cc): undefined reference to `ebus_dma_irq_enable'
   sparc-linux-ld: drivers/parport/parport_pc.o: in function `ecpp_probe':
   arch/sparc/include/asm/ns87303.h:102:(.text+0x14d8): undefined reference to `ns87303_lock'
   sparc-linux-ld: arch/sparc/include/asm/ns87303.h:102:(.text+0x14e4): undefined reference to `ns87303_lock'
   sparc-linux-ld: drivers/parport/parport_pc.o: in function `ecpp_probe':
   include/linux/spinlock.h:405:(.text+0x1508): undefined reference to `ns87303_lock'
   sparc-linux-ld: drivers/parport/parport_pc.o: in function `ecpp_probe':
   arch/sparc/include/asm/ns87303.h:102:(.text+0x1510): undefined reference to `ns87303_lock'
   sparc-linux-ld: drivers/parport/parport_pc.o: in function `ecpp_probe':
   include/linux/spinlock.h:405:(.text+0x1538): undefined reference to `ns87303_lock'
   sparc-linux-ld: drivers/parport/parport_pc.o: in function `ecpp_probe':
   arch/sparc/include/asm/parport.h:185:(.text+0x1568): undefined reference to `ebus_dma_irq_enable'
   sparc-linux-ld: arch/sparc/include/asm/parport.h:186:(.text+0x1574): undefined reference to `ebus_dma_unregister'
   sparc-linux-ld: drivers/parport/parport_pc.o: in function `parport_pc_fifo_write_block_dma':
   arch/sparc/include/asm/parport.h:81:(.text+0x2074): undefined reference to `ebus_dma_enable'
>> sparc-linux-ld: arch/sparc/include/asm/parport.h:91:(.text+0x2088): undefined reference to `ebus_dma_prepare'
   sparc-linux-ld: arch/sparc/include/asm/parport.h:71:(.text+0x20e0): undefined reference to `ebus_dma_enable'
   sparc-linux-ld: arch/sparc/include/asm/parport.h:73:(.text+0x20f0): undefined reference to `ebus_dma_request'
   sparc-linux-ld: arch/sparc/include/asm/parport.h:81:(.text+0x2194): undefined reference to `ebus_dma_enable'
   sparc-linux-ld: arch/sparc/include/asm/parport.h:106:(.text+0x21a4): undefined reference to `ebus_dma_residue'
   sparc-linux-ld: arch/sparc/include/asm/parport.h:81:(.text+0x2218): undefined reference to `ebus_dma_enable'
   sparc-linux-ld: arch/sparc/include/asm/parport.h:106:(.text+0x2228): undefined reference to `ebus_dma_residue'
   sparc-linux-ld: drivers/parport/parport_pc.o: in function `ecpp_remove':
   arch/sparc/include/asm/parport.h:211:(.text+0x2684): undefined reference to `ebus_dma_irq_enable'
   sparc-linux-ld: arch/sparc/include/asm/parport.h:212:(.text+0x268c): undefined reference to `ebus_dma_unregister'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

