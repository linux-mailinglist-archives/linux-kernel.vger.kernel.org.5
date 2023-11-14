Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87277EAB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjKNH6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNH6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:58:35 -0500
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 23:58:31 PST
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC86619B;
        Mon, 13 Nov 2023 23:58:31 -0800 (PST)
Received: from hq-00595.fritz.box (unknown [178.19.214.146])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 05DF928071D;
        Tue, 14 Nov 2023 07:49:15 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        lech.perczak@camlingroup.com, u.kleine-koenig@pengutronix.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Maxim Popov <maxim.snafu@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] serial: sc16is7xx: address RX timeout interrupt errata
Date:   Tue, 14 Nov 2023 08:49:04 +0100
Message-ID: <20231114074904.239458-1-daniel@zonque.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This devices has a silicon bug that makes it report a timeout interrupt
but no data in FIFO.

The datasheet states the following in the errata section 18.1.4:

  "If the host reads the receive FIFO at the at the same time as a
  time-out interrupt condition happens, the host might read 0xCC
  (time-out) in the Interrupt Indication Register (IIR), but bit 0
  of the Line Status Register (LSR) is not set (means there is not
  data in the receive FIFO)."

When this happens, the loop in sc16is7xx_irq() will run forever,
which effectively blocks the i2c bus and breaks the functionality
of the UART.

From the information above, it is assumed that when the bug is
triggered, the FIFO does in fact have payload in its buffer, but the
fill level reporting is off-by-one. Hence this patch fixes the issue
by reading one byte from the FIFO when that condition is detected.

This clears the interrupt and hence breaks the polling loop.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Co-Developed-by: Maxim Popov <maxim.snafu@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/sc16is7xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 289ca7d4e566..76f76e510ed1 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -765,6 +765,18 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		case SC16IS7XX_IIR_RTOI_SRC:
 		case SC16IS7XX_IIR_XOFFI_SRC:
 			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
+
+			/*
+			 * There is a silicon bug that makes the chip report a
+			 * time-out interrupt but no data in the FIFO. This is
+			 * described in errata section 18.1.4.
+			 *
+			 * When this happens, read one byte from the FIFO to
+			 * clear the interrupt.
+			 */
+			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
+				rxlen = 1;
+
 			if (rxlen)
 				sc16is7xx_handle_rx(port, rxlen, iir);
 			break;
-- 
2.41.0

