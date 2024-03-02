Return-Path: <linux-kernel+bounces-89545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F72986F1D3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB31A2823F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC62CCAD;
	Sat,  2 Mar 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HegcN9C2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEB2C697
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709403419; cv=none; b=pk14Tip7TMuC/5uaduNXjPqfQC3JfvYNEXjjKlA9YxKK4M+cCPz1e+wPs4pEhZ1EO3sQ920hd5yEC5smqgQdw2YGSmL8q9Vjjwhto1EahRYE9/P/UTYh2qWWqTGRFA8zy+9EDDP9OXYRe8pr6Acpq4M7QW5dvRVoTjP7ptawluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709403419; c=relaxed/simple;
	bh=dhpC1z1VlOjYv5PCibNXLQn4/9V+7BuN441NiWBMd68=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KN0TlcpPw/qxOGk8tXnpUIu9nXgWrcQHa4mc9v5lwJW4BXD4Hh22ML29Va2H9Y3SN0b/VuyQJm/VPDEearMbAKgRHFgLLLgzuQRkG2/GaZeOjQEMS9w906SOBQk6s6PB7j/t1L+2agieM7a4ow+VrY3lO25b6wkDH0o31ly26Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HegcN9C2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709403418; x=1740939418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dhpC1z1VlOjYv5PCibNXLQn4/9V+7BuN441NiWBMd68=;
  b=HegcN9C22YDjJfzUYiwd5BMYErKollyhPityRkTEcEgXsPtnfi00Omc8
   WBmumuAyk+w5SPOrgkAJFI/GpNkQmf1GbV5jbjuYglTFbJRXaB7YrGqnx
   XPuhhEOl3MPZA+lZERDym6u1b0LyIImMFgFcJk7egatDQ/M+eb3L2HFbR
   dWIf9wEIqC8ySJGOwqAO48ep9tNd7nb841GQqPJVreV4ZOC2TtzVZaY7z
   txqk+4vyVi9mppn9Uu4qQJMW6tInav7g1JKtEY1/GcAUfNlz6n+uTtVU5
   dWlw1ln+ZDSUw+meC7ElCOvkz/DiVcdpNsC4ETx4lMRmlioCNi9VCHay/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="14510789"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="14510789"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 10:16:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8755118"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2024 10:16:56 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgTuo-0000DI-06;
	Sat, 02 Mar 2024 18:16:54 +0000
Date: Sun, 3 Mar 2024 02:16:31 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: "strncat" [lib/strcat_kunit.ko] has no CRC!
Message-ID: <202403030236.qOy0rBIN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ad3cb0ed525b80c7f66c32b49a68c1f3510bec9
commit: 3bf301e1ab85e18ed0e337ce124dc71d6d7b5fd7 string: Add Kunit tests for strcat() family
date:   10 months ago
config: alpha-randconfig-r024-20230814 (https://download.01.org/0day-ci/archive/20240303/202403030236.qOy0rBIN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240303/202403030236.qOy0rBIN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403030236.qOy0rBIN-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux.o: EXPORT_SYMBOL used for init/exit symbol: page_is_ram (section: .init.text)
WARNING: modpost: EXPORT symbol "strcpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strcat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "strcpy" [fs/ecryptfs/ecryptfs.ko] has no CRC!
WARNING: modpost: "strncpy" [fs/ecryptfs/ecryptfs.ko] has no CRC!
WARNING: modpost: "strncpy" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "strncat" [lib/kunit/kunit.ko] has no CRC!
>> WARNING: modpost: "strncat" [lib/strcat_kunit.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/mmp/fb/mmpfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/char/ipmi/ipmi_msghandler.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/char/ipmi/ipmi_watchdog.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/tty/n_gsm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/base/regmap/regmap-kunit.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/nfc/pn544/pn544_i2c.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mtd/devices/phram.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mtd/nand/raw/r852.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/usb/misc/usbsevseg.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/input/rmi4/rmi_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq24190_charger.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mmc/core/mmc_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/crypto/cavium/nitrox/n5pf.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/hid/uhid.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/test/iio-test-rescale.ko] has no CRC!
WARNING: modpost: "strcpy" [net/bluetooth/bluetooth.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

