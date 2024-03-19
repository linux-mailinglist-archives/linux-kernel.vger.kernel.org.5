Return-Path: <linux-kernel+bounces-107974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B974A880453
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753E4282BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26402C6A9;
	Tue, 19 Mar 2024 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="NPRXUTTh"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383482BCF7;
	Tue, 19 Mar 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871383; cv=none; b=khSj3nm9ysYt8PmyUs+F0eWj/ln+BqEb642NAOEWyICRsiQBW8oLYVz9syIJ9ecqEH3ikcqZk008dwNmMzyfg4cSohhLcrHUE31Uc46EbK+udGIiXjJ2TxMbegD1MyFdDCqBtm7ctGKLynLBRSLkooGb0acfSFZRRpzvbbqabvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871383; c=relaxed/simple;
	bh=/bOYxA0veCdTw7dWZj2qwekiYpyvVOARZ2+vTVGh08w=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WfOP4U/HlDDutEsZQXTAOcf5n0Y8i1XAqZ2Eofrwyio1Ub7B50YhGoaOofTphI7W0/f+jmaDcTF4wTLv6tqIrXmNgyEEgpZFV4eXrwyomoQAwU35nR8OP2X8o3EC+vYlOA0xRoheTqFytFNBY/VO2upGkR4HnnMNleYkY30mtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=NPRXUTTh; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1710871373; x=1711130573;
	bh=AA4YbM0umuAl4kGtml9n7UI9KGtZnTLfV5Axe2bZA3o=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NPRXUTThmrkX0+ybosBhdcwELKM7EDYZ1SURCv6t1gUFPUdp4yRh0BKPtZkelos1h
	 VJyfQboos07nSBKJAQi2CC77UPYPMQ7KHYpWLtpcRA5aVi50yxNkLI1yKvRAKteEng
	 pLa9qvEa9eTfp1+PdhAhY68QH4eHkZ2ndrWVHWXxDIpvUOwZ+thr6oRP0NDGCtUygz
	 meIjrX2AnRfNsa6aizGo4Gh7vdjB/JDx7J8Qa9H5baaJmW8KhXtzIHKNIjk63ovKpf
	 K2MBEFY5CoFFTZqUTUylA8O0ovgUUwwc7R1/ZSyjrhUWpg3ez8f2tKm/Kplu4vmy2U
	 WJXva94zvDztA==
Date: Tue, 19 Mar 2024 18:02:47 +0000
To: jirislaby@kernel.org, gregkh@linuxfoundation.org
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Emil Kronborg <emil.kronborg@protonmail.com>, stable@vger.kernel.org
Subject: [PATCH v2] serial: mxs-auart: add spinlock around changing cts state
Message-ID: <20240319180239.69765-1-emil.kronborg@protonmail.com>
Feedback-ID: 20949900:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The uart_handle_cts_change() function in serial_core expects the caller
to hold uport->lock. For example, I have seen the below kernel splat,
when the Bluetooth driver is loaded on an i.MX28 board.

    [   85.119255] ------------[ cut here ]------------
    [   85.124413] WARNING: CPU: 0 PID: 27 at /drivers/tty/serial/serial_co=
re.c:3453 uart_handle_cts_change+0xb4/0xec
    [   85.134694] Modules linked in: hci_uart bluetooth ecdh_generic ecc w=
lcore_sdio configfs
    [   85.143314] CPU: 0 PID: 27 Comm: kworker/u3:0 Not tainted 6.6.3-0002=
1-gd62a2f068f92 #1
    [   85.151396] Hardware name: Freescale MXS (Device Tree)
    [   85.156679] Workqueue: hci0 hci_power_on [bluetooth]
    (...)
    [   85.191765]  uart_handle_cts_change from mxs_auart_irq_handle+0x380/=
0x3f4
    [   85.198787]  mxs_auart_irq_handle from __handle_irq_event_percpu+0x8=
8/0x210
    (...)

Cc: stable@vger.kernel.org # v6.1+
Fixes: 4d90bb147ef6 ("serial: core: Document and assert lock requirements f=
or irq helpers")
Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
---
Changes in v2:
- Add more of the stack trace to show why the lock is necessary. Note
  that i removed some unrelated noise for unwinding, showing and dumping
  the stack trace.
- Add Fixes tag. Note that this commit do not fix 4d90bb147ef6 ("serial:
  core: Document and assert lock requirements for irq helpers") as such,
  but it was the closest commit I could find that makes sense.
- Cc stable. Commit b0af4bcb4946 ("serial: core: Provide port lock
  wrappers") is a prerequisite. Therefore, v6.1+.

 drivers/tty/serial/mxs-auart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.=
c
index 4749331fe618..1e8853eae504 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1086,11 +1086,13 @@ static void mxs_auart_set_ldisc(struct uart_port *p=
ort,
=20
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
-=09u32 istat;
+=09u32 istat, stat;
 =09struct mxs_auart_port *s =3D context;
 =09u32 mctrl_temp =3D s->mctrl_prev;
-=09u32 stat =3D mxs_read(s, REG_STAT);
=20
+=09uart_port_lock(&s->port);
+
+=09stat =3D mxs_read(s, REG_STAT);
 =09istat =3D mxs_read(s, REG_INTR);
=20
 =09/* ack irq */
@@ -1126,6 +1128,8 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void=
 *context)
 =09=09istat &=3D ~AUART_INTR_TXIS;
 =09}
=20
+=09uart_port_unlock(&s->port);
+
 =09return IRQ_HANDLED;
 }
=20
--=20
2.44.0



