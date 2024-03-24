Return-Path: <linux-kernel+bounces-116200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82B889D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE52C1C35279
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F073C290BB2;
	Mon, 25 Mar 2024 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgGadleE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6617CF5E;
	Sun, 24 Mar 2024 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323809; cv=none; b=iVyykKCy7RfbWt+t7qRQD3VMA9xlWHhfm0sFnkmYdygrhW6v6GJbzl0C0OoIdFaAd35Fp4eBHzKl9Nwc/0H+utXCa4he0Vw1BPOB9Hz+cu4Ots7VkPGQIuijeSs7IoDVdJV3X/Hm7dRGpbYWl6FaSllEEkm3QFzAw7/HCoILiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323809; c=relaxed/simple;
	bh=LYhPIjMpKEPwiaOA5bQCN6S1WNeGsEIjM6B9l315d1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/xWZqu+xajfOxLtEJws7q5a9unvqFplwY87VIfslLCG2Pp7U2yhpXuxiEK/XfGG4T3CeuXWcftj1KTavF/BAKMYLp3d08EE8kkBq6oodiZ/itAaZmV1giecP+hINsI6lnfvGS0EW/d+w7LmzB8cDbIxeRe80ghudidQyEizdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgGadleE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B86C433F1;
	Sun, 24 Mar 2024 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323808;
	bh=LYhPIjMpKEPwiaOA5bQCN6S1WNeGsEIjM6B9l315d1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BgGadleEUqV1I8C9HRERFC9+BcsS5f3quA4iIZjfNTnmgMQPQECN2SAOix/yU2/fL
	 zNw99L1cpvbfaSxBIIT/Vc8SkgUYfyZTVbEXQ7g/B/2VPtcotEeT4iH1S8WZoU7cbY
	 kwzIKbiGYKeuxbvryHJA6K/bQmVF1qFUh8CuqwocP3GjOdJ4rHOPnEltZbBb2ZJsSv
	 5OZGExUATYEBd1Oi93Myn2OhGs0OLNHnxtL0jDDKHP5wO8rk0f0keWL3LMcU8vIXdg
	 rx2lO/DriFAPHEcraQKwC7I9NFTm7Y6flisfnR4wlUq2BWppupPw8Ik1J1t/QMM6dT
	 In1dPzNqLIB/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 187/238] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:39:35 -0400
Message-ID: <20240324234027.1354210-188-sashal@kernel.org>
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


