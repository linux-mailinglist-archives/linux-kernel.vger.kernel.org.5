Return-Path: <linux-kernel+bounces-98107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB287753C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C167D1F21CC6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ED411C87;
	Sun, 10 Mar 2024 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8Fve5Qf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555733D8;
	Sun, 10 Mar 2024 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710040797; cv=none; b=L6gMhWOYtmCU43anKoErrcIWuo8mRe61Nt3Apdmk0MuB3bfRK1FLNjkjFj3DSEsqWPqDZOe2CZ0hxv/gcrUnVanFsV8xV0X5abEYv86r7sz5x4B7UZPRCqMQaDFGR/69Fzi6SGNyOnDrDq9GZkyQz8KJNrTqBF0/oacHvYNvf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710040797; c=relaxed/simple;
	bh=NGWdQWEHWpFEjdw+zfAGKqF6mfpWb0dLFKBmOsG0MrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu3Ws6Ut2LQCgYV5c9i6KYYv3UUXGCfSASIDUn8Rb8U2/D4bpa20OmcVAt32YCMcQLGcVW5RmBbxZIYTHr6q88g9681nannQgPNS+QpPcaSvWb6cPaXJY2Yy5TRXK2xFL0c7KmvlkinHIwTCVoyJBdPIE+gPFSl8EXyKMk9pptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8Fve5Qf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710040795; x=1741576795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NGWdQWEHWpFEjdw+zfAGKqF6mfpWb0dLFKBmOsG0MrA=;
  b=K8Fve5QfNl9xKMmlfkkbYLOLUlHOqOJWQf+RpZL1sZj/QaXGu3BhPbnA
   cfqO62n+WSYGb21CMXiMquPsq7P/gGfJh+5sEFSZklwEb2b1NcyoTsgkj
   K9+cmK4iL4fEktNEwWtymsO+6nXRbxc7YbBb1K1DbhCeM6okJX6niff6f
   TTKuSVx/XnYWqi4tsxycg5Ff53KyjH3o4YRooZ9tUYFQswXdVZb5FiIDM
   6Zm1lPYuXLKa3iw5I4jhn635rb784uc3bOEIJYq5Uh/mRyoZE18VtM1xf
   KFCBLb5kGglUtN16YVsZYIkQKyFuMto9QoYIsbRUYfOVIP2kiVYLhFDmo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4899937"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4899937"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 19:19:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="10744501"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Mar 2024 19:19:51 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rj9j2-0007sJ-2V;
	Sun, 10 Mar 2024 03:19:48 +0000
