Return-Path: <linux-kernel+bounces-114632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F402888B65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4098D1C29349
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28856189A20;
	Sun, 24 Mar 2024 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5DMAJFH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B215E7F5;
	Sun, 24 Mar 2024 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322293; cv=none; b=CZUG019Fuw+00XfmOMVtg+bHbFQqQxfQUBSc8QYCjKBPLP/ZBaYBMsjRg8ZKZF0j4Y9Lo6DRivOCmdOe2bP8KrH4qz3uXpusk9ljpJp/46jJ1gFdwiNFNNH/yS0CGew8ryeptSZaxFES4JOBydPdwt4CmW/3NLny1xZ3HfnPqBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322293; c=relaxed/simple;
	bh=/kzETMdMLNiuT/POZ0C+E50b1oXVWke7qL3EAlAkLXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2D46QNomkBRD/VCS1MxwfctFtPBj0xzg7WSHzT4iERzckgZd3LsM7xbjxjZKXtOG3U6lvvpKgrk2R6Q0tehHzcByfWAOaTEaR5pezklmMRA+CvDIYORvhuVSh7FDtU843vy1wmZSxeafm81TA1zjLkM58u3L607FLJgVauo7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5DMAJFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76149C433A6;
	Sun, 24 Mar 2024 23:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322292;
	bh=/kzETMdMLNiuT/POZ0C+E50b1oXVWke7qL3EAlAkLXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5DMAJFHkOGfpZeQNhs2eQYR7+iqWh0Cvx1XKTWeGYj8sUXEcc1gFbicCdHrzHvyL
	 vEIutv+hzkBIQMFAyyjnycMipMN7WIz4ATJu8Bp+gZl9pwHae+8Yf2U3isRRcEdD0n
	 CIdL/zXFrJpTvnG+zsYq9zaDg8t1ItA/27n7r6fDMjqN/XtRIyzCQUDR0pKagZWjmJ
	 SaXE6vybPxn6mnjVmv1zeTHMXfqLk+qFbf7yIbFgQefMTEsYMozonSxc7SQeyDTbSW
	 xgxfMEX7i4FBzRF0bZxs/n9TlKjZwuEqA1Yn2/DUPjifVjaGnOrUWK9Drc/aCa/LvA
	 xX1UnAuUOgcow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Wolsieffer <ben.wolsieffer@hefring.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 375/451] watchdog: stm32_iwdg: initialize default timeout
Date: Sun, 24 Mar 2024 19:10:51 -0400
Message-ID: <20240324231207.1351418-376-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 570a71509d2a9..78d51deab87aa 100644
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
@@ -249,6 +251,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	wdd->parent = dev;
 	wdd->info = &stm32_iwdg_info;
 	wdd->ops = &stm32_iwdg_ops;
+	wdd->timeout = DEFAULT_TIMEOUT;
 	wdd->min_timeout = DIV_ROUND_UP((RLR_MIN + 1) * PR_MIN, wdt->rate);
 	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
 				    1000) / wdt->rate;
-- 
2.43.0


