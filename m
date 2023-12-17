Return-Path: <linux-kernel+bounces-2581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0956815F0F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219161C210B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FAA43179;
	Sun, 17 Dec 2023 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1sR076o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8444367;
	Sun, 17 Dec 2023 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702816993; x=1734352993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ACMZYUw/c3LU7bK9uq07xvXLyS+mDBY6zrKqOWw9xCs=;
  b=S1sR076oIn/zdyP+bSNvFkuJMSvftT+Lp8ToGFfdwwWqHJYHxQyyRDe0
   OA5BF7ZQzEMlpB7b579jFVBU4tDRwnzgWtVDWonmZhmZzavtNA2t7u82G
   6ZQPxy4K+1jl4/b0Yg70scF45oc6vUpEF1s7NAaT7c7sUz1fc3NuezVN+
   g5EogIre0pk+38uZqnYnsS0ATBhjJQAls51vZWKUKgvIHa9Ihhf/IcJcU
   +Wx8DtgLRbYVDz4o7GWlLXKANLWP7U2kAYQitLFTjGL8KZd6mfAbfj4RN
   fn7vMSnWJ1L+DUNE2sMz+ry5B5fj5X3vHKeWsAQ/i0jWKnR9uDnRw5wZJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="2239725"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="2239725"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 04:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="865926572"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="865926572"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Dec 2023 04:43:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEqU6-00032G-2T;
	Sun, 17 Dec 2023 12:43:06 +0000
Date: Sun, 17 Dec 2023 20:42:08 +0800
From: kernel test robot <lkp@intel.com>
To: yang.guang5@zte.com.cn, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn,
	cgel.zte@gmail.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sd@queasysnail.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] mlxsw: spectrum: use netif_is_macsec()
 instead of open code
Message-ID: <202312172042.gMYseKZQ-lkp@intel.com>
References: <202312152145312776210@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312152145312776210@zte.com.cn>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231215]

url:    https://github.com/intel-lab-lkp/linux/commits/yang-guang5-zte-com-cn/mlxsw-spectrum-use-netif_is_macsec-instead-of-open-code/20231215-214631
base:   next-20231215
patch link:    https://lore.kernel.org/r/202312152145312776210%40zte.com.cn
patch subject: [PATCH linux-next] mlxsw: spectrum: use netif_is_macsec() instead of open code
config: i386-buildonly-randconfig-003-20231217 (https://download.01.org/0day-ci/archive/20231217/202312172042.gMYseKZQ-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312172042.gMYseKZQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312172042.gMYseKZQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/cgroup/cgroup.c:33:
   In file included from include/linux/bpf-cgroup.h:11:
   In file included from include/net/sock.h:46:
>> include/linux/netdevice.h:5105:1: warning: all paths through this function will call itself [-Winfinite-recursion]
   {
   ^
   1 warning generated.


vim +5105 include/linux/netdevice.h

7967168cefdbc6 Herbert Xu      2006-06-22  5098  
14d7b8122fd591 Jakub Kicinski  2022-05-05  5099  void netif_set_tso_max_size(struct net_device *dev, unsigned int size);
14d7b8122fd591 Jakub Kicinski  2022-05-05  5100  void netif_set_tso_max_segs(struct net_device *dev, unsigned int segs);
6df6398f7c8b48 Jakub Kicinski  2022-05-05  5101  void netif_inherit_tso_max(struct net_device *to,
6df6398f7c8b48 Jakub Kicinski  2022-05-05  5102  			   const struct net_device *from);
6df6398f7c8b48 Jakub Kicinski  2022-05-05  5103  
3c17578473b9be Sabrina Dubroca 2016-03-11  5104  static inline bool netif_is_macsec(const struct net_device *dev)
3c17578473b9be Sabrina Dubroca 2016-03-11 @5105  {
55cddeca5e222e Yang Guang      2023-12-15  5106  	return netif_is_macsec(dev);
3c17578473b9be Sabrina Dubroca 2016-03-11  5107  }
3c17578473b9be Sabrina Dubroca 2016-03-11  5108  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

