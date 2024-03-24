Return-Path: <linux-kernel+bounces-113898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64FC88873D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2DD1C265AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7520FAB9;
	Sun, 24 Mar 2024 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJKvrxKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474812BE83;
	Sun, 24 Mar 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320982; cv=none; b=CznbNR+tZxlwQJqyk9ck1l8ZBAXVIQSjRM6/qkJgdY6dDzEnkb7/h3njMCPO39riuVtLD0QOD2dQKKVCwM5mPPdNgDrcJPlVHmz3r3hGdUnuUvaHVtULQLtXwt3WtrHtKC/Xh14SGY0cqz6/MZsB3cPmU8wWN3elQmO/PaGA1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320982; c=relaxed/simple;
	bh=4PlkdmqB6yZ6noXjc3qFkk6SADhbWCGGBO9b/AhRtr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEa8VqBX2JszRUKgiMFWONX7NlACTamkh4F0/qQN0m0vJ+YjaN9cSCnelSUCexAse4TgRMfoRmqDKH4Sw+PuFdmxBuV/++/qOWh9kf/+vmCHIRl8J+T8gpk3UpH2oVTvO75/mtqetXIihajjmjS1LVZk6sAzCSEy1kxrhVt0WGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJKvrxKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF52C433F1;
	Sun, 24 Mar 2024 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320981;
	bh=4PlkdmqB6yZ6noXjc3qFkk6SADhbWCGGBO9b/AhRtr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJKvrxKh8d009KdnRig8XTRy6PGBqEU+sXbI6+XggA557JRoIYWMw/D8McnyjLy3L
	 qlMwGpV8J2b5+8VMt9IF1QnNp1dpTt8nrwZxtdEKLA5yR6MpBeNnBlbg1sjIUVuNPF
	 iiGsXp9gpiWzAMGW2S7Gdp29Bk/B87TEyKZYSuZNhcnPzj8sErGoGNIAOq4R83t7T+
	 4G20iMdiC5uTKmL2qb+rGCpHIAWRlMsKiqFA7YwG9s/wZOv4ASv7IIJ8ziYNTPvryU
	 TjqM1JY2Op9quEHvBNcFpAeyQFm2Dx+p650SVUcz8/qJK9KzWzeRprMG57Sdrdgp3W
	 /qpA+7IJUOg7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 545/713] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 18:44:31 -0400
Message-ID: <20240324224720.1345309-546-sashal@kernel.org>
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
index 5246c171497d6..564f62acd7211 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -338,6 +338,7 @@ static int lm3639_probe(struct i2c_client *client)
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
-- 
2.43.0


