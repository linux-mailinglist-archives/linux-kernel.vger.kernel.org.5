Return-Path: <linux-kernel+bounces-74668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1E85D781
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC1F1C22433
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0850F4C60B;
	Wed, 21 Feb 2024 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQpT880s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5D482D8;
	Wed, 21 Feb 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516606; cv=none; b=kW0zCu03q404/nFLkSVUabgFtIpCXAQ88g7t5NWQ0Q3QXe/pwOGziVimtiWGo+hT/IwTRrY65K4pqiz7vSEGDeJSR0PNDUT8wq7bW8vxCjQZyt3h5WUtSLhNhZS5dmHOhumi7lby35zF/mn1jHx8iugdVJbXTByibEmNlLqZ6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516606; c=relaxed/simple;
	bh=Dr9OQrUqQG/6MBjESHU6+3PVn2jjS861J9aFbtcZVq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcAlSJAMdrRclCQTi11AA16ZkVFY8iw91qrWvarTf/lFcxBSfzXpGqwEDywh6LIbteweWWgkInKk+FcZb4uyx45r1bSnlQ+Yhkh7/L440m2XgmZJ9HM0vp1cTxzEWsKlHxIToE3mdm8Q6meJmm1ehre2X+uo7KDv2MtJcK+f/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQpT880s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEB79C433F1;
	Wed, 21 Feb 2024 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708516605;
	bh=Dr9OQrUqQG/6MBjESHU6+3PVn2jjS861J9aFbtcZVq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gQpT880sjW3T+moOLdRPm4D/qZbYsY0ogJJyEKz2C2nNCuaEt5tJr48ZLqoPqTaEp
	 CZBVoiKt9MkSe3dlNewYw2ku1kdgBk1xKJvU3z6dM9k7SwNtEpNjCDhRv64YQ1lOOy
	 IfCRH+ZkaIigSizzaBsw9SN/92ES4abREtIndl+8lrePmG5JUmKD7D/GPjeXkMOfBh
	 +HC3+aRPnAiJmphhCK2OW8frk3fvgKmdcLhJwZ4vFM1jSnr/yMzsh2OJrqKglbGOgZ
	 TgK2O4X77zXMeGoz+xX3veUkBVu3RjlDm5zj5FqAJcgigozQV53y+IQGvs25PeWdac
	 ppUgUz01ERzug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37F0C48BF6;
	Wed, 21 Feb 2024 11:56:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 21 Feb 2024 19:56:41 +0800
Subject: [PATCH v3 1/2] watchdog: sp805_wdt: deassert the reset if
 available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hisi-wdt-v3-1-9642613dc2e6@outlook.com>
References: <20240221-hisi-wdt-v3-0-9642613dc2e6@outlook.com>
In-Reply-To: <20240221-hisi-wdt-v3-0-9642613dc2e6@outlook.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708516604; l=1308;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Yulf71GztXVGablEgkhT6BHnqYqWblq9L42vUSDAg9k=;
 b=+BBcG1xmGtzehN6g+Xwdx1UJPNgY6Spl76NJKL/19umtdnMNqtXf/NjvXINZy1aot1GKR3UgT
 5vXzcsBnhRuCceep7KHoaoAakAuReSP6/t0rNrqDPmpqBKs3CU+rMjj
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
 drivers/watchdog/sp805_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 2756ed54ca3d..109e2e37e8f0 100644
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
@@ -232,6 +233,7 @@ static int
 sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct sp805_wdt *wdt;
+	struct reset_control *rst;
 	u64 rate = 0;
 	int ret = 0;
 
@@ -264,6 +266,12 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 		return -ENODEV;
 	}
 
+	rst = devm_reset_control_get_optional_exclusive(&adev->dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(&adev->dev, PTR_ERR(rst), "Can not get reset\n");
+
+	reset_control_deassert(rst);
+
 	wdt->adev = adev;
 	wdt->wdd.info = &wdt_info;
 	wdt->wdd.ops = &wdt_ops;

-- 
2.43.0


