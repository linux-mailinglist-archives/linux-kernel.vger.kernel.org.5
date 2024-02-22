Return-Path: <linux-kernel+bounces-76726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2EE85FB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349F51C20A75
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFF71482EA;
	Thu, 22 Feb 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw8pHSsc"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58E23DB9A;
	Thu, 22 Feb 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613469; cv=none; b=qctVClt5+ISAPipuAf3Mcxcf0DYXAY1GqAMRS7nia6vfLhJu51bKKbNxCSAPJtHdxXgXP9fA7mjkHSzbT4Kvo0On4JbPeF6qOgZGtH/Uaz727GNxQR8R9vcSb6wrUInuebQYi1tPD7TfPstS96HDFv90OlfU4LUMyk8IBd52va8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613469; c=relaxed/simple;
	bh=QaAhI/wbbBAuiLt9QHQSbVsKeYt5VzZ02DUcj9u9Pa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jw8kpqrAV6uXBAdizr/RS66X87IbmW3Zgk+wj3LWrS3FwtjPbyh240cZfat0mlaZnRD5nx3YOvEkqchSDcqDWxoyi8wZJ5m8lbF5+rQJ/IIH0iD5QDVjhk4CzV1g/ykY0gsHQwragZ7jVQmBn3cEnWP28TuxeSLXh78AYGErQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw8pHSsc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512d8fe4fceso1201538e87.3;
        Thu, 22 Feb 2024 06:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708613466; x=1709218266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+We9WJEv1KV+ZKPjgcW2YQTM92TLBV7sBEUyk52zXI=;
        b=Fw8pHSsc0Kosu5HrpS+o79ue4mSs+mk9KBkNPr1tN598JcgcoYnXQbtNFUFVMMjFrH
         UlaJK8oJXusmUzLciyPf76O5G0MgejbNvPUwSEg7+Xq63lxh3TXi7J1jT7MGdzlDCUiB
         XUuqm6HrpWaXA26ILQrOU/vpbtJdrTAOT1TpYydwk4KlAtq9ELoNgXZIQfjeF/zq7RX6
         cQZ5173R4/XBgd4RGrvtl1fhuSqO/pCPqBLDayL8tEBQ8jPzfRotjkbowFLHNMYtNx/G
         YCYpxk8o5g6XoyaeLgBwgdXdDuy/I9iy67yyyAghE/CMCv7aQaQhM/eVopGbiTxIEcrC
         vPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708613466; x=1709218266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+We9WJEv1KV+ZKPjgcW2YQTM92TLBV7sBEUyk52zXI=;
        b=ppus9Sg8l3bfpyr6bBYyPkbVKL4zYcpPBW46eeleL/XojhFZkWEUqt0UmUk42t9Pr4
         TWXQqzGFGX3Ps8vX3fIpYc1oCfIsbCiXBaoYNwCw5UBepZb6xLWbCYabdcIYLrSoqrO7
         9e1B0uT2OI9c3Ek63O//fOcscimECuJDgVex5QFEMQQQwUq1bmjWC1wNogrXGvIGvHqu
         G0no7CQ2PLUKBQgrvzFKhqZOOE+AGhyQZGEGM1a8mPGZH9G4yzFGjaddj8NzGGdCV4t/
         oYd0kldNJx9xT6IiLSIeHBq2v4HH6QhdeAlZSo8AsoT1tplxjNDcJXqby7IOeLYZiVyg
         olZg==
X-Forwarded-Encrypted: i=1; AJvYcCV7BLEPbdQT8u26DoCIyyUGb2+l8KlycizPRdqXTeWKS0qEGi/i6rAn4BS5UHyOODxYeg9Kjg6hfRVm2dpayNoA+IZV4h3EevbfH7ltlaBCtZ0l6VWSYupo7098vIH1NRQ/xnQP1Ukah2ZD
X-Gm-Message-State: AOJu0Yz0eq5QR9WrYNBD7LlW8Z4B4TvvB7iQrDAcnFi6Kq3TxXFzGISk
	P3r26bUmjZisxUNaN4vrqnoPfX3YvbCc7zVfYJn9uysv7jT5oJbpX0AdFx2XCqM=
X-Google-Smtp-Source: AGHT+IF0dVYPTtTO9cnO6b9aLE7e/Kms6Qc0pHEV290SQdeghRfb5j3grfWht7aqt+2H3RhR89xc3g==
X-Received: by 2002:a05:6512:6d5:b0:512:df5b:ee91 with SMTP id u21-20020a05651206d500b00512df5bee91mr1366298lff.30.1708613465620;
        Thu, 22 Feb 2024 06:51:05 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id r8-20020ac25f88000000b0051144c7cf9esm2085194lfe.265.2024.02.22.06.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:51:05 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: Use serial8250_do_set_termios for uartclk updating
Date: Thu, 22 Feb 2024 17:50:56 +0300
Message-ID: <20240222145058.28307-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The serial8250_update_uartclk() body was created based on the several
method calls copied from the serial8250_do_set_termios() function. Seeing
aside with some other things the later method can update the baud rate
based on the new reference clock let's just call it instead thus
simplifying the code a bit.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/linux-serial/ZczD7KPbeRnY4CFc@black.fi.intel.com
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8ca061d3bbb9..a74d39846dd4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2714,12 +2714,8 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
  */
 void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 {
-	struct uart_8250_port *up = up_to_u8250p(port);
 	struct tty_port *tport = &port->state->port;
-	unsigned int baud, quot, frac = 0;
-	struct ktermios *termios;
 	struct tty_struct *tty;
-	unsigned long flags;
 
 	tty = tty_port_tty_get(tport);
 	if (!tty) {
@@ -2740,21 +2736,7 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 	if (!tty_port_initialized(tport))
 		goto out_unlock;
 
-	termios = &tty->termios;
-
-	baud = serial8250_get_baud_rate(port, termios, NULL);
-	quot = serial8250_get_divisor(port, baud, &frac);
-
-	serial8250_rpm_get(up);
-	uart_port_lock_irqsave(port, &flags);
-
-	uart_update_timeout(port, termios->c_cflag, baud);
-
-	serial8250_set_divisor(port, baud, quot, frac);
-	serial_port_out(port, UART_LCR, up->lcr);
-
-	uart_port_unlock_irqrestore(port, flags);
-	serial8250_rpm_put(up);
+	serial8250_do_set_termios(port, &tty->termios, NULL);
 
 out_unlock:
 	mutex_unlock(&tport->mutex);
-- 
2.43.0


