Return-Path: <linux-kernel+bounces-124532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C9891972
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41211F22F63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918E148318;
	Fri, 29 Mar 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRdKUtsy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA091482FA;
	Fri, 29 Mar 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715319; cv=none; b=OTpk4aYKct+NdSioZPdpn6XwQb0f6RcQhP2qGmLNl6IY7Sb6DHGS0QwMRXq2WYsN1qaeC6Z3rZe8995gb9SC4EiVU+36YK69NNzVpScidftNcxAIS5xf8DFK4DTkpNMu1WEBY6TgBOyWQC3KHwIrNz1qEsqEBO7YK4wzJpGj+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715319; c=relaxed/simple;
	bh=JqUuGiDE40YrvaUE3aMQq/tZU7+N7m0ERzkVn3GKpeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh6OvyKIHeTcgDCYcGPToxNOBzu9D3omcAbbs/Ly0KYtI3YwztnrT95dqwX2endawYbOW0G7Ke1/Iq9B9KOOixb8G2rXINtegPkZ6yguqK9qYydjG4bTfQ1ywHZAjD6hijQEiv4ATJA3qqxn2U/hHxAuNpNPPbisOWD3Z9BKBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRdKUtsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B634C43390;
	Fri, 29 Mar 2024 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715319;
	bh=JqUuGiDE40YrvaUE3aMQq/tZU7+N7m0ERzkVn3GKpeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRdKUtsydTwOhKCrwk6pqT3kx//yVceF0JxhHF8tr0AiS8LGf0ytcVprOrTFdsI++
	 4pyRyl1D4SpmfqSyTbXseqcL+CiO3xy5TAdvqy9eDd3WLoS8Xnk5+js5RGG8Z00adH
	 tN+8ewYnuhUsojqaDUIUFq18W9JBuL1CWKo1HeLb1UL+OG1789Sq5/6SStNm6qcov6
	 JYhN4QMpniYH8rFqQM09WOjU6LM9NugQ9p+8NPm7COXVdD9VAepBea30tqrSioexrd
	 5i0L8WDnWmuB0nllIkxloxQiYRTeXsT7vi5DNQ755sxp/v06MZteQgu8LhNNG0RSJH
	 Ii+hBAgVq4ECA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 51/68] wifi: ath11k: decrease MHI channel buffer length to 8KB
Date: Fri, 29 Mar 2024 08:25:47 -0400
Message-ID: <20240329122652.3082296-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 1cca1bddf9ef080503c15378cecf4877f7510015 ]

Currently buf_len field of ath11k_mhi_config_qca6390 is assigned
with 0, making MHI use a default size, 64KB, to allocate channel
buffers. This is likely to fail in some scenarios where system
memory is highly fragmented and memory compaction or reclaim is
not allowed.

There is a fail report which is caused by it:
kworker/u32:45: page allocation failure: order:4, mode:0x40c00(GFP_NOIO|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
CPU: 0 PID: 19318 Comm: kworker/u32:45 Not tainted 6.8.0-rc3-1.gae4495f-default #1 openSUSE Tumbleweed (unreleased) 493b6d5b382c603654d7a81fc3c144d59a1dfceb
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0x47/0x60
 warn_alloc+0x13a/0x1b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __alloc_pages_direct_compact+0xab/0x210
 __alloc_pages_slowpath.constprop.0+0xd3e/0xda0
 __alloc_pages+0x32d/0x350
 ? mhi_prepare_channel+0x127/0x2d0 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 __kmalloc_large_node+0x72/0x110
 __kmalloc+0x37c/0x480
 ? mhi_map_single_no_bb+0x77/0xf0 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 ? mhi_prepare_channel+0x127/0x2d0 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 mhi_prepare_channel+0x127/0x2d0 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 __mhi_prepare_for_transfer+0x44/0x80 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 ? __pfx_____mhi_prepare_for_transfer+0x10/0x10 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 device_for_each_child+0x5c/0xa0
 ? __pfx_pci_pm_resume+0x10/0x10
 ath11k_core_resume+0x65/0x100 [ath11k a5094e22d7223135c40d93c8f5321cf09fd85e4e]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ath11k_pci_pm_resume+0x32/0x60 [ath11k_pci 830b7bfc3ea80ebef32e563cafe2cb55e9cc73ec]
 ? srso_alias_return_thunk+0x5/0xfbef5
 dpm_run_callback+0x8c/0x1e0
 device_resume+0x104/0x340
 ? __pfx_dpm_watchdog_handler+0x10/0x10
 async_resume+0x1d/0x30
 async_run_entry_fn+0x32/0x120
 process_one_work+0x168/0x330
 worker_thread+0x2f5/0x410
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe8/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Actually those buffers are used only by QMI target -> host communication.
And for WCN6855 and QCA6390, the largest packet size for that is less
than 6KB. So change buf_len field to 8KB, which results in order 1
allocation if page size is 4KB. In this way, we can at least save some
memory, and as well as decrease the possibility of allocation failure
in those scenarios.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Closes: https://lore.kernel.org/ath11k/96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240223053111.29170-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 6835c14b82cc9..337590236485f 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -106,7 +106,7 @@ static struct mhi_controller_config ath11k_mhi_config_qca6390 = {
 	.max_channels = 128,
 	.timeout_ms = 2000,
 	.use_bounce_buf = false,
-	.buf_len = 0,
+	.buf_len = 8192,
 	.num_channels = ARRAY_SIZE(ath11k_mhi_channels_qca6390),
 	.ch_cfg = ath11k_mhi_channels_qca6390,
 	.num_events = ARRAY_SIZE(ath11k_mhi_events_qca6390),
-- 
2.43.0


