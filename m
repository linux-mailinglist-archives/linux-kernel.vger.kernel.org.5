Return-Path: <linux-kernel+bounces-114400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A233D888A41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8E728B33B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094021A826;
	Sun, 24 Mar 2024 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meo0qILL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB12197BB;
	Sun, 24 Mar 2024 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321808; cv=none; b=BW1L0zWFuOshj8SMYsesOJzd0KIusvtQnkIXciHCAHF6uPXXNUvSoqx7rprPkqdT78F+5mvyhDEgqNDIvp/bq834ONX+xAZ0f/RAwzbyqfvfNkPUgRREBkgrA+0Wvq37xny/L+XnjvSeybaF458XLrN3eYcqHBbXHeMFpj2IA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321808; c=relaxed/simple;
	bh=Vygp2TWkGLy0BzP36pH0XzONz44hyfZcDWMybmTjJT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1WyKK9lA6zlf4xK76tMnRMEE19bzYoIjSwBerlMuJ4iEyUpc/n+na1/rIzMe+SDsWzji0xYnbZ1sUQnR/eZ0tg0xKAu0PlB90+FVLbN0zEYpDzDRbnQ5nG0WvUzuqzRZ5S0XEGv4zomSWJoCF1PDrFuhxluUYM13rFXZeZqq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meo0qILL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A004BC43394;
	Sun, 24 Mar 2024 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321808;
	bh=Vygp2TWkGLy0BzP36pH0XzONz44hyfZcDWMybmTjJT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meo0qILLCSrGesvDx6PxrmXKrpKEJPUHViklGfO9GdMWn7YctXh9Ojl66pUkCf8kZ
	 /kmFI6y8UcDC2/EL9GCJ9MuuoninX+NjinMM5uH6/1RgY9dfpMuU6tVzb0cukgVOZb
	 eWyBCzy3F2oKsgOIB4GJSX/1WSAyVt9rMoiQAhAmt4m9lpd6lkb1GzUwiqILyWO/ab
	 OucPgeeCv/ke4f1Rx15C0HMiwAPF+yE0220VuxICAbAqOQKZmUwfooJZsbyFDeAFVT
	 1umhusJ55u/Nr3eF1KbLiYIzqD38vcGSwjlmYACcsnGSH0MnuvXEy7e/zGC7c31Egf
	 kcyAEpNN8um+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Wolsieffer <ben.wolsieffer@hefring.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 536/638] watchdog: stm32_iwdg: initialize default timeout
Date: Sun, 24 Mar 2024 18:59:33 -0400
Message-ID: <20240324230116.1348576-537-sashal@kernel.org>
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

From: Ben Wolsieffer <ben.wolsieffer@hefring.com>

[ Upstream commit dbd7c0088b7f44aa0b9276ed3449df075a7b5b54 ]

The driver never sets a default timeout value, therefore it is
initialized to zero. When CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is
enabled, the watchdog is started during probe. The kernel is supposed to
automatically ping the watchdog from this point until userspace takes
over, but this does not happen if the configured timeout is zero. A zero
timeout causes watchdog_need_worker() to return false, so the heartbeat
worker does not run and the system therefore resets soon after the
driver is probed.

This patch fixes this by setting an arbitrary non-zero default timeout.
The default could be read from the hardware instead, but I didn't see
any reason to add this complexity.

This has been tested on an STM32F746.

Fixes: 85fdc63fe256 ("drivers: watchdog: stm32_iwdg: set WDOG_HW_RUNNING at probe")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240228182723.12855-1-ben.wolsieffer@hefring.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/stm32_iwdg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index d9fd50df9802c..5404e03876202 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -20,6 +20,8 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
+#define DEFAULT_TIMEOUT 10
+
 /* IWDG registers */
 #define IWDG_KR		0x00 /* Key register */
 #define IWDG_PR		0x04 /* Prescaler Register */
@@ -248,6 +250,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	wdd->parent = dev;
 	wdd->info = &stm32_iwdg_info;
 	wdd->ops = &stm32_iwdg_ops;
+	wdd->timeout = DEFAULT_TIMEOUT;
 	wdd->min_timeout = DIV_ROUND_UP((RLR_MIN + 1) * PR_MIN, wdt->rate);
 	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
 				    1000) / wdt->rate;
-- 
2.43.0


