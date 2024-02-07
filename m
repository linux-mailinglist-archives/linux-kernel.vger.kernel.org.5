Return-Path: <linux-kernel+bounces-56658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D53B84CD46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7ED31F28BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572727F7FA;
	Wed,  7 Feb 2024 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SfKO0Saj"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A307F7D4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317499; cv=none; b=RaXuL0AtjB/FIUiG19fKAbquTS+OhOGq+Al4wACbsEYSsog/UK69Zf8s6KvREcK8+Mup/cCiZhTMp1cwLqoBOCDBCJAmb9KtiBj3FdE27M6Cky6gODd/uLXczIimcSvo/+aX2Nyp32cvJF5I6g3zTBbmK+A3VG10SeQDafUle6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317499; c=relaxed/simple;
	bh=0+mHBIiTkYE/oE5w4LgHz44U2EyulKRFEiitlg4y6SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqy+YPfq6e6jYnGFbm/tSm7NfpKjn8Ym4jJJIlUeyToXdAt9vp46kocoMruozZRsJ1OjPL50Uis0MoLwEIWpLZRuEcnxSFqIEBn6Fj6ImHleKASy3/Czyv0LQ4m8O4+DIJlSDVsUjAOFzdemer+UFo/QcA7n98v0M2daaEWWuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SfKO0Saj; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bfedaaeeacso313377b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707317495; x=1707922295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao4b426B+NqhtR2ZLveczs7D6jYQ4PDxIiN9DLi59UM=;
        b=SfKO0SajEh8wkzzi49/Z/jenlkww/rCxmmE0xjtno9GLLTnCUCmA5XptA/2tmbA6eN
         gMVNo9QXwVC6OR9y3EmO0DmeRzk4ID6aTCZ7lqZ360u+dNYBXVZMI5jXMZThfafszlka
         VU1fbsIREk6RC8Ht/l0AburR3t6t33KWxfoXS1nk1WSqjyxgSqZfBQPWa0S95DU3sGNq
         OZt2m/6LdKzIKKdcSUPjlrPRM14tRNtRSf7wt7As7LMYlMXUQkJIWh4TuvamovKR+2wL
         tlQBBE2o2kbmzO4iMvJQv4qfo2e991FvPF35WlVv2qtdSucwi8HHDZxaHVrxOWUUe+0+
         FiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317495; x=1707922295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao4b426B+NqhtR2ZLveczs7D6jYQ4PDxIiN9DLi59UM=;
        b=n9rcwJueTvmj2paawB/92/Ix710pTH6iuj7HSHi7MgeFb2EzIRSlkCCxYTmu98t3O8
         PCsfp77Qg3mIm3hxBsxsnGOaSRGglAZcMhkioWIQS+gZvXQhi41GVs3LcqskscY1e37A
         qdR4x0BgV6FCxw5nNSiV/YV18Nvj1YiawiVntfwHb8ALvqYtk3//3U6l9aJLMd1Myvh4
         9K36ACEUEheV5dPJPaAecAJZL06+myD+f0DVJW07XETDtvNhZ4hOavQ3mIqvHrm1Hcn1
         N89hPEk5UEM3aSOKnkjuAuRj4f4A9q2b+vg/r1/bJfPuJc9TE6EwHZjm+HeqInIcKqdC
         RhHw==
X-Gm-Message-State: AOJu0Yx5W6M5X5ktiPcIW8/BDFPgIjb9bXjf76BF+f7rIkxEEx3f2A5K
	V9nvfEhDg6OlPTP6As3pA/b4aLimo4jV2iCP5fOTG3jJFQ8RPlRlCSvb5QdUB4Q=
X-Google-Smtp-Source: AGHT+IFt1hk8IAKsEiD0e1klvGA3tToEnwzCEKm9KzLSPtRhka6wNhZY3w9aUdnseQ8NAhk90UUQ0Q==
X-Received: by 2002:a05:6808:148f:b0:3bf:c0bf:dcbe with SMTP id e15-20020a056808148f00b003bfc0bfdcbemr6905308oiw.6.1707317495045;
        Wed, 07 Feb 2024 06:51:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLWnHSxUKQJVXie5Ik3MB+TQiaqcz1HhlWz0ZIolbZ8d5MjZsPMBjdjuBlEyvYEV9hmcUYI3A6WhLhJ3UB18tVhk5dSUuVcXISc7uHgUsnj9p5SjOQHUt7ezv0Idw9AcZPD7YQQctoYLmOIvUrrjPIbVOWG+FYPD3F6TAZranWfoBRgWYpH73seilUG3MVCcpGDg==
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id k26-20020a05680808da00b003bfe05691f3sm205856oij.9.2024.02.07.06.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:51:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] spi: axi-spi-engine: move msg finalization out of irq handler
Date: Wed,  7 Feb 2024 08:51:25 -0600
Message-ID: <20240207-axi-spi-engine-round-2-1-v2-2-40c0b4e85352@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207-axi-spi-engine-round-2-1-v2-0-40c0b4e85352@baylibre.com>
References: <20240207-axi-spi-engine-round-2-1-v2-0-40c0b4e85352@baylibre.com>
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

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 606389566129..ca66d202f0e2 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -13,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-#include <linux/timer.h>
 
 #define SPI_ENGINE_REG_RESET			0x40
 
@@ -109,9 +109,7 @@ struct spi_engine {
 	spinlock_t lock;
 
 	void __iomem *base;
-	struct timer_list watchdog_timer;
-	struct spi_controller *controller;
-
+	struct completion msg_complete;
 	unsigned int int_enable;
 };
 
@@ -483,11 +481,9 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 
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
@@ -558,7 +554,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	unsigned int int_enable = 0;
 	unsigned long flags;
 
-	mod_timer(&spi_engine->watchdog_timer, jiffies + msecs_to_jiffies(5000));
+	reinit_completion(&spi_engine->msg_complete);
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
 
@@ -580,21 +576,16 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
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
@@ -625,8 +616,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spi_engine = spi_controller_get_devdata(host);
 
 	spin_lock_init(&spi_engine->lock);
-	timer_setup(&spi_engine->watchdog_timer, spi_engine_timeout, TIMER_IRQSAFE);
-	spi_engine->controller = host;
+	init_completion(&spi_engine->msg_complete);
 
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk))

-- 
2.43.0


