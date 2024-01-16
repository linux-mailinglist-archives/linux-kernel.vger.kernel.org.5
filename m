Return-Path: <linux-kernel+bounces-27863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31782F6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0732BB24177
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E986166E;
	Tue, 16 Jan 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myRaPg4w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79660EE7;
	Tue, 16 Jan 2024 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434391; cv=none; b=UntxFNVFuw2w3ipgIXpaNmQZIbYigg73gTLepE1auRnbfYQ84q2YPn5en1VlNwdt6/sPIEP0uujfvB4uBAlWEe6LmuBWpDzlCrcknVEeIsAs5Hosebk/bAJh+1tXunSyRvN/Fm7aisyJJOohzrePdR4R3H/jfz3EkiAlMyyZHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434391; c=relaxed/simple;
	bh=PA3DB4DoSiGHFmaUE4UnMNsI9MEwD2pOFRYNMBa34ps=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=l9QRWQYsb9kwXM33jJ/buS5495cGcQQMc7zjfga6PJTIQGhPPl4ktQtCO0bQGKm+Akg8XWnRPxteX+/SwozuBkL9nhgzOzEIv+ZO/JGJHBt0P1cyKLpykcUoVFwWQc4NPzSkpT5kFMHqhhqUh3PaUWr2wn7ogmwJIkt3OhPwIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myRaPg4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6301C433C7;
	Tue, 16 Jan 2024 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434391;
	bh=PA3DB4DoSiGHFmaUE4UnMNsI9MEwD2pOFRYNMBa34ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myRaPg4wgq0s2lLe0TFXUAuAZ59HscgVPL/85F8jfEPAI16vc8G/0haSf8cXxx2Bt
	 P8Rp7kD+tQq7VUcg+gIHBOrFJX3Uz7FAVamGfAisOELkQTldZc8+NeNBJH5Tz6fLeS
	 5qjs2eTAmw9jfq14webEGKVCdd5Qw+BC2MOYDmHByaJ6fUchfNm0pS4cLajSIcuMZx
	 ObUhg0/tzjmyeP3p1MZYFtabJsRO8nFc4tZszkPJXXEm29zPfUxz9UVzDusbxK85O/
	 K6cWQL53x8x4zBucwr6+V7fmdeKVxazHgyMQgtJ+Vt4LYgHs7sNB6iYWqvWY29Zd9N
	 RSN6VCZOdmA9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ching-Te Ku <ku920601@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 091/108] wifi: rtw89: coex: Fix wrong Wi-Fi role info and FDDT parameter members
Date: Tue, 16 Jan 2024 14:39:57 -0500
Message-ID: <20240116194225.250921-91-sashal@kernel.org>
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
index bdcc172639e4..ace7bbf2cf94 100644
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
index 91e4d4e79eea..8f59461e58f2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2294,12 +2294,6 @@ struct rtw89_btc_fbtc_fddt_cell_status {
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
@@ -2363,9 +2357,9 @@ struct rtw89_btc_fbtc_cysta_v5 { /* statistics for cycles */
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


