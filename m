Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4F07A7054
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjITC1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjITC1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:27:07 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194DC6;
        Tue, 19 Sep 2023 19:27:01 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59bfb0825efso57102217b3.3;
        Tue, 19 Sep 2023 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695176820; x=1695781620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa6uFbknqzj199lmh6a4GX+0E1qDjG74urk1D5Bo0C8=;
        b=jBHiTZ+Ex9586TBVmGyUZ86g8+TpbQADy+uujvG4Zrl9cnZhpW0QK3bZnvoTq/fdPY
         kZ1zkZQSImAtuudl3VidbXQIVIuvizyS7sQ7kD/KVnkL3ppJwTyxxrAXXxgfXfaFfWMM
         P86DQGZjQntWNN8uwVQ5uDlPdMnz/L3Wy4wP3+upZ2pNyQFU9t2GcETWhAg93VfZ397n
         32VjdPHWZ5cZ4hgmR8Uxh8pb9TCQCXF2H7aQBhFrYw+Wlg1u7OHAzOXxDrDnE2+xulsD
         YmLeKoeQ+HCldAphaX9aHS5OPPD5g9q4zk8Ff2Eev5ZbzbsGP1VSoI7xNU6/Ih26++xf
         aymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695176820; x=1695781620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa6uFbknqzj199lmh6a4GX+0E1qDjG74urk1D5Bo0C8=;
        b=JOp9D6FNteVz0reV41tSWLnofwJKcvDg43Z6FIYVHy0x1+8Nl0yAD18Acmqzv9109M
         LDuF0Q6Gfj8JPZ3y/7gJLEMItxQXBefLMlMO3C0idwJHf/dfxh/ObZY/3oxML6XT6GC5
         eTHM1wKc2u0tC3dKB6GgiIT+ivhQh/ky8TEo2qh7VKWyVsGa3jxkBajb59yH4nfg5bLB
         zLxvK6yK5z1oQD9t8MQf4iJHgwfBDasd0d1wbFwV4PfAmfngj6iywPGMQ9inPxiandMN
         uuaK9M33OIIIRM+SFj7dNaA44f3v9R6eE6GK0UdRfX5pzYjeDnHWwip5K4seueeGs+GB
         Vvog==
X-Gm-Message-State: AOJu0Yy7T2sue3QP6WzuyE3hzoCFkCRZkafjr4gNLlP52IXgNRsn8ZoB
        0b0xuGrGK+eY4Cxwg1zGFHdjNmwawds=
X-Google-Smtp-Source: AGHT+IGwKPQbxyEfkP/aZBBjvXtn+yd7aQ+6l1naTAE2GWBkNfDrKJJVkREFeJTh6b3KgDqgmIcWCQ==
X-Received: by 2002:a0d:e84f:0:b0:59b:cde8:fc35 with SMTP id r76-20020a0de84f000000b0059bcde8fc35mr1366263ywe.24.1695176820490;
        Tue, 19 Sep 2023 19:27:00 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:9ca3:318f:421e:68cb])
        by smtp.gmail.com with ESMTPSA id p15-20020a62ab0f000000b0067aea93af40sm9224757pff.2.2023.09.19.19.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:26:59 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 1/5] serial: core: tidy invalid baudrate handling in uart_get_baud_rate
Date:   Tue, 19 Sep 2023 19:26:40 -0700
Message-Id: <20230920022644.2712651-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_get_baud_rate has input parameters 'min' and 'max' limiting the
range of acceptable baud rates from the caller's perspective. If neither
current or old termios structures have acceptable baud rate setting and
9600 is not in the min/max range either the function returns 0 and
issues a warning.
However for a UART that does not support speed of 9600 baud this is
expected behavior.
Clarify that 0 can be (and always could be) returned from the
uart_get_baud_rate. Don't issue a warning in that case.
Move the warinng to the uart_get_divisor instead, which is often called
with the uart_get_baud_rate return value.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/tty/serial/serial_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..a8e2915832e8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -431,7 +431,7 @@ EXPORT_SYMBOL(uart_update_timeout);
  * baud.
  *
  * If the new baud rate is invalid, try the @old termios setting. If it's still
- * invalid, we try 9600 baud.
+ * invalid, we try 9600 baud. If that is also invalid 0 is returned.
  *
  * The @termios structure is updated to reflect the baud rate we're actually
  * going to be using. Don't do this for the case where B0 is requested ("hang
@@ -515,8 +515,6 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 							max - 1, max - 1);
 		}
 	}
-	/* Should never happen */
-	WARN_ON(1);
 	return 0;
 }
 EXPORT_SYMBOL(uart_get_baud_rate);
@@ -539,6 +537,7 @@ uart_get_divisor(struct uart_port *port, unsigned int baud)
 {
 	unsigned int quot;
 
+	WARN_ON(baud == 0);
 	/*
 	 * Old custom speed handling.
 	 */
-- 
2.30.2

