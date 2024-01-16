Return-Path: <linux-kernel+bounces-28128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A1582FA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F5D1F2784D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321111578A9;
	Tue, 16 Jan 2024 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC6m74cO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124215788D;
	Tue, 16 Jan 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435196; cv=none; b=Rb1c+DV8X8ulhN4NIh0TGHm3C517KGmBpa3Sr8tNsFSPcXfV/V/Yy2wW2eOfEYWeEioGF7stcsV1NHuVp4s4tVF87nxLnSqVyIfRqJoATOhZAivTW8FhaKofxh5pRDyg8qZCV6oBYoVKAR6JN8EcBmHSE+jCGcTfu5odH/R2oYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435196; c=relaxed/simple;
	bh=FgXKYXjmn6QXTfJ3/fj/E8eIatj7g5+XsrzED+N2P8c=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ONhS4ciCjwOzF0N7jnqyD/NqL9ohwyY0BcJL0aaAyHHd7uapWDjxBKwas+XUUiz0hkzJ6BM9PegkgkE+iiMpzROt2c+LntrDyfpwt+5+NQh4xnUXRb3/C6rcpUzcTUlLvXejo2g58vaDnFa3/RDWqTRRO+eMMX/Alqv0p5JEPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC6m74cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898E7C433F1;
	Tue, 16 Jan 2024 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435196;
	bh=FgXKYXjmn6QXTfJ3/fj/E8eIatj7g5+XsrzED+N2P8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SC6m74cOh5zfCkxCsShUPPPyf4VpFEdM7IlaUh48o5mkvnUCyEZcw4cybqvG+1OkO
	 BWWTQnrQ0gHFm7OxpCTgOLGZNIDmwUapQfH0pe8d1xFOkCSFZqubBGdUb9QCZUny/S
	 9w9bfINDNftu7+/NYssh5+491Q/usakTtnGNCXB8gSnO9uvGc8DMwCmPW1w/jeZtiZ
	 e3kjH7ROUu0/5MPhdCWzia8Gd2cIAZvb4NZ+k34+KDnDu0WnqgI6Fjo4dCRujhyF8h
	 Px0yxwxfjdKQho3PIPOkTD2ZMmiEvMuJlM0EeNvv1hBhdzZqpRYiMHZURir2hSeAIe
	 vp629xfmoaRUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 40/47] wifi: rtlwifi: add calculate_bit_shift()
Date: Tue, 16 Jan 2024 14:57:43 -0500
Message-ID: <20240116195834.257313-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index aa07856411b1..a1f223c8848b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -3106,4 +3106,11 @@ static inline struct ieee80211_sta *rtl_find_sta(struct ieee80211_hw *hw,
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


