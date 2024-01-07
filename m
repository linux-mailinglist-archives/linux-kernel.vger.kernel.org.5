Return-Path: <linux-kernel+bounces-18758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC4382629D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F941C21041
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098384407;
	Sun,  7 Jan 2024 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMZVY1/I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A535139C;
	Sun,  7 Jan 2024 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704590927; x=1736126927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7O1UL8cXY0lJE1zmCzGXxOgYFADLmsa5MNEHePLgsoY=;
  b=RMZVY1/IfZbc1V3OdnSsycAz23j7ENNyuN7a2/5WnkPrrkHrid1Nx8+H
   WjxCQXFzsDr9mdBKE7bnPWavrbejEwfX+NIYudiP2KLJjViB9bKJik2ZR
   ZADvFFT8WCaohRqeOl1sZlZJTqnaP9HQ4yGf3G/gursDUg7Hj3Q33/biG
   mgt+5UJ+YI1CKyRnppNnqOluEWvgYw0deZ88gS+XDL+FwFoO7+gDsKt/I
   pZ21qMXRowojOV7Yo0LbATXAHLVGCkSufIPUa2B1K0DgU5as4apOYvzmo
   H9CnUxZNJMvYF7jqMRvu0e9QUybSv++K+7sgls9ooaRJaGz/UBmzsihr+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="428875595"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="428875595"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 17:28:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="23179110"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Jan 2024 17:28:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMHxx-0003F7-0m;
	Sun, 07 Jan 2024 01:28:41 +0000
Date: Sun, 7 Jan 2024 09:28:33 +0800
From: kernel test robot <lkp@intel.com>
To: Brett Creeley <brett.creeley@amd.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	shannon.nelson@amd.com, brett.creeley@amd.com
Subject: Re: [PATCH net-next 4/8] pds_core: Prevent race issues involving the
 adminq
Message-ID: <202401070931.tvTUY2US-lkp@intel.com>
References: <20240104171221.31399-5-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104171221.31399-5-brett.creeley@amd.com>

Hi Brett,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Brett-Creeley/pds_core-Prevent-health-thread-from-running-during-reset-remove/20240105-011706
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240104171221.31399-5-brett.creeley%40amd.com
patch subject: [PATCH net-next 4/8] pds_core: Prevent race issues involving the adminq
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240107/202401070931.tvTUY2US-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070931.tvTUY2US-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070931.tvTUY2US-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/amd/pds_core/core.c:518:6: warning: no previous prototype for function 'pdsc_adminq_wait_and_dec_once_unused' [-Wmissing-prototypes]
     518 | void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
         |      ^
   drivers/net/ethernet/amd/pds_core/core.c:518:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     518 | void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
         | ^
         | static 
   1 warning generated.


vim +/pdsc_adminq_wait_and_dec_once_unused +518 drivers/net/ethernet/amd/pds_core/core.c

   517	
 > 518	void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
   519	{
   520		/* The driver initializes the adminq_refcnt to 1 when the adminq is
   521		 * allocated and ready for use. Other users/requesters will increment
   522		 * the refcnt while in use. If the refcnt is down to 1 then the adminq
   523		 * is not in use and the refcnt can be cleared and adminq freed. Before
   524		 * calling this function the driver will set PDSC_S_FW_DEAD, which
   525		 * prevent subsequent attempts to use the adminq and increment the
   526		 * refcnt to fail. This guarantees that this function will eventually
   527		 * exit.
   528		 */
   529		while (!refcount_dec_if_one(&pdsc->adminq_refcnt)) {
   530			dev_dbg_ratelimited(pdsc->dev, "%s: adminq in use\n",
   531					    __func__);
   532			cpu_relax();
   533		}
   534	}
   535	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

