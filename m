Return-Path: <linux-kernel+bounces-54351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346984AE0D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5A81F248BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6347F7CE;
	Tue,  6 Feb 2024 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="by412leK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8627F7C6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196855; cv=none; b=lu//MFbQfXeUhB1tU6XlUUYBzbnKnlqLs8WdHE5sfkpEDLZKaRoz2sa15nDrIC1moqA2nnDoqLk0DHYFavlFOcx19GIENMaC0V/uI8N7tdT1kDJA7pbh41bOn/NSH+VYE9mcxodEj7JK94YRRt1roiBUHRl062zQs8BoJSOVceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196855; c=relaxed/simple;
	bh=pWUOxlVQHlpSyV46EtmG+wggoUe9bonogEOJmkNN3NY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W0i3Hl4xzsJUtCG/USDua5N9i2cZZ5D9Kr/hx4YwanyQRGDVOCpEnEfZIWGQzSK0nrL7T69pdbk7Kb+8nb2uc3JyfWUYBO4pzzyGZCXP7iPwt4C1atzebNYc6liq5i4DKqMVJb9YGaBllN+QS+U9yF4B28WMBhYvC+hcSn2dLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=by412leK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707196853; x=1738732853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pWUOxlVQHlpSyV46EtmG+wggoUe9bonogEOJmkNN3NY=;
  b=by412leKGOoSsSgVDPzVMwteShuOIDHXzo4z+Aw4XIhxIQJxkGSNZrYJ
   dhM5IZWDmFC0Suvoriw1M6s+f8+qmGEYBiH0FqrBng565mUXLS79Fhg6b
   rCOmQ5R7IEF7K69rbn2WJw80IWNWTFnwuYMOcpqtNT76wBVFxIDkqqYxd
   +UiGXIgrphdOoVdu2c0Ag0yJhkqbbBD0koR62pbJc2FZeEfl3R7L7y7li
   lGJYJ5ctPd40+PZB6GCmFX6jC0dbvf3LeQDFF7NPQI6Lvha4TZgi4uv6B
   VF+CQPQocO8a8qAtZWSIFuYfHJOs5Xzz6kYh+alWCHr8KzmZvjhXyGeHm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18096681"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="18096681"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 21:20:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="31984473"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2024 21:20:50 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXDt3-00015U-0G;
	Tue, 06 Feb 2024 05:20:49 +0000
Date: Tue, 6 Feb 2024 13:19:58 +0800
From: kernel test robot <lkp@intel.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of
 range: -524416 is not in [-524288, 524287]; references
 kallsyms_seqs_of_names
Message-ID: <202402061302.HkByW9x0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Zhen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
commit: 60443c88f3a89fd303a9e8c0e84895910675c316 kallsyms: Improve the performance of kallsyms_lookup_name()
date:   1 year, 3 months ago
config: riscv-randconfig-r064-20240120 (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402061302.HkByW9x0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

