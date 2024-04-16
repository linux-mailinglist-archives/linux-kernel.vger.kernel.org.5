Return-Path: <linux-kernel+bounces-147393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1014C8A734C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423191C226AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F61369B1;
	Tue, 16 Apr 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="hn1CQ/Gg"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B5132C37
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292467; cv=none; b=sBc7rUQ5PX/CvYU53wqCSUhOEV3f7aEjJs6V5n1xZl0+/YbCLVji4ckzz7ZbgWFOjCfNmoo7GWzlCHW51w42R3P3ttwEIQOvg6ukp5icORZb7RySOqpMSDWpQIlepMq1zEK1R2Ml99RzlxSGrWV1M+WcvriV+xvxHKdberkHpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292467; c=relaxed/simple;
	bh=SZ9BlOq9LC/Dzi9Ke1GsgNFBMPYPVQktfTHm/zfvHdA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvZRASXD2WL6nz2LCGYn07KjUnbImM8WnLbK4MEu2CuS622qnPbmx7MCDOUUm6acjP5RuduhoyEV73Uk9z+QWNRHkuOkXswhKdWP6LVdP9Lu5hODyJfAI3tTneUxAHagYG4l/1lgWOnCTv5J+MLy1PJER+NeDzLkiFU0u1NJle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=hn1CQ/Gg; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1713292463; x=1713551663;
	bh=SZ9BlOq9LC/Dzi9Ke1GsgNFBMPYPVQktfTHm/zfvHdA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hn1CQ/GgpX9BczIc9SqdPGiPdserIrTIiPm9lk0gzJXJGax1LwhZF7As1Z2/jcgdi
	 87gXJOIITzGmbfKhFfOzX8sWkhNDDmk7/SH3Na1c3QoQyv/c16KagIL70MLcKIgd6B
	 FYpaT7ujVBkGCEPfrsSXTqMJuCTU6ipZ6LV3e9dZQPR7GDe0zR8AXjk1lbfYMX2leQ
	 72I8cVZi/vi1mCmaXSvXwgvGw5YIwk30OYJPu27zKEUUIruOJIqtItQvbg9Buih8jV
	 1m/t0+9MyoAasUQ74R4y+QNX/sg/KlvLbt0UsFvMIqqIFpnr73so2RFXBioOrV5XSB
	 QYRUkR1ltL/vg==
Date: Tue, 16 Apr 2024 18:34:10 +0000
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>, Michael Pratt <mcpratt@pm.me>
Subject: [PATCH v2 3/3] serial: 8250: Set fifo timeout using uart_fifo_timeout()
Message-ID: <20240416182741.22514-4-mcpratt@pm.me>
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

Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
reworked functions for basic 8250 and 16550 type serial devices
in order to enable and use the internal fifo device for buffering,
however the default timeout of 10 ms remained, which is proving
to be insufficient for low baud rates like 9600, causing data overrun.

Unforunately, that commit was written and accepted just before commit
31f6bd7fad3b ("serial: Store character timing information to uart_port")
which introduced the frame_time member of the uart_port struct
in order to store the amount of time it takes to send one uart frame
relative to the baud rate and other serial port configuration,
and commit f9008285bb69 ("serial: Drop timeout from uart_port")
which established function uart_fifo_timeout() in order to
calculate a reasonable timeout to wait until flushing
the fifo device before writing data again when partially filled,
using the now stored frame_time value and size of the buffer.

Fix this by using the stored timeout value made with this new function
to calculate the timeout for the fifo device, when enabled, and when
the buffer is larger than 1 byte (unknown port default).

The previous 2 commits add the struct members used here
in order to store the values, so that the calculations
are offloaded from the functions that are called
during a write operation for better performance.

Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.

Fixes: 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
V1 -> V2:
 Use stored values instead of calling uart_fifo_timeout()
 or checking capability flags.
 The existence of the timeout value satisfies fifosize > 1.

 drivers/tty/serial/8250/8250_port.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index 5b0cfe6bc98c..cf67911a74f5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2066,7 +2066,10 @@ static void wait_for_lsr(struct uart_8250_port *up, =
int bits)
 {
 =09unsigned int status, tmout =3D 10000;
=20
-=09/* Wait up to 10ms for the character(s) to be sent. */
+=09/* Wait for a time relative to buffer size and baud */
+=09if (up->fifo_enable && up->port.timeout)
+=09=09tmout =3D jiffies_to_usecs(up->port.timeout);
+
 =09for (;;) {
 =09=09status =3D serial_lsr_in(up);
=20
--=20
2.30.2



