Return-Path: <linux-kernel+bounces-167765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266CB8BAEE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A576D28402E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC09156C45;
	Fri,  3 May 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KSyGTDk2"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922321552FC;
	Fri,  3 May 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746083; cv=none; b=BJYhbm3xxXYKj5N79zhY2s+WE05F7zkzSnuHhmvx3UdQ9LFyd1N/mZzyWwI1El7lk9/Nz/0ux0McucxKOYCS2oIAj56KxtAwnCmLnnppZNMmEyXJSVjmFNm2KY+P/Esz+ZVV6ZT7HL7VQmyx9WQpNJ5dVhTDY42gb2v6iS5tR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746083; c=relaxed/simple;
	bh=3/3CibSLjnE7Z2tUb3XhZmdn0m09V6Wb8mUSh7tSTtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YhmedSHXaWIqad6AtFoXfWZXv0kunjqgdCuistV9syvh85oLhcQmFqYWZnjFY5GBAqB1RtKfDwDrgG4Ysjtv2m8R/mh/iszXt/6xQKbuez9tNEATsFxa39cXLh6pcJC8QQtG+x6+4YnxomjSqfffc+b1lWCZNGTz/aiAnIvhdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KSyGTDk2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00C5EE0007;
	Fri,  3 May 2024 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714746072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhCxOhm2wL8IBQ2UHqwouQlBmqxgQGndTJ7ExI+Ljes=;
	b=KSyGTDk2Ze0sA+Xr3CMjqq69hhUODAFh7KrVLI+BwthMp0mz9iItW7Evzw5ZfJRoNcoPnU
	OeNuNt4VaIb6OVgVFH4ElemZuPFdg4lf58kozOqEyZl4usKuKbzmxzPHx90DqNSc3H6Xak
	2sDh76IWcOqKMZ4d44pza9aTR09/dKBYlK3r17iGq/ONpRqfBQRyzMy7h8Y+NpKoex1NG4
	IlABmkbPIi2DrZjTwA0f2A7kGCupj/i0YDBQ4zaSW3gnbfMS8mB+WZQrdw23B6jItCHDCV
	4mYAtOpSZJxKbaySA37tLD+rjZMjf68gkybHapHNAFR0VOWFe/fb3cmM9RXS7g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 03 May 2024 16:20:49 +0200
Subject: [PATCH v2 04/11] driver core: platform: Introduce
 platform_device_add_with_name()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240503-mbly-olb-v2-4-95ce5a1e18fe@bootlin.com>
References: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
In-Reply-To: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Public function platform_device_add() does three things:
 - Name device using pdev->name and pdev->id;
 - Insert resources into resource tree;
 - device_add().

This implies device name must be based upon pdev->name. Add
platform_device_add_with_name() to allow caller to pick device name.
pdev->name cannot be picked freely: it might be used to match platform
driver id_table or name. This applies to MFD cells for example.

In header file, avoid breakage by aliasing platform_device_add(pdev) to
platform_device_add_with_name(pdev, NULL).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/base/platform.c         | 17 +++++++++++------
 include/linux/platform_device.h | 12 +++++++++++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 10c577963418..dce282cb2e50 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -648,13 +648,15 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
 /**
- * platform_device_add - add a platform device to device hierarchy
+ * platform_device_add_with_name - add a platform device to device hierarchy
  * @pdev: platform device we're adding
+ * @devname: optional device name to assign, fallback to platform device name
  *
  * This is part 2 of platform_device_register(), though may be called
  * separately _iff_ pdev was allocated by platform_device_alloc().
  */
-int platform_device_add(struct platform_device *pdev)
+int platform_device_add_with_name(struct platform_device *pdev,
+				  const char *devname)
 {
 	struct device *dev = &pdev->dev;
 	u32 i;
@@ -665,12 +667,15 @@ int platform_device_add(struct platform_device *pdev)
 
 	dev->bus = &platform_bus_type;
 
+	if (!devname)
+		devname = pdev->name;
+
 	switch (pdev->id) {
 	default:
-		dev_set_name(dev, "%s.%d", pdev->name,  pdev->id);
+		dev_set_name(dev, "%s.%d", devname,  pdev->id);
 		break;
 	case PLATFORM_DEVID_NONE:
-		dev_set_name(dev, "%s", pdev->name);
+		dev_set_name(dev, "%s", devname);
 		break;
 	case PLATFORM_DEVID_AUTO:
 		/*
@@ -683,7 +688,7 @@ int platform_device_add(struct platform_device *pdev)
 			return ret;
 		pdev->id = ret;
 		pdev->id_auto = true;
-		dev_set_name(dev, "%s.%d.auto", pdev->name, pdev->id);
+		dev_set_name(dev, "%s.%d.auto", devname, pdev->id);
 		break;
 	}
 
@@ -733,7 +738,7 @@ int platform_device_add(struct platform_device *pdev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(platform_device_add);
+EXPORT_SYMBOL_GPL(platform_device_add_with_name);
 
 /**
  * platform_device_del - remove a platform-level device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7a41c72c1959..bc1463c83f69 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -229,10 +229,20 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
-extern int platform_device_add(struct platform_device *pdev);
+extern int platform_device_add_with_name(struct platform_device *pdev,
+					 const char *devname);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
 
+/**
+ * platform_device_add - add a platform device to device hierarchy
+ * @pdev: platform device we're adding
+ */
+static inline int platform_device_add(struct platform_device *pdev)
+{
+	return platform_device_add_with_name(pdev, NULL);
+}
+
 struct platform_driver {
 	int (*probe)(struct platform_device *);
 

-- 
2.45.0


