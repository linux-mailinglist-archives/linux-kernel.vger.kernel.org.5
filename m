Return-Path: <linux-kernel+bounces-125551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64279892818
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31EC3B21A9A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682B215CB;
	Sat, 30 Mar 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/GU0cHL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083F17CD;
	Sat, 30 Mar 2024 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758679; cv=none; b=jPRYOa1pZb5xXyRVHiCt8Y4rfDZ4hrL3kjqRg9TVczb5lANAix04kKL/hA1emqJFzCTtBOPbESgWGA/hZ/sxTln1EAB6x/6W9rPPDWy6wCK6Gamg+2XrRQaDwgYdo0PVoXphJT/r9fA6KrKMNOpjHxFdmtr7KYsmk+mRdr33+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758679; c=relaxed/simple;
	bh=7YZ2emKoPRQ2Oh1HSYDBnvLIiVwOATZLjFZIyAOLekY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFfyiNNd7X2drPjiWcwBOOBCiavjGYb8OqWmxgKkt0zni72zK/iUpEH0mhOeQ97UZgw2RSsFS8XMygvXEvHpK3/nT41q2lkf9Varp+DDttnuyY661UKynM7fC/Z/t6K3HRW5Qqi7TGvUQAIgo0ckVFrC6cMVevw3ui+dEhGsJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/GU0cHL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711758677; x=1743294677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7YZ2emKoPRQ2Oh1HSYDBnvLIiVwOATZLjFZIyAOLekY=;
  b=l/GU0cHL8soqEEbc8gHM8kmlGkX9/ba/CLb6TbNgzpErBTiw0QuYI7kM
   W5LJkHIOxgZXu0GcgZr1mVEZCI5N6phBZoFY070wTOaC4et7l+Vk1iXTW
   1mv633GbkuEIzXfxYRLt587/x0oXGGCAdfjcgMbWKOmJ/AUSFxVHIYGxz
   /c2M3nup2U22wjlagvYfiZQszOw87pSeZRkcA3/01/7nmO5QgLE/nhDZF
   iVi30p9+JZJ/PMY1LDhTXGEvEGOFBreRyLn/S0Nl0ySmnBZDV7pdH/q6i
   Llow5aK2UGN4uJLyaNbNHknROrQF3wX/YYSy+SBuoUoSeGtx52BkWW9Lf
   Q==;
X-CSE-ConnectionGUID: lqb4HQbBQ4mIqBWBrAci0Q==
X-CSE-MsgGUID: DtyxbnqTQb2j9A/P8Cj3IQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6801836"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="6801836"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 17:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="21768159"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Mar 2024 17:31:13 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqMcn-0003mQ-2h;
	Sat, 30 Mar 2024 00:31:09 +0000
Date: Sat, 30 Mar 2024 08:30:25 +0800
From: kernel test robot <lkp@intel.com>
To: git@luigi311.com, linux-media@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Luigi311 <git@luigi311.com>
Subject: Re: [PATCH 18/23] dt-bindings: media: imx258: Add alternate
 compatible strings
Message-ID: <202403300820.NEs0EOr7-lkp@intel.com>
References: <20240327231710.53188-19-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327231710.53188-19-git@luigi311.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linuxtv-media-stage/master linus/master v6.9-rc1 next-20240328]
[cannot apply to sailus-media-tree/streams]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/git-luigi311-com/media-i2c-imx258-Remove-unused-defines/20240328-072629
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20240327231710.53188-19-git%40luigi311.com
patch subject: [PATCH 18/23] dt-bindings: media: imx258: Add alternate compatible strings
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240330/202403300820.NEs0EOr7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403300820.NEs0EOr7-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml: properties:compatible: [{'enum': ['sony,imx258', 'sony,imx258-pdaf']}] is not of type 'object', 'boolean'
   	from schema $id: http://json-schema.org/draft-07/schema#
>> Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml: properties:compatible: [{'enum': ['sony,imx258', 'sony,imx258-pdaf']}] is not of type 'object', 'boolean'
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
--
>> Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml: ignoring, error in schema: properties: compatible

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

