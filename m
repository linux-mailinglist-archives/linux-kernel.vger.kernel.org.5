Return-Path: <linux-kernel+bounces-114957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E5C8892C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290F41F2F0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FB22DD219;
	Mon, 25 Mar 2024 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCVR9LMz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812542811BD;
	Sun, 24 Mar 2024 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323675; cv=none; b=stNzoXYUlNED/w44iwAkKTo8m+ham1fVAAsHfpV38lOpPDEw2yT2axwwF1x4DeZpT1IyWOU+zO3kJIIU0rlqedPlt+IFDNFkI7QRWh34C4fyTg6KHnv8L1osP55B8lbCVujAMiyYnF6fRPx++ZFlpKRlBa5N7nUHUWajdXCEbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323675; c=relaxed/simple;
	bh=pK91jJaBnwGOqondxwR+98VyK28KJn+ZyGzSqLRXcCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrWGwcRwPidnQj/eWTUDpyClB9X18H7R8yW2BQZ9lhJdvA1Xin268rRCjI30/w/Nh6U7/qdyOdM92CVQ2ggeUHeEBOGVGXNW0r1Hm47ciFKrCAwxRDW+NoOWdj8TddnLWxe9e/2JkjOo+/GIMFQUwjll9nS2oP71Jl5vs590Io4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCVR9LMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F280C433C7;
	Sun, 24 Mar 2024 23:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323674;
	bh=pK91jJaBnwGOqondxwR+98VyK28KJn+ZyGzSqLRXcCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCVR9LMzGCK5ZhVTeWw7Jtxu2ytEsl6slmAK5pzUaiA7+DwFshsbbVItw8vQp5742
	 5hMxXKZXy2g1yTQgPVnXjzkHOn6cVsYu3UzwhI3Vla3ZDpH3rxFz0AdMcT4jEVT/J+
	 rH5Km4wDU40YqGJgMClFWJsl0lUztN2xVR7qNQpy9eqnVXEgK8AuapdE60m6vZFRaV
	 HlpxaGrj5hgag6kfUYhd8ALp6Pio804RTGyGbmB2+Ol+v0PDiXFGSYLA90asHoPaRP
	 C0kS+rlLzO1RndCRsVwiYiCLEqu9CftiT1xsL9qY7RTTxWpGgtxxS6Fy/HrlniZCvm
	 Ex+sWc9vutbmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 046/238] wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
Date: Sun, 24 Mar 2024 19:37:14 -0400
Message-ID: <20240324234027.1354210-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 3051fb358fdd5..9efc15e69ae82 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6483,6 +6483,7 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 	if (priv->usb_interrupts)
 		rtl8xxxu_write32(priv, REG_USB_HIMR, 0);
 
+	cancel_work_sync(&priv->c2hcmd_work);
 	cancel_delayed_work_sync(&priv->ra_watchdog);
 
 	rtl8xxxu_free_rx_resources(priv);
-- 
2.43.0


