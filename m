Return-Path: <linux-kernel+bounces-50600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEBD847B70
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30BD28DEF4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A881752;
	Fri,  2 Feb 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNqU9s23"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63248063C;
	Fri,  2 Feb 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908752; cv=none; b=nFAhbTaUrcP3iY3Ek6P/5npNC6d75PcrnsW57BZPZkDY1n8ktlUQa010dr8HsEhi+AEb0N1gVWLLxY9qa3WCjq3Em/dWgd6puhzTbNaUyhIqQ3ti6b7yYi2/z6bjpcdyJgpo1sEcc2PxcBkuCZS5TH+xMbQer9fXq6gF9cmjFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908752; c=relaxed/simple;
	bh=5ksOdQd8ghM9qXKkEiudkWeCW/Mz361KuBeBg2gzM/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9P8XMFVK/LhUBMbqRThuc93AHm1GSLlEGt24sQz4T+7icI+KBJG3f2NpMmXj+EdL2PKZOMQwlYAy4kiIV/xWwZXTSyR527amOZIa4Y9EQeYc0/J+ZjVELw0ln6Sa6riGpnWH9IykjX2rPOTZ+OBsrPds7AbsObGsT7eg3Oo6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNqU9s23; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706908751; x=1738444751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ksOdQd8ghM9qXKkEiudkWeCW/Mz361KuBeBg2gzM/4=;
  b=nNqU9s23ItmdisKaKf6tshjaRnar2k4cqBurHtmJM/PRlsi9PVTpPCy8
   R4SbTCGeVIvDKX+cC98Kkq5eBE/8Q3dHM1vlWIUGoLAT4ToES0HLvkzLt
   nQkn3Ymt+qsA62Ar9ieVsFUp8hu7P/G8/nvdBeV94MUcxlGdLQ0GdkwTU
   cbZgcVxhE9cielIJcmpVB6m2L5SSOC8TCMb8KcBQAAUzu5RnUdsNUPFxs
   D2LCCsYMb+VfchzPpZMCiHA/dUueB5vvOjOSFc8vbM4rkXNeemTu1J6UM
   YsCUVhJbrdxGUfMiBKwUJfjJaJ4xnjjnURwZspvH4rLvvIML09pSbpRr5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="148414"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="148414"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 13:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="932581866"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="932581866"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2024 13:19:05 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW0wB-0004H0-1Q;
	Fri, 02 Feb 2024 21:19:03 +0000
Date: Sat, 3 Feb 2024 05:18:51 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, ilpo.jarvinen@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	robh@kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v5 1/8] i3c: add target mode support
Message-ID: <202402030437.GdGCrKeK-lkp@intel.com>
References: <20240129195321.229867-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129195321.229867-2-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus robh/for-next linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-add-target-mode-support/20240130-035826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240129195321.229867-2-Frank.Li%40nxp.com
patch subject: [PATCH v5 1/8] i3c: add target mode support
config: sh-randconfig-r122-20240202 (https://download.01.org/0day-ci/archive/20240203/202402030437.GdGCrKeK-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240203/202402030437.GdGCrKeK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/i3c/target.o: in function `i3c_target_ctrl_destroy':
>> target.c:(.text+0x264): undefined reference to `i3c_target_cfs_remove_ctrl_group'
   sh4-linux-ld: drivers/i3c/target.o: in function `__i3c_target_func_register_driver':
>> target.c:(.text+0x4bc): undefined reference to `i3c_target_cfs_add_func_group'
   sh4-linux-ld: drivers/i3c/target.o: in function `__i3c_target_ctrl_create':
>> target.c:(.text+0x778): undefined reference to `i3c_target_cfs_add_ctrl_group'
   sh4-linux-ld: drivers/i3c/target.o: in function `devm_i3c_target_ctrl_release':
   target.c:(.text+0x7b8): undefined reference to `i3c_target_cfs_remove_ctrl_group'
   sh4-linux-ld: drivers/media/i2c/tc358746.o: in function `tc358746_probe':
   tc358746.c:(.text+0x17c4): undefined reference to `devm_clk_hw_register'
   sh4-linux-ld: tc358746.c:(.text+0x17c8): undefined reference to `devm_of_clk_add_hw_provider'
   sh4-linux-ld: tc358746.c:(.text+0x17cc): undefined reference to `of_clk_hw_simple_get'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

