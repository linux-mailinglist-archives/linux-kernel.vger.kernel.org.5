Return-Path: <linux-kernel+bounces-41948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2567E83F9E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EF41C21718
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB022E83F;
	Sun, 28 Jan 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="Q7uXlMIy"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BC2E62B;
	Sun, 28 Jan 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706474925; cv=none; b=pMpOLPp22r9kW7iidKxC+DSDDMKOq5DyfG72a9srPMStad8E/P+bK3Lk6IAxiCwN0sGLR1BnLXezDdrI/o7fwOYitBp0KMFWnu1zFae7T0jwV6xSbCYYMAZWZZkbEbiwRXPbkF8CA+r7kExGgE6ChplFKhxMsicO9dtGTZu0vmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706474925; c=relaxed/simple;
	bh=DKGeUasBS6xTyhYqe+UExGr24G9PuFPZv+fUiAffDj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWAqEMi8WW6rfSWVRxKzLSIJuuvb+lm69zj7EVEwla80TdItQHq8Zc0tu1bSs8g4RS45rS5jHauSrVdCK+Ft+WJTZkjmVmzhpbOrykVP97Xn96lbD7ck8TTjdJQ8VafEq2WK/lQWX16dLPH4kpsZZluU7/LM9plaezLMWQChNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=Q7uXlMIy; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id B11E846366;
	Sun, 28 Jan 2024 20:48:35 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-kernel@vger.kernel.org
Cc: Miles Alan <m@milesalan.com>,
	Ondrej Jirman <megi@xff.cz>,
	Aren Moynihan <aren@peacevolution.org>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-leds@vger.kernel.org
Subject: [PATCH 1/4] leds: rgb: leds-group-multicolor: allow leds to stay on in suspend
Date: Sun, 28 Jan 2024 15:45:07 -0500
Message-ID: <20240128204740.2355092-1-aren@peacevolution.org>
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
	s=dkim; t=1706474916;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
	bh=lb0m4VN+fLcRwTMjHhUiN4pOHzBM3BNlNUXpNwfCjmE=;
	b=Q7uXlMIygUiuEL02z/PKkAuY3qqvE7csYD6Ap3VSRKMhAcg9XvsTxqUCfzt1iXgwsFM/dA
	OjBDHPlh47mATnlAVVPe8P9+k/GJS+gEBeeDeytbBimKfDq+phqSniMkY4TWN7GlpCfmcI
	uWHqkBDSAjOl2f0CL/XYL7DgnPb4WCk=

If none of the managed leds enable LED_CORE_SUSPENDRESUME, then we
shouldn't need to set it here. This makes it possible to use multicolor
groups with gpio leds that enable retain-state-suspended in the device
tree.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

 drivers/leds/rgb/leds-group-multicolor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
index 39f58be32af5..194c6a33640b 100644
--- a/drivers/leds/rgb/leds-group-multicolor.c
+++ b/drivers/leds/rgb/leds-group-multicolor.c
@@ -69,7 +69,7 @@ static int leds_gmc_probe(struct platform_device *pdev)
 	struct mc_subled *subled;
 	struct leds_multicolor *priv;
 	unsigned int max_brightness = 0;
-	int i, ret, count = 0;
+	int i, ret, count, common_flags = 0;
 
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


