Return-Path: <linux-kernel+bounces-108897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1854881186
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C791B224DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6853FB84;
	Wed, 20 Mar 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ceFRikTm"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD5347B6;
	Wed, 20 Mar 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936951; cv=none; b=nXHD11bV8OTHU/0xkJ8eRY/SEGD6Z5+shCnrA2zI5Kt+uOggJfUEbVKUthBoqnoAq7UZf2k245i+6b+9xEMzSGq0a+qa0UiqKWXiMuxwBUzE8w71mmm1+58axo9wyAKtJis0vqUWMEKQpDuEEp6ACm+YreZRxQX6GeHh4XRiH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936951; c=relaxed/simple;
	bh=icCOddxJucyQGAwO1xY/XiG/Q3JgHVedjvn3506ChdU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Isb8gfUSUgR0UGia/tltMAzBE933TD6vYur47WswgIqSZ/X0J4oOJqNCXJUG6auRN7jltLJAHfjCOOSKyeTO0zHCVKK7wr28krSTa4O2UN0p8dmb4ngCKnljVutbzQFufBExrdYQgvrswVxR7lF2w8XYnO35ADxmcdiYd03UA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ceFRikTm; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1710936946; x=1711196146;
	bh=hrhEkdmz0bda6xif5V4a29xg5PpADmwyOkTCS+waL7s=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ceFRikTm1IiNNVPOhnISV8qVpdelqJ33F15DUsJLpI3RJgisESC+j4UatluzI5o1H
	 qu1I82s9WkMamYRmCENMdU08ypS8966hc3CMA84IyoEoToOPCSv4Pbn29tdj6fpmVC
	 tXKpRkRFKQGi2W9oiG5bPSeSNf3VdVqDtTgx1loJiucbhEC22aqKYcAoWN+ohmigqW
	 A0K9OZXrnYEO0oA5A2nL3UKjwT1PQzbNjN8j6JtxLMVjxtqahsyV2webvQQC2ZU9Cs
	 2hSXssimo2RqG09dnVX/KLw+uNlRfaubijK3ipwMhkCbCUYdSFQWtorcGi10cK9AZ/
	 7rp8OsheUX/cA==
Date: Wed, 20 Mar 2024 12:15:36 +0000
To: jirislaby@kernel.org, gregkh@linuxfoundation.org
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Emil Kronborg <emil.kronborg@protonmail.com>, stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3] serial: mxs-auart: add spinlock around changing cts state
Message-ID: <20240320121530.11348-1-emil.kronborg@protonmail.com>
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

Cc: stable@vger.kernel.org
Fixes: 4d90bb147ef6 ("serial: core: Document and assert lock requirements f=
or irq helpers")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
---
Changes in v3:

I misunderstood how additional instructions for the stable team work;
sorry about that. Therefore, the only change in this version is the
removal of the "Cc" tag, which no longer includes v6.1+ as a
prerequisite. Additionally, I included Frank's Reviewed-by in the patch.

Since the Fixes commit has been included since v3.18, this patch should
be backported to all currently maintained stable kernels. However, for
backporting to v6.6 and earlier, either b0af4bcb4946 ("serial: core:
Provide port lock wrappers") needs to be included, or those helpers must
be open-coded, i.e. doing spin_lock(&s->port.lock); instead of
uart_port_lock(&s->port);.

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



