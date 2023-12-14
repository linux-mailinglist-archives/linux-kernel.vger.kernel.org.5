Return-Path: <linux-kernel+bounces-144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C38813CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456E11C21CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BFA6DCFD;
	Thu, 14 Dec 2023 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOcxR/U3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="29jZVYcn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841086ABB3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/NotbYcz70vb9TswAdSo/L8cfzqAV5DTPxEUBxk0c8=;
	b=yOcxR/U3d0FPxIrFHLpGXYySVhpZMfr8I4Hwg/QRm4ZmNnim7rbVwus6zENdtjbEYhAAok
	ogs1XfQ9tfNvH7fxUr1+O49TWlfkwLfYVAmcVHAKTVM7HPz7t1UqtlaWJALqXp5iw7+VNf
	g4bwS+GDik7bOP2vg3GiQZxdsQacxZbqH5jHVV9A7x0IsVay2n7Zgy3RYunu6U9QwEtJ21
	IGY+XPt4RlJo3O0oib/dknKxb/lFv54+LSseI/z4J/7ybeLK+WkkHVL7nrMsuJrsp4R3Ca
	8ybVr0+0LtBDGI4yyWgQ2Pst+poQwDBu7kRIkNxnrl2m06JY0N5Y8r7lC90yPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/NotbYcz70vb9TswAdSo/L8cfzqAV5DTPxEUBxk0c8=;
	b=29jZVYcnmRq2m2fajNwN2rkwlfR5X8Uq/N8rbSOC8BypMgCEoiI+HSyjdwf/tuPOIeV6I1
	1r0swCE9anxCijBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 01/14] printk: nbcon: Relocate 32bit seq macros
Date: Thu, 14 Dec 2023 22:47:48 +0106
Message-Id: <20231214214201.499426-2-john.ogness@linutronix.de>
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros __seq_to_nbcon_seq() and __nbcon_seq_to_seq() are
used to provide support for atomic handling of sequence numbers
on 32bit systems. Until now this was only used by nbcon.c,
which is why they were located in nbcon.c and include nbcon in
the name.

In a follow-up commit this functionality is also needed by
printk_ringbuffer. Rather than duplicating the functionality,
relocate the macros to printk_ringbuffer.h.

Also, since the macros will be no longer nbcon-specific, rename
them to __u64seq_to_ulseq() and __ulseq_to_u64seq().

This does not result in any functional change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c             | 41 +++----------------------------
 kernel/printk/printk_ringbuffer.h | 33 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index b96077152f49..c8093bcc01fe 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -140,39 +140,6 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
 	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
 }
 
-#ifdef CONFIG_64BIT
-
-#define __seq_to_nbcon_seq(seq) (seq)
-#define __nbcon_seq_to_seq(seq) (seq)
-
-#else /* CONFIG_64BIT */
-
-#define __seq_to_nbcon_seq(seq) ((u32)seq)
-
-static inline u64 __nbcon_seq_to_seq(u32 nbcon_seq)
-{
-	u64 seq;
-	u64 rb_next_seq;
-
-	/*
-	 * The provided sequence is only the lower 32 bits of the ringbuffer
-	 * sequence. It needs to be expanded to 64bit. Get the next sequence
-	 * number from the ringbuffer and fold it.
-	 *
-	 * Having a 32bit representation in the console is sufficient.
-	 * If a console ever gets more than 2^31 records behind
-	 * the ringbuffer then this is the least of the problems.
-	 *
-	 * Also the access to the ring buffer is always safe.
-	 */
-	rb_next_seq = prb_next_seq(prb);
-	seq = rb_next_seq - ((u32)rb_next_seq - nbcon_seq);
-
-	return seq;
-}
-
-#endif /* CONFIG_64BIT */
-
 /**
  * nbcon_seq_read - Read the current console sequence
  * @con:	Console to read the sequence of
@@ -183,7 +150,7 @@ u64 nbcon_seq_read(struct console *con)
 {
 	unsigned long nbcon_seq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_seq));
 
-	return __nbcon_seq_to_seq(nbcon_seq);
+	return __ulseq_to_u64seq(prb, nbcon_seq);
 }
 
 /**
@@ -204,7 +171,7 @@ void nbcon_seq_force(struct console *con, u64 seq)
 	 */
 	u64 valid_seq = max_t(u64, seq, prb_first_valid_seq(prb));
 
-	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __seq_to_nbcon_seq(valid_seq));
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __u64seq_to_ulseq(valid_seq));
 
 	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
 	con->seq = 0;
@@ -223,11 +190,11 @@ void nbcon_seq_force(struct console *con, u64 seq)
  */
 static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
 {
-	unsigned long nbcon_seq = __seq_to_nbcon_seq(ctxt->seq);
+	unsigned long nbcon_seq = __u64seq_to_ulseq(ctxt->seq);
 	struct console *con = ctxt->console;
 
 	if (atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_seq), &nbcon_seq,
-				    __seq_to_nbcon_seq(new_seq))) {
+				    __u64seq_to_ulseq(new_seq))) {
 		ctxt->seq = new_seq;
 	} else {
 		ctxt->seq = nbcon_seq_read(con);
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 18cd25e489b8..b82a96dc2ea2 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -381,4 +381,37 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
 
+#ifdef CONFIG_64BIT
+
+#define __u64seq_to_ulseq(u64seq) (u64seq)
+#define __ulseq_to_u64seq(rb, ulseq) (ulseq)
+
+#else /* CONFIG_64BIT */
+
+#define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
+
+static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
+{
+	u64 seq;
+	u64 rb_next_seq;
+
+	/*
+	 * The provided sequence is only the lower 32 bits of the ringbuffer
+	 * sequence. It needs to be expanded to 64bit. Get the next sequence
+	 * number from the ringbuffer and fold it.
+	 *
+	 * Having a 32bit representation in the console is sufficient.
+	 * If a console ever gets more than 2^31 records behind
+	 * the ringbuffer then this is the least of the problems.
+	 *
+	 * Also the access to the ring buffer is always safe.
+	 */
+	rb_next_seq = prb_next_seq(rb);
+	seq = rb_next_seq - ((u32)rb_next_seq - ulseq);
+
+	return seq;
+}
+
+#endif /* CONFIG_64BIT */
+
 #endif /* _KERNEL_PRINTK_RINGBUFFER_H */
-- 
2.39.2


