Return-Path: <linux-kernel+bounces-69385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB94885884C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05600B250A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3566148307;
	Fri, 16 Feb 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="midR6Xkd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1D1482F5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120820; cv=none; b=q4LD9//RmbakGrkSH01IrMMV7QSZF+lEqR02Ljn30ShaF+aF9frmegfCT/FZK7jcxiW6nnWWnuKeeONR5jMvYcS6G+Xu5Wp4nMNR4FS0kthMTiRLzrpOrO+MfYr+dl/xxarWB6z4q3FPUJYTDHc8TVY2/+Afwj/1gGlcJwru8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120820; c=relaxed/simple;
	bh=J4IIxXtt+OgzD7+kQFH3KhUlKL9XxEev1TjRoQUA3zE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FeN5tjmyiTHJmNaaSiSR9V3qp99bUjXSrUMXZKPM2MmgZ/fOt1PppJRXscef15fYlixGLTgYTM1BVimDTEaPZgDRqRLu9JrWvRjMC+uztq/6zXOq8kIn66JdPrdI+q8pT/oFsvkq5dArGxOxywIqnjw+BC3Nk/PlZ2ezY7at68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=midR6Xkd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708120818; x=1739656818;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J4IIxXtt+OgzD7+kQFH3KhUlKL9XxEev1TjRoQUA3zE=;
  b=midR6Xkd23C6bJjHPDlyjVEfX4+Jf2l9Em3AcM3KfvYqL6p5fM5JdkPx
   CNKIw4MEr5zJAXliugWHz13N+d9mih/AAmWzA+wnEco+C7OODi9HzMUwA
   BL9ZsYKkSJiANWRrzgFVkJWgL4pDoBQ5I6h3QMEhr5JQ/aF7aLoZ5h2i3
   usiOJf58GucJH7anc/H3SHghLTQBLvq6DMExM3dhPjDcoYYvx1E2YUPAL
   gIRP6P718BJCNWMabctZt04RpNRBrDBkQS4qLks7C28TGHaLG9s3tLL+k
   kxR8wbIfpoY+Ek5Tf6Egn14XUoP+PCVv9u0RCpw779Uy8ZrjnSag+KYi9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2124868"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2124868"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4334016"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 16 Feb 2024 14:00:14 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rb6Fc-0001du-1L;
	Fri, 16 Feb 2024 22:00:11 +0000
Date: Sat, 17 Feb 2024 05:59:50 +0800
From: kernel test robot <lkp@intel.com>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10349:13: error:
 stack frame size (2200) exceeds limit (2048) in 'rt2800_calibration_rt6352'
