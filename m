Return-Path: <linux-kernel+bounces-116143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305EE889996
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E7E1C3292C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92473B0A29;
	Mon, 25 Mar 2024 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiUWnFJZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A417A923;
	Sun, 24 Mar 2024 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323696; cv=none; b=i3RVOsc21rLHarrvcpH/pejRndGqeind4yh83jCk1bf9ZWB8yKszxDWjvm57NH5usP3YMxM4Z2r/28isuWLT2uPHqTO7YAtzzNPeyrT+KX6PYotwAmBU68NTCwrpi3Yv8wE9WXU/UmR85mg5GSoiPD8YnPcLMQe4pEKRca4y1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323696; c=relaxed/simple;
	bh=INN/gpk51sOf3ovPi5IuavhJHJQYrg/i54zt5o0DS0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZvEObMjS00vtpAOT0U+ChubiAYkQ+MzeQUAECK5jx3rhb8jBLWL4u9I0OjjBRuQ36GRB0uAe2jPr7j19vKQmkIx37uxZu/tnfvrqRrgYApjZksCx7p4D751PMpe47v/FNS76dRs2kn/bWhSrZZrz8OwwCTAvFP1cgwC6uhg0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiUWnFJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8DCC433F1;
	Sun, 24 Mar 2024 23:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323694;
	bh=INN/gpk51sOf3ovPi5IuavhJHJQYrg/i54zt5o0DS0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eiUWnFJZrXI/+zAjtXQZamNO/OR9fwuCjLEI2N4GN/Yo7Er/VmLRxmfyRifJ+IJgW
	 6TLz8L2ZbhHFdqTSD0/sHbfNSSu2ziVuFmjW8+GVu0gO4IDNh04fmVNB97KTzGSzEZ
	 6AmB3GrLrWr9TH2a3ZlUBrpj+7T4kxvo1QpoMGdPSkaebm2Zg6qHhuu8ZVECxdOZNh
	 2WJc0Jf+rw70rLnMtF8hfenevD0TeAZE6On/wTfeId5FpmG6CyNZo4KSdHNQJav+BV
	 35qqAkQFDzz7KUjILveRYaUCE0MbGQCM5N3YUn90yC3v6lWbXQS4KXiPtzD6x49Puo
	 6RFioxXAK/mEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 067/238] ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()
Date: Sun, 24 Mar 2024 19:37:35 -0400
Message-ID: <20240324234027.1354210-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit e18afcb7b2a12b635ac10081f943fcf84ddacc51 ]

After unregistering the CPU idle device, the memory associated with
it is not freed, leading to a memory leak:

unreferenced object 0xffff896282f6c000 (size 1024):
  comm "swapper/0", pid 1, jiffies 4294893170
  hex dump (first 32 bytes):
    00 00 00 00 0b 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8836a742):
    [<ffffffff993495ed>] kmalloc_trace+0x29d/0x340
    [<ffffffff9972f3b3>] acpi_processor_power_init+0xf3/0x1c0
    [<ffffffff9972d263>] __acpi_processor_start+0xd3/0xf0
    [<ffffffff9972d2bc>] acpi_processor_start+0x2c/0x50
    [<ffffffff99805872>] really_probe+0xe2/0x480
    [<ffffffff99805c98>] __driver_probe_device+0x78/0x160
    [<ffffffff99805daf>] driver_probe_device+0x1f/0x90
    [<ffffffff9980601e>] __driver_attach+0xce/0x1c0
    [<ffffffff99803170>] bus_for_each_dev+0x70/0xc0
    [<ffffffff99804822>] bus_add_driver+0x112/0x210
    [<ffffffff99807245>] driver_register+0x55/0x100
    [<ffffffff9aee4acb>] acpi_processor_driver_init+0x3b/0xc0
    [<ffffffff990012d1>] do_one_initcall+0x41/0x300
    [<ffffffff9ae7c4b0>] kernel_init_freeable+0x320/0x470
    [<ffffffff99b231f6>] kernel_init+0x16/0x1b0
    [<ffffffff99042e6d>] ret_from_fork+0x2d/0x50

Fix this by freeing the CPU idle device after unregistering it.

Fixes: 3d339dcbb56d ("cpuidle / ACPI : move cpuidle_device field out of the acpi_processor_power structure")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/processor_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 59781e765e0e2..3deeabb273940 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1427,6 +1427,8 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
 		acpi_processor_registered--;
 		if (acpi_processor_registered == 0)
 			cpuidle_unregister_driver(&acpi_idle_driver);
+
+		kfree(dev);
 	}
 
 	pr->flags.power_setup_done = 0;
-- 
2.43.0


