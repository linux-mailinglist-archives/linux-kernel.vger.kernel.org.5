Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635C75D657
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGUVSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGUVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:18:03 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C017230F5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:17:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso1523933b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689974278; x=1690579078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNTS5THwfPjN5/CdUW2aIKuGB6szZ2gYGFTOCjZzejc=;
        b=Hx0QuExvbFns1+qqw7VVsXj3cp7g+gqUovK10ZK7yHJhDGHq8T8HdnEhBbReqNSnkF
         Jri2kDGnME0Zz5npbk6tjfFRa0ehJsc+TT/eU3sbEMO/xhZxJhvaAf9vL4f4EWH2hXw/
         q3t60+gyiQ5Ushs/BbhJ7aNMcoVAEqIMQBKm87EzxIz4SW5XxpNWFCkPqjve6PCAQZ9N
         Hdsw/rWM+oMG8W4O98NMq3i/XCmePRsIZpgMIemUPFSC0uJyHdeQRFzTjOiS5ZsoP3D1
         0bNWmyJVV+BlzbtyjDrLLsTiQyb/j55pdCqAvSInvBmCSA0qAtAa+D3AE/xr8g/7cHBy
         PwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689974278; x=1690579078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNTS5THwfPjN5/CdUW2aIKuGB6szZ2gYGFTOCjZzejc=;
        b=HyMVXFpLcXAh8reij+BK946VT9IW89Th7oeflyCWCwVaiMW2SsS34kEB/NM7M2PUIx
         lU/4esMYLTylJMBM5t41RU3jPwJ2l9BYp/HNgD1ArqFwNUg8PG57Ry+c3jSjApmwlet+
         fYXc2QdkZAgAOMtInDeJwe+apCIw0Yx80j2/aTOSagXeTWdJY3HLQ+AgJN3JiTvk2xPS
         8n/KMucfBQoDuBOV8609iAyQWxQbhsjXYoK6JHXXetClmnqpxYYQanMc5PnSF4rgh+hO
         Ank3xCtKVWdyzCi7EnjAe5/iZOszFVQ7a6/3cI5Rx2Wc4tOhNdvpFRNrBvWPfcwJgZ2e
         QkqQ==
X-Gm-Message-State: ABy/qLYC0owUvZwwo63TO3L2PWm6F1g7RsfP3vSqBi9Qy3cRjPOGTMm6
        nc1O7IrujB1fPWPqJuofjkk=
X-Google-Smtp-Source: APBJJlHpm4BEYq7/0Hz9S1q6Mmnc2x0aPq57JZXzpKSGigXs3RpbALQcjx3AeaEszSNAAv3pKh/Yug==
X-Received: by 2002:a05:6a00:10d2:b0:680:40b2:5424 with SMTP id d18-20020a056a0010d200b0068040b25424mr1284289pfu.23.1689974277891;
        Fri, 21 Jul 2023 14:17:57 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c25-20020aa78e19000000b00682c864f35bsm3493908pfr.140.2023.07.21.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 14:17:57 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Doug Berger <opendmb@gmail.com>
Subject: [RFC PATCH] tty: keep last tty attached to console ports
Date:   Fri, 21 Jul 2023 14:17:23 -0700
Message-Id: <20230721211723.4082643-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have observed an issue when resuming a UART device that
supports a console where the serial_core attempts to set the
baud rate to 0.

The scenario is as follows:
The systemd software suite intentionally opens and closes the
/dev/console for each status line. When the console is on
/dev/ttyS0 this has the effect that any initial console
configuration is migrated to the first tty_struct associated
with the port and the console configuration is zeroed out in
uart_port_startup(). When the UART is closed tty_port_close()
is invoked and if no other device beside the console is open on
the port tty_port_shutdown() is invoked. However, there is
explicit logic in tty_port_shutdown() that avoids invoking the
shutdown functions of the port when it is a console. The final
step of tty_port_close() is to disconnect the tty_struct from
the port which causes the console configuration information to
be lost. If the device is suspended and resumed after this point
uart_resume_port() will attempt to recover the configuration
data from the console structure that was previously zeroed out
and since the tty_struct was disconnected the set_termios()
operation of the driver will be invoked with the zeroed termios.
In many cases this will lead to setting the baud rate to a
default 9600bps which is often undesired. In other cases it may
lead to division by 0 or something else depending on the
underlying driver.

It would seem more appropriate to me for tty_port_shutdown() to
invoke the shutdown functions of the underlying port so that the
serial core layer would have the opportunity to preserve the
current termios settings back into the console structure. There
is logic in uart_shutdown() to do this, but in this case it
would be more appropriate for that code to be moved to
uart_port_shutdown() instead.

However, the logic of tty_port_shutdown() appears to have been
explicitly changed to have the current behavior of not calling
shutdown operations when the tty port is a console to prevent
another issue (I believe in ttyUSB) so I don't want to propose
this solution without a better understanding of why that change
was made.

As an alternative, the tty_port_close() function could leave the
last tty_struct connected to console ports as suggested here.
This would allow uart_resume_port() to recover the termios
settings from there.

Please help me find the best way to address this issue.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/tty/tty_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index a788a6bf487d..18c96b153815 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -721,7 +721,8 @@ void tty_port_close(struct tty_port *port, struct tty_struct *tty,
 	if (!port->console)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 	tty_port_close_end(port, tty);
-	tty_port_tty_set(port, NULL);
+	if (!port->console)
+		tty_port_tty_set(port, NULL);
 }
 EXPORT_SYMBOL(tty_port_close);
 
-- 
2.34.1

