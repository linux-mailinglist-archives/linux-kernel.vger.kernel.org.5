Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FAB7FF146
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjK3OHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345832AbjK3OHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:07:31 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA74BD54;
        Thu, 30 Nov 2023 06:07:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0905540005;
        Thu, 30 Nov 2023 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701353254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZeVZYzIpi7qPE4gQGC8UDmZIaZsyDdyEiRhUi1Jk860=;
        b=H97wfVSH6x6Jen1208bJYnKsln5XW+KjqrP6YiMoJpYlgdPLKXN7dPNUQjeTCsq6EYNa1+
        jtp4ML9I3gYh5UY8JoKl2OH5QjOBanBOx01p+w2E1cBYlRHOYOHxu95krH9ePD6eJCOQ5T
        llbjCbSUzze1K55yALQYYYLMAxZd73SjqkUCCg2FKj2qZCxHXCNgQN6Yv0nVS3bwjV0SlU
        Sg5OwYtW29GJnHiNDpLEUQgV/WdNdTphkKknpPNPQZblwgFF5YSC2ad9ESGmod/X051pyv
        2HLI3IVxbTMoETJ6TtcNGXUD4VfxYeoWFIdcLTjSiN5te1uN/H3+/ie/FbTPsg==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 30 Nov 2023 15:07:14 +0100
Subject: [PATCH v5 2/9] tty: serial: amba: Use linux/{bits,bitfield}.h
 macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses bit shifts and hexadecimal expressions to declare
constants. Replace that with the BIT(), GENMASK() & FIELD_PREP_CONST()
macros to clarify intent.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 include/linux/amba/serial.h | 248 +++++++++++++++++++++++---------------------
 1 file changed, 127 insertions(+), 121 deletions(-)

diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 27003ec52114..23ab7c4cc34f 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -10,6 +10,8 @@
 #ifndef ASM_ARM_HARDWARE_SERIAL_AMBA_H
 #define ASM_ARM_HARDWARE_SERIAL_AMBA_H
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 /* -------------------------------------------------------------------------------
@@ -70,138 +72,142 @@
 #define ZX_UART011_ICR		0x4c
 #define ZX_UART011_DMACR	0x50
 
-#define UART011_DR_OE		(1 << 11)
-#define UART011_DR_BE		(1 << 10)
-#define UART011_DR_PE		(1 << 9)
-#define UART011_DR_FE		(1 << 8)
-
-#define UART01x_RSR_OE		0x08
-#define UART01x_RSR_BE		0x04
-#define UART01x_RSR_PE		0x02
-#define UART01x_RSR_FE		0x01
-
-#define UART011_FR_RI		0x100
-#define UART011_FR_TXFE		0x080
-#define UART011_FR_RXFF		0x040
-#define UART01x_FR_TXFF		0x020
-#define UART01x_FR_RXFE		0x010
-#define UART01x_FR_BUSY		0x008
-#define UART01x_FR_DCD		0x004
-#define UART01x_FR_DSR		0x002
-#define UART01x_FR_CTS		0x001
+#define UART011_DR_OE		BIT(11)
+#define UART011_DR_BE		BIT(10)
+#define UART011_DR_PE		BIT(9)
+#define UART011_DR_FE		BIT(8)
+
+#define UART01x_RSR_OE		BIT(3)
+#define UART01x_RSR_BE		BIT(2)
+#define UART01x_RSR_PE		BIT(1)
+#define UART01x_RSR_FE		BIT(0)
+
+#define UART011_FR_RI		BIT(8)
+#define UART011_FR_TXFE		BIT(7)
+#define UART011_FR_RXFF		BIT(6)
+#define UART01x_FR_TXFF		BIT(5)
+#define UART01x_FR_RXFE		BIT(4)
+#define UART01x_FR_BUSY		BIT(3)
+#define UART01x_FR_DCD		BIT(2)
+#define UART01x_FR_DSR		BIT(1)
+#define UART01x_FR_CTS		BIT(0)
 #define UART01x_FR_TMSK		(UART01x_FR_TXFF + UART01x_FR_BUSY)
 
 /*
  * Some bits of Flag Register on ZTE device have different position from
  * standard ones.
  */
