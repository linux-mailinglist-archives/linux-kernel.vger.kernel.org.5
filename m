Return-Path: <linux-kernel+bounces-44255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE308841F65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FC2B28719
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08085B211;
	Tue, 30 Jan 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZ+r2qHD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30E5821A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606791; cv=none; b=N+wWe0BiHzcOHTfPs071yvW6qjwIcFgEXUbGgqwkm6m37LVvV1TPWBe1T7WZJccTQzLFq6sVC2+vkaWY9CBgM2zcw7LGjDTw/nIe3h1CiHsq8/fHS2arzZ6JXwZUn7kZ5ZoKVztrXQC6d/k2hQ4jQfZY7P4SI7Upn/lt+GMeLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606791; c=relaxed/simple;
	bh=+Wa+UewSUjQ+evNuV3fl9xdlJrL1UOY62kc5bL0+Gbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UZVYnBAn+XfeXmchGHLPjTCEN11WB2XRRT5qC8yfv6IkidYwrVt3rfNUWxW+TEULRXdc/DEDrgb0CUVmNPVk+dSpHRWHC+glp3xilg2PHqYSYrPwX/7UHvM0d87P9pT89U6q/9vEbN31q2zNYsklJNcByhUgqcuVTkE1x5uawms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZ+r2qHD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706606789; x=1738142789;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Wa+UewSUjQ+evNuV3fl9xdlJrL1UOY62kc5bL0+Gbs=;
  b=TZ+r2qHDzBT5lHdt4lZ5b2Un0+MmnwDz074BzN81/2sNGAdPzovtnVhf
   VKmaRNumxbFQI4v0q7k7nHaVqxL/8TQOozqFucHsOq2TT84bm4U583FXO
   1Smo8PRQwftdNFmsdmRS2oV2idUH0xrplwIhfWgGkn+svKRA49+zD91YG
   wbUhhDuAaXQuEjCf2NaU/3nB2UyySyhihZrfYmGL6i1JoBXfBG3++rT9G
   gCsMQbaLt+c8ptZGOIY/acCMqFYFL2DbkPl+fXEtkoMhDG5oF/xD1CKr+
   rZEfikIuXfRavacx6gACss84n0qP9uJ4CB+9WD+PkFcbfs4KHBL9vLXx3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16604727"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16604727"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3612205"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 30 Jan 2024 01:26:28 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUkNG-00009o-2a;
	Tue, 30 Jan 2024 09:25:47 +0000
Date: Tue, 30 Jan 2024 17:18:30 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>
Subject: arch/riscv/kernel/paravirt.c:44:1: sparse: sparse: symbol
 '__pcpu_scope_steal_time' was not declared. Should it be static?
Message-ID: <202401301733.XLBqnyLY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861c0981648f5b64c86fd028ee622096eb7af05a
commit: fdf68acccfc6af9497c34ee411d89af13b6516ed RISC-V: paravirt: Implement steal-time support
date:   4 weeks ago
config: riscv-randconfig-r133-20240130 (https://download.01.org/0day-ci/archive/20240130/202401301733.XLBqnyLY-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4a39d08908942b2d415db405844cbe4af73e75d4)
reproduce: (https://download.01.org/0day-ci/archive/20240130/202401301733.XLBqnyLY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401301733.XLBqnyLY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/paravirt.c:44:1: sparse: sparse: symbol '__pcpu_scope_steal_time' was not declared. Should it be static?
   arch/riscv/kernel/paravirt.c:106:19: sparse: sparse: cast to restricted __le32
   arch/riscv/kernel/paravirt.c:107:30: sparse: sparse: restricted __le32 degrades to integer
   arch/riscv/kernel/paravirt.c:102:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sequence @@     got restricted __le32 @@
   arch/riscv/kernel/paravirt.c:102:26: sparse:     expected unsigned int [usertype] sequence
   arch/riscv/kernel/paravirt.c:102:26: sparse:     got restricted __le32
   arch/riscv/kernel/paravirt.c:104:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] steal @@     got restricted __le64 @@
   arch/riscv/kernel/paravirt.c:104:23: sparse:     expected unsigned long long [usertype] steal
   arch/riscv/kernel/paravirt.c:104:23: sparse:     got restricted __le64
   arch/riscv/kernel/paravirt.c:109:16: sparse: sparse: cast to restricted __le64

vim +/__pcpu_scope_steal_time +44 arch/riscv/kernel/paravirt.c

    43	
  > 44	DEFINE_PER_CPU(struct sbi_sta_struct, steal_time) __aligned(64);
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

