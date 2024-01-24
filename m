Return-Path: <linux-kernel+bounces-37164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264DF83AC37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1201F21E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE3B7F7E3;
	Wed, 24 Jan 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoPFdpS1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEE7E783;
	Wed, 24 Jan 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106660; cv=none; b=N4yoid32C4lVKzIwQT2m4iSUBIQMyZdOM4NOVqTQw6jP/w2tXDj48WQ9XjxY1O/X2evb9cu6jlSCh79FI/pjEfd8lXt11/wV7tNQeeX+Rxp4pDyQotfxzvOMmDSU11GtP8EP+A3kzrlqv0wkBqpRCiej7ToH9nsgkE7CWGaeYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106660; c=relaxed/simple;
	bh=ZrFrs9JqbS6nzoUzpLQx7hDiMMgs6qIH7LIqo6FQCn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrK+hWwOa/7d4cMpQyrlI8xzre28y34bbguHmNs0U9zB2IDc7kISY5tq7+Ggz/VmikZ6zU+sMEQQRUBDrG1Waiso9yaNPUH15FmSig6gboH/wWVAGaqdy4QiPjLh8TT3ZnoPsrFvGk7K0NLGp6m0OGLfyc1TO4FJ8bk+p7wpJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoPFdpS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8AAC433C7;
	Wed, 24 Jan 2024 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106660;
	bh=ZrFrs9JqbS6nzoUzpLQx7hDiMMgs6qIH7LIqo6FQCn0=;
	h=From:To:Cc:Subject:Date:From;
	b=HoPFdpS1GCCKNJ3JS+On08Qvak02SE6Unk/0jpreuI7+GQeCTGxHIaQ0zvc5v9ga4
	 K9Fc1cl7iKOnUBgDWZycKieNGY+zkkRJWuBn4Jth0xS2+7GoraGSsgPm29MIhqt/EN
	 d7tfhfqFJRzxZjYcF6svVKg0xNTdz4iRFpG91WSYZ2oP6gDgPYf4rOrXkc6eSApnfW
	 EgIMLFxfvvPwBkAAkJ7+d+scqyjDpViqufZSZy+uL8Tat+SOlep7/sWw5qH9HZMUdV
	 z06Ok1eZxEDw5zceBkx91nj4urKBULHCRw+LuRUdSZj2EJS+1Qc1eWA1KLgQVaqP7/
	 VSNsTUht4w5gA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pavel@ucw.cz,
	linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/7] leds: trigger: panic: Don't register panic notifier if creating the trigger failed
Date: Wed, 24 Jan 2024 09:30:42 -0500
Message-ID: <20240124143057.1284274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 5751cd032f9d..4bf232465dfd 100644
--- a/drivers/leds/trigger/ledtrig-panic.c
+++ b/drivers/leds/trigger/ledtrig-panic.c
@@ -63,10 +63,13 @@ static long led_panic_blink(int state)
 
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


