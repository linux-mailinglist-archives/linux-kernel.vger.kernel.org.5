Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2487F5933
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjKWH2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKWH2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:28:21 -0500
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A030EE7;
        Wed, 22 Nov 2023 23:28:27 -0800 (PST)
Received: from hq-00595.holoplot.net (unknown [62.214.9.170])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 1041A2806ED;
        Thu, 23 Nov 2023 07:28:26 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        lech.perczak@camlingroup.com, u.kleine-koenig@pengutronix.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Maxim Popov <maxim.snafu@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v5] serial: sc16is7xx: address RX timeout interrupt errata
Date:   Thu, 23 Nov 2023 08:28:18 +0100
Message-ID: <20231123072818.1394539-1-daniel@zonque.org>
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

This device has a silicon bug that makes it report a timeout interrupt
but no data in the FIFO.

The datasheet states the following in the errata section 18.1.4:

  "If the host reads the receive FIFO at the same time as a
  time-out interrupt condition happens, the host might read 0xCC
  (time-out) in the Interrupt Indication Register (IIR), but bit 0
  of the Line Status Register (LSR) is not set (means there is no
  data in the receive FIFO)."

The errata description seems to indicate it concerns only polled mode of
operation when reading bit 0 of the LSR register. However, tests have
shown and NXP has confirmed that the RXLVL register also yields 0 when
the bug is triggered, and hence the IRQ driven implementation in this
driver is equally affected.

This bug has hit us on production units and when it does, sc16is7xx_irq()
would spin forever because sc16is7xx_port_irq() keeps seeing an
interrupt in the IIR register that is not cleared because the driver
does not call into sc16is7xx_handle_rx() unless the RXLVL register
reports at least one byte in the FIFO.

Fix this by always reading one byte from the FIFO when this condition
is detected in order to clear the interrupt. This approach was
confirmed to be correct by NXP through their support channels.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Co-Developed-by: Maxim Popov <maxim.snafu@gmail.com>
Tested by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: stable@vger.kernel.org
---
v5: slightly reworded commit log again, added Hugo's Tested-By
v4: NXP has confirmed the fix; update the commit log accordingly
v3: re-added the additional Co-Developed-by and stable@ tags
v2: reworded the commit log a bit for more context.

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

