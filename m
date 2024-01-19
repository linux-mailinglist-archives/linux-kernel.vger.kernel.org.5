Return-Path: <linux-kernel+bounces-31215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B13832AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7B62846AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6652F7D;
	Fri, 19 Jan 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWhtwQ9d"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A541A8F;
	Fri, 19 Jan 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671975; cv=none; b=UZKP2NwBRVSlJUI8RqPydtdLxPo4sggFXg7rO/1Rb+OuikoSgIgUICBGLjfSyzIuYhraJsZ8SsL6+vaD6mXKAsLl1J58kxCkffP/vW/XwLRTCmLuWFCb4GdI/LrJQEpUCfdWYeRkZjuF2BFRg7I+IxsNg6voTpFNIoZCvv9r8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671975; c=relaxed/simple;
	bh=ORfW2yWVKuXhf9AVbBpirYvy32m+5AGMk4YqtkB2BO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AdqaYjSbMDczOTrubOWbD0+4CGCWoJagOTU/NtdZzmO7pouwQJ4lb1ebJWb4MDm1+UC848OoZalkSFQrW1d4tuqSOnaC3bKI2TKc6CcKbSo9nYJ0VdheJRD/i/r4TQ1vC6sai33g2nISCJzhfSLUheOrhCLnLZsG5HX3LEw91hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWhtwQ9d; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705671974; x=1737207974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ORfW2yWVKuXhf9AVbBpirYvy32m+5AGMk4YqtkB2BO0=;
  b=eWhtwQ9dxPDhc039sC3oqslampLcIwMWfQjXumwtwix/P6eqYAEmkPrT
   f+AF/0dZer3nuExalQeetzjBMb8UUttDOedn6IK/kODq6p4kU9+e6jwYX
   TcpA5WRC8EijkM0T5RT1K46JTL6IbyJBSMZdIxOhrm5jRkbk8oJYSyyp2
   R3z6bJfrNvTqZGXF8eao+b2OZ6OBqhILos1l3KwGfmwhjSTT0a8pfDkue
   iiTmlXFstCkVWYwH0EBUQn42/SDUMUBmq0kV1bRPYtJk/qU/yADN8Q6by
   IBgQadIZPYu0RwUvjCP9QVZHvxRC181MuWg4eC93+MNzlBKHNQYXvg/gn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="465026893"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="465026893"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 05:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="788360383"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="788360383"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2024 05:46:10 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	davem@davemloft.net,
	milena.olech@intel.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	mschmidt@redhat.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net v6 0/4] dpll: fix unordered unbind/bind registerer issues
Date: Fri, 19 Jan 2024 14:43:00 +0100
Message-Id: <20240119134304.576956-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues when performing unordered unbind/bind of a kernel modules
which are using a dpll device with DPLL_PIN_TYPE_MUX pins.
Currently only serialized bind/unbind of such use case works, fix
the issues and allow for unserialized kernel module bind order.

The issues are observed on the ice driver, i.e.,

$ echo 0000:af:00.0 > /sys/bus/pci/drivers/ice/unbind
$ echo 0000:af:00.1 > /sys/bus/pci/drivers/ice/unbind

results in:

