Return-Path: <linux-kernel+bounces-89367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31B686EF78
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBF31F230F4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08CC134A1;
	Sat,  2 Mar 2024 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMv+Trd9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114511711
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709367608; cv=none; b=VzXpC/ziyj6iTEfwi4rHLmvBAqT403KGFvjgCaJvOW+szLx3nsPXaN+79pl6CGsJJKm8JmiUcCctX5ME2I+0VEtxklrQVJ5zjZLrsMQuYTbo61SCFpdD8SF2af88/snLpHf5Wg1CfxzKdVfePcl3JXfVtGmFE/lAxq/b546daPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709367608; c=relaxed/simple;
	bh=4tXcOXcUrP0+jqLgD1fyYl1ENBstb08f2mCwSq9QMNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F0tqJA4lkVXRhtHnQhTpTKfQyGhJPTZw+9IU0k11lio777gsHuAxq8TEeiu4lBIx0/BEnvMhojeAzcd2k8oBDBJYjHPnTYRj8TwPl0SXsOv22KSxysmTqiJgSUPavrr0cQOjYzmC7Dsjhb3C5ZVkL87nxaNtzpCOYla6zzlMFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMv+Trd9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709367605; x=1740903605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4tXcOXcUrP0+jqLgD1fyYl1ENBstb08f2mCwSq9QMNA=;
  b=kMv+Trd9Itc2YBgjqZCSOVwf1O3nvnwVV35ZAE23h+x11HhYpehzMq6e
   YnrZgtNhnoXFKe0F8KR6i9sTeRQ4zQ3ATL7GAAfG2NodITJKlRiI9ezB9
   aOtuxq9LBfH9uVY/uc96xxcVurjGgL3NPPEv5pyH5mywk0/tqu9WTKGGX
   XlzunnnNqLyxd+ZDbdFKJZgNa7nscDD/uYZYcwtcuolWA30S0jVNw1doz
   g4hW+PSMR4aXylOxjk2y75Mg0OAdsIwH1QxVpA0cqf80ajMbmeb7zVU3D
   6DlNkX/qXHfuAztKySfyoeGWnc9xcgO3Orny0Ht7OHA/Fl4PQdP5HlRLu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="21456081"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="21456081"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 00:20:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8567841"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2024 00:20:03 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgKbB-000ESX-1U;
	Sat, 02 Mar 2024 08:20:01 +0000
Date: Sat, 2 Mar 2024 16:19:58 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:x86/boot 9/9] arch/x86/include/asm/desc.h:54:16: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202403021605.gg6Sr3yI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
head:   721f791ce1cddfa5f2bf524ac14741bfa0f72697
commit: 11e36b0f7c2150a6453872b79555767b43c846d0 [9/9] x86/boot/64: Load the final kernel GDT during early boot directly, remove startup_gdt[]
config: x86_64-randconfig-121-20240301 (https://download.01.org/0day-ci/archive/20240302/202403021605.gg6Sr3yI-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403021605.gg6Sr3yI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403021605.gg6Sr3yI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)


vim +54 arch/x86/include/asm/desc.h

a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28  50  
69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14  51  /* Provide the original GDT */
69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14  52  static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28  53  {
a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28 @54  	return per_cpu(gdt_page, cpu).gdt;
a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28  55  }
a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28  56  

:::::: The code at line 54 was first introduced by commit
:::::: a939098afcfa5f81d3474782ec15c6d114e57763 x86: move x86_64 gdt closer to i386

:::::: TO: Glauber Costa <gcosta@redhat.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

