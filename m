Return-Path: <linux-kernel+bounces-11407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C581E5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF1E1F22761
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E296F4CB2C;
	Tue, 26 Dec 2023 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOKfEY0k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C964C625;
	Tue, 26 Dec 2023 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703576993; x=1735112993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+wO1tAzMJBsNwBmiNDTSqAm2EQmTUDeXsbExsAPcjk=;
  b=lOKfEY0kVGMBrC993az55Gmu1SFlDwGymoE9IH4VFgpxOaYAKo5135UY
   /03u+3h2HwHTL1Rx6/WspGExCoT39R4j+otw18kJnY9tFCfYa7Qe6V7JR
   q9/1WT2nNrD0RG/1IYZfQb77b4yq6OFVbosbTJjnKbLsoLjwFzDBLtuHO
   rCr/ILPc1TCUmKTz9FWr0i8aEQYVS9rwxSfnWhuk6iijIMzVae1UYrdpS
   2JgokdFsMlQzG0+2nUEZQ7a6R0qKpcmlIKJJQBYISHlkFa4OVbBPX0ZNN
   DGIeCJ9n3U0f1t0FHwbcidC0IhIz6DdyKRIXkAaPiTZL7GVv/FRAPbZkX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="400149436"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="400149436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 23:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="921505174"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="921505174"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 25 Dec 2023 23:49:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rI2C8-000EDF-0e;
	Tue, 26 Dec 2023 07:49:44 +0000
Date: Tue, 26 Dec 2023 15:49:22 +0800
From: kernel test robot <lkp@intel.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, olivia@selenic.com,
	herbert@gondor.apana.org.au, jiajie.ho@starfivetech.com,
	conor.dooley@microchip.com, martin@kaiser.cx, mmyangfl@gmail.com,
	jenny.zhang@starfivetech.com, robh@kernel.org,
	l.stelmach@samsung.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, YunShen@zhaoxin.com, LeoLiu@zhaoxin.com,
	LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: Re: [PATCH v4] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
Message-ID: <202312261505.rDaQJwAq-lkp@intel.com>
References: <20231225025330.809554-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225025330.809554-1-LeoLiu-oc@zhaoxin.com>

Hi LeoLiu-oc,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/hwrng-add-Zhaoxin-rng-driver-base-on-rep_xstore-instruction/20231225-153520
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231225025330.809554-1-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH v4] hwrng: add Zhaoxin rng driver base on rep_xstore instruction
config: i386-randconfig-141-20231225 (https://download.01.org/0day-ci/archive/20231226/202312261505.rDaQJwAq-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261505.rDaQJwAq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261505.rDaQJwAq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/char/hw_random/via-rng.c:220:26: error: redefinition of 'via_rng_cpu_id' with a different type: 'struct x86_cpu_id[]' vs 'const struct x86_cpu_id[]'
   static struct x86_cpu_id via_rng_cpu_id[] = {
                            ^
   drivers/char/hw_random/via-rng.c:38:32: note: previous definition is here
   static const struct x86_cpu_id via_rng_cpu_id[];
                                  ^
>> drivers/char/hw_random/via-rng.c:224:1: error: definition of variable with array type needs an explicit size or an initializer
   MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
   ^
   include/linux/module.h:244:21: note: expanded from macro 'MODULE_DEVICE_TABLE'
   extern typeof(name) __mod_##type##__##name##_device_table               \
                       ^
   <scratch space>:56:1: note: expanded from here
   __mod_x86cpu__via_rng_cpu_id_device_table
   ^
   drivers/char/hw_random/via-rng.c:38:32: warning: tentative array definition assumed to have one element
   static const struct x86_cpu_id via_rng_cpu_id[];
                                  ^
   1 warning and 2 errors generated.


vim +220 drivers/char/hw_random/via-rng.c

   219	
 > 220	static struct x86_cpu_id via_rng_cpu_id[] = {
   221		X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
   222		{}
   223	};
 > 224	MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
   225	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

