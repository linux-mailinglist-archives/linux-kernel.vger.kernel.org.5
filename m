Return-Path: <linux-kernel+bounces-28209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C4E82FB9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00F028CE99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87C16899C;
	Tue, 16 Jan 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eafnlJ/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC1168983;
	Tue, 16 Jan 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435447; cv=none; b=ubb1xTi/kaTZ8sRGM5KuRFwZx/Pqy43CY4gakq+taLXPu8Y147JqhPlGTCr5XHVcz2nBSC7SrmCvg/Ho1SA9kgutju7T2axLqHaVDb1kxvluOEKX4vut6bP2DlsmNnOcHOcCBiML2DlHIYp7PAtvJ/02fgdiJuobFAonF1t4Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435447; c=relaxed/simple;
	bh=wbK2XEyPjt121Hbs46E4qxK6oOrpTKnefTYUsKU5CpE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=CHzu++zZ7gqNSyUu1RNEMh2UFDLC9bM1SdFufVWUA6uqEKvLZnR8UqOOxfs1wL1GvRIyrWTYI/DFs1bOJT2/OclZKAUei/bsncGERBjANY+KQqaftmxI96CspFjWIkEyspQ3xv+KgPPITym3uQbBvboO3IrRCtaHJ9ZrujIunN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eafnlJ/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635E3C43394;
	Tue, 16 Jan 2024 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435447;
	bh=wbK2XEyPjt121Hbs46E4qxK6oOrpTKnefTYUsKU5CpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eafnlJ/N3vJo6lgqrpOWreK/4bPWnWRUGauKvrxUMfQTQjNAqs+sD9s0lQZAf7Xf1
	 MbODjUx+O9262+i92ZcfoI59B04OTHeNBHHF56AkIIFasUwR36tV2ebYdmMtooydCf
	 rCw3VW+ovynPQFUIsQrBJpjXzTXg5QV1Jx1wHi7L4ozgqCr8d03GcvefIl2X4yrYo1
	 HbM75A/dW9mpIK0NHRcn2HocwmhK4vCZrTmuhD7/j37i5gHF2T7PSjLDGgBn21Ip2g
	 z4dcIUz2qU5jGqPAMVTC9lcBgpeitFWFa4G63jTa/hCCE9tQj27HZQ3wh1GSMjr/YU
	 Frd+xb34ZLkvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 29/31] wifi: rtlwifi: add calculate_bit_shift()
Date: Tue, 16 Jan 2024 15:02:38 -0500
Message-ID: <20240116200310.259340-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index 3bdda1c98339..abec9ceabe28 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -3230,4 +3230,11 @@ static inline struct ieee80211_sta *rtl_find_sta(struct ieee80211_hw *hw,
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


