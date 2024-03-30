Return-Path: <linux-kernel+bounces-125882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E3892D63
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C231C216D2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF5D4AED5;
	Sat, 30 Mar 2024 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0DSfSZM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607F3D0C4;
	Sat, 30 Mar 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711832467; cv=none; b=MPmAHRIoqRdas7WSt0uUib037Tq5lofpLVL0Vu8h/CuiCZrUMAOP2lsk9JJnjLsJHWXS7UqW8jIUC2j4X8FkVHFhELVb99mjUK5wavAX63wD/inLcDI5XToqpUhPcLSYzq9OaiyDo22xsdVAtr8yKRBFqoSWhVGgXAcK0CVaOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711832467; c=relaxed/simple;
	bh=e5I2rYsF7rsiw95li5OwBXcRBuJFwZ4pAt4TxQFNfco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtkgIxE77Fut3AgxsvAAv0hyzPfzL6BunMVeoYESJQwKDyhiWBwjKEddn5oKzUgaVxE7nsMD1oGN7GC7Q45gSZWS40tnbBdeupWcbLV7cxjyJs5su+L+/vvGfA7PWHM6I4E5H9yUN4SthZNOjRXHlr2jfZdBOJNUlsycFItqfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0DSfSZM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711832465; x=1743368465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e5I2rYsF7rsiw95li5OwBXcRBuJFwZ4pAt4TxQFNfco=;
  b=V0DSfSZMsUMbViNPs/sSRTQvD6FEBABtBdFfd/ZcRaLJHkl/01XmTsxF
   1ItnGLZbVgrXvV7TL5NJfVyL0dO4WHflD6pYwo2u0s6v6pMYmUpFR+Uaj
   VRrqBeno7asNYOXqogOxznrj+ZbKEm6tKO+UImbAKDXAwwSMG69xIDPx5
   ndlS54tNoQ/mIGvYv2NEAXIpKGca2G8QuLlxlV1gbdlKGxVzO2x5C8Jvd
   voJSBd1ClyuGQgWBlCIcqvouhJpKewCERfpEk+oivAtBAjA4ytA6x4uoL
   nJIv5gUI9w3oXenNySbhSj9u5nmj3V3GMh2iE1q7riAk4K0gm5GLYTRZM
   g==;
X-CSE-ConnectionGUID: TvQ+GR1tSS2Ja5ZWdAL2gQ==
X-CSE-MsgGUID: YMq/TPXTSy+rxKnAbUtfXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="6848715"
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="6848715"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 14:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="21950900"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Mar 2024 14:00:59 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqfou-0000P2-37;
	Sat, 30 Mar 2024 21:00:56 +0000
Date: Sun, 31 Mar 2024 04:59:57 +0800
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
Message-ID: <202403310442.vdZu7Yh6-lkp@intel.com>
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
reproduce: (https://download.01.org/0day-ci/archive/20240331/202403310442.vdZu7Yh6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403310442.vdZu7Yh6-lkp@intel.com/

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

