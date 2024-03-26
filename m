Return-Path: <linux-kernel+bounces-118661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9388BDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B331C39C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDF612BEB5;
	Tue, 26 Mar 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUoZf/qr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033746FE10;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=VBeLlWdZsPkWtP/hYW6SNEu7lNYou9G15pMD+FQnBHq2zL0AY1403jtCrRTmiplQHIozl3otsvr4PkZRABnZT0thEaZS0m7gwRLPQv/eZ922dWFk78HX0wrlh+Yq1RXZvtOpRzS42c2BM/5X337tvZL0lGsCHwT+aq3jeG8Wg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=axzOW/bLfk48A9ZCiMw4d+If5yhSQO0oy0KThVKKlAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otxs/jybF7Za6fdNk5o6V3eN9pWPUQrN74BMz0qa6FcJ2oTj1ikMmiaAoTqnSwNa1sVT2JNnu8jhFFJ8skRWJIVxUpDP+VEvryzAUgrdFSEG251CKvPwaRwGDeAhqy0aUqBtyIJqbXBG8MA5fDTAjUa5L9Y5ePR3Wz0VC4Tc0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUoZf/qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48904C41631;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=axzOW/bLfk48A9ZCiMw4d+If5yhSQO0oy0KThVKKlAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MUoZf/qr+jc7eamIHqe7kJLS3+dJVX0yVsTvnz/5fgrvoT2AMwA5Gqo3k2InR6wH6
	 hhwtAzzdX8rjafgiEFDaPCLoKSMzGnzQdHtenengp+v1HqtyRmUz9+Cnk6MjnGCVhq
	 7k+yRO/B2ZEUN+Iy7VqwNsmI3Lszng03becekAxnFeDSlztyhFvwAsvDCOGIr3A7dt
	 DMF4oQ4da6bX642vUjWmGehX6IgnTJt0bwPb6XXUCOIwgd6kRItfULdnsfE6EITcxD
	 7rPVI2BLiJ57S4sWfO3iR2rdft+LfHRjaTtCBI0HbLHSDm26dA5rSGbrr83Xe6ZPOA
	 0lzZQei2nDXPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE8CD1283;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:51 +0300
Subject: [PATCH v9 24/38] wdt: ts72xx: add DT support for ts72xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-24-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=1140;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=1rWEe31MzZtFeQGF9K/nSefILZAuLYwUQNOfnETpfJQ=;
 b=oOMjVqh/NS4VkbHF7TTCTYPOJcHgxzligt8EPVtOwGz/oY8zeE3CgIxbO/wrBGmUI40A927Uu1HM
 zbO4pAKtBfDt9MmxtFnrbP/ft8xB0d+9RB6OSyw9dwofVr8rpr1N
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/watchdog/ts72xx_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 3d57670befe1..ac709dc31a65 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
 #include <linux/io.h>
@@ -160,10 +161,17 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ts72xx_wdt_of_ids[] = {
+	{ .compatible = "technologic,ts7200-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ts72xx_wdt_of_ids);
+
 static struct platform_driver ts72xx_wdt_driver = {
 	.probe		= ts72xx_wdt_probe,
 	.driver		= {
 		.name	= "ts72xx-wdt",
+		.of_match_table = ts72xx_wdt_of_ids,
 	},
 };
 

-- 
2.41.0



