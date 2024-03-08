Return-Path: <linux-kernel+bounces-96867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3474C876262
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD0D1C20FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0855769;
	Fri,  8 Mar 2024 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhdxbPQs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253553E3F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894794; cv=none; b=BnZ5F+TkFFf0vz3y4G4GfOP3bE0AlXEnrKjDyhUy1IqtJixvJEw8hE7m2JKaxW3tGKpKZsQA76VJV8KlSjjEv6pQle1oWuECBuZhElG9org0/VL0GcuWkS1FVIyjrzHU7u7Rsdufz7Tseu9eLxF3nHysldDyWBf+DAP1RG9zAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894794; c=relaxed/simple;
	bh=8MosYBhE5riFfkSnxDEG266Cx1MumuoXdlWUNzqfQ1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KYfuL7/k8BJ1/PKBcdbF9MhQ6UK0dtee4kYbdyhzAbqgZCD7s1OidpLv8vPyEFrPG1xBRmcIuvF3CKu3aQ/HT3cZOKsRjSYzCcF/12b4KEdbElw9MaSEWdbtlvHeHmrqmhC0lRozCfcOuzxqZRSpz1H6vn+zTgYBBLub2OD5U58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhdxbPQs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709894792; x=1741430792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8MosYBhE5riFfkSnxDEG266Cx1MumuoXdlWUNzqfQ1c=;
  b=FhdxbPQsgIU955Uqo7wY5zcIfOY2OaEevUgjt0kuaUJh+w/v/L/OwjII
   d/tFuPyINBLEvig7zjk6wdeusuuk1QKtFUJz8wvUBlFPX/w7hQW/zaMwA
   Xy6950Z08aeSdSmz3NzF/JqigANa2R4zDDM+hUSRmnL+zly2P0rMvkbSE
   zzBXscaoOdijMYIsMdNkntq6sBpM63zYW7SfXjVT8wT7pN2YUThDheT4B
   jHQTzQQliDlqnIPelp0eEM60g1rXpMojcQbbE+7r6wTyMyU4OCccgqR/m
   XLur03EIplJiqZULow+yM6ZNfA8swqdX/ggl1FRqq8yjftpjwpqBFdOpZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4778370"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4778370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:46:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10835315"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:46:27 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7B65411F819;
	Fri,  8 Mar 2024 12:46:24 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1riXk8-00GrgK-1V;
	Fri, 08 Mar 2024 12:46:24 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	wentong.wu@intel.com,
	"Reported-by : Dominik Brodowski" <linux@dominikbrodowski.net>
Subject: [PATCH 1/1] mei: vsc: Mark the driver BROKEN
Date: Fri,  8 Mar 2024 12:46:14 +0200
Message-Id: <20240308104614.4019592-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MEI VSC driver currently oopses and may crash the system on suspend.
The other drivers required to use MEI VSC driver's services are not in
upstream yet, disable the MEI VSC driver by marking it BROKEN until it is
fixed.

