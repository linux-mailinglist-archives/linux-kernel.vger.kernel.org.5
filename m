Return-Path: <linux-kernel+bounces-78917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D23C861A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6DE1C25956
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032AF14037B;
	Fri, 23 Feb 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eu0rUko+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CB12D758;
	Fri, 23 Feb 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710635; cv=none; b=rk1dOl9OOmk5UAQ6bGkooNaHz1Va8vMlVLS4rrzViqLe1AQWGGwOpSAG9XWuwIv4ZmFGkdpJyvihTOpcoHuM6I+8YgdDfbOM+uZVJLOCp1n8+SP8r2q1ZwZubcgye6CeTBmsNqNfvFJr6d0eS8BoMZCdngCaspb9ff9DTpPSQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710635; c=relaxed/simple;
	bh=B6DmhEttlW8Mu2glpPfxHo63S9rUwJ+jcUzzSCLsRmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI8w7fwI4CtMRT38r0URoppsrEMp29U3AlAU0R5tbwtWcIcbrl/e8XuBGMMnpBMCd67ejUwGwrv95n8gcwrCpbRVQnmDuP/nkNJAzVN7Y6pydIP3O9lyUiHk+NyBH1dRStC2yrmJ8t9DQKIQMhU69Im1b393KCrHAq9lJhiemnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eu0rUko+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708710632; x=1740246632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B6DmhEttlW8Mu2glpPfxHo63S9rUwJ+jcUzzSCLsRmg=;
  b=Eu0rUko+nImkEm/asxct11KJmADnNSLX1TVr98AtOPvW5DoW27dg7/xC
   iovCDlc2qxak1JT/TquMQCH5WjZF+M9AU4qehHVslkI0hN+qILdxd0MV6
   zO8uJIanKsmhqmW71psrLSxFAfI6zK7xE6SOUIwJoYpgYAtBDgawRXJXb
   r9dYoeQH5gKf0t+tg9uBcQYl5nRybdD4EuUdEhGQc90LAPXl8inoFcBR7
   az1LJM9A9zxaRtzgyUC3PXNiVHw8Ig95F7Z3dm8XJpFwiADckOHJKDAXd
   9LNrtBz7S2vJC+K69mRUZE+usAKQDx8u03zI6PeCzgpHEaSndqMrPr00D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2925139"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2925139"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6454681"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 23 Feb 2024 09:50:27 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdZgm-0007jH-1L;
	Fri, 23 Feb 2024 17:50:24 +0000
Date: Sat, 24 Feb 2024 01:49:40 +0800
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
Message-ID: <202402240119.AR4eT8mt-lkp@intel.com>
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
config: arc-randconfig-r133-20240223 (https://download.01.org/0day-ci/archive/20240224/202402240119.AR4eT8mt-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240224/202402240119.AR4eT8mt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402240119.AR4eT8mt-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/vxlan/vxlan_core.c: In function 'vxlan_create_sock':
>> drivers/net/vxlan/vxlan_core.c:3498:34: error: 'struct udp_port_cfg' has no member named 'local_ip6'; did you mean 'local_ip'?
    3498 |                 memcpy(&udp_conf.local_ip6.s6_addr32,
         |                                  ^~~~~~~~~
         |                                  local_ip


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

