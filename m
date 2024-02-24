Return-Path: <linux-kernel+bounces-79479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACE38622CD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62B31C21F10
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC245168BA;
	Sat, 24 Feb 2024 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOkXgh8S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E462563;
	Sat, 24 Feb 2024 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754321; cv=none; b=rvZUtqPYRgHubn2GJHn480QkIPX9vcLDkotT0pxT7WSLFqL1nr+yvGUwSco3/eoufoCIiepc0HqhOI2OY7bDwlpmtdqIp7SmfTjvYWRaLB9ZqR6340cgNE0qTwtrCcLWAAlMcxKLsAlrSicRyU1lBwd4iEW0Dok2CEU7adQ6XY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754321; c=relaxed/simple;
	bh=TdvUJHnhdNcKHJAUA2hyYixe1O6zS5I5PuwSVmz9wm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBMzrW0lic+KWMokno10E1k/lAAJnvcc0rx+wdhb2kunWCWlmPXfHzpc6xDpPJ77KSk0AZFVvB3ftqwSDiJR+m6jq6KCcDgwewEiMRv1crKVWkKqm7MPDYgMnmUHciUBjV5IO5PFyYkVaWjLdaRHUFU2SWf2uWqdw/dlprN4jnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOkXgh8S; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708754320; x=1740290320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TdvUJHnhdNcKHJAUA2hyYixe1O6zS5I5PuwSVmz9wm8=;
  b=WOkXgh8SbCqROSn/a3ZtUvpReVc59xCWaLwwtHWy2k+1NsvGGUTCTGc5
   EbeTpqoxzRkhUfzxfZ9ivmvsO44iiASlJ1nXX+xfsNNGKCGyXQQ84V0OU
   mosWQz45Y26zKGKahOxupVHwASUbE7tQJf1PuaTR8nFBXXiS1tAfBou/D
   +aJ6qBpiZy2jjC2+TEB48RHaNP7Eohp2Zq3xw7fQmFcUxdTroqJSdOvWX
   dWgKffPr9VnuOJoHEOK3SPrSxMEWbUDt/Giwh+KfLO4ubbTWqDEeaBA6A
   hucmJCy4V3UVKTRsvSpMTiYJCoc//+xrfu6yoGukF+UG21wX0jM/LtnpR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3009409"
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="3009409"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 21:58:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="43587996"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 23 Feb 2024 21:58:35 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdl3Q-0008Gy-1J;
	Sat, 24 Feb 2024 05:58:32 +0000
Date: Sat, 24 Feb 2024 13:58:07 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	idosch@nvidia.com, razor@blackwall.org, amcohen@nvidia.com,
	petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com,
	bpoirier@nvidia.com, gavinl@nvidia.com, martin.lau@kernel.org,
	daniel@iogearbox.net, herbert@gondor.apana.org.au,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] net: vxlan: enable local address bind for
 vxlan sockets
