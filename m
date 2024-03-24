Return-Path: <linux-kernel+bounces-116207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1158896AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E8DB21B79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B33BCECD;
	Mon, 25 Mar 2024 03:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAb0BSop"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE132853C4;
	Sun, 24 Mar 2024 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323822; cv=none; b=jctRRdfpI6WXnrvOENVIfj2ydE1/+c1ZjcydrN93R2Bn5UKGNh+d8ru+26fheQfUdxFoCnMpbGBFIlyX95Lrrfr1s+6L2P6Vv17pNiCW6yv7pLegloCLvUrwdQJ0qdRAgUiHzJElmBbQNsGw9iX9NnbDfL5oYMeufGmcrmESbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323822; c=relaxed/simple;
	bh=1HX/XtXY9tKoIkbNvy21lYq1+GU7W/u60Q5A+0A38Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZpsqlX24YL/1MaKpFxhPvSsm2DBOAmzFeWzqe/853/BcySUv9tvzG6uvHuoX63N6raFnZxowKYVSP3IY2CHvaMR/hdaH9zt0vyXqWc172DgW2CpH4u+hvt3QCAXS4BkaAFEDHbEYg1dS0I5UvmZoJC0fU3y9UB3SMIYWKSXtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAb0BSop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35CFC433C7;
	Sun, 24 Mar 2024 23:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323822;
	bh=1HX/XtXY9tKoIkbNvy21lYq1+GU7W/u60Q5A+0A38Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uAb0BSopGYh8f+pI3MyPiuEndSKCtiluacQKI5FA28HDthvTCjlthv3nOQr0OeeDo
	 0J5ZSrH6lKELxMQM7dETjv3NgYhT7d0dd+b9zylNIqFsbffkDdV87nYxXtItDqZmoe
	 FDr+y0G890M/PlDg4R/S9KvBfhnNkdPUs6BN0Fg+x8rZD3lLD8OqIEEkxu9x8AGcxR
	 5eJEauHUCX9dhSwH1YSlxriQ0oJWTRuelCNFd2e3PASUGWCTTFQtUgAtKF8MZ21jCo
	 lugU8peUCnnONbrULMtj3NW/0iyPuCrfxwAY/egSnvUFqirG65IAcj15YDO6d+ijed
	 vcLVPtmMVGejg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Wolsieffer <ben.wolsieffer@hefring.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 201/238] watchdog: stm32_iwdg: initialize default timeout
Date: Sun, 24 Mar 2024 19:39:49 -0400
Message-ID: <20240324234027.1354210-202-sashal@kernel.org>
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


