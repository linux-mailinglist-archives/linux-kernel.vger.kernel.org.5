Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71D7E2EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjKFVH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjKFVHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:07:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFAD75
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:07:38 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699304855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPyZTcWZWhXXvYtKbCYSzlUC2oh3LgQ1z4Pk6pXNprY=;
        b=JiSkeIhKiFvecS2FXzSEnPYPxGF/LN+OykA0vVJaX1Q93NZlyyXg/o98rXaFU+8hcdtPZM
        7EonEjJzEiMLX+gD9ZBIB+cNXvR0yRgSTc4ctPifNmogqolc8y7pyMW/WxCrXAJt/1JT/B
        EDS8mYvTBp6DoBgri33uPStc3KKUaSjqvXFWValpM9Vcs/SK79Yg4W1XN10UE2ALuE6zwV
        upeHCakfbHiKt2rF4V1c/tuxH83VzGSX/Z2hRy3mdfCzBl47TMpAKdSjX3mQqI8ORYXLhg
        ERVNPeJDQk1R2ORZcaqyFdVWl+hE7D4StmRdsSmksY1BBjnXvKlp85R2JSoM8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699304855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPyZTcWZWhXXvYtKbCYSzlUC2oh3LgQ1z4Pk6pXNprY=;
        b=yFI+fvbcrINRbTXEB4WeODLJn6Vn4DYrIh3V7Z7kHof5vRGsQCN1/t6qrayYoKMVVkGGzv
        6OwczLGJ8aIDuqCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 7/9] printk: Skip non-finalized records in panic
Date:   Mon,  6 Nov 2023 22:13:28 +0106
Message-Id: <20231106210730.115192-8-john.ogness@linutronix.de>
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

Normally a reader will stop once reaching a non-finalized
record. However, when a panic happens, writers from other CPUs
(or an interrupted context on the panic CPU) may have been
writing a record and were unable to finalize it. The panic CPU
will reserve/commit/finalize its panic records, but these will
be located after the non-finalized records. This results in
panic() not flushing the panic messages.

Extend _prb_read_valid() to skip over non-finalized records if
on the panic CPU.

Fixes: 896fbe20b4e2 ("printk: use the lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index dc83569d3a3a..584d2b213876 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2116,6 +2116,10 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
  *
  * On failure @seq is updated to a record that is not yet available to the
  * reader, but it will be the next record available to the reader.
+ *
+ * Note: When the current CPU is in panic, this function will skip over any
+ *       non-existent/non-finalized records in order to allow the panic CPU
+ *       to print any and all records that have been finalized.
  */
 static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			    struct printk_record *r, unsigned int *line_count)
@@ -2138,8 +2142,22 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			(*seq)++;
 
 		} else {
-			/* Non-existent/non-finalized record. Must stop. */
-			return false;
+			/*
+			 * Non-existent/non-finalized record. Must stop.
+			 *
+			 * For panic situations it cannot be expected that
+			 * non-finalized records will become finalized. But
+			 * there may be other finalized records beyond that
+			 * need to be printed for a panic situation. If this
+			 * is the panic CPU, skip this
+			 * non-existent/non-finalized record unless it is
+			 * at or beyond the head, in which case it is not
+			 * possible to continue.
+			 */
+			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
+				(*seq)++;
+			else
+				return false;
 		}
 	}
 
-- 
2.39.2

