Return-Path: <linux-kernel+bounces-27771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120B782F5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D581C23FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A401D553;
	Tue, 16 Jan 2024 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF9tJcbd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD651D52B;
	Tue, 16 Jan 2024 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434148; cv=none; b=c//03aTKo6stFlItm59LZzFwieXBlHgGUpbek8Vtqqf3xQfko6arlBab6nrCuTIHKTj7s8FWZkRveeFQXORcrDqgG57/NxjQlTwyBMgxBQRgz76pJeV+yqVCrM9sTkTuGbbc8mHCMigJA+aaPpVW5oTc6ef8GVQFSmMkXyY3IBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434148; c=relaxed/simple;
	bh=ydks/e5IH7FasqqTx9rcS78Zu0NPFlqiVB3AdAuGvQs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:X-stable:X-Patchwork-Hint:X-stable-base:
	 Content-Transfer-Encoding; b=VHE0uXGDr/vi2DmYcprfAIxn7fyqzgY05nQKJNSEHxA0rTgwzEfyvMXDNRqLZIsch0mkMONnjd71Cg3GbqfvjqXHJcwbu1E253V+P4LF4elmigl7gQme7GAhgGZ726/9jDABT+8XnjBcIRJHmOAoEpp/zAUZuh5U9slsjSbx2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF9tJcbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBC7C433F1;
	Tue, 16 Jan 2024 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434148;
	bh=ydks/e5IH7FasqqTx9rcS78Zu0NPFlqiVB3AdAuGvQs=;
	h=From:To:Cc:Subject:Date:From;
	b=HF9tJcbdwDPOZAs+LQDZomVgJAVcb09JN/mTNpIfUwf8DTI4G6TkkQQJMwATtdOK8
	 kB3TqzYgEpTpGF5v8TbByFPxQp7KZI7MbOjkFPtx2/Hor7BWxZ9KmBTY56axwJbkvW
	 fjXZzyaAFX/+UmNHkC70wOQxkYxCLUMhHeAAgMXqZy8aiBmJLisMKh2K1NhzKOSqdF
	 QT1lxmVEwh8qfLKPq3YKg5Qsz/YyG7WRRFc7spafxRWBJDSm+XuC/ARPT9++G5biNJ
	 9Mmptwh2EIueTkHdGcfiMeDQsf1RWmdmYZ6IVSYK9FyfIIsewJwGSIl+/CWrRVva1n
	 xdZ8epEmpm35A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 001/108] wifi: rtw89: fix timeout calculation in rtw89_roc_end()
Date: Tue, 16 Jan 2024 14:38:27 -0500
Message-ID: <20240116194225.250921-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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
index 3d75165e48be..a3624ebf01b7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2886,7 +2886,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	if (hw->conf.flags & IEEE80211_CONF_IDLE)
 		ieee80211_queue_delayed_work(hw, &roc->roc_work,
-					     RTW89_ROC_IDLE_TIMEOUT);
+					     msecs_to_jiffies(RTW89_ROC_IDLE_TIMEOUT));
 }
 
 void rtw89_roc_work(struct work_struct *work)
-- 
2.43.0


