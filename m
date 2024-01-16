Return-Path: <linux-kernel+bounces-27825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6095282F66D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 025E8B21D79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71593527F;
	Tue, 16 Jan 2024 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc+FwEQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC16347BA;
	Tue, 16 Jan 2024 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434292; cv=none; b=VjXlgbvv1hIlS87ouPSQVz74OG/j7WpFp2QOtvvCstRoxljDtkThqjC+ZOpgApyFLfsmaikOpPI6gB5dGxvBlVhkACjeGUAgSYGX9EttsrQNha6Vx8wAWoW5ChavIZl5veq4PqT3vi/ipgxg8eWQtD9f1+bjQ/f2cBXiKSu2KnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434292; c=relaxed/simple;
	bh=D750ABmyPdR0sdVilRzaxbbPUulq4xyX/K+IEdq8uyw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=POXe/B8dsvAITiF8y7lMxK4PPTqBXi9ZmBwoizsTGtqQZpq+DvboAkb1Qkvzq72Q+HaEmha2180/dW+mdjG59m+ikcv5ZUAYnowU7dQWtbs5c8qG8ZPTz4mQPFN7+XvZ1lE8DXnKfEhdP4NfyuNypeJ9gosWq3DARfP/xmsx4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tc+FwEQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7AEC433F1;
	Tue, 16 Jan 2024 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434291;
	bh=D750ABmyPdR0sdVilRzaxbbPUulq4xyX/K+IEdq8uyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tc+FwEQLTIpUe3yvg7CjM/HRBT/iCx/Wgp1O6f+SfdNK+q3KnWSS3nZAWtoRnRCEG
	 /tNio+9ye/z/+0JB1Fbs6W7mcgofHzpDRfNI+xcN8Byp/JJxAB1yHapWkXV9lIGAIC
	 A7tzVI0F7ux6tSJ7vbuz+F4JRbgl//k1NfE17AxLOjL9+4AJroukcIuxQcivMl12bs
	 pcjAQPAScgaAGNlewg5j+wQjF5KQ5VOgV0XPDx54AIiGDKu97XBqcwGrP5cFBY8YZJ
	 3C6KMyFrv2gAHZNV370daE984OeDUUJ+wqRgfuns/Dyv4TvPel9+bFqUYOiViIThQY
	 Z3DPiAqeevyGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lingbo Kong <quic_lingbok@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	quic_jjohnson@quicinc.com,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 054/108] wifi: ath12k: fix the issue that the multicast/broadcast indicator is not read correctly for WCN7850
Date: Tue, 16 Jan 2024 14:39:20 -0500
Message-ID: <20240116194225.250921-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Lingbo Kong <quic_lingbok@quicinc.com>

[ Upstream commit 7133b072dfbfac8763ffb017642c9c894894c50d ]

We observe some packets are discarded in ieee80211_rx_handlers_result
function for WCN7850. This is because the way to get multicast/broadcast
indicator with RX_MSDU_END_INFO5_DA_IS_MCBC & info5 is incorrect. It should
use RX_MSDU_END_INFO13_MCAST_BCAST & info13 to get multicast/broadcast
indicator.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20231206141759.5430-1-quic_lingbok@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/hal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index eca86fc25a60..b896dfe66dad 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -889,8 +889,8 @@ static u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 
 static bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le16_to_cpu(desc->u.wcn7850.msdu_end.info5) &
-	       RX_MSDU_END_INFO5_DA_IS_MCBC;
+	return __le32_to_cpu(desc->u.wcn7850.msdu_end.info13) &
+	       RX_MSDU_END_INFO13_MCAST_BCAST;
 }
 
 static void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-- 
2.43.0


