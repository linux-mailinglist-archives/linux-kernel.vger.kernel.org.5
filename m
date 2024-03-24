Return-Path: <linux-kernel+bounces-113662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81741888E36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCAF1F2B160
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2988E126F0C;
	Sun, 24 Mar 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzDiNy2M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCDF1442F8;
	Sun, 24 Mar 2024 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320657; cv=none; b=izaA5YWbxzyl4tkdiZ7anp9cbOQqp0lte4s0A0r1TFrKG+1VoddgSLcDWFFW1siClx6RXEVbw0RTvxhw2JXNFtj+IrnQthOCUnTy6l73ogiPhXIToWG7vmpvUbvIHNLkwgz8E2saaPZzK76xMCazQvypPEX1I/+o3p07pUZnUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320657; c=relaxed/simple;
	bh=Hb/NsZOhMbQg490AAjzJrWojSX3thYXJ3sqhmuaCxWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbOrmQwF+QSCDRf8PMEPK2NVt8O4DrSgbRtplVW8yQkdjpDcTs0GLCfsvAXyjHFfBeBmGCkjdRxowNp7r0Y8h0Xm1/8xf+fsVZR40LveI9u7PdHvGyvXwJp9iSpHMRu2wKCouLk+i5dQj8+KkfS+Vn2/Jd0/n/3KONdC68qmZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzDiNy2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA69EC43390;
	Sun, 24 Mar 2024 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320656;
	bh=Hb/NsZOhMbQg490AAjzJrWojSX3thYXJ3sqhmuaCxWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzDiNy2Mjr3CwR3gqzzNfp2MFbgNdx/Q9TY3H/I8l5uTrdkqXojWMZfTp55k8w5Pw
	 uFwK2pDo8UFQr5jL8SEe9IdD15iScxjRHchRbv5iduIDRBJ7MoE7LckSBS/QQsCTWE
	 bCgsrqHruXDCVhJ5mfhi2REqIeUTGQQ8yG8SUd95u6ylS5Gr/OoVpNE+6QDTMA4h99
	 j5eS4mOzej7PeC0Peeq/2OiO0/AkgcnXmpw7+nY5mp1YDBUtY/hHwe5aWal0diflgr
	 WyI4/1gZcxmeohQbB1BYBsevwDjB+8/DSEh5jYj7PvoGDTBzdFjZ6w0OWR58f+v4pK
	 pLRkquxFVwjXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 218/713] printk: Wait for all reserved records with pr_flush()
Date: Sun, 24 Mar 2024 18:39:04 -0400
Message-ID: <20240324224720.1345309-219-sashal@kernel.org>
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

[ Upstream commit ac7d7844c64d15603daa3e905a311ddcfbb4bc91 ]

Currently pr_flush() will only wait for records that were
available to readers at the time of the call (using
prb_next_seq()). But there may be more records (non-finalized)
that have following finalized records. pr_flush() should wait
for these to print as well. Particularly because any trailing
finalized records may be the messages that the calling context
wants to ensure are printed.

Add a new ringbuffer function prb_next_reserve_seq() to return
the sequence number following the most recently reserved record.
This guarantees that pr_flush() will wait until all current
printk() messages (completed or in progress) have been printed.

Fixes: 3b604ca81202 ("printk: add pr_flush()")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-10-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c            |   2 +-
 kernel/printk/printk_ringbuffer.c | 105 ++++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |   1 +
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16c..d9420207282ac 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3761,7 +3761,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 	might_sleep();
 
-	seq = prb_next_seq(prb);
+	seq = prb_next_reserve_seq(prb);
 
 	/* Flush the consoles so that records up to @seq are printed. */
 	console_lock();
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 4ce1826dc9426..d152b6bd35c9a 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1974,6 +1974,111 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
 	return seq;
 }
 
+/**
+ * prb_next_reserve_seq() - Get the sequence number after the most recently
+ *                  reserved record.
+ *
+ * @rb:  The ringbuffer to get the sequence number from.
+ *
+ * This is the public function available to readers to see what sequence
+ * number will be assigned to the next reserved record.
+ *
+ * Note that depending on the situation, this value can be equal to or
+ * higher than the sequence number returned by prb_next_seq().
+ *
+ * Context: Any context.
+ * Return: The sequence number that will be assigned to the next record
+ *         reserved.
+ */
+u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	unsigned long last_finalized_id;
+	atomic_long_t *state_var;
+	u64 last_finalized_seq;
+	unsigned long head_id;
+	struct prb_desc desc;
+	unsigned long diff;
+	struct prb_desc *d;
+	int err;
+
+	/*
+	 * It may not be possible to read a sequence number for @head_id.
+	 * So the ID of @last_finailzed_seq is used to calculate what the
+	 * sequence number of @head_id will be.
+	 */
+
+try_again:
+	last_finalized_seq = desc_last_finalized_seq(rb);
+
+	/*
+	 * @head_id is loaded after @last_finalized_seq to ensure that
+	 * it points to the record with @last_finalized_seq or newer.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If desc_last_finalized_seq:A reads from
+	 * desc_update_last_finalized:A, then
+	 * prb_next_reserve_seq:A reads from desc_reserve:D.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from desc_reserve:D to desc_update_last_finalized:A
+	 *    matching
+	 * ACQUIRE from desc_last_finalized_seq:A to prb_next_reserve_seq:A
+	 *
+	 * Note: desc_reserve:D and desc_update_last_finalized:A can be
+	 *       different CPUs. However, the desc_update_last_finalized:A CPU
+	 *       (which performs the release) must have previously seen
+	 *       desc_read:C, which implies desc_reserve:D can be seen.
+	 */
+	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(prb_next_reserve_seq:A) */
+
+	d = to_desc(desc_ring, last_finalized_seq);
+	state_var = &d->state_var;
+
+	/* Extract the ID, used to specify the descriptor to read. */
+	last_finalized_id = DESC_ID(atomic_long_read(state_var));
+
+	/* Ensure @last_finalized_id is correct. */
+	err = desc_read_finalized_seq(desc_ring, last_finalized_id, last_finalized_seq, &desc);
+
+	if (err == -EINVAL) {
+		if (last_finalized_seq == 0) {
+			/*
+			 * No record has been finalized or even reserved yet.
+			 *
+			 * The @head_id is initialized such that the first
+			 * increment will yield the first record (seq=0).
+			 * Handle it separately to avoid a negative @diff
+			 * below.
+			 */
+			if (head_id == DESC0_ID(desc_ring->count_bits))
+				return 0;
+
+			/*
+			 * One or more descriptors are already reserved. Use
+			 * the descriptor ID of the first one (@seq=0) for
+			 * the @diff below.
+			 */
+			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;
+		} else {
+			/* Record must have been overwritten. Try again. */
+			goto try_again;
+		}
+	}
+
+	/* Diff of known descriptor IDs to compute related sequence numbers. */
+	diff = head_id - last_finalized_id;
+
+	/*
+	 * @head_id points to the most recently reserved record, but this
+	 * function returns the sequence number that will be assigned to the
+	 * next (not yet reserved) record. Thus +1 is needed.
+	 */
+	return (last_finalized_seq + diff + 1);
+}
+
 /*
  * Non-blocking read of a record. Updates @seq to the last finalized record
  * (which may have no data available).
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 70457916d577d..5aebe97bd4afc 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -380,6 +380,7 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 
 u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
+u64 prb_next_reserve_seq(struct printk_ringbuffer *rb);
 
 #ifdef CONFIG_64BIT
 
-- 
2.43.0


