Return-Path: <linux-kernel+bounces-31822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7249883352A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C47B1C20F99
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFF101EE;
	Sat, 20 Jan 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSKsiSOp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E465FC0A;
	Sat, 20 Jan 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705763508; cv=none; b=p8nBWOsTPwCL7qfJYVbzhBKbcNhm/KtUoNX6fjI5CXXVqLozYCDLQXqbEy8gHZcbCslrr2K7cOvK//wnWcxP2VZEajziq9lZijGUD3FApQtHt8mYKpi9LHXZD4vUn7O56ksq2GzEuP27X+thh9aDsY6ccwpcYcd+jxP/ObkDpNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705763508; c=relaxed/simple;
	bh=u3YBrFEsSBqsOGlt7vGKNsBZQ2vucaM4CGZCHTn3S8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X22AyfE1ROFdbiXm2JdKFvTsDbR5IPOoxx8+pgfjAwtgqtGz90zcQUx6IzPzJFLG8HGt7CW/9TB72MR0nG1YB6NsB8e8/kW8f49U2GfMgLlTuxiKj8+bvMa+1cpS2p6M0YPCZs6S6Z3+cCAtOWmfIpxP4vP1qKHC51EoIpJC4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSKsiSOp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705763508; x=1737299508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u3YBrFEsSBqsOGlt7vGKNsBZQ2vucaM4CGZCHTn3S8Q=;
  b=nSKsiSOpyYl2Zh6PUF0RR+yvex7q/pJD4THo0swJAOHr2Cor0TUKhl4V
   889q9BKx739QoOvqIk6L2f1Egm22cKIA4cBYULHkjyMJRgLJhxc2JCt6i
   QdnJd7/V3VMpJ/57yRds7LqiB/wYwVkgcKbZHPmtZv4Ov47/dDMpFElu4
   +3IrqNeJe3ES5ZO24sj8QF8fh15TJvX1w5pD9zxcEnyQiJXEGhUtWeFp1
   XEDcfHsU88ThIsX53edTU2MH/vLuwIED4KU0ooWTaaMMyq86a1queUirN
   zf1SNlmnTYdy7ogSZrtQampxycrg2tEEpe6/jFuLX3dHEFlFtx1lXzrGZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="19521053"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="19521053"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 07:11:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="1116483944"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="1116483944"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jan 2024 07:11:42 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRD0W-0005C2-0j;
	Sat, 20 Jan 2024 15:11:40 +0000
Date: Sat, 20 Jan 2024 23:11:12 +0800
From: kernel test robot <lkp@intel.com>
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	razor@blackwall.org, leon@kernel.org, haleyb.dev@gmail.com,
	ja@ssi.bg, judyhsiao@chromium.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next v1] neighbour: complement nl_ntbl_parm_policy
Message-ID: <202401202347.sHNru6Y6-lkp@intel.com>
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240120/202401202347.sHNru6Y6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401202347.sHNru6Y6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401202347.sHNru6Y6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/neighbour.c:2296:10: error: 'NPTPA_QUEUE_LEN_BYTES' undeclared here (not in a function); did you mean 'NDTPA_QUEUE_LENBYTES'?
    2296 |         [NPTPA_QUEUE_LEN_BYTES]         = { .type = NLA_U32 },
         |          ^~~~~~~~~~~~~~~~~~~~~
         |          NDTPA_QUEUE_LENBYTES
>> net/core/neighbour.c:2296:10: error: array index in initializer not of integer type
   net/core/neighbour.c:2296:10: note: (near initialization for 'nl_ntbl_parm_policy')
   net/core/neighbour.c:2298:43: warning: initialized field overwritten [-Woverride-init]
    2298 |         [NDTPA_APP_PROBES]              = { .type = NLA_U32 },
         |                                           ^
   net/core/neighbour.c:2298:43: note: (near initialization for 'nl_ntbl_parm_policy[9]')


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

