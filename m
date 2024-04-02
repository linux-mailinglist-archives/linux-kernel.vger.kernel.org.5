Return-Path: <linux-kernel+bounces-127559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAEB894DA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DC01F22309
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451017C7C;
	Tue,  2 Apr 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxyENgd7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015413AC5;
	Tue,  2 Apr 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046893; cv=none; b=ZlCq0Id27yNjT4Ju8pZMNuLc6PvqAnQ+/EU6aSk0+ca3mdNnAVVU+Gpzwwc7RycaD+EpX33peLiQ+/zAZojj4svMtr8GkgkgNL5XeW6YwRrql8J2tzvppXXpaVPPGvoUJwZF2ug47VPX1u/vxe1+PilJuOtQ+pef4SShuRBTHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046893; c=relaxed/simple;
	bh=N+vg+rqPUjXewNa+Z2tDR6F5vyf+yMWtt3YikIb7Uec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ//xFC/f4vVXnBmEeORUGksKgTQjBVuF3g69gg2/Hfk17UHckxIiwembZWo390CDZkEfPA2pSd1qAvNayFxBrWsHMxzLdI2b3YAirrfKSgdEDZZmtMC/x7JZ2PoVpbwOo3a6kS3kJlq4p2uCEPy9En/kkEGOJDAlbTcpdqvY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxyENgd7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712046891; x=1743582891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N+vg+rqPUjXewNa+Z2tDR6F5vyf+yMWtt3YikIb7Uec=;
  b=TxyENgd7aBU9oJBSBtQC6BMGcSOBnbPgTWkndax3EbRT33gyWl/FKDak
   WHtux31rVV4roq/EHez7rKsy+oXl4uca2esFu7C+1SYgUY+NU4nnOBUN3
   hS8l0rkSJ0wICjGMirZtrQbyZzwvoDl47DpFCtnH7dfH8Aht7wwLhQkaU
   KPt4KK4A1kwrY+4UqLT1uVJAuZQxsjezqTzlSeQ4IoLCQZhgSLeP8swcW
   74BkdWGqqTDmBXKqWh3rEuG4is8ekDq79Sa8jCPjiZk5L8/JSIyvYrQsl
   tbxQVYRoTVEcclmkADQuDxSKTKsjAa2TUED38O5b77drObYJ9DU2IplAT
   g==;
X-CSE-ConnectionGUID: 975jYRv6S0yRcVsHmWR+Ug==
X-CSE-MsgGUID: Z1b+LfyfS0u2T44PO2bhCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29680621"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="29680621"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 01:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22439172"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 02 Apr 2024 01:34:49 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrZbS-00013J-30;
	Tue, 02 Apr 2024 08:34:46 +0000
Date: Tue, 2 Apr 2024 16:34:24 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 11/11] pinctrl: aw9523: Remove redundant dependency to
 OF
Message-ID: <202404021642.1I0w7URO-lkp@intel.com>
References: <20240329105634.712457-12-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329105634.712457-12-andy.shevchenko@gmail.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next linus/master v6.9-rc2 next-20240402]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-aw9523-Destroy-mutex-on-remove/20240329-185957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20240329105634.712457-12-andy.shevchenko%40gmail.com
patch subject: [PATCH v2 11/11] pinctrl: aw9523: Remove redundant dependency to OF
config: i386-randconfig-054-20240401 (https://download.01.org/0day-ci/archive/20240402/202404021642.1I0w7URO-lkp@intel.com/config)
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240402/202404021642.1I0w7URO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404021642.1I0w7URO-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pinctrl/pinctrl-aw9523.o: in function `pinconf_generic_dt_node_to_map_pin':
   include/linux/pinctrl/pinconf-generic.h:216:(.text+0x891): undefined reference to `pinconf_generic_dt_node_to_map'
>> ld: drivers/pinctrl/pinctrl-aw9523.o:(.rodata+0x4f4): undefined reference to `pinconf_generic_dt_free_map'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

