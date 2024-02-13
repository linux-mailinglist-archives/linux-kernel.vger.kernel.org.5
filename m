Return-Path: <linux-kernel+bounces-63270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA1852D18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3560285080
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D40224D5;
	Tue, 13 Feb 2024 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUuIqwL+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB52208B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817970; cv=none; b=m0dtk7bsuuP2tXTkXn/yAou8rHUaVji7z3EjTvHYZjJ/ol+ffKYd9jKMzqFrV0LIA9iWYwVe4mPguXrpmEmSpcZWGhB/gyzDJoLJiPeMZLHrVDJcYUdTewQlYmCkRt1KLHby216ozNfi+YbGqKG7KIU0ESOCTdDcipuFumjCzmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817970; c=relaxed/simple;
	bh=TWjIIYxvPFkc36kIc6UBZiZzo/ccXERIOjGsYHm8iUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OggKdufQ17bxGJGA/vDZxc2pTU6u1anm1l+MuQFRODSyGbuEd9VY7/vNPoymyFnMGbqPOJkfiPbV6zxtW2BrNsrSEZlrpIJFymfbfKTB5swg3VOXDf1JyN+LfE7arpHanXzBKPT7q+/b/1Mg49Jf3FfxytOeni6CDsr8lgFb7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUuIqwL+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707817969; x=1739353969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TWjIIYxvPFkc36kIc6UBZiZzo/ccXERIOjGsYHm8iUo=;
  b=OUuIqwL+fc+JuiJ4K8G/2DFEQq7+7jzSjy7ZnWXlHmYSw+y4g6c2+sEx
   0HV3k9eaejc5r2/1RZGigNcyMt2LqA92TJ1nvdal+5N5pK1ygua03ZbWH
   K//fdrdocBN4aLgulfRb4KQ9fMYns0nqco5+vqr2pCwzjSiDfcZBy/bMX
   Obe1bxdXYGnHeltEaH1I2K4GwqWP0cyrxwZBpiD3ZzBHIb71LG4Y3EDQi
   hgB6J1L+xcfh6V6/cC+Q3VC+edo5qMsOGcfFrvRS8xKUxARvNwGKvxgCJ
   6NYW9r75ROuaHO1QDunHAbgHLQLvvWH+pZQPh777Kyhvp3CNSeM6zVx6j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12368711"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="12368711"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:52:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7474576"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Feb 2024 01:52:45 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZpT0-0007dh-2B;
	Tue, 13 Feb 2024 09:52:42 +0000
Date: Tue, 13 Feb 2024 17:52:12 +0800
From: kernel test robot <lkp@intel.com>
To: "mac.shen" <mac.shen@mediatek.com>, chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	jitao.shi@mediatek.com
Cc: oe-kbuild-all@lists.linux.dev, mac.shen@mediatek.com,
	shuijing.li@mediatek.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Message-ID: <202402131731.OMfzWywy-lkp@intel.com>
References: <20240205055055.25340-3-mac.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205055055.25340-3-mac.shen@mediatek.com>

Hi mac.shen,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on pza/reset/next linus/master v6.8-rc4 next-20240213]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mac-shen/Subject-PATCH-drm-mediatek-dp-Add-tee-client-application-for-HDCP-feature/20240205-163727
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240205055055.25340-3-mac.shen%40mediatek.com
patch subject: [PATCH v2 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x feature for DisplayPort
config: arm-randconfig-001-20240213 (https://download.01.org/0day-ci/archive/20240213/202402131731.OMfzWywy-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402131731.OMfzWywy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402131731.OMfzWywy-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/gpu/drm/mediatek/mtk_dp.o: in function `mtk_dp_get_system_time':
>> mtk_dp.c:(.text+0x41c0): undefined reference to `__aeabi_uldivmod'
>> arm-linux-gnueabi-ld: mtk_dp.c:(.text+0x41ce): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: drivers/gpu/drm/mediatek/mtk_dp.o: in function `mtk_dp_get_time_diff':
   mtk_dp.c:(.text+0x41ea): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: mtk_dp.c:(.text+0x41f8): undefined reference to `__aeabi_uldivmod'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

