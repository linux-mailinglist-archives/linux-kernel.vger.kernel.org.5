Return-Path: <linux-kernel+bounces-115918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A58894D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82E11C2F4D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5995D38A96A;
	Mon, 25 Mar 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIvfxVyN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49197148300;
	Sun, 24 Mar 2024 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322114; cv=none; b=ZdW4rnzVMDHJuAScexGkMkEEHeQE7K9/fvIV1lUvpiIOPOOSZnyCOenWK4EufYPm+45Kx98nlAHm8C9g8tKWnAZ+OF0TvT20pJVKICZH7fmr7yxYh5x/p4Kvbys0qrPSmDS0AjgaUEojO5b+0RTgOdB0OUQ0gpTfojKzdoGcNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322114; c=relaxed/simple;
	bh=xlo68ZFskLrQUsfDtn3csgWoSo1hwwHJodwFfU9RdeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7uyEMeHAgTrG78Lbk4gWidqIoXssrA8b2UdaT7nvclKL75nhhEuCqOkuMzpyfuhM82/kBnCcEwssnOw8zzMhjkAh9aCJw7XEGLy0ue2rS1RJ7zqnMNOOcjt1pONMKtkMnx9IXOWoJUD8QcM1z7C0BfuH52uIkZFqzehaXMmp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIvfxVyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FF2C433B2;
	Sun, 24 Mar 2024 23:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322114;
	bh=xlo68ZFskLrQUsfDtn3csgWoSo1hwwHJodwFfU9RdeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIvfxVyNlvC/yV+j66HvbmvaPK6vXXUmXq2plH6c+LZ5R+wxNWJTzBMkvrgLtbMYZ
	 amhX8mtrLCYwQY/fJr1qXe4waur0UVf5sR5xrztHB2pEurfo/DyoOtlRzhWmEsdZ1H
	 5e+Sry1AwTqXdPJ1oteVV199KhCESwSqvV3SvhxEZI9bexhuNOrbUukidmNE1MGj4n
	 b0VvUfMD2G8SaqAImOGcc1jT42Wzyu7uj5dD0vH8zGpfyLVDV7j+vbZYt8WLq0+oH+
	 bJIIs4QBVc9WsriZXnuH4G+oa4aLlU9TAXrsSrFj7NkwZznGMSW66EYN1/GXbbOnjO
	 /L+fwgMR2ryPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 189/451] wifi: rtw88: 8821c: Fix beacon loss and disconnect
Date: Sun, 24 Mar 2024 19:07:45 -0400
Message-ID: <20240324231207.1351418-190-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 4c8164db4a9e4..81f3112923f1c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1989,8 +1989,6 @@ static int rtw_chip_board_info_setup(struct rtw_dev *rtwdev)
 	rtw_phy_setup_phy_cond(rtwdev, 0);
 
 	rtw_phy_init_tx_power(rtwdev);
-	if (rfe_def->agc_btg_tbl)
-		rtw_load_table(rtwdev, rfe_def->agc_btg_tbl);
 	rtw_load_table(rtwdev, rfe_def->phy_pg_tbl);
 	rtw_load_table(rtwdev, rfe_def->txpwr_lmt_tbl);
 	rtw_phy_tx_power_by_rate_config(hal);
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index bd7d05e080848..fde7b532bc07e 100644
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


