Return-Path: <linux-kernel+bounces-41547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF9183F447
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 07:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9812834FB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F18C1A;
	Sun, 28 Jan 2024 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBo8WN91"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45DF748D;
	Sun, 28 Jan 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706421987; cv=none; b=q5eKPtQE3hGv0Ox3RE0mP/WHO804kjYOECJA2B6SDDQT11kR2zhmLU/Qb649KPzNYMu2U/geHitGdJQKk90QSxB7207t8z3P4GIIVu60sJxIz5MyWLVoRROCnB8qSD1iq/+Rev494OP5WexN9CezhNKLVQbpEYxAryLLowvZdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706421987; c=relaxed/simple;
	bh=NttJqLrnePMktBrZTxU8B3o9czIfX/MyFTnT41W2cfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWx7TiYrrj9uUfNLkXQtuuaQSPR4RznRcZVTQMPsZnN14Y5YRmwt0eZQb/R2EwFq/Iz32RmE/XdfzuDMgEa3UZYuruOFSoYNfTMHaEgGXJSBc0ixM8jwueyuzT15CKu4HBGEjZa43yrWgtduEvdWti10W++YryeSxP8bfnAXVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBo8WN91; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706421985; x=1737957985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NttJqLrnePMktBrZTxU8B3o9czIfX/MyFTnT41W2cfo=;
  b=oBo8WN91XAlDgT5qZc6wY7FV2dAuLTOT4E0SXThXVq663ZFm3oduJXb5
   kLqjlPovyVnaxegJiiEWL7g6CP9h2PqLRt769SjtPxFZmatsaTVDiXkKP
   BqNRcDe9xr/bVSEwv0TIRUQZM2Mo5CFt1BrU1+caoELc1pCc5dVC96ep9
   RbowP2B805TBvIbIEwnBCjh8kND8eDMIZuzX6dMVdGNPESL9aeFYGMa6G
   QfGL/cvm95tZ4EGnLRWHpssv94ygI+HIhFKhDENvUJhlY3TIWLISs7hus
   38kBWtCwOi7osFFC357Q3SfP0QBHfWjSswUmDBcRxY2bLj7gUCjsb6zQc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="10128795"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10128795"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:06:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2982796"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 27 Jan 2024 22:06:16 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTyJ3-00038s-2C;
	Sun, 28 Jan 2024 06:06:13 +0000
Date: Sun, 28 Jan 2024 14:06:05 +0800
From: kernel test robot <lkp@intel.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, catalin.marinas@arm.com,
	will@kernel.org, robh+dt@kernel.org, frowand.list@gmail.com,
	vgupta@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
	guoren@kernel.org, monstr@monstr.eu, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, dinguyen@kernel.org, chenhuacai@kernel.org,
	tsbogend@alpha.franken.de, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
	mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 30/46] of: reserved_mem: Add code to use unflattened DT
 for reserved_mem nodes
Message-ID: <202401281304.tsu89Kcm-lkp@intel.com>
References: <20240126235425.12233-31-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126235425.12233-31-quic_obabatun@quicinc.com>

Hi Oreoluwa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm64/for-next/core vgupta-arc/for-curr powerpc/next powerpc/fixes jcmvbkbc-xtensa/xtensa-for-next linus/master v6.8-rc1 next-20240125]
[cannot apply to vgupta-arc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oreoluwa-Babatunde/of-reserved_mem-Change-the-order-that-reserved_mem-regions-are-stored/20240127-081735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240126235425.12233-31-quic_obabatun%40quicinc.com
patch subject: [PATCH 30/46] of: reserved_mem: Add code to use unflattened DT for reserved_mem nodes
config: arm-randconfig-r133-20240127 (https://download.01.org/0day-ci/archive/20240128/202401281304.tsu89Kcm-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240128/202401281304.tsu89Kcm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281304.tsu89Kcm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/dma/coherent.c:371:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long node @@     got struct device_node *node @@
   kernel/dma/coherent.c:371:34: sparse:     expected unsigned long node
   kernel/dma/coherent.c:371:34: sparse:     got struct device_node *node
   kernel/dma/coherent.c:378:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long node @@     got struct device_node *node @@
   kernel/dma/coherent.c:378:33: sparse:     expected unsigned long node
   kernel/dma/coherent.c:378:33: sparse:     got struct device_node *node

vim +371 kernel/dma/coherent.c

7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  362  
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  363  static int __init rmem_dma_setup(struct reserved_mem *rmem)
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  364  {
b81d457b174810 kernel/dma/coherent.c       Oreoluwa Babatunde 2024-01-26  365  	struct device_node *node = rmem->dev_node;
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  366  
b81d457b174810 kernel/dma/coherent.c       Oreoluwa Babatunde 2024-01-26  367  	if (of_get_property(node, "reusable", NULL))
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  368  		return -EINVAL;
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  369  
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  370  #ifdef CONFIG_ARM
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13 @371  	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  372  		pr_err("Reserved memory: regions without no-map are not yet supported\n");
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  373  		return -EINVAL;
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  374  	}
70d6aa0ecfed25 kernel/dma/coherent.c       Christoph Hellwig  2021-06-24  375  #endif
93228b44c33a57 drivers/base/dma-coherent.c Vladimir Murzin    2017-06-26  376  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

