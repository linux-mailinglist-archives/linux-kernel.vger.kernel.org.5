Return-Path: <linux-kernel+bounces-116291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D8889E06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F041C33CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B503CCC79;
	Mon, 25 Mar 2024 03:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMqSJA98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBF1826E9;
	Sun, 24 Mar 2024 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324151; cv=none; b=cyK5yYvHD2U73wQfl/GFn1cH7RyaG2jKGcRUXaStPx5BqGcPBgLJd/YIjRAA7Ps/p8QDCYkhea62N4VVec4k856hMSuV0u3DHF+LgyrXGhRDAVlrkMGzH/7Ts5fpGULK818KYWhF1u/9gnLPHCHMjeAcnCgXhd8D8oAHxSawGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324151; c=relaxed/simple;
	bh=3seKHVoN8/gBs3/qRcJQnELvobzcetvAIc5iZRBAZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOlFi7xt8LjdR3D+sZDWwk/ev+Dzlgx9IVoA4O+GQKnDAvbs5JX65udMl1Nv0qt74uCaOmMVflz7gwBVrFZ6Ow8F15W4+wB4AEHxKNXvOYPjRRWSXew/Hm5JTP8RuVGup7yFKjlNFuKQhCnxlR6gcX1hD+2kMLyj4iN31Dp0CVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMqSJA98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E9EC43399;
	Sun, 24 Mar 2024 23:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324150;
	bh=3seKHVoN8/gBs3/qRcJQnELvobzcetvAIc5iZRBAZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMqSJA98KW45yuCZ82+6rz2b+wRtodV3UhbJsU+f6hE8H9nQdXxZZinR44+QS9ClL
	 wNlRG2K5apWKT4yueziia9BUdZIbWgqNRDCipXnWtJ42FGn/I2+/NorlmE7RPAaYXB
	 edLviICg/Apx65r0AqTJss+ZCDFiC2DaHNhxLYZRKI1HXC2GwMRpPSAIpY6E2bCrKx
	 6xzQUBQX9pT+8xra6Izkn7FxMMxGmFHgSccv5SCJQOpjl8/ub+I+NFUNUAdJt36Gn6
	 9nIW24WpaMiU2YXUQEsuLYuCNEJRjJIv3LhCrLXoPaB4fOrNY/cGxB5o4tc3GP03ol
	 Z++vdcubzLjng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 146/183] backlight: da9052: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:45:59 -0400
Message-ID: <20240324234638.1355609-147-sashal@kernel.org>
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


