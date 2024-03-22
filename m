Return-Path: <linux-kernel+bounces-110973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C3886680
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9421F238D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C6C8E0;
	Fri, 22 Mar 2024 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fns5Vi3R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D928C11;
	Fri, 22 Mar 2024 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086921; cv=none; b=kQbY0sHzR9fT8EYD+h0jHc70/BP07jTcp2OSYRzpLPdWklNLqildmLE+YeOsqNDm56WcnGX4F+59HCFvmT1V+oo7AwoTJ5kv/0CgwH7h00tvPMTSFYc1j6demtIT9xvKqszZBj41gMgtknn8cV9c449bfx/7m9SY1LqgnXsN4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086921; c=relaxed/simple;
	bh=pBHdCBlvQiXxSvqU/zvo9Ko4f2qwbUYrtBSglgVXkQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/ptODo7ZaVdtnnHxsNiHKL1hjpHj2ggKBSqsmOT2hgnNHdEbe8ptcDXBCruTmaqnVq/xI5L94reLDPtOP6+qSLtAdgLl/Zg4AFXR8HSp04Y5wgRjzVtGK8KfTAOMJ1ZLIxEwSRbaopb8UQf3IQVYbiQj9jkEQYONWfQr2iydPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fns5Vi3R; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711086918; x=1742622918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pBHdCBlvQiXxSvqU/zvo9Ko4f2qwbUYrtBSglgVXkQc=;
  b=fns5Vi3RXiGxI8NQgew7C7wHyrgHTJzR57UacuqrGbDZXihHKVaPN333
   1hS+cvT4K++8XzsJKejBFbBALKl+kFEqq9b1Zh/+kqIpGpFK/RGwltycq
   CQA0ekw40MObCD4wJFqQladVcNe39Bdk0geQFHjbo3gjA9IsY165Olj/H
   tigh/MoGtJ/9XK0AelZ150aNok7KVPvEMKQhTxlH7QzQ/gs5/8icwOEOw
   T/GdLfxCcidUdJKYOEJysQD/q+Snq1+mK7mM5lS2bc+mz3gtxFNaGxBcM
   sigu3uAiswZJQbllOakU2Py8kBZAwMwTwcIQZ+yRYDRWhpIjZt3eNeVwt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6241502"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6241502"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 22:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="19478223"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Mar 2024 22:55:14 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnXrz-000K4p-1s;
	Fri, 22 Mar 2024 05:55:11 +0000
Date: Fri, 22 Mar 2024 13:55:06 +0800
From: kernel test robot <lkp@intel.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
	konrad.dybcio@linaro.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH 2/2] clk: qcom: add IPQ9574 interconnect clocks support
Message-ID: <202403221357.pOXvpS3O-lkp@intel.com>
References: <20240321043149.2739204-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321043149.2739204-3-quic_varada@quicinc.com>

Hi Varadarajan,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on clk/clk-next linus/master v6.8 next-20240321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Varadarajan-Narayanan/dt-bindings-interconnect-Add-Qualcomm-IPQ9574-support/20240321-123508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240321043149.2739204-3-quic_varada%40quicinc.com
patch subject: [PATCH 2/2] clk: qcom: add IPQ9574 interconnect clocks support
config: csky-randconfig-001-20240321 (https://download.01.org/0day-ci/archive/20240322/202403221357.pOXvpS3O-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240322/202403221357.pOXvpS3O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403221357.pOXvpS3O-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/clk/qcom/gcc-ipq9574.o: in function `gcc_ipq9574_probe':
   gcc-ipq9574.c:(.text+0xc2): undefined reference to `icc_clk_register'
>> csky-linux-ld: gcc-ipq9574.c:(.text+0x10c): undefined reference to `icc_clk_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

