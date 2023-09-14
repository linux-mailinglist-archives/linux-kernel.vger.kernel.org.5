Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5667A0D36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbjINSld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbjINSjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38CC26B3;
        Thu, 14 Sep 2023 11:39:00 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17zj637DQkryRYGb4/9wkWuly22RRdW4LfXIGp3ap80=;
        b=gJJt8ECptIei3pjqa8XEVI+Fwjnumc3jdwgKHE1l8lrc9aoruj1uhfU5thGoUQktKtVykB
        i9R0cnq6YsLdnagbYQxc7STHZFFZgEdYBFjDL/zlU1nFx1KTdKV1QqmYZND5Suu3uV8NBj
        e5GZbEMgaCAS2mUB2re+7iJgGrmGCxjoDuVMlC5AiBvUn2LnOt/r+bI1n7lVDOxE2NPcll
        bGvchLP71BEje107RFPk4AJD8Nbi/r5tYyiUXkKmPxwGPVyD5j++W5xMPY1FyGWqKhncW2
        wPHWMbjrp4EJyL6zrnGddSIClo6BeuWKR12+6RqpXNt2sS6CIYakWxIy9AFx1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17zj637DQkryRYGb4/9wkWuly22RRdW4LfXIGp3ap80=;
        b=trnfmLCq598rEijUt+3jLrOeWMN5bTzCu2nDNdwBc7BKdrhgvOzyjV0oc1f/S8ypF8LsKA
        gYEZTR+YnQA9qxDg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH tty v1 49/74] serial: qcom-geni: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:06 +0206
Message-Id: <20230914183831.587273-50-john.ogness@linutronix.de>
In-Reply-To: <20230914183831.587273-1-john.ogness@linutronix.de>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

When a serial port is used for kernel console output, then all
modifications to the UART registers which are done from other contexts,
e.g. getty, termios, are interference points for the kernel console.

So far this has been ignored and the printk output is based on the
principle of hope. The rework of the console infrastructure which aims to
support threaded and atomic consoles, requires to mark sections which
modify the UART registers as unsafe. This allows the atomic write function
to make informed decisions and eventually to restore operational state. It
also allows to prevent the regular UART code from modifying UART registers
while printk output is in progress.

All modifications of UART registers are guarded by the UART port lock,
which provides an obvious synchronization point with the console
infrastructure.

To avoid adding this functionality to all UART drivers, wrap the
spin_[un]lock*() invocations for uart_port::lock into helper functions
which just contain the spin_[un]lock*() invocations for now. In a
subsequent step these helpers will gain the console synchronization
mechanisms.

Converted with coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/tty/serial/qcom_geni_serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b8aa4c1293ba..7e78f97e8f43 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -482,9 +482,9 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 
 	uport = &port->uport;
 	if (oops_in_progress)
-		locked = spin_trylock_irqsave(&uport->lock, flags);
+		locked = uart_port_trylock_irqsave(uport, &flags);
 	else
-		spin_lock_irqsave(&uport->lock, flags);
+		uart_port_lock_irqsave(uport, &flags);
 
 	geni_status = readl(uport->membase + SE_GENI_STATUS);
 
@@ -520,7 +520,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		qcom_geni_serial_setup_tx(uport, port->tx_remaining);
 
 	if (locked)
-		spin_unlock_irqrestore(&uport->lock, flags);
+		uart_port_unlock_irqrestore(uport, flags);
 }
 
 static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
@@ -970,7 +970,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	if (uport->suspended)
 		return IRQ_NONE;
 
-	spin_lock(&uport->lock);
+	uart_port_lock(uport);
 
 	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
 	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
-- 
2.39.2

