Return-Path: <linux-kernel+bounces-10148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDF81D0BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9951F22E01
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852D4A0C;
	Sat, 23 Dec 2023 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7oahVnx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B92440C;
	Sat, 23 Dec 2023 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703290522; x=1734826522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ws0TygMMtf/phnOvtmj/fglneDu5qG5xFkyTN/kvubk=;
  b=b7oahVnxhlzLmDhUTQ5gD5lWJBSuHKmi77IHwB2rUkY8dbPAvZtTkeL+
   kC2vInC3N7w25Gwp7Jh0UULdiQAvLsRLwbOT0XCDqYWV/L9oLORfdjYE9
   +osnpsAzEVuQKfPQZgZ+bB8qmklNqhlGYPJhppTj20+RADyuc0IpX4eQ+
   l6Wv1tHgAav2lufhgM6BiAbAx+OhiyNU5G5adO/sry64Sq+Bms/3BMqbM
   9ks11apEwPyZaaB0432ITG87pr/lsIF2k3tXdarGvEI/1z4dog20t0zSO
   C2So4UyTNyZkqyIVOwssLSEaNZ0kb6aJA2MeQ1AGD5ApEHomJ6opKxWR0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="17740308"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="17740308"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:15:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="920821874"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="920821874"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2023 16:15:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGpeO-000A1n-1R;
	Sat, 23 Dec 2023 00:14:39 +0000
Date: Sat, 23 Dec 2023 08:11:35 +0800
From: kernel test robot <lkp@intel.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, olivia@selenic.com,
	herbert@gondor.apana.org.au, jiajie.ho@starfivetech.com,
	conor.dooley@microchip.com, martin@kaiser.cx, mmyangfl@gmail.com,
	jenny.zhang@starfivetech.com, robh@kernel.org,
	l.stelmach@samsung.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, YunShen@zhaoxin.com,
	LeoLiu@zhaoxin.com, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: Re: [PATCH v3] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
Message-ID: <202312230731.XIJLqDeg-lkp@intel.com>
References: <20231221062602.799432-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221062602.799432-1-LeoLiu-oc@zhaoxin.com>

Hi LeoLiu-oc,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master linus/master v6.7-rc6 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/hwrng-add-Zhaoxin-rng-driver-base-on-rep_xstore-instruction/20231222-174625
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231221062602.799432-1-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH v3] hwrng: add Zhaoxin rng driver base on rep_xstore instruction
config: i386-buildonly-randconfig-003-20231223 (https://download.01.org/0day-ci/archive/20231223/202312230731.XIJLqDeg-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230731.XIJLqDeg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230731.XIJLqDeg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/char/hw_random/via-rng.c:38:32: warning: tentative array definition assumed to have one element
   static const struct x86_cpu_id via_rng_cpu_ids[];
                                  ^
>> drivers/char/hw_random/via-rng.c:220:26: warning: unused variable 'via_rng_cpu_id' [-Wunused-variable]
   static struct x86_cpu_id via_rng_cpu_id[] = {
                            ^
   2 warnings generated.


vim +/via_rng_cpu_id +220 drivers/char/hw_random/via-rng.c

   219	
 > 220	static struct x86_cpu_id via_rng_cpu_id[] = {
   221		X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
   222		{}
   223	};
   224	MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
   225	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

