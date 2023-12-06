Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6188068BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377070AbjLFHjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjLFHif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6059A1FDD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D095FC433C8;
        Wed,  6 Dec 2023 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848276;
        bh=nSSljLNGQ9Y7kzHEyEQQ1fA1Oeo2vcVP/kZE9IDY3b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hk3CXAABBif2+4UBFwiraoU/6ilEnlUlJ1NpyRGjMu3AjUqIhRjtyDnpTnRGClPIL
         mGkK2tCq/Gi9AiM49mtR2h+Gbs/sSpjRUJgONSl95tImyu3undV+YU6prjWlh33wu+
         LcCnpUXxpct1fvqbQF84yXA2qHYCrvgmHKbsRB5cH0RlACrRDqnOQp9IzXPAWtTITZ
         SaLvrTgmDd4B1A8lj2OB2ruRE4bc2EsXnBN0O4CZ09oosSjG2zL4F3ktYlDlzLwJ/J
         OP4r+OftN+Cw+iWGhEcNeR+pc829wKtQa9RMcmx//odpUS1GeuhEDVVRD13McQObJS
         vVZ7uHjlYVh9g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 18/27] tty: mxser: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:37:03 +0100
Message-ID: <20231206073712.17776-19-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/mxser.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6ce7f259968f..458bb1280ebf 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -264,7 +264,7 @@ struct mxser_port {
 	u8 rx_low_water;
 	int type;		/* UART type */
 
-	unsigned char x_char;	/* xon/xoff character */
+	u8 x_char;		/* xon/xoff character */
 	u8 IER;			/* Interrupt Enable Register */
 	u8 MCR;			/* Modem control register */
 	u8 FCR;			/* FIFO control register */
@@ -905,7 +905,7 @@ static ssize_t mxser_write(struct tty_struct *tty, const u8 *buf, size_t count)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
-	int written;
+	size_t written;
 	bool is_empty;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1521,7 +1521,7 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 			if (++ignored > 100)
 				break;
 		} else {
-			char flag = 0;
+			u8 flag = 0;
 			if (status & UART_LSR_BRK_ERROR_BITS) {
 				if (status & UART_LSR_BI) {
 					flag = TTY_BREAK;
@@ -1585,7 +1585,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 
 	count = port->xmit_fifo_size;
 	do {
-		unsigned char c;
+		u8 c;
 
 		if (!kfifo_get(&port->port.xmit_fifo, &c))
 			break;
-- 
2.43.0

