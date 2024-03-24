Return-Path: <linux-kernel+bounces-115920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF3A8898AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E201F2DAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE8738B012;
	Mon, 25 Mar 2024 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip+NDEOH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A631487F9;
	Sun, 24 Mar 2024 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322115; cv=none; b=tOBasQpRa2JeuTIBM8IaQloSwCkEyUi83H1Q5MOmk19zKM4aILsqPV+QJ9jC4InPKB04HbfGKQmiTvmaSPnNODb1xi4WaFgX3NypbR2EAXH6l2p58QB2DAmjG4WZejsHGkBxSWF9+lEMuhxLGmH2eWMtYpaGj2C2c+lpSR5MhA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322115; c=relaxed/simple;
	bh=Nmw5THMc56boYoN+6LILknPlj2jAuIWd5p8Yh2bj8GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSpp1+5IcHvfNO5sroQo95G9iDR49LGOrhS3EdtRfiMP3eABsRuPvVPskeeZNeaEs9mq8XrFVYLrUVXPqdpP4NOss/nBHeq1ir70Oa3H58HlZyPPjCaTPCURCQQr897XxkfcZHbrkOUDeZbhOKDxE95vn4jDB90KR8pVsVqSvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip+NDEOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB2FC433C7;
	Sun, 24 Mar 2024 23:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322115;
	bh=Nmw5THMc56boYoN+6LILknPlj2jAuIWd5p8Yh2bj8GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ip+NDEOHtv8AusZZrboVf+m55llIwpiqpbLBS5XclYn/wDU/YmGW0tcyqJDEN95Z3
	 edK8i0iPE3LathAWLIPqy+ePZohupAR9UKgFVBSiyxIeaZJIGCPnOXqHVqTidRACIE
	 qUrwZm4PNaRZfmyRZmbhL9wVTRWyhGeBHAN/+nAtufmTOdqpBMxCsQkgzSpy60jErj
	 5wAYaDIT48U51JgrOel0CZLJvvBP2cxYx02wzuwUobEoPJIPyJa25ePGBrFOBktJZC
	 yBan5Te7LSkZsq92ukfl+IxC/FilFB/ScKwcorzumpUNJzDzbYtm/KEJR663R4G3Ui
	 dNRNliWL6shGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 190/451] wifi: rtw88: 8821c: Fix false alarm count
Date: Sun, 24 Mar 2024 19:07:46 -0400
Message-ID: <20240324231207.1351418-191-sashal@kernel.org>
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
index 609a2b86330d8..50e3e46f7d8aa 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -674,9 +674,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
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


