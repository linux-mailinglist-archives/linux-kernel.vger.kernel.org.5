Return-Path: <linux-kernel+bounces-115130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA55888D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF23128D536
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9D2FF8D6;
	Mon, 25 Mar 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOoiTx5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343901826F1;
	Sun, 24 Mar 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324153; cv=none; b=AzKuzL8embqCfkreIPFRVJZxT+Sfnt9hIPlYUtbSPrJNJzgxpqf01FHlOzIqOTxzc/S+lAgc0BkhisomrjFRJ8lnJ19fyP8eHqSRjPma+z6V5I3pAHyc07t3ohhyioX3gtjbUg6Jz+DsuxVRi/kzb8ytPsYW7UKNKyqYRd9NPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324153; c=relaxed/simple;
	bh=LYhPIjMpKEPwiaOA5bQCN6S1WNeGsEIjM6B9l315d1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qth4g4EOZA10Dp+ZFx35ly4RWA96Fa6GkL/ELX2pd4EoMzGTNp3vG+JtVpF7Rv2MJHq5qrZHSLEQMAtNofIYBjO29cNhcgdPEm+tIxN2l4DU2AVAVDUaJ1lLBZnTt408LTGAL+AzRt2aH5zLh4sL2SxtEqpj1ZfM3rd7cWKw8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOoiTx5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5A0C43390;
	Sun, 24 Mar 2024 23:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324152;
	bh=LYhPIjMpKEPwiaOA5bQCN6S1WNeGsEIjM6B9l315d1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOoiTx5MO5C/CIAfm3VkqlyzcauSIV+3E2Gwy9NxBzE+qo7FEDLfqFeXdBoIhk+Ni
	 5Yz+goY7xUgsNCl7r/DThSa7+MC0VDAZyGXUdWNqjJtl1cpU0Qgs5lIHhBqKTwgZ39
	 zWmDvauqAkS1CXRN6lRM20c8B4fSiGlEDVEa6miUuQUGlzRj0iTrFxRxdTc0nAPwUH
	 juvgks7Rsmu+VQvE2p+l5WQytyRpQOhhahMyKLzeBFBQZ3j/WcymYGUlXuz/ZCOSrG
	 PiRdO6eiZogpU2z3akM2Skb202zlYFdfg5NrFuubAAJm4rn3Uav39tctQ83cKD3VGE
	 rLeCHzNqpgBtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 148/183] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:46:01 -0400
Message-ID: <20240324234638.1355609-149-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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

[ Upstream commit 392346827fbe8a7fd573dfb145170d7949f639a6 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: c5a51053cf3b ("backlight: add new lp8788 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-4-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lp8788_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index ba42f3fe0c739..d9b95dbd40d30 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -191,6 +191,7 @@ static int lp8788_backlight_register(struct lp8788_bl *bl)
 	int init_brt;
 	char *name;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
-- 
2.43.0


