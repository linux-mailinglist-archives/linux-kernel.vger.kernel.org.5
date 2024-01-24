Return-Path: <linux-kernel+bounces-36234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89B839DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501851C24355
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE4D137B;
	Wed, 24 Jan 2024 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhlKnA9g"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00117CD;
	Wed, 24 Jan 2024 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057626; cv=none; b=MeFAG2NwhN5uUE6uDDdkwr3pjYTQhUX0PUxZJgj/JLoTRNMQg4GW4wlAF2G3nJAMB3t1S4DvMogIC2s2NFiDzrTKjDSclRjDkaUgzmekeG9OhtQBiMm5suyZB+nu1IbJDJWsC5kamqGk3CHg7sonBnmZb80kqdB/FCUDFMDHkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057626; c=relaxed/simple;
	bh=yU9VsaBUrWtQtZ+GU86aDxwFo8ytu1/OKjeCrxQZZw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApIC0weaGf7/FYsjdWz81Fa6jPk9LfdvSgy3uxJolfY/QBNadJnQxSuwABa4ylxcUpRLqTx9bBKmRNTcE+Hv7cZGqG/Wdf3bETy0fqoCmwHYlf/AYVut0XTkBA7bwpeGep2bjv7/Raz7ojMG4n4DGQnF8AxPnsoEaedhbSFsxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhlKnA9g; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706057624; x=1737593624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yU9VsaBUrWtQtZ+GU86aDxwFo8ytu1/OKjeCrxQZZw8=;
  b=IhlKnA9g13fYO612mTk3JFliIxvVs+vBk0ubOWKGSrhzTbXBmXZHpeRV
   AdgG5IwADKSbjtuSw5n8bDWpfP2UOlpL/1EnLc/mazwSOYjzBcOhnkSAi
   kzPTU23jijZ3+euRYrEc9GD3meRWUBk+rVVYHhr9PbxLz0R3nKtTvLQxm
   aChXGwulEdkhJ33etoSytvOCTLn45l6Jj9dSiZzirG1e1qLCzqlDGQ1Ss
   hzOoQOt1DcIH90ByWeP1On2feOGgJqHpFcBJebGu9vUo/Dl4fxIrse8tV
   3OFgw/20v8H/7Ggsg4RXy0WeiPaDd7AVZe08BfbUnArLVE2Ms1NUQzKnU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405454537"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="405454537"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 16:53:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929509990"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="929509990"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2024 16:53:40 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSRWM-0007lN-0F;
	Wed, 24 Jan 2024 00:53:38 +0000
Date: Wed, 24 Jan 2024 08:53:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ziyang Huang <hzyitc@outlook.com>, mcoquelin.stm32@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	alexandre.torgue@foss.st.com, richardcochran@gmail.com,
	p.zabel@pengutronix.de, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [PATCH 8/8] arm64: dts: qcom: ipq5018-rdp432-c2: enable ethernet
 support
Message-ID: <202401240841.gfbyp3Lz-lkp@intel.com>
References: <TYZPR01MB5556D3E73D7F7242F810F915C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB5556D3E73D7F7242F810F915C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

Hi Ziyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on clk/clk-next pza/reset/next]
[cannot apply to linus/master pza/imx-drm/next v6.8-rc1 next-20240123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziyang-Huang/net-phy-Introduce-Qualcomm-IPQ5018-internal-PHY-driver/20240121-204840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/TYZPR01MB5556D3E73D7F7242F810F915C9762%40TYZPR01MB5556.apcprd01.prod.exchangelabs.com
patch subject: [PATCH 8/8] arm64: dts: qcom: ipq5018-rdp432-c2: enable ethernet support
config: arm64-randconfig-001-20240124 (https://download.01.org/0day-ci/archive/20240124/202401240841.gfbyp3Lz-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240124/202401240841.gfbyp3Lz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401240841.gfbyp3Lz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts:102.26-27 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

