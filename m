Return-Path: <linux-kernel+bounces-77344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF3860413
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23C11C25590
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6371754;
	Thu, 22 Feb 2024 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8bfosCG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E531B59A;
	Thu, 22 Feb 2024 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635397; cv=none; b=Y35avILvVKQZV1ScsyTj/oLRzBxITVBo1lvzccyST9YQz+P0AIV+q1btLIl9DhPfopMGbcpCvGv6bCrhtW+e5IIXE9M3iHN1gKdvBAowCimqth0h9WqvPXbRlvqOArVWnhGpxOscEvT+QUYFwM/cJdBUrgbijDO5LfAb4SxEbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635397; c=relaxed/simple;
	bh=sCttGzEdOK4egxBE3FWWdZH3y2xnyCFiswncLgXt6Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAZttES2/IsJBMRIIgsDElLlGaPhbY0EO4iaiXt8x/v/sR1jcnnGoEB/QLNvOo9/bEWR0OwZ8zDQhO7nKl8CVv76A0/a4BGTg+0civ+x4aubFyaSnRWAb3KyH5xiQNj9EtZJi8SinLxf+/3+1koKW0QH/2aHUu2zaabXEO4pNbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8bfosCG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708635395; x=1740171395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sCttGzEdOK4egxBE3FWWdZH3y2xnyCFiswncLgXt6Rg=;
  b=N8bfosCGk0L2ma29fRmEt1qxN9bnEs8Ek5rKCqE4Z6N4am9a1znKVNhG
   mSH0Gn6U40Pvny4x8DxLeLo4zS+nyfBBi79Td2pUvoTJ3wKfXPnubYhYg
   HQnwTEiZwIqWzsD6tV6E3HFdFnIpb6kPhXUBA0bVohSAQYqYZO0SECFrl
   ZadsT6xewg94aViKLoBxRkGwsFu0hNsEHH0ztmM0vV62uUOfPD9o9NSK7
   SoaDd2SsYRkIf6FVs7IW+JY+M4gGzMxd5ywe4wXIVB10pA6tuwLZmR8w+
   i2bNzdG7z5L1APxg9Qya+638oTwSfr1lH6uZnQSZT98vgVIhrGZWMzYCP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2759041"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2759041"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:56:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="827603218"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="827603218"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Feb 2024 12:56:24 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdG7B-0006hW-1B;
	Thu, 22 Feb 2024 20:56:21 +0000
Date: Fri, 23 Feb 2024 04:55:26 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI
 APIs
Message-ID: <202402230429.g2qC2zMK-lkp@intel.com>
References: <1708531057-67392-2-git-send-email-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708531057-67392-2-git-send-email-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/netdev-genl-Add-ifname-for-queue-and-NAPI-APIs/20240222-000134
base:   net-next/main
patch link:    https://lore.kernel.org/r/1708531057-67392-2-git-send-email-jdamato%40fastly.com
patch subject: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI APIs
config: powerpc-acadia_defconfig (https://download.01.org/0day-ci/archive/20240223/202402230429.g2qC2zMK-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240223/202402230429.g2qC2zMK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402230429.g2qC2zMK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/netdev-genl.c:388:14: warning: variable 'ifname' is uninitialized when used here [-Wuninitialized]
     388 |         nla_strscpy(ifname, info->attrs[NETDEV_A_QUEUE_IFNAME], IFNAMSIZ);
         |                     ^~~~~~
   net/core/netdev-genl.c:376:14: note: initialize the variable 'ifname' to silence this warning
     376 |         char *ifname;
         |                     ^
         |                      = NULL
   1 warning generated.


vim +/ifname +388 net/core/netdev-genl.c

   370	
   371	int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
   372	{
   373		u32 q_id, q_type, ifindex;
   374		struct net_device *netdev;
   375		struct sk_buff *rsp;
   376		char *ifname;
   377		int err;
   378	
   379		if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
   380		    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
   381		    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
   382		    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFNAME))
   383			return -EINVAL;
   384	
   385		q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
   386		q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
   387		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
 > 388		nla_strscpy(ifname, info->attrs[NETDEV_A_QUEUE_IFNAME], IFNAMSIZ);
   389	
   390		rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
   391		if (!rsp)
   392			return -ENOMEM;
   393	
   394		rtnl_lock();
   395	
   396		netdev = __dev_get_by_index(genl_info_net(info), ifindex);
   397	
   398		if (strcmp(netdev->name, ifname)) {
   399			err = -ENODEV;
   400		} else {
   401			if (netdev)
   402				err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
   403			else
   404				err = -ENODEV;
   405		}
   406	
   407		rtnl_unlock();
   408	
   409		if (err)
   410			goto err_free_msg;
   411	
   412		return genlmsg_reply(rsp, info);
   413	
   414	err_free_msg:
   415		nlmsg_free(rsp);
   416		return err;
   417	}
   418	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

