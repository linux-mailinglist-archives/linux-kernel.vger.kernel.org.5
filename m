Return-Path: <linux-kernel+bounces-114884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F48891FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA48728AAAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CC52CD510;
	Mon, 25 Mar 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU0UmZED"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8CC178238;
	Sun, 24 Mar 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323535; cv=none; b=eT/wyxCI0tgcTSttjE+nQBakELCa5hA5AXIk9S6wqvcn91N1TnDIQ98QwqHBZUWgZEnaFV5R1UYaQwuAqB0nTRZZS130tBOHAnt/iJGy9cnWQbd9oAmAobhOjqRitjRSs/+MuF77Zvf3rJ2ZZQ8JvtagmHqK9n8vVOvqJ7RnvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323535; c=relaxed/simple;
	bh=209fK/14O+ZT6vCzV5Vxv49X9YAFEn5iUZM+C4/5aUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3W5zNSgIQrgbTkTQbWyoky2tMblWfwOGfR2dYkyo3LeKtRoG1ETvhoH9m9oPkqcbkpI9viag2O1rHX2p4ihgZcTJON6exOgMBN40rh8DRXP0+b3Se3IB1Tpwm7mr668T4PQddgcvO68bdooxcu+ecW+OWop5clcBSjH/XoUUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU0UmZED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB561C433C7;
	Sun, 24 Mar 2024 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323534;
	bh=209fK/14O+ZT6vCzV5Vxv49X9YAFEn5iUZM+C4/5aUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jU0UmZEDqOKkykRCEFJkrvP253hXAjlk9gh0W+evx9ifdKxAOzVgDTM6LECCgnAa7
	 dsAp3E/6Y7XlLWSLrqG6YqkcOFVP8nwX9+XA2oC05qjpn/O7ntaeRO3cFOKptD4djl
	 rVl4Xce9pAaIdRrP2LM1v+CZbpJYYj7HAxkUbpWKAtftqM1PFpSPPzmxVSH1AZs0j/
	 ihj/tbJvMJrA8me4wcWyrNM3e9h38mz0zlYtBpTMn6JWjCh4ORYFH+ppUA4P0jXVnR
	 f63POvPCpf3J0NIJ/gnRgpF9yb5q+YVPxnOw9Idroc6nDOvj/oh9QI1w0YcwmdMUhL
	 OkL/udHgdgV9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 242/317] leds: sgm3140: Add missing timer cleanup and flash gpio control
Date: Sun, 24 Mar 2024 19:33:42 -0400
Message-ID: <20240324233458.1352854-243-sashal@kernel.org>
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

From: Ondrej Jirman <megi@xff.cz>

[ Upstream commit 205c29887a333ee4b37596e6533373e38cb23947 ]

Enabling strobe and then setting brightness to 0 causes the driver to enter
invalid state after strobe end timer fires. We should cancel strobe mode
resources when changing brightness (aka torch mode).

Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Link: https://lore.kernel.org/r/20240217191133.1757553-1-megi@xff.cz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/flash/leds-sgm3140.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index f4f831570f11c..e72017b11098b 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -114,8 +114,11 @@ static int sgm3140_brightness_set(struct led_classdev *led_cdev,
 				"failed to enable regulator: %d\n", ret);
 			return ret;
 		}
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 1);
 	} else {
+		del_timer_sync(&priv->powerdown_timer);
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 0);
 		ret = regulator_disable(priv->vin_regulator);
 		if (ret) {
-- 
2.43.0


