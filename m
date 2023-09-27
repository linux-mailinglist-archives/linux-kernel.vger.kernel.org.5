Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9037B0BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjI0SUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0SUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:20:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A70DD;
        Wed, 27 Sep 2023 11:20:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso10583675b3a.1;
        Wed, 27 Sep 2023 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695838806; x=1696443606; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5B3VoFkvJ3Kkt4BU0WJl0+BQwyfXbEUUwHbI2QcpnY=;
        b=VZx/EnM4LZvLKx4s3I8N1dV8XMMsHCwpvk7hiLNLj2c2LAbuc+t+PlAKrr4nNQUl5x
         9yqczm7PA/7/ahTliaV6GL4zEkBpqg+fGJOEE1euAzYff+CQwCtKDOyUHneiiJmUVNj9
         BWj2f2WoCAOJIrb9N7hLaJH+szfnRTmGmWgdIe5qLYH928eTz5j88QbmLE/3MF2OS1HT
         UuJpsOL5cVAJW3rEHWvj/N4+TBN2esVI6hWszVdtn6R5ZATjB3T35/Rhqe6nKqYul00C
         tLX9ROMzWAu3qmqAXe1e1YhmrLLdmuVaktNyEVfPhjZ8s8qeqhrjVs5yYexjzqvzMC/6
         2FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695838806; x=1696443606;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5B3VoFkvJ3Kkt4BU0WJl0+BQwyfXbEUUwHbI2QcpnY=;
        b=alsD4ckMwW4RbcVLFJS0XEfw6GGhYmRL3A+GToAOQm8tGNbjYIFI+YoBYzn05sNqPS
         QQwCai3DCh9MlyGpM5vDjWemdeO7y0ZIhmbF1qy4bLzYGovHgbohcX91grKdIHbkRHcH
         7Wf6kKXWCSBe0XIixocJiJgU0cCKf6i3ts/t19Gsf3Tsevxr09Hb1qs0WJja1igfsrq5
         62mvE0L57ec9cHYPl0ZfpzEQNREzWwublpqpdzE8tpCAHsaZUEFOGx75IdgeYsWHnFZl
         ql3qMZruKYof8uO6oiBo/+pKTR7XV33ID6kEQbEAZ6fh/eRqFLi1Tj2PvV13rekOtWPG
         uW9Q==
X-Gm-Message-State: AOJu0YyOPeMTMjR5UgjwTk6WeyAe0IaAqXDAhpVZ92LNAXOAHu2uIy+/
        UHQUZyx/ZZf4oGD1GYm2CZc=
X-Google-Smtp-Source: AGHT+IGwuIFY5ERDx4cHwOm/e+K0VXyYRtVSOWopBVjwpR89TArQj9id/SpVD4k2iqu8pe/g4IRmpQ==
X-Received: by 2002:a05:6a21:2728:b0:15e:96d3:a31b with SMTP id rm40-20020a056a21272800b0015e96d3a31bmr2432976pzb.39.1695838805878;
        Wed, 27 Sep 2023 11:20:05 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id x6-20020aa793a6000000b0068c006dd5c1sm475047pff.115.2023.09.27.11.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 11:20:05 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        sorganov@gmail.com, festevam@gmail.com,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH RESEND] serial: imx: Fix potential deadlock on sport->port.lock
Date:   Wed, 27 Sep 2023 18:19:39 +0000
Message-Id: <20230927181939.60554-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &sport->port.lock is acquired under irq context along the following
call chain from imx_uart_rtsint(), other acquisition of the same lock
inside process context or softirq context should disable irq avoid double
lock.

<deadlock #1>

imx_uart_dma_rx_callback()
--> spin_lock(&sport->port.lock)
<interrupt>
   --> imx_uart_rtsint()
   --> spin_lock(&sport->port.lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_irqsave()
on the &sport->port.lock inside imx_uart_dma_rx_callback() to prevent
the possible deadlock scenario.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/tty/serial/imx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 13cb78340709..7bb3aa19d51c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1165,13 +1165,14 @@ static void imx_uart_dma_rx_callback(void *data)
 	unsigned int w_bytes = 0;
 	unsigned int r_bytes;
 	unsigned int bd_size;
+	unsigned long flags;
 
 	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
 
 	if (status == DMA_ERROR) {
-		spin_lock(&sport->port.lock);
+		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_uart_clear_rx_errors(sport);
-		spin_unlock(&sport->port.lock);
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 		return;
 	}
 
@@ -1200,9 +1201,9 @@ static void imx_uart_dma_rx_callback(void *data)
 		r_bytes = rx_ring->head - rx_ring->tail;
 
 		/* If we received something, check for 0xff flood */
-		spin_lock(&sport->port.lock);
+		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
-		spin_unlock(&sport->port.lock);
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 
 		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
 
-- 
2.17.1

