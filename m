Return-Path: <linux-kernel+bounces-28023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD282F936
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403891C25308
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F813FF7A;
	Tue, 16 Jan 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY/YzRDz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188613FF68;
	Tue, 16 Jan 2024 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434926; cv=none; b=Rqa59CyVW+IqGLlSkmoM6upI1jfPflsm2pFtezNq2B+j5yGOKoI8CwCFaM3O8XC5q9AJl3BZkPeTFhNSZQ6KLO3/wf5enuAN1nYkbYmxTbK/DhkblI5cFcYZyFlWG74LbkK57pPwDhI/2CcVL+NXOe3bdfA36dj62QkuAlLzDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434926; c=relaxed/simple;
	bh=BeOHMRrGf0zhtFdRSeFEOEFiEyO56VUNVHfmChfcUhg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=q5u8sVARf+BWbwT/oWCN8pxbvdh8MJaqb1SGjMhI6bKsSDLTtREVLSLj/eSgy+Ck40kzrrwsZ3ftF3Rxwx/8VdDfAT5XtCXuORw+XWUGthMj17Dvt+NwbX0tJzDbMCwURU/uA1dYwWi2CX+nRllF7KugJvltobiJu+2+TBgj18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tY/YzRDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197D9C433F1;
	Tue, 16 Jan 2024 19:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434926;
	bh=BeOHMRrGf0zhtFdRSeFEOEFiEyO56VUNVHfmChfcUhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tY/YzRDzhy1TXHFzCacSYAGMMZjfhn2JyqFeEHqvp0h0Y5ZxNsTqWYVkkyrsJyq64
	 KISto9l5xoVqipHUnVkK+fivgzwMtqssmZ0f0MBoDxGBOFvRLOzWblBokAzGHjgz6O
	 QssxPJ1AXZ5zUiHKJ++L/DYavuzPI4s1UQ9z6oVXFkZWm9U+awDOJLhqtLzXFJT3EK
	 mCqG3xogZXy8SrtIAjirfIbcZuWsxGtxQtmUAiBYfq6nwuW8xxsSJt0H24YQSnxdqG
	 yN+/61rVQUXyO//w8vTpvaLtSmhogvN5JcLv86BzQUzqmn+n8ccKOjPgh+TqM/w7AQ
	 D1bjeEbwZT+5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: HariBabu Gattem <haribabu.gattem@xilinx.com>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	abhyuday.godhasara@xilinx.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 06/68] soc: xilinx: Fix for call trace due to the usage of smp_processor_id()
Date: Tue, 16 Jan 2024 14:53:05 -0500
Message-ID: <20240116195511.255854-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: HariBabu Gattem <haribabu.gattem@xilinx.com>

[ Upstream commit daed80ed07580e5adc0e6d8bc79933a35154135a ]

When preemption is enabled in kernel and if any task which can be
preempted should not use smp_processor_id() directly, since CPU
switch can happen at any time, the previous value of cpu_id
differs with current cpu_id. As a result we see the below call trace
during xlnx_event_manager_probe.

[ 6.140197] dump_backtrace+0x0/0x190
[ 6.143884] show_stack+0x18/0x40
[ 6.147220] dump_stack_lvl+0x7c/0xa0
[ 6.150907] dump_stack+0x18/0x34
[ 6.154241] check_preemption_disabled+0x124/0x134
[ 6.159068] debug_smp_processor_id+0x20/0x2c
[ 6.163453] xlnx_event_manager_probe+0x48/0x250

To protect cpu_id, It is recommended to use get_cpu()/put_cpu()
to disable preemption, get the cpu_id and enable preemption respectively.
(For Reference, Documentation/locking/preempt-locking.rst and
Documentation/kernel-hacking/hacking.rst)

Use preempt_disable()/smp_processor_id()/preempt_enable()
API's to achieve the same.

Signed-off-by: HariBabu Gattem <haribabu.gattem@xilinx.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Link: https://lore.kernel.org/r/20231027055622.21544-1-jay.buddhabhatti@amd.com
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index f9d9b82b562d..56d22d3989bb 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -555,7 +555,7 @@ static void xlnx_disable_percpu_irq(void *data)
 static int xlnx_event_init_sgi(struct platform_device *pdev)
 {
 	int ret = 0;
-	int cpu = smp_processor_id();
+	int cpu;
 	/*
 	 * IRQ related structures are used for the following:
 	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
@@ -592,9 +592,12 @@ static int xlnx_event_init_sgi(struct platform_device *pdev)
 	sgi_fwspec.param[0] = sgi_num;
 	virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
 
+	cpu = get_cpu();
 	per_cpu(cpu_number1, cpu) = cpu;
 	ret = request_percpu_irq(virq_sgi, xlnx_event_handler, "xlnx_event_mgmt",
 				 &cpu_number1);
+	put_cpu();
+
 	WARN_ON(ret);
 	if (ret) {
 		irq_dispose_mapping(virq_sgi);
-- 
2.43.0


