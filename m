Return-Path: <linux-kernel+bounces-67908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80178572DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEE11F2355B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D889DDC1;
	Fri, 16 Feb 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZAAPuDe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A39445;
	Fri, 16 Feb 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044630; cv=none; b=FOPzKkcugP+Rx+rX5XHuB2qsS+Dnd2qy4y2uPovY1Hs5pDNoH9Il7JRhydjMgPAMMTCDxZu83jwcGS44S4XipqYkk0okIPbT8GJiTukL9O/wPW3bm0i3nv7kmntzKX46NSBhbgTSxjz3GMRdAJMjOG86bj4VnU3BkjEIDr0urEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044630; c=relaxed/simple;
	bh=XP0hdLNo06bsjvOGz8495Ni7Q+jI7N7uvHuRX7sdhVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uxs5e2piuRcXhFhyHOBEENA+6g6UYyzGVvfJ5J6ny2011kJ21TOf2cpB/6ouDWZUsQjrm/tDUBU3eT/LfWCdEgqd5th/noR6uWfV176DLQ9sj9IKM3Qu3Z+FJ8dG/WtDhx1OP+fd8RtcN2QcRU7vVkf4cjlYJiHi6zxNVMhIswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZAAPuDe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708044627; x=1739580627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XP0hdLNo06bsjvOGz8495Ni7Q+jI7N7uvHuRX7sdhVU=;
  b=hZAAPuDefuKXH3aPPqksgEQ4DdAkINZMCcwVq1UoNXHsXTe6wnM5tb/t
   YiwHh3tiMSS4BaLIsL3R3/ZtI7NOTHJA73KvmsG8wmSnmh8LHsNu0U3GC
   39lphjvZuds1ggRzLdvVefL5QrRVP4eG9k1n0RezGVf4Z1ffcHnTs1I/3
   hRGaRoVwl0kVs5X6R1yy/PGg1vmRs+nKDGATaCSbE7dj9haqIzxFuvypb
   R6mlzCo2suYSxu0YMlwu0pLA1iFzyWwcJPyjM7Fgy9HfeCOCykSjOPCb7
   Ca3yxI4891vrmuNZWDlU8g6XoRtNuplByPWqBmKmoX6HB4vUGt5aM2vdK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5948563"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="5948563"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 16:50:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="8303317"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 15 Feb 2024 16:50:22 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ramQm-0000sq-20;
	Fri, 16 Feb 2024 00:50:20 +0000
Date: Fri, 16 Feb 2024 08:49:21 +0800
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
Message-ID: <202402160847.FdGsKGjp-lkp@intel.com>
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
config: nios2-randconfig-r061-20240215 (https://download.01.org/0day-ci/archive/20240216/202402160847.FdGsKGjp-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240216/202402160847.FdGsKGjp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402160847.FdGsKGjp-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/video/fbdev/ssd1307fb.o: in function `ssd1307fb_remove':
   ssd1307fb.c:(.text+0x40c): undefined reference to `backlight_device_unregister'
>> ssd1307fb.c:(.text+0x40c): relocation truncated to fit: R_NIOS2_CALL26 against `backlight_device_unregister'
   nios2-linux-ld: drivers/video/fbdev/ssd1307fb.o: in function `ssd1307fb_probe':
   ssd1307fb.c:(.text+0x1d98): undefined reference to `backlight_device_register'
>> ssd1307fb.c:(.text+0x1d98): relocation truncated to fit: R_NIOS2_CALL26 against `backlight_device_register'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FB_BACKLIGHT
   Depends on [n]: HAS_IOMEM [=y] && FB [=y] && BACKLIGHT_CLASS_DEVICE [=n]
   Selected by [y]:
   - FB_SSD1307 [=y] && HAS_IOMEM [=y] && FB [=y] && I2C [=y] && (GPIOLIB [=y] || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

