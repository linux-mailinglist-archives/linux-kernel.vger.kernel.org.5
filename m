Return-Path: <linux-kernel+bounces-56656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D37D84CD44
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FF128BC88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A737F471;
	Wed,  7 Feb 2024 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qN4fqeWi"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01A7F7CE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317497; cv=none; b=iXprocRx8F3SRySSHE/9bbrR11QdLd9KdyQBJR5eFT/BaOb2UMBsZFRHK7iEnHH2OzvuLj0gCq2csaY10j57KXr9Ib2//mV7XYU/zFo/Vnlr4I/uSC9EpRPU19weH4aGr8GnuW2EihZdHcnA7U65w97qBjvTKi3Je3BfR9bZfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317497; c=relaxed/simple;
	bh=/KvjVNAVg8fzd2VfLqRcK/ChfH3ulQlvhCLvZrUm28c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fyuw2DkjGbv8k8sdgLEXMOzg/aJP3meZXxw6dEGS7iijdyIgj+VBaqLY3Ineo/UPFs2oaiCAF3EnxAFs3GHlbtpw9GFAPs3fxizrWDn604wqaozWb75NL4BKFn9htfdVOD2NPu9OOwPomgD5fMkX35E8Wo37oyouTOmwTY6D2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qN4fqeWi; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bfdd9fa13eso396746b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707317494; x=1707922294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux87ry6fY2cpssDKidx5KVtl6ifmP1x/qZ3f7bi/zmc=;
        b=qN4fqeWiDjzqu4ATPiruymN8hwI3s3lv1Cteb3D4Y2fkng7Wfc5YQ9egRRxnFp4Hun
         KYEm9jqOnweHsnFk/Qrwnt/P2eGXP3PHiSjh2XjbB2+Hyp3Ef/JH51gX9yVfmW/ZKdv2
         TysUh+WcpaXjUGIIvsYviFtXHidY6PateqZZhm91v13iCrV/TI6DJQEmI8KVjoZ+5x/k
         k3aA19RGafIKxr8VmK+DxElWQkUQxuiHnrJCpfuZtV+m+E0uadW90B9H+E2LfLFlV58D
         e8xd/aIfTs0BnOaerubWZhc58WhT8mbT6Dwyg1k3m52B/J+34fah/RztAGfwe4fZ8/yG
         sKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317494; x=1707922294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux87ry6fY2cpssDKidx5KVtl6ifmP1x/qZ3f7bi/zmc=;
        b=RbZqni84BRNrk2yWz4eBhqXR/gDEERhTMZlpDGK6kYg25AEj0RsPHDFoJqan1Jz7Qg
         8YDy63ty43hlqtDHinLtH0K0v1b9bTMGpDAJP6aPFz1FoUkrpaJsKkrmsf/ONM12MDi4
         zOBe8iyEiIAfLedAGLGtVgR1YjX9OdR8xtvyTCcAchLzbCxchF2b2WjA+IKdxM180gUv
         rd7czP+0uZiLOltbXWIeISmx+OwnFYIjtD1SuJhBT3Rc2HxENaEO27ZaIYnLVVi7lLG2
         db7gloZ3NGwntE08YhISEHlKez5pYs7AtgESu+5sPTkXplI8bau6mnqxv3iQfwfxspas
         R77A==
X-Gm-Message-State: AOJu0YzYsaHQaxj58c3nnFLNfhif8/r8pI8zSQgz15OuY01U9ub+AubN
	6nNIwBYO5y7lC0UoLNczGCYfneydIHgffugjaHj4vJDqxilJhcpe6Jo7VfhAELg=
X-Google-Smtp-Source: AGHT+IF49KbxP1ujx11aBVx51qbYUQPqkJU32gXuwc8srgoc4C/ywi4+Fifz6S7CAXtkLARc4Reliw==
X-Received: by 2002:a05:6808:3a18:b0:3bf:e5c0:78ff with SMTP id gr24-20020a0568083a1800b003bfe5c078ffmr5809178oib.11.1707317494328;
        Wed, 07 Feb 2024 06:51:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqvDAiqH+R2x35IJZes3f5w+JgRftkTo/8x70ZulV3Y6q731h2IqDbBbHdyFVWY6YffUKEm+QkuhZZ1Z+/8JcewULwC1pVfUzUJ+afis/0pt0kv4pB/vcTtJfb+e5eFElWqotzWxpg5r7/O2k5hbDYzzJ1Ax6ThUYSD6zgOZeNrqTBxyDbuaOAw7qZsakk3REmKg==
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id k26-20020a05680808da00b003bfe05691f3sm205856oij.9.2024.02.07.06.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:51:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] spi: axi-spi-engine: remove use of ida for sync id
Date: Wed,  7 Feb 2024 08:51:24 -0600
Message-ID: <20240207-axi-spi-engine-round-2-1-v2-1-40c0b4e85352@baylibre.com>
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

