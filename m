Return-Path: <linux-kernel+bounces-38820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2136E83C66E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE01B28D07A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66626EB78;
	Thu, 25 Jan 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuT/VHi5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1D6EB59
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196132; cv=none; b=BT5GRGTEFvdr+rp3l9uwqBaO8d5N1PhGD1hqR6H8pngsKe3SXXpF0Xyz3tSTCUDq8C38KgNZLeIxvuQGHXJ+YoWDfvb69TiEIG7f9CNmZveMLChYggp9E7BX0+DyqMLq3TevXxI9lWQaRj6s5vgnzPwwbrIUTf6i6q8aP1+j4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196132; c=relaxed/simple;
	bh=su1Mgq4fZUUogYwZxT5HTLTDkgoOuBntb5pescN973g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YSQyEYfTVl/w4c3dj+abXoSrwME/gTsmFBCCb5ghrnI2hn04LSzEsd4xTiwjzHW7z8PoRb2Xk4sy1Z/g9FlL6bPghRrsWshZDY69Uzx/oyL5HbKM8MO8Jh8+f0DGtjYBHOw7acyh5S5Joa/LBLoF0wur9cWdXrV6IiCKvolH9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuT/VHi5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706196130; x=1737732130;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=su1Mgq4fZUUogYwZxT5HTLTDkgoOuBntb5pescN973g=;
  b=SuT/VHi5ufGrmJ3IDyI/2V7qB4ULCFAqvcJuhQKe9xoJNIf7q+/bl4ZA
   gXATkLBMoPxHPWUBt5FqRyAD1WE7Tx0zfxIwvfzC6QqTly05pY5u6tpc5
   tbzC4iCIJeNPcAaPj8FQpWWh8jXGyymyg+FpbSGuo35B1vzO0YASSLstq
   Yxi/8lE3XPO4V/JzWL7s3yZiSviaumm6kCqzNaAuDz5N2CAGOgAzmpSba
   doDypl4/640BNEIBi/Yd2UKAi6kou58KZCR/SRIoYlVWd9J2ttPTazpor
   n8JvE6+JKVD8v4FB7zO5a/2ALryjx1P62YWEQnCfejnXGoFLjLdGUqGqU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="8843592"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8843592"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 07:21:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2276941"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Jan 2024 07:21:57 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT1YA-00008i-1P;
	Thu, 25 Jan 2024 15:21:54 +0000
Date: Thu, 25 Jan 2024 23:21:22 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Brodkin <abrodkin@synopsys.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	Vineet Gupta <vgupta@synopsys.com>
Subject: arch/arc/kernel/devtree.c:64:23: warning: variable 'dt_root' set but
 not used
Message-ID: <202401252355.5NfsqG3G-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6098d87eaf31f48153c984e2adadf14762520a87
commit: 6e9318d1be83714e004a0ac795a936df4d2bed3e ARC: RIP arc_{get|set}_core_freq() clk API
date:   8 years ago
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240125/202401252355.5NfsqG3G-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240125/202401252355.5NfsqG3G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401252355.5NfsqG3G-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:13,
                    from arch/arc/include/asm/bug.h:31,
                    from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from include/asm-generic/current.h:4,
                    from arch/arc/include/asm/current.h:23,
                    from include/linux/mutex.h:13,
                    from include/linux/notifier.h:13,
                    from include/linux/reboot.h:5,
                    from arch/arc/kernel/devtree.c:13:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   arch/arc/kernel/devtree.c: In function 'setup_machine_fdt':
>> arch/arc/kernel/devtree.c:64:23: warning: variable 'dt_root' set but not used [-Wunused-but-set-variable]
      64 |         unsigned long dt_root;
         |                       ^~~~~~~


vim +/dt_root +64 arch/arc/kernel/devtree.c

880beb8807814c Rob Herring  2013-08-27  53  
999159a5381bff Vineet Gupta 2013-01-22  54  /**
999159a5381bff Vineet Gupta 2013-01-22  55   * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
999159a5381bff Vineet Gupta 2013-01-22  56   * @dt:		virtual address pointer to dt blob
999159a5381bff Vineet Gupta 2013-01-22  57   *
999159a5381bff Vineet Gupta 2013-01-22  58   * If a dtb was passed to the kernel, then use it to choose the correct
999159a5381bff Vineet Gupta 2013-01-22  59   * machine_desc and to setup the system.
999159a5381bff Vineet Gupta 2013-01-22  60   */
880beb8807814c Rob Herring  2013-08-27  61  const struct machine_desc * __init setup_machine_fdt(void *dt)
999159a5381bff Vineet Gupta 2013-01-22  62  {
880beb8807814c Rob Herring  2013-08-27  63  	const struct machine_desc *mdesc;
999159a5381bff Vineet Gupta 2013-01-22 @64  	unsigned long dt_root;

:::::: The code at line 64 was first introduced by commit
:::::: 999159a5381bff3bd6f688c5d20fbec9d8789e53 ARC: [DeviceTree] Basic support

:::::: TO: Vineet Gupta <vgupta@synopsys.com>
:::::: CC: Vineet Gupta <vgupta@synopsys.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

