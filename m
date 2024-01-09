Return-Path: <linux-kernel+bounces-20370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B774D827DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF4E2854B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF5612E;
	Tue,  9 Jan 2024 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ea+/UYHr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740FD6103
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 04:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704773702; x=1736309702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eql/ryGXYpBfNi/IwL27//vHSjTMaBfZJ75XRfdcXH4=;
  b=Ea+/UYHrG8BalRXqaYAOhpk9/RPMsFYe3czyf4Zydtp5RemQi2A4R0S+
   a8iLjWQKL4AKmIibbQ+VZ4QG/0Ma9EZNk3nf042fOI54mFzhZzgVJCuiy
   mXrjdVLf8YIiFaxVJNZi6bHJVhtN09yfOxh0ooQ3ewJ5IeVe3gASgBFEe
   5UxgtZAPV44ZPQMBpbl4bTaSrDhlE3JE0ic7SIH67VCnP/iWZATwqey+j
   IZwr2yJe2NkwdsgTfXuZulEnLQ+xxIM2YqVq9uiG+m059Un/7jgiCcwLy
   7b6piFc0Ok5VnwXXSi9h9nQEJZZhXZQUai06FD+uwcOM0eFp3dPOBHOxd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5426383"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="5426383"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 20:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872104783"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="872104783"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jan 2024 20:14:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rN3Vw-0005SM-0J;
	Tue, 09 Jan 2024 04:14:56 +0000
Date: Tue, 9 Jan 2024 12:14:45 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Palmer <daniel@0x0f.com>, gerg@linux-m68k.org,
	geert@linux-m68k.org, fthain@linux-m68k.org
Cc: oe-kbuild-all@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 2/2] m68k: Fix interrupt stack frames for 68000
Message-ID: <202401091123.K60t1Foe-lkp@intel.com>
References: <20240108093221.1477020-3-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108093221.1477020-3-daniel@0x0f.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on gerg-m68knommu/for-next]
[also build test ERROR on geert-m68k/for-next geert-m68k/for-linus linus/master v6.7 next-20240108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Palmer/m68k-Use-macro-to-generate-68000-interrupt-entry-sleds/20240108-175040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
patch link:    https://lore.kernel.org/r/20240108093221.1477020-3-daniel%400x0f.com
patch subject: [PATCH v2 2/2] m68k: Fix interrupt stack frames for 68000
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240109/202401091123.K60t1Foe-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091123.K60t1Foe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401091123.K60t1Foe-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> error: arch/m68k/include/uapi/asm/ptrace.h: leak CONFIG_M68000 to user-space
   make[3]: *** [scripts/Makefile.headersinst:63: usr/include/asm/ptrace.h] Error 1
   make[3]: Target '__headers' not remade because of errors.
   make[2]: *** [Makefile:1288: headers] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

