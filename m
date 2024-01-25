Return-Path: <linux-kernel+bounces-38629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA9783C366
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8DA1C233CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE034F893;
	Thu, 25 Jan 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYzd4yMB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DD4F21D;
	Thu, 25 Jan 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188422; cv=none; b=rh3EOZ6SE+pF3ypScm1CdEem2p2UyPtO79So/kd/xVazFXK0py8DS30qb+fb7XZmYqGSX+qVbLXuGdgz6p3+PKzIFqBUywg43RYqEAfYDIxgwcWzDskxQoTxogBSp1+Jl1ddcQE/dxiQbuvKQNAX1dci+EBXZ+VWcSHb4kK99qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188422; c=relaxed/simple;
	bh=TxuJPyUhqCMM8oE9c/YfYJXNjwat6HPusNObJpnlvvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saCFSAWECfQYW0lqv7yVPK1JCtzU6aSN1O3sLxmiBl4pfspHcsDwypW/cXUsthV8/aNHzIAle3VlXpIx4zc0KtOeoqI4O0Pbe6fVA2+Zbt6WWVBctieJXBsxh9RAW9xN0U3IkMPIhn725WEK7FWaEZ/eAmArEubpTDBPKk86jyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYzd4yMB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706188421; x=1737724421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TxuJPyUhqCMM8oE9c/YfYJXNjwat6HPusNObJpnlvvQ=;
  b=eYzd4yMBbwS38aSY06xvkzFOFzh6E9WlShkeb3PqT5JmUf9XN5mMGvYx
   YLot9gDwgvgsqTT7Z0za3CjDsR9vVBgGeplELH2vRmaShVGDdfs6MIRiI
   ssmHlyL3bM9UAXiH3rxSfJFx5VjjRCzbOubq3g3aY2dtvBdh9QK7DEUyY
   JmtV19hN9zOzl+Gt+CgUCEWlCGf+MkxnGrlh2x74i+Fv7HoUpnc/LkRdH
   Ll4WCChRAoC3Yc9e35QGla3/QMWIZvVvBaPjTYC5Z9xRvmFEsUmr94T7b
   Ks3iah9DNClcN7yETz6kMrK4OjzVgc8pbym9fHnA07CBJPJBhY659U8nJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="23619204"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="23619204"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 05:13:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2266864"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Jan 2024 05:13:36 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSzXx-000901-0u;
	Thu, 25 Jan 2024 13:13:33 +0000
Date: Thu, 25 Jan 2024 21:12:35 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, chuck.lever@oracle.com,
	jlayton@kernel.org, linux-api@vger.kernel.org, brauner@kernel.org,
	edumazet@google.com, davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org, weiwan@google.com,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [net-next v2 3/4] eventpoll: Add epoll ioctl for epoll_params
Message-ID: <202401252141.eUlgsF08-lkp@intel.com>
References: <20240125003014.43103-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125003014.43103-4-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/eventpoll-support-busy-poll-per-epoll-instance/20240125-083418
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240125003014.43103-4-jdamato%40fastly.com
patch subject: [net-next v2 3/4] eventpoll: Add epoll ioctl for epoll_params
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240125/202401252141.eUlgsF08-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240125/202401252141.eUlgsF08-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401252141.eUlgsF08-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/eventpoll.c: In function 'ep_eventpoll_ioctl':
>> fs/eventpoll.c:879:22: warning: unused variable 'uarg' [-Wunused-variable]
     879 |         void __user *uarg = (void __user *) arg;
         |                      ^~~~
>> fs/eventpoll.c:878:29: warning: unused variable 'epoll_params' [-Wunused-variable]
     878 |         struct epoll_params epoll_params;
         |                             ^~~~~~~~~~~~
   fs/eventpoll.c:877:27: warning: variable 'ep' set but not used [-Wunused-but-set-variable]
     877 |         struct eventpoll *ep;
         |                           ^~


vim +/uarg +879 fs/eventpoll.c

   873	
   874	static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
   875	{
   876		int ret;
   877		struct eventpoll *ep;
 > 878		struct epoll_params epoll_params;
 > 879		void __user *uarg = (void __user *) arg;
   880	
   881		if (!is_file_epoll(file))
   882			return -EINVAL;
   883	
   884		ep = file->private_data;
   885	
   886		switch (cmd) {
   887	#ifdef CONFIG_NET_RX_BUSY_POLL
   888		case EPIOCSPARAMS:
   889			if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
   890				return -EFAULT;
   891	
   892			if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT)
   893				pr_err("busy poll budget %u exceeds suggested maximum %u\n",
   894						epoll_params.busy_poll_budget, NAPI_POLL_WEIGHT);
   895	
   896			ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
   897			ep->busy_poll_budget = epoll_params.busy_poll_budget;
   898			return 0;
   899	
   900		case EPIOCGPARAMS:
   901			memset(&epoll_params, 0, sizeof(epoll_params));
   902			epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
   903			epoll_params.busy_poll_budget = ep->busy_poll_budget;
   904			if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
   905				return -EFAULT;
   906	
   907			return 0;
   908	#endif
   909		default:
   910			ret = -EINVAL;
   911			break;
   912		}
   913	
   914		return ret;
   915	}
   916	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

