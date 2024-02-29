Return-Path: <linux-kernel+bounces-87212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EE486D12B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100E4286CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D36D75806;
	Thu, 29 Feb 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYGYvzwN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B18757E7;
	Thu, 29 Feb 2024 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229211; cv=none; b=WEnaFtMGsgz01xaq9cIfW9P8Ava7C2LBuMblkaWe+ANjmlohasSYGxik8hL9w+UZyjGRICS6D5ACJ66JXuCOaZ+78fVAV2TALNxf1F4gtKZodPW/7+zZkZJdtmEPjHcgwbIU7fkD2qZQjjsW55UZjQzAvVb+uYHyVoQF5V7Frw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229211; c=relaxed/simple;
	bh=IZ8tXHi4D6VeM3kc0kx68z1bYQSTMxGuNMx6zsNFNB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYXJ5JzfsrXOKyPKPaOZfC+frCzhJTMmVpwoZmD6WQWn46MtsESRzlFzVRPXNJr6v6XgXzfuxNma5IYyOUrDWDMymO1Ah2cQtF/WbxjsSQyzuiIR+X6EKRswxiFq3Uy2R+GXjvlL6Air+wTg+IT9AT5Co81bq/4+GSOMYQdIlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYGYvzwN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709229209; x=1740765209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IZ8tXHi4D6VeM3kc0kx68z1bYQSTMxGuNMx6zsNFNB0=;
  b=DYGYvzwNfmxpq7ObKabx3RVT+vH5D36T5LzWrArpkzqj2/KUc4irIBPj
   cGq202ta97rlS3PMXi9aoHB84NMrRe18my66Ff+UQYf4pDbS+uwPyk6f/
   8m2kIQAYccR22eHSD4YSxm4H6tO8N1clT/4Zptzt7BcpZe8vX9nIJHCBt
   5xeTpcFQr8F/IyEL+e0LTVNFlrUK3R4GQBYgtcnc5hrtLtO2jCgPAxdmY
   OPbSU2j/m2om5QW0owi2It8+w2PeozaJp1BPQacj2FSGTcLg8MlQW37nX
   bfg6NN15QGUKCTMHFNkFDKGtu4FJeaudn6n2UMGI3pRZB/YH/4VM4D6wR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="21177108"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21177108"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 09:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12511155"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 29 Feb 2024 09:53:23 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfkav-000DAD-0q;
	Thu, 29 Feb 2024 17:53:21 +0000
Date: Fri, 1 Mar 2024 01:52:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx: add i.MX95 BLK CTL clk driver
Message-ID: <202403010142.5gu9hKpX-lkp@intel.com>
References: <20240228-imx95-blk-ctl-v1-2-9b5ae3c14d83@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-imx95-blk-ctl-v1-2-9b5ae3c14d83@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 22ba90670a51a18c6b36d285fddf92b9887c0bc3]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/dt-bindindgs-clock-support-NXP-i-MX95-BLK-CTL-module/20240228-122408
base:   22ba90670a51a18c6b36d285fddf92b9887c0bc3
patch link:    https://lore.kernel.org/r/20240228-imx95-blk-ctl-v1-2-9b5ae3c14d83%40nxp.com
patch subject: [PATCH 2/2] clk: imx: add i.MX95 BLK CTL clk driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240301/202403010142.5gu9hKpX-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 325f51237252e6dab8e4e1ea1fa7acbb4faee1cd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403010142.5gu9hKpX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403010142.5gu9hKpX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk-imx95-blk-ctl.c:13:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/clk/imx/clk-imx95-blk-ctl.c:13:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/clk/imx/clk-imx95-blk-ctl.c:13:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/clk/imx/clk-imx95-blk-ctl.c:425:25: error: use of undeclared identifier 'imx95_blk_ctl_match'; did you mean 'imx95_bc_of_match'?
     425 | MODULE_DEVICE_TABLE(of, imx95_blk_ctl_match);
         |                         ^~~~~~~~~~~~~~~~~~~
         |                         imx95_bc_of_match
   include/linux/module.h:244:15: note: expanded from macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^
   drivers/clk/imx/clk-imx95-blk-ctl.c:416:34: note: 'imx95_bc_of_match' declared here
     416 | static const struct of_device_id imx95_bc_of_match[] = {
         |                                  ^
   6 warnings and 1 error generated.


vim +425 drivers/clk/imx/clk-imx95-blk-ctl.c

   415	
   416	static const struct of_device_id imx95_bc_of_match[] = {
   417		{ .compatible = "nxp,imx95-cameramix-csr", .data = &camblk_dev_data },
   418		{ .compatible = "nxp,imx95-display-master-csr", },
   419		{ .compatible = "nxp,imx95-dispmix-lvds-csr", .data = &lvds_csr_dev_data },
   420		{ .compatible = "nxp,imx95-dispmix-csr", .data = &dispmix_csr_dev_data },
   421		{ .compatible = "nxp,imx95-netcmix-blk-ctrl", },
   422		{ .compatible = "nxp,imx95-vpumix-csr", .data = &vpublk_dev_data },
   423		{ /* Sentinel */ },
   424	};
 > 425	MODULE_DEVICE_TABLE(of, imx95_blk_ctl_match);
   426	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

