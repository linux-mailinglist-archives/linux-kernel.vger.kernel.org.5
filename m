Return-Path: <linux-kernel+bounces-115539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDEB889C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB91E2E2809
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515F247F6D;
	Mon, 25 Mar 2024 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUZj2rO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301B12C558;
	Sun, 24 Mar 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321031; cv=none; b=DoJthqO6BfODpPV8SIjCA11cTAQyEzNUVPXHind1kwIUpEfoyFxbJjr2Ej67NLYuqDwi6L2Ze8d6oHu7cQIbMoezeMmj7DRWA4K+4Ibz81iHib8fAlKLoan4P6toZahdhiTp0HPrQYLPyvbVo6K1GLYYbE5gy8viQedd9a++tXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321031; c=relaxed/simple;
	bh=Vygp2TWkGLy0BzP36pH0XzONz44hyfZcDWMybmTjJT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT7dGuWbFGYviPoc1dqE51CMruxGieiREmqecCWJiBLFM4pbUneq+fea6qzpVkXBPIS5AZtUpehlZRHSpKrmaNxOt72kG3mjm2yea96yVbFnW5GOU4nrfPysOnyM7YW0UWdX64RID5Y+wpriYaCPVjBffkA0VkSq9iYwDd7sQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUZj2rO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE075C433F1;
	Sun, 24 Mar 2024 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321031;
	bh=Vygp2TWkGLy0BzP36pH0XzONz44hyfZcDWMybmTjJT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUZj2rO8NtF3gAJtwHpzLhcXZrZTxBIXghuu/whXsrY1CE49tSdRswK4dBDX12ltc
	 HRHn6Q8IwiT4PwlozBGhDATuCkv6GJGs3DJvTr3RVtxpxt1nCm3x9PnKAgEwf7rypg
	 5TZogDVss5g4PL7+9kG7564s2CbgMtmhxKFQAXJuKlu29mhim/Z1221+8syM+4zGal
	 hqjJyXsswHq8ZRCG4mOAk8/Yx/uP7mQW5MY4p3dxkqQ6oGmqn97EOslVs+1nUZxzrT
	 I03Ix1IHPdm32lijiFXD0CVJCJuYslyf3zGkoS4BPsxCKuDKv7sIlwt8WIx8EuF7m3
	 AhMuOiSVqSegw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Wolsieffer <ben.wolsieffer@hefring.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 594/713] watchdog: stm32_iwdg: initialize default timeout
Date: Sun, 24 Mar 2024 18:45:20 -0400
Message-ID: <20240324224720.1345309-595-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


