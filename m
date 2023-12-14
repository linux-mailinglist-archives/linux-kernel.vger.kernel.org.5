Return-Path: <linux-kernel+bounces-153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6644813CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0459B1C21CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333376DCB;
	Thu, 14 Dec 2023 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XPgKbTY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8/Gtj27"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E446E2D9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOpz80KH0gOIPorBUANVFFuEUm2IlzR04QH0UC2n8ec=;
	b=3XPgKbTYjsOSZZI8Z0yrQGgswsqfMiaE7LTZuoZlvjGuK0QB2uH+6eWXptBrjF0N1QXiNz
	XZ2QDMG0/8fkf4dRt8pddUR6G1VYuX2DjCbBCMX8gYVUUcM8YnZH9ZNil23NZ3KV7NIEAV
	oUXhE88cRwHF4MzdPo45kcwPU/vppvgtM8XkZdCtxDkeqEaIw3dD1t/nV6i41/WK7M58fn
	mGLa4m71D/jZOOCzeKiEbdBbVTAUPUHQqPVz7Rps+6UBq4XFf7GhhrIOAfhAxZ1VMy4mw3
	lVw2boR0W/FUVmYQ17ZoQ8oOdAV2wh/pto+a4EDaVr00NGltAoAWE6pvIMEf4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOpz80KH0gOIPorBUANVFFuEUm2IlzR04QH0UC2n8ec=;
	b=y8/Gtj27CBD6NJc0FZUEREShj5VIVtIJaLWUgTsuCtS9F+eakMLN6S2Rqku02qW3KLc87y
	aGeNAXVmuQ5UbiAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 10/14] printk: ringbuffer: Skip non-finalized records in panic
Date: Thu, 14 Dec 2023 22:47:57 +0106
Message-Id: <20231214214201.499426-11-john.ogness@linutronix.de>
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 kernel/printk/printk_ringbuffer.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index b7748d7c44c1..d6ed33683b8b 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2107,6 +2107,10 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
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
@@ -2129,8 +2133,28 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
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
+			 *
+			 * Note that new messages printed on panic CPU are
+			 * finalized when we are here. The only exception
+			 * might be the last message without trailing newline.
+			 * But it would have the sequence number returned
+			 * by "prb_next_reserve_seq() - 1".
+			 */
+			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
+				(*seq)++;
+			else
+				return false;
 		}
 	}
 
-- 
2.39.2


