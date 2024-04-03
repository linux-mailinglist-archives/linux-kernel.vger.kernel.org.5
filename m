Return-Path: <linux-kernel+bounces-130277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FBD897643
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78B31C2885C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E62154BE2;
	Wed,  3 Apr 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJxy1UGt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BC153BE0;
	Wed,  3 Apr 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164620; cv=none; b=rfzRQXqgaga7xrielKqcZxtNQO+YkAEpXHwzTXg4Q/i1is47iyP/601ojAMxo0QaKKXyjdKMGZjQ6meM9iBzSeGw3ppn/Xy4ldimmMH8uZNzrtV0gQFpG7Fu2ytMu6L9/545SWlRH+EDmBKHQtZ83zR91t/FF49OHT8XL//Wd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164620; c=relaxed/simple;
	bh=Rdq/tCZloRjmO30scHy8wsKZG4mD07IlY6+90beOSuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcFRBWPQ1VEh6iv3zQx9fN9BWIKEkCU0PBU3jORt9HSsQjQfdof4pwl88lnwBGVW8CxPn1PeGvzuwoRLd+6sZjnSDFStz9YnLA6irl76cx3ikoCW+pu9YMBzt+pk0ezblA/o2jfRvWEK5KdQcB1fkvJdFICkKSDbpDbgMiED5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJxy1UGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925BFC433B2;
	Wed,  3 Apr 2024 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164619;
	bh=Rdq/tCZloRjmO30scHy8wsKZG4mD07IlY6+90beOSuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJxy1UGtzC7hhGWqTsQTUx9beRl4WLaSbKFzckbjYwEI+34iAfW3Nzq4ST60m7Mt8
	 ya7Drt0rYwS5LOwFpuNb+Mv/M0m9VYmMzzvsoWLX6UbAa8nUutucMJAbpzTwx9PJVU
	 68RM8AwVE7fW5YevHxR5r+AxQHtzEaPOHkHSZ/iB3SRGsM/C59zXSCCd/mNOxZ33Ye
	 qZBQopK8OXlf2cSsd5UrcKRMB9QgeJHw52849dzs7tjG+pthjwkzMguPGlWTvJu0hz
	 9letp9ICVi2E+clOw1oRtsA93qHPmAAKeyxtheWHJWRO15RtnGKsRdM9zjhlyeJRVP
	 k3aXSQjKKPtYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	jirislaby@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 03/28] serial: qcom-geni: Don't cancel/abort if we can't get the port lock
Date: Wed,  3 Apr 2024 13:16:05 -0400
Message-ID: <20240403171656.335224-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 9e957a155005b16af057e86c6bcc1197cd70a6af ]

As of commit d7402513c935 ("arm64: smp: IPI_CPU_STOP and
IPI_CPU_CRASH_STOP should try for NMI"), if we've got pseudo-NMI
enabled then we'll use it to stop CPUs at panic time. This is nice,
but it does mean that there's a pretty good chance that we'll end up
stopping a CPU while it holds the port lock for the console
UART. Specifically, I see a CPU get stopped while holding the port
lock nearly 100% of the time on my sc7180-trogdor based Chromebook by
enabling the "buddy" hardlockup detector and then doing:

  sysctl -w kernel.hardlockup_all_cpu_backtrace=1
  sysctl -w kernel.hardlockup_panic=1
  echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT

UART drivers are _supposed_ to handle this case OK and this is why
UART drivers check "oops_in_progress" and only do a "trylock" in that
case. However, before we enabled pseudo-NMI to stop CPUs it wasn't a
very well-tested situation.

Now that we're testing the situation a lot, it can be seen that the
Qualcomm GENI UART driver is pretty broken. Specifically, when I run
my test case and look at the console output I just see a bunch of
garbled output like:

  [  201.069084] NMI backtrace[  201.069084] NM[  201.069087] CPU: 6
  PID: 10296 Comm: dnsproxyd Not tainted 6.7.0-06265-gb13e8c0ede12
  #1 01112b9f14923cbd0b[  201.069090] Hardware name: Google Lazor
  ([  201.069092] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DI[
  201.069095] pc : smp_call_function_man[  201.069099]

That's obviously not so great. This happens because each call to the
console driver exits after the data has been written to the FIFO but
before it's actually been flushed out of the serial port. When we have
multiple calls into the console one after the other then (if we can't
get the lock) each call tells the UART to throw away any data in the
FIFO that hadn't been transferred yet.

I've posted up a patch to change the arm64 core to avoid this
situation most of the time [1] much like x86 seems to do, but even if
that patch lands the GENI driver should still be fixed.

>From testing, it appears that we can just delete the cancel/abort in
the case where we weren't able to get the UART lock and the output
looks good. It makes sense that we'd be able to do this since that
means we'll just call into __qcom_geni_serial_console_write() and
__qcom_geni_serial_console_write() looks much like
qcom_geni_serial_poll_put_char() but with a loop. However, it seems
safest to poll the FIFO and make sure it's empty before our
transfer. This should reliably make sure that we're not
interrupting/clobbering any existing transfers.

As part of this change, we'll also avoid re-setting up a TX at the end
of the console write function if we weren't able to get the lock,
since accessing "port->tx_remaining" without the lock is not
safe. This is only needed to re-start userspace initiated transfers.

[1] https://lore.kernel.org/r/20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20240112150307.2.Idb1553d1d22123c377f31eacb4486432f6c9ac8d@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 99e08737f293c..f9f7ac1a10df3 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -488,18 +488,16 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 
 	geni_status = readl(uport->membase + SE_GENI_STATUS);
 
-	/* Cancel the current write to log the fault */
 	if (!locked) {
-		geni_se_cancel_m_cmd(&port->se);
-		if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-						M_CMD_CANCEL_EN, true)) {
-			geni_se_abort_m_cmd(&port->se);
-			qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-							M_CMD_ABORT_EN, true);
-			writel(M_CMD_ABORT_EN, uport->membase +
-							SE_GENI_M_IRQ_CLEAR);
-		}
-		writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+		/*
+		 * We can only get here if an oops is in progress then we were
+		 * unable to get the lock. This means we can't safely access
+		 * our state variables like tx_remaining. About the best we
+		 * can do is wait for the FIFO to be empty before we start our
+		 * transfer, so we'll do that.
+		 */
+		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
+					  M_TX_FIFO_NOT_EMPTY_EN, false);
 	} else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
 		/*
 		 * It seems we can't interrupt existing transfers if all data
@@ -516,11 +514,12 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 
 	__qcom_geni_serial_console_write(uport, s, count);
 
-	if (port->tx_remaining)
-		qcom_geni_serial_setup_tx(uport, port->tx_remaining);
 
-	if (locked)
+	if (locked) {
+		if (port->tx_remaining)
+			qcom_geni_serial_setup_tx(uport, port->tx_remaining);
 		uart_port_unlock_irqrestore(uport, flags);
+	}
 }
 
 static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
-- 
2.43.0


