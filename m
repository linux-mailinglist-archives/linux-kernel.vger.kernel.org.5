Return-Path: <linux-kernel+bounces-27139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF382EB15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9BC28547B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7BF125C4;
	Tue, 16 Jan 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJUIMEM3"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5412B9A;
	Tue, 16 Jan 2024 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705394814; x=1736930814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pe1QjLikG6M/4WQLHvUWPP91kl86mMKrUxyNnm7Uedk=;
  b=hJUIMEM35MtwnvcTVRIb+CNe7ecxYBsWVxpiqzFdSWOyiBoGOw7QZ4Cm
   O0ljaukJx2bUeprgtcIEnYr+4Ql4Wnm7Kf+aO+M6Z7/dKOkwFSX+odknL
   3Qw9/svb2jvVR4R5/lkHjLT+TZoIj5RuUcJi3dk5QEBCw9Ao17vGbEl7q
   PCrVbUXcKvISDj3P32NxM9pfwP5db5CJg/ieUpcAJsY9qwXSGqeKfQJzf
   5cROKVaLjW4r3G+cz9+mCpdowleSzNUG/CNEKr+KWpQGCCG+dBz91qtdE
   R3mBpQGk+yUPABIUzgK0hoeOY/hCorCsXjRPEXe24lZEVyEAVx7v8KUUh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="398656206"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="398656206"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:46:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="927386299"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="927386299"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jan 2024 00:46:49 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPf5r-0000Gi-0y;
	Tue, 16 Jan 2024 08:46:47 +0000
Date: Tue, 16 Jan 2024 16:46:21 +0800
From: kernel test robot <lkp@intel.com>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Message-ID: <202401161603.5dloSqiJ-lkp@intel.com>
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
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240116/202401161603.5dloSqiJ-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401161603.5dloSqiJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161603.5dloSqiJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/stm32_rproc.c:977:6: warning: variable 'trproc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     977 |         if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/stm32_rproc.c:991:8: note: uninitialized use occurs here
     991 |                             trproc ? &st_rproc_tee_ops : &st_rproc_ops,
         |                             ^~~~~~
   drivers/remoteproc/stm32_rproc.c:977:2: note: remove the 'if' if its condition is always true
     977 |         if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/stm32_rproc.c:968:26: note: initialize the variable 'trproc' to silence this warning
     968 |         struct tee_rproc *trproc;
         |                                 ^
         |                                  = NULL
   1 warning generated.


vim +977 drivers/remoteproc/stm32_rproc.c

   962	
   963	static int stm32_rproc_probe(struct platform_device *pdev)
   964	{
   965		struct device *dev = &pdev->dev;
   966		struct stm32_rproc *ddata;
   967		struct device_node *np = dev->of_node;
   968		struct tee_rproc *trproc;
   969		struct rproc *rproc;
   970		unsigned int state;
   971		int ret;
   972	
   973		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
   974		if (ret)
   975			return ret;
   976	
 > 977		if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
   978			trproc = tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
   979			if (IS_ERR(trproc)) {
   980				dev_err_probe(dev, PTR_ERR(trproc),
   981					      "signed firmware not supported by TEE\n");
   982				return PTR_ERR(trproc);
   983			}
   984			/*
   985			 * Delegate the firmware management to the secure context.
   986			 * The firmware loaded has to be signed.
   987			 */
   988			dev_info(dev, "Support of signed firmware only\n");
   989		}
   990		rproc = rproc_alloc(dev, np->name,
   991				    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
   992				    NULL, sizeof(*ddata));
   993		if (!rproc) {
   994			ret = -ENOMEM;
   995			goto free_tee;
   996		}
   997	
   998		ddata = rproc->priv;
   999		ddata->trproc = trproc;
  1000		if (trproc)
  1001			trproc->rproc = rproc;
  1002	
  1003		rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
  1004	
  1005		ret = stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
  1006		if (ret)
  1007			goto free_rproc;
  1008	
  1009		ret = stm32_rproc_of_memory_translations(pdev, ddata);
  1010		if (ret)
  1011			goto free_rproc;
  1012	
  1013		ret = stm32_rproc_get_m4_status(ddata, &state);
  1014		if (ret)
  1015			goto free_rproc;
  1016	
  1017		if (state == M4_STATE_CRUN)
  1018			rproc->state = RPROC_DETACHED;
  1019	
  1020		rproc->has_iommu = false;
  1021		ddata->workqueue = create_workqueue(dev_name(dev));
  1022		if (!ddata->workqueue) {
  1023			dev_err(dev, "cannot create workqueue\n");
  1024			ret = -ENOMEM;
  1025			goto free_resources;
  1026		}
  1027	
  1028		platform_set_drvdata(pdev, rproc);
  1029	
  1030		ret = stm32_rproc_request_mbox(rproc);
  1031		if (ret)
  1032			goto free_wkq;
  1033	
  1034		ret = rproc_add(rproc);
  1035		if (ret)
  1036			goto free_mb;
  1037	
  1038		return 0;
  1039	
  1040	free_mb:
  1041		stm32_rproc_free_mbox(rproc);
  1042	free_wkq:
  1043		destroy_workqueue(ddata->workqueue);
  1044	free_resources:
  1045		rproc_resource_cleanup(rproc);
  1046	free_rproc:
  1047		if (device_may_wakeup(dev)) {
  1048			dev_pm_clear_wake_irq(dev);
  1049			device_init_wakeup(dev, false);
  1050		}
  1051		rproc_free(rproc);
  1052	free_tee:
  1053		if (trproc)
  1054			tee_rproc_unregister(trproc);
  1055	
  1056		return ret;
  1057	}
  1058	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