-#define ZX_UART01x_FR_BUSY	0x100
-#define ZX_UART01x_FR_DSR	0x008
-#define ZX_UART01x_FR_CTS	0x002
-#define ZX_UART011_FR_RI	0x001
-
-#define UART011_CR_CTSEN	0x8000	/* CTS hardware flow control */
-#define UART011_CR_RTSEN	0x4000	/* RTS hardware flow control */
-#define UART011_CR_OUT2		0x2000	/* OUT2 */
-#define UART011_CR_OUT1		0x1000	/* OUT1 */
-#define UART011_CR_RTS		0x0800	/* RTS */
-#define UART011_CR_DTR		0x0400	/* DTR */
-#define UART011_CR_RXE		0x0200	/* receive enable */
-#define UART011_CR_TXE		0x0100	/* transmit enable */
-#define UART011_CR_LBE		0x0080	/* loopback enable */
-#define UART010_CR_RTIE		0x0040
-#define UART010_CR_TIE		0x0020
-#define UART010_CR_RIE		0x0010
-#define UART010_CR_MSIE		0x0008
-#define ST_UART011_CR_OVSFACT	0x0008	/* Oversampling factor */
-#define UART01x_CR_IIRLP	0x0004	/* SIR low power mode */
-#define UART01x_CR_SIREN	0x0002	/* SIR enable */
-#define UART01x_CR_UARTEN	0x0001	/* UART enable */
-
-#define UART011_LCRH_SPS	0x80
+#define ZX_UART01x_FR_BUSY	BIT(8)
+#define ZX_UART01x_FR_DSR	BIT(3)
+#define ZX_UART01x_FR_CTS	BIT(1)
+#define ZX_UART011_FR_RI	BIT(0)
+
+#define UART011_CR_CTSEN	BIT(15)	/* CTS hardware flow control */
+#define UART011_CR_RTSEN	BIT(14)	/* RTS hardware flow control */
+#define UART011_CR_OUT2		BIT(13)	/* OUT2 */
+#define UART011_CR_OUT1		BIT(12)	/* OUT1 */
+#define UART011_CR_RTS		BIT(11)	/* RTS */
+#define UART011_CR_DTR		BIT(10)	/* DTR */
+#define UART011_CR_RXE		BIT(9)	/* receive enable */
+#define UART011_CR_TXE		BIT(8)	/* transmit enable */
+#define UART011_CR_LBE		BIT(7)	/* loopback enable */
+#define UART010_CR_RTIE		BIT(6)
+#define UART010_CR_TIE		BIT(5)
+#define UART010_CR_RIE		BIT(4)
+#define UART010_CR_MSIE		BIT(3)
+#define ST_UART011_CR_OVSFACT	BIT(3)	/* Oversampling factor */
+#define UART01x_CR_IIRLP	BIT(2)	/* SIR low power mode */
+#define UART01x_CR_SIREN	BIT(1)	/* SIR enable */
+#define UART01x_CR_UARTEN	BIT(0)	/* UART enable */
+
+#define UART011_LCRH_SPS	BIT(7)
 #define UART01x_LCRH_WLEN_8	0x60
 #define UART01x_LCRH_WLEN_7	0x40
 #define UART01x_LCRH_WLEN_6	0x20
 #define UART01x_LCRH_WLEN_5	0x00
