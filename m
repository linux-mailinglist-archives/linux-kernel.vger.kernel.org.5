Return-Path: <linux-kernel+bounces-28232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF9182FBED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1D128D44F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113616D888;
	Tue, 16 Jan 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNmjVkGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022216D877;
	Tue, 16 Jan 2024 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435514; cv=none; b=Bbnt2c7A6/2aduRMdVuIgUsE+rKyAzJSveXYmROCCxPXyy4Tt4xpAl0dkh/+kM+uoAv590Zclon75SCsio15iEE29ihDmndxB1Qtjdy/DvLEf2NHfcoWVq7BvhcIuyfagIVaIUCrmI6uuyWYJZJljzMueicPLoC274Sgitg2Elo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435514; c=relaxed/simple;
	bh=JrK3Ry7krXyfnAcY6MiWGhjxc1iD1Y8fvxFyNuwC99o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=izsILv7zRdrWtVRAks7+DIFrWMEJT2jJahGToAYFtAFZy/teFjMjdTLKxbrIGRK1d3OzKLVBVJ7lhvcRlPCQTHXvKu52sBA2vuUkhxASlLC0sGTfMpimEzemPjm+c3VLgNvYY64H2zNVGc7fH0e2LlXOOWBj/1XSeE+Qh04ZARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNmjVkGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C45C433F1;
	Tue, 16 Jan 2024 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435514;
	bh=JrK3Ry7krXyfnAcY6MiWGhjxc1iD1Y8fvxFyNuwC99o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNmjVkGNofZ2oZdN/dX4XHVf/zxNAnKizRV0wzgtFoVb34WOEKmity6hjRf2jVWK5
	 fsY+oqoWsgZxCaNcSAwejsx7hSJvU0qbh+DLrwrNz80u0pU4OeAeH9XC4utTmAcTLe
	 xloUaL90VETV8D5iUBbUQZGp78ATS6Jsxl9mwo3jVDsE8zM/2WN+bQLC444xIGu5ii
	 sfcjq/9UKqlniDDrw6KHuRhbpcKhJhaDPYxlgKl6X9nsR0j2u9ab6DMx+hy1gXJbwj
	 1qZTAqKpxHUfwMuGUF+Pfs//DpeHvPRjn2MSIagy9eS2V6pGFFqONZNvPjxkWfnq/6
	 VX1fSImmw4zCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/22] wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()
Date: Tue, 16 Jan 2024 15:04:15 -0500
Message-ID: <20240116200432.260016-21-sashal@kernel.org>
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
index 5cf29f5a4b54..e6ac496e898e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
@@ -72,7 +72,7 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 							    rfpath, regaddr);
 	}
 
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
@@ -104,7 +104,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = rtl8723_phy_rf_serial_read(hw,
 								    rfpath,
 								    regaddr);
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
@@ -113,7 +113,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 		rtl8723_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	} else {
 		if (bitmask != RFREG_OFFSET_MASK) {
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
index 1263b12db5dc..bbbbf61d7bcf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
@@ -64,7 +64,7 @@ u32 rtl8723be_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
 
 	original_value = rtl8723_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
@@ -92,7 +92,7 @@ void rtl8723be_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path path,
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


