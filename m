Return-Path: <linux-kernel+bounces-110780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3618863DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71421C21D09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5E8F41;
	Thu, 21 Mar 2024 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NR/TkZOY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2D79EA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711062546; cv=none; b=WanosBI0rmuaxyeY9TrF4bWYR1e9wuWjlTSCJS0w2OnG2BQyEK3pxh0lc9Ygz/U3TLue3lc/a4pAqpmeC3dyYRtZUc8qh5TYcl6zlIARRUOtLwveh++1vdi3QJJUGGXZgROUnXRwGCZBgh3SrGK+zXvzMLNHLOFAjuciZzZIM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711062546; c=relaxed/simple;
	bh=VC3pbG80ztHyTQTavsPSO9OC8/VLuzg2xJ41/Q0N3oI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Abczt3E4QdbPc9W4woSNqsDH4UFnXlUV1JUPr8ZWtssXdqqTzba1kS4DsohtI/WvKhoBRn2FsvJbjgI3Ow0r/220m89haMEYegu977wjfaUv0RRed6WougCnHthCY/HFvAFwTs45vvk/Pb9qHY9F5ivu1mtkWfG5+i88qaZUB+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NR/TkZOY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711062545; x=1742598545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VC3pbG80ztHyTQTavsPSO9OC8/VLuzg2xJ41/Q0N3oI=;
  b=NR/TkZOY9buz5xzOVHwBn35cFYo8t+x14B9yDiiFuD9gQ0RCv2OTSmdO
   BDQKPn7Rkgvvik6PYn/fU/OvfTVWnpKWxQwch48o/eRf2egHKrQx9aDIY
   eeUU7E0PoBSiqY3jZB47+np4Hr8fCjIw9jDM477UOJx4f3stBKy/JM8xc
   aIPywv9EjgRD8tRfZYaW4bHKcqN9Q2Q06TqL9NvNpIOWwyclb6f33M9oh
   +gEkguC3IYQ0Yaq3ozC7id0JBru9xhWWCOAeCRTYKqNVjUsgw7d1T+h4t
   /maHdYkDTUOa7cc2I2funTDGuJpUE1xZhoabU77c4/33Z5YcKMjQlZoNb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28563992"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="28563992"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 16:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="14654702"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Mar 2024 16:09:03 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnRWu-000JqV-2b;
	Thu, 21 Mar 2024 23:09:00 +0000
Date: Fri, 22 Mar 2024 07:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 run_tracer_selftest+0x2c0 (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
Message-ID: <202403220757.MP0We5ui-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ebc9bee8814d12ec247de117aa2f7fd39ff11127
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   8 months ago
config: xtensa-randconfig-r024-20220805 (https://download.01.org/0day-ci/archive/20240322/202403220757.MP0We5ui-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240322/202403220757.MP0We5ui-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403220757.MP0We5ui-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: run_tracer_selftest+0x2c0 (section: .text.unlikely) -> initcall_level_names (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