-#define UART01x_LCRH_FEN	0x10
-#define UART01x_LCRH_STP2	0x08
-#define UART01x_LCRH_EPS	0x04
-#define UART01x_LCRH_PEN	0x02
-#define UART01x_LCRH_BRK	0x01
-
-#define ST_UART011_DMAWM_RX_1	(0 << 3)
-#define ST_UART011_DMAWM_RX_2	(1 << 3)
-#define ST_UART011_DMAWM_RX_4	(2 << 3)
-#define ST_UART011_DMAWM_RX_8	(3 << 3)
-#define ST_UART011_DMAWM_RX_16	(4 << 3)
-#define ST_UART011_DMAWM_RX_32	(5 << 3)
-#define ST_UART011_DMAWM_RX_48	(6 << 3)
-#define ST_UART011_DMAWM_TX_1	0
-#define ST_UART011_DMAWM_TX_2	1
-#define ST_UART011_DMAWM_TX_4	2
-#define ST_UART011_DMAWM_TX_8	3
-#define ST_UART011_DMAWM_TX_16	4
-#define ST_UART011_DMAWM_TX_32	5
-#define ST_UART011_DMAWM_TX_48	6
-
-#define UART010_IIR_RTIS	0x08
-#define UART010_IIR_TIS		0x04
-#define UART010_IIR_RIS		0x02
-#define UART010_IIR_MIS		0x01
-
-#define UART011_IFLS_RX1_8	(0 << 3)
-#define UART011_IFLS_RX2_8	(1 << 3)
-#define UART011_IFLS_RX4_8	(2 << 3)
-#define UART011_IFLS_RX6_8	(3 << 3)
-#define UART011_IFLS_RX7_8	(4 << 3)
-#define UART011_IFLS_TX1_8	(0 << 0)
-#define UART011_IFLS_TX2_8	(1 << 0)
-#define UART011_IFLS_TX4_8	(2 << 0)
-#define UART011_IFLS_TX6_8	(3 << 0)
-#define UART011_IFLS_TX7_8	(4 << 0)
+#define UART01x_LCRH_FEN	BIT(4)
+#define UART01x_LCRH_STP2	BIT(3)
+#define UART01x_LCRH_EPS	BIT(2)
+#define UART01x_LCRH_PEN	BIT(1)
+#define UART01x_LCRH_BRK	BIT(0)
+
+#define ST_UART011_DMAWM_RX	GENMASK(5, 3)
+#define ST_UART011_DMAWM_RX_1	FIELD_PREP_CONST(ST_UART011_DMAWM_RX, 0)
+#define ST_UART011_DMAWM_RX_2	FIELD_PREP_CONST(ST_UART011_DMAWM_RX, 1)
+#define ST_UART011_DMAWM_RX_4	FIELD_PREP_CONST(ST_UART011_DMAWM_RX, 2)
+#define ST_UART011_DMAWM_RX_8	FIELD_PREP_CONST(ST_UART011_DMAWM_RX, 3)
+#define ST_UART011_DMAWM_RX_16	FIELD_PREP_CONST(ST_UART011_DMAWM_RX, 4)
+#define ST_UART011_DMAWM_RX_32	FIELD_PREP_CONST(ST_UART011_DMAWM_RX, 5)
+#define ST_UART011_DMAWM_RX_48	FIELD_PREP_CONST(ST_UART011_DMAWM_RX, 6)
+#define ST_UART011_DMAWM_TX	GENMASK(2, 0)
+#define ST_UART011_DMAWM_TX_1	FIELD_PREP_CONST(ST_UART011_DMAWM_TX, 0)
+#define ST_UART011_DMAWM_TX_2	FIELD_PREP_CONST(ST_UART011_DMAWM_TX, 1)
+#define ST_UART011_DMAWM_TX_4	FIELD_PREP_CONST(ST_UART011_DMAWM_TX, 2)
+#define ST_UART011_DMAWM_TX_8	FIELD_PREP_CONST(ST_UART011_DMAWM_TX, 3)
+#define ST_UART011_DMAWM_TX_16	FIELD_PREP_CONST(ST_UART011_DMAWM_TX, 4)
+#define ST_UART011_DMAWM_TX_32	FIELD_PREP_CONST(ST_UART011_DMAWM_TX, 5)
+#define ST_UART011_DMAWM_TX_48	FIELD_PREP_CONST(ST_UART011_DMAWM_TX, 6)
+
+#define UART010_IIR_RTIS	BIT(3)
+#define UART010_IIR_TIS		BIT(2)
+#define UART010_IIR_RIS		BIT(1)
+#define UART010_IIR_MIS		BIT(0)
+
+#define UART011_IFLS_RXIFLSEL	GENMASK(5, 3)
+#define UART011_IFLS_RX1_8	FIELD_PREP_CONST(UART011_IFLS_RXIFLSEL, 0)
+#define UART011_IFLS_RX2_8	FIELD_PREP_CONST(UART011_IFLS_RXIFLSEL, 1)
+#define UART011_IFLS_RX4_8	FIELD_PREP_CONST(UART011_IFLS_RXIFLSEL, 2)
+#define UART011_IFLS_RX6_8	FIELD_PREP_CONST(UART011_IFLS_RXIFLSEL, 3)
+#define UART011_IFLS_RX7_8	FIELD_PREP_CONST(UART011_IFLS_RXIFLSEL, 4)
+#define UART011_IFLS_TXIFLSEL	GENMASK(2, 0)
+#define UART011_IFLS_TX1_8	FIELD_PREP_CONST(UART011_IFLS_TXIFLSEL, 0)
+#define UART011_IFLS_TX2_8	FIELD_PREP_CONST(UART011_IFLS_TXIFLSEL, 1)
+#define UART011_IFLS_TX4_8	FIELD_PREP_CONST(UART011_IFLS_TXIFLSEL, 2)
+#define UART011_IFLS_TX6_8	FIELD_PREP_CONST(UART011_IFLS_TXIFLSEL, 3)
+#define UART011_IFLS_TX7_8	FIELD_PREP_CONST(UART011_IFLS_TXIFLSEL, 4)
 /* special values for ST vendor with deeper fifo */
