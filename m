Return-Path: <linux-kernel+bounces-41443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789783F1C9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B5CB22257
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73832033F;
	Sat, 27 Jan 2024 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PECYXxUK"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA3200B2;
	Sat, 27 Jan 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397731; cv=none; b=ECIQAPSH3cRJ457OKMrhTzzBuaD2fLMqsRryespTBnCSaamhJvkLhnIBsAzHwwHQc3B1cHAAICwUEHhzG8LqARPQpTGTfG09gB8wLf6oeFvfBrq44cI+cjQg7p/QZPFrWCvk1tj3AkCBz+NV0i/Su1wlm+M36GebQnbAU6jiQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397731; c=relaxed/simple;
	bh=20qSAAIqanWUeEOfYpQXU7bnnPuWMMlDWr5ybRYLvzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW378zbVJunMXn8YbelKm/sb5+YlU/ZO5BtcCXB30hf84VBDWta5cZF2/P0bvbdEHJgDp7Kh19m6nmjB/oGwbWQxDA4TGwYATSupBbiUVVvkAXRac3VyDV8XozhxprcZ5YxPzio7FXI8c/E6T0CodhHRTGXNJN125ZReCwJSL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PECYXxUK; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706397729; x=1737933729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=20qSAAIqanWUeEOfYpQXU7bnnPuWMMlDWr5ybRYLvzo=;
  b=PECYXxUKimwctJMUSxn2oNaTsDaFQnryeJf3nSE1+SWx8OmXk95JiicM
   QO6fbNdXayDjxi0sDYVPH055L0t2zRVU0ORBu73/rO/SoQSOBY2RNqUPY
   2xf9TRUqbpEgB85zbaTY9kITm8qaiSZoJUCFrrJ+/aEFfi1zjTEk1sb9X
   F4E5EYO27+J67ivbNpy02uOy3epSoDs5x1e6zH5ABVuTRgUGdopqfPgtj
   CVKOrukBqnzVg21aw9+aEBn+XDunrMrIWEhuVuVXvCmK66k5xtFKw6cCP
   qrEzeNU0kh4eoFUb41WKdlLhPY9mB9I0sAjcuM1OQkcADnLx1oxtCvFdI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="406440981"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="406440981"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 15:22:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35779710"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2024 15:22:05 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTrzu-0002rC-3C;
	Sat, 27 Jan 2024 23:22:02 +0000
Date: Sun, 28 Jan 2024 07:21:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ychuang3@nuvoton.com,
	schung@nuvoton.com
Subject: Re: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
Message-ID: <202401280700.5ewaEUFG-lkp@intel.com>
References: <20240123080637.1902578-5-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123080637.1902578-5-ychuang570808@gmail.com>

Hi Jacky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next robh/for-next pza/reset/next linus/master v6.8-rc1 next-20240125]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/dt-bindings-reset-Add-syscon-to-nuvoton-ma35d1-system-management-node/20240123-161939
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20240123080637.1902578-5-ychuang570808%40gmail.com
patch subject: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver
config: x86_64-randconfig-122-20240128 (https://download.01.org/0day-ci/archive/20240128/202401280700.5ewaEUFG-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401280700.5ewaEUFG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401280700.5ewaEUFG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pinctrl/nuvoton/pinctrl-ma35.c:287:25: sparse: sparse: symbol 'ma35_pmx_ops' was not declared. Should it be static?
   drivers/pinctrl/nuvoton/pinctrl-ma35.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/ma35_pmx_ops +287 drivers/pinctrl/nuvoton/pinctrl-ma35.c

   286	
 > 287	const struct pinmux_ops ma35_pmx_ops = {
   288		.get_functions_count = ma35_pinmux_get_func_count,
   289		.get_function_name = ma35_pinmux_get_func_name,
   290		.get_function_groups = ma35_pinmux_get_func_groups,
   291		.set_mux = ma35_pinmux_set_mux,
   292		.strict = true,
   293	};
   294	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

