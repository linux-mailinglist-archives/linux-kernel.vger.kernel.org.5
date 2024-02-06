Return-Path: <linux-kernel+bounces-55531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0D584BDBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABEC1F20F17
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854117731;
	Tue,  6 Feb 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="AD8RDoDq"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B5175BD;
	Tue,  6 Feb 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246178; cv=none; b=ddgi0iSNnESpPw5Xb2Gx6bi0HuirQfu6GLkX62mnL51Ie5gEe/dWY2cfT+EN5kO3mP1pVuYVlDL5UJyJpiVy+AL1WXLFwRmWtMUH3i3m+Za5PQmHSGjcgRDx2a1HG2sEjtGHbuGmXXA9/NnJBbDp8obz+wl0tPzJxaLq32UiDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246178; c=relaxed/simple;
	bh=qXVPXyupoi6y4mfGDfx6l8JDOF1+lMDDn4mbVnSTzr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vE5C2+t6LWqlUP4zC3HHwiMEsfo5JSLT/1t4+1rgWo6JchBtRxKkLK+vZ8jqWbet9s8WnN4LV4Cq3Fx12BzrWEndsto1o1iqSFw5u2MnzYMqtjYX9g2/88pB/MGDF8W1LecuBHLxEjTiOIss+yaZmuMxdsK7tN934EmgDWku1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=AD8RDoDq; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id DD9644583E;
	Tue,  6 Feb 2024 19:02:48 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Ondrej Jirman <megi@xff.cz>,
	linux-sunxi@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-arm-kernel@lists.infradead.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-leds@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Miles Alan <m@milesalan.com>,
	Samuel Holland <samuel@sholland.org>,
	Aren Moynihan <aren@peacevolution.org>
Subject: [PATCH v2 1/4] leds: rgb: leds-group-multicolor: allow leds to stay on in suspend
Date: Tue,  6 Feb 2024 13:13:17 -0500
Message-ID: <20240206185400.596979-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ****
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1707246170;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
	bh=NQIirmVOCAxOql2DLF2KDYdkndurgToAOXdUzzfrUao=;
	b=AD8RDoDqSuMzuW8WjS6hsO4Ihd7f8WOWW5QsXpSI7G+B3S/ZAOv9zFcgzVMoPwDLVcGvsZ
	3jyUXi4dQD42GwETLjspanbyyc4gtnAGlP9du/NQeqpq3AQNfhm+zqS098d0N0cu3STJr2
	Os7WmPNxQ97X0MQofjfo76Zlw56NSU0=

If none of the managed leds enable LED_CORE_SUSPENDRESUME, then we
shouldn't need to set it here. This makes it possible to use multicolor
groups with gpio leds that enable retain-state-suspended in the device
tree.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Changes in v2:
 - make sure count gets initialized
 - send the patch to (hopefully) all the correct people this time

 drivers/leds/rgb/leds-group-multicolor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
index 39f58be32af5..b6c7679015fd 100644
--- a/drivers/leds/rgb/leds-group-multicolor.c
+++ b/drivers/leds/rgb/leds-group-multicolor.c
@@ -69,7 +69,7 @@ static int leds_gmc_probe(struct platform_device *pdev)
 	struct mc_subled *subled;
 	struct leds_multicolor *priv;
 	unsigned int max_brightness = 0;
-	int i, ret, count = 0;
+	int i, ret, count = 0, common_flags = 0;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -91,6 +91,7 @@ static int leds_gmc_probe(struct platform_device *pdev)
 		if (!priv->monochromatics)
 			return -ENOMEM;
 
+		common_flags |= led_cdev->flags;
 		priv->monochromatics[count] = led_cdev;
 
 		max_brightness = max(max_brightness, led_cdev->max_brightness);
@@ -114,12 +115,15 @@ static int leds_gmc_probe(struct platform_device *pdev)
 
 	/* Initialise the multicolor's LED class device */
 	cdev = &priv->mc_cdev.led_cdev;
-	cdev->flags = LED_CORE_SUSPENDRESUME;
 	cdev->brightness_set_blocking = leds_gmc_set;
 	cdev->max_brightness = max_brightness;
 	cdev->color = LED_COLOR_ID_MULTI;
 	priv->mc_cdev.num_colors = count;
 
+	/* we only need suspend/resume if a sub-led requests it */
+	if (common_flags & LED_CORE_SUSPENDRESUME)
+		cdev->flags = LED_CORE_SUSPENDRESUME;
+
 	init_data.fwnode = dev_fwnode(dev);
 	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev, &init_data);
 	if (ret)
-- 
2.43.0