Profiling has shown that ida_alloc_range() accounts for about 10% of the
time spent in spi_sync() when using the AXI SPI Engine controller. This
call is used to create a unique id for each SPI message to match to an
IRQ when the message is complete.

Since the core SPI code serializes messages in a message queue, we can
only have one message in flight at a time, namely host->cur_msg. This
means that we can use a fixed value instead of a unique id for each
message since there can never be more than one message pending at a
time.

This patch removes the use of ida for the sync id and replaces it with a
constant value. This simplifies the driver and improves performance.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 6b0c72bf3395..606389566129 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -7,7 +7,6 @@
 
 #include <linux/clk.h>
 #include <linux/fpga/adi-axi-common.h>
-#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -57,6 +56,9 @@
 #define SPI_ENGINE_TRANSFER_WRITE		0x1
 #define SPI_ENGINE_TRANSFER_READ		0x2
 
+/* Arbitrary sync ID for use by host->cur_msg */
+#define AXI_SPI_ENGINE_CUR_MSG_SYNC_ID		0x1
+
 #define SPI_ENGINE_CMD(inst, arg1, arg2) \
 	(((inst) << 12) | ((arg1) << 8) | (arg2))
 
@@ -98,8 +100,6 @@ struct spi_engine_message_state {
 	unsigned int rx_length;
 	/** @rx_buf: Bytes not yet written to the RX FIFO. */
 	uint8_t *rx_buf;
-	/** @sync_id: ID to correlate SYNC interrupts with this message. */
-	u8 sync_id;
 };
 
 struct spi_engine {
@@ -109,7 +109,6 @@ struct spi_engine {
 	spinlock_t lock;
 
 	void __iomem *base;
-	struct ida sync_ida;
 	struct timer_list watchdog_timer;
 	struct spi_controller *controller;
 
@@ -483,9 +482,7 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	}
 
 	if (pending & SPI_ENGINE_INT_SYNC && msg) {
-		struct spi_engine_message_state *st = msg->state;
-
-		if (completed_id == st->sync_id) {
+		if (completed_id == AXI_SPI_ENGINE_CUR_MSG_SYNC_ID) {
 			if (timer_delete_sync(&spi_engine->watchdog_timer)) {
 				msg->status = 0;
 				msg->actual_length = msg->frame_length;
@@ -510,10 +507,8 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 				      struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
-	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	struct spi_engine_message_state *st;
 	size_t size;
-	int ret;
 
 	st = kzalloc(sizeof(*st), GFP_KERNEL);
 	if (!st)
@@ -531,18 +526,10 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 		return -ENOMEM;
 	}
 
-	ret = ida_alloc_range(&spi_engine->sync_ida, 0, U8_MAX, GFP_KERNEL);
-	if (ret < 0) {
-		kfree(p);
-		kfree(st);
-		return ret;
-	}
-
-	st->sync_id = ret;
-
 	spi_engine_compile_message(msg, false, p);
 
-	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st->sync_id));
+	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
+						AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
 
 	st->p = p;
 	st->cmd_buf = p->instructions;
@@ -555,10 +542,8 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 static int spi_engine_unprepare_message(struct spi_controller *host,
 					struct spi_message *msg)
 {
-	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	struct spi_engine_message_state *st = msg->state;
 
-	ida_free(&spi_engine->sync_ida, st->sync_id);
 	kfree(st->p);
 	kfree(st);
 
@@ -640,7 +625,6 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spi_engine = spi_controller_get_devdata(host);
 
 	spin_lock_init(&spi_engine->lock);
-	ida_init(&spi_engine->sync_ida);
 	timer_setup(&spi_engine->watchdog_timer, spi_engine_timeout, TIMER_IRQSAFE);
 	spi_engine->controller = host;
 

-- 
2.43.0


