Return-Path: <linux-kernel+bounces-125965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CD1892EB7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2001F21BAB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AED6FD5;
	Sun, 31 Mar 2024 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMuj82PN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE216ABA
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711865001; cv=none; b=J0Mmi5ytIHPg133eh5EIpZvc5ycSon/IGng1i+lpY0AgFIIPt8L2xf0zuA1aVRHO7f49oCIqxghkkApeTusi+trU8CrFHH9Vf3L2bn7n2jVgLzQAEoAcuVnC3fbaBSNBrH5B4kNMQlmzJP0OcN9s484Cw0n+H+ejLN9PvIz/OCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711865001; c=relaxed/simple;
	bh=nRQtuk+65XZXJMoGM5MuO3DPUwYoug1VdmDCSRXswN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ii00dF0fQcjiPdrbWiSm7aijbuq+AMT48rOpi5YmPI+hsLNUjsxUI8jeqUdAqXZNzOiMS5AA6fVW5yGfh1EXiDkvhjtebhj3ZE2qnzwuL9vOeoBXcAxRYR57WMZV6Ojod1Quno+LtOteb/8b7mG3INGFVRSQKG8u15ocdiAlGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMuj82PN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711865000; x=1743401000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nRQtuk+65XZXJMoGM5MuO3DPUwYoug1VdmDCSRXswN4=;
  b=RMuj82PNmN00zgJ7bK0bA8mcaZqR0mN4Lqe0GyKelsEVyLJUXx69CkyG
   WEmB+7l59rhc514+Foc1WG/SRrJapqs0e46E7hejJFZZ3eg1Jl4K2NU38
   0aUXzrZiJJCyjI0zsGhbzXjsP5wHhmX+N6Y0kZeP/fdxqvC/BWtsisAaW
   K6FMXxM5c8cfUhtwRblAGIBJamjsREcpXVNFsMsP8Z2mJ4BKp5TRCwj0f
   QdG89qqo/N3bE7SDhK4muV4p1w23DXLwTnDO+KDK1VfzsXXhQzl9Mmeor
   fjzOfUDnDqMtrBtTFpfjWjDUJ3XJIM716B/4YnwnW10r5lgi2JAFWlu6u
   A==;
X-CSE-ConnectionGUID: 7Wxf82TTR0aR2Mv98Cyuxg==
X-CSE-MsgGUID: 6F6rYypGSyGl0OpwKuowDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="6861504"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="6861504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 23:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="54831833"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Mar 2024 23:03:17 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqoHj-0000qw-0S;
	Sun, 31 Mar 2024 06:03:15 +0000
Date: Sun, 31 Mar 2024 14:02:26 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/power/domain_governor.c:409: warning: cannot understand
 function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '
Message-ID: <202403311326.Dr2HlMYm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Huacai,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   712e14250dd2907346617eba275c46f53db8fae7
commit: 366bb35a8e48198cefcd3484ac6b2374d1347873 LoongArch: Add suspend (ACPI S3) support
date:   1 year, 4 months ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20240331/202403311326.Dr2HlMYm-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240331/202403311326.Dr2HlMYm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403311326.Dr2HlMYm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/power/domain_governor.c:409: warning: cannot understand function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '
--
>> drivers/base/power/runtime.c:365: warning: Excess function parameter 'dev' description in '__rpm_callback'

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/nvs.c:140:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *kaddr @@
   drivers/acpi/nvs.c:140:54: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/nvs.c:140:54: sparse:     got void *kaddr
>> drivers/acpi/nvs.c:143:66: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got void *kaddr @@
   drivers/acpi/nvs.c:143:66: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/nvs.c:143:66: sparse:     got void *kaddr
>> drivers/acpi/nvs.c:182:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *kaddr @@     got void [noderef] __iomem * @@
   drivers/acpi/nvs.c:182:38: sparse:     expected void *kaddr
   drivers/acpi/nvs.c:182:38: sparse:     got void [noderef] __iomem *
   drivers/acpi/nvs.c:184:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *kaddr @@     got void [noderef] __iomem * @@
   drivers/acpi/nvs.c:184:46: sparse:     expected void *kaddr
   drivers/acpi/nvs.c:184:46: sparse:     got void [noderef] __iomem *
--
>> drivers/acpi/sleep.c:556:46: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/acpi/sleep.c:656:50: sparse: sparse: restricted suspend_state_t degrades to integer
--
>> kernel/power/main.c:133:34: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:133:38: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:134:21: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:134:26: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:136:38: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:137:62: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:133:55: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:162:38: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:162:46: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:163:54: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:162:67: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:182:31: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:182:36: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:188:13: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:188:21: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:188:39: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:188:47: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:579:34: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:579:38: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:580:31: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:581:57: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:579:55: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:608:38: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:608:46: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:609:47: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:608:67: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:629:31: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:629:36: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:635:13: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:635:21: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:703:31: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/main.c:703:36: sparse: sparse: restricted suspend_state_t degrades to integer

vim +409 drivers/base/power/domain_governor.c

e59a8db8d9b7c0 Rafael J. Wysocki 2012-01-14  405  
925b44a273aa8c Mark Brown        2011-12-08  406  /**
925b44a273aa8c Mark Brown        2011-12-08  407   * pm_genpd_gov_always_on - A governor implementing an always-on policy
925b44a273aa8c Mark Brown        2011-12-08  408   */
925b44a273aa8c Mark Brown        2011-12-08 @409  struct dev_power_governor pm_domain_always_on_gov = {

:::::: The code at line 409 was first introduced by commit
:::::: 925b44a273aa8c4c23c006c1228aacd538eead09 PM / Domains: Provide an always on power domain governor

:::::: TO: Mark Brown <broonie@opensource.wolfsonmicro.com>
:::::: CC: Rafael J. Wysocki <rjw@sisk.pl>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

