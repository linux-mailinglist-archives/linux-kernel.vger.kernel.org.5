Return-Path: <linux-kernel+bounces-11309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05D81E458
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDD828129E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF2EEB7;
	Tue, 26 Dec 2023 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzbUMhep"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20106EAEE;
	Tue, 26 Dec 2023 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703552728; x=1735088728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5fjzzSMSrRrSSDVeE4lsTbpR6OOdl61CCzr2auoGYjk=;
  b=CzbUMhepyMRL081WChJbcSg38POBYBPcbldT/gXblPYcolXlBvqB16nP
   ogsuxtbAm/IS1yAMuk8w/sx995ddUxVl0EPNxQuv6RGjJ7UBAuLbD7Fqb
   Z2FyMMDOMWWVlMbQm4F689GRXa1WNHDqi9zy91fm4zOHF9FTkjtmAz1ny
   6NXHjbihtKhhkYlIrXzWQLWoV8JROXcIEHllwye/icxFxhMkn1/dbNdEc
   t+keD8SvwrNTT+pzqBxMuO5czM4lq9eFrKikawAkPXDJEZQE7CWgcdcn2
   w2BKaOYEqFKzNN7BSuyGYuZamzdNakTAxdHsidMTX/OnfxHwIZfQMtlQk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="400130309"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="400130309"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 17:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="896436694"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="896436694"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 25 Dec 2023 17:05:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHvsn-000DpV-0L;
	Tue, 26 Dec 2023 01:05:21 +0000
Date: Tue, 26 Dec 2023 09:04:23 +0800
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
Message-ID: <202312260844.FPx3YOsI-lkp@intel.com>
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
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20231226/202312260844.FPx3YOsI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260844.FPx3YOsI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260844.FPx3YOsI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/char/hw_random/via-rng.c:220:26: error: conflicting types for 'via_rng_cpu_id'; have 'struct x86_cpu_id[]'
     220 | static struct x86_cpu_id via_rng_cpu_id[] = {
         |                          ^~~~~~~~~~~~~~
   drivers/char/hw_random/via-rng.c:38:32: note: previous declaration of 'via_rng_cpu_id' with type 'const struct x86_cpu_id[]'
      38 | static const struct x86_cpu_id via_rng_cpu_id[];
         |                                ^~~~~~~~~~~~~~
   drivers/char/hw_random/via-rng.c:38:32: warning: array 'via_rng_cpu_id' assumed to have one element


vim +220 drivers/char/hw_random/via-rng.c

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

