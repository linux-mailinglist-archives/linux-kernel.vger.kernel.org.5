Return-Path: <linux-kernel+bounces-68208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD3857740
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9681F21545
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8FF1BF47;
	Fri, 16 Feb 2024 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RraAo3q5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E921BC5E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070433; cv=none; b=I81MSrAJE2MzD9KPVR3uoa1xHLk+/5xhRMR5GZH0IfZH4Az20jM/ZzJAxwHuXEJ6Rc+KUEse7eKUlsuWAvgIgseJlQEWf5d4L5cfvFFUVdh6yw0S85lOJ0BgB1XXz69g/iaQ3WCx1CMYnXDkOcoJ1bv0+oS9tpZjQw/gT/qwU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070433; c=relaxed/simple;
	bh=DpW7fdG3PEtBSw4uHybL/y6wUJ0RIFhtQZUvi+EiDQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJusRGlNsDF7ZsAHjdEu2/nUO8ydR22ARxe8drFe2d/J7uMktudVhiK+lkzXQfFcFuDZ6qCHTzk5CpBytGpFueeNdXYPmZLmQtmMdAF4+3nDdURZ+xMOjCpqLhobFaxEqvHfResKBHVMH0Ju9OKDS61m6vrZ4zyHb9K/AiWNOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RraAo3q5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708070431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bho+yn8M4kGUaS4UAXQ+fSY/db1hBVlHnbWifBhcoOQ=;
	b=RraAo3q5dyTB7UDfIRn+NPY26twP/+NfzQNQoOL7jVuF6W3eR7ZZr896GbEahfwks+nXH/
	VeL2hjBoV1zNBturjEXnfZz2s6eTb2UUDLxLkiTFITz0IeYXsvA08yz1VVedQeyXK9XUVV
	iFU0iOj52V5hsoqQgfJ1mQhocwY2X/M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-noXIOcegN7GhhCaugE67Mw-1; Fri, 16 Feb 2024 03:00:29 -0500
X-MC-Unique: noXIOcegN7GhhCaugE67Mw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-785d3e4f98aso189429485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708070429; x=1708675229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bho+yn8M4kGUaS4UAXQ+fSY/db1hBVlHnbWifBhcoOQ=;
        b=nq5oWPgHEEdEdQPK6L19RAPXJsonPr9N8VnOxgYktr1h3+jz+GtuZUVa3/A+ijsOyy
         ZZckuQ0FjwTYIQETx46AAMCo7yTjib0FDAfwfLklrdjIu0uQ48ZTEMOA2NTiQmEb5EdJ
         Vc5MklfCyTYpWgaG+tG4Dex9UsI7X9Ju25t7j0ISslvSd9P5WZkioVe0rav5OG2mYW+T
         Jpzetf6PTRkLB4xanwo2xoR79r3v9Wy3EHEqJbBdV+IJ45zYq9raz1uMj+7qy6JcncI+
         ab2UvZLpsWwvXI6eGfhYDG6OE2fL5SSAHQnkTC1tsycXlFmw/jZC1OMApS3ZbohxBbjv
         pUig==
X-Gm-Message-State: AOJu0YzB5q7wsh0z6wx4Okn7hcwGC/R6salun8wX/SS/QgMZLN3nIe2D
	FMjqXy4kDxtTqa5AopTZs9ZePGsqLbVbKZ3wtam2tfZ9A1zCuONPuz8kaEehJeUpM/GO91XAFFZ
	7ae12ld3YL5cBIfocPtQeXMkZ6vb1WP+AaSwBOqWVNSzkshfRdUY84gbUA3pcbw==
X-Received: by 2002:a05:620a:564a:b0:785:ec1f:6aee with SMTP id vw10-20020a05620a564a00b00785ec1f6aeemr3631452qkn.27.1708070428744;
        Fri, 16 Feb 2024 00:00:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk5xfmE9icqXe3ltJz8nq6nkHMSdP3/86CuMkgc0dqcATRNh3NfMI3OUZi8MhWVBnCnizQ8w==
X-Received: by 2002:a05:620a:564a:b0:785:ec1f:6aee with SMTP id vw10-20020a05620a564a00b00785ec1f6aeemr3631427qkn.27.1708070428387;
        Fri, 16 Feb 2024 00:00:28 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b00787346f1edasm1300756qkb.54.2024.02.16.00.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:00:28 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Leonardo Bras <leobras@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH v2 4/4] tty/serial8250: Make use of IRQ_HANDLED_MANY interface
