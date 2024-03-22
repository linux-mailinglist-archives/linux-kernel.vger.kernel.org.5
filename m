Return-Path: <linux-kernel+bounces-111904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D70C887268
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8031C238FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131060EE9;
	Fri, 22 Mar 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ek39tlHb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922860DE7;
	Fri, 22 Mar 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130319; cv=none; b=N3TGhSRoWzYkjrH7U0KfGlC0YpRJhK4qk1fiCFC1/L3Sz8TuPVyH1ml7k3CJnfTj5yAE1RTRCroS3GiRU4glTEnMstd12SH6HZ3X5KICNU9QyhbAYVk5UfpjQrvW25JjRl3GHApcJyODYRQ/pdLegpd4QgbBDQqx7jWR3YZH46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130319; c=relaxed/simple;
	bh=Fg2DTIIIhUQNFpW2Iw3rokXpLJlP9QgdMt0GMxWljz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pch37pcZD3OUkEPikFQCTMl/gBFIq4anY4m79sJ4pgacNjnWj0LKOdnYIsrEL9Iq1Ak5m2dXfLtwi/CjiYobGlBnMyzy46tFvs6X5pQQORjXSwSQwRolu7LHVil0zn++brJbDGf45Qe9aD2BIWwEITW0IUeCtVYZH7mw2U8IeCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ek39tlHb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711130317; x=1742666317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fg2DTIIIhUQNFpW2Iw3rokXpLJlP9QgdMt0GMxWljz4=;
  b=ek39tlHbe26aMIDREYKIeDgNvXGTPg7L3B9pWojODgDRisNRGSlq51mc
   ks0lo5owd6TrWjOf0rT/dX68yOUU0K/jIFJD8yf+Ni2NT80kzqQppC3DC
   GA7BlJFaxCi3yOxCUXBQzt5oanX9Uwz1Y8c8figcEhNfewhXuL49DaB2d
   m36gr8NVQXglZGiK5hYRFgtlo8RNo7PLIRqz5qNDy9eKSrD53r3vgqJYW
   RR5vXrZw0m8ndvL68ecyX54/Gi8ATk6nIYk2mraeQ4nkST9tFXYWglZsi
   wB5Vax2EEGVD6UN41JctHUuICe/++S+8ediwxxbxPrCVeY0Ung1fH/86A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6308430"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6308430"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="19551738"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 22 Mar 2024 10:58:33 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnj9y-000KVr-2a;
	Fri, 22 Mar 2024 17:58:30 +0000
Date: Sat, 23 Mar 2024 01:58:17 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Bee <knaerzche@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH 2/5] mfd: rk8xx: Add RK816 support
Message-ID: <202403230131.AhHTZiEx-lkp@intel.com>
References: <20240321143911.90210-5-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321143911.90210-5-knaerzche@gmail.com>

Hi Alex,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on lee-mfd/for-mfd-fixes broonie-regulator/for-next robh/for-next linus/master v6.8 next-20240322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Bee/dt-bindings-mfd-Add-rk816-binding/20240321-224318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20240321143911.90210-5-knaerzche%40gmail.com
patch subject: [PATCH 2/5] mfd: rk8xx: Add RK816 support
config: i386-randconfig-062-20240322 (https://download.01.org/0day-ci/archive/20240323/202403230131.AhHTZiEx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240323/202403230131.AhHTZiEx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403230131.AhHTZiEx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mfd/rk8xx-core.c:573:24: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected unsigned int ( *get_irq_reg )( ... ) @@     got unsigned int ( const * )( ... ) @@
   drivers/mfd/rk8xx-core.c:573:24: sparse:     expected unsigned int ( *get_irq_reg )( ... )
   drivers/mfd/rk8xx-core.c:573:24: sparse:     got unsigned int ( const * )( ... )

vim +573 drivers/mfd/rk8xx-core.c

   567	
   568	static const struct regmap_irq_chip rk816_irq_chip = {
   569		.name = "rk816",
   570		.irqs = rk816_irqs,
   571		.num_irqs = ARRAY_SIZE(rk816_irqs),
   572		.num_regs = 3,
 > 573		.get_irq_reg = rk816_get_irq_reg,
   574		.status_base = RK816_INT_STS_REG1,
   575		.mask_base = RK816_INT_STS_MSK_REG1,
   576		.ack_base = RK816_INT_STS_REG1,
   577		.init_ack_masked = true,
   578	};
   579	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

