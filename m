Return-Path: <linux-kernel+bounces-28175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500482FB29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9B61F2AEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB71615BD;
	Tue, 16 Jan 2024 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPS8Him/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515E405DF;
	Tue, 16 Jan 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435342; cv=none; b=jO+uBLTDk70OPm9v6U+BhS1ELG7XgmVNGgoKCQXK7ZffARMmDjVo0ybPUNnUWYqvBqm91ieGV9Hc4q9rDpXbNpzth4IkLmhoXXco5E78D4WAfigZyIt4vaGTZgcbmkanENv1TagpItS76gQzUID4AT36QjuMuWKhnpSNypNSuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435342; c=relaxed/simple;
	bh=cUgIoC7sYL3zlsFCb07Nc9ZrcyGFG0MovF6+8jsZkcU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=K24Rc5lzV1+ZcFfBqWBg4R7mDeQ90OXKelNngU1P+xb5BPLy6QjEHcRkqAPp8p5z/5gsGUNlBdGhYyal0z5V2x9iP2M78b9O+gXGBWphuucnIPmYdZdSSSmcpbyAYnScrclHSz+fkOQIi0fgn0NkzQnktn6FBRyUmc/73GiHm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPS8Him/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D618FC43390;
	Tue, 16 Jan 2024 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435342;
	bh=cUgIoC7sYL3zlsFCb07Nc9ZrcyGFG0MovF6+8jsZkcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPS8Him/xdZ09wN4tHRAncsDWoqiW4RnKaLS1lF0PomdNU9+L0MyPasRWIrTkKpVE
	 JnnL5KeyQ5HTy0nE12T8pUqpkWlILmjrzKQhUo3ZUfLQFvU1mfbX3YRSHyHdXCbb9T
	 s7jN27WmZ2ryb17VDbZbcfD+UKi0vwKI6Lj9T7+UcuY85rwsCnImo3DmbaiK1N96cZ
	 S5a38rrpS1BDD/I54JMAyBHEFUMvewmQZDmdQBpDwEzw0dO/AfcX3RYGLS2S/70PmY
	 kE8FssBsXLV2RH+5x9neYKYi5/39YWPZSt7tn36gJPAfEGoNHULR74DgvYpdKcbZ6Q
	 UTWcQnJ6Yt5IA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 39/44] wifi: rtlwifi: add calculate_bit_shift()
Date: Tue, 16 Jan 2024 15:00:08 -0500
Message-ID: <20240116200044.258335-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 52221dfddbbfb5b4e029bb2efe9bb7da33ec1e46 ]

There are many same functions like _rtl88e_phy_calculate_bit_shift(),
_rtl92c_phy_calculate_bit_shift() and so on. And these functions can
cause undefined bitwise shift behavior. Add calculate_bit_shift() to
replace them and fix undefined behavior in subsequent patches.

Signed-off-by: Su Hui <suhui@nfschina.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231219065739.1895666-2-suhui@nfschina.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index fdccfd29fd61..a89e232d6963 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -3111,4 +3111,11 @@ static inline struct ieee80211_sta *rtl_find_sta(struct ieee80211_hw *hw,
 	return ieee80211_find_sta(mac->vif, mac_addr);
 }
 
+static inline u32 calculate_bit_shift(u32 bitmask)
+{
+	if (WARN_ON_ONCE(!bitmask))
+		return 0;
+
+	return __ffs(bitmask);
+}
 #endif
-- 
2.43.0


