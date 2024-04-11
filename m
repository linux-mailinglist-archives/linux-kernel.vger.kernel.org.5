Return-Path: <linux-kernel+bounces-141570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E08A202A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45508B2476A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8044199B9;
	Thu, 11 Apr 2024 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="SwLrta9o"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D57D17C6D;
	Thu, 11 Apr 2024 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867165; cv=none; b=H51favclpXV0QrYcyZ47tuRydkZEP8DHdlPF9+kbE4IpVIMNFS0XkA9mfpS9mJN9PLLYLNK72DKFJLsvQeEEne6ifknyYfx2oU7gcrB4tub95YFlR2FWVf8Q0kVxFCUOw/Boiiyhq+3ANZSjJUtnE7+OZXLrpABQTeCKeQUrJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867165; c=relaxed/simple;
	bh=TkhjnlvjFGVhpEGIBO9ktab1bjtXa/Gww45F0qnwaGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYPNgHeNSp+knz318rJ6z2e/qvi4sGbmM21n+jSIyFI2Jg0hYNhZDBFVyjX0UdddXfUtQgaIcJtKJh/zHRulGtRLrXLjM0YwAjXZEnFVVMyb1ZQljMTg76SGk5hHJ+vU+3XBKr4ft6NJTRhdkw+zkeCiJc/vy4FUo4uw+5pBpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=SwLrta9o; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712867158; x=1713471958; i=parker@finest.io;
	bh=iyYbMwbsoalW7f0BZDynP1kALXT2YHy5NY0+s2Dr6Fs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SwLrta9oqLc9LjSfpwh6cf9yGX5e6RutuK+e7NSaECXA1tR8nidYQ4eDR2JU2ywI
	 1+iAixV9+bo2dipTkSsGtG9e6uom7qPLU+t06XWr30yAAkJXucoaGIj1HbETbxDoj
	 C8zQP0gpfgU6ywkitJEcSZ4FzlaWQ8eVBdilo4ZxH86cNNsdMc8CHvaDA8+FAAFw+
	 uz0cD+NxYY23FeCjuvnfQoCb9H14PSEkWqu6ePqjZHrk1wHFgSlhow0Ikj5Dfdi4i
	 AWaq8dDKZX5BxhoirIm48XnIN7HyPhT12kLIuZZWaQ5whptM2UYhY2sxYZVLfaID3
	 Dw/xDWihgdz/36wndw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MStu7-1sMkSZ0m6n-00HffZ; Thu, 11 Apr
 2024 22:25:58 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 4/7] serial: exar: add optional board_setup function
Date: Thu, 11 Apr 2024 16:25:42 -0400
Message-ID: <69677365f4c753cbe6b5c028f530db49e6712ab3.1712863999.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712863999.git.pnewman@connecttech.com>
References: <cover.1712863999.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cGlYfgxUzp/dk+YlF7OoGo/8PXhPAY+qB3wIDrtCULnQKHcJ2Ey
 zVfZISSB7kE3OunQRk0o4w0I72C90WOpchanDUIj7YBMukIsHjt7dkYLoT1vmaMUTgm+YEb
 EgkjbDWk7a2WXhduxd0BTq43qseMJBtCb5E9rDq4o4+PEV+GrEFQFD1a6/rCdOgmAqythds
 d30hTd+raE42y2dWhNH8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CeSaNtNqE98=;cEBVWnOpTBRRd8aBZe4JWF9WmQo
 MgA8fU/bkfIwDJrj/+mpW3WHwRY4KvnU7TiAga5ss1MWVK5k84tHNwy1jAg1wOJ+bp8FMnMHZ
 RRvaGQFMJNxTvMXl1L7OPHJvaQ48bElfzv/a0NWMHBKLVZ6vF23SUsb5zICFo8IItCSWVX7OB
 8mx5MQ6hNEkWSRA6qu9J0N6Hc6wl5YRn6Kgk+bJEgW6XZsihJa6RnPBpyey1mHMx1KCCyzoNc
 dQhQ4NfDQ5b2Vsx1JYzkXit+Dze7sJ5juec1Qx1m3fcClNrx+AtEvisbKKCQxD1ezeZhq27Da
 62Qh2XfAgVJyzltkuirKcKBsDeVp3VDA2y1oum+ha2EdbaUl9UnodGR75KOCL0XIRXqcRtO0p
 BamuNZ0LF5yFXHBuiVWMRF7AvR2JsHvQuAwWfwiBomzaC/mDWRDoMJdPJIavitbHboiulJ1on
 0+qO7NFvX3w2OWjubwpBYiGcRxcWoShjxh3R1T9BZPWstTLYEG+zXJgsrVqkwu5rg9VoyBm5v
 8VJEE9gKsQ9LkrtpQgaQezUjh7ZvCxYNeqzjruX8SWdno+rPfIkMFACscyHw86J2PWgTlCeaB
 ZNYXR6NQa60Fg1eKiRcg3ByypxaEThPWF+M09TBX5ZzYSKHXgBwymhPcnjbuoSttF4LcBOcYi
 5GA031wGNJ9hrqry0AUI4xM/OAbd2lmsyp//6zsQ/drzfusPUB4m8lXc1CYQdu85hQPwOZpYg
 GXlZTZrDyJ1iBHR2Xr0oXXNjyeGHf1S9G2jYGa3GUEk9GR6KbS0QdY=

From: Parker Newman <pnewman@connecttech.com>

Adds an optional "board_setup" function pointer to struct
exar8250_board. This gets called once during probe prior to setting up
the ports.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 9915a99cb7c6..b30f3855652a 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -143,7 +143,7 @@
  *
  * MPIO		Port	Function
  * ----		----	--------
- * 0		2 	Mode bit 0
+ * 0		2	Mode bit 0
  * 1		2	Mode bit 1
  * 2		2	Terminate bus
  * 3		-	<reserved>
@@ -179,22 +179,24 @@ struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
-	void (*unregister_gpio)(struct uart_8250_port *);
+	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port=
);
+	void (*unregister_gpio)(struct uart_8250_port *port);
 };

 /**
  * struct exar8250_board - board information
  * @num_ports: number of serial ports
  * @reg_shift: describes UART register mapping in PCI memory
- * @setup: quirk run at ->probe() stage
+ * @board_setup: quirk run once at ->probe() stage before setting up port=
s
+ * @setup: quirk run at ->probe() stage for each port
  * @exit: quirk run at ->remove() stage
  */
 struct exar8250_board {
 	unsigned int num_ports;
 	unsigned int reg_shift;
-	int	(*setup)(struct exar8250 *, struct pci_dev *,
-			 struct uart_8250_port *, int);
+	int     (*board_setup)(struct exar8250 *priv);
+	int	(*setup)(struct exar8250 *priv, struct pci_dev *pcidev,
+			 struct uart_8250_port *port, int idx);
 	void	(*exit)(struct pci_dev *pcidev);
 };

@@ -966,6 +968,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struct p=
ci_device_id *ent)
 	if (rc)
 		return rc;

+	if (board->board_setup) {
+		rc =3D board->board_setup(priv);
+		if (rc) {
+			pci_err(pcidev,
+				"failed to setup serial board: %d\n", rc);
+			return rc;
+		}
+	}
+
 	for (i =3D 0; i < nr_ports && i < maxnr; i++) {
 		rc =3D board->setup(priv, pcidev, &uart, i);
 		if (rc) {
=2D-
2.43.2