Message-ID: <202402170517.CsuVrcjo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   683b783c2093e0172738f899ba188bc406b0595f
commit: cca74bed37af1c8217bcd8282d9b384efdbf73bd wifi: rt2x00: rework MT7620 PA/LNA RF calibration
date:   4 months ago
config: x86_64-sof-customedconfig-memory-debug-defconfig (https://download.01.org/0day-ci/archive/20240217/202402170517.CsuVrcjo-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402170517.CsuVrcjo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402170517.CsuVrcjo-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4108:13: error: stack frame size (5496) exceeds limit (2048) in 'rt2800_config_channel' [-Werror,-Wframe-larger-than]
    4108 | static void rt2800_config_channel(struct rt2x00_dev *rt2x00dev,
         |             ^
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:7194:13: error: stack frame size (4760) exceeds limit (2048) in 'rt2800_init_bbp' [-Werror,-Wframe-larger-than]
    7194 | static void rt2800_init_bbp(struct rt2x00_dev *rt2x00dev)
         |             ^
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10693:13: error: stack frame size (8504) exceeds limit (2048) in 'rt2800_init_rfcsr' [-Werror,-Wframe-larger-than]
    10693 | static void rt2800_init_rfcsr(struct rt2x00_dev *rt2x00dev)
          |             ^
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3432:13: error: stack frame size (2264) exceeds limit (2048) in 'rt2800_config_channel_rf55xx' [-Werror,-Wframe-larger-than]
    3432 | static void rt2800_config_channel_rf55xx(struct rt2x00_dev *rt2x00dev,
         |             ^
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10425:13: error: stack frame size (6840) exceeds limit (2048) in 'rt2800_init_rfcsr_6352' [-Werror,-Wframe-larger-than]
    10425 | static void rt2800_init_rfcsr_6352(struct rt2x00_dev *rt2x00dev)
          |             ^
>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10349:13: error: stack frame size (2200) exceeds limit (2048) in 'rt2800_calibration_rt6352' [-Werror,-Wframe-larger-than]
    10349 | static void rt2800_calibration_rt6352(struct rt2x00_dev *rt2x00dev)
          |             ^
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9527:13: error: stack frame size (2648) exceeds limit (2048) in 'rt2800_loft_iq_calibration' [-Werror,-Wframe-larger-than]
    9527 | static void rt2800_loft_iq_calibration(struct rt2x00_dev *rt2x00dev)
         |             ^
   7 errors generated.


vim +/rt2800_calibration_rt6352 +10349 drivers/net/wireless/ralink/rt2x00/rt2800lib.c

 10348	
 10349	static void rt2800_calibration_rt6352(struct rt2x00_dev *rt2x00dev)
 10350	{
 10351		u32 reg;
 10352	
 10353		if (rt2x00_has_cap_external_pa(rt2x00dev) ||
 10354		    rt2x00_has_cap_external_lna_bg(rt2x00dev))
 10355			rt2800_restore_rf_bbp_rt6352(rt2x00dev);
 10356	
 10357		rt2800_r_calibration(rt2x00dev);
 10358		rt2800_rf_self_txdc_cal(rt2x00dev);
 10359		rt2800_rxdcoc_calibration(rt2x00dev);
 10360		rt2800_bw_filter_calibration(rt2x00dev, true);
 10361		rt2800_bw_filter_calibration(rt2x00dev, false);
 10362		rt2800_loft_iq_calibration(rt2x00dev);
 10363	
 10364		/* missing DPD calibration for internal PA devices */
 10365	
 10366		rt2800_rxdcoc_calibration(rt2x00dev);
 10367		rt2800_rxiq_calibration(rt2x00dev);
 10368	
 10369		if (!rt2x00_has_cap_external_pa(rt2x00dev) &&
 10370		    !rt2x00_has_cap_external_lna_bg(rt2x00dev))
 10371			return;
 10372	
 10373		if (rt2x00_has_cap_external_pa(rt2x00dev)) {
 10374			reg = rt2800_register_read(rt2x00dev, RF_CONTROL3);
 10375			reg |= 0x00000101;
 10376			rt2800_register_write(rt2x00dev, RF_CONTROL3, reg);
 10377	
 10378			reg = rt2800_register_read(rt2x00dev, RF_BYPASS3);
 10379			reg |= 0x00000101;
 10380			rt2800_register_write(rt2x00dev, RF_BYPASS3, reg);
 10381		}
 10382	
 10383		if (rt2x00_has_cap_external_lna_bg(rt2x00dev)) {
 10384			rt2800_rfcsr_write_chanreg(rt2x00dev, 14, 0x66);
 10385			rt2800_rfcsr_write_chanreg(rt2x00dev, 17, 0x20);
 10386			rt2800_rfcsr_write_chanreg(rt2x00dev, 18, 0x42);
 10387		}
 10388	
 10389		if (rt2x00_has_cap_external_pa(rt2x00dev)) {
 10390			rt2800_rfcsr_write_chanreg(rt2x00dev, 43, 0x73);
 10391			rt2800_rfcsr_write_chanreg(rt2x00dev, 44, 0x73);
 10392			rt2800_rfcsr_write_chanreg(rt2x00dev, 45, 0x73);
 10393			rt2800_rfcsr_write_chanreg(rt2x00dev, 46, 0x27);
 10394			rt2800_rfcsr_write_chanreg(rt2x00dev, 47, 0xc8);
 10395			rt2800_rfcsr_write_chanreg(rt2x00dev, 48, 0xa4);
 10396			rt2800_rfcsr_write_chanreg(rt2x00dev, 49, 0x05);
 10397			rt2800_rfcsr_write_chanreg(rt2x00dev, 54, 0x27);
 10398			rt2800_rfcsr_write_chanreg(rt2x00dev, 55, 0xc8);
 10399			rt2800_rfcsr_write_chanreg(rt2x00dev, 56, 0xa4);
 10400			rt2800_rfcsr_write_chanreg(rt2x00dev, 57, 0x05);
 10401			rt2800_rfcsr_write_chanreg(rt2x00dev, 58, 0x27);
 10402			rt2800_rfcsr_write_chanreg(rt2x00dev, 59, 0xc8);
 10403			rt2800_rfcsr_write_chanreg(rt2x00dev, 60, 0xa4);
 10404			rt2800_rfcsr_write_chanreg(rt2x00dev, 61, 0x05);
 10405		}
 10406	
 10407		if (rt2x00_has_cap_external_pa(rt2x00dev))
 10408			rt2800_rfcsr_write_dccal(rt2x00dev, 05, 0x00);
 10409	
 10410		if (rt2x00_has_cap_external_lna_bg(rt2x00dev)) {
 10411			rt2800_bbp_write(rt2x00dev, 75, 0x68);
 10412			rt2800_bbp_write(rt2x00dev, 76, 0x4c);
 10413			rt2800_bbp_write(rt2x00dev, 79, 0x1c);
 10414			rt2800_bbp_write(rt2x00dev, 80, 0x0c);
 10415			rt2800_bbp_write(rt2x00dev, 82, 0xb6);
 10416		}
 10417	
 10418		if (rt2x00_has_cap_external_pa(rt2x00dev)) {
 10419			rt2800_register_write(rt2x00dev, TX0_RF_GAIN_CORRECT, 0x36303636);
 10420			rt2800_register_write(rt2x00dev, TX0_RF_GAIN_ATTEN, 0x6c6c6b6c);
 10421			rt2800_register_write(rt2x00dev, TX1_RF_GAIN_ATTEN, 0x6c6c6b6c);
 10422		}
 10423	}
 10424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

