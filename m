Return-Path: <linux-kernel+bounces-28000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A3482F8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32883288C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D115BFEF;
	Tue, 16 Jan 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InhAanNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C25BFD3;
	Tue, 16 Jan 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434810; cv=none; b=GZcjU5SIx5/wT4+BtuwraXwhnfMKEkpPJkmbOqzh7kurIDzqzzZTF0E+AYZo+OyLv2OPIsXYRTkXOTXY2kTT/MXGexacHkc1sdFEG6VYHj6k30HeMvO7xK9jbRD9LuxRNvZwiQtNf5DgaHUJ3LG3j/ByoyrhY35ReDaHdleT420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434810; c=relaxed/simple;
	bh=5QYpzRbhgZ+uxoC3ZbfDHg98h5nJ5f+DeeyZWxmI4aA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=HJWfNW3z92lfcZCrEZa55aAjkGZdA+vsHBtHgTik1owAzcWBQDT4OvBGmUoYlSiyo7/+PWKXGAwNqwUuHGPnzPag2ueRQN3d8wj/FSdzPN7rIujpv083qx4pjPtZfYqlcSbjBJN/k3K1J6Ltij6izp4YbOLf93NkyS/iSkaEnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InhAanNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB15BC43394;
	Tue, 16 Jan 2024 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434810;
	bh=5QYpzRbhgZ+uxoC3ZbfDHg98h5nJ5f+DeeyZWxmI4aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InhAanNbC/bU+jl7x1UuEZyAg/gNR107TC6v89DxN3FBETB7M8Q/k5lpH4yy7DTKj
	 D8srqrR/ovHditJoRSvhYjQXQuH+EmAGzAdkCeSquYf7tZFf+utcxbW8yTsn48EkmP
	 BngxeQD39E/sU8zhosqhmePO1zWydiJigzTqkyulp1FSKaIB+exuE3pdWpo7SpiUfZ
	 a/GZ95G6xI8tuLv4kdoTsCBZGjZTefKSBeWFmw9wiemqVE7xwhDRES50vLLfuOgqei
	 ijckQ2V/TN+20zTUfSr/3IOxqN3f8U7DijitTFS/AbmN4iaEISDLQfuWA6yqM2eizl
	 t6Qk0mr4PikKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ching-Te Ku <ku920601@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 088/104] wifi: rtw89: coex: Fix wrong Wi-Fi role info and FDDT parameter members
Date: Tue, 16 Jan 2024 14:46:54 -0500
Message-ID: <20240116194908.253437-88-sashal@kernel.org>
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

From: Ching-Te Ku <ku920601@realtek.com>

[ Upstream commit acc55d7dd4de525ac07e43e90ea3cc630677ec8a ]

The Wi-Fi firmware 29.29.X should use version 2 role info format. FDDT
mechanism version 5 use the same cell members to judge traffic situation,
don't need to add another new format.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231218061341.51255-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/coex.c |  4 ++--
 drivers/net/wireless/realtek/rtw89/core.h | 12 +++---------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 4ba8b3df70ae..6ab1b6ffbb50 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -131,7 +131,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtcrpt = 105, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
-	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,
+	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,
 	 .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 57, 0),
@@ -159,7 +159,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtcrpt = 105, .fcxtdma = 3,  .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
-	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,
+	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,
 	 .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 14, 0),
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 04ce221730f9..ee6ae2a0c798 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2230,12 +2230,6 @@ struct rtw89_btc_fbtc_fddt_cell_status {
 	u8 state_phase; /* [0:3] train state, [4:7] train phase */
 } __packed;
 
-struct rtw89_btc_fbtc_fddt_cell_status_v5 {
-	s8 wl_tx_pwr;
-	s8 bt_tx_pwr;
-	s8 bt_rx_gain;
-} __packed;
-
 struct rtw89_btc_fbtc_cysta_v3 { /* statistics for cycles */
 	u8 fver;
 	u8 rsvd;
@@ -2299,9 +2293,9 @@ struct rtw89_btc_fbtc_cysta_v5 { /* statistics for cycles */
 	struct rtw89_btc_fbtc_cycle_a2dp_empty_info a2dp_ept;
 	struct rtw89_btc_fbtc_a2dp_trx_stat_v4 a2dp_trx[BTC_CYCLE_SLOT_MAX];
 	struct rtw89_btc_fbtc_cycle_fddt_info_v5 fddt_trx[BTC_CYCLE_SLOT_MAX];
-	struct rtw89_btc_fbtc_fddt_cell_status_v5 fddt_cells[FDD_TRAIN_WL_DIRECTION]
-							    [FDD_TRAIN_WL_RSSI_LEVEL]
-							    [FDD_TRAIN_BT_RSSI_LEVEL];
+	struct rtw89_btc_fbtc_fddt_cell_status fddt_cells[FDD_TRAIN_WL_DIRECTION]
+							 [FDD_TRAIN_WL_RSSI_LEVEL]
+							 [FDD_TRAIN_BT_RSSI_LEVEL];
 	__le32 except_map;
 } __packed;
 
-- 
2.43.0


