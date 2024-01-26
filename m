Return-Path: <linux-kernel+bounces-40089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E783DA1B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6DF1F2644A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AF518E3A;
	Fri, 26 Jan 2024 12:23:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA691175AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271818; cv=none; b=MFGdupGAIpqyrIX84LTTFOOwy5Uc6B8eaXvnhkVoEBluFBtGDKAVpDEA5JOmpNNCL3hrbniSW5RwE4pZdWQGR+JN5HkfSPcK5L5cBGZWcCXaLZ9ne821rQQspjO8AnjsxZTRuQc4w11hacQbEMM9tD4fNERZduStZ1usEVDdAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271818; c=relaxed/simple;
	bh=Qg8gVm5tOaq4msIADLBhg8VHptX6VXLh03956HO0biQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YmPySiOV9xN+S+xWZa2NaRmnwgBrt9To32G8lOAhjcIzHlIfJn15gBk+HKEtW9Kps1em3mJuyX8SXcOBhq2V0x7Aa28MZu23zjE0bS3cej3OfYXfrzzsGa5G7E/7Gvlg6kPpzVkl83ocZvGa5FU3nIfxy1gbcRivYJ5d4l4GJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1388B1FB;
	Fri, 26 Jan 2024 04:24:19 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CABE33F73F;
	Fri, 26 Jan 2024 04:23:33 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: fix double free in smc cleanup path
Date: Fri, 26 Jan 2024 12:23:25 +0000
Message-Id: <20240126122325.2039669-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the generic SCMI code tears down a channel, it calls the chan_free
callback function, defined by each transport. Since multiple protocols
might share the same transport_info member, chan_free() might want to
clean up the same member multiple times. This will lead to a NULL
pointer dereference at the second time:

[    9.788824] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
[    9.813091] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    9.814485] arm-scmi firmware:scmi: unable to communicate with SCMI
[    9.824996] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    9.825586] Mem abort info:
[    9.825863]   ESR = 0x0000000096000004
[    9.826193]   EC = 0x25: DABT (current EL), IL = 32 bits
[    9.827625]   SET = 0, FnV = 0
[    9.827927]   EA = 0, S1PTW = 0
[    9.828232]   FSC = 0x04: level 0 translation fault
[    9.828628] Data abort info:
[    9.828909]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    9.829333]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    9.829745]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    9.830170] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000881ef8000
[    9.830887] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[    9.831763] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    9.832177] Modules linked in:
[    9.832440] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc2-00124-g455ef3d016c9-dirty #793
[    9.832997] Hardware name: FVP Base RevC (DT)
[    9.833302] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    9.833775] pc : smc_chan_free+0x3c/0x6c
[    9.834089] lr : smc_chan_free+0x3c/0x6c
[    9.834401] sp : ffff8000839bba00
[    9.834652] x29: ffff8000839bba00 x28: 00000000ffffffa1 x27: ffff0008024aa350
[    9.835227] x26: ffff800083305898 x25: ffff0008004d4a18 x24: ffff000800328000
[    9.835804] x23: ffff0008024aa1b0 x22: 0000000000000000 x21: 000000007fffffff
[    9.836375] x20: 0000000000000000 x19: ffff000802639440 x18: 0000000000000010
[    9.836945] x17: 73203e3d20293062 x16: 3161613432303830 x15: 303066666666202c
[    9.837522] x14: 00000000000001f4 x13: ffff000800328488 x12: 00000000ffffffea
[    9.838094] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffff800082f3b430
[    9.838667] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 000000000005fff4
[    9.839237] x5 : 00000000002bffa8 x4 : 0000000000000000 x3 : 0000000000000000
[    9.839803] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000004a
[    9.840368] Call trace:
[    9.840571]  smc_chan_free+0x3c/0x6c
[    9.840868]  idr_for_each+0x68/0xf8
[    9.841164]  scmi_cleanup_channels.isra.0+0x2c/0x58
[    9.841543]  scmi_probe+0x434/0x734
[    9.841848]  platform_probe+0x68/0xd8
[    9.842164]  really_probe+0x110/0x27c
[    9.842464]  __driver_probe_device+0x78/0x12c
[    9.842801]  driver_probe_device+0x3c/0x118
[    9.843130]  __driver_attach+0x74/0x128
[    9.843439]  bus_for_each_dev+0x78/0xe0
[    9.843783]  driver_attach+0x24/0x30
[    9.844121]  bus_add_driver+0xe4/0x1e8
[    9.844466]  driver_register+0x60/0x128
[    9.844778]  __platform_driver_register+0x28/0x34
[    9.845149]  scmi_driver_init+0x84/0xc0
[    9.845459]  do_one_initcall+0x78/0x33c
[    9.845778]  kernel_init_freeable+0x2b8/0x51c
[    9.846127]  kernel_init+0x24/0x130
[    9.846426]  ret_from_fork+0x10/0x20
[    9.846772] Code: f0004701 910a0021 aa1403e5 97b91c70 (b9400280)
[    9.847172] ---[ end trace 0000000000000000 ]---
[    9.847604] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Simply check for the struct pointer being NULL before trying to access
its members, to avoid this situation.
This was found when a transport doesn't really work (for instance no SMC
service), the probe routines then tries to clean up, and triggers a crash.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Fixes: 1dc6558062da ("firmware: arm_scmi: Add smc/hvc transport")
---
Hi,

reportedly Cristian has some patches in the making that solve this
problem in a more general way, but meanwhile this is an easy backport
candidate.
I am not 100% sure about the wording in the commit message, so feel free
to correct me there.

Cheers,
Andre

 drivers/firmware/arm_scmi/smc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 7611e9665038d..39936e1dd30e9 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -214,6 +214,13 @@ static int smc_chan_free(int id, void *p, void *data)
 	struct scmi_chan_info *cinfo = p;
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
+	/*
+	 * Different protocols might share the same chan info, so a previous
+	 * smc_chan_free call might have already freed the structure.
+	 */
+	if (!scmi_info)
+		return 0;
+
 	/* Ignore any possible further reception on the IRQ path */
 	if (scmi_info->irq > 0)
 		free_irq(scmi_info->irq, scmi_info);
-- 
2.25.1