Date: Sun, 10 Mar 2024 11:18:59 +0800
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
Subject: Re: [PATCH v4 1/4] remoteproc: Add TEE support
Message-ID: <202403101139.NIzJMqwP-lkp@intel.com>
References: <20240308144708.62362-2-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308144708.62362-2-arnaud.pouliquen@foss.st.com>

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 62210f7509e13a2caa7b080722a45229b8f17a0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remoteproc-Add-TEE-support/20240308-225116
base:   62210f7509e13a2caa7b080722a45229b8f17a0a
patch link:    https://lore.kernel.org/r/20240308144708.62362-2-arnaud.pouliquen%40foss.st.com
patch subject: [PATCH v4 1/4] remoteproc: Add TEE support
config: arm-randconfig-r123-20240310 (https://download.01.org/0day-ci/archive/20240310/202403101139.NIzJMqwP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240310/202403101139.NIzJMqwP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403101139.NIzJMqwP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/tee_remoteproc.c:163:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct resource_table *rsc_table @@     got void [noderef] __iomem * @@
   drivers/remoteproc/tee_remoteproc.c:163:19: sparse:     expected struct resource_table *rsc_table
   drivers/remoteproc/tee_remoteproc.c:163:19: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/tee_remoteproc.c:276:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct resource_table *rsc_table @@
   drivers/remoteproc/tee_remoteproc.c:276:23: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/remoteproc/tee_remoteproc.c:276:23: sparse:     got struct resource_table *rsc_table
   drivers/remoteproc/tee_remoteproc.c:399:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct resource_table *rsc_table @@
   drivers/remoteproc/tee_remoteproc.c:399:38: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/remoteproc/tee_remoteproc.c:399:38: sparse:     got struct resource_table *rsc_table
   drivers/remoteproc/tee_remoteproc.c: note: in included file (through arch/arm/include/asm/traps.h, arch/arm/include/asm/thread_info.h, include/linux/thread_info.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +163 drivers/remoteproc/tee_remoteproc.c

   131	
   132	struct resource_table *tee_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
   133	{
   134		struct tee_ioctl_invoke_arg arg;
   135		struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
   136		struct tee_rproc *trproc = rproc->tee_interface;
   137		struct resource_table *rsc_table;
   138		int ret;
   139	
   140		if (!trproc)
   141			return ERR_PTR(-EINVAL);
   142	
   143		tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
   144	
   145		param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
   146		param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
   147	
   148		ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
   149		if (ret < 0 || arg.ret != 0) {
   150			dev_err(tee_rproc_ctx->dev,
   151				"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %x, ret:%x\n",
   152				arg.ret, ret);
   153			return ERR_PTR(-EIO);
   154		}
   155	
   156		*table_sz = param[2].u.value.a;
   157	
   158		/* If the size is null no resource table defined in the image */
   159		if (!*table_sz)
   160			return NULL;
   161	
   162		/* Store the resource table address that would be updated by the remote core. */
 > 163		rsc_table = ioremap_wc(param[1].u.value.a, *table_sz);
   164		if (IS_ERR_OR_NULL(rsc_table)) {
   165			dev_err(tee_rproc_ctx->dev, "Unable to map memory region: %lld+%zx\n",
   166				param[1].u.value.a, *table_sz);
   167			return ERR_PTR(-ENOMEM);
   168		}
   169	
   170		return rsc_table;
   171	}
   172	EXPORT_SYMBOL_GPL(tee_rproc_get_loaded_rsc_table);
   173	
   174	int tee_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
   175	{
   176		struct tee_rproc *trproc = rproc->tee_interface;
   177		struct resource_table *rsc_table;
   178		size_t table_sz;
   179		int ret;
   180	
   181		ret = tee_rproc_load_fw(rproc, fw);
   182		if (ret)
   183			return ret;
   184	
   185		rsc_table = tee_rproc_get_loaded_rsc_table(rproc, &table_sz);
   186		if (IS_ERR(rsc_table))
   187			return PTR_ERR(rsc_table);
   188	
   189		/* Create a copy of the resource table to have same behaviour than the elf loader. */
   190		rproc->cached_table = kmemdup(rsc_table, table_sz, GFP_KERNEL);
   191		if (!rproc->cached_table)
   192			return -ENOMEM;
   193	
   194		rproc->table_ptr = rproc->cached_table;
   195		rproc->table_sz = table_sz;
   196		trproc->rsc_table = rsc_table;
   197	
   198		return 0;
   199	}
   200	EXPORT_SYMBOL_GPL(tee_rproc_parse_fw);
   201	
   202	struct resource_table *tee_rproc_find_loaded_rsc_table(struct rproc *rproc,
   203							       const struct firmware *fw)
   204	{
   205		struct tee_rproc *trproc = rproc->tee_interface;
   206		struct resource_table *rsc_table;
   207		size_t table_sz;
   208	
   209		if (!trproc)
   210			return ERR_PTR(-EINVAL);
   211	
   212		/* Check if the resourse table has already been obtained in tee_rproc_parse_fw() */
   213		if (trproc->rsc_table)
   214			return trproc->rsc_table;
   215	
   216		rsc_table = tee_rproc_get_loaded_rsc_table(rproc, &table_sz);
   217		if (IS_ERR(rsc_table))
   218			return rsc_table;
   219	
   220		rproc->table_sz = table_sz;
   221		trproc->rsc_table = rsc_table;
   222	
   223		return rsc_table;
   224	}
   225	EXPORT_SYMBOL_GPL(tee_rproc_find_loaded_rsc_table);
   226	
   227	int tee_rproc_start(struct rproc *rproc)
   228	{
   229		struct tee_ioctl_invoke_arg arg;
   230		struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
   231		struct tee_rproc *trproc = rproc->tee_interface;
   232		int ret;
   233	
   234		if (!trproc)
   235			return -EINVAL;
   236	
   237		tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_START_FW, &arg, param, 0);
   238	
   239		ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
   240		if (ret < 0 || arg.ret != 0) {
   241			dev_err(tee_rproc_ctx->dev,
   242				"TA_RPROC_FW_CMD_START_FW invoke failed TEE err: %x, ret:%x\n",
   243				arg.ret, ret);
   244			if (!ret)
   245				ret = -EIO;
   246		}
   247	
   248		return ret;
   249	}
   250	EXPORT_SYMBOL_GPL(tee_rproc_start);
   251	
   252	int tee_rproc_stop(struct rproc *rproc)
   253	{
   254		struct tee_ioctl_invoke_arg arg;
   255		struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
   256		struct tee_rproc *trproc = rproc->tee_interface;
   257		int ret;
   258	
   259		if (!trproc)
   260			return -EINVAL;
   261	
   262		tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_STOP_FW, &arg, param, 0);
   263	
   264		ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
   265		if (ret < 0 || arg.ret != 0) {
   266			dev_err(tee_rproc_ctx->dev,
   267				"TA_RPROC_FW_CMD_STOP_FW invoke failed TEE err: %x, ret:%x\n",
   268				arg.ret, ret);
   269			if (!ret)
   270				ret = -EIO;
   271		}
   272	
   273		if (!rproc->table_ptr)
   274			return ret;
   275	
 > 276		iounmap(trproc->rsc_table);
   277		trproc->rsc_table = NULL;
   278		rproc->table_ptr = NULL;
   279	
   280		return 0;
   281	}
   282	EXPORT_SYMBOL_GPL(tee_rproc_stop);
   283	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

