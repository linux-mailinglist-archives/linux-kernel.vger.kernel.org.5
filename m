Return-Path: <linux-kernel+bounces-41530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4DC83F3EB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0A22835DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D266063DF;
	Sun, 28 Jan 2024 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4r7M/aX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37085440C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 04:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706417419; cv=none; b=aeQGGhetwtdSkjAbvSVWXN6S1XPYu8Hol4gcQVWZuqT7C3TSm7u32WR6ctNIi+msbM39Qs1R0m8eXSHKdaqILy4arFI8rwtUWyk8M/dYNbEE5jVviUxe+su9vpkmEB8ZUl/gnMx6WQ/vtixODIxiC0s+nSZaITAepUXLlUOsPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706417419; c=relaxed/simple;
	bh=WWMTdDCo/ZFyxKJbvW5goSUgmmbNlhQXiF8IA36CLT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e1Js2H4LEgP2bwQucyf1owNuGJRk1qq5vjJd+FMc6bvfx+4eaEDCHcqfXt8HHpgMKXwE+fqtdSsNcfvi4OMqULzEk03yAIqvgoEACZx7NUdarrKE4e+dPZEIqGShKdoEqBORjg33ghvnHTOzdFGAxDJQ6yVNs/sSyjSLnv9dRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4r7M/aX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706417417; x=1737953417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WWMTdDCo/ZFyxKJbvW5goSUgmmbNlhQXiF8IA36CLT4=;
  b=Z4r7M/aXz3oolzg+G6WEpSchmrD1VFopb6MdLxjP0gDEk5SfdKKGQTeB
   ewCWWrt/6A/P/gTMsME2M0XCAfZ36u1XNiu93KmH/s4v/1wttKTS8xF3G
   fOR/EQSzlDWJJ37R8orAJsO6EYSPLmh+thE4xZakIGEu9Qw2F8B9ym6MG
   I5toSc7PtFK/DynCFDyUZQ2hDIjl5azHEpv7gePanAa06xs3RTP4y74VK
   oghfFDNKE7CAA3yV41ccurUKk8927WIJ5ldFpCr+T6xPAWYg9b0aUy2jD
   w/DJDQ5Wf4MFpVTczEnmELC9KRUBVciNDQYl27DkrJp2JHO2u5Q5OxAq6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="2606028"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2606028"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 20:50:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="29196988"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Jan 2024 20:50:15 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTx7T-00035O-2f;
	Sun, 28 Jan 2024 04:50:11 +0000
Date: Sun, 28 Jan 2024 12:50:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:irq/core 9/9] kernel/irq/irq_sim.c:173:12: error: expected
 expression
Message-ID: <202401281222.T75XK3kV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   590610d72a790458431cbbebc71ee24521533b5e
commit: 590610d72a790458431cbbebc71ee24521533b5e [9/9] genirq/irq_sim: Shrink code by using cleanup helpers
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240128/202401281222.T75XK3kV-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281222.T75XK3kV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281222.T75XK3kV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/irq/irq_sim.c:173:12: error: expected expression
     173 |         pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
         |                   ^
   include/linux/cleanup.h:64:23: note: expanded from macro '__free'
      64 | #define __free(_name)   __cleanup(__free_##_name)
         |                         ^
   include/linux/compiler-clang.h:15:25: note: expanded from macro '__cleanup'
      15 | #define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
         |                         ^
   include/linux/compiler_attributes.h:344:41: note: expanded from macro '__maybe_unused'
     344 | #define __maybe_unused                  __attribute__((__unused__))
         |                                         ^
   1 error generated.


vim +173 kernel/irq/irq_sim.c

   153	
   154	/**
   155	 * irq_domain_create_sim - Create a new interrupt simulator irq_domain and
   156	 *                         allocate a range of dummy interrupts.
   157	 *
   158	 * @fwnode:     struct fwnode_handle to be associated with this domain.
   159	 * @num_irqs:   Number of interrupts to allocate.
   160	 *
   161	 * On success: return a new irq_domain object.
   162	 * On failure: a negative errno wrapped with ERR_PTR().
   163	 */
   164	struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
   165						 unsigned int num_irqs)
   166	{
   167		struct irq_sim_work_ctx *work_ctx __free(kfree) = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
   168		unsigned long *pending;
   169	
   170		if (!work_ctx)
   171			return ERR_PTR(-ENOMEM);
   172	
 > 173		pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
   174		if (!pending)
   175			return ERR_PTR(-ENOMEM);
   176	
   177		work_ctx->domain = irq_domain_create_linear(fwnode, num_irqs,
   178							    &irq_sim_domain_ops,
   179							    work_ctx);
   180		if (!work_ctx->domain)
   181			return ERR_PTR(-ENOMEM);
   182	
   183		work_ctx->irq_count = num_irqs;
   184		work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
   185		work_ctx->pending = no_free_ptr(pending);
   186	
   187		return no_free_ptr(work_ctx)->domain;
   188	}
   189	EXPORT_SYMBOL_GPL(irq_domain_create_sim);
   190	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

