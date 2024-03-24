Return-Path: <linux-kernel+bounces-115181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A81889343
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858C31C2E3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42C1C9EC1;
	Mon, 25 Mar 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA+J2DWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791072922B2;
	Sun, 24 Mar 2024 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324247; cv=none; b=Yz4MkXfwqWu5Nc9mbDXpkIbXpx9H8nJ0QIwxK9EBWavWZLnJMg4aI3kdoezQYoWimHl48OEmBQKbFrH3PedZJuz50T0kU1HpNWLpFwv6WoP2Ve/BW0iBNyiQJO5bIjEoIJrtzoZTfFjuQC0dg+jLcLivPxoKwGA1uAmHGgW+OSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324247; c=relaxed/simple;
	bh=JXlbG+tRxwqUWRpCzakl4kGGlgD5ASN65oakHttJqHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvB3VW3YDSTHSBWH07okO+f7qCgVXepxMGdEqwp1Gh9cWOkXechbhSSnCjzjYf8aDYwRfPVUXCcgcDcB+MnrEW9ImB0L7iKhVq79sqBZqvPNX7q+Wuxe4PgymsM/GlldO8LI29PCEWH9qUepaMKuYx/2hbuv5AKuOAuZP5obwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA+J2DWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A3BC433C7;
	Sun, 24 Mar 2024 23:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324246;
	bh=JXlbG+tRxwqUWRpCzakl4kGGlgD5ASN65oakHttJqHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hA+J2DWr6/CzfuQ/znmuKe+XJGIR5cp78s17SFU7x6XUC522WKE68tGcUPBwYyHmD
	 glwflRpsXeGQ9QWCY4kYsB9gjeBgCcxtqdHxBMp2IE+0tdkUQOgLGKehcZgYkAY5Xi
	 zUYVDig/9vXmbj+EPjUah1k5n7xmrlfYyTmi63DWVw4vNh/TsIqcF53SoM9yOD6YRn
	 MJXgIJnpgDfZzYscGGpw/spsoau4dBzawO7YHfCDVXYNFWGErZyI8Cvjsx6eNHI4Wl
	 G4JFrLtCcbnbKn1pvJCzbc6+x3OqYSiZ3qy1SOOn6NAkIYt0HLPHcT/S2V9k61o1ar
	 wcPPQShbN5jqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xingyuan Mo <hdthky0@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/148] wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Date: Sun, 24 Mar 2024 19:48:12 -0400
Message-ID: <20240324235012.1356413-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 243887fdb343e..c9df78950ff4b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -684,6 +684,10 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k *ar, struct sk_buff *skb,
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


