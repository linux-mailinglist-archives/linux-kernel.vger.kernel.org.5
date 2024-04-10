Return-Path: <linux-kernel+bounces-138417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D256389F0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881F21F22B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E9C1598EB;
	Wed, 10 Apr 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WQUw7db6"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180B159218
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748914; cv=none; b=I9JyaSppSYUrXgO5oELSDA7IP09nZpylxGuzfZK2AOu3AGiF4LdsGGOzuHj/Komt2GlQRz/nGpu8foXZ4UdOCQgsnvUp5WXkcLwsENaM7gqTlOdEHAxx405rUkHOsuDgX1pAGlGFLiLZ/UfBNCKUnQdhJ8UFkCn3wFZkviH6Tug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748914; c=relaxed/simple;
	bh=O/8AzskD9KVva3GT8q4/o/zoV+1+gKKkebrOiTkuZ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=giXIfvf/jW8DLakDBvtVb2RfwNDta/irgZiSphOzUoo8lP/ssIboghLmsQ12eX8SSIyBKAWlWB2dzaqDe/xrKr4/edcUcX2a3ra0Uj5c7Qhvu3IwkMeozF+wqypmZi4XPauNkvV8YZ5H0IDUC6v7hQ+VcQ6IJUggE3Cw0TPJAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WQUw7db6; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2E51BFF809;
	Wed, 10 Apr 2024 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712748908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=grZHtqTXi6TevLF3Jivd3QmMNmzhzNubpl8v6knfd4A=;
	b=WQUw7db6u7rvh4XH83DqAxFl+78HqSX1Q5V5Erw9qfOSntLHG7UWmwLSUc9AsUbZN2OyoD
	D6mWpgX9HlRQeqzUszyAVgUGdTD5cgzlD09jiI+EMs0rWsnyErk4n8kfyPnxv4h59UvNaD
	sx0xhla89Ld2M1MwMLcfL9yub+vZsDbLmZqFz4rUFXZ37/ST9zrceKY73NEPOzlcf+WG1o
	blwSamA2Q8rrsePyTVNYQcBuKzGKNuZdA5Em3PfshYQIyN7yFEgM8fTPNWroqcFlOOWrFW
	16xanHUKETkEb6ts01hE5YFIUC/G7+GBCJi0dN4WqqS8rOM5Efpx9wHw5EV8zg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 1/1] pps: clients: gpio: Bypass edge's direction check when not needed
Date: Wed, 10 Apr 2024 13:35:02 +0200
Message-ID: <20240410113502.73038-1-bastien.curutchet@bootlin.com>
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

Bypass the edge's direction verification when info->capture_clear is not
set.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/pps/clients/pps-gpio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 2f4b11b4dfcd..c2a96e3e3836 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -52,6 +52,15 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 
 	info = data;
 
+	if (!info->capture_clear) {
+		/*
+		 * If capture_clear is unset, IRQ is triggered by one edge only.
+		 * So the check on edge direction is not needed here
+		 */
+		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
+		return IRQ_HANDLED;
+	}
+
 	rising_edge = gpiod_get_value(info->gpio_pin);
 	if ((rising_edge && !info->assert_falling_edge) ||
 			(!rising_edge && info->assert_falling_edge))
-- 
2.44.0


