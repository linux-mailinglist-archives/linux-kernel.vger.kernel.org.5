Return-Path: <linux-kernel+bounces-41542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4059C83F414
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FE3B21CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29AD51A;
	Sun, 28 Jan 2024 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jv4Ddh1s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AE6FB8;
	Sun, 28 Jan 2024 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706420062; cv=none; b=OHm2VmVtryWUahOcFZwn0Kf/Mv6vTM+9iXiM0rxIy5JFcaDyjfnIz1JuzjMlpdoJ2fbQW56XKEEHup2vDBmCQll45HmdT4Z7NbWfthCKD2BkPXRt7xu5aeSA45i0OmKL3vKSri+ymljssxmAO1m9/m9g543X5Iw1jjKs7PBEpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706420062; c=relaxed/simple;
	bh=odzG11xlyST2dT7NQleJAypc54kwhO0S0seYX5QdTos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP1TnyXNhDFmcb+Sbg3xKzf1SVmvnE5Im/LKgx2heK9KzuWVqh75QhdLxb7Kyhnt3Ju95WP+dfWHJcHi/NIVUiUJmZw5vOuTb16YImlE1B4Fnb9T8/wHTYkfKkw2kh7EXVyQR6UZCbud63LykEszQyzEZbXpFkjuI/AXkBJOo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jv4Ddh1s; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706420059; x=1737956059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=odzG11xlyST2dT7NQleJAypc54kwhO0S0seYX5QdTos=;
  b=jv4Ddh1s49Z9Cs09iIBLENI3AVri3iCcbQ4UKE+6ck1qGqXul32hyn+8
   mV/0ntt4toeRLLoAdUGSEP+zy0x8attzJdQv2qJZUcs4sP5Tzht2iRv4l
   7s9egPmvApC0nNwTBpjs3iVLBorMww2MCZiaf1FEJ2D5D/qAzvfB3LA0f
   UxLD7t+jbergEsTE5J5N3KftBJgEkM1khDIcxmTvdxP2y8Argh+2IXN4x
   I2CDychkM+kq500ha4ks7MgiRBzaVJh++D6b+bt0iatjLcZ0F6V0wNIO4
   /pZn/Nvu+5LboYZexqai06GPn4dJvPxT+SYFnrvyWqSjERKzozXeB3BVi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24212939"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24212939"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 21:34:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3067961"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jan 2024 21:34:14 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTxo4-000370-20;
	Sun, 28 Jan 2024 05:34:12 +0000
Date: Sun, 28 Jan 2024 13:34:04 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ychuang3@nuvoton.com,
	schung@nuvoton.com
Subject: Re: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
Message-ID: <202401281341.AfsuZHCI-lkp@intel.com>
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
config: alpha-kismet-CONFIG_PINCTRL_MA35-CONFIG_PINCTRL_MA35D1-0-0 (https://download.01.org/0day-ci/archive/20240128/202401281341.AfsuZHCI-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240128/202401281341.AfsuZHCI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281341.AfsuZHCI-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PINCTRL_MA35 when selected by PINCTRL_MA35D1
   
   WARNING: unmet direct dependencies detected for PINCTRL_MA35
     Depends on [n]: PINCTRL [=y] && (ARCH_MA35 || COMPILE_TEST [=y]) && OF [=n]
     Selected by [y]:
     - PINCTRL_MA35D1 [=y] && PINCTRL [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

