Return-Path: <linux-kernel+bounces-115970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF48898EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6731C31F16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED47F3941FC;
	Mon, 25 Mar 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTg8WirP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9814D426;
	Sun, 24 Mar 2024 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322258; cv=none; b=Ux1U44AgdRhvg7Oe/sxpvCmGDxGmUgxajwAJgTSfIXjaSCdvdKW3xYgziRcuhiT+fvCPmXYzsGvl6JR3aR67iQkmGzen+UQwaefS/FvejVWuMnRXPH8PODzfRF5bd9i8wPwvGd5A+QmHygYy1kQ/y90/Y3lkUE80e1Kc7SJz7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322258; c=relaxed/simple;
	bh=3seKHVoN8/gBs3/qRcJQnELvobzcetvAIc5iZRBAZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqUy9p/9uLUe69L0aaEaxSM7iUyBhQtNDxCv9Id0vB84BnJZGWrgebzj4XU6BSJnYXG2FqEmkk95jWeHlAtzbRCQ5yjnI36ULG8zO70NbY7ugjAaO3hSDuL6GyAAsIPkOrS4BjarJVOcqEPjmG2LDZogJJRvmJMovn7resK8hg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTg8WirP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57057C433F1;
	Sun, 24 Mar 2024 23:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322258;
	bh=3seKHVoN8/gBs3/qRcJQnELvobzcetvAIc5iZRBAZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTg8WirPdXLb0A/+CIRJNQbnbqIrlus2yfcO197thunajERTF/2UEC6ym0DAlEyfP
	 3ySuMlp/WmemkaZEqFEqWFZCvth/1aoVasvWypQkVtAkwa+xKCdWOOcBD411M66NUV
	 tQR/CIs6cE6vM6Oaq1o/tBHPRZtS15cUr/RpB4dQablkOdd8K6av4Bm/652pMZjtYr
	 UHFEw8ynfiREhW67VXy3oz1rsNpZI9a3UG5r5qjQ8svXgSQ6vErES6ei8jVjrOPX7n
	 8J7pYecmHtq2angb1IjN9KobJ4WOzNVLIJEpqei7m5GPuBWnAlDUjJgb0PdrPUhUgx
	 1ir47+QoZIiRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 340/451] backlight: da9052: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:10:16 -0400
Message-ID: <20240324231207.1351418-341-sashal@kernel.org>
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


