Return-Path: <linux-kernel+bounces-37142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE9B83AC03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238EA1F224A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F1E12A172;
	Wed, 24 Jan 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEszC+d7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369D604B2;
	Wed, 24 Jan 2024 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106593; cv=none; b=hznwPpqE9pVeGC71ktkIiAPMyr8wVUv91W1JPlqeQgYMkLu+pIaRRk1EHLUFB/vsgVVW8Ybx3qNEcooMCllOEOPOTVdsf3jzuSXcbazZ3Pwz+9WHMJldU29OpivgKQsD4v3wAEa8MB7zzkfnICE4bAhxGhps6jRr5RUf7U/y3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106593; c=relaxed/simple;
	bh=OYia0AtsnKf67CdsbSIm04KyjzCViV9xEqkqRkan7fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVzNq3N6gmagYjnaMi7WWrVkwFPoNJah082LrUiLDsxvUk0HM43OgGpN7wiP6tq9maF7Wd0Aem/rz/uhAldiS9I9aaYfzDAgBINpKICsvNIk1uQzDumwgMCbYl+sIZ0To4w5k/mV4xHVTv/LYyOkwyhcwjhW7Tn/4w9JFs8KQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEszC+d7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B265C433F1;
	Wed, 24 Jan 2024 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106592;
	bh=OYia0AtsnKf67CdsbSIm04KyjzCViV9xEqkqRkan7fg=;
	h=From:To:Cc:Subject:Date:From;
	b=KEszC+d7wJwEZ429lAyXqII8qCj3CaebuBUJjlJ40/Ez3XYIivWx1u6ewhTVWI2OI
	 wuErfHUXvxuk6LbwjnsyToAo1AQ6eDgyTRB7tsUaQw6baP+UywYeruWRwHXOsAJ1ah
	 NV9/5KH0Mbwp3ImCcVP8MI+l+8WVDyi3dRNeQ3szrE2CNSfVQeZd7KEp/WKtpXEY1b
	 i9PSN3CTtotQK5EZwwnC/zizC8FB6kyfY0KHvW86bM5JQyFQWiXb9FKt2Zyt/OdxFs
	 a88WH3j6F1NI75a6GRuh9tTfXi/QG5vTP2x9v13hyu3M0npYK11vlD8/iM/PndqRsa
	 ludhp8jpZN/HA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pavel@ucw.cz,
	linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/9] leds: trigger: panic: Don't register panic notifier if creating the trigger failed
Date: Wed, 24 Jan 2024 09:29:31 -0500
Message-ID: <20240124142949.1283818-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit afacb21834bb02785ddb0c3ec197208803b74faa ]

It doesn't make sense to register the panic notifier if creating the
panic trigger failed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/8a61e229-5388-46c7-919a-4d18cc7362b2@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/trigger/ledtrig-panic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-panic.c b/drivers/leds/trigger/ledtrig-panic.c
index 64abf2e91608..5a6b21bfeb9a 100644
--- a/drivers/leds/trigger/ledtrig-panic.c
+++ b/drivers/leds/trigger/ledtrig-panic.c
@@ -64,10 +64,13 @@ static long led_panic_blink(int state)
 
 static int __init ledtrig_panic_init(void)
 {
+	led_trigger_register_simple("panic", &trigger);
+	if (!trigger)
+		return -ENOMEM;
+
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &led_trigger_panic_nb);
 
-	led_trigger_register_simple("panic", &trigger);
 	panic_blink = led_panic_blink;
 	return 0;
 }
-- 
2.43.0