--------8<------------
[  554.624659] intel_vsc intel_vsc: wait fw ready failed: -110
[  554.624672] intel_vsc intel_vsc: hw_start failed ret = -110 fw status =
[  554.625016] intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status =
[  554.628623] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040100
[  554.628863] snd_hda_intel 0000:00:1f.3: SoundWire enabled on CannonLake+ platform, using SOF driver
[  554.628909] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040100
[  554.628943] sof-audio-pci-intel-tgl 0000:00:1f.3: SoundWire enabled on CannonLake+ platform, using SOF driver
[  554.629603] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040100
[  554.629606] OOM killer enabled.
[  554.629611] Restarting tasks ... done.
[  554.631243] random: crng reseeded on system resumption
[  554.631373] intel_ipu6_isys.isys intel_ipu6.isys.40: ltr: value 1023 scale 5, did: value 1023 scale 2
[  554.680511] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  554.684521] intel_vsc intel_vsc: silicon stepping version is 0:2
[  554.815307] PM: suspend exit
[  564.652519] BUG: unable to handle page fault for address: 0000001800070c19
[  564.652537] #PF: supervisor read access in kernel mode
[  564.652543] #PF: error_code(0x0000) - not-present page
[  564.652548] PGD 0 P4D 0
[  564.652556] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  564.652566] CPU: 2 PID: 261 Comm: kworker/2:2 Not tainted 6.8.0-rc2+ #1983
[  564.652575] Hardware name: Dell Inc. XPS 9315/0WWXF6, BIOS 1.3.0 08/16/2022
[  564.652579] Workqueue: events mei_reset_work [mei]
[  564.652629] RIP: 0010:mei_cl_set_disconnected+0xc/0x270 [mei]
[  564.652675] Code: c3 cc cc cc cc 0f 0b eb 97 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 54 53 <8b> 47 18 4c 8b 67 10 83 f8 07 0f 84 45 01 00 00 83 f8 01 0f 86 3c
[  564.652682] RSP: 0018:ffff9f97807cbd40 EFLAGS: 00010213
[  564.652689] RAX: 0000000000000000 RBX: 0000001800070c01 RCX: 0000000000000000
[  564.652695] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000001800070c01
[  564.652699] RBP: ffff9f97807cbd50 R08: 0000000000000000 R09: 0000000000000000
[  564.652703] R10: 0000000000000000 R11: 0000000000000000 R12: ffff926a016760e8
[  564.652707] R13: 0000000000000000 R14: ffff926a00151401 R15: ffff926a01676e00
[  564.652711] FS:  0000000000000000(0000) GS:ffff926b87680000(0000) knlGS:0000000000000000
[  564.652717] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  564.652722] CR2: 0000001800070c19 CR3: 000000014c03c000 CR4: 0000000000750ef0
[  564.652728] PKRU: 55555554
[  564.652731] Call Trace:
[  564.652736]  <TASK>
[  564.652744]  ? show_regs+0x6d/0x80
[  564.652761]  ? __die+0x24/0x80
[  564.652770]  ? page_fault_oops+0x156/0x4b0
[  564.652783]  ? do_user_addr_fault+0x2f9/0x6c0
[  564.652793]  ? exc_page_fault+0x83/0x1b0
[  564.652803]  ? asm_exc_page_fault+0x27/0x30
[  564.652818]  ? mei_cl_set_disconnected+0xc/0x270 [mei]
[  564.652857]  mei_cl_all_disconnect+0x27/0x40 [mei]
[  564.652893]  mei_reset+0x18a/0x550 [mei]
[  564.652927]  ? __synchronize_irq+0x31/0xb0
[  564.652940]  mei_reset_work+0x55/0xe0 [mei]
[  564.652975]  process_one_work+0x16c/0x350
[  564.652985]  worker_thread+0x306/0x440
[  564.652993]  ? __pfx_worker_thread+0x10/0x10
[  564.653000]  kthread+0xef/0x120
[  564.653013]  ? __pfx_kthread+0x10/0x10
[  564.653023]  ret_from_fork+0x44/0x70
[  564.653034]  ? __pfx_kthread+0x10/0x10
[  564.653044]  ret_from_fork_asm+0x1b/0x30
[  564.653054]  </TASK>
--------8<------------

Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: <stable@vger.kernel.org> # for 6.8
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Hi Greg,

It'd be nice to have this in 6.8 or if that fails, merge it in early
stable releases. This issue causes crashes on Tiger lake, Alderlake and
others on system suspend.

As the driver isn't used for anything (in upstream) quite yet, the patch
marks it BROKEN for now.

- Sakari

 drivers/misc/mei/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 67d9391f1855..d72e06d51b69 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -60,6 +60,7 @@ config INTEL_MEI_GSC
 
 config INTEL_MEI_VSC_HW
 	tristate "Intel visual sensing controller device transport driver"
+	depends on BROKEN
 	depends on ACPI && SPI
 	depends on GPIOLIB || COMPILE_TEST
 	help
-- 
2.39.2


