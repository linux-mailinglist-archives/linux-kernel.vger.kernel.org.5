Return-Path: <linux-kernel+bounces-113766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5583688867D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871CC1C259A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027C1E1697;
	Sun, 24 Mar 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOIWE0RP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C951E169B;
	Sun, 24 Mar 2024 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320773; cv=none; b=myShxvWacQo8LPNOztQQALeBFpNCfgXvL6bUAY+Wsy+b1zVWSMHKfh91pVGaX5vKJO2UX3Ze8UwDmo8y3i4SRZ1d1tR8qOupT3367GAUu1sYX3b1jxKmfCxxIB37DJXwu+hHgJ7QO9DhbAF8UaZbI1GNu52106+vxG75dqXdZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320773; c=relaxed/simple;
	bh=mZScqgdFbFxEEZ5oStzghiuQovEy8pryA8k/LHb0adw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLCsJhAH+5k+GSR6R+yEdom9bBwyhvdlEVnXWPilj/ojCNfSG82NNtPryt8e+0gRsqBkIOKwCs7ozex18d+WLWrfVaYSiaA0iGHwwH0XBF0bw6AtUNDplYkjv5J9/iJjryTOh4Nq4M1v3NfAuAe+9F6MJl3XyPY9kVzhuN174/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOIWE0RP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99239C43394;
	Sun, 24 Mar 2024 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320772;
	bh=mZScqgdFbFxEEZ5oStzghiuQovEy8pryA8k/LHb0adw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOIWE0RPTQsVb5wnKkTmJupAz6XkgPGTy2NI2VZWJCPPiYClEFjJOKSMVBn9gMTu4
	 MBHi5RcgT9+V21bQmc7xqwVzec7SJCWtA77uEOimCsx4uacpXQTKSJPTNPhdGFUVtM
	 tIEG+0FK7zeR2LWbbPUipnkh/eGLNrymwBwH6TQRVvKcKgJOpn7qVS1ZwoNxq/kfWa
	 bO1i9IlbyrajW/Ft/XnShjmDMSP4ZYUcmN0+2tKF9TcCRh+29ZhhUTAMkLw2l2bQlL
	 IXENEThF1SMuiPYerfg0Pw1axNHS3uYzpWt/2gKq9yBhqp9/JzfkbImI2u6Sogawrn
	 COYHbJej3Cubg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 336/713] wifi: rtw88: 8821c: Fix false alarm count
Date: Sun, 24 Mar 2024 18:41:02 -0400
Message-ID: <20240324224720.1345309-337-sashal@kernel.org>
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
index 429bb420b0563..fe5d8e1883509 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -773,9 +773,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
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


