Return-Path: <linux-kernel+bounces-115127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B6F88931B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FF11C2DEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402E2FEFA1;
	Mon, 25 Mar 2024 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duzd6peq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483DE1826ED;
	Sun, 24 Mar 2024 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324152; cv=none; b=ZXbqYlzTKnqGk6q+UKuOl7+GH6+f1+mxMhp/1lcM9Dimvbdgt3q3vJR0qsp0Of0NaAfW2LzT1sqsU7/2Uzb5MeuvUd/wg4NhgtRLREELzcrwd8gEVakejo4Chja0E4CaRjcOKo2vicKuFU6R5LQXId/VrGh6OFbqR4+xGoueoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324152; c=relaxed/simple;
	bh=sEYKigNfaix1DXTkbduGtVqUs9Nej6EnPx1x34vReh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRJkpxgn702OjxGIafGivShD8e9XAl07g31oXK1dhDeqBjd4bvfyp3F5o1jZjFB2ffWj86JRFmKtnv0eSiob1iW7PPLv1kiPctIOtQo27jrjfwFia1JluQQRGjZ5b2b5Siq7HFhffU1UVyVPAbJIkLkr5dzwJLGWvDqwom6IFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duzd6peq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81614C433F1;
	Sun, 24 Mar 2024 23:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324151;
	bh=sEYKigNfaix1DXTkbduGtVqUs9Nej6EnPx1x34vReh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duzd6peqTuacRD8QsJXJgmFgWOt9fTeIem8Zffq8KwftscqJbuBKHJ/ARQM+dyaAF
	 mv1e4xKxI24aV3zaS0w/M6mkdQkF52+8CywcuS+ynDx5rbss3MZWeRbmhoK0s+lVg8
	 mi7IAAipaaViYVx7rAU4qCDhYJtUlJHWgx51e2d2PoYrXg/B8hWLWmX2RaNLeXeYGT
	 nVMxo9ZI58QTHk99yqiiiLBsJb/Uyf60yGkJSMvOF6rlCH1DYVCylH60qsSFmpGohl
	 iFMsSShchAM66Ho6VfuNBLjvMt2Gzg2SSCleO3fdnBqWb3BflT4TPDaYBGMqdJFcKj
	 mx9ki5Q5mgPrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 147/183] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:46:00 -0400
Message-ID: <20240324234638.1355609-148-sashal@kernel.org>
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

[ Upstream commit abb5a5d951fbea3feb5c4ba179b89bb96a1d3462 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 0f59858d5119 ("backlight: add new lm3639 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-3-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3639_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 48c04155a5f9d..bb617f4673e94 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -339,6 +339,7 @@ static int lm3639_probe(struct i2c_client *client,
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
-- 
2.43.0