-#define UART011_IFLS_RX_HALF	(5 << 3)
-#define UART011_IFLS_TX_HALF	(5 << 0)
-
-#define UART011_OEIM		(1 << 10)	/* overrun error interrupt mask */
-#define UART011_BEIM		(1 << 9)	/* break error interrupt mask */
-#define UART011_PEIM		(1 << 8)	/* parity error interrupt mask */
-#define UART011_FEIM		(1 << 7)	/* framing error interrupt mask */
-#define UART011_RTIM		(1 << 6)	/* receive timeout interrupt mask */
-#define UART011_TXIM		(1 << 5)	/* transmit interrupt mask */
-#define UART011_RXIM		(1 << 4)	/* receive interrupt mask */
-#define UART011_DSRMIM		(1 << 3)	/* DSR interrupt mask */
-#define UART011_DCDMIM		(1 << 2)	/* DCD interrupt mask */
-#define UART011_CTSMIM		(1 << 1)	/* CTS interrupt mask */
-#define UART011_RIMIM		(1 << 0)	/* RI interrupt mask */
-
-#define UART011_OEIS		(1 << 10)	/* overrun error interrupt status */
-#define UART011_BEIS		(1 << 9)	/* break error interrupt status */
-#define UART011_PEIS		(1 << 8)	/* parity error interrupt status */
-#define UART011_FEIS		(1 << 7)	/* framing error interrupt status */
-#define UART011_RTIS		(1 << 6)	/* receive timeout interrupt status */
-#define UART011_TXIS		(1 << 5)	/* transmit interrupt status */
-#define UART011_RXIS		(1 << 4)	/* receive interrupt status */
-#define UART011_DSRMIS		(1 << 3)	/* DSR interrupt status */
-#define UART011_DCDMIS		(1 << 2)	/* DCD interrupt status */
-#define UART011_CTSMIS		(1 << 1)	/* CTS interrupt status */
-#define UART011_RIMIS		(1 << 0)	/* RI interrupt status */
-
-#define UART011_OEIC		(1 << 10)	/* overrun error interrupt clear */
-#define UART011_BEIC		(1 << 9)	/* break error interrupt clear */
-#define UART011_PEIC		(1 << 8)	/* parity error interrupt clear */
-#define UART011_FEIC		(1 << 7)	/* framing error interrupt clear */
-#define UART011_RTIC		(1 << 6)	/* receive timeout interrupt clear */
-#define UART011_TXIC		(1 << 5)	/* transmit interrupt clear */
-#define UART011_RXIC		(1 << 4)	/* receive interrupt clear */
-#define UART011_DSRMIC		(1 << 3)	/* DSR interrupt clear */
-#define UART011_DCDMIC		(1 << 2)	/* DCD interrupt clear */
-#define UART011_CTSMIC		(1 << 1)	/* CTS interrupt clear */
-#define UART011_RIMIC		(1 << 0)	/* RI interrupt clear */
-
-#define UART011_DMAONERR	(1 << 2)	/* disable dma on error */
-#define UART011_TXDMAE		(1 << 1)	/* enable transmit dma */
-#define UART011_RXDMAE		(1 << 0)	/* enable receive dma */
+#define UART011_IFLS_RX_HALF	FIELD_PREP_CONST(UART011_IFLS_RXIFLSEL, 5)
+#define UART011_IFLS_TX_HALF	FIELD_PREP_CONST(UART011_IFLS_TXIFLSEL, 5)
+
+#define UART011_OEIM		BIT(10)	/* overrun error interrupt mask */
+#define UART011_BEIM		BIT(9)	/* break error interrupt mask */
+#define UART011_PEIM		BIT(8)	/* parity error interrupt mask */
+#define UART011_FEIM		BIT(7)	/* framing error interrupt mask */
+#define UART011_RTIM		BIT(6)	/* receive timeout interrupt mask */
+#define UART011_TXIM		BIT(5)	/* transmit interrupt mask */
+#define UART011_RXIM		BIT(4)	/* receive interrupt mask */
+#define UART011_DSRMIM		BIT(3)	/* DSR interrupt mask */
+#define UART011_DCDMIM		BIT(2)	/* DCD interrupt mask */
+#define UART011_CTSMIM		BIT(1)	/* CTS interrupt mask */
+#define UART011_RIMIM		BIT(0)	/* RI interrupt mask */
+
+#define UART011_OEIS		BIT(10)	/* overrun error interrupt status */
+#define UART011_BEIS		BIT(9)	/* break error interrupt status */
+#define UART011_PEIS		BIT(8)	/* parity error interrupt status */
+#define UART011_FEIS		BIT(7)	/* framing error interrupt status */
+#define UART011_RTIS		BIT(6)	/* receive timeout interrupt status */
+#define UART011_TXIS		BIT(5)	/* transmit interrupt status */
+#define UART011_RXIS		BIT(4)	/* receive interrupt status */
+#define UART011_DSRMIS		BIT(3)	/* DSR interrupt status */
+#define UART011_DCDMIS		BIT(2)	/* DCD interrupt status */
+#define UART011_CTSMIS		BIT(1)	/* CTS interrupt status */
+#define UART011_RIMIS		BIT(0)	/* RI interrupt status */
+
+#define UART011_OEIC		BIT(10)	/* overrun error interrupt clear */
+#define UART011_BEIC		BIT(9)	/* break error interrupt clear */
+#define UART011_PEIC		BIT(8)	/* parity error interrupt clear */
+#define UART011_FEIC		BIT(7)	/* framing error interrupt clear */
+#define UART011_RTIC		BIT(6)	/* receive timeout interrupt clear */
+#define UART011_TXIC		BIT(5)	/* transmit interrupt clear */
+#define UART011_RXIC		BIT(4)	/* receive interrupt clear */
+#define UART011_DSRMIC		BIT(3)	/* DSR interrupt clear */
+#define UART011_DCDMIC		BIT(2)	/* DCD interrupt clear */
+#define UART011_CTSMIC		BIT(1)	/* CTS interrupt clear */
+#define UART011_RIMIC		BIT(0)	/* RI interrupt clear */
+
+#define UART011_DMAONERR	BIT(2)	/* disable dma on error */
+#define UART011_TXDMAE		BIT(1)	/* enable transmit dma */
+#define UART011_RXDMAE		BIT(0)	/* enable receive dma */
 
 #define UART01x_RSR_ANY		(UART01x_RSR_OE | UART01x_RSR_BE | UART01x_RSR_PE | UART01x_RSR_FE)
 #define UART01x_FR_MODEM_ANY	(UART01x_FR_DCD | UART01x_FR_DSR | UART01x_FR_CTS)

-- 
2.43.0

