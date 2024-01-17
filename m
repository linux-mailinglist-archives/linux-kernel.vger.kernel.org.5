Return-Path: <linux-kernel+bounces-29559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9D8831034
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAFC2811B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14D4288D5;
	Wed, 17 Jan 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdEA0SIJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553928DA2;
	Wed, 17 Jan 2024 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535427; cv=none; b=VgmdRnSkf+lrEq/bvEG2HI4afHAVR4xm5xQNsV1V3u3oSP8jlnWxz9Jb47sTZwI5NqO9OAzxbIFFv6zlKLzZvYQSNTDJztCgOYLoKzvPiGgA8b9FOBlNOqqJ3693hu7OKDZqLxnDy5o/nzinCpfbT8/lbzJ3f3fP7zBq9f9t1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535427; c=relaxed/simple;
	bh=vA/lVruIhcqs1iF8s5CGZ0Yh0/2pqLuM2zH9Xl5+LMk=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=VbYWysflFiemBwffQETR3JGxP6xIt34ms21SidcNaLlF7Md78KFVBrpnzeONutqeKik5UsVR9A3aWYfh2fGGiYRaHnFfrU+wOdsSu3D7SJVxchJ1nHbodiqY2HWKXDkgaM4psr933N28/940yDpl9jTPJEBBbLBgICHUHi2+WEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdEA0SIJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705535426; x=1737071426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vA/lVruIhcqs1iF8s5CGZ0Yh0/2pqLuM2zH9Xl5+LMk=;
  b=mdEA0SIJXVPT10H9EonAQAKCElUbjuqDiu6Rcx5BEvXOhdV9kBXOYHRp
   CbOKfMHXHD3DWIWMhbrZjxVvGVQbCg7cXUodcRB4MZfsq7Tu0m6fHGK1j
   PDKwBOp7GNCCNWHHzRP+rq16yb/Rldh1qOxmV8QuNB4kRF8H3cBPXzB6f
   QcPuAonWAnB6XwgQCVFSA1aAEWXKVWj+RdxIYzPmZkMhI5TPQumaObfHw
   /08WrjXgfGmN5g106R54gjSyuFxeAIk9JC8uDTRlCjl7Ki6/6P4O0VZY/
   Bb3pq3YgGpEofs/v/60IScUqsTRLIgMdtsRVLMyXUTcjbBpXiHgp+lOa/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7014415"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7014415"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 15:50:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="26612682"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jan 2024 15:50:22 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQFfn-0002RC-2J;
	Wed, 17 Jan 2024 23:50:19 +0000
Date: Thu, 18 Jan 2024 07:49:37 +0800
From: kernel test robot <lkp@intel.com>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Message-ID: <202401180740.1ud9PJYn-lkp@intel.com>
References: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on robh/for-next linus/master v6.7 next-20240117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remoteproc-Add-TEE-support/20240115-215613
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/20240115135249.296822-5-arnaud.pouliquen%40foss.st.com
patch subject: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
config: mips-randconfig-r112-20240117 (https://download.01.org/0day-ci/archive/20240118/202401180740.1ud9PJYn-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce: (https://download.01.org/0day-ci/archive/20240118/202401180740.1ud9PJYn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401180740.1ud9PJYn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/tee_remoteproc.c:82:26: sparse: sparse: symbol 'tee_rproc_ctx' was not declared. Should it be static?
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *rsc_va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse:     expected void *rsc_va
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/tee_remoteproc.c:233:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *rsc_va @@
   drivers/remoteproc/tee_remoteproc.c:233:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/remoteproc/tee_remoteproc.c:233:31: sparse:     got void *rsc_va
   drivers/remoteproc/tee_remoteproc.c: note: in included file (through include/linux/preempt.h, include/linux/spinlock.h, include/linux/mmzone.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +233 drivers/remoteproc/tee_remoteproc.c

6805d1065198e1 Arnaud Pouliquen 2024-01-15  215  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  216  int tee_rproc_stop(struct tee_rproc *trproc)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  217  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  218  	struct tee_ioctl_invoke_arg arg;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  219  	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
6805d1065198e1 Arnaud Pouliquen 2024-01-15  220  	int ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  221  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  222  	prepare_args(trproc, TA_RPROC_FW_CMD_STOP_FW, &arg, param, 0);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  223  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  224  	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  225  	if (ret < 0 || arg.ret != 0) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  226  		dev_err(tee_rproc_ctx->dev,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  227  			"TA_RPROC_FW_CMD_STOP_FW invoke failed TEE err: %x, ret:%x\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  228  			arg.ret, ret);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  229  		if (!ret)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  230  			ret = -EIO;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  231  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  232  	if (trproc->rsc_va)
6805d1065198e1 Arnaud Pouliquen 2024-01-15 @233  		iounmap(trproc->rsc_va);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  234  	trproc->rsc_va = NULL;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  235  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  236  	return ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  237  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  238  EXPORT_SYMBOL_GPL(tee_rproc_stop);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  239  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

