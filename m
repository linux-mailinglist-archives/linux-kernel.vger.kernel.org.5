Return-Path: <linux-kernel+bounces-18450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A638D825DBE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF331C23A8F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E5115B1;
	Sat,  6 Jan 2024 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYl4H2UP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45715AB;
	Sat,  6 Jan 2024 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704505866; x=1736041866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kENHpnKp3Mc72FB3iQsqSSxWwNZF4fgvq/yw+UTQgsk=;
  b=aYl4H2UPYpJsRBLJvtcQikx89dTDbNxLqEkDHbr9kndpijnp9/TKyNMg
   cpGNgxJeVWybNPQgQ5FoEGNBUXM4uYKlEuG81sEZnsa09lKhDMms81g0B
   dsfDIRP8OGvkcTSywI89lQgzSjxyPDaj837xgG9N/5wwoJh/2C5mi3W6y
   W9T1MoidWjE35cy4uQPAKObSa5BhvCbE5B9pDUH1REqFd38q+oZZkE2vu
   eLYmLznxh2zKXGm56FHynciRQYdG20hiE7dpjL1niFfcbZcu2Qvi3WW+v
   +Dz+zvzphb2iFq0sXeOXCR+Xle9Ll663Y0gxc3APqhNAneD5rqhad9BhN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4984486"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="4984486"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 17:51:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="904298606"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="904298606"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2024 17:51:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLvq0-0001u8-2R;
	Sat, 06 Jan 2024 01:51:00 +0000
Date: Sat, 6 Jan 2024 09:50:06 +0800
From: kernel test robot <lkp@intel.com>
To: Brett Creeley <brett.creeley@amd.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, shannon.nelson@amd.com,
	brett.creeley@amd.com
Subject: Re: [PATCH net-next 4/8] pds_core: Prevent race issues involving the
 adminq
Message-ID: <202401060952.4J8S3LbP-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240106/202401060952.4J8S3LbP-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401060952.4J8S3LbP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401060952.4J8S3LbP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/amd/pds_core/core.c:518:6: warning: no previous prototype for 'pdsc_adminq_wait_and_dec_once_unused' [-Wmissing-prototypes]
     518 | void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

