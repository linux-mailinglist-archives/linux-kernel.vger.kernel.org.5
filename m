Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C480E1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345954AbjLLC33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345727AbjLLC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:48 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521CDC;
        Mon, 11 Dec 2023 18:28:38 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5c85e8fdd2dso50587807b3.2;
        Mon, 11 Dec 2023 18:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348117; x=1702952917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ2PLGJf5O/y/fYo5hj+s9entphd8dP6/+b2EP37z+g=;
        b=fK45JuyVji7HIaxL2jT7ItpOqf4xNYhdluBt1WippgC+8ltzMgx452lFW3unig98eM
         b4TBiySBb1nTJhwuVzodldo9a5gX8aC1+4MV0x8CMPatkgzdvaOcrCgqfhs+kh4igBEX
         8p6orQwI3+zQ87U2xPfXSsWx77oPfJR5YusUtKHCFrLPKYfgFErm4jIyLxfV5lJwgYGA
         r2/NeVA6Fj3IoD6XWYQFHcsM8cZo001PXWch5ijWEtz1t7QbOpudZnxWKpwaTEuOsc8L
         9m3yg37OGJb0COJ9WwZ0grxFrY4YQEGn2t2uUhw/CsVSFRZOyP1XSah/B26kNgXtLz9m
         246Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348117; x=1702952917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ2PLGJf5O/y/fYo5hj+s9entphd8dP6/+b2EP37z+g=;
        b=ka+10wyBpw247uio6rbsK6bycRN9M/0vmRKR1jvku2aInHLHG9Kixk0u0gDFe4Uj24
         rGZaROmcHNCW3d9fPSbhoM3Ny7ib58yQWSZw595PX9hgSqqiZJkpRmPFww4UT8CzBhHx
         hjSZibUJZDvq3eYG9RriaF8VKvNGcOkRrL/gdWZAhwAYvwZLwk6Xf5dKNgskftizcKja
         als3DEw8EpJ+2fDXoaHxTEtpOb5aqEvij9kIoP7Do6bioMJ3N7VizcI2IkorB1NvgSZT
         IedmBxjU0QQgz1S3Fo6d0jJseVrgJrs52O70QcCv30dsiodxxqj79gpR0/hTuWcJLyrR
         o8mQ==
X-Gm-Message-State: AOJu0Ywn7Cg619s3SgLTB9/I7wX4u3J2Vd4PjVRWMlOvfKh0yVbpoklS
        JMe4SWvN2QYZ/531F8Fn0ptzZkosayvgUA==
X-Google-Smtp-Source: AGHT+IFVVkusrEqfGlllJZMJGaQHJxP2yzg9OjmOI/Ze7n3Lz5dErcjkdvmjbGkgcU6bmEuOceHhWA==
X-Received: by 2002:a81:6cc4:0:b0:5e1:fc32:6f2b with SMTP id h187-20020a816cc4000000b005e1fc326f2bmr58743ywc.17.1702348116699;
        Mon, 11 Dec 2023 18:28:36 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id j2-20020a0dc702000000b005cf1ce8b96dsm3435640ywd.5.2023.12.11.18.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:35 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hui Wang <hui.wang@canonical.com>,
        Isaac True <isaac.true@canonical.com>,
        Yury Norov <yury.norov@gmail.com>, linux-serial@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 29/35] serial: sc12is7xx: optimize sc16is7xx_alloc_line()
Date:   Mon, 11 Dec 2023 18:27:43 -0800
Message-Id: <20231212022749.625238-30-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of polling every bit in sc16is7xx_lines, use a dedicated
find_and_set_bit(), and make the function a simple one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index cf0c6120d30e..a7adb6ad0bbd 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -427,15 +427,9 @@ static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
 
 static int sc16is7xx_alloc_line(void)
 {
-	int i;
-
 	BUILD_BUG_ON(SC16IS7XX_MAX_DEVS > BITS_PER_LONG);
 
-	for (i = 0; i < SC16IS7XX_MAX_DEVS; i++)
-		if (!test_and_set_bit(i, &sc16is7xx_lines))
-			break;
-
-	return i;
+	return find_and_set_bit(&sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
 }
 
 static void sc16is7xx_power(struct uart_port *port, int on)
-- 
2.40.1

