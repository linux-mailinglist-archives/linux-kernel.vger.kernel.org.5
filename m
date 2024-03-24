Return-Path: <linux-kernel+bounces-113660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E8888E35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCD61F2B0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913E1D685A;
	Sun, 24 Mar 2024 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhROVB0J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6D1D6955;
	Sun, 24 Mar 2024 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320578; cv=none; b=o7dKFlcAKP//BeHAE9UjcO/10EFjf+JUnCxvlVIJ0dIFKeQNNkjswn3RF0mDsK5HQgbk8Awm4QtAxIwQOt1pBdgUwSd3WmGW/8ZGodIfzLs5ysKB9JI1xmzVqHE7b1KZfXxvmD+DkTJTu41qDUjOxQQex4+pLiX7a4f4LqNW6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320578; c=relaxed/simple;
	bh=HRsI8JAt342So7xUBYg8KsqVHOOsA3e9WgoFFAH9MKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImuuNJ5OFyWq3z5lQGY8q01jU2/yO7xkgJGJgKQwMHWdLn16qjVeCMbWZyucn9veokV0KVp3KjERhmsMlw+cbdMkupNviDSFq2VDL6+6uZOv0WvcORstmh6r5OLx+btLkdaIJq8Ixv0Dr4+aLIhnxmNO2Eg9+sCUvIEc+qkTTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhROVB0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39E2C433C7;
	Sun, 24 Mar 2024 22:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320577;
	bh=HRsI8JAt342So7xUBYg8KsqVHOOsA3e9WgoFFAH9MKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhROVB0J1QZqoEZvxQNuFQwfw3gyv49rXsXqhLwyNO/QAK7cmbk5zZhJHX2teaoJN
	 vpzj0UFL8OK2Tp9jgbEkcsjgrQI3DQ21IcChlhG7esEe1W7LpVL+KLEBld1B7qcyhm
	 fS24bRcPeAmC7ZmCasgz2FGlP1s8LFctgtbUc7eNJIk3AXsBpRrbroaFhA2S2wWU/y
	 9BAxEz4h+D6bclu17FfVjkvTchvJwpDTPj0sjc+QsdGaASkLGQeig7tLWfiZsFix0U
	 0R8za0M+Nq9nYhBcRtKxavZDvFoWGoxvOmAeP0Iy1mmz/MiQWs8g+zmYeUnYH9HnIf
	 r91uIbXf5hDJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 138/713] wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
Date: Sun, 24 Mar 2024 18:37:44 -0400
Message-ID: <20240324224720.1345309-139-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 180907319e8cd..04df0f54aa667 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7304,6 +7304,7 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 	if (priv->usb_interrupts)
 		rtl8xxxu_write32(priv, REG_USB_HIMR, 0);
 
+	cancel_work_sync(&priv->c2hcmd_work);
 	cancel_delayed_work_sync(&priv->ra_watchdog);
 
 	rtl8xxxu_free_rx_resources(priv);
-- 
2.43.0


