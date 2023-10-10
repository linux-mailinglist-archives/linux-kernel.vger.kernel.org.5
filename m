Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8167BF6AA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjJJI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjJJI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:59:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7252CA4;
        Tue, 10 Oct 2023 01:59:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-58916df84c8so3414075a12.3;
        Tue, 10 Oct 2023 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696928377; x=1697533177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJQrTaJjPi0Je/kfhPU0DQ5oya5Qf9MZSqPuDbE0Nms=;
        b=ahQYp+b+SNyVKnOGaEF2d3hq7fuYdVWGQHAS7MjB19zTF75UCa+UYJBVb3EH2Cu2+4
         lqAXijhW9dmZvBs8bnasx43/nqQ2oIbMb4Rnu019BvxPKLAa3uEezxRJA1fMtrtsZguf
         aJqENAPnoTh0KkG2Z1RZ41pyNkvH5Zlc4LIXWIm4tgVbJivI7BhMoqn3tswLExWugqst
         W0Mcy/OKtlAdLlzjB8QvB9bIobBe/0FO46qYasn7Xnw0AaIreldQLRW6GZqmPk82LqXK
         2h8XXrPEeDxjVvDqhsiWPLSO5mIOBJCdVS9Ob/H7wZYLaVT/cMHwU/sSpEKEj5bCruyX
         6B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928377; x=1697533177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJQrTaJjPi0Je/kfhPU0DQ5oya5Qf9MZSqPuDbE0Nms=;
        b=Jqkk7d+JfpGNfbJU3oJGes3FknhpSvahY8CG2d4JMv5THeI4bkMvus4ynwykPhencm
         h0K/7KbX/iXSjlNc0em8OQfPBdskasRvJC99GB+sa5YmSQ+Z4DjKL+uXUZlO6UKZCbCx
         4ht2gQEI+ih3STIPK1E6GMGj4qe5rt9zI13lr0TJltYWPPaxBc+kXKTsseOLrwsushkt
         sf/66bfLBtAUuijDUgNICbi4IWCsOq9ygtqcG+K1qRMRSGnww0Y3v7uONEXi9WAgagVu
         Epgmrvq4DchrQ1r9ILOw4c7XOE2q/FnwmQdn+txrg9p+5cazQpQQqlXy/Cmohlm6sns/
         0p0Q==
X-Gm-Message-State: AOJu0YwT0A/qArtKQNz8jUq7J7AF8fEhM3C9xWlTkXvOpqhRySFbfB6M
        TQW3yfYNIK1sWW/pXftgnq8Rs+wnchQ=
X-Google-Smtp-Source: AGHT+IHiDzgTslln6QB9BjU5V4YxjCpd8q1lMFq/5OF/t2L4x4RwUoLdTLB8v/D8FsZ4ezkuvTZhdQ==
X-Received: by 2002:a17:90b:4b86:b0:279:e5e:ea1b with SMTP id lr6-20020a17090b4b8600b002790e5eea1bmr15363646pjb.5.1696928377627;
        Tue, 10 Oct 2023 01:59:37 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:f462:7ab2:1aaa:db73])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a3d4c00b0027782f611d1sm12542731pjf.36.2023.10.10.01.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:59:37 -0700 (PDT)
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
Subject: [PATCH v5 1/5] serial: core: tidy invalid baudrate handling in uart_get_baud_rate
Date:   Tue, 10 Oct 2023 01:59:22 -0700
Message-Id: <20231010085926.1021667-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231010085926.1021667-1-jcmvbkbc@gmail.com>
References: <20231010085926.1021667-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
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

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v4->v5:
- fix commit message

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

