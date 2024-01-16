Return-Path: <linux-kernel+bounces-27116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED6882EABD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B27B22976
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE4011C81;
	Tue, 16 Jan 2024 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQkr4Moh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0C11713;
	Tue, 16 Jan 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705392951; x=1736928951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+93pTATwhylov/fGq+dM4wmJHrz3bwBGnnp7wd37fYM=;
  b=EQkr4Moh7kUPaIs4sD6GkJnsoqDrTb0WW0zv/MMhLW/UIXdtDClQ8S/g
   Vf2CXAqXiZq5ZF3OYH8TAlWmByktkQJTprI/E7/EVyhf3rl23YYBr9SpF
   m/0/OzMDYUeXQpSKN4fkTchumJ19FSUisXd5546eKbjeJP3pzQuXn4YfP
   h1Xhb1EijkviBatbKmkS7t42yO7Ki/9tRJl5gaNVRtV7q5NvU0N/lc78T
   Quhly5e16QlYtqFSr7+NyzwTl0T23RKiSaUFt7XzglQS7M3fn81yTPefi
   rOXlXEc/Sv4s/sjiwt/cUikITAg5rwXR7wmCsQam4mRuEo/yy90hJ9gV4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="18387565"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="18387565"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:15:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733529493"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="733529493"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Jan 2024 00:15:45 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPebn-0000CQ-04;
	Tue, 16 Jan 2024 08:15:43 +0000
