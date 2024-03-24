Return-Path: <linux-kernel+bounces-114885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8A8891FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B693E1C2D9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101642CDE81;
	Mon, 25 Mar 2024 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2yVTPeA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216B1782E7;
	Sun, 24 Mar 2024 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323538; cv=none; b=oJFFcLRud0Yq2iKjVjsJLBj90FOy7S7AiO4ZrLkfYztqvJl/uDJaEhcSMUNLn7bTRHW+mhzOPs4Jnm7cmL1QrDjKRvBnnCX63uco7ss7D8Vx8r+rGpd8JPotBLGXtyx3yocyP3OmIYE69NxkJZDtqzVK+uyYQxWJ5myIEaZENSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323538; c=relaxed/simple;
	bh=3seKHVoN8/gBs3/qRcJQnELvobzcetvAIc5iZRBAZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOdKzPVMWe/RRZqE56IDJVIZL+ZdqT4jUK4sh3HlLtnvW9v1luF2QxVbVVFOrHzknZ5tCFBaCLCRwieQoOy1okaHVx4wbmD+Liy+DXKVBaqoDS7ypqYaxeYFTo92ILNBAW4uN/g+RkjbHrcYZ5IKp60fzBspQYG4YRVIqVbC9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2yVTPeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1347C433C7;
	Sun, 24 Mar 2024 23:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323537;
	bh=3seKHVoN8/gBs3/qRcJQnELvobzcetvAIc5iZRBAZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2yVTPeAhq3GvLum+wYMUk0LhXzPuZSwfjW7U7FHOGwfOEuCuBHlvi9BRFVKi6gKK
	 7Ys7QD8zes6m/VZhqXllqDosFO+jy1aiepC7cVSOM53xqjvVaeYdUWcY5eP21xXkO+
	 MiRH284KoxiCPux1pFeZ9NgKXBrzX/arIkOXlBgM98wYXep/DZA77ryL2RlIa1fje3
	 Z69BbsSSvbnvk5/KzfZYzUFsaCymdNcwZ8f7JSFcINMK8K5/GE9FwhPw447/PQathQ
	 Q0pGdxymxvlnwXnozUZTD+oZWUb+R5kvfloUt3Q4UuA6iHRyZitcLUxXHdHImRqi0W
	 PGtbb1nEQjHFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 245/317] backlight: da9052: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:33:45 -0400
Message-ID: <20240324233458.1352854-246-sashal@kernel.org>
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
index 882359dd288c0..aa00379392a0f 100644
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


