Return-Path: <linux-kernel+bounces-55601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F76684BEBB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C4DB25781
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A9B1B94D;
	Tue,  6 Feb 2024 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uNXpjRXu"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FFE1B807
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251609; cv=none; b=qyk5iqdZy9jSWjqYFAa4ySfc/6B1VrNMl/4sMzm+AJYLPOmMQakyfKZ5FeB4T+IpjyNB84V/CjRw01oN/wagbmVoXkrxXR+obHEgiyCy+iU3G4o8xyUfOFgrPWmwB3plZr5GJ6SEaNIi1ElgfIMN95q/SsO13mIa2pbkMd7neek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251609; c=relaxed/simple;
	bh=zV6UMa6KGS3460hptBgo8h2zveZj4vaThxc5kbb1euc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8VOgSoW7JcnNlH4W/LJOGNHOt/EnmgQtYlogaBtHaHa+402805RRhx65d+VMyChlKzU5B1CP5wRO5pbzjzlT4pOy36+tBx0/quEWIBefn3mnqrULI0nIWCCEGA+i6TBM1PSXHrIhQCMzxVYl9owXGVYn0zHvDKCFo4fPcSyOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uNXpjRXu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e1149c16d4so2164552a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707251606; x=1707856406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfTOMRIgy5yUmp1Zi1mrOXV6NTegVTcyJrqWrXnDXfo=;
        b=uNXpjRXuSdTOAMczG5ehg8nEJRUSsmBl2egbaAmgfkpCErvlAYEHr8b352FcupFRI/
         UXhBA9Jw1SM+ofjnymnO95qugGdn/douklZiU/AcaOt7QvX1D4FxgzC8J9GxM3TKGPqd
         Iw7rHvETzE/pV1pb0F4PilII5vCVOeFJTjV71wdJFsIme6QI9m8QwskF/tTqaN17Snrf
         JXdfZd57ksGUUTL2GzeWjl02CBleHt/O2vhPfRb+q3nJN/EwMWAMJx72ji2bjgifdL5j
         cAOUHOvXBRzD59dZGGTIyw0nwJ8I04xSJt0menMljtiN/qUxrASKhVspGuA7HvNTSq3v
         JhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707251606; x=1707856406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfTOMRIgy5yUmp1Zi1mrOXV6NTegVTcyJrqWrXnDXfo=;
        b=vW/8a8/b5+C3P3t6EYoxPX8QNVscqhFI8ovT/VNxrX3nNkQ2xAXX1P0NKfpaVEqOch
         1NazcziA4tidJolu2p/3wh+E/jQIt01/GReNmcyTUyEyCmqPS8uij3Ofxg65+IYIM88R
         YMoFkOF+MOXskNgwprczvqmwzADm1qNFnKpJmn20AWLRWaAD3lTpjiF146jbH0iDjy8B
         iGX4A7phcrzfQac9jEsN8MuipT3yRxfBUo8vQ1Zz2s8J1cvXRE6Y6uS/JpF+QiBNcdjL
         rsvXylmAhdUP4Y2uUGD0m/QyyrweL9tty8ErROqrr2Mw3RGCiAR80C1ukJxFmQqxBnqk
         tLxw==
X-Gm-Message-State: AOJu0YxRWiTFVoaq8pd6DCc7AN7peFx0FzDh+L3AMHW3EvDvT/Ks6qDe
	H5NsA0xkQoGfS+jE3xmIM8s043dXrBjevZhbNzPA29isNlzE8oeL9ZL/3sVU6H4=
X-Google-Smtp-Source: AGHT+IGJf9ep/lPbbuizFAQfco/oZLYeI9cVSfpniFdRh+hPnl269EOax256xe26Om84BuZyOssTWQ==
X-Received: by 2002:a9d:77d2:0:b0:6e0:f903:f7a6 with SMTP id w18-20020a9d77d2000000b006e0f903f7a6mr4073222otl.36.1707251606042;
        Tue, 06 Feb 2024 12:33:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV+uanjprraKmO3BJdbA8N8V3mZg3/e56x/S+A6o4ojIU2WsGbOoQVl0I9ozFPnU5QepvkfdTSsww7u4InLod8SgXN3j2jrCTvp2CLa+HMZhFUdVj22pGJIxuMYMU+JUEki6KNLWwe01zeKUHEF+s99igBfSGrU4txJtszHp+ndQ3XwYO7lwQ1Tmh/CM7n3+tKIXQ==
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l2-20020a05683016c200b006e11d93ff09sm429581otr.72.2024.02.06.12.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:33:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: axi-spi-engine: move msg finalization out of irq handler
Date: Tue,  6 Feb 2024 14:31:28 -0600
Message-ID: <20240206-axi-spi-engine-round-2-1-v1-2-ea6eeb60f4fb@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
References: <20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

