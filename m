Return-Path: <linux-kernel+bounces-47501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8640E844EB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A2E1F25CED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFAB4C67;
	Thu,  1 Feb 2024 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZsB0746"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BD4A2E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751315; cv=none; b=L7oLwcaf4D2ix/x27xDD73DGqenm53FCaSHN5SmL3yJVQVInNG99VYtK7XfHz2x6DozVcfLNaz942fyQwLJ8JflLO0zi6ezl0IYC/2NGtL+0WtsWtkcf6eSqPuB2J72eMKZ5Yqf7ptyw9nkaCN4soOa61b0gIxT+G8EW/qzhygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751315; c=relaxed/simple;
	bh=3ncwFn2EBiz7K4vNyQ2OHTqEHXKCkUDlLERY625dMWs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uJkzhmsrdcp6EvdprLZ/ux/kORD08U2KxPvZFuyR1jGlHgFiCsE9nnAG0M6BKV1GzDlcFc9vtqFnd9Le3afVE5xofRCetAimi1pV7qtRaNnjTPCa7D5dKkOBuI5ZdtQRwRUgCMM6VmIgUpEiGXNHqy0UcGFrQ9QnMZqsb5Xb1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZsB0746; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706751312; x=1738287312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3ncwFn2EBiz7K4vNyQ2OHTqEHXKCkUDlLERY625dMWs=;
  b=BZsB0746fW13UqidfyKdOwX/RSo9daP0ic7s61fSXqO9zNmpFlun924T
   u+Rvp/ziDefGCcjbmtxChuod9AxcCZ/08SBkxHfdUhSBh+Sax1Da3eFvA
   CG+QcJNCY06mT5wQcA3XEy7Aq8V/Y3+Fpbgm5ZNgc02jBL6FR4WDr7ewk
   2eWyVwpdfB0ZN5r9lIo1n5whE+R+uQ49q08k/GD+yjVHoAvRHKxLOjZUq
   KcDZi1ykm3J9kwiEC/lwHbJgUvNmHloCC3PqusLvmQzwV7z9fs0js6+Aj
   MTLtCL+C4RigHgDklG5XcHpN5fOSqafidajJqmYbvbfQD7pgo94rzT+LY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10432074"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10432074"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788787437"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="788787437"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2024 17:35:09 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVLy0-0002FC-2p;
	Thu, 01 Feb 2024 01:34:38 +0000
Date: Thu, 1 Feb 2024 09:33:44 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: drivers/gpu/drm/xe/xe_lrc.c:544:1: error: unused function
 '__xe_lrc_regs_ggtt_addr'
Message-ID: <202402010928.g3j2aSBL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6764c317b6bb91bd806ef79adf6d9c0e428b191e
commit: dd08ebf6c3525a7ea2186e636df064ea47281987 drm/xe: Introduce a new DRM driver for Intel GPUs
date:   7 weeks ago
config: x86_64-randconfig-002-20240201 (https://download.01.org/0day-ci/archive/20240201/202402010928.g3j2aSBL-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402010928.g3j2aSBL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402010928.g3j2aSBL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/xe/xe_lrc.c:544:1: error: unused function '__xe_lrc_regs_ggtt_addr' [-Werror,-Wunused-function]
     544 | DECL_MAP_ADDR_HELPERS(regs)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c:536:19: note: expanded from macro 'DECL_MAP_ADDR_HELPERS'
     536 | static inline u32 __xe_lrc_##elem##_ggtt_addr(struct xe_lrc *lrc) \
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:54:1: note: expanded from here
      54 | __xe_lrc_regs_ggtt_addr
         | ^~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [y]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +/__xe_lrc_regs_ggtt_addr +544 drivers/gpu/drm/xe/xe_lrc.c

   540	
   541	DECL_MAP_ADDR_HELPERS(ring)
   542	DECL_MAP_ADDR_HELPERS(pphwsp)
   543	DECL_MAP_ADDR_HELPERS(seqno)
 > 544	DECL_MAP_ADDR_HELPERS(regs)
   545	DECL_MAP_ADDR_HELPERS(start_seqno)
   546	DECL_MAP_ADDR_HELPERS(parallel)
   547	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

