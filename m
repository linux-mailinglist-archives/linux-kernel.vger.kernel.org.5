Return-Path: <linux-kernel+bounces-28255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C6682FC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AAF1C27B86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CBF241F0;
	Tue, 16 Jan 2024 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPzrISPu"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5921E522;
	Tue, 16 Jan 2024 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437337; cv=none; b=YN29aFEGf5IUFcwDLA21VoML/tREwLlfdeSWR/02/Bp9O+U2c1Qe9TIBuVymPQrd935DB/gupkd1ljOk7vjDbIsxKgR6jAmrUz5woiJsrZn4qYW1z5bOUWIKrb509OiUbUQjohVKTsBKv21PI8beeBC86cAKMiNL53aUatxyvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437337; c=relaxed/simple;
	bh=9PpIhVPT+ja3jI9uPpGTzGflBYIHLpQFQiw2CXoF3f8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=jQMQPdFsFOpspp+/z2GVsUpzN6Co98L7C0mTkeNaCAqBDcf6R6mLXb+mW5Ss+1qZFC+uVNGxsXobLdoCREVyEjlIprM8T5M5h75lh0vaTOoGo0hiOu9HjS/Db22DDLgmL+Acbm5uhE1Si/3Z4nrbUnTe28F0rRkhFukxYW0nzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPzrISPu; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705437336; x=1736973336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9PpIhVPT+ja3jI9uPpGTzGflBYIHLpQFQiw2CXoF3f8=;
  b=IPzrISPuLC2ZgXdiSwTT2tKnbeMLEZPKLXvoc06eR502MdOXkZ0dxUpT
   nnn4ZIFqE/BqGjsXsD+/Qn55tWD4WHco9iw30iNJeyeD+hZBqIEBBbIRf
   PSYiKzayRtmtcxdWxb5LBTAoqHFnZGEKWt2nN71L11avl6thwroT+hE6m
   lBfGB0PSeTtMG+7TxrgBWaBaQCCfyeDRsLB3/mULLLRyvGLGRSJgNT+T+
   GdhhuGPdQ5zF2XH0UdgeYkBHZwBrAOcZlnbnE/AubDHLO9Fqwq0LIMq+V
   9dMqmdRncEmJ38y8D6docf/9Lf/rwE4jgqohFV1WLgFF7negIwXRQ3P2l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="397137949"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="397137949"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 12:35:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="25935828"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Jan 2024 12:35:30 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPq9f-0001Ck-1k;
	Tue, 16 Jan 2024 20:35:27 +0000
Date: Wed, 17 Jan 2024 04:34:35 +0800
From: kernel test robot <lkp@intel.com>
To: Mao Jinlong <quic_jinlmao@quicinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Mao Jinlong <quic_jinlmao@quicinc.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: Add device-name in the
 coresight components
Message-ID: <202401170445.7STzlFcl-lkp@intel.com>
References: <20240115164252.26510-3-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115164252.26510-3-quic_jinlmao@quicinc.com>

Hi Mao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mao-Jinlong/coresight-core-Add-device-name-support/20240116-004557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240115164252.26510-3-quic_jinlmao%40quicinc.com
patch subject: [PATCH v2 2/2] dt-bindings: arm: Add device-name in the coresight components
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240117/202401170445.7STzlFcl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170445.7STzlFcl-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml: device-name: missing type definition

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

