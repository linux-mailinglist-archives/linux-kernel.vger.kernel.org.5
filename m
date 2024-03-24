Return-Path: <linux-kernel+bounces-116150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C68899B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7105029CF45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84DA3B1E0E;
	Mon, 25 Mar 2024 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq/j67c7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141F1311B3;
	Sun, 24 Mar 2024 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323708; cv=none; b=KNROiAcNc6z2AlUd++bjgQRdtV0w3Hr/uFOnNb2SYtxlVSVyoozYQwLsy2TLOlh/gZ/0nu7Qmie15SNSmKBm9kQ/TzcRgGMTu6ONHxtVRhsr0Xi5Lbp1kmSOm5dCjjlN0FdGaYnseJwX04aGe1QkJeSLibrcb/VMoPCvifZY4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323708; c=relaxed/simple;
	bh=xfzY6sqSCTfLmXyPr1h7wJ82kutCf6cup+CAcJxnjPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nH+y4hCavTeo6821twcIuMSUXDW5iBU21Wq6D+US5hINkGBLkoRoNWHmsTvb/IQMstkKrDukseAdNE6Qr/EMy04YHtQf9eJwzkgxcqGGp0QAHDQUN+Z6tGdww9WzAjx+EPQJPxyL/rOCuiF7rfKRHdMqhJNtObZ1tJdZWQsAUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq/j67c7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A8FC433C7;
	Sun, 24 Mar 2024 23:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323707;
	bh=xfzY6sqSCTfLmXyPr1h7wJ82kutCf6cup+CAcJxnjPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aq/j67c7LEKyl844fWuC9Ey4vw2mmYCB++Lepkm3o/9lWeqWebQIGT8bLvI0EF4jo
	 lTHAWzxynPUuUIBSLr1TeJfNxxUOBM6N9sPus/WDX7ibBhF5iLx4fOnsFWubWArjmt
	 ElGacaHgqYI6sk4kcwv2UH91tGotfaiwMtTElyUxc0naHhtDHiLfaVIgK+MTMAE70s
	 E/LiN0OIsxyvd3SCK9k7NUAP2En6eSgdhSM9EB6yUzUZUULX4CUiwd2XTOdirZtjfR
	 OUtgxo0nPs3hiu8CKBFL8NlDdp/P8Q06B0V7M6KXgq/uuA7ZAfomysxA6PcQvuS2mZ
	 pTFPVOlSNmKag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 081/238] wifi: rtw88: 8821c: Fix false alarm count
Date: Sun, 24 Mar 2024 19:37:49 -0400
Message-ID: <20240324234027.1354210-82-sashal@kernel.org>
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

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit c238adbc578eeb70cbc8fdd1bef3666b0f585b13 ]

total_fa_cnt is supposed to include cck_fa_cnt and ofdm_fa_cnt, not just
ofdm_fa_cnt.

Fixes: 960361238b86 ("rtw88: 8821c: add false alarm statistics")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/f3cb6d17-e4e4-44a7-9c9b-72aed994b5c9@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index f9615f76f1734..d517f92b6180b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -579,9 +579,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
 	dm_info->cck_fa_cnt = cck_fa_cnt;
 	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
+	dm_info->total_fa_cnt = ofdm_fa_cnt;
 	if (cck_enable)
 		dm_info->total_fa_cnt += cck_fa_cnt;
-	dm_info->total_fa_cnt = ofdm_fa_cnt;
 
 	crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
 	dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
-- 
2.43.0


