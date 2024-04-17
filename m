Return-Path: <linux-kernel+bounces-148245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AAA8A7FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090C7B2137C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802EF13C8E2;
	Wed, 17 Apr 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lm9vnTGf"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27AC13B587;
	Wed, 17 Apr 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346466; cv=none; b=CGbVmy9xWQmurql5UMPS1l3q8S8CqH6hQyzHLTxGIxI/ctl+5pRMJzEDzfPmATs8R1fkvRAasVgffEzNgs6a7yzaiUr4iJeZNcOVAcOJJJlBO6WOCgj8On3iQFCaEEL4B+yq7GKuMqO4qZRXv+yItjjNgLGiUYIDBmaYuWSDlNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346466; c=relaxed/simple;
	bh=eGHupbbAXrOuVkyU7yVyj7B+fR4iB6zqnc40QsMfo1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfkEBLHRqmrtJGz2C20mnKMGt5+pWruowpeIuCS+B6ZHYmRJH9Rv/DkezFGvZD6HJqCLcvwjX1GEs3T8BvHnpAjvpI0b2gv40m5lqW5oXHO2qwqBeZpBCzj3CocM5M0oHxnkDhqT4F2PYSf6Hs3nk/qL9Vnxh/FTimK8C3CEFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lm9vnTGf; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DB26FF807;
	Wed, 17 Apr 2024 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713346456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWaDtQEb7dwOp/Q7435hr2efY4FLjjZYmFKQ/nPyw3U=;
	b=lm9vnTGflHUTqHkGsfltL26z4PU4h0vtaCrVhA+7oYPg9jP3QEVIZYebZjOCwN9BBUHBZn
	7ivm/4AhqmXMXP9A0TYAy+kcKXNao/XROVxSvFACBLGavSGehOgBT66rx/bK4TGcVFaM3Z
	VhNzXKfugyz/b+to+VXZxmOVIDSC3xJgLplb3cCx7Pj3oBgLxk6jEKR6sTHRlEncPGCox7
	pT0pZLbEaj4dlqHhcmhzJZuSho5nn/DcT2+sgJgyW031P+ybcXrqllMdMxp17sEpF5lcVW
	EVyHyOgupg3AS3gP0lNI9HWy2q2q0Ac4DA+1fo4ruJ/MuFuTZfe/AjC7SQvVpQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 17 Apr 2024 11:34:12 +0200
Subject: [PATCH 5/6] wifi: wilc1000: make sdio deinit function really
 deinit the sdio card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240417-mac_addr_at_probe-v1-5-67d6c9b3bc2b@bootlin.com>
References: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
In-Reply-To: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

In order to be able to read raw registers (eg the nv mac address) in
wilc1000 during probe before the firmware is loaded and running, we need to
run the basic sdio functions initialization, but then we also need to
properly deinitialize those right after, to preserve the current driver
behavior (keeping the chip idle/unconfigured until the corresponding
interface is brought up). Calling wilc_sdio_deinit in its current form is
not enough because it merely resets an internal flag.

Implement a deinit sequence which symmetrically reset all steps performed
in wilc_sdio_init (only for parts activating/deactivating features, for the
sake of simplicity, let's ignore blocks size configuration reset)

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index a841dad08410..04d6565df2cb 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -627,7 +627,52 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
 
 static int wilc_sdio_deinit(struct wilc *wilc)
 {
+	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
+	struct sdio_cmd52 cmd;
+	int ret;
+
+	cmd.read_write = 1;
+	cmd.function = 0;
+	cmd.raw = 1;
+
+	/* Disable all functions interrupts */
+	cmd.address = SDIO_CCCR_IENx;
+	cmd.data = 0;
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Failed to disable functions interrupts\n");
+		return ret;
+	}
+
+	/* Disable all functions */
+	cmd.address = SDIO_CCCR_IOEx;
+	cmd.data = 0;
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev,
+			"Failed to reset all functions\n");
+		return ret;
+	}
+
+	/* Disable CSA */
+	cmd.read_write = 0;
+	cmd.address = SDIO_FBR_BASE(1);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev,
+			"Failed to read CSA for function 1\n");
+		return ret;
+	}
+	cmd.read_write = 1;
+	cmd.address = SDIO_FBR_BASE(1);
+	cmd.data &= ~SDIO_FBR_ENABLE_CSA;
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev,
+			"Failed to disable CSA for function 1\n");
+		return ret;
+	}
 
 	sdio_priv->isinit = false;
 	return 0;

-- 
2.44.0


