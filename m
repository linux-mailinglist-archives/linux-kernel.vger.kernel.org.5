Return-Path: <linux-kernel+bounces-27865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C0182F6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12010282C09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78702627F6;
	Tue, 16 Jan 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAkyANKC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B783D6169F;
	Tue, 16 Jan 2024 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434394; cv=none; b=QvvGgeZ1THjfg+ePGNhFnvuWDPWXu33+tfuN3ZcTfIsMMmEgJF7jQwmWwzw5T7StFlD09FZ5bfFs30VZlZ0PRgLO6FB/2Bpj576aPeAyN2U/2OBHFoiUqy+3IioTyhTsRwEgTRFmuiZwRexkaYpIpLIyNUspS+lFw86bKs1Uvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434394; c=relaxed/simple;
	bh=2vmIKsWl6DOTug3sX+BOSpbnCLZrMIY2f5WbrQbC0Do=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=tPp8c/8zJRg9gExhmqMtRQ249i05vD3rqOGFd8bl9tnHvRBggcOVnygsi02OVVewBgrBB/q/nzDUgM/+ievqrRhrhro3fXPTdiyRklrEww8MYG495cE7RByu3AeDoUNRytFexciD3xM2TwNbuTPz69FKm3+CNJY4tvYn1pUqB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAkyANKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B761DC433B1;
	Tue, 16 Jan 2024 19:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434394;
	bh=2vmIKsWl6DOTug3sX+BOSpbnCLZrMIY2f5WbrQbC0Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAkyANKCZaLrc51gizkwewj0Umr3OnBnM0pHwD3qOe7qBZhRE9sjrH1WN6cNi4IXI
	 rzL6HvQOE8SNdzILwCrKhOozYKsbm8vu50pdb+SSWZdNa7Cn/oAolFLgcTCAHg2c2L
	 LPnOw9TrsSVNKOoHAzZfM64qNZpJE9QdWb3UlxqcBqEMOl1hQvRq5GfS7PjJLDdIdV
	 NlTzOG1XsXSfp4bXBtZ6K1qZNatX6Y2b5fOltPjkom06DlyOn00J8ElJFFLx+OZWqy
	 BycZtb2Tae44PRkcHQmZWmWx7Jyuo7JDwLRGAqA4vqZ/71QmEtwt5Vg20yzdw910/w
	 66ypBLHudshAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 093/108] wifi: rtlwifi: add calculate_bit_shift()
Date: Tue, 16 Jan 2024 14:39:59 -0500
Message-ID: <20240116194225.250921-93-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 31a481f43a07..5d842cc394aa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -3069,4 +3069,11 @@ static inline struct ieee80211_sta *rtl_find_sta(struct ieee80211_hw *hw,
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


