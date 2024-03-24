Return-Path: <linux-kernel+bounces-115519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA69889CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581D5B313EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F8423CB97;
	Mon, 25 Mar 2024 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyEGi7sJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210011494A9;
	Sun, 24 Mar 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320977; cv=none; b=UJhOygJFrSjuqtGAl3ctynDdEq2EVOR4G+k1SM7rl87+F6ynMc4pCatsnkSrdh7jrFifS8PMsEe6IrKaiNf/AjOmBHclGteLABX2UdVdbTlH6zbxm0qmyJu2Z92B+q9Ay0jiBbxZih0iEx/b+afwXEpOBlJ7qD5jOvQ6J8xe3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320977; c=relaxed/simple;
	bh=mvaQi4rBDSOnIPPLAudxamhpMufrPv08bZt49wXE+sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDgWXrWMa86oLrLJrzHJveWA4CwFHY6Nna/D1KxVcsGQVA8cFLD0+6o9uWY/543hzNj+aksTHEY2nTN41JaRuwx/sq13yT3wUX8uHWpyeqlXRJq63GAQGxkR53K/oC069ME+RnTB8cJt/43MNMfliZB6bh0Mnefv06hr8pmLJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyEGi7sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BA3C433F1;
	Sun, 24 Mar 2024 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320977;
	bh=mvaQi4rBDSOnIPPLAudxamhpMufrPv08bZt49wXE+sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyEGi7sJ2UWXLrCD9T6TdhQi28nLlq+pXPgoGM061u2iCTx0yhWni2pmuHfpzKV5V
	 uT4xZZGXT5GLSr7td3T4kPfS5WffwEI9FSofoFYlyJmSqAf+Eo8R9QcxTVFodhzTNE
	 AqnYBgW5Dy+ERL1FN3YF7yFhoCzN6JpzAa4vjdk5xIHAALUp02LOGl7UOITDmkoI5u
	 9fjUwXdy1tYQWxbGOZ1GOOcC9f7J2z+qkL9LeDQZLW+nS88xEM7gUaoD9Wgoo8ROgJ
	 /gMoqX9HqrxucIjfVOY54Y9UwwMO67xRCWZ7tbrG0l+cypjOIuEgAlqHvuqzFj4PvT
	 0OR4gyfhuJIDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 540/713] leds: sgm3140: Add missing timer cleanup and flash gpio control
Date: Sun, 24 Mar 2024 18:44:26 -0400
Message-ID: <20240324224720.1345309-541-sashal@kernel.org>
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
index eb648ff54b4e5..db0ac6641954e 100644
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