Date: Fri, 16 Feb 2024 04:59:46 -0300
Message-ID: <20240216075948.131372-6-leobras@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216075948.131372-2-leobras@redhat.com>
References: <20240216075948.131372-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For every TX byte an IRQ is requested.
On threaded IRQs, the handler calls serial8250_tx_chars can send multiple
bytes, limited to it's queue size (tx_loadsz).

When this happens, the handler return IRQ_HANDLED with reduces the
unhandled IRQ counter only by 1, even though many requests have been
handled at once.

This causes the unhandled IRQ counter to go up until it reaches the maximum
and causes the registered IRQ to be disabled, thus breaking the serial
console.

Make use of the newly introduced IRQ_HANDLED_MANY interface to return the
number of requests handled, so the unhandled IRQ counter can get decreased
accordingly.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/serial_8250.h         |  2 +-
 drivers/tty/serial/8250/8250_core.c | 13 ++++++++-----
 drivers/tty/serial/8250/8250_port.c | 16 ++++++++++------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index ec46e3b49ee99..c9d4271b71d70 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -200,7 +200,7 @@ int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
-void serial8250_tx_chars(struct uart_8250_port *up);
+int serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
 void serial8250_set_defaults(struct uart_8250_port *up);
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ae637155fe7cd..2fab9102eec45 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -110,7 +110,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 {
 	struct irq_info *i = dev_id;
 	struct list_head *l, *end = NULL;
-	int pass_counter = 0, handled = 0;
+	int pass_counter = 0, handled_total = 0;
 
 	pr_debug("%s(%d): start\n", __func__, irq);
 
@@ -120,15 +120,18 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 	do {
 		struct uart_8250_port *up;
 		struct uart_port *port;
+		int handled;
 
 		up = list_entry(l, struct uart_8250_port, list);
 		port = &up->port;
 
-		if (port->handle_irq(port)) {
-			handled = 1;
+		handled = port->handle_irq(port);
+		if (handled) {
+			handled_total += handled;
 			end = NULL;
-		} else if (end == NULL)
+		} else if (end == NULL) {
 			end = l;
+		}
 
 		l = l->next;
 
@@ -140,7 +143,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
 	pr_debug("%s(%d): end\n", __func__, irq);
 
-	return IRQ_RETVAL(handled);
+	return IRQ_RETVAL_MANY(handled_total);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f799c34f1603c..74d53507a73d4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1802,7 +1802,7 @@ u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_chars);
 
-void serial8250_tx_chars(struct uart_8250_port *up)
+int serial8250_tx_chars(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 	struct circ_buf *xmit = &port->state->xmit;
@@ -1810,15 +1810,15 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 
 	if (port->x_char) {
 		uart_xchar_out(port, UART_TX);
-		return;
+		return 0;
 	}
 	if (uart_tx_stopped(port)) {
 		serial8250_stop_tx(port);
-		return;
+		return 0;
 	}
 	if (uart_circ_empty(xmit)) {
 		__stop_tx(up);
-		return;
+		return 0;
 	}
 
 	count = up->tx_loadsz;
@@ -1858,6 +1858,9 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	 */
 	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
 		__stop_tx(up);
+
+	/* Return number of chars sent */
+	return up->tx_loadsz - count;
 }
 EXPORT_SYMBOL_GPL(serial8250_tx_chars);
 
@@ -1923,6 +1926,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	bool skip_rx = false;
 	unsigned long flags;
 	u16 status;
+	int handled = 0;
 
 	if (iir & UART_IIR_NO_INT)
 		return 0;
@@ -1956,14 +1960,14 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	serial8250_modem_status(up);
 	if ((status & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
 		if (!up->dma || up->dma->tx_err)
-			serial8250_tx_chars(up);
+			handled = serial8250_tx_chars(up);
 		else if (!up->dma->tx_running)
 			__stop_tx(up);
 	}
 
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 
-	return 1;
+	return handled ? : 1;
 }
 EXPORT_SYMBOL_GPL(serial8250_handle_irq);
 
-- 
2.43.2


