Return-Path: <linux-kernel+bounces-77743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 047328609A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A23B2645C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BA811CAE;
	Fri, 23 Feb 2024 03:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqc+9AuQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B256111B5;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660191; cv=none; b=m6Gv8wP1R1wnrf/Hairuiv60/0tUenJA1UDIXvOnqSEqDhTIvbqVebzRUg1kDrXnvZDdnNB/EZlUrwxaNl6FukPD3ScDesGDEdiEjyd7Us4X1B8YrsDGGlcFVKhakaJJlH8k18wiRuBzL//jPpqT+r6Wgi2hr/yxohmc6bnI7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660191; c=relaxed/simple;
	bh=TWYzt4cWE702k5VOaGpWj9p2plXpYzNDkLilGGhbLfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTEH5YVBXzjxuVjcHy3WRjyT0Ug6AD5o325xNoz27jt2aRl/YMhK8Dwa9ibEdp2G3dpinLtV93km3ITK7vaPauxxGJKEnK6hdFmwdGEt+TwfMXQGfJyXu7rwXHDog7Iv0YZt9abVoKUdoihLmNaqMSB8w1oDlQ93YgcqPCbhZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqc+9AuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B710C433A6;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708660190;
	bh=TWYzt4cWE702k5VOaGpWj9p2plXpYzNDkLilGGhbLfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jqc+9AuQt9R+RFyxDbEXLasVKrOHbloI3R9NUuBgLCLw7/qNkRGQx0FDzweBtoO72
	 h8brlCRB+MH8L+ZcTFyn5hme99s75Bi4yFwxKyGPpJ4Dj0L/tBbkaugzGVP/g4LT7D
	 Bh5xkGwUVOqQrB4h7m3JUjxin/esA1qWVU0H3qXtdTAchnGWLRNcKiHzENybnHXQa0
	 a3vZczf0lGAJUw+60ovLSDoKFZS0KmDHZikCSuPGWL2NTUE3fDZkmzHKr/+i9DMuNP
	 UYKuuqo0AXBvrepPVMMFUkCKqGgtXhxXOx2NvUUexnBYpwTMlAtAwGKrbCzHQcBGdR
	 URzHf17w2vt4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E373C54798;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 11:49:47 +0800
Subject: [PATCH 2/2] drivers: bus: simple-pm-bus: Get and deassert resets
 exclusively
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-b4-bus-v1-2-2803c3ac4673@outlook.com>
References: <20240223-b4-bus-v1-0-2803c3ac4673@outlook.com>
In-Reply-To: <20240223-b4-bus-v1-0-2803c3ac4673@outlook.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708660187; l=1979;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=JWFA4aEPe9UmKX/cnL2dAlkZhpNjtIvdqZ32qXjuGyM=;
 b=qcHy1AJ2U0hzEwKWQHgC3iK0+xqjk8WbWl2uq7fhr6LqaRXcHt0ct/VyrmF1YNi9UhZRUXtJi
 6PhcXTFCv+eBZKsu7+gUxThU6jlKAvTTFu0oUsKCCNpUvnj66v+mIiW
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

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/bus/simple-pm-bus.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 50870c827889..d84dbd61c02b 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -16,9 +16,11 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 struct simple_pm_bus {
 	struct clk_bulk_data *clks;
+	struct reset_control *rsts;
 	int num_clks;
 };
 
@@ -62,6 +64,10 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	if (bus->num_clks < 0)
 		return dev_err_probe(&pdev->dev, bus->num_clks, "failed to get clocks\n");
 
+	bus->rsts = devm_reset_control_array_get(dev, false, true);
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


