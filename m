Return-Path: <linux-kernel+bounces-28231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17582FBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E30628D228
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782F16D216;
	Tue, 16 Jan 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlB1/zzT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9E16D1FE;
	Tue, 16 Jan 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435508; cv=none; b=FQdVMcOin/WndAIpJzwoGUb5EnKLkhVFkc6Tf0dQiSZJfDSHTdXpaxhquA7VwRSNie3g5pGgyH+WTvgrbRYG4L3GwyWnp95DYXyn6IB3/KXBfDJzoe2TEq3oGILaDobp87bdB1XiqsiaDL0N5a9F1nMfoBfzFY4GGo7690V5W2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435508; c=relaxed/simple;
	bh=+YVms0AUFGvQO41yF5POmdSd8sSLh3fVoVZVNMsQxBk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=R82mGrBsiekwgeKwa+voTguFByWtiL78c8Wha0bv4KFTZ9HE9fm3BedABpKOiimSWzqM6WyRB/8y2A5UyFORHvcdDMJd2/N9EahQhAFQYTvzm+IEnc7hUhA4s9dpaF3jHTg+2j0Ek4PexhVYXZOxY9ogeJv86qMmixLufAq5Z0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlB1/zzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB5DC43394;
	Tue, 16 Jan 2024 20:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435508;
	bh=+YVms0AUFGvQO41yF5POmdSd8sSLh3fVoVZVNMsQxBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlB1/zzTx/CpDhvCNCJ2V29Shc8xrNx8sNoR0vt9+/9qfgqcwquCo7l62a0YuNgr8
	 IJ1g3fzalkooXUSwidqyL/CRwbjm7hIMTX8QC4Y8Q7S+yL3talGjJYraRfpBU4cVgI
	 TK1Nt1noE4p63ZuctQ30+mhmzYbbMjOXv8cO7UEP1MYvXdDwy6np6OsXwrGiNMjW8h
	 w4kCTQ9cjbcthKkeqi/3jNfvybRrVttZkAZ7hNJkr0p0vTQ+TbZOAyXFGt3pYIUEwz
	 72T8BI4WOZd+X0DmLRxiR7EVQCVECjTupUA5rgksM/aBFPhwIPRk+hZhAa039xZfsr
	 YhJqIsU77tLRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 20/22] wifi: rtlwifi: add calculate_bit_shift()
Date: Tue, 16 Jan 2024 15:04:14 -0500
Message-ID: <20240116200432.260016-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200432.260016-1-sashal@kernel.org>
References: <20240116200432.260016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 0f3b98c5227f..0287cbb9a719 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -3251,4 +3251,11 @@ static inline struct ieee80211_sta *rtl_find_sta(struct ieee80211_hw *hw,
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


