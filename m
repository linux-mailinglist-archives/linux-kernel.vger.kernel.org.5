Return-Path: <linux-kernel+bounces-116017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5D8894FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54A31F2F866
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481F17D220;
	Mon, 25 Mar 2024 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRuh9tCw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B82174979;
	Sun, 24 Mar 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323357; cv=none; b=u7NAhxN7Fhc3GEf1sFfiT0LAvBjWw6Q90+KOI+Y+kmhHtcYlgN3vU9ky/S6ficJKdpFLTWgQ5RRccjIEl2GYuXy8IOmTDNC2OBXMtFUmrYoTtszXNGV9CHiNXOa5ilx7WqcOiVxEmXfMe/UbLtD0vcqbmHzaZfAzEgSTqirBckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323357; c=relaxed/simple;
	bh=lk9a3sR+Gf80Nc1LTDgoNyiixBCKAWQX3ANl8n28usg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGshLRtJrXtbz11oQLc5oekvTF6/D/b79l3ButC6HYILFhymjkEt/+/CoY/kl0swjI3ZvnTagy+c1+Ak9ttPW4+id7FKfY57S3XJMbaCsN6+KKZsBp2lTAC3aL39gElskgpdhe4t5MrxWgF+2tLB2XSOqaUjdGy26dajTN/Nz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRuh9tCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A78C43394;
	Sun, 24 Mar 2024 23:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323357;
	bh=lk9a3sR+Gf80Nc1LTDgoNyiixBCKAWQX3ANl8n28usg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRuh9tCwhWRvpVA1jNAKN8jBggeF6Kp5Npy9D6GiRiOUpvW3mhmM4qu2Lbmd7P8WS
	 mlvJeR+c6OVadYCmiRlZkdvWutROMzTYNPvt6sYdGRSnMhcvlQVdQzncnNjd2/Lqo3
	 gly6/UPRioLlOHpyynFy+DsjO8tymGgTuwYR95b3uudAvG3iy55Ijhyf6TzvoNwDTx
	 msAoFYAm2AdOUxllr4KWYVk6IbaSuv9zlWX4EmWd0VFSbTxNlgF0ygScBGBCqS4xRF
	 zRAP8mlitK/oEgV7kE4aNou7rSOIH5tVhHfNTcfY9I+OTgIlT3Q8b2DHVD8PmGrp1a
	 YkyLYBVBk9Wxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 057/317] wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
Date: Sun, 24 Mar 2024 19:30:37 -0400
Message-ID: <20240324233458.1352854-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 30d9a195c6fb5..3536b9f8470f4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6484,6 +6484,7 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 	if (priv->usb_interrupts)
 		rtl8xxxu_write32(priv, REG_USB_HIMR, 0);
 
+	cancel_work_sync(&priv->c2hcmd_work);
 	cancel_delayed_work_sync(&priv->ra_watchdog);
 
 	rtl8xxxu_free_rx_resources(priv);
-- 
2.43.0


