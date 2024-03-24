Return-Path: <linux-kernel+bounces-113899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B98CE888F29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78A4B27945
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE720FAA6;
	Sun, 24 Mar 2024 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/bJtau9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0312BE87;
	Sun, 24 Mar 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320982; cv=none; b=OWOT/DxHjjhRJwBl5tegf1GzrFs+IPGefkEBeJkiG5Fe3+LkbJAxbPg93hqXnEBM8ld66SmL3UZe7NrfHJvQ7a3lYgi2BcCjF5eyYtbbspw8jGJ5scvVmxqbHUjXQm3Adol3MTFoq5ujSJIAJngVcDU2sUPexJQlmaQYWAOi7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320982; c=relaxed/simple;
	bh=Bt3mk2Iwu3M4KY9cNK4m0RwGZAFpSKRjFzZ84cADfPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwHqgi8thAcKmV+NxTbq3KdDvvEfR/cjo9D3n2XEHvcrE3aOxHWY24SwV8v9F9c9dNv3Tgr+aQM/IGiX6S2vHnVJzzZhbjY8udh3Pbyq8/Nvdj7SqkJ5eigt8nzGtfIabj+Qak0ZpquKhRT6fWI1lMu8Q4V4Q41Zu/oqgZdrMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/bJtau9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44529C433C7;
	Sun, 24 Mar 2024 22:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320980;
	bh=Bt3mk2Iwu3M4KY9cNK4m0RwGZAFpSKRjFzZ84cADfPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/bJtau9tSaxt3/K6EkpdrBGKzavITkDAa0D09SRVMkl7SRA4awMdLG7LxfXc0Ozt
	 /dhy9gVqBl4U8rfHVppoqLe5cJs5QGHaTHvjkmgr/9mkqM98wyrjvqOZsv45OwurC+
	 6DGzGIblYyUPg72jA6eTdBGHHOOJrT5bzz1M7zxBbo3kEHecFkMtb6Fi9JY4AcOVO1
	 Fjw5z0MpP9UOH2fs3YvnsoyMff6MAqUyHnU82SzGGs+nnXm7FWBrt4ywku72kVIlqW
	 vc80z1FuaQTAEhIHxYDhRPAG2FTBrf7dMfQowGCU/u4aX7WLY5VZcIZBbBT3/L5LBM
	 iuA+++EEcZM4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 544/713] backlight: da9052: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 18:44:30 -0400
Message-ID: <20240324224720.1345309-545-sashal@kernel.org>
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

From: Daniel Thompson <daniel.thompson@linaro.org>

[ Upstream commit 0285e9efaee8276305db5c52a59baf84e9731556 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 6ede3d832aaa ("backlight: add driver for DA9052/53 PMIC v1")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-2-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/da9052_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index 1cdc8543310b4..b8ff7046510eb 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -117,6 +117,7 @@ static int da9052_backlight_probe(struct platform_device *pdev)
 	wleds->led_reg = platform_get_device_id(pdev)->driver_data;
 	wleds->state = DA9052_WLEDS_OFF;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = DA9052_MAX_BRIGHTNESS;
 
-- 
2.43.0


