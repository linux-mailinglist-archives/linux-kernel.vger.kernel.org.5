Return-Path: <linux-kernel+bounces-114086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18438890EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FDEB39962
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AA014F9E2;
	Sun, 24 Mar 2024 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgD7aPkG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6B130E30;
	Sun, 24 Mar 2024 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321397; cv=none; b=t9WK4sGFUx7ToS1RkbOPASau0dk7JmWNMOxmmA1nXAmuU02QV/rvWkh0qvofwq/w1edMTCAnlfjS7Jo6KjVqibz/JcvFSaMfFz/0rUrmlYwlJdsDVSBkx7PZkq7XmjfT60aK2G1qIomlpwOeNULjnD1Tn9h/iKc5CUfXjjI3JwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321397; c=relaxed/simple;
	bh=PV95sVDzH0x/NSKCwRKFhOR/8HyXkMLE2m1FQByzsUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7/EBxWJQ2SoRa+XJfYaAp7vKFBkK78wmBjR+b1EhkwNLh7hhw3BpARWF+3GzgxESShN7bR/SiHdUar1TLpPYhm1XCrfKByUjb2sFO6N3z0d4RAuLTeRkl3dXHd7ApQE0FOEMXgf73XBy2tyrVv3ELBFkwsPLm9f7xOq303XxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgD7aPkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4204C43399;
	Sun, 24 Mar 2024 23:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321396;
	bh=PV95sVDzH0x/NSKCwRKFhOR/8HyXkMLE2m1FQByzsUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgD7aPkGmk4089evKvIM/Ii+aa9TuOTiFRY01zGlBmVVC5FlNJx8BtOFBb2P9jPZT
	 ingHhuvxO2J3VSGf5V1oMDuZTYFI801xz2Dkj6NswRg2oQvx0DLiHQZxnm/yjN6K82
	 EvgFbQP4kixxmaeQF28z2/cHk5FtNOb7m6hjduVANU0v3YBi73K2T9XpvEbOltq+RR
	 lDtx2ISjg3e8zMDQONPKgAqTKGCeyCu+BsGJChQ9T4n5WqPxk2igfkwjSJijmkBnN5
	 /FbrFy9/lBTfoksWxDOO9geXV2v2ixo1BUZmypT1PpL1X8ae9acbXFfqeuDzzECMP5
	 wS97bs4G8Tv3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 120/638] wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
Date: Sun, 24 Mar 2024 18:52:37 -0400
Message-ID: <20240324230116.1348576-121-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 77b356fedd82a..0e74ba630a8e8 100644
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


