Return-Path: <linux-kernel+bounces-31630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8102383319C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226F9B22A45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6061459174;
	Fri, 19 Jan 2024 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNlwXZPQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDF5914D;
	Fri, 19 Jan 2024 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707503; cv=none; b=I8So90JwjIV/CZOE+0nAEjhQXecYvLN2dB8P5bIo9+UMjEOBbqch9uyfzemH+82bTzMZKe7Tazk//uN92S9ZOxEf804lBf9T5se7BjlG+kygS7rPwsEIMROn2/QmBx5MPGqnG23S0SeHSBbRhSfTPgvIZqwAHShstOMr2qascxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707503; c=relaxed/simple;
	bh=7+hMZpFmWpmV+mrB7PolbtyQ9ZwFs+8lmmyhfHO0Z3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erEMkH5S8/63VdF0JkwHGNPGPEMoixA0SYhL6euwdykc8a+R5Zc2E0mJpC8dP73+MLKUsdi79oVxAHmdjyJ+srVElZQUEmgdvTWsMPf2vthm7mj+dMr7ihzry5WiGycYEUi4LI5LvPW0r4vs1/Zj4QtPWdq43xKzbvnDC6OyWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNlwXZPQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707502; x=1737243502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7+hMZpFmWpmV+mrB7PolbtyQ9ZwFs+8lmmyhfHO0Z3w=;
  b=nNlwXZPQOhwHJ1BZNHRTlqOawB+Fa3NoJUy2vsaLzqgwplMSR6eAivfV
   c8UtPUiutYFBDgv14OYSyTnhXQt9q1PnmrKyobTTneg6KCiVAgMO5I9NM
   eq97iUfRuuqNG0WR/qwCP7TAJy45rUcmijenNFrgm5SRogKGiFP6YBwdu
   lU5ClKaj4guxHt2oydb3kkywSh6cFgPRNTSEdXl3d3xVmoj/+M4EUSKru
   anqpXoIBM9Ab1TucDBHe6VbCVNDqq6E8Nbu+IV+85n8Cs/wNHuLYzITAy
   aMiP7/3YxLIx0jjvCZIxPgWoAj5B7xfohemtnfl7CAWC5w9Ed69X/PAr8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="751691"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="751691"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:38:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="855452102"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="855452102"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jan 2024 15:38:17 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQyRD-0004VG-1j;
	Fri, 19 Jan 2024 23:38:15 +0000
Date: Sat, 20 Jan 2024 07:37:34 +0800
From: kernel test robot <lkp@intel.com>
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	razor@blackwall.org, leon@kernel.org, haleyb.dev@gmail.com,
	ja@ssi.bg, judyhsiao@chromium.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next v1] neighbour: complement nl_ntbl_parm_policy
Message-ID: <202401200717.gbJdfFML-lkp@intel.com>
References: <20240119070847.5402-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119070847.5402-1-linma@zju.edu.cn>

Hi Lin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Ma/neighbour-complement-nl_ntbl_parm_policy/20240119-151255
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240119070847.5402-1-linma%40zju.edu.cn
patch subject: [PATCH net-next v1] neighbour: complement nl_ntbl_parm_policy
config: arm-randconfig-001-20240120 (https://download.01.org/0day-ci/archive/20240120/202401200717.gbJdfFML-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d92ce344bf641e6bb025b41b3f1a77dd25e2b3e9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401200717.gbJdfFML-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401200717.gbJdfFML-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/neighbour.c:2296:3: error: use of undeclared identifier 'NPTPA_QUEUE_LEN_BYTES'; did you mean 'NDTPA_QUEUE_LENBYTES'?
    2296 |         [NPTPA_QUEUE_LEN_BYTES]         = { .type = NLA_U32 },
         |          ^~~~~~~~~~~~~~~~~~~~~
         |          NDTPA_QUEUE_LENBYTES
   include/uapi/linux/neighbour.h:160:2: note: 'NDTPA_QUEUE_LENBYTES' declared here
     160 |         NDTPA_QUEUE_LENBYTES,           /* u32 */
         |         ^
   1 error generated.


vim +2296 net/core/neighbour.c

  2292	
  2293	static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
  2294		[NDTPA_IFINDEX]			= { .type = NLA_U32 },
  2295		[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
> 2296		[NPTPA_QUEUE_LEN_BYTES]         = { .type = NLA_U32 },
  2297		[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
  2298		[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
  2299		[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
  2300		[NDTPA_MCAST_PROBES]		= { .type = NLA_U32 },
  2301		[NDTPA_MCAST_REPROBES]		= { .type = NLA_U32 },
  2302		[NDTPA_BASE_REACHABLE_TIME]	= { .type = NLA_U64 },
  2303		[NDTPA_GC_STALETIME]		= { .type = NLA_U64 },
  2304		[NDTPA_DELAY_PROBE_TIME]	= { .type = NLA_U64 },
  2305		[NDTPA_RETRANS_TIME]		= { .type = NLA_U64 },
  2306		[NDTPA_ANYCAST_DELAY]		= { .type = NLA_U64 },
  2307		[NDTPA_PROXY_DELAY]		= { .type = NLA_U64 },
  2308		[NDTPA_LOCKTIME]		= { .type = NLA_U64 },
  2309		[NDTPA_INTERVAL_PROBE_TIME_MS]	= { .type = NLA_U64, .min = 1 },
  2310	};
  2311	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

