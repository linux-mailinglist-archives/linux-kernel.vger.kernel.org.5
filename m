Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D0D7AA8E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjIVGPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjIVGPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:15:51 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B36197
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=nGiTOBkXg0QBYNNKE4GjU+gPswwukGG0RFc1y0f8fGU=; b=WJj01S
        aViU5JPWr1bKFd1swE8SLjVGyswEKVVFC054eqFF8ijl3j34fim8fec4qrwnQ2Wx
        jPio/PtCpg2qbTbYlA3GXv2jOKvZ/t1rBU/p981kpUfJ3T/ZTmSrLh3xQyz6hmfk
        tCqcMVAwp5zX59OE0kyPtYJ2lH4de5DsTB31AttO5Ic0KuAxHlcHR51EOpAUKEpq
        V76M7i7cRcdPWif5aAQuttwjy+/fnMoKeo5MAbqzpDc6BrrGxpU4Z/hUaCcOxxKM
        y0XlUUw/1LNJfEP9uEX8R/KkAiR3x9Tfsp4esgKSG5VMBZIDn9gpigrMp65AWPy6
        ivAkuJD/COMIHwDw==
Received: (qmail 1269022 invoked from network); 22 Sep 2023 08:15:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 08:15:40 +0200
X-UD-Smtp-Session: l3s3148p1@2qKjiewF8JkujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 1/6] serial: 8250: remove AR7 support
Date:   Fri, 22 Sep 2023 08:15:22 +0200
Message-Id: <20230922061530.3121-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AR7 is going to be removed from the Kernel, so remove its type
definition from 8250 code. As with previous removals, I checked with
Debian Code Search that 'PORT_AR7' is not used in userspace.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Changes since v1:
* added acks
* kept uapi define for for serial port type

 drivers/tty/serial/8250/8250_port.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fb891b67968f..a4f5d792679a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -170,13 +170,6 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
-	[PORT_AR7] = {
-		.name		= "AR7",
-		.fifo_size	= 16,
-		.tx_loadsz	= 16,
-		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
-		.flags		= UART_CAP_FIFO /* | UART_CAP_AFE */,
-	},
 	[PORT_U6_16550A] = {
 		.name		= "U6_16550A",
 		.fifo_size	= 64,
-- 
2.35.1

