Return-Path: <linux-kernel+bounces-39561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B279383D2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C58F2861D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1FA944;
	Fri, 26 Jan 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PN7BRFy/"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792658F5F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238275; cv=none; b=UljUlEn5cTU+LLlgy+r+d7BCv03POSucl0HtsmqCy+SD+zlji5cu/G+MX/FMOjgf8EVnU3VM9eR7eoN/kx16GmIjac3cNQhVOdKXhafuiFD4jCf3k6j7dis5HH+jJUIZTLig9OUNvOJAbMDj/34KmrGhNCtOn0HFbL+Kl+Vf8jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238275; c=relaxed/simple;
	bh=0ypCh8UcVy8glJYp6xf3jIfGCa8bvlbqsej6to5nxR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NsaWtnn5YwZ1j3OENvmQavDoVIFApFqw7Lq9ri2nNDHal+Dv3Gy7w0Vg3fcAUaeV1rp6GUoqFHop3f36hrEMjukOQ7FenXD2Wh3jC2mmQOJkZNRFtaqzK154UyphtIjSQ8oGxR/nTJACy2PL2R+4gHkFTF0z6cdKjuQISkuhHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PN7BRFy/; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706238272; x=1737774272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0ypCh8UcVy8glJYp6xf3jIfGCa8bvlbqsej6to5nxR4=;
  b=PN7BRFy/GwiiNMcEQWD7Aa2aj3HlVJNEp0kLCDcIoqBZTXuLJxXp2OzR
   gcz8rj1P0yGrwOQcMFZh1bea1gMXvubGWdpPD1oGtL5seVhARjJ85pJyW
   xQIZhRwuunv0yaqmV4XjCd6/05btNWF1sPxUBkiI0UiYkntYix1bRp10b
   QvjOhC/3NOya4GWlip7X9secO8xZEE1P9dfz4v6pte8nReiOKJEfQrmyg
   xchR7sGiKt/zcbWbkJvrSY+QiZvK/X+NITaVHUfYe4dl9bz0OxCpJB5Cp
   So4p7YHmoZ4Nbwt9pwfn7wbW8xtalo9MEP5+6xnUaow74dQse/UYIBoiU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="406109417"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="406109417"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 19:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2484717"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Jan 2024 19:04:30 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTCW3-0000ci-2l;
	Fri, 26 Jan 2024 03:04:27 +0000
Date: Fri, 26 Jan 2024 11:04:01 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>
Subject: drivers/gpu/drm/xe/xe_rtp.c:151:2-3: Unneeded semicolon
Message-ID: <202401261029.Ed0Wh8zS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
commit: 72906d340b60f3dae545deef77376a0f598bece7 drm/xe/rtp: Split rtp process initialization
date:   5 weeks ago
config: powerpc64-randconfig-r052-20240125 (https://download.01.org/0day-ci/archive/20240126/202401261029.Ed0Wh8zS-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261029.Ed0Wh8zS-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/xe/xe_rtp.c:151:2-3: Unneeded semicolon

vim +151 drivers/gpu/drm/xe/xe_rtp.c

   134	
   135	static void rtp_get_context(struct xe_rtp_process_ctx *ctx,
   136				    struct xe_hw_engine **hwe,
   137				    struct xe_gt **gt,
   138				    struct xe_device **xe)
   139	{
   140		switch (ctx->type) {
   141		case XE_RTP_PROCESS_TYPE_GT:
   142			*hwe = NULL;
   143			*gt = ctx->gt;
   144			*xe = gt_to_xe(*gt);
   145			break;
   146		case XE_RTP_PROCESS_TYPE_ENGINE:
   147			*hwe = ctx->hwe;
   148			*gt = (*hwe)->gt;
   149			*xe = gt_to_xe(*gt);
   150			break;
 > 151		};
   152	}
   153	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

