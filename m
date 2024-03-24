Return-Path: <linux-kernel+bounces-113713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B372888631
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060C3292C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAD31E7733;
	Sun, 24 Mar 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5oB42x5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D81DBF22;
	Sun, 24 Mar 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320699; cv=none; b=mL5Z9lPXPOkrZQiUoJEPlSYBxxpQvYLBTdawZjdVIxRAmSmLQmk4cYvl7oBdrOWSX0o932Y3vckck/Bvk9SYQ0fDVJlGw3nIMxUgwARh5roLnXUQ17dzr83lvlnV7ZabYBdYt0d/qZDFvT80HgWCXym70O6eswXaaDs8On1bgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320699; c=relaxed/simple;
	bh=nfu/1bifCRzhzUwuYeSYF4B5jVHi/FobrLmXrxCk7CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3LY/C7Z3kJ2GZ/X3jIKHBOVFmiY8936saMXnzFQZBA3zSy3IjZ7ZKSZ70+wfUuaT+crhgTECXlB0OVlYqsCZcEMr7y/NyEE6+Bl40bgUdG3BwvANFRyLRbkawkttt6oMfZq5ul1l85NZOqgys/6evH9x4wdfANVCVzU0i1a+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5oB42x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C0C43394;
	Sun, 24 Mar 2024 22:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320697;
	bh=nfu/1bifCRzhzUwuYeSYF4B5jVHi/FobrLmXrxCk7CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5oB42x5tlrFsL0sBMVcF9A3TNoKJzBPTeR4d/3J5ZpFwF6WEx6UoCsqT1UXZHJNo
	 ZvEjnqtTJ/Gsv2SNftfOYxGy12yHrq1wwz+UkHtJgEWH+ZdYZTGUjPEhMcKXTXKhSA
	 I5syQ4KqsBii3VpVoVyPtMKpf6sZOY/zL/ZY1W87VlwTOPaIGiXpCukpVGUI8fiPRM
	 KhgfPT0ZKLR2NDVhXwN/gwjO9r3TW+VEmlsjmNzis689FeXn44yAsfCB+0+pDzQp6N
	 F8Y9NxzzREPKT6zSrGrAiPfklgeba4Bf96b4fTQJW9s6f8LsldrTwNzY3S61fZGH/Y
	 chHMYpfgD9pPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 260/713] ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()
Date: Sun, 24 Mar 2024 18:39:46 -0400
Message-ID: <20240324224720.1345309-261-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 55437f5e0c3ae..bd6a7857ce058 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1430,6 +1430,8 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
 		acpi_processor_registered--;
 		if (acpi_processor_registered == 0)
 			cpuidle_unregister_driver(&acpi_idle_driver);
+
+		kfree(dev);
 	}
 
 	pr->flags.power_setup_done = 0;
-- 
2.43.0


