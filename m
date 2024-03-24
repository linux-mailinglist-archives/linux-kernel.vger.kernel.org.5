Return-Path: <linux-kernel+bounces-113650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6E888E27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B49297ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1AA8626C;
	Sun, 24 Mar 2024 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLTeUYrj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1A1D5F85;
	Sun, 24 Mar 2024 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320572; cv=none; b=m92xW0rw0AjuWAKTD6ZSDopxdzt4OVYBfuXlBsNMygIqMHnoVbO71eJJ3gCNT6EIpGvEt8JgPRVOlMq2R/yOk8Y8vtMXy9JElgVntyZGVzll4kmixAtcStU2xc24IJJ0C3jmJqpLjLsn2xS7XRfStSeDxpf9UkvkGjgsoteZlrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320572; c=relaxed/simple;
	bh=oYYvn/6nxGWAVbko5rNqBa3zP6x2dNPOvgw8qbioNx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMRkSwr4WqvlS3hhfXPIQKTbguVhbs3kkwU4CEXX4KwAgA2DDU0X9ENhc4ti8wREwzdyfxp+OJ1OQPh7AWrFrzHHcrWPxb9ecp4mf7nU6SMcDe1f2dN4keA+qjVf9aoxLFdrABQI4YFIVbBeBJK2KULoHTq+iOYiOoBv98lwYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLTeUYrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C1C433C7;
	Sun, 24 Mar 2024 22:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320570;
	bh=oYYvn/6nxGWAVbko5rNqBa3zP6x2dNPOvgw8qbioNx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLTeUYrjQSWbyOQIHgvLsD9+UtPBDnThyndGZ3H0qaFfNU6Q7rYXtoGrMMvZqQP80
	 wJ1NzWff6pmdTDxruaFvDGel2dIU2k+tyMtapvdvAfBbLpkVLfVZiW8FTBPCS4vpVe
	 c7u5p0PcVB86H9UHgJoexZ4iUniD35a+DXCNcAaAopeH1QfAiuJZTtcNJauTNur36A
	 Ub/lQHzen1V3iQ5Q6myITo4essSMRRxbNWf61Ass65D7eMmHDWy60/OkqDf4pM/N/e
	 ypBg0gKiiPBg++6gEV9XVktrJYnAR4M6TKDiSWtW1yJLOspC8joL37m+CPyavj0lPB
	 5Z/tWd2AxvrmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xingyuan Mo <hdthky0@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 131/713] wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Date: Sun, 24 Mar 2024 18:37:37 -0400
Message-ID: <20240324224720.1345309-132-sashal@kernel.org>
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


