Return-Path: <linux-kernel+bounces-51381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1E848AA7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785FD285007
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677217F7;
	Sun,  4 Feb 2024 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHX2fOkL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2B10F1;
	Sun,  4 Feb 2024 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013600; cv=none; b=IUllzHwjBmIfQzGRk8vvgwNmZRj0rdQ9Vo8IEgVn7OyfPUlj+OOat81hj/wyAAYIT9yzN5FS1fj2jR1q7yp0au0uSPYZQ0OJHTMyM8OIjc0lfmSAiOOSEOlqHvDUV1rfeCPEXZD3TwQO667K1ULygsYZP6QoXW2iFVa+NSsMhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013600; c=relaxed/simple;
	bh=MZuUD704UrOLgccaN1b2cCtt8f2iQc2TlTIT1NofrqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr5TzF2+VNaio57Y76E6TlMSzQjyhtgAj6dIARCyC6HBawrRgJ45tbBNiiJWyDigtcxuooU+iZkpMuXvnxewVSKsoM16aRvxygl3RbGNlX5SODI/+cx7zdFvN7JvGT7rYPpeAxShSF0FGTXSqkDFxF2HusY8T86iw0hlYFJF28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHX2fOkL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707013598; x=1738549598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MZuUD704UrOLgccaN1b2cCtt8f2iQc2TlTIT1NofrqM=;
  b=OHX2fOkLXCW1KtVUJqoUyoN+ud+HZ5hfubYggwalRpNenq/HSoGa6cUx
   v2T+1ij8btF/OboBCIlH1TgYkkzTAuvu8E8weiSWJpSyeMD/iFnylqnpZ
   ieoC8R9PHGVAjeFI2Yrc3rFCIn2p+nrO04QOGk2p+/P4o+kzidgzPIytX
   CA427PFMdcoITAbNmNHvMGTeT+5CpqlUoI6rrIQvlPjpr9GDQab+IAD/C
   Vrk59yckSQ0vTzdkluCNyyBRdmPigSHvaF2tsAZhyoJWnnnmVrL8+65v3
   Liyo6pzF4qzzDWSQK4to+hvcJgBJ79hHxRn9fI5UV+n2/gFQGzFzkqgFu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="10948395"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="10948395"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 18:26:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="908957191"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="908957191"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2024 18:26:34 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWSDH-0005tm-2y;
	Sun, 04 Feb 2024 02:26:31 +0000
Date: Sun, 4 Feb 2024 10:25:32 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	alexandre.belloni@bootlin.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net, antoniu.miclaus@analog.com,
	noname.nuno@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v6 1/2] drivers: rtc: add max313xx series rtc driver
Message-ID: <202402041027.jyioXP7e-lkp@intel.com>
References: <20240202025241.834283-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202025241.834283-2-chris.packham@alliedtelesis.co.nz>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on robh/for-next linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Packham/drivers-rtc-add-max313xx-series-rtc-driver/20240202-105538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20240202025241.834283-2-chris.packham%40alliedtelesis.co.nz
patch subject: [PATCH v6 1/2] drivers: rtc: add max313xx series rtc driver
config: parisc-randconfig-r051-20240204 (https://download.01.org/0day-ci/archive/20240204/202402041027.jyioXP7e-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041027.jyioXP7e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402041027.jyioXP7e-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/rtc/rtc-max313xx.o: in function `max313xx_probe':
>> (.text+0x16b0): undefined reference to `devm_clk_hw_register'
>> hppa-linux-ld: (.text+0x16c8): undefined reference to `devm_of_clk_add_hw_provider'
   hppa-linux-ld: drivers/rtc/rtc-max313xx.o: in function `.LC19':
>> (.rodata.cst4+0x4): undefined reference to `of_clk_hw_simple_get'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

