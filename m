Return-Path: <linux-kernel+bounces-126739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C6893C27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B985284AC2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31A642076;
	Mon,  1 Apr 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGNmR5We"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508E40872;
	Mon,  1 Apr 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981293; cv=none; b=eBDy8XKgn8JwciGsL124OCCmEHEuBaqLxLwQb7YeNqV1CbkRLmQFL3iTL9QKETdILU8M3TOi3ymJo3OTtlmQ4ZAZV8vn00Ue8VNodt1IBYbc0Gbbo+xbOibEYHKZ8Ub0ik59gEHa1wQXn5k40H3drufMHbiRtTD5ThyfDLR3v5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981293; c=relaxed/simple;
	bh=Y3iC7Guigto6APqj928YbEg9ZXITRZybElLdcaLuYJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSblwSm6O+izaQ5k6+n5Y5NKuDo2N0Qvsg9pN9pwxNyK5U/4pfhD1x+fR+WyLRmuBrd+1LzJgaiF0Zbygb9O/4BnaQUc7rIU/m+5EBmS3ktJHi43JFlZV94iWcRzO3+CM6ErLxX2pd8snH25yDPCmWIHxufMVBvj2R1YxBHS0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGNmR5We; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711981291; x=1743517291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3iC7Guigto6APqj928YbEg9ZXITRZybElLdcaLuYJ8=;
  b=IGNmR5We+KACuI1KJGj6Rkylt5f15D31z82y4jVFmKsAbICaGQvpLSs7
   QKWXJAK2jFlVvNE/QpvM29sKazBUTgi1UiIfzK02al+av0JpHKVbGblum
   Rg9pLOcl9uEZmuUSY30uYMw4slaKMeKOxFDTPCLBIUFeeRqZ1Q+PQGqyZ
   5IVSinsK8fCijv3WNdjH3PQermGOg/LuXeB29zxz//gDZJpfdKUSPaOc4
   qxhuHD1PGbT6O/UNhpXBrjX4AvcWkSUQWE4KYSqYC/yiiULvBn/bRjrND
   0UsiW6QARTWXQquFKXRp8rpW+ATNs71q4uTlcIxO+6efxmGv4tKBlr6z0
   w==;
X-CSE-ConnectionGUID: oAS5TkNoRiSX1VxA8VCfhA==
X-CSE-MsgGUID: 0W24oef5Q+WJSYOBz+YSew==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10066640"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="10066640"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 07:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="48718554"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 01 Apr 2024 07:21:25 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrIXK-0000ML-1t;
	Mon, 01 Apr 2024 14:21:22 +0000
Date: Mon, 1 Apr 2024 22:20:58 +0800
From: kernel test robot <lkp@intel.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
	konrad.dybcio@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, djakov@kernel.org, dmitry.baryshkov@linaro.org,
	quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 4/5] clk: qcom: ipq9574: Use icc-clk for enabling NoC
 related clocks
Message-ID: <202404012258.MFriF5BV-lkp@intel.com>
References: <20240328075936.223461-5-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328075936.223461-5-quic_varada@quicinc.com>

Hi Varadarajan,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next linus/master v6.9-rc2 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Varadarajan-Narayanan/dt-bindings-interconnect-Add-Qualcomm-IPQ9574-support/20240328-160522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240328075936.223461-5-quic_varada%40quicinc.com
patch subject: [PATCH v5 4/5] clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
config: powerpc64-randconfig-r132-20240331 (https://download.01.org/0day-ci/archive/20240401/202404012258.MFriF5BV-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240401/202404012258.MFriF5BV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404012258.MFriF5BV-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: drivers/clk/qcom/common.o: in function `qcom_cc_really_probe':
>> common.c:(.text+0x980): undefined reference to `devm_icc_clk_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

