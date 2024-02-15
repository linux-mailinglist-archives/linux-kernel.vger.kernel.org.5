Return-Path: <linux-kernel+bounces-67665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C24856ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382F91C22928
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1713B79B;
	Thu, 15 Feb 2024 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfaaT220"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCC13B295;
	Thu, 15 Feb 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030086; cv=none; b=uDV5ZV9SX7vb9rxORKtEqJXK9YNCv66/S+OwDUQ7XgGjce+xH/1fCAiMJmYd1OxaFMsQ61hL6/mmkXRQrPa5bTahXueZWe3u6v+I6TXWviqRZPPAmaVmeNZ6fHgkS5uV1jKKd2GEpfwiz3BiR4krvcnKTIuxreFVDPzlJwugWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030086; c=relaxed/simple;
	bh=2HCXSQsU9UnX7lXFl7AHSAP6YihKzbTu9UWh/36f/Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDNcz7Lr+eg+gJNe8ZXcsifNcDck9w0R/wcY+/AF47pAqyhxy/5uM/8uXv+UbW1f0Xn3Pnnpg0oFQK1KxfYBpTvh7Ap+vL72dueaZJMFcg5Ulwfl+1FiJ5NyDEy5DKMOhH2vlTOdZlpCfm0Afn8Vv2xKEtmUO2SR8TRWYb+ZNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfaaT220; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708030083; x=1739566083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2HCXSQsU9UnX7lXFl7AHSAP6YihKzbTu9UWh/36f/Bc=;
  b=LfaaT220aNVsyzZE1C0tHNXnf9MpVixHEQqQ530gbDIse83eR+GtA6p+
   /ZBGeAdvnyAMxJ2ktpO9Vu0PZGoJ29MEwTzZP2bh4sX4dFUYSUkt9Jk9/
   jir4JDQHrlDOIOpzu1sYCIj4ADh8fr+TWBwOvCvpSS/lDkULTMJYDSSDP
   D7GTzdUx09rdeUftVXbQU82l1EGPPFdFKEoVARpBXTxvs2vaFGztDzngp
   AUGUDyaIpz4qmd+uTlkCmsZWzVQ8ZCpddviG9Ozfr80ZoR4V1vn1S/8KH
   W8UdyQ4cbDPQSi2cRFAE0jbFztAadOHeDq2rdMseqp62ljI921KD1zar1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2278658"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2278658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 12:48:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3810566"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 15 Feb 2024 12:47:58 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1raieB-0000lE-28;
	Thu, 15 Feb 2024 20:47:55 +0000
Date: Fri, 16 Feb 2024 04:47:21 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Cc: oe-kbuild-all@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v6 1/5] drm: Stop using `select ACPI_VIDEO` in all drivers
Message-ID: <202402160446.YAlmYBPI-lkp@intel.com>
References: <20240214215756.6530-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214215756.6530-2-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.8-rc4 next-20240215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/drm-Stop-using-select-ACPI_VIDEO-in-all-drivers/20240215-055936
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240214215756.6530-2-mario.limonciello%40amd.com
patch subject: [PATCH v6 1/5] drm: Stop using `select ACPI_VIDEO` in all drivers
config: openrisc-randconfig-r064-20240215 (https://download.01.org/0day-ci/archive/20240216/202402160446.YAlmYBPI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240216/202402160446.YAlmYBPI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402160446.YAlmYBPI-lkp@intel.com/

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/video/fbdev/nvidia/nv_backlight.o: in function `nvidia_bl_init':
>> nv_backlight.c:(.text+0x26c): undefined reference to `backlight_device_register'
>> nv_backlight.c:(.text+0x26c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `backlight_device_register'
   or1k-linux-ld: drivers/video/fbdev/nvidia/nv_backlight.o: in function `nvidia_bl_exit':
>> nv_backlight.c:(.text+0x32c): undefined reference to `backlight_device_unregister'
>> nv_backlight.c:(.text+0x32c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `backlight_device_unregister'
   or1k-linux-ld: drivers/video/fbdev/aty/aty128fb.o: in function `aty128_remove':
>> aty128fb.c:(.text+0x14c): undefined reference to `backlight_device_unregister'
>> aty128fb.c:(.text+0x14c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `backlight_device_unregister'
   or1k-linux-ld: drivers/video/fbdev/aty/aty128fb.o: in function `aty128_init':
>> aty128fb.c:(.text.unlikely+0x5bc): undefined reference to `backlight_device_register'
>> aty128fb.c:(.text.unlikely+0x5bc): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `backlight_device_register'
   or1k-linux-ld: drivers/auxdisplay/ht16k33.o: in function `ht16k33_fbdev_probe':
>> ht16k33.c:(.text+0x17f4): undefined reference to `devm_backlight_device_register'
>> ht16k33.c:(.text+0x17f4): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `devm_backlight_device_register'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FB_BACKLIGHT
   Depends on [n]: HAS_IOMEM [=y] && FB [=y] && BACKLIGHT_CLASS_DEVICE [=n]
   Selected by [y]:
   - HT16K33 [=y] && AUXDISPLAY [=y] && FB [=y] && I2C [=y] && INPUT [=y]
   - FB_ATMEL [=y] && FB [=y] && OF [=y] && HAVE_CLK [=y] && HAS_IOMEM [=y] && (HAVE_FB_ATMEL [=n] || COMPILE_TEST [=y])
   - FB_NVIDIA [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FB_NVIDIA_BACKLIGHT [=y]
   - FB_ATY128 [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FB_ATY128_BACKLIGHT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

