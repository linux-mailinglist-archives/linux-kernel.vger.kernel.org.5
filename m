Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10BB7C8E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjJMUnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJMUnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:43:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8DABE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:43:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697229827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhL7l1aUccuPRBI1pChRIFWIRZ0vcUeOr3QrzqxHYPw=;
        b=zU6f7JCLrru8rBmPXU4C7JSL7cEjLWttVRhyRM9WhTGarOxRzSSX6zw8AYM4T4XB5hQHZP
        n2Ynx/MXplkKuezM76hbxZ8h626Xfzl2tZ8DJ/Ei/vOBxIhT+zOWTb48qLitd1e3bH5Yqk
        pvEFuiyaEiNjgm82AWF/mt848qg41ort9HF5vdldWMS4TaFb2KNrwpR1aSf8Iaq9lPuHNS
        ppSsekSqvEFBAMe7UHduikjS0odsor6/pMYJoonuQOplsHOuw/CZP5BlNW03LgJMKGjRJF
        Qh3YHFT6s06M661wO499uZ2nXpoua6b7K6lvxaVPjFxgpOrJZ8hMCtB/JNInCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697229827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhL7l1aUccuPRBI1pChRIFWIRZ0vcUeOr3QrzqxHYPw=;
        b=NseDkzKnu+69pUds5Z0kYR49DJsN5ek4ibBK34gcLW0kWLSuv0N98mqvAOIIqTdhVUs7W4
        CDM9ihipdnvt2hBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
Date:   Fri, 13 Oct 2023 22:49:39 +0206
Message-Id: <20231013204340.1112036-4-john.ogness@linutronix.de>
In-Reply-To: <20231013204340.1112036-1-john.ogness@linutronix.de>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally a reader will stop once reaching an unfinalized record.
However, when a panic happens, writers from other CPUs (or an
interrupted context on the panic CPU) may have been writing a
record and were unable to finalize it. The panic CPU will
reserve/commit/finalize its panic records, but these will be
located after the unfinalized records. This results in panic()
not flushing the panic messages.

Add a special case to printk_get_next_message() to allow
skipping over unfinalized records if on the panic CPU.

Also refine the documentation of the ringbuffer reading
functions to clarify that failure may also be due to an
unfinalized record.

Fixes: 896fbe20b4e2 ("printk: use the lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c            | 15 +++++++++++++--
 kernel/printk/printk_ringbuffer.c |  9 +++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 19b752880879..56d9b4acbbf2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2813,8 +2813,19 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	else
 		prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
 
-	if (!prb_read_valid(prb, seq, &r))
-		return false;
+	while (!prb_read_valid(prb, seq, &r)) {
+		if (this_cpu_in_panic() && seq < prb_next_seq(prb)) {
+			/*
+			 * The record @seq is not finalized and there may be
+			 * more records in the ringbuffer. Since this is the
+			 * panic CPU, skip over the unfinalized record and
+			 * try to read a finalized record that may follow.
+			 */
+			seq++;
+		} else {
+			return false;
+		}
+	}
 
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 2dc4d5a1f1ff..1bbc008109ef 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1876,8 +1876,9 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
 }
 
 /*
- * Non-blocking read of a record. Updates @seq to the last finalized record
- * (which may have no data available).
+ * Non-blocking read of a record. Updates @seq to the record that was read
+ * (which may have no data available) or was attempted to be read (in case
+ * it was unfinalized or non-existent).
  *
  * See the description of prb_read_valid() and prb_read_valid_info()
  * for details.
@@ -1932,7 +1933,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
  * On success, the reader must check r->info.seq to see which record was
  * actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a not yet finalized or non-existing record.
  */
 bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 		    struct printk_record *r)
@@ -1962,7 +1963,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
  * On success, the reader must check info->seq to see which record meta data
  * was actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a not yet finalized or non-existing record.
  */
 bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 			 struct printk_info *info, unsigned int *line_count)
-- 
2.39.2

