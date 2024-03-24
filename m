Return-Path: <linux-kernel+bounces-114365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E879888FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3891C24272
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327913048D;
	Sun, 24 Mar 2024 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejYMy5bE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A2216182;
	Sun, 24 Mar 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321760; cv=none; b=kiYckK5GHiWWD8ZYneKol6E3pILqEVLxa/3NEzgFQS2npUXdHBbAukj5pzr1fYHC/lDSCcrlJIXIlXRouE9pqt5Px5DJwRiRnisPposjFNx+LATgAdf5DMiS/VEqeSlbfDX/1Kd3r8PHOfzkQ1Pbw68btkOzmAyyXgyP2SJiRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321760; c=relaxed/simple;
	bh=Bt3mk2Iwu3M4KY9cNK4m0RwGZAFpSKRjFzZ84cADfPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoVqRfIGqeGkeQDtzkUis1UPYn5mVAl+3qFEONjwy7EFOobGKGMV8IGi477ykIyUj1DiZX/qqfD2C5iWCWQHC+5P7c1Ykm0y3k06WsF64m7p0rixixiSmkYkUZvEZn2ZAqZIVUrHwYkAcbXQGlH7URTEuXNoNDECs44fSwHPHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejYMy5bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82E5C43390;
	Sun, 24 Mar 2024 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321759;
	bh=Bt3mk2Iwu3M4KY9cNK4m0RwGZAFpSKRjFzZ84cADfPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejYMy5bEReIjXHdV3udgVvgVYbRvqhfXDd4GkJZH7kiWPp0iHiS2ymDoSyc2fT8YM
	 Ibgz8tEcOQHNlS1uAUNFtYiQiK0iFT7pKeR0KXhUFGOkmnnjepTNhwybRFhXs57cTn
	 MYTUq7h2EebVJZVP4Na/Z7frZre0vwuMQMRMUEHfQBmgRIGuUU01lVGIBqgfu+uOAS
	 vsh+xPKAwkgCEHjZO60Fs7CkH7QNG22ENNUKgZ6J1Tgo/TSiAKZQJgjDcFg7EuUeZL
	 j9kVOewVJuQuA4rBIbw1Swdms1jMfF6v1m4AafK2QivGZ8jM3/aa8ysVEXNv/gUjIq
	 KCp56uIhWkBIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 487/638] backlight: da9052: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 18:58:44 -0400
Message-ID: <20240324230116.1348576-488-sashal@kernel.org>
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


