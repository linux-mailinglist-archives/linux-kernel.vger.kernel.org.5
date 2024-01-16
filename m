Return-Path: <linux-kernel+bounces-28002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC482F8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE45286BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6913B7BE;
	Tue, 16 Jan 2024 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPAUXRky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EE13B7AD;
	Tue, 16 Jan 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434814; cv=none; b=tihytGY0Nutnfwdc9hBJ2TlYbPLs+yz0oLdeNvHFjz3ItfinvDjTK4n/o4a79QtT8LjbznhfRe0BgNZV6MxFgQdAEqCy06MXd/RYsSq7jIOtW5dp20BdwBrW9bkWP2Z1jwb3jHdMU3NZxkIrBJ05+Wxuvu+glXhD0GPfIr+hqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434814; c=relaxed/simple;
	bh=/YfA1eWiAVAtY24JCbeKDlQFxtbsyL+ny+6AY65nBDk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=TCLdx0ckbGQeGuWZprEjoASlB8HhBwnW6pwUgFsbdnyrqRkJWa2G+b4BGh3q6SbBVD8Mu3DWdQOcVZgGCwev6qkxkqZHQQ/s5O7EbUIRUMfvUko11kzdb9uhRlhnEEL3WkOV+zj6sa8XCGJjt+L8ioNIqA0lmM3YwoE35KV5s8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPAUXRky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A60C433F1;
	Tue, 16 Jan 2024 19:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434813;
	bh=/YfA1eWiAVAtY24JCbeKDlQFxtbsyL+ny+6AY65nBDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPAUXRkyB0MeCTlARxzqfUAgE0iBOK0SGl4Kzao3h0iMVmAFxI21Q3OZ2qeWojSTx
	 p9Oe905nInVp6+WyW3BHJZ4aS6k0e6m2zxaQfjAKSP6xwhABlxD+6v2qXQ/FLnF1qe
	 uUvVpxM9WpsfBEYMwUk30Q0YwOsHMTyouWIW866J6SM2jx8vV09+6n1WW2XZn10dAg
	 j08oFP8yLq8plHwI7+zjBK7JMxuRTsX84ohHZlQaSUWL6PPOYRAQqDhXklxxxpmw4b
	 zVxSLxO7d+BfZBjCi5Kge9owkKlave4cm0VD0CvBbyDw20BUYoS6F/5v2jo+cZ9CSz
	 E451tkBhGpWkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 090/104] wifi: rtlwifi: add calculate_bit_shift()
Date: Tue, 16 Jan 2024 14:46:56 -0500
Message-ID: <20240116194908.253437-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 2e7e04f91279..8cbf3fb38853 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -3080,4 +3080,11 @@ static inline struct ieee80211_sta *rtl_find_sta(struct ieee80211_hw *hw,
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


