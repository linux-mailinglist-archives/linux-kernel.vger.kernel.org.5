Return-Path: <linux-kernel+bounces-126125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F289327B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061571F2140D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C4145B04;
	Sun, 31 Mar 2024 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTc76s1b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099F145321
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901136; cv=none; b=e9yzHwWrU08HDzFKCJj9lH0Dt5YNl1HxCli2C9h7VynXh3nVcvF9DOp557MxJ0LSYKsvPRqU9RnMTNwrA8Ii38h54v0RBF80GxgMzyynXlwhSakT2yV+IuWFijzSmwZrxIvnNP2aSo1a8F8Vl45Fn6njGENr66MtLYZdl/lqIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901136; c=relaxed/simple;
	bh=0PgwmdbQN7ZnKNKCizoTyzmjQV/8g5GhP4FH1t2EX14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ugg8uGevX/7wjDefVrShwrxgXqmSJbAnl0JyzLyIM8iGW+tiVpy4X6iudFvToHDkLSyvoYZbYFR23QyNFEPkIuQ9m4YFhmFQTz3vakxPHsFDBs7L+cILHFcKOHayoa7143j7Cmd43yos2ys1lpdu665hg0U/bFsyET5jpVt5vW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTc76s1b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711901133; x=1743437133;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0PgwmdbQN7ZnKNKCizoTyzmjQV/8g5GhP4FH1t2EX14=;
  b=ZTc76s1bnshfrdHA5PoepCSLNafxZtQwmZoy2LopJYoubvcskfLJxrE/
   DFB3A4HleQB0Rc0UJhNuX4lUGjImHmSp2x6EtjMV9mtuvRp2sc1Qn2zqm
   Jj511CEIL85HpvKdQu7kh6SJ8sf1Ap/czcSwan3+LSsSpGBxc6/tZ4ozx
   cRRgEJkXL5y2d1MN2ct4zOwqFvfMvraO8Xpcbw7HBXgm1stJZMj6rMwfO
   TaudnO/qA4Z2Jcm480a6BEB91lW2veaCA2ddoeTiuCK7s9C1ve1HLn5jt
   54cVNKs5D2NcLaqSKHgnCzNyh6ip4lm/4PJ4DsiTcXDr6YWa6+XLobrfI
   g==;
X-CSE-ConnectionGUID: A92ZlS0cSbKQl/Gl/7vxow==
X-CSE-MsgGUID: ULGlQsCjRhGqm1jHdEOwtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="17597732"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17597732"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 09:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17870414"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 31 Mar 2024 09:05:31 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqxgW-0001Ec-2N;
	Sun, 31 Mar 2024 16:05:28 +0000
Date: Mon, 1 Apr 2024 00:04:51 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <tangyouling@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Subject: arch/loongarch/kernel/relocate.c:166:38: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202403312345.Rmq1hxfh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   712e14250dd2907346617eba275c46f53db8fae7
commit: e5f02b51fa0cb785e352e77271a65e96051b789b LoongArch: Add support for kernel address space layout randomization (KASLR)
date:   1 year, 1 month ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20240331/202403312345.Rmq1hxfh-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240331/202403312345.Rmq1hxfh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403312345.Rmq1hxfh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/loongarch/kernel/relocate.c:166:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *cmdline @@     got void [noderef] __iomem * @@
   arch/loongarch/kernel/relocate.c:166:38: sparse:     expected char *cmdline
   arch/loongarch/kernel/relocate.c:166:38: sparse:     got void [noderef] __iomem *

vim +166 arch/loongarch/kernel/relocate.c

   159	
   160	void * __init relocate_kernel(void)
   161	{
   162		unsigned long kernel_length;
   163		unsigned long random_offset = 0;
   164		void *location_new = _text; /* Default to original kernel start */
   165		void *kernel_entry = start_kernel; /* Default to original kernel entry point */
 > 166		char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
   167	
   168		strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
   169	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

