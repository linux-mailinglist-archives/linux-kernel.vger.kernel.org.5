Return-Path: <linux-kernel+bounces-29863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830883149D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77D0B25AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98F29CE9;
	Thu, 18 Jan 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QID7zQlN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9A13FE0;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566179; cv=none; b=bzlD2yqLSfCuEEuFp2va8wcF+pywT30aImix8WpCQh589z4QdM8Uw1f1lvNnQnI73p6ou/uXUCY+5Y7zcfp9BDAdxONG0srS0cZAO/3ZQw79y1vlv92sYgz2vJ5ZsCqWagOAKFavVWyB2pdLNrGP2NihmVVz+pvFFCuTZ6RrCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566179; c=relaxed/simple;
	bh=LRvc91m097Qskz9yB8bGNzi/V/i9xkRrGP0qF9TsLpg=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=ix/rl4Jhe/OGGebgDEO8lP+xzbzzDW40F4U2dbEwlz6RFoixle58mShaNYu0wMruYU6wJv0gRafbyau8HKY5n9ShMLFxp+NEcNOnodrxXXsPm0GNUlapoW9C/r8veBbuK8DtvPjx4VfxBpvxigJWZJTnsFxogzxW8q6hbGehIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QID7zQlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59427C32786;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566179;
	bh=LRvc91m097Qskz9yB8bGNzi/V/i9xkRrGP0qF9TsLpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QID7zQlNsAcSx6M52VwTi0R83Szg764KVPk2BqNoNc68dmn1nnzQd5oSlkQ+e92t8
	 lsyPU91jJcxo1w0J26JAV0uayfHl0Y/XmlU76rjLONzVc4lD2mgFxB1SKP1HYFSgpH
	 mfFO8p9lhPmUYdgFTh+Pfbfi2bcZM5AUxmbZe4vbzaur7dGsLapiQklpktjWq2tBdZ
	 r87tvGj8dVoBQzNzI3mFFNoT+wK/jCbFqZsbzw1n98XiSe9tZ5NejEb4KwiCBc0Kke
	 zVH1g8DI1DpSoTyQikoeiR5uD6CclUcxcts//YwMIGUObuyNQz5bv4fcm207KADrX3
	 xWBNB8OZ+JoLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A420C47DB3;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:20:57 +0300
Subject: [PATCH v7 14/39] pwm: ep93xx: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240118-ep93xx-v7-14-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=1116;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=47BXUS7nKAN+L1sWT+XWD4yJWjkfGZ50keulY4vZgFE=; =?utf-8?q?b=3DLgOJGJXNgz2E?=
 =?utf-8?q?fcjkp5S4Al5fvAI75BB64JbwutATTTKbE/nMlIp5TZEYqcrDvllPRhOplAj0hmH5?=
 X8N2R080DJa9hmWCGlkHUam9I7VkVy1uMtx279ASFX48vy8gfwyo
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


