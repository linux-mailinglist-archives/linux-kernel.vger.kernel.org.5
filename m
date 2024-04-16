Return-Path: <linux-kernel+bounces-147384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F68A7335
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC801F21C61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6B7135418;
	Tue, 16 Apr 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jWGQPi8d"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD51332B6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292156; cv=none; b=KPRQa4x74qOjLojjvQXM0tpacmbA41287Z/eX1FrM2KKHy/c1uqtUPDQxNaxRqVWWM+fAts65mZMfpPi3uAo89g78trgvbm+5fI439eE+gxAqEW4xHHEdgCZjDl9Zk/m+UDfGPvSi6x8UBhME75f0IiqfPN5ZBtbZWQ89YUgmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292156; c=relaxed/simple;
	bh=v+czfn0IfSapZZ8pqxRYSfkPUjwNRdVUep4x5Tza0QA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jcRUFIJ1vSyJ5BPTWOo8RfMLwFbx4/mkw9AXx/5IZiZWaY2KdnieC1sieOjp7KCOZpPe/vbl+jtHAWMN1mWXAs61MGUCOW3PWfh13X7Hp5Phy0iqbUB7yduYsVStHdg2LXx9EfgLGZJW6cuoJU5vb1hdwlBUi/eeF9oLwVFYM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jWGQPi8d; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1713292152; x=1713551352;
	bh=hzNvp2rdWqKMsdmDAYXgUDD3rBTlt6eZV6vZgFT9zFo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jWGQPi8dLclrNLoIEExXmBHGzqXEro1BDfTNAP3ZPEHOTUkBl2PBM5PvpbzZxvmsD
	 1KpNudoXV7JBIyzhj8MYhdJERm+Fb+0eSKvrwutZCbA1rkcijQsHfhTLlUUtL71O7U
	 fQkOuh2GTtinjyg8+FDk6kv2cjCKr+0b6TI1Wd3n1B23qM3nM4lbRVxKEbyHDGyUO7
	 HF/bqhFGdri0cmZ9tn9lO8yl03wap3LE/LoYx82cY1XmDZNhHHqDcwiI5oomt5CsEV
	 2G3R55ki5M0QM9rf0uRrv9nwQA9g+FoiKvS/De2kpWabxH04QADMuQmuf/6HlocG6+
	 0el4g6UkKL+ZQ==
Date: Tue, 16 Apr 2024 18:28:41 +0000
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>, Michael Pratt <mcpratt@pm.me>
Subject: [PATCH v2 0/3] serial: 8250: Set fifo timeout with uart_fifo_timeout()
Message-ID: <20240416182741.22514-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, Jan 11, 2024 I submitted a single patch solution
for this issue of data overrun because of the default timeout
value which is insufficient for very low baud rates
with the internal fifo device enabled.

Following the advice of Vamshi Gajjela in the v1 thread,
I tried to find a way to limit the amount of math
being done within the write operation, and this is a possibility.

In this series, I'm proposing we bring back the
"timeout" member of struct uart_port, and also that we
add a new member of struct uart_8250_port in order
to store whether the fifo device has been enabled.

This way, in the function wait_for_lsr()
all we need to do is convert the value from jiffies to usecs
in order to have the appropriate timeout value.

I'm hoping to get this in during the RC phase of v6.9
and I'm trying to keep this fix as simple as possible,
or at least I think this is the appropriate time to
bring this issue up again...

Thanks in advance for your time.

--
MCP

Michael Pratt (3):
  serial: core: Store fifo timeout again
  serial: 8250: Store whether fifo device is enabled
  serial: 8250: Set fifo timeout using uart_fifo_timeout()

 drivers/tty/serial/8250/8250_port.c | 7 ++++++-
 drivers/tty/serial/serial_core.c    | 3 +++
 include/linux/serial_8250.h         | 1 +
 include/linux/serial_core.h         | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)


base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
--
2.30.2