Message-ID: <202402241309.eGUSV2aI-lkp@intel.com>
References: <a4cd1adb-74d4-4eea-9f74-0d0ac3d79e44@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4cd1adb-74d4-4eea-9f74-0d0ac3d79e44@gmail.com>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Gobert/net-vxlan-enable-local-address-bind-for-vxlan-sockets/20240223-045600
base:   net-next/main
patch link:    https://lore.kernel.org/r/a4cd1adb-74d4-4eea-9f74-0d0ac3d79e44%40gmail.com
patch subject: [PATCH net-next 1/2] net: vxlan: enable local address bind for vxlan sockets
config: x86_64-randconfig-122-20240224 (https://download.01.org/0day-ci/archive/20240224/202402241309.eGUSV2aI-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240224/202402241309.eGUSV2aI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402241309.eGUSV2aI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/vxlan/vxlan_core.c:3498:20: error: no member named 'local_ip6' in 'struct udp_port_cfg'
    3498 |                 memcpy(&udp_conf.local_ip6.s6_addr32,
         |                         ~~~~~~~~ ^
   include/linux/fortify-string.h:639:17: note: expanded from macro 'memcpy'
     639 |                 __struct_size(p), __struct_size(q),                     \
         |                               ^
   include/linux/compiler_types.h:358:56: note: expanded from macro '__struct_size'
     358 | #define __struct_size(p)        __builtin_dynamic_object_size(p, 0)
         |                                                               ^
   include/linux/fortify-string.h:582:27: note: expanded from macro '__fortify_memcpy_chk'
     582 |         const size_t __p_size = (p_size);                               \
         |                                  ^~~~~~
>> drivers/net/vxlan/vxlan_core.c:3498:20: error: no member named 'local_ip6' in 'struct udp_port_cfg'
    3498 |                 memcpy(&udp_conf.local_ip6.s6_addr32,
         |                         ~~~~~~~~ ^
   include/linux/fortify-string.h:640:17: note: expanded from macro 'memcpy'
     640 |                 __member_size(p), __member_size(q),                     \
         |                               ^
   include/linux/compiler_types.h:359:56: note: expanded from macro '__member_size'
     359 | #define __member_size(p)        __builtin_dynamic_object_size(p, 1)
         |                                                               ^
   include/linux/fortify-string.h:584:33: note: expanded from macro '__fortify_memcpy_chk'
     584 |         const size_t __p_size_field = (p_size_field);                   \
         |                                        ^~~~~~~~~~~~
>> drivers/net/vxlan/vxlan_core.c:3498:20: error: no member named 'local_ip6' in 'struct udp_port_cfg'
    3498 |                 memcpy(&udp_conf.local_ip6.s6_addr32,
         |                         ~~~~~~~~ ^
   include/linux/fortify-string.h:638:47: note: expanded from macro 'memcpy'
     638 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                                               ^
   include/linux/fortify-string.h:593:20: note: expanded from macro '__fortify_memcpy_chk'
     593 |         __underlying_##op(p, q, __fortify_size);                        \
         |                           ^
   3 errors generated.


vim +3498 drivers/net/vxlan/vxlan_core.c

  3482	
  3483	static struct socket *vxlan_create_sock(struct net *net, bool ipv6, __be16 port,
  3484						u32 flags, int ifindex,
  3485						union vxlan_addr addr)
  3486	{
  3487		struct socket *sock;
  3488		struct udp_port_cfg udp_conf;
  3489		int err;
  3490	
  3491		memset(&udp_conf, 0, sizeof(udp_conf));
  3492	
  3493		if (ipv6) {
  3494			udp_conf.family = AF_INET6;
  3495			udp_conf.use_udp6_rx_checksums =
  3496			    !(flags & VXLAN_F_UDP_ZERO_CSUM6_RX);
  3497			udp_conf.ipv6_v6only = 1;
> 3498			memcpy(&udp_conf.local_ip6.s6_addr32,
  3499			       &addr.sin6.sin6_addr.s6_addr32,
  3500			       sizeof(addr.sin6.sin6_addr.s6_addr32));
  3501		} else {
  3502			udp_conf.family = AF_INET;
  3503			udp_conf.local_ip.s_addr = addr.sin.sin_addr.s_addr;
  3504			memcpy(&udp_conf.local_ip.s_addr,
  3505			       &addr.sin.sin_addr.s_addr,
  3506			       sizeof(addr.sin.sin_addr.s_addr));
  3507		}
  3508	
  3509		udp_conf.local_udp_port = port;
  3510		udp_conf.bind_ifindex = ifindex;
  3511	
  3512		/* Open UDP socket */
  3513		err = udp_sock_create(net, &udp_conf, &sock);
  3514		if (err < 0)
  3515			return ERR_PTR(err);
  3516	
  3517		udp_allow_gso(sock->sk);
  3518		return sock;
  3519	}
  3520	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

