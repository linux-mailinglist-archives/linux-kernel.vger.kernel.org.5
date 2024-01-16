Return-Path: <linux-kernel+bounces-27908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAE182F7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34481C24A95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5C2233B;
	Tue, 16 Jan 2024 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLI9u5r/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2248509C;
	Tue, 16 Jan 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434552; cv=none; b=MORz5/0X+Gm2e7HFcSRG82CBIYFRx3fmCyN4R9mSvCfygYuIqi3EY21USmhjvzeYBTqjZoYVPx4EfgEPJkMgrfCrW/TbMRMi+DPB2++RWLZVM8i8xAsT8ZXJrqlMQKRCBNKFZrPCkhivuVLfwMh6iYZnheWCZ3Ci4nrXoJsY55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434552; c=relaxed/simple;
	bh=tIH1Lv0iXYkXYNFVwBt7OBZPs5FAlwpQhvwCM6EyewA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:X-stable:X-Patchwork-Hint:X-stable-base:
	 Content-Transfer-Encoding; b=VlT6eoedUhfEHL50HJET90jCwbLWCSlhNhqSNNUyJHWU/WDPLYAsOdJHj4ADFwhZrHT3Bls5mpXO79o4XlDPZZv29Y7osqOrcDzkt43Dsb3zPq+vzATBcBIjrcsKw72cV2Nu+pFQ32SEShbbWC6RwbDy6WNotyidES9d/I3S/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLI9u5r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09BDC433F1;
	Tue, 16 Jan 2024 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434551;
	bh=tIH1Lv0iXYkXYNFVwBt7OBZPs5FAlwpQhvwCM6EyewA=;
	h=From:To:Cc:Subject:Date:From;
	b=XLI9u5r/V+u1GQJN/HBzr5kKhnSEEaxWUoEszCK2bvk0OlcdNc94wHCFFv6p+2xp+
	 dWt4b97Tn+ZLsghV8GQjbHo0FGfXKkQBIZB1Bi4gk//HrTqAldVSaY2+pmTAU0Wq1V
	 nRFx5Y7AgB1NedZBtYfADr2Nc+kSayxfjSlB3YEv3GuVjfdii7xpu151hAz6A7Jmkb
	 ez/ynrspvmzUaZfpP4zj/BgbMo5lYOCmj/jqNkiuZdNK5KMuucyfyV0xWGsLxeqVE5
	 RNHCeFIt86MjnAI34Eelgyp+DOdx9oLKMKkGWcmqGG1tfzper1etrw28ikgX5xHdfC
	 vL8YpDPVP1+AQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 001/104] wifi: rtw89: fix timeout calculation in rtw89_roc_end()
Date: Tue, 16 Jan 2024 14:45:27 -0500
Message-ID: <20240116194908.253437-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit e416514e309f7e25e577fee45a65f246f67b2261 ]

Since 'rtw89_core_tx_kick_off_and_wait()' assumes timeout
(actually RTW89_ROC_TX_TIMEOUT) in milliseconds, I suppose
that RTW89_ROC_IDLE_TIMEOUT is in milliseconds as well. If
so, 'msecs_to_jiffies()' should be used in a call to
'ieee80211_queue_delayed_work()' from 'rtw89_roc_end()'.
Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231024143137.30393-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 133bf289bacb..535393eca564 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2548,7 +2548,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	if (hw->conf.flags & IEEE80211_CONF_IDLE)
 		ieee80211_queue_delayed_work(hw, &roc->roc_work,
-					     RTW89_ROC_IDLE_TIMEOUT);
+					     msecs_to_jiffies(RTW89_ROC_IDLE_TIMEOUT));
 }
 
 void rtw89_roc_work(struct work_struct *work)
-- 
2.43.0


