Return-Path: <linux-kernel+bounces-113112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D488818D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325A2B21660
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139C7159560;
	Sun, 24 Mar 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxzNdXKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D1159579;
	Sun, 24 Mar 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319920; cv=none; b=XIf60F24KzopgwVSQKQwQZWyxcF69NiuxkUeJxaI2HzjpM/sFIpFbFFBBrt2ZR4Z6pkew182zWbwkOwkdJeADneeldore+uUWtqu5oThdK+1afUIhKi9RUxwTem86gYggzxQBSpq+CGtA+z5awI9qbZriM7Ogw0IJSJYR1qHqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319920; c=relaxed/simple;
	bh=1lwHRMfdeOG67Fs2sEkZD3y3XqkdjZSm0N3AdDXg11g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFlHsx1vHVzol7xmUNet1rHSLvrSVzsFtAwSc4YRJE9sCP452IrvsDvvpTe70+Y22cJukXDAtFFwjeNHUT4PfZQnXreBgPK9FR06cOtWW0vGHBBmmoMhEGr28CbWwLYkC663gGVNiMDqGNvJ/EH1XamIkjJI66KSPIsmML+03tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxzNdXKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0564DC433C7;
	Sun, 24 Mar 2024 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319919;
	bh=1lwHRMfdeOG67Fs2sEkZD3y3XqkdjZSm0N3AdDXg11g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxzNdXKX8DofVamfeg5k75uCmAfvNP7d+YisU30BHzCIRJPBiYRO7cpRaSNedS01d
	 p4wg2nF0h/xZt3cM9vhjds7eTVjb8yl4LtNgLBTqHfVbcy0ExI3G+wOU7LKj90s8PL
	 IarUiu9AgKeanJj4/0yax/C9aHUxC9+fGM+E3iw7EDmpgIk+D4bvva1WquLeSu0wZZ
	 fHHN7W3My64LzVD5OoimyTDQ8ZF+QkmzGtIG8QK95w+8YJ7eQLF0qT7HaGprz6dSM9
	 /mmH7WyXth+R4CnikruUaFGoe4cSIZHtBTy6WAHbAet+SgXoshIv68E4dD5iLOo2LN
	 UWdSm7LRUpuZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Przywara <andre.przywara@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 225/715] firmware: arm_scmi: Fix double free in SMC transport cleanup path
Date: Sun, 24 Mar 2024 18:26:44 -0400
Message-ID: <20240324223455.1342824-226-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit f1d71576d2c9ec8fdb822173fa7f3de79475e9bd ]

When the generic SCMI code tears down a channel, it calls the chan_free
callback function, defined by each transport. Since multiple protocols
might share the same transport_info member, chan_free() might want to
clean up the same member multiple times within the given SCMI transport
implementation. In this case, it is SMC transport. This will lead to a NULL
pointer dereference at the second time:

    | scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
    | arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
    | arm-scmi firmware:scmi: unable to communicate with SCMI
    | Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
    | Mem abort info:
    |   ESR = 0x0000000096000004
    |   EC = 0x25: DABT (current EL), IL = 32 bits
    |   SET = 0, FnV = 0
    |   EA = 0, S1PTW = 0
    |   FSC = 0x04: level 0 translation fault
    | Data abort info:
    |   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
    |   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
    |   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
    | user pgtable: 4k pages, 48-bit VAs, pgdp=0000000881ef8000
    | [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
    | Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
    | Modules linked in:
    | CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc2-00124-g455ef3d016c9-dirty #793
    | Hardware name: FVP Base RevC (DT)
    | pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
    | pc : smc_chan_free+0x3c/0x6c
    | lr : smc_chan_free+0x3c/0x6c
    | Call trace:
    |  smc_chan_free+0x3c/0x6c
    |  idr_for_each+0x68/0xf8
    |  scmi_cleanup_channels.isra.0+0x2c/0x58
    |  scmi_probe+0x434/0x734
    |  platform_probe+0x68/0xd8
    |  really_probe+0x110/0x27c
    |  __driver_probe_device+0x78/0x12c
    |  driver_probe_device+0x3c/0x118
    |  __driver_attach+0x74/0x128
    |  bus_for_each_dev+0x78/0xe0
    |  driver_attach+0x24/0x30
    |  bus_add_driver+0xe4/0x1e8
    |  driver_register+0x60/0x128
    |  __platform_driver_register+0x28/0x34
    |  scmi_driver_init+0x84/0xc0
    |  do_one_initcall+0x78/0x33c
    |  kernel_init_freeable+0x2b8/0x51c
    |  kernel_init+0x24/0x130
    |  ret_from_fork+0x10/0x20
    | Code: f0004701 910a0021 aa1403e5 97b91c70 (b9400280)
    | ---[ end trace 0000000000000000 ]---

Simply check for the struct pointer being NULL before trying to access
its members, to avoid this situation.

This was found when a transport doesn't really work (for instance no SMC
service), the probe routines then tries to clean up, and triggers a crash.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Fixes: 1dc6558062da ("firmware: arm_scmi: Add smc/hvc transport")
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20240126122325.2039669-1-andre.przywara@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
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
2.43.0


