Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34EF7C9CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjJPBdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjJPBdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:33:07 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC14D9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 18:33:04 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6956A2C08CB;
        Mon, 16 Oct 2023 14:33:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1697419983;
        bh=IZEVXUIfVDeU102VRJdLKR3/kJ0wfoxd9fyNoMXJEjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7naH9EyFGc7cb4H80VZCwkE644TWn82WDRYSUVldFvTUMp0Ld6iWnGw9qo6/ybFp
         xHKCnWUxF9kZ/wTIUi1ifXkRls6ZSyYQ3iQSqXzzvYCOsul/F7V5tGS1sdiaK3Ur5f
         63ybkoy1p0t4gj+d7bSiGRjWu61QAFl1CyHtMZJQOCr+udQEUVhMao6Z2BAu1PKhr4
         Z3jHOoyD7XIAsEESvpwInUiMiI5WIGJ4Ii98CrDc5q5JCiz9E+CNgu5SAFxEC5p3tr
         TIZhvDfewdo8SC7emasMuCPLZzqcyz8kqRKLdE6CUUkbNBEmaVw6RH3JQWPFrqrRQC
         xXX1dgOVNCZ/A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B652c92cf0000>; Mon, 16 Oct 2023 14:33:03 +1300
Received: from richardl-dl.ws.atlnz.lc (richardl-dl.ws.atlnz.lc [10.33.23.23])
        by pat.atlnz.lc (Postfix) with ESMTP id 423AD13EDA9;
        Mon, 16 Oct 2023 14:33:03 +1300 (NZDT)
Received: by richardl-dl.ws.atlnz.lc (Postfix, from userid 1481)
        id 3FC56520158; Mon, 16 Oct 2023 14:33:03 +1300 (NZDT)
From:   Richard Laing <richard.laing@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Laing <richard.laing@alliedtelesis.co.nz>
Subject: [PATCH] serial: 8250_dw: Allow TX FIFO to drain before writing to UART_LCR An issue has been observed on the Broadcom BCM56160 serial port which appears closely related to a similar issue on the Marvell Armada 38x serial port.
Date:   Mon, 16 Oct 2023 14:32:06 +1300
Message-ID: <20231016013207.2249946-2-richard.laing@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016013207.2249946-1-richard.laing@alliedtelesis.co.nz>
References: <20231016013207.2249946-1-richard.laing@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L6ZjvNb8 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DcImL0Qf-bG7TP--:21 a=bhdUkHdE2iEA:10 a=_4wK4nrJ_IHnA3Loe_EA:9 a=u4WmNXZ_R_CsxNJzEJ0U:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writes to UART_LCR can result in characters that are currently held in th=
e
TX FIFO being lost rather than sent, even if the userspace process has
attempted to flush them.

This is most visible when using the "resize" command (tested on Busybox),
where we have observed the escape code for restoring cursor position
becoming mangled.

Since this appears to be a more common problem add a new driver option
to flush the TX FIFO before writing to the UART_LCR.

Signed-off-by: Richard Laing <richard.laing@alliedtelesis.co.nz>
---
 drivers/tty/serial/8250/8250_dw.c    | 18 ++++++++++++++++++
 drivers/tty/serial/8250/8250_dwlib.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
index f4cafca1a7da..17ee824294c7 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -161,6 +161,10 @@ static void dw8250_serial_out(struct uart_port *p, i=
nt offset, int value)
 {
 	struct dw8250_data *d =3D to_dw8250_data(p->private_data);
=20
+	/* Allow the TX to drain before we reconfigure */
+	if (offset =3D=3D UART_LCR && d->drain_before_lcr_change)
+		dw8250_tx_wait_empty(p);
+
 	writeb(value, p->membase + (offset << p->regshift));
=20
 	if (offset =3D=3D UART_LCR && !d->uart_16550_compatible)
@@ -197,6 +201,10 @@ static void dw8250_serial_outq(struct uart_port *p, =
int offset, int value)
 {
 	struct dw8250_data *d =3D to_dw8250_data(p->private_data);
=20
+	/* Allow the TX to drain before we reconfigure */
+	if (offset =3D=3D UART_LCR && d->drain_before_lcr_change)
+		dw8250_tx_wait_empty(p);
+
 	value &=3D 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
@@ -211,6 +219,10 @@ static void dw8250_serial_out32(struct uart_port *p,=
 int offset, int value)
 {
 	struct dw8250_data *d =3D to_dw8250_data(p->private_data);
=20
+	/* Allow the TX to drain before we reconfigure */
+	if (offset =3D=3D UART_LCR && d->drain_before_lcr_change)
+		dw8250_tx_wait_empty(p);
+
 	writel(value, p->membase + (offset << p->regshift));
=20
 	if (offset =3D=3D UART_LCR && !d->uart_16550_compatible)
@@ -228,6 +240,10 @@ static void dw8250_serial_out32be(struct uart_port *=
p, int offset, int value)
 {
 	struct dw8250_data *d =3D to_dw8250_data(p->private_data);
=20
+	/* Allow the TX to drain before we reconfigure */
+	if (offset =3D=3D UART_LCR && d->drain_before_lcr_change)
+		dw8250_tx_wait_empty(p);
+
 	iowrite32be(value, p->membase + (offset << p->regshift));
=20
 	if (offset =3D=3D UART_LCR && !d->uart_16550_compatible)
@@ -597,6 +613,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &p->uartclk);
=20
+	data->drain_before_lcr_change =3D device_property_read_bool(dev, "drain=
-before-lcr-change");
+
 	/* If there is separate baudclk, get the rate from it. */
 	data->clk =3D devm_clk_get_optional(dev, "baudclk");
 	if (data->clk =3D=3D NULL)
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/82=
50/8250_dwlib.h
index f13e91f2cace..f7d88fa8f058 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -45,6 +45,7 @@ struct dw8250_data {
=20
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		drain_before_lcr_change:1;
 };
=20
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios=
, const struct ktermios *old);
--=20
2.42.0

