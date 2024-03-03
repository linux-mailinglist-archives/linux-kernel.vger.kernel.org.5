Return-Path: <linux-kernel+bounces-89824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEEB86F622
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6DE281182
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB976BFDB;
	Sun,  3 Mar 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAyfN6SL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E266B5F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483641; cv=none; b=Ukqlv/WZD5awmpSe/aa0yugq4cL+WL3WQ6yUz31frsJwQyJLQ+dHKLS2atsznozgS3Hb4M3Cznh0V3Qhwzxl40xnzmQB5Ht5TuiX7Ts4hQ2UUgl+58jX9SiPQ+g2TY+O6GzGLdbWAtUY8UjraAWhUn+NHdImrZPplqTQGoW3P1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483641; c=relaxed/simple;
	bh=WAdP/rfypzddvDLaI9NZ8Nmc/RIaGpluV0kiu8bpAc4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MCv/iIm2R70eDPMNBQMedHC2s/XwomkduTKccNcHXC8k92I5R/fRKrzpI2s0HbX12ZwTVxbRT5APm2ODnx9WAzZMFiiMMLu2h2DeHV6xwVNQrxhnjdOjRv3dCqWNDGweibeKHqt3AHKl4njtu8URWa61wTx+15LSd9ACN7/HWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAyfN6SL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709483638; x=1741019638;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WAdP/rfypzddvDLaI9NZ8Nmc/RIaGpluV0kiu8bpAc4=;
  b=IAyfN6SLr66V8U0TB2XxLL07pBlJ9O7vBiLpYJJ8aikCCftzlyAfBSQ5
   +mN6NRTIAu60PMWJKFCRr1O+yPObfREptu2zWkU9+oqLgssE071gMjXCy
   tFMKOpyaEZCnAsyNrLoTWcbqeTTlpAO9S9jKe1uCAMJ7Ma7F/P5fkpdk1
   t4fZIkLFz59zYjsc3hpkXiAxzU4q/6vRRs9r+ps8YJFK0TzDlmpP5a/K4
   Noa449Iu2gTjfNkt9hKqVhkymtCjhhWmWbOM9d96AlU0hsCHfZBmO7vF2
   OYUacyZFrShPH6GJbVk4HH1P+Bli7z5TJlgZcc0uRIDNgRGWFxMh0+HJR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="14683741"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="14683741"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 08:33:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="39578526"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2024 08:33:55 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgome-0001w8-1Q;
	Sun, 03 Mar 2024 16:33:52 +0000
Date: Mon, 4 Mar 2024 00:32:53 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: drivers/gpu/drm/xe/xe_lrc.c:544:1: error: unused function
 '__xe_lrc_regs_ggtt_addr'
Message-ID: <202403040013.C6fxy7Q8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04b8076df2534f08bb4190f90a24e0f7f8930aca
commit: dd08ebf6c3525a7ea2186e636df064ea47281987 drm/xe: Introduce a new DRM driver for Intel GPUs
date:   3 months ago
config: x86_64-randconfig-076-20240303 (https://download.01.org/0day-ci/archive/20240304/202403040013.C6fxy7Q8-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040013.C6fxy7Q8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040013.C6fxy7Q8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/xe/xe_lrc.c:544:1: error: unused function '__xe_lrc_regs_ggtt_addr' [-Werror,-Wunused-function]
     544 | DECL_MAP_ADDR_HELPERS(regs)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xe/xe_lrc.c:536:19: note: expanded from macro 'DECL_MAP_ADDR_HELPERS'
     536 | static inline u32 __xe_lrc_##elem##_ggtt_addr(struct xe_lrc *lrc) \
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:238:1: note: expanded from here
     238 | __xe_lrc_regs_ggtt_addr
         | ^~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


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

