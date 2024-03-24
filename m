Return-Path: <linux-kernel+bounces-115031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF4888CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2F28FFDF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02081C1AF7;
	Mon, 25 Mar 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au8W/fLx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79917CF61;
	Sun, 24 Mar 2024 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323809; cv=none; b=UVg4K/hBX+gTZxON6jPvGiDYI1zXXKExMBR8M/VIxkKloD35eJib0spXDjJ2VRF/u2TOc+ohn+BAtPZ8qiOqkEfLMc+sHMjtVpnSJtQ13HddROIe5RPuXI/BebMfrmHmd9Ej6pygqEBXDsdG95+vbERgeGLnp/YnOGiFvbHZzhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323809; c=relaxed/simple;
	bh=sEYKigNfaix1DXTkbduGtVqUs9Nej6EnPx1x34vReh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkCrNO2JyAAvA6EfHTuUFEJ0svS0MgkiF19bzbqcldzlnvXFqSysKZWPv0EJjY9b7KC9iZ8AG5JCyn8hhTFdWREIEtjjDDUmoWGrkaH2C9Jr+4+4dUu5WEaJWFZnkyQyO/GuipfC3dijUw8y1XVyF7GWiD/CrfDZEP29kV0zxvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au8W/fLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D47FC433C7;
	Sun, 24 Mar 2024 23:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323808;
	bh=sEYKigNfaix1DXTkbduGtVqUs9Nej6EnPx1x34vReh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Au8W/fLxPcg6Wp5lvaQrL4K9BwNpW66nobnKL42lGBSGIhfEzGMIOWebXkYrLCdSf
	 QfhXp9EEb03LuOj0C7j3ib8oT8tNHQdy+uoM/CnJat8jY4sbLwypltkz9dxdYsTV62
	 5fdvGlrx+8KYIepNpFgMLTO+OSX1JPoiOhmoA3XJ82EtWq2RXA3ei8oWw7aQa8QnnI
	 EomQECbVbnkNhM8DJ8AHkW9MMoLsx6qX1ton+nkvmP9z9WeYK4QpNqHAiU6R+vMI2j
	 APx8HLg23L9tIpdO1YuFH2jWkK4nQCU8hArXROmUWLXgbrDPg9qxzAfQrb6FhNqXxd
	 DmnNeq+i3IOEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 186/238] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:39:34 -0400
Message-ID: <20240324234027.1354210-187-sashal@kernel.org>
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


