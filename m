Return-Path: <linux-kernel+bounces-37118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20883ABBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2D91C22093
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF597E575;
	Wed, 24 Jan 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc7rMO2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157267C0B8;
	Wed, 24 Jan 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106507; cv=none; b=PTjzjVuTkEfi22pVL9J9nPVxe+9Uvo5HYt2T0AZxX+RjtrhcIXM483lMeHkUXpq8TMWN+fQeZ+uay/BPbcLQ13xUAzsoOnPnNS3NgCqGB2x6cD4Jr9z94WEpCw5+Pa008nkexel8LYlbD998L7AbjZfeXyLk8465YrJ+ltl8dV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106507; c=relaxed/simple;
	bh=OYia0AtsnKf67CdsbSIm04KyjzCViV9xEqkqRkan7fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTvVp6zpJM/PTwzBkDwQDxu6lP5jKdaI0VAW3KKKirvcqHxw7LdynlFkMUhJA5PZZ4q+Oxs6nid585jv0vSie0PerJmAcuQybR5IteHkU+N9bZoGnEIUN1vx/LYj9G+Dgfrk/jMx1agf/50uXmcDcga1dXjEeLkDmJomxziOogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc7rMO2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8CDC433A6;
	Wed, 24 Jan 2024 14:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106506;
	bh=OYia0AtsnKf67CdsbSIm04KyjzCViV9xEqkqRkan7fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dc7rMO2rCI3XpSWoRKOcryjtr4m+jP1bXdASFV5pMDDw5KwiQlDWkhWc+CmtDNLMU
	 F+n4QLnkphaym3ZpBJRWBZ+iUTHTzdsxXiKpEvg7H+PNhKAxplzVm0YbEyVZBRhm6p
	 hjM+Elrkuis24X5/yps7ogg+iObzSVUiY0h1oRUWUDqbgSZTBdyyehoSK0Mmy1RSTe
	 4kEnKzY3XKllR2eDgJtI4R3IhcEeZ8StKgH8KG1F5HLq1s/QOJltc5HOQsP4P8XxPv
	 0I1x66QgJ+g9UaO2sKdaVIbKWlPD9nBH+QsoG0nFzeO3VsOVImGzWUdeco6czcJD8t
	 pf1D968GHj7wQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pavel@ucw.cz,
	linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 02/13] leds: trigger: panic: Don't register panic notifier if creating the trigger failed
Date: Wed, 24 Jan 2024 09:27:55 -0500
Message-ID: <20240124142820.1283206-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142820.1283206-1-sashal@kernel.org>
References: <20240124142820.1283206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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


