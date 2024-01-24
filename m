Return-Path: <linux-kernel+bounces-37131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46B83ABE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC241F27CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE2186ADA;
	Wed, 24 Jan 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q56lv06z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20937CF3B;
	Wed, 24 Jan 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106554; cv=none; b=jGRMN6V1+bwtI4kdYUM6iIn/vOwIaRtJkcYZc5WqmCComEgQjR/NejaapbI9YM8Cuxg6qJBV+mmQW6pE7hlJy40wUaxzjmcdqTHCqtOurwcFzl7wapVd8f+6JVOJXsHNzy/AtdUwWuYuP9iYdC03PlLalYOheKwQC4B5T0Zq8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106554; c=relaxed/simple;
	bh=OYia0AtsnKf67CdsbSIm04KyjzCViV9xEqkqRkan7fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOXgkzroeEcvBV7zxxAle1VHdrKc5xZLaxJu0lwzsRNPjQoYHjvbtempXTkMgyV/BrJ6oYoBtbRqnRKlIaDvrZWJNPA86oGzKQ2FHJTv6HqKTmbXdE0PemKj7PFCBFZDpGqQnqoKmXrRR82xFQb43AInttmVoXeIdZVNYKYJkik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q56lv06z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6990C433A6;
	Wed, 24 Jan 2024 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106553;
	bh=OYia0AtsnKf67CdsbSIm04KyjzCViV9xEqkqRkan7fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q56lv06zo3hwYjN/4W7w3Yy0O2B6yRhbMogdy/I/SbXIzv4OiVEWUlIQczhu89UBq
	 oD/4BAB7sGKZixSj5TYiJqRTrWeKolaQVZbNfoeVYL5A7NvRUBaOGGhJE0aaP7fOke
	 UjjTGQoymFXfnfIsxLOGhfz1Kr/jC4NYR4kGn9cOxpyC0U1tH3uVYn8ShIXA57X7cM
	 8t9I4mUqmZufN9gXzw1Bi/X+B53AF/xG9ifs5B0wC2mrAno9rWfWJsPZgAMQ6jVkm4
	 88oYuSJD7t1xw+p8Q/7XKFwgA+FyIYVtc3YUHIuyFM+kLl3ZacDl+7DOhIYUnprX7F
	 V5+Ln5PSPEQgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pavel@ucw.cz,
	linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/11] leds: trigger: panic: Don't register panic notifier if creating the trigger failed
Date: Wed, 24 Jan 2024 09:28:45 -0500
Message-ID: <20240124142907.1283546-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142907.1283546-1-sashal@kernel.org>
References: <20240124142907.1283546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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


