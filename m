Return-Path: <linux-kernel+bounces-114361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC9888FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBB71C2C183
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13788172BDE;
	Sun, 24 Mar 2024 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CopaLZRY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757321616B;
	Sun, 24 Mar 2024 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321756; cv=none; b=WsJIcrYjQ4/y0xtZzVME1EMTIcdZ3Z+0U5SlKKMnz3IaSxkD1Q14liMiEsisqbWGLQwZGdozbCEB2pBnzpAb8UNkhrdtc/C11xVjwnGrRzWKce4oFBjdhcN/VjbQVf3NBlEdIo7KVoFynApgEAARpjfjBL96OboRIVvS01LGJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321756; c=relaxed/simple;
	bh=wDEJiLHscUK9NyKHIPvuQ3CVDTPKOTZ/4yleEtifAjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WveNKNpKxtfVHAfsZ7A+L26WDE42RJ0s4CoYiqlwz0R4GxxVZan+b4/395BjNTmoBHKVvEMDSGA/QobQcwqT7R2XE37fxuvLDfXesgmt55+ItAHM8hCKnekeZVE+x3sSWgQhitukNnzeJLKdpULSy+tSxIYMuJkzroJTe/+Ez8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CopaLZRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC79C433C7;
	Sun, 24 Mar 2024 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321755;
	bh=wDEJiLHscUK9NyKHIPvuQ3CVDTPKOTZ/4yleEtifAjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CopaLZRYKB9FbRPcOO7qFYqJYxxT6edD6vyxwtmp1Wn0UbcNRdtLtvJ3jBPluL41y
	 ZsfS92pVHq58WOJQATZqt0LVS6zA8Ae9Z2QMeDoNy5JDG2M4ybPMnYDeJdl250cJTI
	 mcigUswLxPGux+dfPdtWLaBqBT1gNXOdKr7bMRzNdpxtGEp2DjDyZLF/YWnInlDIu6
	 PkxJd2oABT9ocxNdzZ/OM9xG5p8sFVTm2d73Nvs7z9FvVgZJZF+87xVcrIDMuIjsu6
	 Zh58JfhDMGPzQ2eG8w3bDljOePjHfPuidQf+Bb1fJ9vMKg6b6j+a/WeyNs9gsO0CIg
	 gwnuepjEBRnRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 483/638] leds: sgm3140: Add missing timer cleanup and flash gpio control
Date: Sun, 24 Mar 2024 18:58:40 -0400
Message-ID: <20240324230116.1348576-484-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index d3f50dca51366..991b3db63ebe7 100644
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


