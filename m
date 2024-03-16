Return-Path: <linux-kernel+bounces-105096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C8787D90A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E22F28268D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9199461;
	Sat, 16 Mar 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwMtQL9A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197048F48
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570222; cv=none; b=Q1nsLUpKiqnHPj0FVwTNiyWeBsdmRd8lWxHgVm4IQXVRh/F/ucLpvkqMUZm5gCrJ66SvKMTM2gIc6i/dFGH8kg565dAIkvGkypYYEqSBQMJm4sdx7St8nuaUUl65k4ntEYrfaGgZ0UYQXCCl28OoOhMPVR2DgF9NbDAFAWAQSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570222; c=relaxed/simple;
	bh=kVnvJl9le5ztyFniEU4QMdmByKHLsgfmzxLSM3JHI9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lfevFb+FdzgACqiX17QWhJIOasFIoNOoqMAwOTlv/qs9Z8az0PzP0b8mBHDJ2Z9Rjrch0Jc+xw6DlwyJW0GUDOxSnA1yZ3+4r62UFAye+sS484DPQmqsvDj1RJFc2vJFPEkd3uEnP47fuUPiOpdCzuVfn6Jw2i1ToMcjiSXji2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwMtQL9A; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710570219; x=1742106219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kVnvJl9le5ztyFniEU4QMdmByKHLsgfmzxLSM3JHI9M=;
  b=MwMtQL9A/4yRgr6t7ZshXg6rBZ+ER6t7oknNM8a5+5yqmCJZkyu0x996
   eZbfNggF0PwjxgWH/HWFUChYUsITNYnl2LR7wk+dnU2y2sFsyEx2pxfY/
   4kLKhk6NJGbghCaeh/VR0loqIsMOmC3JjYcG8Oq8vuOr7epx1g8BOuzX3
   ffQHZ0uE3g0+NhbkY93lRpgu1h0cFygePBCm3yQ4UT9SJ7zVpt92Xp/65
   ep+uCiWIGf6gx7KYGPVEyPNpQJSlornYLMc42aJSCV402zrnwf6BGIsrg
   W0QMZ74j4GWOVYmld+NEX19TFTFuQ6MKZpkOeNVQHX2lYeRbXM1YXBGHi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="16853252"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="16853252"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 23:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="12974169"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Mar 2024 23:23:37 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlNSB-000F7x-01;
	Sat, 16 Mar 2024 06:23:35 +0000
Date: Sat, 16 Mar 2024 14:23:34 +0800
From: kernel test robot <lkp@intel.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: ERROR: modpost: "devm_drm_of_get_bridge"
 [drivers/usb/typec/mux/ptn36502.ko] undefined!
Message-ID: <202403161449.bV9MUszO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   66a27abac311a30edbbb65fe8c41ff1b13876faa
commit: 8e99dc783648e5e663494434544bdc5160522de3 usb: typec: add support for PTN36502 redriver
date:   5 months ago
config: riscv-randconfig-r064-20240311 (https://download.01.org/0day-ci/archive/20240316/202403161449.bV9MUszO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161449.bV9MUszO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403161449.bV9MUszO-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/locktorture.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcutorture.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcuscale.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/refscale.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/torture.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_ucs2_utils.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/smb/common/cifs_arc4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/smb/common/cifs_md4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_panel_orientation_quirks.o
ERROR: modpost: "devm_drm_of_get_bridge" [drivers/usb/typec/mux/nb7vpq904m.ko] undefined!
>> ERROR: modpost: "devm_drm_of_get_bridge" [drivers/usb/typec/mux/ptn36502.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

