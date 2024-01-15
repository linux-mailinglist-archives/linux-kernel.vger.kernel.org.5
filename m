Return-Path: <linux-kernel+bounces-25903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D682D7D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD234282531
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAAB1E86C;
	Mon, 15 Jan 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7/UXl9L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mVhAO0jw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4631E863
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705315960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HOIq5xrrcKDhjWifKtOBpW3KDRCmGoSMcl/b7n5dGtg=;
	b=e7/UXl9LlTdR8h22ZKKRUQ2CnDreqpzpfv3mUAkWAvxaRkGZlCjS4O1G6nVusitg+as/oV
	sGyZmjVONlSQA70++6o3jd8cbbzFxgK3L+7JjXV6Wzcp57qH46TSotL3prXdmC2gA5wPiX
	wa3j/RQv7kocTJGVs5E+A//pmZ88qzcViRaOQ1wn+vyVAd2QDAiIJaMoRjk0yPa6Xx30t6
	JysBa4EPR9kwYq7czFYJMDppWbMAoY/BcoCtoLBBMA6e2CNN4a5N9cGvZz/FomipcHa6L1
	3+YE+HCYkBb2SJoW2cnq5hTrsfELnmYKoGbIvPC4cyYH5WQN7MBxlGx0O0vy3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705315960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HOIq5xrrcKDhjWifKtOBpW3KDRCmGoSMcl/b7n5dGtg=;
	b=mVhAO0jw13hGl0fB4LX37BblU6LQPc1BgdXFtOXdf5oAy3Hq9rwqyEfZgupvKEP5Vri08+
	/UArINe+0bw1tHCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Francesco Dolcini <francesco@dolcini.it>,
 kernel test robot <oliver.sang@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH printk v3 02/14] printk: Adjust mapping for 32bit seq
 macros
In-Reply-To: <ZaGBlDTuQ0hYBpeJ@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-3-john.ogness@linutronix.de>
 <ZaEUUZ6PICA54qVH@alley> <ZaGBlDTuQ0hYBpeJ@alley>
Date: Mon, 15 Jan 2024 11:58:39 +0106
Message-ID: <87a5p6g96w.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-12, Petr Mladek <pmladek@suse.com> wrote:
>> > Reported-by: Francesco Dolcini <francesco@dolcini.it>
>> > Reported-by: kernel test robot <oliver.sang@intel.com>
>> > Closes: https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.com
>> > Reported-by: kernel test robot <oliver.sang@intel.com>
>> > Closes: https://lore.kernel.org/oe-lkp/202311161555.3ee16fc9-oliver.sang@intel.com
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> 
>> Great catch! It must have been complicated to debug this.
>> 
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> That said, I am a bit nervous that a bug like this might cause
> workqueue stall and panic() the kernel.
>
> At least, this is how I read
> https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.com/

Note that the bug is reported for code that mainline will never
have. This patch "fixes" the problem before it is a problem. From the
perspective of mainline, the problem never existed. Perhaps it is
inappropriate to list these with the Closes tag.

> It looks like it caused some loop and refcout overlow or so.
> But I might be wrong.
>
> I would like to better understand this and check if we could prevent
> it somehow.

The code in question can be found here:

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/printk/printk_ringbuffer.c?id=768c33033e41ad195a9304ebb183afb730d5ae98#n2031

The URL above points to prb_next_reserve_seq(), which is in an infinite
loop.

desc_last_finalized_seq() is returning a huge garbage value due to the
32bit sequence value 1 being incorrectly mapped to 0xffffffff00000001
(which is 18446744069414584321). When desc_read_finalized_seq() is
called (line 2082), it obviously returns -EINVAL because there is no
record with this huge sequence number.

The code interrupts -EINVAL to mean that the record has been
overwritten, and so it tries again with an updated last finalized
sequence number => infinite loop.

With this patch applied, the 32bit value 1 is correctly mapped to
sequence number 1 and all is OK.

The problem was that desc_last_finalized_seq() returned a sequence
number that was higher than the highest record. That was the bug. As
long as desc_last_finalized_seq() always returns a sequence number that
exists or used to exist, the retry loop is fine. And since the tail
record is always in the finalized state, there will always be a
finalized record available.

John

