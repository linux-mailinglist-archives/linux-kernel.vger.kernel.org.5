Return-Path: <linux-kernel+bounces-26292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CAA82DE2D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9EF1C21E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E38182DF;
	Mon, 15 Jan 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvsNTlqI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5tGferVp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0371804A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705338509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zI9aOA5pFU1a8/3o2IH5nyS4T+dQsL0rAjim+dM8zO8=;
	b=IvsNTlqI5vHFY6RPku5rZbLyYhDqZT+z6SqVjp51zkwn0rW6zExuu4xxclfJmwDKUDzJnS
	TFVvEZfU7Qngf1Lrvv9gEFmxc0FiqG/XlCCRZ2ZHlvhNjYwwl8ccX20Fsw3UB/0s/ajpN+
	LAcSCPTDHljriPPKj9DwHHHzBTQtSKvNsWRXDsPXsgH2ZvpZrPkLG4f6IIovis6zvfsqI+
	k2gaOdbS8AXhbs8HFJJEf0DCeYgvuEvBl6OcIo0inyvFsspRaUp1+Qeg0HmkZTX2Ir6OAM
	r0CEZhi3TKq2b79IP5NKoPduvWXbra8Hdq2lHH3hg4RDjMtmyaYUeXLDSuYrkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705338509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zI9aOA5pFU1a8/3o2IH5nyS4T+dQsL0rAjim+dM8zO8=;
	b=5tGferVpSF9AFa/KVdSYMQ5zcf7+pYzj8oAMzX5djeCRBV9gdlXDR6Dn0+zrRZA78d2PA3
	etbrMaX1SxzZZdCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Francesco Dolcini <francesco@dolcini.it>,
 kernel test robot <oliver.sang@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH printk v3 02/14] printk: Adjust mapping for 32bit seq
 macros
In-Reply-To: <ZaVakcK7Bh0tYF9x@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-3-john.ogness@linutronix.de>
 <ZaEUUZ6PICA54qVH@alley> <ZaGBlDTuQ0hYBpeJ@alley>
 <87a5p6g96w.fsf@jogness.linutronix.de> <ZaVakcK7Bh0tYF9x@alley>
Date: Mon, 15 Jan 2024 18:14:26 +0106
Message-ID: <87ttneed85.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-15, Petr Mladek <pmladek@suse.com> wrote:
> You know, the code around reading the messages is getting more
> and more complex. Also the u32 -> u64 transition is not 100% safe.
> So some sanity checks might be useful.

This complexity only exists for 32bit systems, but yeah, it is still
important.

> That said, I do not see any obvious trivial one. Just the following
> came to my mind. prb_first_seq() is reliable and we could do:
>
> void next_seq_sanity_check(struct printk_ringbuffer *rb, u64 next_seq)
> {
> 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> 	u64 first_seq = prb_first_seq(rb);
> 	u64 desc_count = DESC_COUNT(&rb->desc_ring)).
>
> 	WARN_ONCE(seq > first_seq + DESC_COUNT(desc_ring));
> }

@seq is allowed to be 2^31 before or after @first_seq. The check would
look more like this:

    WARN_ONCE((rb_first_seq < 0xffffffff80000000 &&
               seq > rb_first_seq + 0x80000000) ||
              (rb_first_seq > 0x80000000 &&
               seq < rb_first_seq - 0x80000000));

> Well, I am not sure if it is worth it. Also the WARN() won't be
> printed on consoles when the reading is broken.

Broken printing is irrelevant. There are plenty of debug methods to get
at the ringbuffer. I am OK with adding this sanity check (again, only
for 32bit, within __ulseq_to_u64seq()).

John

