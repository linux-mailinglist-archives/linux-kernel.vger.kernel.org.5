Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B3580DB56
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbjLKUNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344971AbjLKUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:13:22 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE76DC;
        Mon, 11 Dec 2023 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702325605;
        bh=MvVyKw/x+yVjAm3vE1F1gu66BqT0E/W/bARjFgMbliw=;
        h=From:To:Cc:Subject:Date:From;
        b=vmV0GKJ1rOjQY5SnrMb0zU+FNuvpCJXSliUZCWUZMDsH1vzEpSlT+jfeFu16ldkTq
         xSQ4mMjPS50qdRcyDMHp9fCo4evqL2dtUJlJVykukrR21tOEPem8iTT1PDJSz1JsP0
         YDy85b3xc9oDozuVFXW0Z4xxL4oCtm4MgqZUKwcJck0BcXOL5PXB7L9laA06L/Y6g6
         ByXYrMJ7u/ExSg5zCTdQJvIZUI0yrXNRebOrgxp4h4T+wqAo8rEAu1jHeNyTb1s9aa
         GVUktYykV6lOQ0vrccU27+wifpCO/4Gk6C9lz2NM8G7rQxmW5qSZ+XO/a1cK5poDIV
         M+hdNtsGw5upQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SptGs4nGDzGRs;
        Mon, 11 Dec 2023 15:13:25 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH] ring-buffer: Fix and comment ring buffer rb_time functions on 32-bit
Date:   Mon, 11 Dec 2023 15:13:24 -0500
Message-Id: <20231211201324.652870-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going through a review of the ring buffer rb_time functions for 32-bit
architectures, I updated the comments to match the code, and identified
the following issues:

- rb_time_cmpxchg() needs to update the msb last, so it matches
  the validation of top and msb by __rb_time_read(). This is fixed by
  this patch.

- A cmpxchg interrupted by 4 writes or cmpxchg overflows the counter
  and produces corrupted time stamps. This is _not_ fixed by this patch.

- After a cmpxchg fails between updates to top and msb, a write is
  needed before read and cmpxchg can succeed again. I am not entirely
  sure the rest of the ring buffer handles this correctly.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
---
 kernel/trace/ring_buffer.c | 64 +++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8d2a4f00eca9..f6ed699947cd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -576,34 +576,50 @@ struct ring_buffer_iter {
 #ifdef RB_TIME_32
 
 /*
- * On 32 bit machines, local64_t is very expensive. As the ring
- * buffer doesn't need all the features of a true 64 bit atomic,
- * on 32 bit, it uses these functions (64 still uses local64_t).
+ * On 32-bit machines, local64_t is very expensive. As the ring
+ * buffer doesn't need all the features of a true 64-bit atomic,
+ * on 32-bit, it uses these functions (64-bit still uses local64_t).
  *
- * For the ring buffer, 64 bit required operations for the time is
- * the following:
+ * For the ring buffer, the operations required to manipulate 64-bit
+ * time stamps are the following:
  *
- *  - Reads may fail if it interrupted a modification of the time stamp.
+ *  - Read may fail if it interrupted a modification of the time stamp.
  *      It will succeed if it did not interrupt another write even if
  *      the read itself is interrupted by a write.
+ *      A read will fail if it follows a cmpxchg which failed between
+ *      updates to its top and msb bits, until a write is performed.
+ *      (note: this limitation may be unexpected in parts of the
+ *      ring buffer algorithm)
  *      It returns whether it was successful or not.
  *
- *  - Writes always succeed and will overwrite other writes and writes
+ *  - Write always succeeds and will overwrite other writes and writes
  *      that were done by events interrupting the current write.
  *
  *  - A write followed by a read of the same time stamp will always succeed,
  *      but may not contain the same value.
  *
  *  - A cmpxchg will fail if it interrupted another write or cmpxchg.
+ *      A cmpxchg will fail if it follows a cmpxchg which failed between
+ *      updates to its top and msb bits, until a write is performed.
+ *      (note: this limitation may be unexpected in parts of the
+ *      ring buffer algorithm)
  *      Other than that, it acts like a normal cmpxchg.
  *
- * The 60 bit time stamp is broken up by 30 bits in a top and bottom half
- *  (bottom being the least significant 30 bits of the 60 bit time stamp).
+ * The 64-bit time stamp is broken up, from most to least significant,
+ * in: msb, top and bottom fields, of respectively 4, 30, and 30 bits.
  *
- * The two most significant bits of each half holds a 2 bit counter (0-3).
+ * The two most significant bits of each field hold a 2-bit counter (0-3).
  * Each update will increment this counter by one.
- * When reading the top and bottom, if the two counter bits match then the
- *  top and bottom together make a valid 60 bit number.
+ * When reading the top, bottom, and msb fields, if the two counter bits
+ *   match, then the combined values make a valid 64-bit number.
+ *
+ * Counter limits. The following situations can generate overflows that
+ * produce corrupted time stamps:
+ *
+ * - A read or a write interrupted by 2^32 writes or cmpxchg.
+ *
+ * - A cmpxchg interrupted by 4 writes or cmpxchg.
+ *   (note: this is not sufficient and should be fixed)
  */
 #define RB_TIME_SHIFT	30
 #define RB_TIME_VAL_MASK ((1 << RB_TIME_SHIFT) - 1)
@@ -632,7 +648,7 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 
 	/*
 	 * If the read is interrupted by a write, then the cnt will
-	 * be different. Loop until both top and bottom have been read
+	 * be different. Loop until top, bottom and msb have been read
 	 * without interruption.
 	 */
 	do {
@@ -644,7 +660,12 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 
 	*cnt = rb_time_cnt(top);
 
-	/* If top and msb counts don't match, this interrupted a write */
+	/*
+	 * If top and msb counts don't match, this either interrupted a
+	 * write or follows a failed cmpxchg.
+	 * This requires the update to bottom to be enclosed between
+	 * updates to top and msb.
+	 */
 	if (*cnt != rb_time_cnt(msb))
 		return false;
 
@@ -685,9 +706,10 @@ static void rb_time_set(rb_time_t *t, u64 val)
 
 	rb_time_split(val, &top, &bottom, &msb);
 
-	/* Writes always succeed with a valid number even if it gets interrupted. */
+	/* Write always succeeds with a valid number even if it gets interrupted. */
 	do {
 		cnt = local_inc_return(&t->cnt);
+		/* The top and msb updates surround bottom update. */
 		rb_time_val_set(&t->top, top, cnt);
 		rb_time_val_set(&t->bottom, bottom, cnt);
 		rb_time_val_set(&t->msb, val >> RB_TIME_MSB_SHIFT, cnt);
@@ -706,7 +728,12 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	unsigned long cnt2, top2, bottom2, msb2;
 	u64 val;
 
-	/* The cmpxchg always fails if it interrupted an update */
+	/*
+	 * The cmpxchg always fails if it interrupted an update or if it
+	 * follows a cmpxchg that fails between updates to top and msb.
+	 * A rb_time_set() is needed after a failed cmpxchg to reset to
+	 * a state where cmpxchg can succeed again.
+	 */
 	 if (!__rb_time_read(t, &val, &cnt2))
 		 return false;
 
@@ -729,12 +756,13 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 
 	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
 		return false;
-	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
-		return false;
+	/* The top and msb updates surround bottom update. */
 	if (!rb_time_read_cmpxchg(&t->top, top, top2))
 		return false;
 	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
 		return false;
+	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
+		return false;
 	return true;
 }
 
-- 
2.39.2

