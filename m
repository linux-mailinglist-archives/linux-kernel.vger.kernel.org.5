Return-Path: <linux-kernel+bounces-116293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0830889E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458962A47FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BC45038;
	Mon, 25 Mar 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaDf541h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56549182750;
	Sun, 24 Mar 2024 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324163; cv=none; b=cJEkOsM4pu29aibaFmg+Hl1WfY4uGqH3ob9I1JzvXK6nUEEy9xm9IGXkaSIX7Zic/iMXe3frWW0SFJdYhHNGG8VkqADQArIoQ07ZXv+4CowRjI/89KDv6zpZW19UNrxSThwMSjfZFufc7HjiM2nnsL+pldHi2wFIbNU3PsTRftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324163; c=relaxed/simple;
	bh=1HX/XtXY9tKoIkbNvy21lYq1+GU7W/u60Q5A+0A38Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVMMqtvojMb6nxMLNRiyff4uDmbR3wIWdnbqwlt4Oe3zGji1oWonYnwjUDc13bfra7QdexRy9R+v24PcfawUdSDcPwbHeSywBvK5VWDOMPutBjMbjgTbyIZk00fD/QjjMGYEuESzQX9XqFq1rIq1493fRbK8VBLsAhSR0zjyV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaDf541h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C40EC43390;
	Sun, 24 Mar 2024 23:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324162;
	bh=1HX/XtXY9tKoIkbNvy21lYq1+GU7W/u60Q5A+0A38Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaDf541hM585AMZqUhk3k74m59Sm80Lvq28mIeSyShB3sy+3K9hiEMzp5sWwQDElY
	 /kJ1kSOVT2O0OWjSIY0pNj0QRRhej3RX+YtwCqHvIVTrM89tivW9kLuGelh0gTlH4B
	 L73PjtdShQNznCCscZL971aslh7z+OLBTB/gcE+TPJztSEphPU/fYNVuKhKqkthKOC
	 n4D4U6rZ7YHXDxN66kwuEJpX48sFIZsvoPleDpqhkTmjd7Rs4ElW4/KY9WeZFpm0EX
	 1J8HdsHNOopPhQD4HVuHR3dmX+inmZcUrPa0av/hqAKyR9ZUdAeJcVZkOjDsLOb4ZD
	 Ihx4C79HV55mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Wolsieffer <ben.wolsieffer@hefring.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 157/183] watchdog: stm32_iwdg: initialize default timeout
Date: Sun, 24 Mar 2024 19:46:10 -0400
Message-ID: <20240324234638.1355609-158-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 25188d6bbe152..16dd1aab7c676 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -21,6 +21,8 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
+#define DEFAULT_TIMEOUT 10
+
 /* IWDG registers */
 #define IWDG_KR		0x00 /* Key register */
 #define IWDG_PR		0x04 /* Prescaler Register */
@@ -254,6 +256,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	wdd->parent = dev;
 	wdd->info = &stm32_iwdg_info;
 	wdd->ops = &stm32_iwdg_ops;
+	wdd->timeout = DEFAULT_TIMEOUT;
 	wdd->min_timeout = DIV_ROUND_UP((RLR_MIN + 1) * PR_MIN, wdt->rate);
 	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
 				    1000) / wdt->rate;
-- 
2.43.0


