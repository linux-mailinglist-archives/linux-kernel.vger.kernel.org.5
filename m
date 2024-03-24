Return-Path: <linux-kernel+bounces-114093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35AD888F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E42A28EFE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB402398A8;
	Sun, 24 Mar 2024 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSicI1/l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83523200A29;
	Sun, 24 Mar 2024 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321390; cv=none; b=orTQn3qCW8EDCIkv33Lh2rt5562EIVsncNRFWODw01V//3aa71XeHVkA2s1PwUDacELYBDUjAFaD4ttLLtmAyQsOSPRbwLJtA3KRr4kv4ycYrsJOBIw5at5je3jrVksDBfe5Nzbnd4Htu8THKAXbcbQQj1tUDqrd0uEPDJb024M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321390; c=relaxed/simple;
	bh=oYYvn/6nxGWAVbko5rNqBa3zP6x2dNPOvgw8qbioNx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os8M25Fu3GTuz8WFxcYdWo9ADb1VPcNRM4YugfxY5JvdG/Ltgc2nGWwmKFkpYKUGHFm0TNUQxOH3iTRYnGaEk9FEiqmc6EvAi98qGT+zyw39RTdzxAVdQhGFHt5vHJ/UnZjb7Ev3ZjvaXGrbII70nRIT2baFWM/BGTzLzle9Rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSicI1/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB778C433C7;
	Sun, 24 Mar 2024 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321389;
	bh=oYYvn/6nxGWAVbko5rNqBa3zP6x2dNPOvgw8qbioNx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSicI1/lBtrDUzUCTrZNI73tYWKXiUUt1bRX2gQodHIljctpmHeAjyzZEneRPcH4l
	 vLBD76DCdrftZraQMVEmB3ZbdvTxOErK2kX/wnHWhVr+JQ6lx/G6R0IEPdu569j9DR
	 tGUcufE+CU1HeuST0bNIhMIK/lqkZdwFTi3kElBo262vz/N/QILt98k0WKpnQLGDS1
	 5jQfVJgjIOBMm66BKi8VhNrhhT8f4iMeboZzxaMgfnp0dStPONbNXBoIBBHKBKtWLM
	 QnlVzBWL85mixFWxQeg93fM1M44yEMoE6g50quTBGLeq+SRm/Gn69pB24BW7UroAWK
	 Yg/s8H1hQWEZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xingyuan Mo <hdthky0@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 113/638] wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Date: Sun, 24 Mar 2024 18:52:30 -0400
Message-ID: <20240324230116.1348576-114-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Xingyuan Mo <hdthky0@gmail.com>

[ Upstream commit ad25ee36f00172f7d53242dc77c69fff7ced0755 ]

We should check whether the WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT tlv is
present before accessing it, otherwise a null pointer deference error will
occur.

Fixes: dc405152bb64 ("ath10k: handle mgmt tx completion event")
Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20231208043433.271449-1-hdthky0@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 6b6aa3c367448..0ce08e9a0a3d2 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -851,6 +851,10 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k *ar, struct sk_buff *skb,
 	}
 
 	ev = tb[WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT];
+	if (!ev) {
+		kfree(tb);
+		return -EPROTO;
+	}
 
 	arg->desc_id = ev->desc_id;
 	arg->status = ev->status;
-- 
2.43.0


