Return-Path: <linux-kernel+bounces-114751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1D68890FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB68B1C26F99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708A13D284;
	Mon, 25 Mar 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK9QyzRo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94132219543;
	Sun, 24 Mar 2024 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323350; cv=none; b=Tq4aB4bPRUEaka2S3wP0kuwGdzBGtHA4w0Z1oA36GSJt2Jl8hk7Dl4sKMIjHNbLByAwjY8DMNyl47QEF1FKdTfNa5T0uiTOexupRyJ+Osh02pWiljIhMsivf1YfawDHGdEin2SyrBN6/UgFKWzqwSJ7lo691BizYDvGR8tb9wvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323350; c=relaxed/simple;
	bh=xmtqkWTODmXjADlJwYaL6d+EDtCCdjOUJyLKvhJG4/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiEuITcp6uTmW9WLyxDPit073NVDLiLlAYCtp0NEWBmXR2dU/Egy2+/MWPqekyC1+RJpuKACUN0Mx51KnZqOv5CnzuwEX21JUbqGXfZN7KxYBZFhJCA10tD1ZdmflJPsqvyL355q32FdCZk6F8LbumGIY2g0b/cfAb1EogZblQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK9QyzRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B872DC43399;
	Sun, 24 Mar 2024 23:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323350;
	bh=xmtqkWTODmXjADlJwYaL6d+EDtCCdjOUJyLKvhJG4/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nK9QyzRoYruGQffyGtTLrPHNSQ2H3ua9UWVc8C94VlVLQWrI7pol5lepGZggnG5Dg
	 VwzWdGoe5GvWleXiP1k0nW0FCHEBiNKFH0dOJ8n+GltqieRWJI6UOT68FBg8dTN9a+
	 Lkl5FPXP2w1aXNRPB+y93hnJtg9Ki1pFWoPzZm1UKb9TQj8Sn/1xhWgXr24C2lF1C/
	 ERVP5fcLS3ob3XcMh7/PJRJ/TYjn1Y0FXb4pSwk4LCbyVQBf2q0DfjbQhZBfaWg9B8
	 EdE4o9Jx2+5UxJG+oHwvImrTWQNAoMgGszV3ScUt0644tYLjhO9i0RoRJbFR0iM+NI
	 gFKC23raE3TxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xingyuan Mo <hdthky0@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 050/317] wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Date: Sun, 24 Mar 2024 19:30:30 -0400
Message-ID: <20240324233458.1352854-51-sashal@kernel.org>
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
index 7efbe03fbca82..d5dafbecc1845 100644
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


