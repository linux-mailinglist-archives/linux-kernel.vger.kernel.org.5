Return-Path: <linux-kernel+bounces-124552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B359A8919CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E580E1C24C79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803FF13BAD4;
	Fri, 29 Mar 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6bFzoKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94D12FB12;
	Fri, 29 Mar 2024 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715398; cv=none; b=eo53jm0EDghKA6TUfvnFVbWvDAwnl4PoA7RhTO7xrcKdGu/X+CRqeDYZGG6AgTft9Btle4a0BxM6xBrJhQC/KUktgFnk+zT6cTgaevFxEMYiZeW0Gn98madjItjPc91XFCC3p84w/CJ1L0yWaBERPKtXcssudlzUea58MkPGqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715398; c=relaxed/simple;
	bh=icd8JE9I8/CsXRr6YD96udCLnIgfHidC0XiNseNAP8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pet9RASylgPTuMr95JjRxHB1xCtnpvaMew65QldkfpA8v15KpwZabp7qIfUIdAkl6ObGDnUf5q8/T1zoa0qTdRCMHmQ4ltFK2jkhwV7uG429s6Tt3ZF+kPHENcH/9fzfhBzV05fDx3yvEN7q5taFcCOVzuUDaqgyaC7YrxqlULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6bFzoKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B5C433F1;
	Fri, 29 Mar 2024 12:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715398;
	bh=icd8JE9I8/CsXRr6YD96udCLnIgfHidC0XiNseNAP8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6bFzoKztbEO0rSubeSDripCuToZLu3KswWqdZpt4TyqOBiC0EgVo+RPFnt+5sXVf
	 AnFJZWHoRTty0rR9HHDEztexpUWzCY52YR0WRQpDp6zqkORQdrmu+qgA9Zb7fRsVzX
	 EMV4FzcjJYs2a9Ns5FCWh0H7Q/0A6pjFqbaglJor48rTHvHr1nqucxxrtHHmcnRsAJ
	 yElCOG6u3OYhyNT2HbEqU7+8iEmXXKKvLdD+/ObTpVhGNCAn65VSQG5vpgQgZsyX+y
	 +OiPpUHYqF+sEWXMIQ2K9gsHi6yU/IH+I4/+bMCscIKoHHpQn/rJD7zPjhEPqwTy0A
	 Zik0xz3Nip5tQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Po-Hao Huang <phhuang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/52] wifi: rtw89: fix null pointer access when abort scan
Date: Fri, 29 Mar 2024 08:28:32 -0400
Message-ID: <20240329122956.3083859-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index e70757e4dc2c1..8aed0d101bf3b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -422,7 +422,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 			 * when disconnected by peer
 			 */
 			if (rtwdev->scanning)
-				rtw89_hw_scan_abort(rtwdev, vif);
+				rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 		}
 	}
 
@@ -971,7 +971,7 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 	}
 
 	if (rtwdev->scanning)
-		rtw89_hw_scan_abort(rtwdev, vif);
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 
 	if (type == IEEE80211_ROC_TYPE_MGMT_TX)
 		roc->state = RTW89_ROC_MGMT;
-- 
2.43.0


