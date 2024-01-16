Return-Path: <linux-kernel+bounces-27922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80682F7D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BA81C20FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637B128AC0;
	Tue, 16 Jan 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMZ4PHth"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF512838D;
	Tue, 16 Jan 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434589; cv=none; b=rv8CUoqc3+vLTSnAoyP8QyCiBJy9h+puA6C8RPY+d5kRI4SvXmideLLBIkhMVCK3b+DcAEFJER6Nm+qAdPyipRnqK+cPngIwn0dlcLZUJA6iD3GcXtBQqGwVQbGmzbEbtNywPIX9OJzxMeKA7V/JR0D6O+l2TUa/OcmHfIl7NXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434589; c=relaxed/simple;
	bh=SbYuKDxHsGMaRqy5BeSJ2nJhg+gbOCrbiKmg/fWiFzw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Q2iM+DDBNBYBN8AGNSe6E0oyEIsq2qrEPAX+ChHNXHxuiLV3wu2oAGlazCb/G5tLIGuPJBhlLRTzsO77jqG7iwONzW/Yi5g5INF02eQ+7YfqMzwZesfuTmHXJ2GYNl5fHlM4HDTKHzMez2fLjC6UG8T+hXtKm4r8s8besPv0mj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMZ4PHth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EB8C433C7;
	Tue, 16 Jan 2024 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434589;
	bh=SbYuKDxHsGMaRqy5BeSJ2nJhg+gbOCrbiKmg/fWiFzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMZ4PHthz3s/rAP28CM0qJ3BcLta/s+ezloRGc6d3hDrGllYiR8eTZDezqKlyjIsL
	 AVhJgYdNltyyR/b/EenWCrs+C7UuR43mrJAs9HKG/mxxCaBExSytQwWidGw5o49LDb
	 s/G3ppGl8MKE79doVLSFrbaFl7gPNhUXZdWC2Mt7q9pjMtBqIVrW4JYu+KL3xwGSxz
	 b6/AjB/3PBNvcphpCAI86/sXDHbXFL7qR/cAyUC/a8mBW3i4lEl6kHr8/b9WGPQkz3
	 fdNsMdCKn2mlQxhwoBFXrSTdUvypNqvNR0Q5ANOR6xYgOYdNmaKJL95/HIbBkC5SnN
	 OAsHOfkMwMeMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: HariBabu Gattem <haribabu.gattem@xilinx.com>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	abhyuday.godhasara@xilinx.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 014/104] soc: xilinx: Fix for call trace due to the usage of smp_processor_id()
Date: Tue, 16 Jan 2024 14:45:40 -0500
Message-ID: <20240116194908.253437-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 86a048a10a13..edfb1d5c10c6 100644
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


