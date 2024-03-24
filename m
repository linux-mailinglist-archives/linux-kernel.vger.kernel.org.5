Return-Path: <linux-kernel+bounces-113417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C7888428
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F61E287FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13913A3FA;
	Sun, 24 Mar 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXgYaKmo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBF6FE12;
	Sun, 24 Mar 2024 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320219; cv=none; b=sjD5GtJQJLSDatM4tF/wt5sNbicNVV3UuVTOH77ksDzxoiCUV82AACHEtt36iqp3/2W6al5p30NPIDpTTTKO7ySmf4HDRZ3aGeTnzJiWJGawafa/zFWpg97l4Mwn0V0/QPzQI6bqeaEujom8hvp1aIwT92vbptLDl0w3ZYKNArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320219; c=relaxed/simple;
	bh=Bt3mk2Iwu3M4KY9cNK4m0RwGZAFpSKRjFzZ84cADfPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYEjRaKnD+RD2M+s6bgtcJ2jZgGV17VX8wG/Y6Zqhe+/XXFYdSEwP7BLPbRRBLNkmbdp1ZLr1EPAkCRNwm9C05vM//aSkJdXvFFIv2sZqz0SXoT/3a/C6nl7Rxn9itBv4Jkwru72r0wfS70aJJPsLgrXe9rF7oIJWnFUkYLgSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXgYaKmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A47CC433F1;
	Sun, 24 Mar 2024 22:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320219;
	bh=Bt3mk2Iwu3M4KY9cNK4m0RwGZAFpSKRjFzZ84cADfPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXgYaKmoc9ON+FojKptZ1Yj6njmUO3duVaOz2MXjxi4f6kSupCnbQ/1mvZXKDcyG3
	 jDxdu+yOaQTHrJ5gREzfSVipqLBjpgxMlTPtwSbqFYmwvLASPyHdRWoTCQrS2EJVT0
	 F4roZR6Jo12Y1hSoeL1clD+z8YWIw3Pofm7CwZ/gysk9TuZt4RAMcVw+Yem/AO0Q0d
	 ez+ZEFhGqL2MdW8QgrV3Gi3zeB6+A7clNDfHv0ibrY/CN89raEe9u+NSKDGWOG0pGC
	 lEDRnvw3Gm0z4wDz988cpsgX/SyU2UDYaZftlwOiJint1PCUj4jKCB8BEeUzUMGPTQ
	 GR2KBevHH2Yiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 526/715] backlight: da9052: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 18:31:45 -0400
Message-ID: <20240324223455.1342824-527-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


