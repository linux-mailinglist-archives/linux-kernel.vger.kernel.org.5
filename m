Return-Path: <linux-kernel+bounces-114818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC634889184
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827501F2CE67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DE32C010C;
	Mon, 25 Mar 2024 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXC0Zhcg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173E176555;
	Sun, 24 Mar 2024 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323438; cv=none; b=KVENwkwNu1gQvP9f14BBhYXOXf71GkxBWgpdfIu5sJ8ZiqEseWmCrR9k70QewhfWq/M82i3o6vPG1EYn9SdRtkIC88oD+l5aARLCX6fd2j79BpsmUiLhTKLIgiQHVZ88M1kDXGdk0y3cvBtjG9u7QD17u9HjPn+0coPRYLS9FK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323438; c=relaxed/simple;
	bh=kJjdOHZSQ3JQSc876NAE7w9DAZ6WFWU9xIDvGyUZ0t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/BSnDSYbSyXN5sfHWKCf5R3uVh685FUoJl+yuNm+trVoUH9vgPQUIeABgRId5vdHSBs7DhQ7uyY1CgMg3pM2482EQAzcgvSxx/xYOp281Az0hIkzCBA0Gjx1b8PfV9IHUrWSx5MnbjTN8IKmTuJGJgQxv8g/UkmekKlFXwX2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXC0Zhcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26783C43394;
	Sun, 24 Mar 2024 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323436;
	bh=kJjdOHZSQ3JQSc876NAE7w9DAZ6WFWU9xIDvGyUZ0t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXC0Zhcg2xjGrs32LFD6akvsKGe8Y1CLrGhTq/wR/6YSPlp7xUGVs0iuxsxkGQh4g
	 TBnFbSBHU+KeNLgTQKHlHTQnIgSwDwysotv+9QoVNlGtDnXhh1CkLmjiEaqM85CpBg
	 k14a5/prpKrk5pGVyW8/u8zpeFft530+df3d+FB/givWmxW+zdStrxsFSlBuY/N+Rc
	 Vr1njL9jEbihRjioh5xF/dHToIfOBWQfwtkVKQWakIvus3u4GAAiYAbtJ2k03wIyUW
	 jM/fr9Jt6bIFQ2nh5CJ93b8N/fDeS+r8odNObBsoiF+NiRZHjhUgGpt0bR9HxgSXlk
	 8wLEeH+N88dwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonglong Liu <liuyonglong@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 139/317] net: hns3: fix kernel crash when 1588 is received on HIP08 devices
Date: Sun, 24 Mar 2024 19:31:59 -0400
Message-ID: <20240324233458.1352854-140-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 0fbcf2366ba9888cf02eda23e35fde7f7fcc07c3 ]

The HIP08 devices does not register the ptp devices, so the
hdev->ptp is NULL, but the hardware can receive 1588 messages,
and set the HNS3_RXD_TS_VLD_B bit, so, if match this case, the
access of hdev->ptp->flags will cause a kernel crash:

[ 5888.946472] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
[ 5888.946475] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
..
[ 5889.266118] pc : hclge_ptp_get_rx_hwts+0x40/0x170 [hclge]
[ 5889.272612] lr : hclge_ptp_get_rx_hwts+0x34/0x170 [hclge]
[ 5889.279101] sp : ffff800012c3bc50
[ 5889.283516] x29: ffff800012c3bc50 x28: ffff2040002be040
[ 5889.289927] x27: ffff800009116484 x26: 0000000080007500
[ 5889.296333] x25: 0000000000000000 x24: ffff204001c6f000
[ 5889.302738] x23: ffff204144f53c00 x22: 0000000000000000
[ 5889.309134] x21: 0000000000000000 x20: ffff204004220080
[ 5889.315520] x19: ffff204144f53c00 x18: 0000000000000000
[ 5889.321897] x17: 0000000000000000 x16: 0000000000000000
[ 5889.328263] x15: 0000004000140ec8 x14: 0000000000000000
[ 5889.334617] x13: 0000000000000000 x12: 00000000010011df
[ 5889.340965] x11: bbfeff4d22000000 x10: 0000000000000000
[ 5889.347303] x9 : ffff800009402124 x8 : 0200f78811dfbb4d
[ 5889.353637] x7 : 2200000000191b01 x6 : ffff208002a7d480
[ 5889.359959] x5 : 0000000000000000 x4 : 0000000000000000
[ 5889.366271] x3 : 0000000000000000 x2 : 0000000000000000
[ 5889.372567] x1 : 0000000000000000 x0 : ffff20400095c080
[ 5889.378857] Call trace:
[ 5889.382285] hclge_ptp_get_rx_hwts+0x40/0x170 [hclge]
[ 5889.388304] hns3_handle_bdinfo+0x324/0x410 [hns3]
[ 5889.394055] hns3_handle_rx_bd+0x60/0x150 [hns3]
[ 5889.399624] hns3_clean_rx_ring+0x84/0x170 [hns3]
[ 5889.405270] hns3_nic_common_poll+0xa8/0x220 [hns3]
[ 5889.411084] napi_poll+0xcc/0x264
[ 5889.415329] net_rx_action+0xd4/0x21c
[ 5889.419911] __do_softirq+0x130/0x358
[ 5889.424484] irq_exit+0x134/0x154
[ 5889.428700] __handle_domain_irq+0x88/0xf0
[ 5889.433684] gic_handle_irq+0x78/0x2c0
[ 5889.438319] el1_irq+0xb8/0x140
[ 5889.442354] arch_cpu_idle+0x18/0x40
[ 5889.446816] default_idle_call+0x5c/0x1c0
[ 5889.451714] cpuidle_idle_call+0x174/0x1b0
[ 5889.456692] do_idle+0xc8/0x160
[ 5889.460717] cpu_startup_entry+0x30/0xfc
[ 5889.465523] secondary_start_kernel+0x158/0x1ec
[ 5889.470936] Code: 97ffab78 f9411c14 91408294 f9457284 (f9400c80)
[ 5889.477950] SMP: stopping secondary CPUs
[ 5890.514626] SMP: failed to stop secondary CPUs 0-69,71-95
[ 5890.522951] Starting crashdump kernel...

Fixes: 0bf5eb788512 ("net: hns3: add support for PTP")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index befa9bcc2f2f2..dd0750f6daa6c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -120,7 +120,7 @@ void hclge_ptp_get_rx_hwts(struct hnae3_handle *handle, struct sk_buff *skb,
 	u64 ns = nsec;
 	u32 sec_h;
 
-	if (!test_bit(HCLGE_PTP_FLAG_RX_EN, &hdev->ptp->flags))
+	if (!hdev->ptp || !test_bit(HCLGE_PTP_FLAG_RX_EN, &hdev->ptp->flags))
 		return;
 
 	/* Since the BD does not have enough space for the higher 16 bits of
-- 
2.43.0


