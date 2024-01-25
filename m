Return-Path: <linux-kernel+bounces-39378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5566983CFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364871C23246
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CDA11CB1;
	Thu, 25 Jan 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWaYCSuU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9E10A3B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223149; cv=none; b=jFDoHxtJGYhsTCsjxfo6s/BYfHMeZux6sGHf1KNDUqqTVxUIxJ7gU/EHn04RItrvyGeaIvxskh9UcxEW2RFyfvSpm1vgYBpW120Vvqv+Uu2/5fe/knqmsSTzbaw1dIseCYKfm9TRxwiyphzAU6uS7TvnPReoTRRvt1/G0t3O+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223149; c=relaxed/simple;
	bh=RvKmfO1R7GNayAPRD/6Wd0l8BRL4dFDHykXLHGppS4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XIRh/iKRuZH8m/q4EPnGT1xngzsNDI0XAvV7s3xhZSKbI2bQXcnEU6SlxcJ2ZajwZ++n8a8NUPzQnY7RipbFB6eIlw0M5649tnkembk4bNXR+Pwv0GyXqeoB5gUel15trrPfuHTuSwuFtiz8FEnWDZ+wrBOx4TcN0Lq+2SqCxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWaYCSuU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706223146; x=1737759146;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RvKmfO1R7GNayAPRD/6Wd0l8BRL4dFDHykXLHGppS4g=;
  b=cWaYCSuUD7pXmPJclphBFjV7BmEcwg7/vSixVIpSPAniuT7R+bLKSFZG
   aOzyygrHR7aae1UkpU7NzAVWM3J50i6IILqx+pP0XcDbUUXj174IEXhXf
   2FQMugL/afL6gbjx3c3KvvNMw/++dhoLNrM7Ws6BP8RKJDKADpD/7fK/5
   2S5D2J+FSIIfkPyJloR6yF5dJXKf9O8s8ZwI7abaHS+KdtmIDMwcP9zcU
   8IZVZLSM9CGs+WsSSE0Nvc7HSsr3Hj0dc7NVkPx5fR6cC6EO7LZ3+WIav
   tCJWj8V6muwCinL845vVWXfftiZApwomITPggVxkHDxGKAuT86LqMAIK+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2195593"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2195593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 14:52:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="820948030"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820948030"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2024 14:52:23 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT8a5-0000TE-0A;
	Thu, 25 Jan 2024 22:52:21 +0000
Date: Fri, 26 Jan 2024 06:52:01 +0800
From: kernel test robot <lkp@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 vega20_enable_dpm_tasks.part.0+0x2cc (section: .text) -> (unknown) (section:
 .init.text)
