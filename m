Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C287F2A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjKUKg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjKUKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:36:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9818F199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:36:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D06C433C8;
        Tue, 21 Nov 2023 10:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700562997;
        bh=FnTt1y4GBgdu68w8crsWeSKtB9fLgimiwg29HboN+SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5+fcHhD47eYBb3BLeAuriqXUEjBh0WQEvFrsS7xm952S9hBAAgUCGcpZ1/NRL+sP
         QN/cLI2P+Mxt7+gXYvivW+aThT5lBEgY0G28YKGiLXZ/cz7clyWbFaVG+8/Cmgk67P
         kyGGkyFfriZbJnLyGilv+sOJ/BaS7tH33S337iNmPwI3TlyMfhHgTxAuK4BsZFrTWX
         25r9tBqtSpEN+9p7PRKqX7uP/YpqM/S3WAgkaowK/mrT91eENnyeW2y9nEQ9J9cty+
         vrYtYq3V1O7anljiFhI83xF4/+HRgSTMP4rMZPb9gfjUwLiupjGmvROCvXSxy6yI26
         N0yFz+/RYzucQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/6] tty: jsm: remove unused members from struct board_ops
Date:   Tue, 21 Nov 2023 11:36:23 +0100
Message-ID: <20231121103626.17772-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121103626.17772-1-jirislaby@kernel.org>
References: <20231121103626.17772-1-jirislaby@kernel.org>
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

clang-struct [1] found board_ops::get_uart_bytes_left() and
::send_immediate_char() unused.

Both are only set but never called. And it has been like that since the
git history, so drop both the members along with the cls+neo
implementations.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/jsm/jsm.h     |  2 --
 drivers/tty/serial/jsm/jsm_cls.c | 36 ----------------------------
 drivers/tty/serial/jsm/jsm_neo.c | 40 --------------------------------
 3 files changed, 78 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm.h b/drivers/tty/serial/jsm/jsm.h
index 8489c07f4cd5..08a42f045ec8 100644
--- a/drivers/tty/serial/jsm/jsm.h
+++ b/drivers/tty/serial/jsm/jsm.h
@@ -115,8 +115,6 @@ struct board_ops {
 	void (*send_start_character)(struct jsm_channel *ch);
 	void (*send_stop_character)(struct jsm_channel *ch);
 	void (*copy_data_from_queue_to_uart)(struct jsm_channel *ch);
-	u32 (*get_uart_bytes_left)(struct jsm_channel *ch);
-	void (*send_immediate_char)(struct jsm_channel *ch, unsigned char);
 };
 
 
diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 3fd57ac3ad81..1eda48964c0b 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -877,28 +877,6 @@ static void cls_uart_off(struct jsm_channel *ch)
 	writeb(0, &ch->ch_cls_uart->ier);
 }
 
-/*
- * cls_get_uarts_bytes_left.
- * Returns 0 is nothing left in the FIFO, returns 1 otherwise.
- *
- * The channel lock MUST be held by the calling function.
- */
-static u32 cls_get_uart_bytes_left(struct jsm_channel *ch)
-{
-	u8 left = 0;
-	u8 lsr = readb(&ch->ch_cls_uart->lsr);
-
-	/* Determine whether the Transmitter is empty or not */
-	if (!(lsr & UART_LSR_TEMT))
-		left = 1;
-	else {
-		ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
-		left = 0;
-	}
-
-	return left;
-}
-
 /*
  * cls_send_break.
  * Starts sending a break thru the UART.
@@ -916,18 +894,6 @@ static void cls_send_break(struct jsm_channel *ch)
 	}
 }
 
-/*
- * cls_send_immediate_char.
- * Sends a specific character as soon as possible to the UART,
- * jumping over any bytes that might be in the write queue.
- *
- * The channel lock MUST be held by the calling function.
- */
-static void cls_send_immediate_char(struct jsm_channel *ch, unsigned char c)
-{
-	writeb(c, &ch->ch_cls_uart->txrx);
-}
-
 struct board_ops jsm_cls_ops = {
 	.intr =				cls_intr,
 	.uart_init =			cls_uart_init,
@@ -943,7 +909,5 @@ struct board_ops jsm_cls_ops = {
 	.send_start_character =		cls_send_start_character,
 	.send_stop_character =		cls_send_stop_character,
 	.copy_data_from_queue_to_uart = cls_copy_data_from_queue_to_uart,
-	.get_uart_bytes_left =		cls_get_uart_bytes_left,
-	.send_immediate_char =		cls_send_immediate_char
 };
 
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 2bd640428970..1fa10f19368f 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -1309,25 +1309,6 @@ static void neo_uart_off(struct jsm_channel *ch)
 	writeb(0, &ch->ch_neo_uart->ier);
 }
 
-static u32 neo_get_uart_bytes_left(struct jsm_channel *ch)
-{
-	u8 left = 0;
-	u8 lsr = readb(&ch->ch_neo_uart->lsr);
-
-	/* We must cache the LSR as some of the bits get reset once read... */
-	ch->ch_cached_lsr |= lsr;
-
-	/* Determine whether the Transmitter is empty or not */
-	if (!(lsr & UART_LSR_TEMT))
-		left = 1;
-	else {
-		ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
-		left = 0;
-	}
-
-	return left;
-}
-
 /* Channel lock MUST be held by the calling function! */
 static void neo_send_break(struct jsm_channel *ch)
 {
@@ -1348,25 +1329,6 @@ static void neo_send_break(struct jsm_channel *ch)
 	}
 }
 
-/*
- * neo_send_immediate_char.
- *
- * Sends a specific character as soon as possible to the UART,
- * jumping over any bytes that might be in the write queue.
- *
- * The channel lock MUST be held by the calling function.
- */
-static void neo_send_immediate_char(struct jsm_channel *ch, unsigned char c)
-{
-	if (!ch)
-		return;
-
-	writeb(c, &ch->ch_neo_uart->txrx);
-
-	/* flush write operation */
-	neo_pci_posting_flush(ch->ch_bd);
-}
-
 struct board_ops jsm_neo_ops = {
 	.intr				= neo_intr,
 	.uart_init			= neo_uart_init,
@@ -1382,6 +1344,4 @@ struct board_ops jsm_neo_ops = {
 	.send_start_character		= neo_send_start_character,
 	.send_stop_character		= neo_send_stop_character,
 	.copy_data_from_queue_to_uart	= neo_copy_data_from_queue_to_uart,
-	.get_uart_bytes_left		= neo_get_uart_bytes_left,
-	.send_immediate_char		= neo_send_immediate_char
 };
-- 
2.42.1

