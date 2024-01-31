Return-Path: <linux-kernel+bounces-46405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618D843F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BB628C7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B597678690;
	Wed, 31 Jan 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8FcuXl0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B61768F4;
	Wed, 31 Jan 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703243; cv=none; b=FJOewHZEPpMDuzYdFMWdgyDA7ZE7c5XsXHyW74SXnweZAjXyjxT5rY9/QG6XkY6RIms5HfwgyeY+LX28KWdOfdUPLw43Jbj9WVS0VJgei70jHaORcZmAjDcrxg8ZM65C3wRfTk4np/xPFx8Cp6Zhs5pBmlLmSo08L0Krnm6cYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703243; c=relaxed/simple;
	bh=7PA+jHjuL3dX/U2euxIHOazTkyVPO2EfIlsJ8MWjALE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJdlhgSditD7HZlJBx0HL8Vn5t3Gd707vTj94T3PND8pqTwuQdciGR93IpOCjv1NdyPE92TGpVNcMlb+LZFK7z0T+iHkGcLtoXiIoZLks5hcV2L+ttqMZDE68vAD8xcEl8N66C62dRxav9yXOoHNy3DPagzWBgLVY0V+5O+2iS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8FcuXl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F101C433C7;
	Wed, 31 Jan 2024 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706703242;
	bh=7PA+jHjuL3dX/U2euxIHOazTkyVPO2EfIlsJ8MWjALE=;
	h=From:To:Cc:Subject:Date:From;
	b=f8FcuXl0L8EkWHgmObVu6ysB+ynvQZF2V/GFvjPb0JvXekn7dzZVNgmswGbQqUeTG
	 21N6i1yF+3OLJRbNNYwgFbU/Hv+7odV9FxtbRjISNk0sM9kGYgcyrOXtDnZeBOT+Ir
	 tZ+EfItHUxVrewAPa3hToP8md/PXOkrcjboQZytnCeNZgUqUFqPRDGXG7OD/zeYoly
	 RIC8oJizvqH/hauI8tn7kj2DGm+jTCvidG8Kk7sycaTSMRCjSTe9FZ8yKLfcu6bawh
	 zseKpel9RjUl/jEaYGbpwEVRGJMS2u9gHDvjC78ZiiN56w2/fz8/gX8GOG4CiUtA/8
	 RhihayIhgx8+w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Emil Kronborg <emil.kronborg@protonmail.com>
Subject: [PATCH 1/2] serial: core: introduce uart_port_tx_flags()
Date: Wed, 31 Jan 2024 13:13:57 +0100
Message-ID: <20240131121359.7855-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And an enum with a flag: UART_TX_NOSTOP. To NOT call
__port->ops->stop_tx() when the circular buffer is empty. mxs-uart needs
this (see the next patch).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Emil Kronborg <emil.kronborg@protonmail.com>
---
 include/linux/serial_core.h | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 536b2581d3e2..edefb6d73604 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -748,8 +748,17 @@ struct uart_driver {
 
 void uart_write_wakeup(struct uart_port *port);
 
-#define __uart_port_tx(uport, ch, tx_ready, put_char, tx_done, for_test,      \
-		for_post)						      \
+/**
+ * enum UART_TX_FLAGS -- flags for uart_port_tx_flags()
+ *
+ * @UART_TX_NOSTOP: don't call port->ops->stop_tx() on empty buffer
+ */
+enum UART_TX_FLAGS {
+	UART_TX_NOSTOP = BIT(0),
+};
+
+#define __uart_port_tx(uport, ch, flags, tx_ready, put_char, tx_done,	      \
+		       for_test, for_post)				      \
 ({									      \
 	struct uart_port *__port = (uport);				      \
 	struct circ_buf *xmit = &__port->state->xmit;			      \
@@ -777,7 +786,7 @@ void uart_write_wakeup(struct uart_port *port);
 	if (pending < WAKEUP_CHARS) {					      \
 		uart_write_wakeup(__port);				      \
 									      \
-		if (pending == 0)					      \
+		if (((flags) & UART_TX_NOSTOP) && pending == 0)		      \
 			__port->ops->stop_tx(__port);			      \
 	}								      \
 									      \
@@ -812,7 +821,7 @@ void uart_write_wakeup(struct uart_port *port);
  */
 #define uart_port_tx_limited(port, ch, count, tx_ready, put_char, tx_done) ({ \
 	unsigned int __count = (count);					      \
-	__uart_port_tx(port, ch, tx_ready, put_char, tx_done, __count,	      \
+	__uart_port_tx(port, ch, 0, tx_ready, put_char, tx_done, __count,     \
 			__count--);					      \
 })
 
@@ -826,8 +835,21 @@ void uart_write_wakeup(struct uart_port *port);
  * See uart_port_tx_limited() for more details.
  */
 #define uart_port_tx(port, ch, tx_ready, put_char)			\
-	__uart_port_tx(port, ch, tx_ready, put_char, ({}), true, ({}))
+	__uart_port_tx(port, ch, 0, tx_ready, put_char, ({}), true, ({}))
+
 
+/**
+ * uart_port_tx_flags -- transmit helper for uart_port with flags
+ * @port: uart port
+ * @ch: variable to store a character to be written to the HW
+ * @flags: %UART_TX_NOSTOP or similar
+ * @tx_ready: can HW accept more data function
+ * @put_char: function to write a character
+ *
+ * See uart_port_tx_limited() for more details.
+ */
+#define uart_port_tx_flags(port, ch, flags, tx_ready, put_char)		\
+	__uart_port_tx(port, ch, flags, tx_ready, put_char, ({}), true, ({}))
 /*
  * Baud rate helpers.
  */
-- 
2.43.0


