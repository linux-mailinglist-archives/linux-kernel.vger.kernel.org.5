Return-Path: <linux-kernel+bounces-113765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16088867B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE20B20F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5FB12D20B;
	Sun, 24 Mar 2024 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQJJaPt8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193D1E168F;
	Sun, 24 Mar 2024 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320772; cv=none; b=Ay5xx8po8hO5KeyA0rnhmeX9RMVYwfdj7R+FIlnMw8IbbblXouQbNM+JMaOPLv++G/oZ1wtH6lz9jgfCEqQtQDflwAw3juCZl3F9ldc8zl6r2Yo89agF1LGgIZyskgEfH2Ygsqfc4TTtx5Q/s+jQedA7g+oJQJZwqpb+Ybupy9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320772; c=relaxed/simple;
	bh=2as4bBo5Q9U5cUurpFOJDy4sVzMO8/WedLyf9JYhGBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPROPNNy7Dpg3y3obVtuoG9Z3og/u+B5IfwGEegLQBjEGVbCQ+MbvAB9CbmVf4wnJQBL0ReCAmQGrEQuWPzggCRNHWbV9jiGp3EZuQvAYl0Bcrb6aL9J7xR91txZN6RgubVHDsZxD16YmI4oy8jxvJegvoGQd+0lupismr+k9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQJJaPt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E68C433C7;
	Sun, 24 Mar 2024 22:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320771;
	bh=2as4bBo5Q9U5cUurpFOJDy4sVzMO8/WedLyf9JYhGBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQJJaPt8sdFji6eML66ZNBw/4hJXf9KCiAPJZjz4rM0RKK1phVxBfXMHD/WE4PVMK
	 JuZ7UjfCOsYCjfync41nfuqOwNnCwBYXHdSuv46orNl2Kd7alXTnM9dg9oseHiu+Bq
	 nql2CkyfQRV8+3IvMvp77/u/OetWVRpoHPc/toByU/mOkJfYt3K3WI3FSfhcmkbI31
	 EXiyWvMu1ZOQR+9/fFs82AoUW9wLr1YKx6sPsJ7WgjMYVpIZn/fG2FnMAlnLLbFCQo
	 szLc9WVERQRC8fRDX7SOzYKvP60CW3PYHyQEgml6eaKEIuZRdUCqbkBdEI8O8EisMP
	 Z3vad2kYo883w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 335/713] wifi: rtw88: 8821c: Fix beacon loss and disconnect
Date: Sun, 24 Mar 2024 18:41:01 -0400
Message-ID: <20240324224720.1345309-336-sashal@kernel.org>
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
index 4a33d2e47f33f..63673005c2fb1 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2027,8 +2027,6 @@ static int rtw_chip_board_info_setup(struct rtw_dev *rtwdev)
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


