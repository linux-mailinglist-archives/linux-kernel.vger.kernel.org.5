Return-Path: <linux-kernel+bounces-73790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE34985CB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669EB2842D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58DC154BF8;
	Tue, 20 Feb 2024 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SflNJCiu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC5C15445F;
	Tue, 20 Feb 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469845; cv=none; b=YI3y173k89eDFvmaCTx9IGiKdPGNi6FUhNeGmmknbaS+gtP4tKjCQYqwoxcHl3HP/us8uZsSTrrBOOJoLv+9uGUTtqMsPMpf/eCBCflqoEABOqWnZgJW05oyBkUPFA8TLhOVm9O1mHZlhvUEHIYxUKeTohVgW6bIdN04Kq8dAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469845; c=relaxed/simple;
	bh=PoSnWb8232+NWzHCqe4gbktgez5KBoGoPcKcW0/PPBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohq5Zwtokm1BzwGCxqcaJqZvfzlO+grrpRi4mhBtDZoB8tFjbwEX2acysJV6Ia7N7mTGkbqCm0XuVnvbKynZrpe4Ud5KtHvNx7TAHMmSMTdgSAD1wcQLtyFvlrIzggvX7VSs6lEY6D50ybsB9bFXQK81VoKFoBApUyL6wcfU55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SflNJCiu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708469843; x=1740005843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PoSnWb8232+NWzHCqe4gbktgez5KBoGoPcKcW0/PPBo=;
  b=SflNJCiuaVnXmjaMoJlSJ+o0Mv+OLTq+7YtJfKVzIU1cGlWeUchb+LZs
   kDnUabM9jKrYJHCGtsGcrUCpR+QyW76/MH3UcxhQG6YR6EmR7Ld2baZ8h
   FZLkHfQ2i8frk7Dh3XTUnlPgX9OHJiHCebSCQNhmFUrFmkUx9px88UIov
   DZBWARfgAtKtjNBn/IoiK7bVcR0aPAm891MrgmTrPZBI8fQ+jus7lAPGi
   jX7Od1jB4HXbBmzOlJaSaOJohSr2YPOFBHGP8VjBrCv3xP9/BkRH/U1r3
   j9E2JlF5bUiomNZwXJydj4MdJG/O5TrMYtNPBLeCEClAdBreNX3hDd89U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2486839"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2486839"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 14:57:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="42408294"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 Feb 2024 14:57:11 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcZ2r-0004s8-30;
	Tue, 20 Feb 2024 22:57:06 +0000
Date: Wed, 21 Feb 2024 06:56:02 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	antoniu.miclaus@analog.com, alexandre.belloni@bootlin.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net
Cc: oe-kbuild-all@lists.linux.dev, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v7 1/2] drivers: rtc: add max313xx series rtc driver
Message-ID: <202402210633.wquhPF22-lkp@intel.com>
References: <20240219221827.3821415-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219221827.3821415-2-chris.packham@alliedtelesis.co.nz>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on linus/master v6.8-rc5 next-20240220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Packham/drivers-rtc-add-max313xx-series-rtc-driver/20240220-062057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20240219221827.3821415-2-chris.packham%40alliedtelesis.co.nz
patch subject: [PATCH v7 1/2] drivers: rtc: add max313xx series rtc driver
config: x86_64-randconfig-123-20240220 (https://download.01.org/0day-ci/archive/20240221/202402210633.wquhPF22-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240221/202402210633.wquhPF22-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402210633.wquhPF22-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/rtc/rtc-max31335.c:727:22: sparse: sparse: symbol 'max313xx_clk_init' was not declared. Should it be static?
>> drivers/rtc/rtc-max31335.c:750:21: sparse: sparse: symbol 'max313xx_nvmem_cfg' was not declared. Should it be static?

vim +/max313xx_clk_init +727 drivers/rtc/rtc-max31335.c

   726	
 > 727	struct clk_init_data max313xx_clk_init = {
   728		.name = "max313xx-clkout",
   729		.ops = &max313xx_clkout_ops,
   730	};
   731	
   732	static int max313xx_nvmem_reg_read(void *priv, unsigned int offset,
   733					   void *val, size_t bytes)
   734	{
   735		struct max313xx *rtc = priv;
   736		unsigned int reg = rtc->chip->ram_reg + offset;
   737	
   738		return regmap_bulk_read(rtc->regmap, reg, val, bytes);
   739	}
   740	
   741	static int max313xx_nvmem_reg_write(void *priv, unsigned int offset,
   742					    void *val, size_t bytes)
   743	{
   744		struct max313xx *rtc = priv;
   745		unsigned int reg = rtc->chip->ram_reg + offset;
   746	
   747		return regmap_bulk_write(rtc->regmap, reg, val, bytes);
   748	}
   749	
 > 750	struct nvmem_config max313xx_nvmem_cfg = {
   751		.reg_read = max313xx_nvmem_reg_read,
   752		.reg_write = max313xx_nvmem_reg_write,
   753		.word_size = 8,
   754	};
   755	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