As a general principal, it is best to do as little as possible in an
interrupt handler. This patch reworks the AXI SPI Engine driver to move
timer_delete_sync() and spi_finalize_current_message() out of the
interrupt handler. Instead, spi_finalize_current_message() is moved to
the transfer_one_message function (similar to nearly all other SPI
controllers). A completion is now used to wait for the sync interrupt
that indicates that the message is complete. The watchdog timer is no
longer needed since we can use the wait_for_completion_timeout()
function to wait for the message to complete with the same effect.

As a bonus, these changes also improve throughput of the SPI controller.
For example, this was tested on a ZynqMP with a 80MHz SCLK reading 4
byte samples from an ADC. The max measured throughput increased from
26k to 28k samples per second.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 9cc602075c17..3c96aa9232b3 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/idr.h>
 #include <linux/interrupt.h>
@@ -14,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-#include <linux/timer.h>
 
 #define SPI_ENGINE_REG_RESET			0x40
 
@@ -110,9 +110,7 @@ struct spi_engine {
 	spinlock_t lock;
 
 	void __iomem *base;
-	struct timer_list watchdog_timer;
-	struct spi_controller *controller;
-
+	struct completion msg_complete;
 	unsigned int int_enable;
 };
 
@@ -484,11 +482,9 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 
 	if (pending & SPI_ENGINE_INT_SYNC && msg) {
 		if (completed_id == AXI_SPI_ENGINE_CUR_MSG_SYNC_ID) {
-			if (timer_delete_sync(&spi_engine->watchdog_timer)) {
-				msg->status = 0;
-				msg->actual_length = msg->frame_length;
-				spi_finalize_current_message(host);
-			}
+			msg->status = 0;
+			msg->actual_length = msg->frame_length;
+			complete(&spi_engine->msg_complete);
 			disable_int |= SPI_ENGINE_INT_SYNC;
 		}
 	}
@@ -559,7 +555,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	unsigned int int_enable = 0;
 	unsigned long flags;
 
-	mod_timer(&spi_engine->watchdog_timer, jiffies + msecs_to_jiffies(5000));
+	reinit_completion(&spi_engine->msg_complete);
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
 
@@ -581,21 +577,16 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	spi_engine->int_enable = int_enable;
 	spin_unlock_irqrestore(&spi_engine->lock, flags);
 
-	return 0;
-}
-
-static void spi_engine_timeout(struct timer_list *timer)
-{
-	struct spi_engine *spi_engine = from_timer(spi_engine, timer, watchdog_timer);
-	struct spi_controller *host = spi_engine->controller;
-
-	if (WARN_ON(!host->cur_msg))
-		return;
+	if (!wait_for_completion_timeout(&spi_engine->msg_complete,
+					 msecs_to_jiffies(5000))) {
+		dev_err(&host->dev,
+			"Timeout occurred while waiting for transfer to complete. Hardware is probably broken.\n");
+		msg->status = -ETIMEDOUT;
+	}
 
-	dev_err(&host->dev,
-		"Timeout occurred while waiting for transfer to complete. Hardware is probably broken.\n");
-	host->cur_msg->status = -ETIMEDOUT;
 	spi_finalize_current_message(host);
+
+	return msg->status;
 }
 
 static void spi_engine_release_hw(void *p)
@@ -626,8 +617,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spi_engine = spi_controller_get_devdata(host);
 
 	spin_lock_init(&spi_engine->lock);
-	timer_setup(&spi_engine->watchdog_timer, spi_engine_timeout, TIMER_IRQSAFE);
-	spi_engine->controller = host;
+	init_completion(&spi_engine->msg_complete);
 
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk))

-- 
2.43.0


