Return-Path: <linux-kernel+bounces-23157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C682A877
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3145DB22CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9EFDDB8;
	Thu, 11 Jan 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EcQuPDsb"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2294DDA7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1704958665; x=1705217865;
	bh=XEdL+zlaCmbj7cKCMxcTYDhIlR/mw4v0wVNnc38KC+k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EcQuPDsbuQ7ERSws+3+A2Mb+94DWzBl8W1VvjxHkgppM2pt4IBwIOmG4cV6xwS4oO
	 Xvk4caecFLACjs8qW+0TcnRIwGTG40Ucky/NT/6XIjXi+q4InoxMCsWLOjnn2f0UoD
	 9zmykoCKV2hbwbKdPKWAR+QIAS8/mpRXjW6a7YpfwsRb0kuNQN2Bmq2DFbmG9g0h/a
	 yrB/uYjV8Jr3ksH08q0clhOUUj5toiAqptOUgXqe2xdeXdcP/oQAkhiYkSaKPRWVFY
	 d6UPIC/dduLBPjta20p/1d6NZI3EmMpZX8SAx0/00B1/rWkLBZ79M8DzCfhVuzR4t3
	 8hd4PxGPx+LLQ==
Date: Thu, 11 Jan 2024 07:37:24 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 RESEND] serial: 8250: Set fifo timeout with uart_fifo_timeout()
Message-ID: <sxGlnHaZVt4mMgmwzplgzx0bwPOv0MaG8us_UlJg2n6QajwaUgqi876d6ctZZrpkAQBLv7iJ2h2sQ4VOdOk16QHDp_D5AJCYpxPXKbBKrFA=@pm.me>
In-Reply-To: <2024011125-stiffness-mutilated-75bb@gregkh>
References: <20240111002056.28205-1-mcpratt@pm.me> <2024011125-stiffness-mutilated-75bb@gregkh>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thursday, January 11th, 2024 at 01:52, Greg Kroah-Hartman <gregkh@linuxf=
oundation.org> wrote:

> On Thu, Jan 11, 2024 at 12:27:07AM +0000, Michael Pratt wrote:
>=20
> > Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")

This is the commit that made the issue present itself.

I'm not sure whether it's right to say that this "fixes" that commit
since it only caused the issue indirectly, and the diff for this patch
doesn't touch any lines that the other commit touched, and the method
I'm using to fix the issue was not available at the time, and also that
for high baud rates like 115200 everything is still fine...
(the 10 ms timeout is as old as the tree)

If that's enough for a "Fixes" tag then go ahead (or tell me to add it),
but maybe a "Ref" tag would be enough?

You can see the other thread linked for more discussion on that point if yo=
u like...

> > reworked functions for basic 8250 and 16550 type serial devices
> > in order to enable and use the internal FIFO device for buffering,
> > however the default timeout of 10 ms remained, which is proving
> > to be insufficient for low baud rates like 9600, causing data overrun.
> >=20
> > Unforunately, that commit was written and accepted just before commit
> > 31f6bd7fad3b ("serial: Store character timing information to uart_port"=
)
> > which introduced the frame_time member of the uart_port struct
> > in order to store the amount of time it takes to send one UART frame
> > relative to the baud rate and other serial port configuration,
> > and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> > which established function uart_fifo_timeout() in order to
> > calculate a reasonable timeout to wait for all frames
> > in the FIFO device to flush before writing data again
> > using the now stored frame_time value and size of the buffer.
> >=20
> > Fix this by using the new function to calculate the timeout
> > whenever the buffer is larger than 1 byte (unknown port default).
> >=20
> > Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.
> >=20
> > Signed-off-by: Michael Pratt mcpratt@pm.me
> > ---
> > v1 thread: https://lore.kernel.org/linux-serial/20231125063552.517-1-mc=
pratt@pm.me/
>=20
>=20
> What commit id does this fix?
>=20
> thanks,
>=20
> greg k-h

--
MCP

