Return-Path: <linux-kernel+bounces-105489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B58C87DF13
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4506B1C2098A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537D1CFA0;
	Sun, 17 Mar 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WppmnvRz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E81CD3D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710698435; cv=none; b=dHA4J26Y6kttDmMaKiRQ/hJKLhJzAOKYyPiIK2xNpwDZZEHOGjKW2mBsxOzkbzCSlOE4VMgt5qB8eH9zKhr7G0iuV3Jwzu4tIOXLC6Cl2zLXUWseoDfeax4QI+59uxIXLqfqsOQkqVoWyzXv9bwpfIo504sWStecO3IzDvVHsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710698435; c=relaxed/simple;
	bh=d1gJtJhLoCoMhAJmy9kBy+XsEohKOLp1ZvRQwzj7H/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rWLzEA1B4S4M3vlakOP/IQMwYAqCzcqjKEWvf2tnOBFR/PISJsXJ01WjnoeluXg+WnPVjDa3of366TrgdBZQ0pZB12SvfMSxCdW+E4PUtji/qZXzLb1B4PWRpQ/AWchUr2BQlR8lH9EOTzkJv356ptb9iP8FhC4tMo0Fm0ToOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WppmnvRz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710698433; x=1742234433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d1gJtJhLoCoMhAJmy9kBy+XsEohKOLp1ZvRQwzj7H/Y=;
  b=WppmnvRzDPP40SI8nfA6+x1yrDBvTLvjMSBeLdvMZKE0hGDFe2clNNbe
   6SEsyI8ONnu3oj+E24pGGUqWA1vE74KASvKjdoceiKdQ6UafLW/hcpcgv
   mIDeyPzr1q7XSPLGNdb+kSw/GTbPKtZEJbj4Zh0P3wHZ4SswKY5Td5M82
   hZv290z9inGGW+dYW9RwFyTnlsrocUWAbuF0jK/6wV1quBxKCEJ6EbDt8
   gj3225lXBdABkYhwUMxYxZM4I1YZTRQ34riQJkTRflxNvAFkMYnU12K9h
   xhUFDIyVyTZ9khQAZZFq2W3juKC6N4Ggz7Du04n/32uXBSf8Wmj1hiZHP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5445650"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="5445650"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 11:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="13130314"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Mar 2024 11:00:30 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rluo8-000GOb-2Q;
	Sun, 17 Mar 2024 18:00:28 +0000
Date: Mon, 18 Mar 2024 02:00:06 +0800
From: kernel test robot <lkp@intel.com>
To: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alan Previn <alan.previn.teres.alexis@intel.com>
Subject: drivers/gpu/drm/xe/xe_irq.c:279:3-4: Unneeded semicolon
Message-ID: <202403180145.fkaEWVrN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   741e9d668aa50c91e4f681511ce0e408d55dd7ce
commit: eb08104f90fc474054211244d668d3fe1d84bccb drm/xe/gsc: add support for GSC proxy interrupt
date:   8 weeks ago
config: alpha-randconfig-r054-20240317 (https://download.01.org/0day-ci/archive/20240318/202403180145.fkaEWVrN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403180145.fkaEWVrN-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/xe/xe_irq.c:279:3-4: Unneeded semicolon

vim +279 drivers/gpu/drm/xe/xe_irq.c

   257	
   258	static struct xe_gt *pick_engine_gt(struct xe_tile *tile,
   259					    enum xe_engine_class class,
   260					    unsigned int instance)
   261	{
   262		struct xe_device *xe = tile_to_xe(tile);
   263	
   264		if (MEDIA_VER(xe) < 13)
   265			return tile->primary_gt;
   266	
   267		switch (class) {
   268		case XE_ENGINE_CLASS_VIDEO_DECODE:
   269		case XE_ENGINE_CLASS_VIDEO_ENHANCE:
   270			return tile->media_gt;
   271		case XE_ENGINE_CLASS_OTHER:
   272			switch (instance) {
   273			case OTHER_MEDIA_GUC_INSTANCE:
   274			case OTHER_GSC_INSTANCE:
   275			case OTHER_GSC_HECI2_INSTANCE:
   276				return tile->media_gt;
   277			default:
   278				break;
 > 279			};
   280			fallthrough;
   281		default:
   282			return tile->primary_gt;
   283		}
   284	}
   285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

