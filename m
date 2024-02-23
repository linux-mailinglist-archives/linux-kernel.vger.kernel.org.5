Return-Path: <linux-kernel+bounces-78104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A27860EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5101F233AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E05D472;
	Fri, 23 Feb 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjvB0QSU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FA5CDCA;
	Fri, 23 Feb 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683023; cv=none; b=mBaxSjv0tEyewQnqTluikvrC26ctbT/JFPMHyiySsVPJPRsPR2x7urJWB2iKPGrhLv+MRQR0+S12EQVWfCwtB55C7BflfjhpEFGt/ItVM69iXNzsYvI58XUvs3HC9tH4ahr/F8cKuxUp7ISJ1ml8eBEk8/sEDWAAx5Q/qq0J54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683023; c=relaxed/simple;
	bh=3U04gKlXchbJ+V24kjC1E8jAr7x4b4Y+oBUhHQOFzN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvfFjkctzNdGFZdnf91wH6kZMhq96bOCIp3uKDg2ehYWaKwIhCRc/IMIanWY1syYmPI/grJFnVOaiKffHpqbHAblqbOKzFj8GL7qSGFA6l+XsaZx5X/Msjz2UHu/BEMRoKmEEZCOKEVM+2B7L1UdeshmtisatsD4MSZAcZKEJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjvB0QSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C09F2C43394;
	Fri, 23 Feb 2024 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683022;
	bh=3U04gKlXchbJ+V24kjC1E8jAr7x4b4Y+oBUhHQOFzN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TjvB0QSUvgv3PAcFdrwn2kV1C+sRbekO9orDxO/UtNg7IS0KzkVpTGPUsLWNvnxs/
	 CJDWj9WiATpH+kx80xaX4LNPwSj2aMyKV2O+iV6DQLzWZxW9UTQ2E4/GIRptnv58xP
	 pb7/fn7KxkjQIjvOCSSkZWW7m/BO6OzEh33fNP/UD927b5R2Q3ioMM243pvAZT84Id
	 GWN4eIjpUxbI8qonSW8503WE7fneIXyRRuKqknjU+0GcLkYudP0BqgbOD62M1vDz/s
	 Sh4XpbZadxwKIHL93olNJNXuuVJDneG7db/HAFIcKVcZvIRGDEFzsSXW0/g7gUavTY
	 +MlMfz9ppnVjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8092C5478C;
	Fri, 23 Feb 2024 10:10:22 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 18:10:20 +0800
Subject: [PATCH v2 2/2] drivers: bus: simple-pm-bus: Get and deassert
 resets exclusively
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-b4-bus-v2-2-da8ba83c1a5f@outlook.com>
References: <20240223-b4-bus-v2-0-da8ba83c1a5f@outlook.com>
In-Reply-To: <20240223-b4-bus-v2-0-da8ba83c1a5f@outlook.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708683020; l=2336;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=IavnxoIeWBK3APBnyHNZI/y56/+6lr1F3uzJe1D+hR0=;
 b=MP/vK9i/hsQIRpsFr8imCB448rwViVkMEJMYN2xWPt0Iguka38Nnv3GNOFlLDLlttOq20rWiG
 hBYhuRFxbd1BPzl4xoRlQ8X0jYQE6ZXq9r0vXmfusoz4ngVIahx9XGT
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Simple Power-Managed bus controller may need functional reset(s)
to be deasserted before child devices connected to the bus can be
accessed.  Get the reset(s) as an array and assert/deassert the
reset(s) when the bus is being power managed.

One example is that HiSilicon USB2 INNO PHY test bus needs to deassert
the reset to the bus before accessing its registers.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/bus/simple-pm-bus.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 50870c827889..f2e98eac0bb4 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -16,15 +16,17 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 struct simple_pm_bus {
 	struct clk_bulk_data *clks;
+	struct reset_control *rsts;
 	int num_clks;
 };
 
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
-	const struct device *dev = &pdev->dev;
+	struct device *dev = &pdev->dev;
 	const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
 	struct device_node *np = dev->of_node;
 	const struct of_device_id *match;
@@ -62,6 +64,10 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	if (bus->num_clks < 0)
 		return dev_err_probe(&pdev->dev, bus->num_clks, "failed to get clocks\n");
 
+	bus->rsts = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(bus->rsts))
+		return dev_err_probe(&pdev->dev, PTR_ERR(bus->rsts), "failed to get resets\n");
+
 	dev_set_drvdata(&pdev->dev, bus);
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
@@ -92,7 +98,7 @@ static int simple_pm_bus_runtime_suspend(struct device *dev)
 
 	clk_bulk_disable_unprepare(bus->num_clks, bus->clks);
 
-	return 0;
+	return reset_control_assert(bus->rsts);
 }
 
 static int simple_pm_bus_runtime_resume(struct device *dev)
@@ -106,6 +112,12 @@ static int simple_pm_bus_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = reset_control_deassert(bus->rsts);
+	if (ret) {
+		dev_err(dev, "failed to deassert resets: %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 

-- 
2.43.0


