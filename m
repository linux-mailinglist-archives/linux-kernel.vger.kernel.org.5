Return-Path: <linux-kernel+bounces-47991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E78455D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91FA1F25FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6015B98F;
	Thu,  1 Feb 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jm3hRClr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2411A28;
	Thu,  1 Feb 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784961; cv=none; b=ONW8I8IHx5s4xf5obDO1GpCgre5ZFgejn3y1fV/ESe6uHrlgjOMBCrC1d46+JYmEbOckvifYobD1nfAcg2zfcn8nH7YOIn13jyfx4+GrXrPH/luMwViVGDbSGmxZUPcXTcRcDP+mxNxcGzDnKJO3JFg2lFoCYoqZqSwIxomi550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784961; c=relaxed/simple;
	bh=8xZUfd2otuKI9fuM5EHBBR4C7/ZhTByLG9LSNa2l4UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnp1iLaxQKdVZ1RTel6WK1AJwr8YjpFuuw92jbbLC/STxludBkvh1w99lzcgTMcqmjYJdnd7a8dfyA02S2UM5R6GLW9e8VEr+h90SeDaCi9AEq1sBOMy1Gb8bd+27Qe1jvHDxI/9Aorb7PYlSgcYwLLoEiIPXH/sa1sNkdu4C2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jm3hRClr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0520FC433F1;
	Thu,  1 Feb 2024 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706784961;
	bh=8xZUfd2otuKI9fuM5EHBBR4C7/ZhTByLG9LSNa2l4UE=;
	h=From:To:Cc:Subject:Date:From;
	b=Jm3hRClreZUu5y+yJN+HH+aXnnZ8EdHuJI90VKlKqEoaAUd3jsbQ9klI6ewfQv3+R
	 +/1Ps+qfOXne2oYtGCEkXoaXQfD8v08UtwGIji4D5MTgBDIcoQe9SrmxXPHXox1HBj
	 /gbKg5qnvHhZN75Gmk2d/+VLPAUXmaJInF5/I6iuH/DBW3HreL1XIpNXWNWOTlQGzi
	 flUYes2xnqYKp2uKU6OLz/S4FjDmyHxDzjT0XnNEExQCkfSKRxSc/ZGw5Y+4gi2cHP
	 stsp/qGv9AYzDkuPyrwBSXWwo/cTF9yepX5uJztvSBJyn3P5Hbi9ufLqAghiTx8uhP
	 GEQvCqZ6jRhrg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Emil Kronborg <emil.kronborg@protonmail.com>
Subject: [PATCH v2 1/2] serial: core: introduce uart_port_tx_flags()
Date: Thu,  1 Feb 2024 11:55:56 +0100
Message-ID: <20240201105557.28043-1-jirislaby@kernel.org>
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

Notes:
    [v2] fix/invert the condition

 include/linux/serial_core.h | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 536b2581d3e2..55b1f3ba48ac 100644
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
+		if (!((flags) & UART_TX_NOSTOP) && pending == 0)	      \
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


