Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C52E7B214C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjI1PaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjI1PaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:30:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C38AC;
        Thu, 28 Sep 2023 08:30:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-570a432468bso10819349a12.0;
        Thu, 28 Sep 2023 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695915016; x=1696519816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USo4wRG0tKgJ2qeKHabBE6AhpAZ7DR66yrvaU6oGcec=;
        b=AWwCq4xsLU0qAmwirSv+y2wkqOCv1vIhFw9CP0JdrIvF0Ci03uID9XiQ6rtZ56GUey
         34z9oAmyFYc9t8DBAzdmXrLyOr0Udac9iq/o6plNGv6cZehdObmxCU0FdGWrP7aBQEjC
         WXnBiKM6VGevw8oMJD0sHXtpEDQYnVNjHkFi58/+OQzzGCbMA/EnSMK5fEABlePRQy18
         ViSem7eTZRiVXVSb4+dH7R/nXv1LwJ8QiKgBidohSEg1Qxm/xBzxiOBivEVti5jdUuN8
         nphtZduzaOvb4Q9phpiXe9Y2LIKY46wh8c7yGBHYfaKcbyZun5exh1YnSoLHzZgX0rxi
         0ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915016; x=1696519816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USo4wRG0tKgJ2qeKHabBE6AhpAZ7DR66yrvaU6oGcec=;
        b=kVCKXmi9EFArSWKgFo9e8oyJD2VBoMXeEjoUUqRqEsebvhLXiUja7GwmD9HwnXchbA
         lTi6fpgtj9CMWMuY8IQ3QJ+xPrXf0sL+T0xg91ju/pd2G9bS2i5jYycy8ItPJwyohWh/
         7KXFwG+erze1tsdo3cNuuN+OcTSDt0Xc07FEnB0c9ZkTLlgnEOloPBLnr4LuYjfmA64A
         r9XBvYZBwj+ioL8igi895/MHsI6mLz2WPWcrgnmKMmqBNjhUf7pLrV44Jr7ZDGWficTv
         RnCa6eqD6Lwe+mdy3k/7y7qcczrbp9gA0FwhwhMU2LN2hr2f5SEdPR/xXm1Aokn38g0Y
         aBWg==
X-Gm-Message-State: AOJu0Yz+9WqiTZa7IKPbSnYqdXUPz46vScChjpnnPILlDEi5Cx9B6MzX
        PsGUuV6jy9mm8hy2hu9wxgUzZYFJQFg=
X-Google-Smtp-Source: AGHT+IESra6vuvk+hflCFcrBbaCinaKDc26/Cs0BqMmhB1cri/ZPa03TJv+TPzKPkalUbjtN7CMPNQ==
X-Received: by 2002:a17:90a:fe98:b0:279:e19:86db with SMTP id co24-20020a17090afe9800b002790e1986dbmr2568851pjb.8.1695915016137;
        Thu, 28 Sep 2023 08:30:16 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:a19c:f3d0:698d:f7a])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a414600b00274a9f8e82asm3892318pjg.51.2023.09.28.08.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:30:15 -0700 (PDT)
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
Subject: [PATCH v4 1/5] serial: core: tidy invalid baudrate handling in uart_get_baud_rate
Date:   Thu, 28 Sep 2023 08:16:27 -0700
Message-Id: <20230928151631.149333-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230928151631.149333-1-jcmvbkbc@gmail.com>
References: <20230928151631.149333-1-jcmvbkbc@gmail.com>
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
Changes v3->v4:
- drop WARN_ON from uart_get_divisor()

 drivers/tty/serial/serial_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..3f130fe9f1a0 100644
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
-- 
2.30.2

