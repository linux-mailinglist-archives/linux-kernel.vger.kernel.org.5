Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBFC7A8D85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjITUKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjITUKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:10:52 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB73C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=ZNeKrg5sAP30QqDQrIU7hgAIKaGsVVJXPQC5z91sR2k=; b=erc3tI
        F7QNEs3H3KRFvKBZcKcsmkR/ynJaaOGiCM4v/yRCukMAo4aTctihbTYFrXERq9tl
        fe/H9vzD3XoQYrYWsp46CXnRurhSklfF0+55brjjxwQDb6IMT00XHCo3+I9bOPuA
        7gt7yqwwjvsta4WJTxLuJecZdAGK5rPmW71gEo6FHkjJvsXYgc26oiaRnl5wkxR3
        7uVtmfW49ezMuky5H9KEqD6X8+B47318Sk4TMw540AyZdZlnafPU2XHUjxp2D7Ff
        qY90Jum3jeoFSZI2R7KzIHOAcWG/YJM3MNbfJgOtH/y1KekCzZDujyRVRqroJrcv
        aL7ZFqUGUhCkYbUA==
Received: (qmail 720181 invoked from network); 20 Sep 2023 22:10:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2023 22:10:41 +0200
X-UD-Smtp-Session: l3s3148p1@dPg7+M8FztgujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 1/6] serial: 8250: remove AR7 support
Date:   Wed, 20 Sep 2023 22:10:27 +0200
Message-Id: <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AR7 is going to be removed from the Kernel, so remove its type
definition from 8250 code. As with previous removals, I checked with
Debian Code Search that 'PORT_AR7' is not used in userspace.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 -------
 include/uapi/linux/serial_core.h    | 1 -
 2 files changed, 8 deletions(-)

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
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index add349889d0a..3b51901926f9 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -32,7 +32,6 @@
 #define PORT_XSCALE	15
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
 #define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
-#define PORT_AR7	18	/* Texas Instruments AR7 internal UART */
 #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
 #define PORT_TEGRA	20	/* NVIDIA Tegra internal UART */
 #define PORT_XR17D15X	21	/* Exar XR17D15x UART */
-- 
2.35.1

