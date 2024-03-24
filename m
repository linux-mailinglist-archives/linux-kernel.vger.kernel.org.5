Return-Path: <linux-kernel+bounces-116084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A066889592
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E06D1F30D66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB6181820;
	Mon, 25 Mar 2024 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bih9XjZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558E1782E8;
	Sun, 24 Mar 2024 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323538; cv=none; b=WRMwmdM9s/KBDW2cFuwsOvsdHc+CjgayCJXA7+2k140aETuhRX0Ugwl1rWdwyKcsgIebVl2aHz0GQsymIK5pUaXxveYtir6HIsV+9kI2DE1oOVHPeW56xe1S4sK3YT8xw23RYR8JusZMcseTwfD4myZTGViPpluRdw/WBdT8Tvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323538; c=relaxed/simple;
	bh=sEYKigNfaix1DXTkbduGtVqUs9Nej6EnPx1x34vReh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtBrJKYZ+XNLM3V7ma0QCFu5cg8eEIqJvIA/nMldH8yU4MuiSwy18H+MP1BSjYsfjMef22FQIQCC1/H/ukCxkyGup0UqfNFJpQmLdkE5UN8NNLuD9ghKbVyYt5+tyQPgY5CJG2PhfMRjWCmeJRiYwiwTIx4K0/hcyWPz5hkv+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bih9XjZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C503DC43390;
	Sun, 24 Mar 2024 23:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323538;
	bh=sEYKigNfaix1DXTkbduGtVqUs9Nej6EnPx1x34vReh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bih9XjZFCs9adpcsTqPs/DzcLofUUgb51vm3RrrS7SMvlWgmFUpH7nzX6WG9rCl6G
	 rGwurAzoawQxbjOrwnA572OM9PLduaQff9GVN3zXFyv9aGN4SkxTX7B1PjU6wzu8s5
	 3gQiz/tAU8k+2D0piJ9WY/8sVcf/oI6NiI3z9vtl05EIaZOaI2m52SH8qVW9106bFd
	 SYHw7xqIBQ1Mv0TYslV75uepp/cy2+yYSztqjr+juoP1q4vg7qRcuSnwVATLoSw9fi
	 UC5dYWtNRFtxJsFBjlImsz9i7Vnouv9d+0IsR7feBenP9XrB+m7R4H2D9RoPd9jn1H
	 k0UJiajbq3oWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 246/317] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:33:46 -0400
Message-ID: <20240324233458.1352854-247-sashal@kernel.org>
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


