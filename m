Return-Path: <linux-kernel+bounces-127312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF8689497D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370ED2865B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA6111A3;
	Tue,  2 Apr 2024 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXasRHP3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF62CA9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 02:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712025497; cv=none; b=U8BAbthcKsMoQnlF/rLKtSNAASj8G3GkGBgOXTv/lw2ZhPJeUfrmlrCC8kH7pnND3zr8cUjiQTWBSzTNZaXw93i7Ev2A3jl/h6Zc/7R10oRuM+TrsuWhCTH6zPkM15bpzwkTfLnrsPtFD5kbm9yu4PEFBlOzZosu0bp3z5VZNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712025497; c=relaxed/simple;
	bh=B0YkMpIL4lKGk1VzcKjuprcKufsRcCXzLubl9FFRhJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZiaLzbertnD7RpHMlf1B0Y0CeL0pRWmFUcUj07w93AciS0KwMVdYQRwNORqgI8IfNcHG/6U1N1BaoTuOr+uI+6CeOQFONMm5gB1Ji+L6WCAS6f7C6HVeD6xh2rd6FyhCiqKbIW+C4GvlBOqvjQqC5AXO5s57nKmLVl9Pjvp1+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXasRHP3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712025496; x=1743561496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B0YkMpIL4lKGk1VzcKjuprcKufsRcCXzLubl9FFRhJk=;
  b=DXasRHP35kCawQpnRScLA145cndRc6fHpLuLFoXmbyyK4f80vlOMew+O
   PKqC6VYacGyIvP0n7vWg5O9uXi8u3hsYe7xrsVCKtir208rhWjLq3dEya
   SjeZp+x27RBo7LFNH3dryANNjvQOXjoOt8s6WaRdAGKNy3eQ3U5/+7QJl
   6TAp+Xm8U1XU17cNbHfjfCw6ZYmyi4SRVggwOtMOFDaTJ7u3FgPZ7DqLP
   7VNw5XQCzgss/D826j7nGby30O0lg9yzablO4Nj9yPKD0mPMsxLkm9T7u
   XZRZy/49PHwRHTM0YCNNidQ6fAPAM39ikpSnsa/48c9GaoTV+Ukp8ivHC
   A==;
X-CSE-ConnectionGUID: U+0PHhcCSpSR3IuE4XePkg==
X-CSE-MsgGUID: EsAq/pLaT2izHb4LmZmcAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10956752"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="10956752"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18365985"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 01 Apr 2024 19:38:14 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrU2N-0000nz-0k;
	Tue, 02 Apr 2024 02:38:11 +0000
Date: Tue, 2 Apr 2024 10:38:07 +0800
From: kernel test robot <lkp@intel.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to
 restricted __le16
Message-ID: <202404021016.m87bJk3A-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   026e680b0a08a62b1d948e5a8ca78700bfac0e6e
commit: 43e9082fbccc7df8b2028c1ba040c58cefda703f leds: turris-omnia: Add support for enabling/disabling HW gamma correction
date:   5 months ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20240402/202404021016.m87bJk3A-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240402/202404021016.m87bJk3A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404021016.m87bJk3A-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/leds/leds-turris-omnia.c:438:15: sparse: sparse: cast to restricted __le16
   drivers/leds/leds-turris-omnia.c:446:16: sparse: sparse: cast to restricted __le16

vim +438 drivers/leds/leds-turris-omnia.c

   426	
   427	static int omnia_mcu_get_features(const struct i2c_client *client)
   428	{
   429		u16 reply;
   430		int err;
   431	
   432		err = omnia_cmd_read_raw(client->adapter, OMNIA_MCU_I2C_ADDR,
   433					 CMD_GET_STATUS_WORD, &reply, sizeof(reply));
   434		if (err < 0)
   435			return err;
   436	
   437		/* Check whether MCU firmware supports the CMD_GET_FEAUTRES command */
 > 438		if (!(le16_to_cpu(reply) & STS_FEATURES_SUPPORTED))
   439			return 0;
   440	
   441		err = omnia_cmd_read_raw(client->adapter, OMNIA_MCU_I2C_ADDR,
   442					 CMD_GET_FEATURES, &reply, sizeof(reply));
   443		if (err < 0)
   444			return err;
   445	
   446		return le16_to_cpu(reply);
   447	}
   448	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

