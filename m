Return-Path: <linux-kernel+bounces-114953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C040888CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F83B23458
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065F41BEDDD;
	Mon, 25 Mar 2024 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usuQKY8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BB179FDF;
	Sun, 24 Mar 2024 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323668; cv=none; b=hatJlYRlXxTh2kexdiQ84vzu7Ab2MORZktdZF9c0Gcw+z9rNPc2PUYjoYTdqHsRKrO0aQBrSrT3g991sVTc86gn9emk+ZtMr510HKfcLHguvqKjRB+OzIfkzUHdycqoyUFfwibbneNGIQ1gCcIrzV6M0OS+S+Q2Bwg8G5oA4y3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323668; c=relaxed/simple;
	bh=KO8CixSl6mJgAcFcZpVjUBVD4cWMv0wovfQtZ3hH+DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSpk++LvR3R+dvtpDRsxlCvR3KNyaXLTmDLwvU6sUPvcNlBMbnYRBjGVp98clNRwTREG0hawh8t+xyVAsJQ90CDckRjZzObKX0N3lhr/Oqm3m7pXS8N4wAuZUAydgx/MSL12OeWUulCCewgS4H1ryw/4Hr7ZNrBaMs/qPlyodRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usuQKY8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAE9C433F1;
	Sun, 24 Mar 2024 23:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323667;
	bh=KO8CixSl6mJgAcFcZpVjUBVD4cWMv0wovfQtZ3hH+DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usuQKY8VquHjVMvvYYd0XXN45nYRM+ZcsZSbXvkFVY9yD6abzy8j5L5U3ZQttUWyu
	 oH0GwWPWpICh1XBHxE7XLvSCeMXwOubfbIXJsEkrATGvqTUBKvwsJHKZRZSB8uxqkm
	 vPfogku4oeEQGkroyul8aI0LAquXgmK5puCKP7MgbKeWJYYqe6GukUoWp5r/SIL9BM
	 JW7nxM3Srm5UsviIomOLf1WmS2cKV66MB/4eFkSG25RWvuKRJZMkYNxUEE7X8GH1nU
	 xBIrNPspRE8R03O58yt+YAdGYA9+74qbp7xTSZwZAoaeOc5G7kGdq/0kFx9Yvx9Ken
	 dO3Cv8uu0ahRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xingyuan Mo <hdthky0@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 039/238] wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Date: Sun, 24 Mar 2024 19:37:07 -0400
Message-ID: <20240324234027.1354210-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 4f2fbc610d798..0eeb74245372f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -844,6 +844,10 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k *ar, struct sk_buff *skb,
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


