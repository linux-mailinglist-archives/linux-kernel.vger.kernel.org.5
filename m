Return-Path: <linux-kernel+bounces-123543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D8890A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79AB1C21D11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1209139D03;
	Thu, 28 Mar 2024 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N80juSaU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72AB7460;
	Thu, 28 Mar 2024 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656402; cv=none; b=nWwY4iROyiWMn1i6bo24dgpmIgfzorGXSLL/f+QxHu4vQbpBGRrsZ6Kj4RXRS36R8wveecramNzjuo7t947fSL3DsdDD8p5+rsfdNLo8motIMEeam0nUEh6SGWcMuVl15TJTVKYqQmKUuAwA0+IrlWppfJLXJ/AHS150KSQxsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656402; c=relaxed/simple;
	bh=nkIjd0IXCVDR6LITaen5NTM7zN+lmF4nDqCRUBJ5Urs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ+mxNTQAB2ogMhBIw5Xat2Vqov0m1zUdnImex8+uivZ1dfcqpWzgaZPtuWb9P8DFBpxyIczqDJ1ekDnANRiUxrp3M4e/7gG9E5sUDaaFLnyAedT9LayWRjd+8Hh3+M7gSQMhxjMFptvZh3G212T7b8JZDw+L6vw0DW3LXxCz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N80juSaU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711656400; x=1743192400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nkIjd0IXCVDR6LITaen5NTM7zN+lmF4nDqCRUBJ5Urs=;
  b=N80juSaUn/hDbvCxuO9rfs0Vawpu8ZJwkSOCJ4K064g9FHr2U+opgw8p
   qi5R703q2EU2pr/rd4HuLhHhGxIpShkolg/A7dcFDJAIgO7RmxGOTEF5U
   ql63nT9cg/BC7MDaY5kZXXS5oXRQrN3S7rpNiVjHXHUwjAE/8nXj+pHxf
   9zdHl7ouWIdCkRpzl3mJAsLYrq/GlWsHlPimc4e0x+dvMe4SsNGQUeZ8c
   y4S5C+oUZqZUUSKqK706FJ6On85G4w5dKbjOme3VUHNWAswQ34xy1J2hH
   ywL3nqkFvR1Wh4W2S4XmSv7XKytYU7Q80hk3fNhih8b6lkVqnOXtEBk4T
   A==;
X-CSE-ConnectionGUID: Qy6iz0wpR+WaSBn8YbkyZw==
X-CSE-MsgGUID: TbuzdmD9R4mHymLC5OnS5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="7030086"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="7030086"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 13:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16786652"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Mar 2024 13:06:21 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpw0w-0002UQ-2z;
	Thu, 28 Mar 2024 20:06:18 +0000
Date: Fri, 29 Mar 2024 04:05:34 +0800
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
Message-ID: <202403290352.sV38QfhQ-lkp@intel.com>
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
reproduce: (https://download.01.org/0day-ci/archive/20240329/202403290352.sV38QfhQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403290352.sV38QfhQ-lkp@intel.com/

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

