Return-Path: <linux-kernel+bounces-105291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778A87DB7F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 22:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F96B20F6D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607901C29C;
	Sat, 16 Mar 2024 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxuX205x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD691B963
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710622985; cv=none; b=Y4lJ7ool1PvK4vHij0Uac+9bUUv8EHcmIzoH8H8cc7dEVnvCGqOkJ9T2a29xNMMUJwejvb85p8qmsMfYthZ/ga371XbTVr+G+WU0S1alP3EXhufLNK1CIvDNwFW8KbAOafX3A4GRhDauTBBBDqRR8saBXjjmA3aiFPzrMU8Px2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710622985; c=relaxed/simple;
	bh=ep8ng0EMepdKqhDXbuRbakvfW/MJX+ehU8XZhvIjkis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AisyoDHSyzq5+sNSFQ/66a69GKERP412rr97VE5FXQ7luFz/uwRESMqHnAHLKHCX/SnqqJGrADTccHr+bKWKBrWB42H4BPsyPc9rj3t0Ep/nIRKptkRA55ZA1emlV61Gdm0UDJ/wWlzkrceV1YFom3zkJkjy7raNZcA3mAKYSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxuX205x; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710622983; x=1742158983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ep8ng0EMepdKqhDXbuRbakvfW/MJX+ehU8XZhvIjkis=;
  b=CxuX205xjn+knFB2bc5MfJEE6StGNbJXw1J8M/U8HUTkJQJJXfI/bkjF
   /Bv/AAhz5jZJkC88T4ZfwVRQpGtb8o1untTWCpstQgUE6IKVZJ0DetnQi
   eKwOCCNn6b9YUfKAZMjIXMzfaDyr3tU5yHa4tj19YaYbSDhNaeBUHbc8I
   DxnJHpB4tpsCJfikjJ2RHbH/32afkkLRq6b3BArYxZQtnMjlZfP5DG1LF
   tuSBoBdQtL+u76e5kzdKLys/SOU0dpZYD2wF44xPmdgLS/DwBQ066cNDV
   8owieVLmiBkp4n2cmS0j3W4EEdg+zVtfsm2u9k9I1EmQWeZBCG8+ia3Ux
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11015"; a="30914123"
X-IronPort-AV: E=Sophos;i="6.07,131,1708416000"; 
   d="scan'208";a="30914123"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 14:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,131,1708416000"; 
   d="scan'208";a="12967723"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Mar 2024 14:03:01 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlbBC-000FmX-2E;
	Sat, 16 Mar 2024 21:02:58 +0000
Date: Sun, 17 Mar 2024 05:02:24 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: ERROR: modpost: "devm_drm_of_get_bridge"
 [drivers/gpu/drm/bridge/aux-bridge.ko] undefined!
Message-ID: <202403170446.90iKtaVS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1f10ac840caced7a9f717d4170dcc14b3fac076
commit: c5d296bad640b190c52ef7508114d70e971a4bba usb: typec: nb7vpq904m: switch to DRM_AUX_BRIDGE
date:   3 months ago
config: riscv-randconfig-r064-20240311 (https://download.01.org/0day-ci/archive/20240317/202403170446.90iKtaVS-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240317/202403170446.90iKtaVS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403170446.90iKtaVS-lkp@intel.com/

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
>> ERROR: modpost: "devm_drm_of_get_bridge" [drivers/gpu/drm/bridge/aux-bridge.ko] undefined!
ERROR: modpost: "devm_drm_of_get_bridge" [drivers/usb/typec/mux/ptn36502.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

