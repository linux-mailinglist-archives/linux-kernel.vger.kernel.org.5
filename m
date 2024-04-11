Return-Path: <linux-kernel+bounces-139821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E68A082A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1DF282901
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34313CF80;
	Thu, 11 Apr 2024 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YSPnlXbt"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDFE13CA93
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816016; cv=none; b=XJLCiaAhKM5bUEm6RiW4ZmVf5ogFFS7iwtSDa6onGR92HZtsPBsdlVa/cQUKzMJBawC8yvnS7Hrqry7tuosIhO7gaB21WNb7tsYSTNmlIhF5I8SDup+VMeBQE/nc5vD9HBchdT1ngFNkH9trReHFXd6O5xKiki6SkYzXpLGXF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816016; c=relaxed/simple;
	bh=iBjVOBaapEZVCW+A+Rje4riKkbfHXxsIc5hGY+CZhj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPJ5kqXGocVE/QifzVT5hh80HM7JbRStuT2vo0T/KnwRUf+FmwZtPw36cVrXm0+gk707MksXXptNVmXNR7ve1LsB6aU46daL0LBD2BZbxZgbFXe/P327e4xVLV4QDwYuUFY/keuumjbNkuC9Tbfk6SgbiRtJ070gjD6qxETY+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YSPnlXbt; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id BD16860004;
	Thu, 11 Apr 2024 06:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712816012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MdWdWtrldfhRQv2gyq59FiEbzEmmQGiIdNXpfZHLUNY=;
	b=YSPnlXbtTkAz/rORo0WCLPT7coZBO5PZ/YI/MG62cfQW8KkiMOh7/vOm4gcpoCnQ88fKQG
	P4EJ0fJU3Ig8qI+e+W4+tGGzyvqWrtrqw6Dh+UeutXER6TkqccR4A1wWA+7HAA2v1/cht9
	8aQ/0bR6I/NMhAwjg42nk3qH8/aJ8WcAl1jPYW2k0XCdxOCO4c73pZPViwjvzNTPq2XYTQ
	bQ3Xa25Z84bNudve33znxUhQVpVXg7FHbKs7+WuFgP7w2akWM6uP4QAuR/dmTWEYlM678o
	yjGiDIV2fEff42uylf0C+P/8vpO/RIBPBrsdFCheGSpB7tSaMKIfzDPX3TS5bg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH v2 1/1] pps: clients: gpio: Bypass edge's direction check when not needed
Date: Thu, 11 Apr 2024 08:13:29 +0200
Message-ID: <20240411061329.7262-1-bastien.curutchet@bootlin.com>
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
Change log v1 -> v2:
 * Modifiy the way the bypass is done to avoid code duplication

v1: https://lore.kernel.org/all/20240410113502.73038-1-bastien.curutchet@bootlin.com/

 drivers/pps/clients/pps-gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 2f4b11b4dfcd..e30bf1c84ea0 100644
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
-- 
2.44.0


