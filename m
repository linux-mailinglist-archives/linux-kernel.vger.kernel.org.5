Return-Path: <linux-kernel+bounces-37181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F9F83AC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AA61F21A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033CF82D76;
	Wed, 24 Jan 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUKcFhYi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D97A728;
	Wed, 24 Jan 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106713; cv=none; b=QgfxEWarPnEppU/173I8dJyzV1nfF/RHW40QUInBqb2wWTiapFI9IjFLw4ZBF48jdV3tRrFb0BoM21y6DNp2LW5+o/j2olhEhUx1DWxfTurZVjRHYL5XZZlAXfhLPvZ+w9Ikkq6RSAdqN4iZH7d32odORAyS99fZ6z6yxOVvUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106713; c=relaxed/simple;
	bh=AINMiAkHA2Ql7rL36V22ul/Y3by28TWkVQGvsoWyHJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7o4+VxGhlEQTGxU59HjOA86XjVysK10R/zVifetvv5V7QCTfptNKEDh4BJbP1m/QPnYxK2/yp8+upftCVqDv9ww+QGdqyfofgOGRVdHXERycA1pmaMiTlwU+DMM7Y8gJEgrGzJh8MmN4p35ePtUfnJeYAb6Y4hYoGQVIYcvpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUKcFhYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C82C43394;
	Wed, 24 Jan 2024 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106712;
	bh=AINMiAkHA2Ql7rL36V22ul/Y3by28TWkVQGvsoWyHJI=;
	h=From:To:Cc:Subject:Date:From;
	b=CUKcFhYio1LpaOdKAyD+dP/fEylRNapYK/p2+lB22p4Ms95yYFeIrWGNJ1fpc7w2c
	 jmo2oTc+ZT4fvZq8z/7VgyBPk2k/2B2PYKE48+xIvRIhGiAfd1QKPvngPwvOD6wSsX
	 xGPeAuz0rztLgyMfEzyfAkwHe0Y0SHHR0MLBvrtnUnHQg3gCWLHXq/SktmvG1fZgUl
	 qsOn/wABaIzomIrrO0N5NVqg1k7vrVjI2I2i0l5A1U8sI5KNVHKAIRerjpfxDnecSX
	 aBhN2OKzanqQHA0Ym7nWzkeLJGkh1WZQuKiWAw+Tlcw1KfZAu6QGiME1xAfc50KbRx
	 gD3brqrxLTUYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pavel@ucw.cz,
	linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/5] leds: trigger: panic: Don't register panic notifier if creating the trigger failed
Date: Wed, 24 Jan 2024 09:31:36 -0500
Message-ID: <20240124143149.1284622-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index d735526b9db4..2fc04418a87e 100644
--- a/drivers/leds/trigger/ledtrig-panic.c
+++ b/drivers/leds/trigger/ledtrig-panic.c
@@ -67,10 +67,13 @@ static long led_panic_blink(int state)
 
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