Message-ID: <202401260626.nE6j5ZwR-lkp@intel.com>
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
commit: dff745c1221a402b4921d54f292288373cff500c fs: move cleanup from init_file() into its callers
date:   7 months ago
config: riscv-randconfig-r026-20230716 (https://download.01.org/0day-ci/archive/20240126/202401260626.nE6j5ZwR-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401260626.nE6j5ZwR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401260626.nE6j5ZwR-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate_single_gfx_level+0x164 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate_single_gfx_level+0x168 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate_single_gfx_level+0x170 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate_single_soc_level+0x4e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate_single_soc_level+0x5a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate_single_soc_level+0x5e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate_single_soc_level+0x74 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate_single_soc_level+0xbc (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega10_populate_single_soc_level+0xc8 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega10_print_clock_levels+0x50a (section: .text) -> $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: phm_get_voltage_id+0x1a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: phm_get_voltage_id+0x2c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: phm_get_voltage_id+0x3c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: phm_get_voltage_id+0x44 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: phm_get_voltage_id+0x50 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x2a0 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x2a6 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x302 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x316 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x32e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x34e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x366 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x36a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x396 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x39e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x3a2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x3b2 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x3d4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x3da (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x3ee (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x3fc (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x422 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x42a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x436 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x448 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x480 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x4b4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x4c6 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x4ca (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x4d2 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x4e4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x4e8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x4ec (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x4f8 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x512 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_setup_default_dpm_tables+0x582 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_max_sustainable_clock+0x60 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_max_sustainable_clock+0x7e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_init_max_sustainable_clocks+0xb2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_init_max_sustainable_clocks+0xfe (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_init_max_sustainable_clocks+0x190 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_init_max_sustainable_clocks+0x1bc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_init_max_sustainable_clocks+0x1f2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_init_max_sustainable_clocks+0x228 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_find_highest_dpm_level+0x54 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_find_highest_dpm_level+0x8a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_find_highest_dpm_level+0xc0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_mp1_state+0x46 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_mgpu_fan_boost+0x30 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_disable_dpm_tasks+0x50 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_disable_dpm_tasks+0x6a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_power_off_asic+0x40 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_override_pcie_parameters+0x192 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_override_pcie_parameters+0x1c6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_override_pcie_parameters+0x1fa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_ppfeature_status+0x15e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_power_profile_mode+0x29e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_power_profile_mode+0x2b2 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_power_profile_mode+0x2b4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_power_profile_mode+0x2c0 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_power_profile_mode+0x2d0 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x36 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x3a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x7e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x94 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x118 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x11c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x120 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x142 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x158 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_power_profile_mode+0x16a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_current_clk_freq+0x4a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x6ea (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x6ee (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x708 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x70c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x72a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x804 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x83a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x872 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x8aa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_print_clock_levels+0x910 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_od8_get_gfx_clock_base_voltage+0x42 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_power_gate_uvd+0x6a (section: .text) -> quiet_kernel (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_disable_vce_dpm.isra.0+0x4c (section: .text) -> rdinit_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_od8_initialize_default_settings+0x2e6 (section: .text) -> ignore_unknown_bootoption (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_od8_initialize_default_settings+0x31c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_od8_initialize_default_settings+0x342 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_od8_initialize_default_settings+0x378 (section: .text) -> warn_bootconfig (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_od8_initialize_default_settings+0x39e (section: .text) -> (unknown) (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x2cc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x2fc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x318 (section: .text) -> set_init_arg (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x34c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x368 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x39c (section: .text) -> unknown_bootoption (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x3d0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x404 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x43a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x470 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x4a6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x4f2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x524 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x528 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x52c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x53c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x564 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x5a8 (section: .text) -> loglevel (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks.part.0+0x5de (section: .text) -> initcall_blacklist (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks+0xae (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks+0xc8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_enable_dpm_tasks+0xfc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_sclk_od+0xe8 (section: .text) -> initcall_blacklisted (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_set_sclk_od+0x150 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_dpm_get_sclk+0x72 (section: .text) -> trace_initcall_finish_cb.constprop.0 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_dpm_get_sclk+0x8c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_dpm_get_sclk+0xb2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_dpm_get_sclk+0xd0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_dpm_get_sclk+0xea (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_dpm_get_mclk+0x74 (section: .text) -> trace_initcall_finish_cb.constprop.0 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_dpm_get_mclk+0xb4 (section: .text) -> parse_early_options (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_dpm_get_mclk+0xd2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_gpu_power+0xde (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_current_activity_percent+0xee (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vega20_get_gpu_metrics+0x20c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dpcd+0x34 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_submit_i2c+0x16 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_submit_i2c+0x3c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_submit_i2c+0x3e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_submit_i2c+0x74 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_submit_i2c+0xb6 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_submit_i2c+0xc4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_submit_i2c+0xcc (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0xe (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0x1c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0x28 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0x30 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0x38 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0x8a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0xb0 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0xb4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0xb8 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_dp_write_dsc_enable+0x214 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_read_local_edid+0x10a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_helpers_read_local_edid+0x126 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: srm_data_write+0x76 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_update_display+0x204 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x10a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x138 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x158 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x186 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x1d4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x1e0 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x244 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x316 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x372 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x380 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hdcp_create_workqueue+0x3c4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x36 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x48 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x6a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x70 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x84 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x88 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x8c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x90 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0xc6 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0xd0 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0xd6 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0xde (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0xf0 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0xf6 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x10a (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x10e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x11e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x128 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x14e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x152 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x172 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x1a6 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x1b0 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x1b4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x1b8 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x1c4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x1d4 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x1d8 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x1dc (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x202 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x20c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x20e (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_c2p0_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x212 (section: .text) -> set_reset_devices (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

