Return-Path: <linux-kernel+bounces-113670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702E8885E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C461F2436C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5F143889;
	Sun, 24 Mar 2024 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e27uNjqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AD143886;
	Sun, 24 Mar 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320626; cv=none; b=XKLPsiAbz8UWWI+TStTZT/jS9ZQ+navJ0XahwLeJ/pqYEXcTimAOVev9SbTXbpPLbQc4LNgRXwkxvyR87ij38ubEraHK7eKcj4/crBftWs1o9FpJBfneuv0x/nXs6zDMwYkB347NaNlD29lyhEVunczRnKZgb88AB12UB8LRCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320626; c=relaxed/simple;
	bh=CCMTvASji0/stHiT5ImMEo2vqL9mPQDDspFCl9RXgnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1FOLGB1P/iqEzYj2XlZ3kHqI32MHQjodDDyf0G4ZVBA6WD963rZYKYRNH9+B5UDtPtUhcEgBeHY7MabwP6WO4FKqLWVaZz2hQEpFjLK+Ietf6wl4/aDdbC/OiFSBACLuu804wM0QBsrT4dsFkoQtG0TA7jEo/oquic5caWmrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e27uNjqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AF7C433F1;
	Sun, 24 Mar 2024 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320625;
	bh=CCMTvASji0/stHiT5ImMEo2vqL9mPQDDspFCl9RXgnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e27uNjqe4ue7Q7+ITKOAtj0soAoWV+CsvKAaPxbWl4PKeq5pm1edU400yxE4tEFrP
	 Q9uSa9ICXMcMZbps6WC2f55kmfMchTE2aiByA4oFhW0E5u7h3P6AhriX4/Cwh1sg6l
	 0qijpGHMA9m4lKsknRTM3O4skNUJ//f1wWQVjy4ObaHHg9i5jhOvF6pYX0K+nUGZwP
	 qYqxH3leZ5913OlJqcAh7ErQhWW/1Izq9IYHwpWU3BVsXw4zwRopqiQucwPucTIwo+
	 vznAJKude0NOqCWOcYQSh1eOPeEm5HTk5zrfhH9C0m7Bgl3ClQHgNTqzDV8u42Hsn4
	 YwUVTwi0U5aTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 187/713] wifi: ath12k: fix fetching MCBC flag for QCN9274
Date: Sun, 24 Mar 2024 18:38:33 -0400
Message-ID: <20240324224720.1345309-188-sashal@kernel.org>
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

From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

[ Upstream commit 902700d55d4a4522bb3eb4ef94f752a19c42230a ]

In QCN9274, RX packet's multicast and broadcast(MCBC) flag is fetched
from RX descriptor's msdu_end info5 member but it is not correct
for QCN9274. Due to this with encryption, ARP request packet is wrongly
marked as MCBC packet and it is sent to mac80211 without setting
RX_FLAG_PN_VALIDATED & RX_FLAG_DECRYPTED flag. This results in packet
getting dropped in mac80211. Hence ping initiated from station to AP
fails.

Fix this by fetching correct MCBC flag in case of QCN9274.
For QC9274 MCBC flag should be fetched from RX descriptor's mpdu_start
info6 member.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 8f04852e90cb ("wifi: ath12k: Use msdu_end to check MCBC")
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240129065724.2310207-5-quic_rajkbhag@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/hal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index a489369d80687..1bdab8604db94 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/dma-mapping.h>
 #include "hal_tx.h"
@@ -449,8 +449,8 @@ static u8 *ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 
 static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
-	       RX_MSDU_END_INFO5_DA_IS_MCBC;
+	return __le32_to_cpu(desc->u.qcn9274.mpdu_start.info6) &
+	       RX_MPDU_START_INFO6_MCAST_BCAST;
 }
 
 static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-- 
2.43.0


