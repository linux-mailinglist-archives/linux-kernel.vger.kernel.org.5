Return-Path: <linux-kernel+bounces-111024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77886886712
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A995C1C22373
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0632E10A19;
	Fri, 22 Mar 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvYjq6KY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C304D51A;
	Fri, 22 Mar 2024 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090101; cv=none; b=bh3lVdJQJxFlFa5elaoJc4KK6aET+lnhvONFPNACEEOZ1qNWZRs9L7rvWcM21FDEOhF2/PPEt5zDee6JtZFP/YkT88huQ9E/Xvq5Oq8apz7zubkldeBKnc0x5Uoi11fad67zEkW6Ox+X/V4foLaHShpE2UF7ZdUw12nvaIBBmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090101; c=relaxed/simple;
	bh=MMToYGDlPx6M64cs/BtMBKCnEYYVKlgAvV4z9fQeu8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlRZ+pI90alfhsHOcFl+WJaE3BX7KKAQWZ2QG1ZMpRlhD1xHonwvb4jc/VbS54l7xD6RQh+fhIAEYFytZbrEXqrRJZS3UhO0gGPPt7qeFpTg7SvC2Fs1DDivE1G1bwzGW4X0hhNv7adahJOXBHVVKb8SKHQKdwCdCKPb5rALeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvYjq6KY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711090099; x=1742626099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MMToYGDlPx6M64cs/BtMBKCnEYYVKlgAvV4z9fQeu8Q=;
  b=lvYjq6KYMgq0JeyE9MVCMT28cMZDxJBIXOWm6LrYQX4GeJUwTL9CDrl/
   CJp8fwI4iRTGfMwMvcUkh2TMpxibFZwjgu6gevLc8WypanU1nsKDmoHEF
   JQ8NjztnMykm+CVcA4CMIiWTEtDLl/4hu/NKFL2BlYI5ZDWRAsMoY1L15
   onE8QwOEvQCejW9i5vxUA6cg9tEmD8eLyJSkaWoekLYxgjV43tvh3gRwO
   2Hi7JEFGtq9S5/B7C9KqVYm1dwZl+XsLlatjN9nLIWZxd/5UstorjSfMV
   TgPBB9Q+alo8leAWrPYe9GHCEQAQLNOUVcs7u2zYbmdtyvp3QJJk0/KYF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5980684"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="5980684"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 23:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="14834215"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Mar 2024 23:48:14 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnYhI-000K5n-0c;
	Fri, 22 Mar 2024 06:48:12 +0000
Date: Fri, 22 Mar 2024 14:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: Andrej Picej <andrej.picej@norik.com>, haibo.chen@nxp.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org, lars@metafoo.de,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add
 calibration properties
Message-ID: <202403221438.trdG8I0x-lkp@intel.com>
References: <20240320100407.1639082-3-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320100407.1639082-3-andrej.picej@norik.com>

Hi Andrej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.8 next-20240322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrej-Picej/iio-adc-imx93-Make-calibration-properties-configurable/20240320-184314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240320100407.1639082-3-andrej.picej%40norik.com
patch subject: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add calibration properties
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240322/202403221438.trdG8I0x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403221438.trdG8I0x-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
>> Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml: nxp,calib-avg-en: missing type definition
>> Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml: nxp,calib-nr-samples: missing type definition
>> Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml: nxp,calib-t-samples: missing type definition

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

