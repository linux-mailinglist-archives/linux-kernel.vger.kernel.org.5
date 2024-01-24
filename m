Return-Path: <linux-kernel+bounces-37175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F8783ACC6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7718BB3249A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DBF134748;
	Wed, 24 Jan 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck2kUK87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EA13473C;
	Wed, 24 Jan 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106687; cv=none; b=U5KsgdyfNlgH5Jb4pJQlJB44jsLMny7DiIMs9tzC8HPHHoGcVgZx0fclmxeMWBurTLijL9HJ2oQdNE0xWp5VZFxG9/xiPF5IooA1VHSoZFsoBLFAs2YFBMml88phExwsPneIZr09eGTLCm6GXAXRNC2CxNuqhDAOOZdlDvFqY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106687; c=relaxed/simple;
	bh=ZrFrs9JqbS6nzoUzpLQx7hDiMMgs6qIH7LIqo6FQCn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpkdlNEQ0ehrwl1G/HBcLmlbN0jZoB76uBJCiFbmXLidKDuF13ZUxd+RnkRiNlE6FzcZKGxWgoZAM0RlCYtcED06YSxl9+P9IfOoNxX0qASzB8jFFNTnX9Zqb3JAL28GTDudReB56V7qrgWTnxFg0OVy1J1evEa3prcDwbZaKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck2kUK87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B0DC433C7;
	Wed, 24 Jan 2024 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106687;
	bh=ZrFrs9JqbS6nzoUzpLQx7hDiMMgs6qIH7LIqo6FQCn0=;
	h=From:To:Cc:Subject:Date:From;
	b=ck2kUK879/vhdjvzr+bVmDVb14YcQw61k4K4KeBM0yOx68UPcEAwXDR3Q0nA4NWmJ
	 Jrd0DcKQv+UiYSUNfvdUsjcbh1loJf3MUTgmoqr0WXdoWgNtZyFYSoeZ4cRuE+21Dj
	 p6Tw2Ncq9t5A/1+fL74yNVvz3ckEbajqsyu3Xz+kgTqsML4gaUTXsNlANZuawtDmx8
	 pIlCdqFg/qyDUaCmWl2d3QHYX8/+PGZwRTNT0nXHoBLf5hWHkeO4L+4EPjVY9IdM2T
	 KDa+wz3+6kgeTOgKPM1eCv+KnmrWTQY/QmYzPpYKuwozSkaWdn/OK0PJ5azaHNkMEx
	 IR3Gxqt0jo4ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pavel@ucw.cz,
	linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/6] leds: trigger: panic: Don't register panic notifier if creating the trigger failed
Date: Wed, 24 Jan 2024 09:31:10 -0500
Message-ID: <20240124143124.1284462-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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


