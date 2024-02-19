Return-Path: <linux-kernel+bounces-71801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC6485AAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA79B21989
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E5482DB;
	Mon, 19 Feb 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcjaxj6y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FE481A7;
	Mon, 19 Feb 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366466; cv=none; b=WGAwwxzjgHJeuDch9/c0lZdKxr+GDOW2HrUbLaqv8jA53Avnsjt/5f9xMXJoyg8JyzRAidfCbS3Hw4X5nb9CVmTjFDaxdSAf9Lm1hSCWFdLizbf2BZCP9w64TNpTYlv5nyK781q2fnYLfhuHbhBEpmnwrnd+SrUZwjohZbOh6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366466; c=relaxed/simple;
	bh=O+gac3yrsv2rOFibZ4kRZ9MSQo41/MsQ6GdSbvpMomU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2oRxUjcO3Ea6gTrDruuF5247FhZD2dfj3yC/SIhOXZzhxVuzvCmnGg788N8CNf4Z8W5gS6N6EYGec77GumBl8o4t+BnQSiRbJ8iihUjAxpJwXwL/Ld28cDP32yYGxDtClWt/qTLuK838ryCGl5YxLnH0NlKybbphCC5kdgtt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bcjaxj6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8046CC433F1;
	Mon, 19 Feb 2024 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708366465;
	bh=O+gac3yrsv2rOFibZ4kRZ9MSQo41/MsQ6GdSbvpMomU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bcjaxj6yVSWWJOJ0LtIaQaOZ7YpN8xGtKUyxWMNm4zTcPmXCo3BAGT5AvyzkTg4+D
	 HT4Yvtkk6avc8b0pxs2HJP5S2Xp4HbFMuGcue98V8wjYjAjQyv9IyljiVhwf4SAXYP
	 N/Ok02GGIil4daiaLLTKwzjNJlUTStnzbYXYNJkJ9YJopahgT0MlgUQg7YIn1yhinW
	 oarClhBrymCbf/bXpOeBXp/7JsW51cbn4EzQdh0txvXdnnexJiWrrfgqxFN7YQvTKM
	 eOgyN/dRR/3FKv1DBJfCV0KLzMZ3UGS+YmYJoO42fbKt0OTNyaWiOukC46Dq1xK95c
	 QLjY3ODEoZGIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E174C54764;
	Mon, 19 Feb 2024 18:14:25 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 02:14:25 +0800
Subject: [PATCH v2 1/2] watchdog: sp805_wdt: deassert the reset if
 available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-hisi-wdt-v2-1-63edc4965b4c@outlook.com>
References: <20240220-hisi-wdt-v2-0-63edc4965b4c@outlook.com>
In-Reply-To: <20240220-hisi-wdt-v2-0-63edc4965b4c@outlook.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708366465; l=1680;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Ni3PL21dVfacX58NyroZjoZbD5lmIJt2JGNnhuDX6xI=;
 b=PrBA7WqGLAiZ5soLMgAGUcPHe80L3qvrMa1YCgw+lIjiZRPgunPC/QJ1gC7Uhjf+LEotU467B
 PvLM+7GxjLJBrZn9tW4NIuMFS0RPOBYdCLLihFM3kfBALus2ZLCjFfr
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

According to the datasheet, the core has an WDOGRESn input signal that
needs to be deasserted before being operational. Implement it in the
driver.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/watchdog/sp805_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 2756ed54ca3d..b4bcfdeb39e6 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -25,6 +25,7 @@
 #include <linux/moduleparam.h>
 #include <linux/pm.h>
 #include <linux/property.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -59,6 +60,7 @@
  * @lock: spin lock protecting dev structure and io access
  * @base: base address of wdt
  * @clk: (optional) clock structure of wdt
+ * @rst: (optional) reset control signal of wdt
  * @rate: (optional) clock rate when provided via properties
  * @adev: amba device structure of wdt
  * @status: current status of wdt
@@ -69,6 +71,7 @@ struct sp805_wdt {
 	spinlock_t			lock;
 	void __iomem			*base;
 	struct clk			*clk;
+	struct reset_control		*rst;
 	u64				rate;
 	struct amba_device		*adev;
 	unsigned int			load_val;
@@ -264,6 +267,12 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 		return -ENODEV;
 	}
 
+	wdt->rst = devm_reset_control_get_optional(&adev->dev, NULL);
+	if (IS_ERR(wdt->rst))
+		return dev_err_probe(&adev->dev, PTR_ERR(wdt->rst), "Can not get reset\n");
+
+	reset_control_deassert(wdt->rst);
+
 	wdt->adev = adev;
 	wdt->wdd.info = &wdt_info;
 	wdt->wdd.ops = &wdt_ops;

-- 
2.43.0


