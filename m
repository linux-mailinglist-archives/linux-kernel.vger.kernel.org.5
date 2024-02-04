Return-Path: <linux-kernel+bounces-51334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0B8489E8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31A41F24489
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B1D10E9;
	Sun,  4 Feb 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHgEuPjE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB410F5;
	Sun,  4 Feb 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009035; cv=none; b=thhyWNVJ5bEoCOfYrjGgc5KJEbZORNsQvQSuzJHNvo+yW51w+/HgdXWhQ++W4Wv0Vz4N+sSolBSfqGbKVnGXjOmjsupnDDMdT6Fv0cWXh+lnjTcmHlwMEc3N6erdLquki3GszG6CQzBKBIxJchfNt7CfKefJwc5mC+ma3yLY/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009035; c=relaxed/simple;
	bh=WyIMQvoDbOUygrCXL4tcOl6XsrIf1Y+KcQ21LH218W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcO/fKDvGALM652aTuwx7KCm2tJufvzuEulzDx0q68SO4GJ/bi+mfs361C1Y8dQFhdShki4ZDmWjaEDg0AcmiLbVC/9drc5Tazph6dbuUGFfrwFKFS6OwNSNJRX83VvGAUV3knw6jLZZ9nWQDbc1187Obq2MvqFTdGG5MV70XCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHgEuPjE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707009033; x=1738545033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WyIMQvoDbOUygrCXL4tcOl6XsrIf1Y+KcQ21LH218W8=;
  b=KHgEuPjE4OL20NWLhTNA8kyYe1wKqPV5wW2JGbIMPKcxzgpn6Rx77OmV
   COML4e1F+pe++ZF6jyNYBFef2TXrKUtKUQEDfRabIWKF4QEqdOGMx5axC
   bK76fxQW2jWbh/LndzX+diWX5VssqMSWi6LvPceMUuWuKnw2ML95bY2hv
   qWxqjOYzZjUa2lqoIqfqU1opCCE8bF7kqYhFe1NlJLEBOWusx8hR2AZ1f
   LV2TBo+wi8Fs6v6rlIZ2D9b1y57hJUk3Ern+AXjwq0pVvNBQTxc7bQzoD
   OoUCjKEjdiPcdZ/WD1QhYrYOZ0SGDF5A/w3+kq9DwVJch+LQ6PMw0JLJQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="11718335"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="11718335"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 17:10:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="715429"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 03 Feb 2024 17:10:30 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWR1Q-0005pK-1O;
	Sun, 04 Feb 2024 01:10:26 +0000
Date: Sun, 4 Feb 2024 09:09:19 +0800
From: kernel test robot <lkp@intel.com>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>,
	srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/16] misc: fastrpc: Add static PD restart support
Message-ID: <202402040834.qMpd4i4O-lkp@intel.com>
References: <20240202064039.15505-4-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202064039.15505-4-quic_ekangupt@quicinc.com>

Hi Ekansh,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ekansh-Gupta/misc-fastrpc-Redesign-remote-heap-management/20240202-144921
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240202064039.15505-4-quic_ekangupt%40quicinc.com
patch subject: [PATCH v1 03/16] misc: fastrpc: Add static PD restart support
config: arm64-randconfig-r053-20240203 (https://download.01.org/0day-ci/archive/20240204/202402040834.qMpd4i4O-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040834.qMpd4i4O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040834.qMpd4i4O-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pdr_handle_alloc
   >>> referenced by fastrpc.c
   >>>               drivers/misc/fastrpc.o:(fastrpc_rpmsg_probe) in archive vmlinux.a
   >>> referenced by fastrpc.c
   >>>               drivers/misc/fastrpc.o:(fastrpc_rpmsg_probe) in archive vmlinux.a
   >>> referenced by fastrpc.c
   >>>               drivers/misc/fastrpc.o:(fastrpc_setup_service_locator) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: pdr_add_lookup
   >>> referenced by fastrpc.c
   >>>               drivers/misc/fastrpc.o:(fastrpc_rpmsg_probe) in archive vmlinux.a
   >>> referenced by fastrpc.c
   >>>               drivers/misc/fastrpc.o:(fastrpc_rpmsg_probe) in archive vmlinux.a
   >>> referenced by fastrpc.c
   >>>               drivers/misc/fastrpc.o:(fastrpc_setup_service_locator) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: pdr_handle_release
   >>> referenced by fastrpc.c
   >>>               drivers/misc/fastrpc.o:(fastrpc_rpmsg_remove) in archive vmlinux.a
   >>> referenced by fastrpc.c
   >>>               drivers/misc/fastrpc.o:(fastrpc_rpmsg_remove) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

