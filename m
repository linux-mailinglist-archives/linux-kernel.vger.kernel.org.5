Return-Path: <linux-kernel+bounces-114221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB32888930
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C326B261A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1568C44C73;
	Sun, 24 Mar 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhkdzP8e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB559209314;
	Sun, 24 Mar 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321564; cv=none; b=TQbPQPsUD3mlsuBbFBP7Ro1ZfnrytiJoMQzi4EXWL4Fat8ydikpJIMmRtSSoshEQeorSeLIdZ9wQoYdYzTYGSkIRoG8JRpfGFl3bq6cclSMFz7aPPmUbKxEix8MRFl6fIMje04tmemzxuAyboHH9+GyThFqSg7dzhEgtkr8yHdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321564; c=relaxed/simple;
	bh=hjfTsG3FxMG0UeWB/cpPvLl/vRyoBBKXFNi5QWwVFTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhjIA+M/mvevPNUfvS/ZHiOOAp9FkkFQwrT9cDCyzjq/gdygP3hBAWSPCr0Bg7qvwAg6lonLzB3tmPuhFTivhCGahcYgzAMlZUlPqiDWGN1SJNdraz9mhCHZ+ZprOJko8FGcNVohmbuUGS6nock5bouojR3jDpD7wZTzLCVvUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhkdzP8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204D5C43390;
	Sun, 24 Mar 2024 23:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321562;
	bh=hjfTsG3FxMG0UeWB/cpPvLl/vRyoBBKXFNi5QWwVFTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhkdzP8el+m+PXAFw+om/sN5TahKePmaZq12qbGhaSBMRVtqA632EJ5Qb9sHS7/PV
	 gergiPDmeo65UrRhQUatb4kwLOti0sdnnboOLSGEivpDui4BeFosJXEBLkBgO9cTdJ
	 UemnNfEWyv9fkvBlIKCWk4TFHVENtdQ1G3VbPKbTb3dK8Y1SvxZRFuitoaOfunFwV8
	 S33DCo1VIMGRh/CWbuTj6IPbVHgsNgurWUSBPvhX2MYfUYLkfTYAam16UQ6WBrv6gL
	 eNoF2/ZAINIuIRy/C30HB3xCfQo4bFF+Z3Mt2ffA1ef4zpu8yfekY/0aqdFccJQ2Ff
	 1PDK7z6aKIBvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 291/638] wifi: rtw88: 8821c: Fix false alarm count
Date: Sun, 24 Mar 2024 18:55:28 -0400
Message-ID: <20240324230116.1348576-292-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index adf224618a2a6..5f3a3a88c3d0d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -706,9 +706,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
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


