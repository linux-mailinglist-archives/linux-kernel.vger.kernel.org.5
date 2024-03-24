Return-Path: <linux-kernel+bounces-113180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B49A888218
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDFF1C22435
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6506013C663;
	Sun, 24 Mar 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUmm2wIA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C10176A16;
	Sun, 24 Mar 2024 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319982; cv=none; b=gnA2n97de4ugSq9uLXdask5IlrjgAyV+eGcYIEss64Z8cL9fkC11uTG+piCeOMIRnhJySWasEWjUhnmyc02l8fyRkW/pHgk81ZQYqskQOJ462UFqKPaOyTFYpGYXUPFNxLvc7A/vzPgc85b213sU5of8P/C5XPMRFRRthTMupbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319982; c=relaxed/simple;
	bh=mZScqgdFbFxEEZ5oStzghiuQovEy8pryA8k/LHb0adw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YT20pG2bH/GzuVrid9cCLW+QUk+GrVPhtYRWXjhTRLoVkIk+E8OmcbLUEjIeoA5tyWgLQI6+7xcTJB7pCQVAdyvYue3PGN0qGersrTpoQcBbxsgsOfPN1vo49ng/9PvFW21r+1oQq5oKfBJOSs7NKyLVmbAuzZIlIFQ6qA0Cahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUmm2wIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C099CC433C7;
	Sun, 24 Mar 2024 22:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319982;
	bh=mZScqgdFbFxEEZ5oStzghiuQovEy8pryA8k/LHb0adw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUmm2wIAcelmmQiMkz52P3562qBLl7o+Y9b3iZXYTukAs9heGY+MkSeUC80WLrA87
	 7fzBqh298PzrFcxxE/3mZjXciDH4JmOJ0Ee9qdWJK2u+lv3U+Ja0d6Ly9j53XBxetR
	 a86VEAr0MFlwIS3584DVDgZlYvP/Zd8RYdJkHoCsASQtdl0FV/SI7M9O7W4FA7lpmz
	 vIAxZ5SV5ORg1aCCI62jXypz8xxcSTKNzi5gBJD5veaK715evbzAwoKDRduZtilvC/
	 M9pSjm2qKebTqSxaGiLxs+QvjU8hdGaHg1dYl6CIHWtvYpAaKbTHsQhnBZ86YRbL5a
	 9ZKpx/oBmQeCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 289/715] wifi: rtw88: 8821c: Fix false alarm count
Date: Sun, 24 Mar 2024 18:27:48 -0400
Message-ID: <20240324223455.1342824-290-sashal@kernel.org>
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


