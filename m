Return-Path: <linux-kernel+bounces-112952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FDE888002
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CE42813A0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA984A4E;
	Sun, 24 Mar 2024 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcdN++al"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482483CA8;
	Sun, 24 Mar 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319764; cv=none; b=ggoJh2j+lyzou+ZhmN5mN7Cp2UEc/x0hzUI9BMRf78adDVkfUrgrUU7M6C8nlPNoio+ghMCpLTigo8tmtRUalBEpq572xjfcqO+Ey3Qhr/mesygL2S4Vd7waijOGRA5szDmQvsCV+isam4VZRirmosvM+ZoE4GBdPPqiC7H5NQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319764; c=relaxed/simple;
	bh=HRsI8JAt342So7xUBYg8KsqVHOOsA3e9WgoFFAH9MKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZ+eiyLgaQtNTxdra708ZREQwLcVyCrI48UZRYmBtdzH3THILYAUElvyI/H9u6Vyo1/TJ7XCPoo2hocpqxxRIKzw3+oamumkvJ7zwhlQOm1HqFq119m5A9cjoqMNBilZkTPCx6wE/XTe1s0mN7EyGX4Nc6AfsAqB5kAAKbGGCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcdN++al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072F1C433C7;
	Sun, 24 Mar 2024 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319764;
	bh=HRsI8JAt342So7xUBYg8KsqVHOOsA3e9WgoFFAH9MKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcdN++alNhgSYgN1n6IUBhw39owBp81TUMSt4hHKV91bHMVfEHtqXPI2fhLqTHVu7
	 9Ny6/kZ+XJjevJm082NQpsIpdSFYpraMUfcdpZd8GTT41me/pfISbAKc7g0pGHxCrA
	 0R80WbjfryEBnXlXOTttHh967OVoahwdSyiCcO9dB3oiooDRx6X5VgpvCRVrdjLIT6
	 41s3eQoZkRJZorzMYYn2X5yjZmStjHPacKSq6hWEeDtD6nXVNtfZniCsvcXjhcUzss
	 q5LMtL2y3PCUuWwLpfE0Xq7DYk3O28jgXA6q1e5JeXp4F7accryGCExBVtfHDhA6f4
	 zCcO+QeQ52Ivg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 065/715] wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
Date: Sun, 24 Mar 2024 18:24:04 -0400
Message-ID: <20240324223455.1342824-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


