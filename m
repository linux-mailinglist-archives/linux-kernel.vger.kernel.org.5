Return-Path: <linux-kernel+bounces-146800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226068A6B28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C7B1F21BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48612BF24;
	Tue, 16 Apr 2024 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ICedfnS+"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442D101D4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270957; cv=none; b=fqJ7B4vWT33DSUR9TOT5teacX/U9fVfvzEQmkV0xCYYE2WKHnSF82slv8+sD670DTHGlKw7wSnxyjip40baEQb/jzvY/xEKEqEt0P9vOYvEQX5bdQZIhYgoreus5smEDK8MmMqiR5mU2UA2rfXziGqq2IRuaoy7VSWaTzvvE4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270957; c=relaxed/simple;
	bh=kRk3QnAZ3qr1PcFUmSrslq3HTppGMx2/2WOyXWDOFfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rE9IZAC1lGKnW6upqdx4RCo1dX0FQkqooojSaXDUTbzi0PWMul+wFGjfJFiQvDIql8T9LVqbnXaiVo3EcUpna0ggM5sJ1cVzEnmke3dnhSQR+jPdDLJj/STMuIN3NiEh3VkNx7aSczUuU4xuoGDILlIlPk5wPyiuqO9cJpiZ268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ICedfnS+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=rK8csEqpyjcNZo4plK8L+bE/v5scXoLguzVWeStfOtQ=; b=ICedfn
	S+Hq8mdLli3RH2Ar+6cfnLlqR62/BKNyOQQhwLDCNXm8LgM/lMJ8e+kSrqceYg5m
	wHZWDf3zqOAmXTbvo4zzS9Hjr/WF/G1QxgDD5j1lff9QqSgPKdRDdnYig12OiiYM
	k/lbxgmWbTdMcI0W/nOoXxuMfAaG0QnIAjvkqYz6UWepdQijbbDEIcsQjXK3DoZk
	le7OECG5gb+gwPZ4Dm36dvVxss8kAouoM6BffztLAIhJpiA58RS50TRu6exjSbTh
	zZHg2CPyMfBzU/IeMCVyCjzeuU8mUbVa4oVAz67mvp6wFgjFJqmtGpOVT2UBH3s+
	mk1PvTIskR0clTKA==
Received: (qmail 2408539 invoked from network); 16 Apr 2024 14:35:53 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Apr 2024 14:35:53 +0200
X-UD-Smtp-Session: l3s3148p1@otaM+jUW7psgAwDPXxiyACzheF6dGXh7
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Aleksandar Mitev <amitev@visteon.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 2/2] serial: sh-sci: always cancel hrtimer when DMA RX is invalidated
Date: Tue, 16 Apr 2024 14:35:48 +0200
Message-ID: <20240416123545.7098-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416123545.7098-4-wsa+renesas@sang-engineering.com>
References: <20240416123545.7098-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear the timer whenever 'chan_rx' is cleared to avoid an OOPS.
Currently, the driver only runs the timer when 'chan_rx' is set before.
However, it is good defensive programming to make sure the hrtimer is
always stopped before clearing the 'chan_rx' pointer.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Closes: https://lore.kernel.org/r/ee6c9e16-9f29-450e-81da-4a8dceaa8fc7@de.bosch.com
Fixes: 9ab765566086 ("serial: sh-sci: Remove timer on shutdown of port")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Locking needs to be double-checked here. This patch is mainly calling
for opinions.

 drivers/tty/serial/sh-sci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1e3c26c11c49..5ad73933c1c5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1262,6 +1262,7 @@ static void sci_dma_rx_chan_invalidate(struct sci_port *s)
 {
 	unsigned int i;
 
+	hrtimer_cancel(&s->rx_timer);
 	s->chan_rx = NULL;
 	for (i = 0; i < ARRAY_SIZE(s->cookie_rx); i++)
 		s->cookie_rx[i] = -EINVAL;
@@ -2242,14 +2243,6 @@ static void sci_shutdown(struct uart_port *port)
 		       scr & (SCSCR_CKE1 | SCSCR_CKE0 | s->hscif_tot));
 	uart_port_unlock_irqrestore(port, flags);
 
-#ifdef CONFIG_SERIAL_SH_SCI_DMA
-	if (s->chan_rx_saved) {
-		dev_dbg(port->dev, "%s(%d) deleting rx_timer\n", __func__,
-			port->line);
-		hrtimer_cancel(&s->rx_timer);
-	}
-#endif
-
 	if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0)
 		del_timer_sync(&s->rx_fifo_timer);
 	sci_free_irq(s);
-- 
2.43.0


