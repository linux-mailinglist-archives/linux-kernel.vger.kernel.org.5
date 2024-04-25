Return-Path: <linux-kernel+bounces-158518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1668B219A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE68A1C222AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34412BF3E;
	Thu, 25 Apr 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XP+Dy3TL"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E012BF28
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048154; cv=none; b=tn4TVVinmE0hTC+Vkm/oBr3aKCF9ZG0MC8ey2Cb/NYlsRlHZacnTS5vBSXj6NmTO0MErA+nNQH6cdv45cL0RU6bUBetVQ+rZVT1wOr7o6H7E36+hZh9Qfaf9pgJXFEDEh2CimOseFrVkOHAEAIIIogpUIxByREa8D2jc6HMVj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048154; c=relaxed/simple;
	bh=drcLk8pUBmRnR0q4bgDQ6UjNtZcLfMvW/yQjuXeW7Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mgx2ktX6WPPl19+Kdk43aMMPf+Sc95zZUPRRLSXnARaRUXF1SzFRkibbz8HqiPWBiYPYGGYO44vpRCdZrwYkKzwyWHyFDeo9otEfep1/nkDRu31pVzYELz/gK50ONr6cHenc1yxZMr/SRof2pPXyNMCostEjZzVCsUi2Rj860As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XP+Dy3TL; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 552771C0004;
	Thu, 25 Apr 2024 12:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714048144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WJAkEXrvSwROdlTnoslcx5AIwSJalnex1Ta2XlQ37l8=;
	b=XP+Dy3TLIvGOqZUqVN/+W+zZnOOPe/yfNa11henjn5j1pnTPLOf6QA/qBAuYDkaYJ7gsBb
	6992Cw/g0Q0ww71z9dTFSngI4E68/kbB1j5rFw+4ztmQV1IN/K1Wkw6HfD1nM/r9+7BN9i
	zzUKiA5Zf/rXjo/2ZUDUggo+HhZgybQieuqtwHMdUM/fkmmtkmVPsNYVLxyUL0/HbS7tF3
	MTqffsTiFmuyfuqVYTfzzHVr6IIzNSWnVyG7z41j6i+mka7njqRdD/7Yivrb7MFHO0OoVc
	DQ33/t41MGcAnhJtVvniX93WjA4QUcqqLTsCd/bfOl1Sas8XlqjNABlRpYgs0w==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH v3 1/1] pps: clients: gpio: Bypass edge's direction check when not needed
Date: Thu, 25 Apr 2024 14:28:52 +0200
Message-ID: <20240425122853.29544-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

In the IRQ handler, the GPIO's state is read to verify the direction of
the edge that triggered the interruption before generating the PPS event.
If a pulse is too short, the GPIO line can reach back its original state
before this verification and the PPS event is lost.

This check is needed when info->capture_clear is set because it needs
interruptions on both rising and falling edges. When info->capture_clear
is not set, interruption is triggered by one edge only so this check can
be omitted.

Add a warning if irq_handler is left without triggering any PPS event.
Bypass the edge's direction verification when info->capture_clear is not
set.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
Changes in v3:
 - Add a warning in irq_handler
Changes in v2:
 - Modifiy the way the bypass is done to avoid code duplication

v1: https://lore.kernel.org/all/20240410113502.73038-1-bastien.curutchet@bootlin.com/
v2: https://lore.kernel.org/all/20240411061329.7262-1-bastien.curutchet@bootlin.com/

 drivers/pps/clients/pps-gpio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 2f4b11b4dfcd..af62d944d051 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -52,7 +52,9 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 
 	info = data;
 
-	rising_edge = gpiod_get_value(info->gpio_pin);
+	/* Small trick to bypass the check on edge's direction when capture_clear is unset */
+	rising_edge = info->capture_clear ?
+		      gpiod_get_value(info->gpio_pin) : !info->assert_falling_edge;
 	if ((rising_edge && !info->assert_falling_edge) ||
 			(!rising_edge && info->assert_falling_edge))
 		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
@@ -60,6 +62,8 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 			((rising_edge && info->assert_falling_edge) ||
 			(!rising_edge && !info->assert_falling_edge)))
 		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
+	else
+		dev_warn_ratelimited(info->pps->dev, "IRQ did not trigger any PPS event\n");
 
 	return IRQ_HANDLED;
 }
-- 
2.44.0


