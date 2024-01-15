Return-Path: <linux-kernel+bounces-25755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C30582D556
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D71D1F21065
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562DBE73;
	Mon, 15 Jan 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qAI+T3ta";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="svE3Jbal"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485CBBE5A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jan 2024 09:51:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705308702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuhglXcya6j0sWfWtkAYCB5SKqg5fB+6p2lnNG25ERY=;
	b=qAI+T3tai6voy9/fjdgsNM256TdSrF/6QR7EGAR0w5JGU3rpZWl3W/W3m5dnvou+DsPTgv
	lgFOmuWKRmYopEHeIQWojb1vpxxZVPwb+lrSER36Vn3oODExyC8zrJ5kFOHDP90r4o521X
	sJRFZMVlkaRfc+qRfPi1aCDDXAmskEohYVlg8vMzcYnVSqc3iRAMFntC8YPPNPULMd4E/K
	CwhnIDf3PYYF/4e8Bm4g1JwB/1aWZS1/SWMUAuge9C0xt/hNtmCkZQn5jTs1uwP/DiwIKu
	LrKGe4Kddp1UzkxbyGk7MFiF595fIY1nOTpa9PKKNkSnf390TZR0yqD/Wjx3+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705308702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuhglXcya6j0sWfWtkAYCB5SKqg5fB+6p2lnNG25ERY=;
	b=svE3Jbal7wJLrN84xl9wXI7kUIdsh3J/Gw7Dg5oBF+Q67ORfVdpxmzGFpKXkP0p9uPBH3E
	USrSg4TNrm6MkEDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH printk v3 02/14] printk: Adjust mapping for 32bit seq
 macros
Message-ID: <20240115085141.MSS4LLsR@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-3-john.ogness@linutronix.de>
 <ZaEUUZ6PICA54qVH@alley>
 <ZaGBlDTuQ0hYBpeJ@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZaGBlDTuQ0hYBpeJ@alley>

On 2024-01-12 19:14:44 [+0100], Petr Mladek wrote:
>=20
> That said, I am a bit nervous that a bug like this might cause
> workqueue stall and panic() the kernel.


> At least, this is how I read
> https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.co=
m/

well, workqueue stalls and RCU as well because the CPU spins. That is a
natural consequence because the CPU makes no progress (at boot). The
panic _might_ be due to panic_on_error or so.
There is no scheduler, nothing so one CPU is blocked and the world ends=E2=
=80=A6

> It looks like it caused some loop and refcout overlow or so.
> But I might be wrong.
>=20
> I would like to better understand this and check if we could prevent
> it somehow.

Based on memory: the problem is that the sign extension bug (the fixed
bug) returned the wrong or too low sequence number. So the printk code
tried again to obtain a new sequence number. And got the wrong
again. And this is what looped during boot.=20

I'm not sure if this sort of lockup can happen now after the bug is
fixed. I can issue a NMI backtrace on all CPUs (32) without the sync (so
they all can printk immediately and not one after the other) and it
prints and continues=E2=80=A6

> Best Regards,
> Petr

Sebastian