ice 0000:af:00.0: Removed PTP clock
BUG: kernel NULL pointer dereference, address: 0000000000000010
PF: supervisor read access in kernel mode
PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 7 PID: 71848 Comm: bash Kdump: loaded Not tainted 6.6.0-rc5_next-queue_19th-Oct-2023-01625-g039e5d15e451 #1
Hardware name: Intel Corporation S2600STB/S2600STB, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
RIP: 0010:ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
Code: 41 57 4d 89 cf 41 56 41 55 4d 89 c5 41 54 55 48 89 f5 53 4c 8b 66 08 48 89 cb 4d 8d b4 24 f0 49 00 00 4c 89 f7 e8 71 ec 1f c5 <0f> b6 5b 10 41 0f b6 84 24 30 4b 00 00 29 c3 41 0f b6 84 24 28 4b
RSP: 0018:ffffc902b179fb60 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8882c1398000 RSI: ffff888c7435cc60 RDI: ffff888c7435cb90
RBP: ffff888c7435cc60 R08: ffffc902b179fbb0 R09: 0000000000000000
R10: ffff888ef1fc8050 R11: fffffffffff82700 R12: ffff888c743581a0
R13: ffffc902b179fbb0 R14: ffff888c7435cb90 R15: 0000000000000000
FS:  00007fdc7dae0740(0000) GS:ffff888c105c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 0000000132c24002 CR4: 00000000007706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die+0x20/0x70
 ? page_fault_oops+0x76/0x170
 ? exc_page_fault+0x65/0x150
 ? asm_exc_page_fault+0x22/0x30
 ? ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
 ? __pfx_ice_dpll_rclk_state_on_pin_get+0x10/0x10 [ice]
 dpll_msg_add_pin_parents+0x142/0x1d0
 dpll_pin_event_send+0x7d/0x150
 dpll_pin_on_pin_unregister+0x3f/0x100
 ice_dpll_deinit_pins+0xa1/0x230 [ice]
 ice_dpll_deinit+0x29/0xe0 [ice]
 ice_remove+0xcd/0x200 [ice]
 pci_device_remove+0x33/0xa0
 device_release_driver_internal+0x193/0x200
 unbind_store+0x9d/0xb0
 kernfs_fop_write_iter+0x128/0x1c0
 vfs_write+0x2bb/0x3e0
 ksys_write+0x5f/0xe0
 do_syscall_64+0x59/0x90
 ? filp_close+0x1b/0x30
 ? do_dup2+0x7d/0xd0
 ? syscall_exit_work+0x103/0x130
 ? syscall_exit_to_user_mode+0x22/0x40
 ? do_syscall_64+0x69/0x90
 ? syscall_exit_work+0x103/0x130
 ? syscall_exit_to_user_mode+0x22/0x40
 ? do_syscall_64+0x69/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7fdc7d93eb97
Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007fff2aa91028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fdc7d93eb97
RDX: 000000000000000d RSI: 00005644814ec9b0 RDI: 0000000000000001
RBP: 00005644814ec9b0 R08: 0000000000000000 R09: 00007fdc7d9b14e0
R10: 00007fdc7d9b13e0 R11: 0000000000000246 R12: 000000000000000d
R13: 00007fdc7d9fb780 R14: 000000000000000d R15: 00007fdc7d9f69e0
 </TASK>
Modules linked in: uinput vfio_pci vfio_pci_core vfio_iommu_type1 vfio irqbypass ixgbevf snd_seq_dummy snd_hrtimer snd_seq snd_timer snd_seq_device snd soundcore overlay qrtr rfkill vfat fat xfs libcrc32c rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm ipmi_ssif x86_pkg_temp_thermal intel_powerclamp coretemp irdma rapl intel_cstate ib_uverbs iTCO_wdt iTCO_vendor_support acpi_ipmi intel_uncore mei_me ipmi_si pcspkr i2c_i801 ib_core mei ipmi_devintf intel_pch_thermal ioatdma i2c_smbus ipmi_msghandler lpc_ich joydev acpi_power_meter acpi_pad ext4 mbcache jbd2 sd_mod t10_pi sg ast i2c_algo_bit drm_shmem_helper drm_kms_helper ice crct10dif_pclmul ixgbe crc32_pclmul drm crc32c_intel ahci i40e libahci ghash_clmulni_intel libata mdio dca gnss wmi fuse [last unloaded: iavf]
CR2: 0000000000000010

v6:
- fix memory corruption on error path in patch [v5 2/4]

Arkadiusz Kubalewski (4):
  dpll: fix broken error path in dpll_pin_alloc(..)
  dpll: fix pin dump crash for rebound module
  dpll: fix userspace availability of pins
  dpll: fix register pin with unregistered parent pin

 drivers/dpll/dpll_core.c    | 68 +++++++++++++++++++++++++++++++------
 drivers/dpll/dpll_core.h    |  4 +--
 drivers/dpll/dpll_netlink.c | 57 ++++++++++++++++++++++---------
 3 files changed, 100 insertions(+), 29 deletions(-)


base-commit: dbc153fd3c142909e564bb256da087e13fbf239c
-- 
2.38.1


