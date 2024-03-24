Return-Path: <linux-kernel+bounces-115386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2C889B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CE51F37ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E161FB06D;
	Mon, 25 Mar 2024 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWE4GZOx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1101442EB;
	Sun, 24 Mar 2024 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320655; cv=none; b=UOuOu4CXTx42CKxsitBhu77D8yO8gIQEMYGKklkvt4d2T53wK2NuolHnTtWcRVMrd8jIdlT06Kwq3JAyrRFeAThWye1liMUYxMYxEzTqvWBH1t0Ur4w8VXnin2VsNhHrA5w+V3jq1PZLqWSAZws85zs2llFsnh7YO5O9ePKwv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320655; c=relaxed/simple;
	bh=JOG+YyezGeMBbIJgXZ49Ud5Nd6CLwHeZEpDp+srOCHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0A07v3wP5KLauowT8Y0jtNEe9zo3Ifb2iPbu4fCgyTAyu84F/pm0vayDMU1c3AC1ycOnl/KDrJ0CXW1fahULAlNW/2S14kyW5yJku+MRrwBNosbYfIWQ3Mf0fu7cs+PW7IqZYP1c9IkXDS/PQc9b3hIBpOOr1UNstwsRH0RVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWE4GZOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A483C433C7;
	Sun, 24 Mar 2024 22:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320654;
	bh=JOG+YyezGeMBbIJgXZ49Ud5Nd6CLwHeZEpDp+srOCHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWE4GZOx6WTEAEEV8kcL2230572qJgtCagwjQ5JdsTQOJe7Av3NXe7miQzToLfY5V
	 Nqay4XLFyuC+706rYqBWYKOBgB0lLWjPDZBsbDsmrrHh9fin8MluVveXN53Al9rkvF
	 ky5wDiDP6uwHhMi/QLnph+wb6Ie2wmFxU0QIoF74HBdMNunxRJTtRSUqJUtkwnPYcx
	 9Yp6DDiqKp+8jby51wRPNcr6M37ZXTc0WWtBqQd2Sof5hixt/BycjiJGxWmdcsi4Xc
	 vsJveL/fBrGF/pPc7FktG5fet3U/0Ug0XvFw3n9+LWGhnoaXpAoFfPaz0fZfWKGY2O
	 dgT58dT0C7NNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 216/713] printk: nbcon: Relocate 32bit seq macros
Date: Sun, 24 Mar 2024 18:39:02 -0400
Message-ID: <20240324224720.1345309-217-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 5b73e706f00f3553e1a4efbb31951ce9fe18f2dc ]

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
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-2-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Stable-dep-of: 5f72e52ba959 ("printk: ringbuffer: Do not skip non-finalized records with prb_next_seq()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/nbcon.c             | 41 +++----------------------------
 kernel/printk/printk_ringbuffer.h | 33 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index b96077152f49d..c8093bcc01fe6 100644
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
index 18cd25e489b89..b82a96dc2ea2b 100644
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
2.43.0


