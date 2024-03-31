Return-Path: <linux-kernel+bounces-125982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A90892EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFBA1C20C65
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8BD8BE2;
	Sun, 31 Mar 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCelxfRY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6279F6;
	Sun, 31 Mar 2024 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711870585; cv=none; b=utSWIt+1PDsj/xCnFU67ffxATHKxu+saRBmS6223AKYcRKVn7mW9asKYCKD5F/ydsDh28BN5x6V0Ujn38eDW+gWQpsYmWVZnQIJsMOoetxi9uXM9LGVZC17TirGrDXg59/GlqOIKzXGqF3V1nfFoYd3MpEhSQefkDDyz37u9Sv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711870585; c=relaxed/simple;
	bh=2FJ006BEJLemfnHq9sEkcgZYK5aGXcw7l0gXyJsqfZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH4R4JVrrxD7HrAcDrDCRm+rbt0RoxN1TepirVCbA7Y0y/Jor7FUS8odqZIOJefoL7tY0BQcSZrJMN3SptukbuORQs6Vw72fVczCxfZqYyyC92z2NKSQCjiGqI2RaOD+9tFmFgHULaQC0TZDqAvFvrQyGv3SVr6UnXdfWoRHItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCelxfRY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711870582; x=1743406582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2FJ006BEJLemfnHq9sEkcgZYK5aGXcw7l0gXyJsqfZU=;
  b=KCelxfRY2jReKV4vK7od7wTEA5xSjl18jMuPVSDk9DUrAAQv618ccb/+
   JNanVMtOiSxo82gjVF0SVypHl6H4Rg+1RVR/LkcU5r4Ej8TYMBwbYdHOe
   pxq2VDEmVOMHv0k+AIE9QiuATdUpXQMwqQgwlpnFRj40YoVG7W45FWq5D
   4yszmFb6bScWI0L5YY4J0F/1cGnVqk2SCEUjZJTLbXESIlskEZ1ruegD+
   VbKXulm8iHuUWjN2I9hbOXe2Uw20jP+mlAnsBU1f+KObw9nRYSoK5GRGg
   DKPKwEJcKp+wIgkGeQOfI5OHijRXO1c4U/6YnDULmDUUtxX83cWcjvp0W
   Q==;
X-CSE-ConnectionGUID: boeED+VRS/WFvhNvBcpxQw==
X-CSE-MsgGUID: TJoUbWT6QwGKNGPHANG2uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="7136288"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="7136288"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 00:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="40537962"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 31 Mar 2024 00:36:19 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqpjk-0000u2-2N;
	Sun, 31 Mar 2024 07:36:16 +0000
Date: Sun, 31 Mar 2024 15:35:49 +0800
From: kernel test robot <lkp@intel.com>
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, broonie@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com, Piyush Malgujar <pmalgujar@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>
Subject: Re: [PATCH 4/5] driver: spi: cadence: Add ACPI support
Message-ID: <202403311503.5rYNyUzp-lkp@intel.com>
References: <20240329194849.25554-5-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329194849.25554-5-wsadowski@marvell.com>

Hi Witold,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Witold-Sadowski/spi-cadence-Add-new-bindings-documentation-for-Cadence-XSPI/20240330-035124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240329194849.25554-5-wsadowski%40marvell.com
patch subject: [PATCH 4/5] driver: spi: cadence: Add ACPI support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240331/202403311503.5rYNyUzp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240331/202403311503.5rYNyUzp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403311503.5rYNyUzp-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-cadence-xspi.c: In function 'mrvl_ioreadq':
   drivers/spi/spi-cadence-xspi.c:535:14: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     535 |         if (((uint64_t)buf % 8) == 0) {
         |              ^
   drivers/spi/spi-cadence-xspi.c:537:36: error: implicit declaration of function 'readq'; did you mean 'readb'? [-Werror=implicit-function-declaration]
     537 |                         *buf64++ = readq(addr);
         |                                    ^~~~~
         |                                    readb
   drivers/spi/spi-cadence-xspi.c: In function 'mrvl_iowriteq':
   drivers/spi/spi-cadence-xspi.c:559:14: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     559 |         if (((uint64_t)buf % 8) == 0) {
         |              ^
   drivers/spi/spi-cadence-xspi.c:561:25: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     561 |                         writeq(*buf64++, addr);
         |                         ^~~~~~
         |                         writel
   drivers/spi/spi-cadence-xspi.c: In function 'cdns_xspi_setup':
   drivers/spi/spi-cadence-xspi.c:869:43: error: implicit declaration of function 'spi_master_get_devdata'; did you mean 'spi_mem_get_drvdata'? [-Werror=implicit-function-declaration]
     869 |         struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(spi_dev->master);
         |                                           ^~~~~~~~~~~~~~~~~~~~~~
         |                                           spi_mem_get_drvdata
   drivers/spi/spi-cadence-xspi.c:869:73: error: 'struct spi_device' has no member named 'master'
     869 |         struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(spi_dev->master);
         |                                                                         ^~
   drivers/spi/spi-cadence-xspi.c: At top level:
>> drivers/spi/spi-cadence-xspi.c:993: error: unterminated #ifdef
     993 | #ifdef CONFIG_OF
         | 
   cc1: some warnings being treated as errors


vim +993 drivers/spi/spi-cadence-xspi.c

   986	
   987	static const struct acpi_device_id cdns_xspi_acpi_match[] = {
   988		{"cdns,xspi-nor", 0},
   989		{"mrvl,xspi-nor", 0},
   990		{},
   991	};
   992	MODULE_DEVICE_TABLE(acpi, cdns_xspi_acpi_match);
 > 993	#ifdef CONFIG_OF
   994	static const struct of_device_id cdns_xspi_of_match[] = {
   995		{
   996			.compatible = "cdns,xspi-nor",
   997		},
   998		{
   999			.compatible = "mrvl,xspi-nor",
  1000		},
  1001		{ /* end of table */}
  1002	};
  1003	MODULE_DEVICE_TABLE(of, cdns_xspi_of_match);
  1004	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

