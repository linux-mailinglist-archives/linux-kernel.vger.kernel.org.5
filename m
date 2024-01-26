Return-Path: <linux-kernel+bounces-39639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A883D415
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0792B21AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9F7C13C;
	Fri, 26 Jan 2024 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARQLuq95"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF70DBE68
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706248657; cv=none; b=l6Vg3ZP86jMEtgbbOJ7a4NqUZ87CNwLY7vmPf1r4b1DQ7RvzfTyUURxiafzls4DThcYaPi4fu4xoU3SfSJm5Bw3wCzr+Su6qpEtc6X61ibadUrSolr8IWaZQd08/Ma31zgfUWeaRaT3pEkAVp3jjVJYjrtnOSK1d5bw786kj3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706248657; c=relaxed/simple;
	bh=TF+C4A4M7xLpdMDvQq5bFg4l4drwc/OMM+vq+4keBuA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q+MBoLvTQWCG/3s7I3QRksaUKUKuwIHCO9N7k6LdeuZrI473NYc2pdMfGCWa5sD/mNRyd8aAGTmzD2OgJtwO4WT4OyFBAyvZKTBHoVZ7XVVjy6WLyHvqC3yGJFKZQlExMPMXr7S1ksNEIb7k8PJHqqtov7neLhKi65xcyXiqamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARQLuq95; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706248656; x=1737784656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TF+C4A4M7xLpdMDvQq5bFg4l4drwc/OMM+vq+4keBuA=;
  b=ARQLuq9541F/mws4BFQCphiLwFdyYuc7y2erhr0+9jwzOY+Fx6fl4ZXg
   XZr1j9Wue6yGPq22lnlyq1baLZmHTvbIZ17/pJwlkqSRbcs8qw05V2HX2
   SkqKX9ihlbHOwe0yOTO0HtO3MdybjMk6VwQtKIgwxf5YK17Y2jp/vT7wR
   XqhI1QPVovw3k8V/+CsYkEhO7vN3Wxm71CcZ+WIb1r1OyLlMmqHiyNSRk
   RcAA/QsDj/KTnmoKRpgwEVWNSO8b3pFkZbdPAo3EPTWc0CMNnBzRNNF04
   dViEQSiko3veCmd3ZELGMcr0xTSoFZh/+0q11HSHRKT25w3dJj0b4myrp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9077537"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9077537"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 21:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1118172425"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1118172425"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2024 21:57:33 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTFDX-0000kC-2Q;
	Fri, 26 Jan 2024 05:57:31 +0000
Date: Fri, 26 Jan 2024 13:57:10 +0800
From: kernel test robot <lkp@intel.com>
To: James Schulman <james.schulman@cirrus.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: versioncheck: ./sound/soc/codecs/cs42l42.c: 18 linux/version.h not
 needed.
Message-ID: <202401261331.HaHQneXf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
commit: 2c394ca79604b404fe60218670ab301ecb758b34 ASoC: Add support for CS42L42 codec
date:   7 years ago
reproduce: (https://download.01.org/0day-ci/archive/20240126/202401261331.HaHQneXf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261331.HaHQneXf-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -Wformat-overflow -Wformat-truncation -Wstringop-overflow -Wrestrict -Wenum-conversion W=1 --keep-going HOSTCC=gcc-12 CC=gcc-12 -j28 KBUILD_MODPOST_WARN=1 ARCH=x86_64 versioncheck
   scripts/kconfig/conf  --silentoldconfig Kconfig
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./arch/arm64/kernel/hibernate.c: 25 linux/version.h not needed.
   ./drivers/block/rsxx/rsxx_priv.h: 28 linux/version.h not needed.
   ./drivers/block/skd_main.c: 37 linux/version.h not needed.
   ./drivers/firmware/efi/test/efi_test.c: 11 linux/version.h not needed.
   ./drivers/i2c/busses/i2c-brcmstb.c: 25 linux/version.h not needed.
   ./drivers/i2c/busses/i2c-xgene-slimpro.c: 33 linux/version.h not needed.
   ./drivers/media/media-device.c: 900: need linux/version.h
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h: 19 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c: 34 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c: 23 linux/version.h not needed.
   ./drivers/mtd/nand/brcmnand/brcmnand.c: 15 linux/version.h not needed.
   ./drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c: 24 linux/version.h not needed.
   ./drivers/net/ethernet/cavium/liquidio/lio_main.c: 22 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qed/qed_l2.c: 22 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qed/qed_ll2.c: 18 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qed/qed_main.c: 13 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede.h: 12 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_ethtool.c: 9 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_main.c: 11 linux/version.h not needed.
   ./drivers/net/ethernet/qualcomm/qca_7k.c: 30 linux/version.h not needed.
   ./drivers/net/usb/lan78xx.c: 17 linux/version.h not needed.
   ./drivers/scsi/cxgbi/libcxgbi.h: 27 linux/version.h not needed.
   ./drivers/staging/greybus/light.c: 15 linux/version.h not needed.
   ./drivers/staging/ks7010/ks_wlan.h: 17 linux/version.h not needed.
   ./drivers/staging/lustre/lustre/include/lustre/lustre_user.h: 48 linux/version.h not needed.
   ./drivers/staging/media/s5p-cec/s5p_cec.c: 25 linux/version.h not needed.
   ./drivers/staging/media/s5p-cec/s5p_cec.h: 25 linux/version.h not needed.
   ./drivers/staging/media/st-cec/stih-cec.c: 19 linux/version.h not needed.
   ./drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c: 40 linux/version.h not needed.
   ./drivers/watchdog/ziirave_wdt.c: 30 linux/version.h not needed.
   ./include/linux/qed/qed_ll2_if.h: 18 linux/version.h not needed.
   ./samples/bpf/sampleip_kern.c: 7 linux/version.h not needed.
   ./samples/bpf/trace_event_kern.c: 8 linux/version.h not needed.
   ./samples/mic/mpssd/mpssd.c: 40 linux/version.h not needed.
>> ./sound/soc/codecs/cs42l42.c: 18 linux/version.h not needed.
   ./tools/perf/tests/bpf-script-example.c: 48: need linux/version.h
   ./tools/perf/tests/bpf-script-test-kbuild.c: 21: need linux/version.h
   ./tools/perf/tests/bpf-script-test-prologue.c: 35: need linux/version.h
   ./tools/perf/tests/bpf-script-test-relocation.c: 50: need linux/version.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

