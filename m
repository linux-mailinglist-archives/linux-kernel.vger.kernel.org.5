Return-Path: <linux-kernel+bounces-113179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092FE888216
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36D21F218AF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4341176A19;
	Sun, 24 Mar 2024 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVWTE4fv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB6176A03;
	Sun, 24 Mar 2024 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319982; cv=none; b=glt+Qy0QiBWjjQI50gPb7Ft+EU1oh1y7l/FB9tY0W/ZOUtOnYaiL5jnpkSv3H1KXu7S04JSajZZw+syLbI+ZuLlzRywbCJLfj3KAZQE7Y36CWSh3/8Hv5VIdcbSMyegCTX5U0ZQsGWjm+OvxizF3UTQoOryhRBusxDg6saxthFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319982; c=relaxed/simple;
	bh=1Ex5kFBpZC5U0wW56mG+2vwHB7YDpbOowaTErJyFC9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG2wQi54QBXyAYM526RHI1oaiBYmgWnIzdG9VSXlzG1xcWSEgQyDrwL6bcWm/CSKAigjwLFA9hsEecZFRiVumxSF+TvHWpPOJk6KVKIm/FpN4gIlzNGG0zK4ntLq23zX9EBBfJ2TT0v511YwFUesdFI69CfAVs+4vzZiVE51XrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVWTE4fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB90CC43330;
	Sun, 24 Mar 2024 22:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319981;
	bh=1Ex5kFBpZC5U0wW56mG+2vwHB7YDpbOowaTErJyFC9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVWTE4fvWFoEmMkZPXD3EOToaYVaJ6JjHf2NwQlPFojC9xMVN3c/I92tKcIgyrX38
	 VijdBi2cxtxKFY31HlwJuS6thqEno+hrHJUqLf9bT8yP/V2qUnpaEsH7MLSJ5Mmjt+
	 Su4Si4vxZ5yqdJuH46KfWNAiA3bjCRNVXKr9lQ79kgrP3zMwoGo5qUzEen6rXjYSmu
	 zWnqVU2WjXjHsXRYHuEU6eg4TPRDFZ25HJvaf2M3ciPuak9dBACtUPvxL8XvvE4Xa5
	 t0nC/qzi0Sa8HykzLYIpDIcenoX/e5lwnO8pv/kf3PZpxDZT8T1t0wt5QI2T7TDhgy
	 GDZT85eTds0zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 288/715] wifi: rtw88: 8821c: Fix beacon loss and disconnect
Date: Sun, 24 Mar 2024 18:27:47 -0400
Message-ID: <20240324223455.1342824-289-sashal@kernel.org>
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

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit e1dfa21427baeb813f9a2f9ceab6b7d32c3ca425 ]

Tenda U9 V2.0, which contains RTL8811CU, is practically unusable because
of frequent disconnections:

Feb 23 14:46:45 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-BEACON-LOSS
Feb 23 14:46:46 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-DISCONNECTED
	bssid=90:55:de:__:__:__ reason=4 locally_generated=1

Feb 23 14:46:52 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-CONNECTED
	- Connection to 90:55:de:__:__:__ completed [id=0 id_str=]
Feb 23 14:46:54 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-BEACON-LOSS
Feb 23 14:46:55 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-DISCONNECTED
	bssid=90:55:de:__:__:__ reason=4 locally_generated=1

Feb 23 14:47:01 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-CONNECTED
	- Connection to 90:55:de:__:__:__ completed [id=0 id_str=]
Feb 23 14:47:04 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-BEACON-LOSS
Feb 23 14:47:05 ideapad2 wpa_supplicant[427]: wlp3s0f3u2: CTRL-EVENT-DISCONNECTED
	bssid=90:55:de:__:__:__ reason=4 locally_generated=1

This is caused by a mistake in the chip initialisation. This version of
the chip requires loading an extra AGC table right after the main one,
but the extra table is being loaded at the wrong time, in
rtw_chip_board_info_setup().

Move the extra AGC table loading to the right place, in
rtw_phy_load_tables().

The rtw_chip_board_info_setup() can only do "software" things, and
rtw_phy_load_tables() can really do IO.

Fixes: 5d6651fe8583 ("rtw88: 8821c: support RFE type2 wifi NIC")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/276c31d8-b9a8-4e54-a3ac-09b74657aff7@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 --
 drivers/net/wireless/realtek/rtw88/phy.c  | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 6d22628129d0d..ffba6b88f392c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2032,8 +2032,6 @@ static int rtw_chip_board_info_setup(struct rtw_dev *rtwdev)
 	rtw_phy_setup_phy_cond(rtwdev, hal->pkg_type);
 
 	rtw_phy_init_tx_power(rtwdev);
-	if (rfe_def->agc_btg_tbl)
-		rtw_load_table(rtwdev, rfe_def->agc_btg_tbl);
 	rtw_load_table(rtwdev, rfe_def->phy_pg_tbl);
 	rtw_load_table(rtwdev, rfe_def->txpwr_lmt_tbl);
 	rtw_phy_tx_power_by_rate_config(hal);
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 128e75a81bf3c..37ef80c9091db 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1761,12 +1761,15 @@ static void rtw_load_rfk_table(struct rtw_dev *rtwdev)
 
 void rtw_phy_load_tables(struct rtw_dev *rtwdev)
 {
+	const struct rtw_rfe_def *rfe_def = rtw_get_rfe_def(rtwdev);
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	u8 rf_path;
 
 	rtw_load_table(rtwdev, chip->mac_tbl);
 	rtw_load_table(rtwdev, chip->bb_tbl);
 	rtw_load_table(rtwdev, chip->agc_tbl);
+	if (rfe_def->agc_btg_tbl)
+		rtw_load_table(rtwdev, rfe_def->agc_btg_tbl);
 	rtw_load_rfk_table(rtwdev);
 
 	for (rf_path = 0; rf_path < rtwdev->hal.rf_path_num; rf_path++) {
-- 
2.43.0


