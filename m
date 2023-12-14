Return-Path: <linux-kernel+bounces-143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D8813CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B859A1C21CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32656DCEC;
	Thu, 14 Dec 2023 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YAQcBB6+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtghYq2O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A56ABA3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q5UpXrYvC+OmHxP4VbWiXKHrbItq+dkK5XTs3sO98Lo=;
	b=YAQcBB6+SKezc5n4mwrblZvnczyYQJVtyVCUuKwcU4H+1i7SYWED+9ZhBXQ2Q6bJPHsF3f
	Z8Vxgp60GPsOLRKhoncbb93Fxboxmjk/0wGzgQJNdLTwQVFMhsAQuhnwVPwnuHBVhrdVzO
	HCa7Im3o+Q7wYlBXQcVPKMwUEcR6u+l+jiz84dHGBg25vMviNj6Es75GFSHtEB2SaGSnWn
	olJBDulw2KuSaWNvA228nPGKnBKxUUrRjEa1lcJVhOHUWemlTGrd6ZE7wjtFKA7OESZkFB
	zlHhMWVudN+yQiZhoxWmi8Tgmwdp4fUAC//yjMDmMYsAhDZC5TPqxYMkAXWlDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q5UpXrYvC+OmHxP4VbWiXKHrbItq+dkK5XTs3sO98Lo=;
	b=rtghYq2OFGcUHAYJkfLGyscitrRxh/RGQKuMsb0J3KwzyYa+ZgtnmUwN1UNPxrJy5hPknI
	dpGE3egiK7Ig/3Dw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v3 00/14] fix console flushing
Date: Thu, 14 Dec 2023 22:47:47 +0106
Message-Id: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While testing various flushing scenarios, I stumbled on a few
issues that cause console flushing to fail. While at LPC2023 in
Richmond, I sat down with Petr Mladek and we reviewed the
v2 [0] series. This v3 series is the result of that offline
discussion.

This series addresses the following issues:

1. The prb_next_seq() optimization caused inconsistent return
   values. Fix prb_next_seq() to the originally intended
   behavior but keep an optimization.

2. pr_flush() might not wait until the most recently stored
   printk() message if non-finalized records precede it. Fix
   pr_flush() to wait for all records to print that are at
   least reserved at the time of the call.

3. In panic, the panic messages will not print if non-finalized
   records precede them. Add a special condition so that
   readers on the panic CPU will drop records that are not in
   a consistent state.

4. It is possible (and easy to reproduce) a scenario where the
   console on the panic CPU hands over to a waiter of a stopped
   CPU. Do not use the handover feature in panic.

5. If messages are being dropped during panic, non-panic CPUs
   are silenced. But by then it is already too late and most
   likely the panic messages have been dropped. Change the
   non-panic CPU silencing logic to _immediately_ silence
   non-panic CPUs during panic. This also leads to clean panic
   output when many CPUs are blasting the kernel log.

6. If a panic occurs in a context where printk() calls defer
   printing (NMI or printk_safe section), the printing of the
   final panic messages rely on irq_work. If that mechanism is
   not available, the final panic messages are not seen (even
   though they are finalized in the ringbuffer). Add one last
   explicit flush after all printk() calls are finished to
   ensure all available messages in the kernel log are printed.

This series also performs some minor cleanups to remove open
coded checks about the panic context and improve documentation
language regarding data-less records.

Because of multiple refactoring done in recent history, it
would be helpful to provide the LTS maintainers with the proper
backported patches. I am happy to do this.

The changes since v2:

- When on the panic CPU, allow desc_read_finalized_seq() to
  read records in the committed state.

- Fix the off-by-one return value of the new function
  prb_next_reserve_seq(). [1]

- Remove the suppress_panic_printk feature and instead simply
  silently drop all printk() messages from non-panic CPUs.

- Remove the __seq_to_nbcon_seq()/__nbcon_seq_to_seq() macros
  and use the new __u64seq_to_ulseq()/__ulseq_to_u64seq()
  macros for nbcon as well.

- Adjust the new __u64seq_to_ulseq()/__ulseq_to_u64seq() macros
  to support seq values above the base value. This is necessary
  for the new last_finalized_seq feature. [2]

- Relocate the new __u64seq_to_ulseq()/__ulseq_to_u64seq()
  macros to printk_ringbuffer.h so they can be shared by the
  printk_ringbuffer and nbcon code.

- Call console_flush_on_panic() one more time at the end of
  panic().

- Add and cleanup many comments and commit messages to clarify
  reasoning and variable meanings.

John Ogness

[0] https://lore.kernel.org/lkml/20231106210730.115192-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/87h6lwcxix.fsf@jogness.linutronix.de
[2] https://lore.kernel.org/lkml/87lear2i8w.fsf@jogness.linutronix.de

John Ogness (13):
  printk: nbcon: Relocate 32bit seq macros
  printk: Adjust mapping for 32bit seq macros
  printk: Use prb_first_seq() as base for 32bit seq macros
  printk: ringbuffer: Do not skip non-finalized records with
    prb_next_seq()
  printk: ringbuffer: Clarify special lpos values
  printk: For @suppress_panic_printk check for other CPU in panic
  printk: Add this_cpu_in_panic()
  printk: ringbuffer: Cleanup reader terminology
  printk: Wait for all reserved records with pr_flush()
  printk: ringbuffer: Skip non-finalized records in panic
  printk: ringbuffer: Consider committed as finalized in panic
  printk: Avoid non-panic CPUs writing to ringbuffer
  panic: Flush kernel log buffer at the end

Petr Mladek (1):
  printk: Disable passing console lock owner completely during panic()

 kernel/panic.c                    |   8 +
 kernel/printk/internal.h          |   1 +
 kernel/printk/nbcon.c             |  41 +---
 kernel/printk/printk.c            | 101 +++++----
 kernel/printk/printk_ringbuffer.c | 360 +++++++++++++++++++++++++-----
 kernel/printk/printk_ringbuffer.h |  54 ++++-
 6 files changed, 427 insertions(+), 138 deletions(-)


base-commit: 6c3a34e38436a2a3f7a1fa764c108ee19b05b893
-- 
2.39.2


