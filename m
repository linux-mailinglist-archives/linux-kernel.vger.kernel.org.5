Return-Path: <linux-kernel+bounces-115027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D2888C94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6989F1C2A13B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1AF1C17EF;
	Mon, 25 Mar 2024 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Olh872Y5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964417CF40;
	Sun, 24 Mar 2024 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323804; cv=none; b=gixecZMQm4Ch5dY484dOqJ/XXAbT9e57q4coqEEXvD7JmAEUfcdhE1QEjq/w3cBpdB2gDluFdbN5Vj0CjR1Z1lCAlhktlPhlOQRkalBrstFLqQ8BU1pu3rLdZ6jNQKBXSTBu/uL8bnT+qaQoNr2/fGuiDhc2jFaBwIDlX5+w+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323804; c=relaxed/simple;
	bh=3EjjOae28iFTTN9Vt3atP73bzK/0EvxJ/PX5W9Dipi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeRggbmRq7pYWPpCXymoenChqmrl2MnJ1B7joTnPOfrVxR+i27xAJC+4uP1J3WJmDL1dOd9G4QFmM0tGJrd9oTCtDaf8rn8HKs3qzcJLhSZ+cAtpCpf/voTBhMnmH+q9k623A/hfHJYorEHTJnS/PoepL9rjt+kcS8QyLmOZ5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olh872Y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994D7C43390;
	Sun, 24 Mar 2024 23:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323804;
	bh=3EjjOae28iFTTN9Vt3atP73bzK/0EvxJ/PX5W9Dipi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Olh872Y5cw+2KkFz2Ru82hWbugs9eFEXn8SBNMiqprE2hCHiBOVx0F2FzUrQXOn7j
	 aO5oShWpc0SasIWeK57kj5tbEm0kmy0AyF7R9kZerWUgRUtxMmyzb5Em+bMGbi2jRB
	 H5wNCewBMBlF0IEpUEzfmYzdVM+hx3GqyWXVP2SznDCGexSBjsgQtnc6gvjZCdluNE
	 uhn2Nbh0Ppxih2hlIPZypmvCmnmuskPT9U/mZ4EiN9m98a5wy5hUK4iWOh8n+qkkAq
	 t1CP8C5Gt5qNpIZYu1EMmd0Ey3shMCkEXM5A061DEwylohV7alj1znilzPHTB3xkrU
	 VTAD60mjbUD2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 182/238] leds: sgm3140: Add missing timer cleanup and flash gpio control
Date: Sun, 24 Mar 2024 19:39:30 -0400
Message-ID: <20240324234027.1354210-183-sashal@kernel.org>
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
 drivers/leds/leds-sgm3140.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/leds/leds-sgm3140.c b/drivers/leds/leds-sgm3140.c
index f4f831570f11c..e72017b11098b 100644
--- a/drivers/leds/leds-sgm3140.c
+++ b/drivers/leds/leds-sgm3140.c
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


