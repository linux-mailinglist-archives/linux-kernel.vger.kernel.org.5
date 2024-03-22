Return-Path: <linux-kernel+bounces-111369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D0886B58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9250A1C21425
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69A3F9E4;
	Fri, 22 Mar 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUDSHomL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6983F8FB;
	Fri, 22 Mar 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107266; cv=none; b=VmdCczSbk64dOVn3k1ItCUoZcpomQhJ00i5cKMDUEE86uGjrZsZnuO4dvcYfdtDWdPmgUwQFzKLQyMFuIDxcNcNxYDLB+jfm8kGaxJZRLp4/pyjFzlFXc9mFhOD0GV9KJ6rVl+QZhhNtxG8zK6EXtb6t0DIR1diZUPSZWautPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107266; c=relaxed/simple;
	bh=OdYK8KD02d6UmxwIIam/r9XyRmX3DuDRyGM+jv+Hc2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipeum4vcE18EmvO3iFIoWGLcXoCQ45e2pUgL5GCr864cjEdegKVqR1nLvtqzdbs0x69QE457ycQ8DT1CxA0ozxRI06lE2bwIP6s5fPXwUF/WD4O0ZhMxb1h6YFyk7y1JD07ZjeQB9BcdyLYbsL+J5QqomjWx+4IJe+QTBMNx7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUDSHomL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711107265; x=1742643265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OdYK8KD02d6UmxwIIam/r9XyRmX3DuDRyGM+jv+Hc2g=;
  b=fUDSHomLUzynr9rbREoLELXJpe0jIZb/wreoyu0RgdgmmjTuFm/OnzwS
   qPerlpUlfCqIFbpXI1F/vRjvlSteuRlaWB/95Fl+swRhlM+CR85KjTt9G
   gALMJTlHe0zheyOZ+5vHJ2Hav3iIZ7qyh0KhB/GEpmPFYXoibnuT8MNhK
   Byl5HvZ7H583NR6IPDSOkms+IKhAyut/xuF00aNSPvy8R+W0hiYKBsIfJ
   80xB9VaW4N2f1fJQlTBu0nNG6bvBXydUYMtD3yJBzeyA99ShlBPoK34B1
   L6q5qeaBpAEjDh5N+ud+t1EiCpAMWZmxX0c49J6TOtE2uMROITtkemaai
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6089699"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6089699"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 04:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="52313988"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Mar 2024 04:34:21 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rndAA-000KGx-1D;
	Fri, 22 Mar 2024 11:34:18 +0000
Date: Fri, 22 Mar 2024 19:33:27 +0800
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
Message-ID: <202403221944.SAbczEhw-lkp@intel.com>
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
[also build test ERROR on clk/clk-next linus/master v6.8 next-20240322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Varadarajan-Narayanan/dt-bindings-interconnect-Add-Qualcomm-IPQ9574-support/20240321-123508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240321043149.2739204-3-quic_varada%40quicinc.com
patch subject: [PATCH 2/2] clk: qcom: add IPQ9574 interconnect clocks support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240322/202403221944.SAbczEhw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240322/202403221944.SAbczEhw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403221944.SAbczEhw-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: drivers/clk/qcom/gcc-ipq9574.o: in function `gcc_ipq9574_probe':
>> (.text+0x1a0): undefined reference to `icc_clk_register'
>> alpha-linux-ld: (.text+0x1ac): undefined reference to `icc_clk_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

