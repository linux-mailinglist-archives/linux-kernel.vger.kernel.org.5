Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4835A7E2EA6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjKFVHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjKFVHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:07:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE7103
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:07:37 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699304855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyZ2jAekG9IbA8OHPwAlE8+iwKYLcZ73K8RQgyikDwc=;
        b=hoDow6cmR6fMaIE4IEz8T8ZOa9WAsRAIZ1laV7umbzSbt5N8y2x2sO+SEOaC0qXJgBq0cN
        HEy9osDwNbibWwsvVQvTwmQxALb/YuUKRlWjPncmw6OPDe7hHkUmhNI7smOxwew9qPX0Pq
        5EB4HTobjMmvA3On+SoaH6IIwXB9P+1b4ZDYfb/vHAmXFZHB1yfpAL5sGW30R8TlCgzZym
        Xj2TupQPiAbEdqrVVXILcrBfu1cjcPkcWvW2P1kPCLRMPS341VzeJp3sFWt1uVLmiI7MKZ
        k1e8LB08vDy7bVHANZ8tiyNOjMH8g634lXyeERfrncWjMnDybu5U62N8OagTXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699304855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyZ2jAekG9IbA8OHPwAlE8+iwKYLcZ73K8RQgyikDwc=;
        b=NeUa92hCHMV8isuc4k3GcjK6dGlvkA0s8ZlE8vv05kzT4Cr+cL2RHKKjGmyq2k7xGzaAZS
        D2KlUcMMEzB78VCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 6/9] printk: Wait for all reserved records with pr_flush()
Date:   Mon,  6 Nov 2023 22:13:27 +0106
Message-Id: <20231106210730.115192-7-john.ogness@linutronix.de>
In-Reply-To: <20231106210730.115192-1-john.ogness@linutronix.de>
References: <20231106210730.115192-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pr_flush() will only wait for records that were
available to readers at the time of the call. But there may be
more records (non-finalized) with following finalized records.
pr_flush() should wait for these to print as well. Particularly
because any trailing finalized records may be the messages that
the calling context wants to ensure are printed.

Fixes: 3b604ca81202 ("printk: add pr_flush()")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c            |  2 +-
 kernel/printk/printk_ringbuffer.c | 96 +++++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  1 +
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82dc2c7949b7..f3a7f5a6f6f8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3755,7 +3755,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 	might_sleep();
 
-	seq = prb_next_seq(prb);
+	seq = prb_next_reserve_seq(prb);
 
 	/* Flush the consoles so that records up to @seq are printed. */
 	console_lock();
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 7c121fd68330..dc83569d3a3a 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2012,6 +2012,102 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
 	return seq;
 }
 
+/**
+ * prb_next_reserve_seq() - Get the sequence number after the most recently
+ *                  reserved record.
+ *
+ * @rb: The ringbuffer to get the sequence number from.
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
+	last_finalized_seq = desc_last_finalized_seq(desc_ring);
+
+	/*
+	 * @head_id is loaded after @last_finalized_seq to ensure that it is
+	 * at or beyond @last_finalized_seq.
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
+			 * @last_finalized_seq still contains its initial
+			 * value. Probably no record has been finalized yet.
+			 * This means the ringbuffer is not yet full and the
+			 * @head_id value can be used directly (subtracting
+			 * off its initial value).
+			 *
+			 * Because of hack#2 of the bootstrapping phase, the
+			 * @head_id initial value must be handled separately.
+			 */
+			if (head_id == DESC0_ID(desc_ring->count_bits))
+				return 0;
+
+			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;
+		} else {
+			/* Record must have been overwritten. Try again. */
+			goto try_again;
+		}
+	}
+
+	diff = head_id - last_finalized_id;
+
+	return (last_finalized_seq + diff);
+}
+
 /*
  * Non-blocking read of a record.
  *
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 5c09061433f3..b48b44ecbe6d 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -394,5 +394,6 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 
 u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
+u64 prb_next_reserve_seq(struct printk_ringbuffer *rb);
 
 #endif /* _KERNEL_PRINTK_RINGBUFFER_H */
-- 
2.39.2

