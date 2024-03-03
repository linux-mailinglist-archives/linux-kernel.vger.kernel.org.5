Return-Path: <linux-kernel+bounces-89942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2476186F7DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EA42814D4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD97B3C3;
	Sun,  3 Mar 2024 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I02XIjyN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9637AE67
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709508573; cv=none; b=KlhxnnFHBNonOkP2HLHvUOq+9NlByrDvCcss6qbfh9QHxe3mHTa8AxRdawjdmSc1+yPJ2UDNWOveqYRMmvisWkYHF4zKiyrIwbc283uazP6QyjGA4ws7PALnNrG11VzLUcKWdCOkMbzrmHaea6Di3WXutQzKCxMQ6Fv0dAU9Ulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709508573; c=relaxed/simple;
	bh=HeUneA9obTz7RjwyEAOPnFHe3ZFcG/qwtodDpDT+duA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Us26/oYe6Zll4IgNQXijqzpF53zwPC3zpeGhgcuahQ+gg8rUDLy1IyBUFSAOvCJVQ9xLaG2+RzOHvLUkmUN4r6s1byJASaa0Ex4/3a5LUpv+AoMf0AjdIvBpI8ijGJAgDswNyQ1HNI2WjFSUulXrve0FE6WiayeJRmtQ0xQQZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I02XIjyN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709508572; x=1741044572;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HeUneA9obTz7RjwyEAOPnFHe3ZFcG/qwtodDpDT+duA=;
  b=I02XIjyNGyhkwv+yf7XV13AFSVegnMrSE7xzggqBeKOELSb/FzeTY0Oy
   PUdzs/jGlPMLGyd8BThiTw5xj8sWWqGHmITMKhJgKc8UUwE4KlqCiUpii
   6DBhvghydk3Wf1nV5dWwQQHZPBlZfVO76asqiqrrECEUqxb59QQo5RiYC
   SDWk0/cYscC1sHHqulU8xrdlw0uJ83fnLtfW2H2fY2Ryh0GU4YdW5Sudx
   XCzIS1dQrwIq9Io+DHA3fJzvVS9HCNpM6tUySnEFCuKzAA2Ax3FoExwoL
   G3TlY7Drkzg+QgLtOJbyJqYNqkhLozQJeOsc4fpAZNs2oebkq9M+la2CP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7803779"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="7803779"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 15:29:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="9370450"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Mar 2024 15:29:30 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgvGp-0002Af-0m;
	Sun, 03 Mar 2024 23:29:27 +0000
Date: Mon, 4 Mar 2024 07:29:22 +0800
From: kernel test robot <lkp@intel.com>
To: Shenghao Ding <13916275206@139.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: WARNING: modpost: "strcpy" [sound/soc/codecs/snd-soc-tas2781-i2c.ko]
 has no CRC!
Message-ID: <202403040744.AiIxkdJG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90d35da658da8cff0d4ecbb5113f5fac9d00eb72
commit: ef3bcde75d06d65f78ba38a30d5a87fb83a5cdae ASoC: tas2781: Add tas2781 driver
date:   9 months ago
config: alpha-randconfig-r062-20231218 (https://download.01.org/0day-ci/archive/20240304/202403040744.AiIxkdJG-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040744.AiIxkdJG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040744.AiIxkdJG-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
WARNING: modpost: vmlinux.o: EXPORT_SYMBOL used for init/exit symbol: page_is_ram (section: .init.text)
WARNING: modpost: EXPORT symbol "strcpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strcat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "strncpy" [fs/reiserfs/reiserfs.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/fuse/fuse.ko] has no CRC!
WARNING: modpost: "strncpy" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "strncpy" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/riva/rivafb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/mmp/fb/mmpfb.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/eeprom/idt_89hpesx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/dax/dax.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/aic7xxx/aic7xxx.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/aic7xxx/aic7xxx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/BusLogic.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/hpsa.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/smartpqi/smartpqi.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/ipr.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/message/fusion/mptctl.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-taos-evm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq24190_charger.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq25980_charger.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq256xx_charger.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/hwmon/pmbus/pmbus_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mmc/core/mmc_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/rpmsg/qcom_glink.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/nvdimm/libnvdimm.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/iio/adc/stm32-adc.ko] has no CRC!
WARNING: modpost: "strcpy" [sound/core/snd.ko] has no CRC!
WARNING: modpost: "strcat" [sound/core/snd.ko] has no CRC!
WARNING: modpost: "strcpy" [sound/core/snd-rawmidi.ko] has no CRC!
WARNING: modpost: "strcpy" [sound/core/seq/snd-seq.ko] has no CRC!
WARNING: modpost: "strcpy" [sound/core/seq/snd-seq-midi.ko] has no CRC!
WARNING: modpost: "strcpy" [sound/pci/hda/snd-hda-codec.ko] has no CRC!
WARNING: modpost: "strncat" [sound/pci/hda/snd-hda-codec.ko] has no CRC!
WARNING: modpost: "strcpy" [sound/pci/hda/snd-hda-codec-generic.ko] has no CRC!
>> WARNING: modpost: "strcpy" [sound/soc/codecs/snd-soc-tas2781-i2c.ko] has no CRC!
WARNING: modpost: "strncpy" [sound/soc/fsl/snd-soc-fsl-micfil.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

