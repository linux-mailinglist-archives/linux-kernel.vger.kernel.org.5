Return-Path: <linux-kernel+bounces-94807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB2874578
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26512841C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5AC610D;
	Thu,  7 Mar 2024 01:06:22 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178CC5227;
	Thu,  7 Mar 2024 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773581; cv=none; b=I10geHdI8S1uH6M22gDQ0O94JZoNOQoLd8bLU4KZXjE8nZqGIIWRHsaLSxOiW0q4sahGiXhwdICebA1YUzXjqSSkHRzW3R84q1Tfm1FwbRmTQRQr8ahcDkpSQnmXUQyMmf4m6LLnugfNJHk5EVjwjWve1eIRybqGo/lObZQXW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773581; c=relaxed/simple;
	bh=5TnHLnIxCUPmyXV7BiLGxZaqnCD+czqXaiIk3hXPYO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaFeNjK00ssVc1WczjpiIRzFFmIvJXV31OXXCt0/xw8FUFAF0SIVnNLMJWJHy67HH/q6r9UMvYjAQYISe0GIfeYR/laTX/u6mVmeIsZhvxr/KtnbiKdpGwrkgjBrPZnOHE9YyLCAT+De7eFxfa9aO8tN6IOj0XeOivTfdT830jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TqrfM0nHGz2BfLr;
	Thu,  7 Mar 2024 09:03:55 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id BDC4E1402C7;
	Thu,  7 Mar 2024 09:06:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:06:16 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 4/8] net: hns3: fix kernel crash when 1588 is received on HIP08 devices
Date: Thu, 7 Mar 2024 09:01:11 +0800
Message-ID: <20240307010115.3054770-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240307010115.3054770-1-shaojijie@huawei.com>
References: <20240307010115.3054770-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Yonglong Liu <liuyonglong@huawei.com>

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
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 80a2a0073d97..507d7ce26d83 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -108,7 +108,7 @@ void hclge_ptp_get_rx_hwts(struct hnae3_handle *handle, struct sk_buff *skb,
 	u64 ns = nsec;
 	u32 sec_h;
 
-	if (!test_bit(HCLGE_PTP_FLAG_RX_EN, &hdev->ptp->flags))
+	if (!hdev->ptp || !test_bit(HCLGE_PTP_FLAG_RX_EN, &hdev->ptp->flags))
 		return;
 
 	/* Since the BD does not have enough space for the higher 16 bits of
-- 
2.30.0


