Return-Path: <linux-kernel+bounces-79518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC586238D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1251F1F233A2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20018035;
	Sat, 24 Feb 2024 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKP+G4j1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753417580;
	Sat, 24 Feb 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765299; cv=none; b=KvdAO6rwXFE+dTYcbeJaO+HgwzIOhQwsjlRdhSHqZyjx8OmhMZ4wGijUhY1DyBa2Y0M9Uata7AI+YbBLpbg+aPt7AKMdD0XD9j2bS+nh3+IHfny1mHk/4nq01E6+5ueEf8cRr+T0l9gMcRI1EU8x8zwhUYKJcQr8pa7ODIpTsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765299; c=relaxed/simple;
	bh=g2+qcJdjdBYbAjdVnawnYr/RLAK7tREUpoNEq3hL37M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX2ELvkdS3uflC01MpmzzXmEwS7SKeYMkyFFhKjIJ6Wu6U01lhmrW2APbFuepL/QWZ3QoK4ZEt2pIzMlLIosTr0pHExn63/qk0jku7PS6kpyDLtQVaH4oeYRugXoLQo+dFxywojSWTOGJKr6TANOqGgCRTa8GUXBO5k8iXgJTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKP+G4j1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708765297; x=1740301297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g2+qcJdjdBYbAjdVnawnYr/RLAK7tREUpoNEq3hL37M=;
  b=NKP+G4j1MA7A5Y7cD+xJYeLzBoeVfeMTxeOzGH28kfUmSXSRAe05kpBj
   +21Cy8HVVZ0HLA1YdwccWOfVUac5EMvVviX+ailbb6Zdck0ZdTwoqmJmT
   WSxy0B9jzRLxQHaNkI8i2kOHfsKxTLqsinzRHn0ja68pUYDu741pmdLfg
   lseALuxOVt03iVjh62jX+TIs58hN2xByFRS7PGm+DBcmsTgmdHAUMK2tJ
   Jy9GQx9dTtExIV/4HUi8yWv4t6D0RDEdZeTkzx6yyn9lDvABazrJxpLym
   sbJdzS+GEuOiQft4fRPBLcE/LRFFW+6oAIPxsfvHg2/KKK0AA47ReTgBG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2960931"
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="2960931"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 01:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="6581036"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Feb 2024 01:01:31 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdnuT-0008Oe-19;
	Sat, 24 Feb 2024 09:01:29 +0000
Date: Sat, 24 Feb 2024 17:01:14 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	idosch@nvidia.com, razor@blackwall.org, amcohen@nvidia.com,
	petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com,
	bpoirier@nvidia.com, gavinl@nvidia.com, martin.lau@kernel.org,
	daniel@iogearbox.net, herbert@gondor.apana.org.au,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next 2/2] net: geneve: enable local address bind for
 geneve sockets
Message-ID: <202402241629.S6oEesWO-lkp@intel.com>
References: <79a8ba83-86bf-4c22-845c-8f285c2d1396@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a8ba83-86bf-4c22-845c-8f285c2d1396@gmail.com>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Gobert/net-vxlan-enable-local-address-bind-for-vxlan-sockets/20240223-045600
base:   net-next/main
patch link:    https://lore.kernel.org/r/79a8ba83-86bf-4c22-845c-8f285c2d1396%40gmail.com
patch subject: [PATCH net-next 2/2] net: geneve: enable local address bind for geneve sockets
config: x86_64-randconfig-012-20240224 (https://download.01.org/0day-ci/archive/20240224/202402241629.S6oEesWO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240224/202402241629.S6oEesWO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402241629.S6oEesWO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:292,
                    from include/linux/bitmap.h:12,
                    from include/linux/ethtool.h:16,
                    from drivers/net/geneve.c:10:
   drivers/net/geneve.c: In function 'geneve_create_sock':
>> drivers/net/geneve.c:469:34: error: 'struct udp_port_cfg' has no member named 'local_ip6'; did you mean 'local_ip'?
     469 |                 memcpy(&udp_conf.local_ip6,
         |                                  ^~~~~~~~~
   include/linux/fortify-string.h:582:34: note: in definition of macro '__fortify_memcpy_chk'
     582 |         const size_t __p_size = (p_size);                               \
         |                                  ^~~~~~
   include/linux/fortify-string.h:639:17: note: in expansion of macro '__struct_size'
     639 |                 __struct_size(p), __struct_size(q),                     \
         |                 ^~~~~~~~~~~~~
   drivers/net/geneve.c:469:17: note: in expansion of macro 'memcpy'
     469 |                 memcpy(&udp_conf.local_ip6,
         |                 ^~~~~~
>> drivers/net/geneve.c:469:34: error: 'struct udp_port_cfg' has no member named 'local_ip6'; did you mean 'local_ip'?
     469 |                 memcpy(&udp_conf.local_ip6,
         |                                  ^~~~~~~~~
   include/linux/fortify-string.h:584:40: note: in definition of macro '__fortify_memcpy_chk'
     584 |         const size_t __p_size_field = (p_size_field);                   \
         |                                        ^~~~~~~~~~~~
   include/linux/fortify-string.h:640:17: note: in expansion of macro '__member_size'
     640 |                 __member_size(p), __member_size(q),                     \
         |                 ^~~~~~~~~~~~~
   drivers/net/geneve.c:469:17: note: in expansion of macro 'memcpy'
     469 |                 memcpy(&udp_conf.local_ip6,
         |                 ^~~~~~
>> drivers/net/geneve.c:469:34: error: 'struct udp_port_cfg' has no member named 'local_ip6'; did you mean 'local_ip'?
     469 |                 memcpy(&udp_conf.local_ip6,
         |                                  ^~~~~~~~~
   include/linux/fortify-string.h:593:27: note: in definition of macro '__fortify_memcpy_chk'
     593 |         __underlying_##op(p, q, __fortify_size);                        \
         |                           ^
   drivers/net/geneve.c:469:17: note: in expansion of macro 'memcpy'
     469 |                 memcpy(&udp_conf.local_ip6,
         |                 ^~~~~~


vim +469 drivers/net/geneve.c

   454	
   455	static struct socket *geneve_create_sock(struct net *net, bool ipv6,
   456						 __be16 port, bool ipv6_rx_csum,
   457						 union geneve_addr *local_addr)
   458	{
   459		struct socket *sock;
   460		struct udp_port_cfg udp_conf;
   461		int err;
   462	
   463		memset(&udp_conf, 0, sizeof(udp_conf));
   464	
   465		if (ipv6) {
   466			udp_conf.family = AF_INET6;
   467			udp_conf.ipv6_v6only = 1;
   468			udp_conf.use_udp6_rx_checksums = ipv6_rx_csum;
 > 469			memcpy(&udp_conf.local_ip6,
   470			       &local_addr->sin6.sin6_addr,
   471			       sizeof(local_addr->sin6.sin6_addr));
   472		} else {
   473			udp_conf.family = AF_INET;
   474			udp_conf.local_ip.s_addr = htonl(INADDR_ANY);
   475			memcpy(&udp_conf.local_ip,
   476			       &local_addr->sin.sin_addr,
   477			       sizeof(local_addr->sin.sin_addr));
   478		}
   479	
   480		udp_conf.local_udp_port = port;
   481	
   482		/* Open UDP socket */
   483		err = udp_sock_create(net, &udp_conf, &sock);
   484		if (err < 0)
   485			return ERR_PTR(err);
   486	
   487		udp_allow_gso(sock->sk);
   488		return sock;
   489	}
   490	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

