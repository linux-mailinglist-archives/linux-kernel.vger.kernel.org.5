Return-Path: <linux-kernel+bounces-104589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6281E87D082
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B6C1C21B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF113F8D1;
	Fri, 15 Mar 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rWoBVUUG"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3144C86
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517375; cv=none; b=pufxrK6GkbaUo+9nv5dFzvDH+2C2FOtjPxr1kNEkuUi8o4vjavwy7N2beGjNjgfso9QC6A9522q+eAeEZe3yRN/lRXHzQra5zG23ETWnCQXPWpcX3ZIPbYn9DC2nG5ZXDTtrqbq9sfGaX09mz/aJ1KRTlDt1vr1KKYvVhX7Mn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517375; c=relaxed/simple;
	bh=fsyEjpuzw7b3BmMY75bgJU7kV32poCTX+CSZE8V0/E8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sL659Y9kStdkmGML5wS0vKlYdvUfq7PxEmLMV8jnpcPplrZmaE+AEFLdptawjSy0GU/rXe2rZSCFR+oAvKeo1347nTyVyNtGUDQ8hDCLloIs3RBWx8SrRgrn05kwpOxvjZVupvVKMPpCEStfZMVw2G6Vx4Bh7jxvaGW+uNTkjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rWoBVUUG; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1710517366; x=1710776566;
	bh=Ey8hbUiqjXiR3zJGD+LfivZVhBQolmYLR6mAIqJ1U14=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rWoBVUUGL3hDfLbPM4hG54IA8djFM2hbgwjbHjdXlMczCs+tTCIu/VOdLwHCWoNcx
	 WnOgpjmfHASbi28mCnLcbtWH5MADtbC/b9xpXI5j6p8unZsS4KfaxLCiWr4Q/Y7TWM
	 GiqRjq490ntDHtIoixozXpqSkSc1YbxCnoaFhQI3rGdu+U9uTMXmnI25r6+E4PXYDW
	 akN80JUnyroJJwsXkFAho8mds1HXhgqM7TKVBZY8Wk1FgGIcjjD/IKlbD7DTf3MY07
	 5BgUUZmH3BLRi8NloCdp86ox6HmlFK+sYe7SU9gvGA4F8qSVN3hpFufTOatN58WG42
	 qEFLlTQGvvsvA==
Date: Fri, 15 Mar 2024 15:42:29 +0000
To: jirislaby@kernel.org, gregkh@linuxfoundation.org
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Emil Kronborg <emil.kronborg@protonmail.com>
Subject: [PATCH] serial: mxs-auart: add spinlock around changing cts state
Message-ID: <20240315154150.28391-1-emil.kronborg@protonmail.com>
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
    [   85.164243]  unwind_backtrace from show_stack+0x10/0x14
    (...)

Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
---
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



