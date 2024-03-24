Return-Path: <linux-kernel+bounces-112942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB7A887FEE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F8D1F23426
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1080C09;
	Sun, 24 Mar 2024 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR2xXuwf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE380612;
	Sun, 24 Mar 2024 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319755; cv=none; b=J2MVcaxSJBef/9WDkoiNDuCeGX+Q83t2hRdBIegoKc8fl2dXMTEcd4zny2aCiOuum7V99vaU7dLokBn0nv08IqrWaruEj+muStLW+j5siPAiJ4yMtZIIGzSl4hQ6d6JfBDVZ8gx0rf2XwRUG3Xgrmf9FozGdtmI3rRJ01xKeJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319755; c=relaxed/simple;
	bh=oYYvn/6nxGWAVbko5rNqBa3zP6x2dNPOvgw8qbioNx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWJzbTAgq3WMOPq8p2aRYYmawAaWrzNJ0cEZpMS/1RnAc0pIrDA/6Myol/1sg890KG5dQTGZIkk92RH6xCFj/A6tEFbSA4N6fNbReV4J8X3qMAyi/TyUD1Ztin7vSdI5hhg9Tu0gv7rra35f9qtHjBph4MJuKQDaMQa1JI4G9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR2xXuwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2D2C433C7;
	Sun, 24 Mar 2024 22:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319754;
	bh=oYYvn/6nxGWAVbko5rNqBa3zP6x2dNPOvgw8qbioNx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hR2xXuwfjXPU3owqX0ayc+3+aZbqYzJb+qJ4vMjD4v9jwhqRW9j96Pm/glurdb/PC
	 Q4K4S6Zyf6j0+BvsOLFmdUtVtIAxIW5U60+WUGpuwSrB6eO4wp0A7JBlhi2xQ0pd9j
	 C5Tyrh6M1JXD9vViLkgxsxOvDyu0A2nIu/Y8+GVGg3TaYtqIXtuVfEQXXDwrRK2fY2
	 fqNXRSoJAJJpy6OMdXta/JnHWrG3RJLzmBW/M826kRdbnFHq/crjZw53GOe7I0KlCP
	 DpGSqfu2M/zL4yuvdc0D/d48R92IoRdIHvV7s4gN/LoGia2x4dbVKjmipx89tSoWei
	 lHM422INdSLkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xingyuan Mo <hdthky0@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 055/715] wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Date: Sun, 24 Mar 2024 18:23:54 -0400
Message-ID: <20240324223455.1342824-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


