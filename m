Return-Path: <linux-kernel+bounces-124483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C898918BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBDE28731A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB41327F5;
	Fri, 29 Mar 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONjFOm1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089912D21F;
	Fri, 29 Mar 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715215; cv=none; b=I2XlyZpfrLKO1W3t7WKLVpqWHJZVg+HGaBgI0Hzay2ggTHrqTrGuZ0V3cL6YFJVzJfIGYq+3GoWMuMo99dW2fywiP3xijOzQK82hZ9Ad0tCV8yM0SU8/5wNDvTae5+EDc0inY+DcryKm+0g07YktJNLGT+otPRMAapy7yNkvObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715215; c=relaxed/simple;
	bh=iKk8l/iQSj5HSgmRuDFSBP0CYJLhzGG2CV5pd/n3Pr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUKRc6np8uad1Rpskhg0wi5YhsimS45k/HjugnJzd43Mq7DwNCB5PMZeCGPKrnaXUDUNa0SzQ255D26BRE9zZvBNoAjnyd7iDapMwGjn0Ey2W1KVqdfH0VMtAHS7a6+tqxVoOIMwc1nij3M/yf1/HmkICRAooPoS9UWl0+qIgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONjFOm1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8FFC43394;
	Fri, 29 Mar 2024 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715214;
	bh=iKk8l/iQSj5HSgmRuDFSBP0CYJLhzGG2CV5pd/n3Pr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONjFOm1kx0Hp9/3B5G3Iqswyo8U+D5j3v9/i+oWJgbfwrmphTtdq60SqvSquj0lZg
	 ZVmhkJf8K8JSqUNeQYHaI5RxKQmM01/KiWV/R9nbFsdr3b65SJGf3LXX/qyjB4j6lh
	 fdw/4fONyoqcCB6Vgc0PYm7uzjvxbVAH/v/5tBf4V3KGNH7NjAF8xzPGfWVT3TiTBD
	 ODjvv5BH7XZe5F4vBS7mjOh8kPMWLkk3ye8MH6cNBs7UsyI0u2graabSVTdgN2XiWM
	 H2zyBZoLxnMDRp3d84RWaQIKMX84P5xkm+1txOc58PE6hiPTuYMDvLrflqwCfZO4zp
	 hqZDtdgQHkhXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Po-Hao Huang <phhuang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 02/68] wifi: rtw89: fix null pointer access when abort scan
Date: Fri, 29 Mar 2024 08:24:58 -0400
Message-ID: <20240329122652.3082296-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Po-Hao Huang <phhuang@realtek.com>

[ Upstream commit 7e11a2966f51695c0af0b1f976a32d64dee243b2 ]

During cancel scan we might use vif that weren't scanning.
Fix this by using the actual scanning vif.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240119081501.25223-6-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 93889d2fface1..956a06c8cdaab 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -441,7 +441,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 			 * when disconnected by peer
 			 */
 			if (rtwdev->scanning)
-				rtw89_hw_scan_abort(rtwdev, vif);
+				rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 		}
 	}
 
@@ -990,7 +990,7 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 	}
 
 	if (rtwdev->scanning)
-		rtw89_hw_scan_abort(rtwdev, vif);
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 
 	if (type == IEEE80211_ROC_TYPE_MGMT_TX)
 		roc->state = RTW89_ROC_MGMT;
-- 
2.43.0


