Return-Path: <linux-kernel+bounces-80647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47E866AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF221F21126
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423B638DE9;
	Mon, 26 Feb 2024 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbehGKZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250F1C695;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932682; cv=none; b=CJhvFQisDrMA5yovAhNtBjlFAmIyBNun++giCMZDsNssdtxWiLQUdlCORrpMJb39MxGw45DyUmlXCnILRou4oG8OK5VI7NkKoScjXSv+bQ2LqICPv0hvzq11y3q0jWB0wJjJvQlsSpvg9xs5HuNQsx+D84OHXRtPYKrb1O+sVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932682; c=relaxed/simple;
	bh=LRvc91m097Qskz9yB8bGNzi/V/i9xkRrGP0qF9TsLpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRHIx4QkMoHeYIMHzQsvqv0BDaDHzMkA3Y8lzYLryq4gXSeRoj/o7T18hYtCeW0OJo9CeaYuasFpsQAFa5LX143BfzlGXZEOZ7cYwwCT/zrqjoY5QFNWOwpZyswodTBmVUuEGbNyeW9cYJBRwU5DBh44YjHwTrgiMAtyk6ERIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbehGKZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 845ACC3278B;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932682;
	bh=LRvc91m097Qskz9yB8bGNzi/V/i9xkRrGP0qF9TsLpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qbehGKZkcdYZlIig3myIMEs64/+8egbWixOcf1ULzNqOIeMYZLPusAGMSXGf1flCD
	 Ahj88XSd2ot+eoBni1qcHS1JATY5v7nIu15YgOi+jLDBkrpMXWmM0KOJjDI1fh51fU
	 igiCFWpYJcSJg5GeqE/Biq0U2ijC2QncJHrsaa0vGTyVrk542Ro0ihTejek+qA2ZAs
	 Iobm2kZZZhA/GK4PFMi9dXWrWx3WEXVpw6wy5BQIV1FaC/gtdbBVQHGnrew/gk3vKZ
	 rk3uUjGWZFN3HGQ91SzOpBxHQZYm3bZQ9ToahnB3l+ToPhwl5jHyOfpk7by8GcNFlg
	 R+RBmeGb1SZCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727EBC5478C;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:09 +0300
Subject: [PATCH v8 13/38] pwm: ep93xx: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-ep93xx-v8-13-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=1116;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=47BXUS7nKAN+L1sWT+XWD4yJWjkfGZ50keulY4vZgFE=; =?utf-8?q?b=3DwUT+RkbSqb4X?=
 =?utf-8?q?6fwujPOXgjloPkP7V030EQ6Jd2ghE0TgciBhw+l4boUmQR3Ln1sNJy0n8CLxkWkB?=
 fuLSn+OEADfFuSTFFZ+Ky1GnSI8AXLkGmEBRIFhvW3hDDSd4raXb
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/pwm/pwm-ep93xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 51e072572a87..7cf05d0b78fb 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
@@ -189,9 +190,16 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_pwm_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-pwm" },
+	{ /* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_pwm_of_ids);
+
 static struct platform_driver ep93xx_pwm_driver = {
 	.driver = {
 		.name = "ep93xx-pwm",
+		.of_match_table = ep93xx_pwm_of_ids,
 	},
 	.probe = ep93xx_pwm_probe,
 };

-- 
2.41.0