Date: Tue, 16 Jan 2024 16:15:40 +0800
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
Message-ID: <202401161552.JWQXL1kD-lkp@intel.com>
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
[also build test WARNING on robh/for-next linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remoteproc-Add-TEE-support/20240115-215613
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/20240115135249.296822-5-arnaud.pouliquen%40foss.st.com
patch subject: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
config: um-randconfig-r113-20240116 (https://download.01.org/0day-ci/archive/20240116/202401161552.JWQXL1kD-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401161552.JWQXL1kD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161552.JWQXL1kD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/tee_remoteproc.c:82:26: sparse: sparse: symbol 'tee_rproc_ctx' was not declared. Should it be static?
>> drivers/remoteproc/tee_remoteproc.c:166:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *rsc_va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse:     expected void *rsc_va
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/tee_remoteproc.c:233:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *rsc_va @@
   drivers/remoteproc/tee_remoteproc.c:233:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/remoteproc/tee_remoteproc.c:233:31: sparse:     got void *rsc_va
   drivers/remoteproc/tee_remoteproc.c: note: in included file (through include/linux/preempt.h, include/linux/spinlock.h, include/linux/mmzone.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +/tee_rproc_ctx +82 drivers/remoteproc/tee_remoteproc.c

6805d1065198e1 Arnaud Pouliquen 2024-01-15   81  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  @82  struct tee_rproc_context *tee_rproc_ctx;
6805d1065198e1 Arnaud Pouliquen 2024-01-15   83  
6805d1065198e1 Arnaud Pouliquen 2024-01-15   84  static void prepare_args(struct tee_rproc *trproc, int cmd, struct tee_ioctl_invoke_arg *arg,
6805d1065198e1 Arnaud Pouliquen 2024-01-15   85  			 struct tee_param *param, unsigned int num_params)
6805d1065198e1 Arnaud Pouliquen 2024-01-15   86  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15   87  	memset(arg, 0, sizeof(*arg));
6805d1065198e1 Arnaud Pouliquen 2024-01-15   88  	memset(param, 0, MAX_TEE_PARAM_ARRY_MEMBER * sizeof(*param));
6805d1065198e1 Arnaud Pouliquen 2024-01-15   89  
6805d1065198e1 Arnaud Pouliquen 2024-01-15   90  	arg->func = cmd;
6805d1065198e1 Arnaud Pouliquen 2024-01-15   91  	arg->session = trproc->session_id;
6805d1065198e1 Arnaud Pouliquen 2024-01-15   92  	arg->num_params = num_params + 1;
6805d1065198e1 Arnaud Pouliquen 2024-01-15   93  
6805d1065198e1 Arnaud Pouliquen 2024-01-15   94  	param[0] = (struct tee_param) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15   95  		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
6805d1065198e1 Arnaud Pouliquen 2024-01-15   96  		.u.value.a = trproc->rproc_id,
6805d1065198e1 Arnaud Pouliquen 2024-01-15   97  	};
6805d1065198e1 Arnaud Pouliquen 2024-01-15   98  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15   99  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  100  int tee_rproc_load_fw(struct tee_rproc *trproc, const struct firmware *fw)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  101  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  102  	struct tee_ioctl_invoke_arg arg;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  103  	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
6805d1065198e1 Arnaud Pouliquen 2024-01-15  104  	struct tee_shm *fw_shm;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  105  	int ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  106  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  107  	fw_shm = tee_shm_register_kernel_buf(tee_rproc_ctx->tee_ctx, (void *)fw->data, fw->size);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  108  	if (IS_ERR(fw_shm))
6805d1065198e1 Arnaud Pouliquen 2024-01-15  109  		return PTR_ERR(fw_shm);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  110  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  111  	prepare_args(trproc, TA_RPROC_FW_CMD_LOAD_FW, &arg, param, 1);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  112  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  113  	/* Provide the address of the firmware image */
6805d1065198e1 Arnaud Pouliquen 2024-01-15  114  	param[1] = (struct tee_param) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  115  		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  116  		.u.memref = {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  117  			.shm = fw_shm,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  118  			.size = fw->size,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  119  			.shm_offs = 0,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  120  		},
6805d1065198e1 Arnaud Pouliquen 2024-01-15  121  	};
6805d1065198e1 Arnaud Pouliquen 2024-01-15  122  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  123  	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  124  	if (ret < 0 || arg.ret != 0) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  125  		dev_err(tee_rproc_ctx->dev,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  126  			"TA_RPROC_FW_CMD_LOAD_FW invoke failed TEE err: %x, ret:%x\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  127  			arg.ret, ret);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  128  		if (!ret)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  129  			ret = -EIO;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  130  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  131  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  132  	tee_shm_free(fw_shm);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  133  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  134  	return ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  135  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  136  EXPORT_SYMBOL_GPL(tee_rproc_load_fw);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  137  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  138  int rproc_tee_get_rsc_table(struct tee_rproc *trproc)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  139  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  140  	struct tee_ioctl_invoke_arg arg;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  141  	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
6805d1065198e1 Arnaud Pouliquen 2024-01-15  142  	struct rproc *rproc = trproc->rproc;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  143  	size_t rsc_size;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  144  	int ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  145  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  146  	prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  147  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  148  	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  149  	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  150  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  151  	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  152  	if (ret < 0 || arg.ret != 0) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  153  		dev_err(tee_rproc_ctx->dev,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  154  			"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %x, ret:%x\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  155  			arg.ret, ret);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  156  		return -EIO;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  157  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  158  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  159  	rsc_size = param[2].u.value.a;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  160  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  161  	/* If the size is null no resource table defined in the image */
6805d1065198e1 Arnaud Pouliquen 2024-01-15  162  	if (!rsc_size)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  163  		return 0;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  164  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  165  	/* Store the resource table address that would be updated by the remote core . */
6805d1065198e1 Arnaud Pouliquen 2024-01-15 @166  	trproc->rsc_va = ioremap_wc(param[1].u.value.a, rsc_size);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  167  	if (IS_ERR_OR_NULL(trproc->rsc_va)) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  168  		dev_err(tee_rproc_ctx->dev, "Unable to map memory region: %lld+%zx\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  169  			param[1].u.value.a, rsc_size);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  170  		trproc->rsc_va = NULL;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  171  		return -ENOMEM;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  172  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  173  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  174  	/*
6805d1065198e1 Arnaud Pouliquen 2024-01-15  175  	 * A cached table is requested as the physical address is not mapped yet
6805d1065198e1 Arnaud Pouliquen 2024-01-15  176  	 * but remoteproc needs to parse the table for resources.
6805d1065198e1 Arnaud Pouliquen 2024-01-15  177  	 */
6805d1065198e1 Arnaud Pouliquen 2024-01-15  178  	rproc->cached_table = kmemdup(trproc->rsc_va, rsc_size, GFP_KERNEL);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  179  	if (!rproc->cached_table)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  180  		return -ENOMEM;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  181  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  182  	rproc->table_ptr = rproc->cached_table;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  183  	rproc->table_sz = rsc_size;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  184  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  185  	return 0;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  186  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  187  EXPORT_SYMBOL_GPL(rproc_tee_get_rsc_table);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  188  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  189  struct resource_table *tee_rproc_get_loaded_rsc_table(struct tee_rproc *trproc)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  190  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  191  	return (struct resource_table *)trproc->rsc_va;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  192  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  193  EXPORT_SYMBOL_GPL(tee_rproc_get_loaded_rsc_table);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  194  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  195  int tee_rproc_start(struct tee_rproc *trproc)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  196  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  197  	struct tee_ioctl_invoke_arg arg;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  198  	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
6805d1065198e1 Arnaud Pouliquen 2024-01-15  199  	int ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  200  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  201  	prepare_args(trproc, TA_RPROC_FW_CMD_START_FW, &arg, param, 0);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  202  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  203  	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  204  	if (ret < 0 || arg.ret != 0) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  205  		dev_err(tee_rproc_ctx->dev,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  206  			"TA_RPROC_FW_CMD_START_FW invoke failed TEE err: %x, ret:%x\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  207  			arg.ret, ret);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  208  		if (!ret)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  209  			ret = -EIO;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  210  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  211  
6805d1065198e1 Arnaud Pouliquen 2024-01-15  212  	return ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  213  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  214  EXPORT_SYMBOL_GPL(tee_rproc_start);
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

