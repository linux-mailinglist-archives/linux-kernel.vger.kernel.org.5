Return-Path: <linux-kernel+bounces-115855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7D889A64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7915FB386E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68A145FFD;
	Mon, 25 Mar 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+nCJZy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35D44393;
	Sun, 24 Mar 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322018; cv=none; b=Ka371zvUO6zSui4LBAzjoTnrPvyxGRSA0SuF2qwOW51L/7QVe2wgXjbOS3DMCig0sD7SbrIvlwpp7HjKlgvp9ueB3rVd38ETxDKOdAbjHiu0DowUBHaYqOQK3TL56+KTMUwaTpcX7pG35z0ys/s7sSZfjJiRC7Yzj1bRhPHaC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322018; c=relaxed/simple;
	bh=sBEVLsaBwotO3KJqTYYim7Q+8BgEHlMSoiIUYwGIHLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMx/rOq+HvRV+l/KmNwJG2AXXqE9VkBE7Aae66OyN66Rp/GNUI08GMZa/7xAmaeJnxU9hXD0r9bf4uj+Ws2z9Q5o+TgQpPNrbo336tKudopC1Z5YZmhF13O4/txbgranzzd2CEvTxbACq/UNt8FvMu2yZP3MA10xcTW8pXDVBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+nCJZy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73908C43390;
	Sun, 24 Mar 2024 23:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322018;
	bh=sBEVLsaBwotO3KJqTYYim7Q+8BgEHlMSoiIUYwGIHLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+nCJZy91ZizS9upVSKGwTw3rQ+zxc0hdsUe058VAUgdPjPhD1yEJQK6YnFhcHnPg
	 barQASs1lP/Tp/i+1UnUH5rl/jonfefRQff6mu1NY4m0OeGC/codFbOO/WtaTG5tK0
	 1QYSOsyg/piA21Kc6kZcTUGulFZk5bP+v2JwZv3pjV7R5CCnHnyufOBRKnm72FoJ/E
	 7bRk+hTRbZkLshklmMAH3mKOROcvlPCqcGNXMikvIFFc6yYU4Gn4AG78sbHrORop9w
	 wD5ljDHQLsl+YwAooET6rLFrAmwX8swZojjs7MOleHLhB4qv+S52WNcCsXVzNZFvs2
	 L4LnlUwdJZtsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 090/451] wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
Date: Sun, 24 Mar 2024 19:06:06 -0400
Message-ID: <20240324231207.1351418-91-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Martin Kaistra <martin.kaistra@linutronix.de>

[ Upstream commit 1213acb478a7181cd73eeaf00db430f1e45b1361 ]

The workqueue might still be running, when the driver is stopped. To
avoid a use-after-free, call cancel_work_sync() in rtl8xxxu_stop().

Fixes: e542e66b7c2e ("rtl8xxxu: add bluetooth co-existence support for single antenna")
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240111163628.320697-2-martin.kaistra@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 6dd5ec1e4d8c3..ccac47dd781d6 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6542,6 +6542,7 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 	if (priv->usb_interrupts)
 		rtl8xxxu_write32(priv, REG_USB_HIMR, 0);
 
+	cancel_work_sync(&priv->c2hcmd_work);
 	cancel_delayed_work_sync(&priv->ra_watchdog);
 
 	rtl8xxxu_free_rx_resources(priv);
-- 
2.43.0


