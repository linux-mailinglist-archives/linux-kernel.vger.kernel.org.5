Return-Path: <linux-kernel+bounces-147386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0131B8A733A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970401F21F55
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73981369B9;
	Tue, 16 Apr 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Wg4PaEEn"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2D2C6A3;
	Tue, 16 Apr 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292229; cv=none; b=FVNreKo/6EBc30QB7Pjn3v9jme7no77Xv1cb1NOeTsqHka4eeB3XaRrwfkBHri96u1KPIjnytY6XJp1sReS5s8tQ8wl553obsv2l3QfTDIvakIDGLLE+fUc6MfD9xuRPn4kkOayY2ZTArrkTJ3C61tOGRqKo/NOp+hf3HiJMbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292229; c=relaxed/simple;
	bh=BOgkAFFdf2wnO9hL/ivSNkM9DBF2bbinKHnkCviT4l8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiH4wni/L5MfstRP6f8Q5YSvkgp4lt7gvjXhV+toA+oCEeRXr/Dab6oydIP4ob83Us520dZJjWzmtywomEpSplGJ9AzIXbLr3pNBoiJbqFOXgsU67wJ5qHRUm0iUQ+T83nWxkKh/0N65FYpCivcn5POlm8eXbad4ySBxzN2vVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Wg4PaEEn; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1713292225; x=1713551425;
	bh=62YpHOvZnZ8olaQOV9AE7phGelntP6xtyhEl8JdkA54=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Wg4PaEEnIx5Lk0zDGjMn6BASw1bt7to6J/Otm4Qg5gGACUkF2rEBqmcYuHbduwckQ
	 H1eo4AJvG3DCpM9CG0k90JV04Y95S8+grRhuFgIlKPdbbC7n44ZULp+QPalg+XNLE0
	 By9mcXrdmEjIw0e41WckW7a/gmG3c5RRA9bNKkfaeuNIIGFAssv+jM1995X88Mgm/N
	 A/sID5Ok081/ygln9wjKqztDlG21Rm6msq3y/xotQbnVtCAQXlK4v5kYzlj+A9mgla
	 qhJNgvAlLImKeJAI7VVqwLilQfcatPe1Sk/FYo5r7zrxe/g0QpIhyB1cVmU2Yh/Xt5
	 OgauEt/0LlMRw==
Date: Tue, 16 Apr 2024 18:29:56 +0000
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>, Michael Pratt <mcpratt@pm.me>
Subject: [PATCH v2 2/3] serial: 8250: Store whether fifo device is enabled
Message-ID: <20240416182741.22514-3-mcpratt@pm.me>
In-Reply-To: <20240416182741.22514-1-mcpratt@pm.me>
References: <20240416182741.22514-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Currently, there are 7 checks for whether to enable
the internal fifo device of a 8250/16550 type uart.

Instead of checking all 7 values again whenever
we need to know whether we have the fifo device enabled,
store the result as a struct member of uart_8250_port.

This can, for example, lessen the amount
of calculations done during a write operation.

Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
V1 -> V2: new commit

 drivers/tty/serial/8250/8250_port.c | 2 ++
 include/linux/serial_8250.h         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index fc9dd5d45295..5b0cfe6bc98c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3392,6 +3392,8 @@ void serial8250_console_write(struct uart_8250_port *=
up, const char *s,
 =09=09 */
 =09=09!(up->port.flags & UPF_CONS_FLOW);
=20
+=09up->fifo_enable =3D use_fifo;
+
 =09if (likely(use_fifo))
 =09=09serial8250_console_fifo_write(up, s, count);
 =09else
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index fd59ed2cca53..017429f0e743 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -127,6 +127,7 @@ struct uart_8250_port {
 =09struct list_head=09list;=09=09/* ports on this IRQ */
 =09u32=09=09=09capabilities;=09/* port capabilities */
 =09u16=09=09=09bugs;=09=09/* port bugs */
+=09unsigned int=09=09fifo_enable;=09/* fifo enabled if capable */
 =09unsigned int=09=09tx_loadsz;=09/* transmit fifo load size */
 =09unsigned char=09=09acr;
 =09unsigned char=09=09fcr;
--=20
2.30.2



