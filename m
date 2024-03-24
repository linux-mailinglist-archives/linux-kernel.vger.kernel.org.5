Return-Path: <linux-kernel+bounces-115248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1732088936E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1451C2E51A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4591CDBF7;
	Mon, 25 Mar 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8gNrxcV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C32987A3;
	Sun, 24 Mar 2024 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324357; cv=none; b=kPD1067vGItL8NxWUb8adLr2QBTlAIa7okvf5Y2WJohMK72ML3zYDIW0h1XGPICfKNWrXChI4rh7eSp2tArBzMxRMFw4AQbQeLIwAkKTxAx+md28U6Fc3MdbpO4tIY9aHAE/xc5jCUempiR7cL9qDH+IawG9vH7ZZc+9Cw45oN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324357; c=relaxed/simple;
	bh=0RYRcER2L99FYnTEc7JLAZOU2F2QK6UDRlV34NIjQKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opbm7vUQRD41DQQj9ofN3G9gYt4NPvDtwlxHg2pFEKEO2DhyD41JZoZIrJlSzZ6Th7HXdNf5HKIKNovOqcA3sw3/EumvyvLoSSDzDCJWbA5POLRBm+rC2kFRP9wYk023jIxwlfZ5Gm8Kdsza5skrZmc74mF50/N4iZEvWfRA4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8gNrxcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0435C433C7;
	Sun, 24 Mar 2024 23:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324355;
	bh=0RYRcER2L99FYnTEc7JLAZOU2F2QK6UDRlV34NIjQKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8gNrxcVL3WIx4NVIQ4G3PgG3eB5ZzCvL6Ekd9k6NF6lzyOEmBJfFGQfTH8Ihn/Es
	 fW4p+a/u97Ja/gut0Gjhh88ZbqAgZrSd59WWexKssCT0klSWGMufesTjJdG5H/PjvD
	 QOVo9duA/5rnfDQ+SbK0dckRbpi1E99D0Kv+FY70AOeHA5EVX09gUQMiTmbnezn6nU
	 0wG5LpGpwNMt72qSoA6pOudSQd5G6QKNlKZ3Yx0C7e6h6+yMX45MscDdyHhyDlX5RP
	 e1w9g4245VhHCH+35o1MBWMi5ywoNqyRFpXC8wdwRoe9KKt6xczpjvKeQ/EwQM84Sa
	 uIlhROvLhL+nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 123/148] backlight: da9052: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:49:47 -0400
Message-ID: <20240324235012.1356413-124-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 49035c12739a1..d48513eb3bc5f 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -122,6 +122,7 @@ static int da9052_backlight_probe(struct platform_device *pdev)
 	wleds->led_reg = platform_get_device_id(pdev)->driver_data;
 	wleds->state = DA9052_WLEDS_OFF;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = DA9052_MAX_BRIGHTNESS;
 
-- 
2.43.0


