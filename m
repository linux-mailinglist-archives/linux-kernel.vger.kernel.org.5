Return-Path: <linux-kernel+bounces-76013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8285F1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5AD1C231A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467A1799C;
	Thu, 22 Feb 2024 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feBHFOCY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1F175B5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587268; cv=none; b=JYDImY0hsF1BgOut/Whsiel9myl4XjtNc8/fZvBPenyxD6je365+15/xoIW5EnjCuSLtcipK5Quroeo2u+b1yqAbQPwVU3tv0pi/BuZzttsi6hmjNDDMEitD2rbrKzhZ8pV7cwQZ72712kkMq7g7sMBmpQbzmlTN/4IMKa9Xd/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587268; c=relaxed/simple;
	bh=qIjjRASZQuOpPiypkZ4z1TTvkn4Ti9H93DmPRe/Af5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCI9bDBh994tJD21Mdfs+LXLd9vwTt4AKfBF8bzkqO5lwQSh8MJ2p98CFu+H7JPsHlh5Mu4h74Fm5Ke1fQSepXaVdFNvGc6AwRXwqhh/QHzspOaJh2Jx6fEshHpnJHXQCJCNunB1/yVeQhn6pX/geVd14Cz98dmqgjw2bSIWmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feBHFOCY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708587267; x=1740123267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qIjjRASZQuOpPiypkZ4z1TTvkn4Ti9H93DmPRe/Af5Y=;
  b=feBHFOCYxS/5ir6rlEBBuylTno07f8b2pMn7aC+TPqBustV5pQLbLwsy
   jGmJIw/NN2N2mBFCQbIIs/AtM/GAoz8JUGPcDJnVEiPwMQrayayW0zgAz
   Lhvqzlx0Fa7Mrr1HrHJ+CroAMR6m0ESk+gA8rIE7ivAYmLj+4v9yak8+w
   bZ/GrPi+UfWZilLzeM6J6b/uM4fxm+CSMNM8lN5xXJaS7uBK+6+H6cbrZ
   SP6uTTakqmdzQbinGpWioT3TqiUG550KBSVrNR0nE+NmJgfwskwCBY+56
   B3a6rRMLka9J+aneAH8yyzNLoW4Aa6nBGivFFnTA8p/nr8EssUimNYQ50
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2657052"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2657052"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 23:34:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5726078"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2024 23:34:22 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rd3b1-00065n-1s;
	Thu, 22 Feb 2024 07:34:19 +0000
Date: Thu, 22 Feb 2024 15:27:29 +0800
From: kernel test robot <lkp@intel.com>
To: Viacheslav Bocharov <adeep@lexina.in>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic
 secure-monitor SoC Information driver
Message-ID: <202402221557.ELxBYVKH-lkp@intel.com>
References: <20240221143654.544444-3-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221143654.544444-3-adeep@lexina.in>

Hi Viacheslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Viacheslav-Bocharov/soc-amlogic-meson-gx-socinfo-move-common-code-to-header-file/20240221-224803
base:   9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8
patch link:    https://lore.kernel.org/r/20240221143654.544444-3-adeep%40lexina.in
patch subject: [PATCH v2 2/3] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic secure-monitor SoC Information driver
config: xtensa-randconfig-r071-20240222 (https://download.01.org/0day-ci/archive/20240222/202402221557.ELxBYVKH-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221557.ELxBYVKH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402221557.ELxBYVKH-lkp@intel.com/

All errors (new ones prefixed by >>):

   xtensa-linux-ld: drivers/soc/amlogic/meson-gx-socinfo-sm.o: in function `meson_gx_socinfo_sm_remove':
   meson-gx-socinfo-sm.c:(.text+0x88): undefined reference to `meson_sm_get'
>> xtensa-linux-ld: meson-gx-socinfo-sm.c:(.text+0x8c): undefined reference to `meson_sm_call_read'
   xtensa-linux-ld: drivers/soc/amlogic/meson-gx-socinfo-sm.o: in function `meson_gx_socinfo_sm_probe':
   meson-gx-socinfo-sm.c:(.text+0x1b8): undefined reference to `meson_sm_get'
   xtensa-linux-ld: meson-gx-socinfo-sm.c:(.text+0x243): undefined reference to `meson_sm_call_read'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

