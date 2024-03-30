Return-Path: <linux-kernel+bounces-125717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55C892B09
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3B5282E4D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE72239AF4;
	Sat, 30 Mar 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3qiuv6J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363C38DDC;
	Sat, 30 Mar 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711799919; cv=none; b=MLH3+5tGpqnHUr9pZub2NJvHfJPPNyWrnB39ku+18bawxiqPX0UViCRZke2+PR785UCRQDZIwQ1oWDNxEPcjd443MoE/dnHx9dK7wT0ImxlPA5WaozX37KNdSSEDuM4NIwrqyvZ/ceHScbZYO4gSFtrsUrGQymB7Wo7YcecTdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711799919; c=relaxed/simple;
	bh=ynfTQ/GVycFwNXOPFSe6F0brkpnNBWsKnsVlyJvCxJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U28qVO+cpz0uk3BduDvy6kk62IDbn+WXCPW5TbM5D9+6d/0+fQ44Xfay9+hrS2Y7Mj5QYrqG97rao3F8D3Y7sU5FvplCSGca/z+6FWoGW9np6PPRkgqp/6cgC0X0+d/GKpAu0Yqxp2kDVix/m8tNMZydN6Pa9zjGiGFzPTkrh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3qiuv6J; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711799916; x=1743335916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ynfTQ/GVycFwNXOPFSe6F0brkpnNBWsKnsVlyJvCxJE=;
  b=m3qiuv6JhVTcRCBoUSmri3xcu54TsZ8Z4sZ31keiDoP1Jif+i/tL/oMR
   a02vwR1z8SlmHXQdOLd49CcKt+l3xwYVapoN1dN/5D7orWtFdqev2W8pH
   H6mJYEdQwD4gISnfRxpSbkzueNTRIfgXuo0Qd3SNG0bbUdUH1tFfnRBSI
   Mmlbe+SWNqZ7BI9qxIts2BXmtWhjmmhry+XRtgLjqvtLJkcRi/krfUX/B
   HZ8TGI3Cdl5YvT9EPbxkgxPAqyHmqMt99UaLUNVtNtwrcbcJkIAP+RwRj
   4hX+oj+/EAimr7WoTUi6aGs3m+GKrOxUv68CW8S/Whz8ejYi5L0Wf5ZC2
   Q==;
X-CSE-ConnectionGUID: IRqAldnrRdmu1RXH9IfrZA==
X-CSE-MsgGUID: 4jUVBjVFQkOvFZJlAP3zvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18120529"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="18120529"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 04:58:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17292158"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Mar 2024 04:58:30 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqXLv-0004EM-2E;
	Sat, 30 Mar 2024 11:58:27 +0000
Date: Sat, 30 Mar 2024 19:58:21 +0800
From: kernel test robot <lkp@intel.com>
To: wefu@redhat.com, jszhang@kernel.org, guoren@kernel.org,
	conor@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, jic23@kernel.org,
	lars@metafoo.de, andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, marius.cristea@microchip.com,
	fr0st61te@gmail.com, okan.sahin@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com, lee@kernel.org,
	mike.looijmans@topic.nl
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Wei Fu <wefu@redhat.com>
Subject: Re: [PATCH 3/3] dt-bindings: adc: Document XuanTie TH1520 ADC
Message-ID: <202403301900.9wSnTE6y-lkp@intel.com>
References: <20240329200241.4122000-4-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329200241.4122000-4-wefu@redhat.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wefu-redhat-com/drivers-iio-adc-Add-XuanTie-TH1520-ADC-driver/20240330-041029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240329200241.4122000-4-wefu%40redhat.com
patch subject: [PATCH 3/3] dt-bindings: adc: Document XuanTie TH1520 ADC
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240330/202403301900.9wSnTE6y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403301900.9wSnTE6y-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml:45:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
--
>> Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml:45:1: found a tab character where an indentation space is expected
--
>> Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml: ignoring, error parsing file

vim +45 Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml

    41	
    42	examples:
    43	  - |
    44	    adc: adc@0xfffff51000 {
  > 45		compatible = "thead,th1520-adc";

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

