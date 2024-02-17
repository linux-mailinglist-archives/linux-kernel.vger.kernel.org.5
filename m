Return-Path: <linux-kernel+bounces-69676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEFC858D32
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B5F28374C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50501CA9A;
	Sat, 17 Feb 2024 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPFBz8Z+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024891CA87;
	Sat, 17 Feb 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708144834; cv=none; b=c+MCCpG4v/gvY1e7KjoYQhRUM9Uh0o6I5X/SDO3bnsGT5wo3daNmMLgl17nip4EDW3OSlQsgrbFCaLzgRX4m38c9S6t7iNKYZ+tZ34+Von77q/+ZIFAhH0zftvLr1ApHnH/bvAuEebVrpBZIooO7II3HRwtYtahMuSp3RKzKh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708144834; c=relaxed/simple;
	bh=O+gac3yrsv2rOFibZ4kRZ9MSQo41/MsQ6GdSbvpMomU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDtYNc6tu6DZk2sz1Z1aJ8wH41AAdWLy9plyKc13sLgnxi46lDnKytvdTbGBfSEmcd2THq0wl8ayHZaPwBXvkqXLSoOhnM/iYX4MqTC5ELBARtQzxzADWCgi9STJr7kK10TjxOmeKCnXnrA1uH82WjwxtZFYl42mz24JeD186DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPFBz8Z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89D50C433C7;
	Sat, 17 Feb 2024 04:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708144833;
	bh=O+gac3yrsv2rOFibZ4kRZ9MSQo41/MsQ6GdSbvpMomU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CPFBz8Z+7+dCJodMlEdTrLsCGQw8KLcnGPAwOBzlTcMu5FBiZJZTbAwfBYv38UZIu
	 M+reaATkaKjTLCR04My6WnGGnXvSEAEZaEUoJ3QzW2eI5sOVnd/WfRXpNSFVMGLKMp
	 oaYfcV5HYv8Q2ToiTS8RFkqTR1iFOTdEoOTrj9K1qPNeox72pRG1QL8hD61yxHC2PJ
	 20IBkygJAv+GIwnNryhH7cRtH3kr2goe8CMoWniQapfuR61N8iXh4wmVKxNyen0KOf
	 0mOJ0tlZvjHUCfBO3xZHjPvmcW1IEMzofo7msgTQrChIvdIA1TbOpMkboxiFO5PNSd
	 TRUnbhize5qnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC6C48BF8;
	Sat, 17 Feb 2024 04:40:33 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 12:40:34 +0800
Subject: [PATCH 1/2] watchdog: sp805_wdt: deassert the reset if available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-hisi-wdt-v1-1-cdb9ddcab968@outlook.com>
References: <20240217-hisi-wdt-v1-0-cdb9ddcab968@outlook.com>
In-Reply-To: <20240217-hisi-wdt-v1-0-cdb9ddcab968@outlook.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708144834; l=1680;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Ni3PL21dVfacX58NyroZjoZbD5lmIJt2JGNnhuDX6xI=;
 b=qRRi4UH/YpnnK9zlhgdhzMq/aSkKISAB1wZOe9Q17jU37YPbo38JY3Un26vNgzqCE5uiWTDF+
 G80t5j/g/XSB7BOUhWmO7yYDvRHKf6erMqOReBZaT0lHNN9B18LzbWB
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


