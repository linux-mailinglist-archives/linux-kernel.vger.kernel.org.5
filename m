Return-Path: <linux-kernel+bounces-37155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5699983AC21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4ED287A72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D17CF09;
	Wed, 24 Jan 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7YwJDnr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B312DD94;
	Wed, 24 Jan 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106628; cv=none; b=unyq9j/d5PrcBhcsqDLuhWIavm+CvpPlDWiMJ4mzNSWCXDAvQZC3M1dWmBL3rXLMv7NTEQPOmUs+tq1Sxpxprc3NPz0eyU16xHJMhxnQB3dbi9au3sHDUUT0CFtqlYX3THWAuRGEoFKqGEoYgsT332XrsBei22nQK1LNYwFGOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106628; c=relaxed/simple;
	bh=OYia0AtsnKf67CdsbSIm04KyjzCViV9xEqkqRkan7fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeTXm8CvgnERA6Up30xGhVgPLThROsOZ/MiJx28VD6T1Rxn0IFPuEDRRSKxEBCH72kTs8ggOGgJBKVo9zcZvuf/B9oZwS2fYlWtNXFQqyKA19ig/DXvZMsYUECGqJ+TklSxyQX1ys+jIrg0orZ1pWNiEbWS+6KurSXyxqWKhsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7YwJDnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3375C433F1;
	Wed, 24 Jan 2024 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106627;
	bh=OYia0AtsnKf67CdsbSIm04KyjzCViV9xEqkqRkan7fg=;
	h=From:To:Cc:Subject:Date:From;
	b=u7YwJDnrk34NJX/gyVDuknBVHZi0189iIVli0ZlxCgHRnhYitscIpTj7cpu4PRAAn
	 yjHGph7R0tBi+7HdOZwqI52rn8FNPXyGSzSGgyjTgWJaAiBcrcCOsxNu+F/zaCRWJU
	 dxdiDfVnBgzD43S9Ea+n8zqOTIQJX6xXbhtXCvzoWicSMKNTPAeotraC810ipr9DFF
	 OZTi7WAjCl4Mot+skPUhaKIU0lqlL4TWwtBlHuCijmR6Kj5QYhM2CEIPxkaHb+h/it
	 AJAMT5WUzyPReIDwTbALO2sNwbolkcdimGVUvGjdQCnUh5YCdCaY5FrkVgLaQNEuIj
	 793s0AfxdiMOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pavel@ucw.cz,
	linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/9] leds: trigger: panic: Don't register panic notifier if creating the trigger failed
Date: Wed, 24 Jan 2024 09:30:04 -0500
Message-ID: <20240124143024.1284046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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


