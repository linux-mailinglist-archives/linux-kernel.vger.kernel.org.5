Return-Path: <linux-kernel+bounces-27964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A282F86C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5951C24F63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6513245F;
	Tue, 16 Jan 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI68yLYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30213243E;
	Tue, 16 Jan 2024 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434696; cv=none; b=LqDiyImfT8FdvAGkoplWqEXlPjs5q2jcSXDMqQgwNHKxrfgJW45/Wm4kRurFY5iF0R3e0DmrLtDBZl2pYbRm3NoJZlEQoRb59FJqrTGveIM+mKG2Dj4LLXa3Vx8irBjds2pRbiQlfElEQ8D6tSq2h4arS4OMVlOZl7Dr9iJB9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434696; c=relaxed/simple;
	bh=0crYvB0Mjou5nQIcJQGMG/46HLt1l6lK92oFyprBTxY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ZBm6ISV9y5ySrpzQBeYAJcCwjgNwalMKxAG/DTiNAIHH3vhfOgYjc91SAaYDQj+MyDJiMuvD8A3mNGoxouSzfsCR3F545gt887Jc6A1j1ZgbZ988809OvUA89QgKxKuW9U9nb77SVAg4nqXGcWZhrYpw6f3GAJZ/mZEdFc2VaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI68yLYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56C7C433C7;
	Tue, 16 Jan 2024 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434695;
	bh=0crYvB0Mjou5nQIcJQGMG/46HLt1l6lK92oFyprBTxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hI68yLYr7axKpg+Sic7Vl3ruUeCWpRYzfZRJxsWegdiS7ZMLJxYU12yBJHBNcQ1xU
	 JrWE09TR2jbFEcTqY33NDPeXI81yHMKURKB6FmmuWExxr4yTM5a5w2XxAMPzRuj7GU
	 s4Uh1FJy0XMdXAuEGGASf8lT64mFHoxw9+XGR4lhGlxXRQhcpIseJ7tOoqqOeUg4hQ
	 BPksAXaujAABmZhxOXqCvAZosiM2Ly4Zjf/M6FyUpDCFSH7D4WhxzaFco1WOD2PNjZ
	 ebmZaZ7n3q0Z017PQoZy548C6r7qip5ChDRJqH31R85rWh8m52aJOMIfL33VZrgKjt
	 ORjYgsKoBUqBA==
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
Subject: [PATCH AUTOSEL 6.6 053/104] wifi: ath12k: fix the issue that the multicast/broadcast indicator is not read correctly for WCN7850
Date: Tue, 16 Jan 2024 14:46:19 -0500
Message-ID: <20240116194908.253437-53-sashal@kernel.org>
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
index e7a150e7158e..b49a4add8828 100644
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


