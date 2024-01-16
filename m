Return-Path: <linux-kernel+bounces-28077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F112B82F9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227F41C25D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012A14BFB7;
	Tue, 16 Jan 2024 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omuW7rVj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43914BFA4;
	Tue, 16 Jan 2024 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435050; cv=none; b=daPr2+zNml1Yn1c0mPFKC9iXoxHcFYdDuLmCktUr/SBolDJOKhtA81sGadyghWQVM2kw2qc+JJuOYMQ2UTsLZDJYd/rZCQX1TtHiC2QknjuftLnJPVOqWpF9eBb04c3mKBXiLm4xQE9uoJC6iGh3rcQcQ5ulo2EO6syIgXCxkjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435050; c=relaxed/simple;
	bh=/a3AD679474Ss0NiWcC8XcwOOMs3WyoQgJk3FKXgHbk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=BZAHvEG5JsXZpN7mivtfJTqFh5cHFiQ6QtHD0pH6bTuZGG672+i6vUxtA45kB670WXb0aLn+vo9SjS8TU7Y4YT31qYGIi/XmpRp2Z0N3OHJYCrl9Pgi1po170jZRaOioRbk2TTUg61eaFDznQE9ZUFgGk9x8qoq1E/9qidjkX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omuW7rVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADAEC43390;
	Tue, 16 Jan 2024 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435050;
	bh=/a3AD679474Ss0NiWcC8XcwOOMs3WyoQgJk3FKXgHbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omuW7rVjo0MHlmWNpZOG7cB+8tDqsNPMieZdmZY0g6pddwibvlH9PBNTdpuHqHf8W
	 lGQmUe7VX813+pQNtRGzn8+XaBRHVp5qWdUVAuxJW39u28Vc3zmKSvqoSD20hqzOeI
	 tpUTDhRb4Z0WAE45ePyjBiTNltXBPGjXiAqKas24gLyCUi6uvLsPtJJEk432XZCL5N
	 jZlR7zMdMeJH69DKT6ysNt7phHE3nQFRkmNRYojuSq/ZqL4E9yzQmiwUKDqJFtSU1J
	 GuGF49/oUikZMfb3Cws8O9wX6BEkT/n1T5ubHDHJpTjrhFdmEOofY8VCME16yWKdLE
	 GXd5gwGaaTG1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 59/68] wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()
Date: Tue, 16 Jan 2024 14:53:58 -0500
Message-ID: <20240116195511.255854-59-sashal@kernel.org>
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

[ Upstream commit 5c16618bc06a41ad68fd8499a21d35ef57ca06c2 ]

Using calculate_bit_shift() to replace rtl8723_phy_calculate_bit_shift().
And fix an undefined bitwise shift behavior problem.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231219065739.1895666-12-suhui@nfschina.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c | 6 +++---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
index fe9b407dc2af..71e29b103da5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
@@ -49,7 +49,7 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 							    rfpath, regaddr);
 	}
 
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -80,7 +80,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = rtl8723_phy_rf_serial_read(hw,
 								    rfpath,
 								    regaddr);
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
@@ -89,7 +89,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 		rtl8723_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	} else {
 		if (bitmask != RFREG_OFFSET_MASK) {
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
index 2b9313cb93db..094cb36153f5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
@@ -41,7 +41,7 @@ u32 rtl8723be_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	spin_lock(&rtlpriv->locks.rf_lock);
 
 	original_value = rtl8723_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -68,7 +68,7 @@ void rtl8723be_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path path,
 	if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = rtl8723_phy_rf_serial_read(hw, path,
 								    regaddr);
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data = ((original_value & (~bitmask)) |
 				(data << bitshift));
 		}
-- 
2.43.0


