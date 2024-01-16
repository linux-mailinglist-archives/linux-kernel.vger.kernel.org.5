Return-Path: <linux-kernel+bounces-28076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E9482F9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8F71C25DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BC2E635;
	Tue, 16 Jan 2024 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3vh+Tcp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA960DF8;
	Tue, 16 Jan 2024 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435045; cv=none; b=YaQAa++5JUzJSJzX0NVbyul39dyLfHNL4JOMhrU8GSvvq/33q6g0lMYJE4IfaFyChFx7ui6ITXqoTFc1pCOKdQinJk6lNxDGC+oqaWcatyC95NgbxDoWH1ZA5mwvQ1aNPSVXvkZtQyC+jQh8LBLoHjRTD+jT1VsOlkTmDeX7Vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435045; c=relaxed/simple;
	bh=wkzP5XWUez48+GOBIvZ+eV/8g5vqXdSoRnGXeEot/nc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=mRGWmzTrwK5iiNtaoSTLdPmpeOEJoomT66PLRNQLqJ66PQm3XQ7/VnCJFIALyvX2lplJeLxFk7jPtUjtbylhNowmdi2Wkf79wyVeFGOzJUE3tpsu7Dl3wO/29OXxhagfBvdkhzH0geB60dK64CZ1r7xGNesvtoEQQ33L1aivp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3vh+Tcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0A6C43399;
	Tue, 16 Jan 2024 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435044;
	bh=wkzP5XWUez48+GOBIvZ+eV/8g5vqXdSoRnGXeEot/nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3vh+TcpOqEUzuSafv0cFBkP3jZ76XnWifdh2mYLKTA3K7c1vyLG5N83aYK2IhZa1
	 dTXaHpquXvRCGpozaw8VgVCQNbwkYKlODK0ltYm5nF5+0LBPiuQtCrazvgVPY5AFZh
	 ZkGIAOANCr4TnpyJglzkHeMadn6VuqICJYYPmISE2IYJkUDaIOp0/BOr87GRQHXFPK
	 T+ZwtlkgmQme58gY9KNcqG+ZsmtQRco5pnX2xjYRdCHg7/jHh01IofGPHONdehQKMr
	 SptTi1RTqzt7CUJzI5QfQYTirc7ylFilmZuYo5iNlBl79zrh4y8vsxw+VR5MU4Rxx5
	 uBMd0GdqvxJrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 58/68] wifi: rtlwifi: add calculate_bit_shift()
Date: Tue, 16 Jan 2024 14:53:57 -0500
Message-ID: <20240116195511.255854-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 31f9e9e5c680..0bac788ccd6e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -3105,4 +3105,11 @@ static inline struct ieee80211_sta *rtl_find_sta(struct ieee80211_hw *hw,
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


