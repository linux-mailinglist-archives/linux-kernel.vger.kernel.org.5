Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC0C7AD3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjIYItM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjIYIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:48:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC56C0;
        Mon, 25 Sep 2023 01:48:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fdcc37827so5055110b3a.0;
        Mon, 25 Sep 2023 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695631727; x=1696236527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa6uFbknqzj199lmh6a4GX+0E1qDjG74urk1D5Bo0C8=;
        b=KoVFIylw9Ffdbf0MPUb4AVzbVAkRiVgE8itnC/b7+l1fEC+zWCSJ1ycMnMArbgYynv
         1q6w63Ijkp9aQvwTRrzu+GnDJn5RsW4dvZMTz60eZX7j206ysiFZ4ylE30fW/pesnbwv
         xOR0+GrsHF45zacF6Ww0duyRha/kUQQj348NaZR8G5WViWjpLsjR/Tggcd9qwL1cMd2X
         WZ+1g1uSx/EKLNAfCoWV0SStfCwBKp5swb34uMxNK2z/bzqM5x+4q7Qmb50BBNCHHKhA
         azVe/2pydS58zXm/AbA2zSvxx8AwzzPCL8bk4Ov+TWGTqqqPZ/q0tMASiU23PGOUbUL1
         KmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631727; x=1696236527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa6uFbknqzj199lmh6a4GX+0E1qDjG74urk1D5Bo0C8=;
        b=GEaZ5fGP6Ipu/uoq0zMGd+iRG1aq4kyQggLj9haIQpU5z9xWaobdDy/8VzK4uy3MC/
         LC8zqlH1SMcAAi5cmyOiicbFqzUFw2uKe5QB94DbFVFCEUQH3vcj9U6hHQO+S44eZMTO
         a3GJxSUcPZXMam2QD8XBEcTqFueJNoObJqK9fh8BJlEnVrUbnyCXSOqVP2o4lAQ2XTgx
         EKoV5s4OjccWeUBOd8Exqt7JZIAOCv1WAoimHUo8Z4OcmVH+/KlD1spsTLyT7PkhG+g+
         g5hKRmS7vfgDOa6ohlasR3YNhkaU57+3Y3WwaMiY7rgdsWxH7lFBWoXXlb440v1oAOHL
         vUXw==
X-Gm-Message-State: AOJu0YzYrIyB0PNWrpi0StOw5Fwhh50i9CLR3Gd1IxGrv7JHyaZ13JAz
        /Hyc8mP5VcSRCWENsZkWtEZ1H0MkR6o=
X-Google-Smtp-Source: AGHT+IHo7YQXy60TF3U/ZHqmijuB8Jn7bkioepae2MbCkiWaX2sBluLP9B5ctJp56zZEQugh1jMD4g==
X-Received: by 2002:a05:6a20:1587:b0:15d:1646:285a with SMTP id h7-20020a056a20158700b0015d1646285amr9403726pzj.21.1695631726991;
        Mon, 25 Sep 2023 01:48:46 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:bc97:e554:1bd8:be33])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b0055c178a8df1sm7406376pgd.94.2023.09.25.01.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:48:46 -0700 (PDT)
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
Subject: [PATCH v3 1/5] serial: core: tidy invalid baudrate handling in uart_get_baud_rate
Date:   Mon, 25 Sep 2023 01:48:21 -0700
Message-Id: <20230925084825.4160708-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230925084825.4160708-1-jcmvbkbc@gmail.com>
References: <20230925084825.4160708-1-jcmvbkbc@gmail.com>
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

