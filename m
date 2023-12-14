Return-Path: <linux-kernel+bounces-150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B31F813CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF41C217DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF86FCFB;
	Thu, 14 Dec 2023 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Um+KStAI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QiXbx7oE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F086E2C0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dulH4uTFGHjZfiwmh5wTwYSUbBhMPUk3D6gHo+246W0=;
	b=Um+KStAIeVeli6ubkyXVvhUMFOAS+CGHsj0pasba2RsNvgIJw6sMPi6+2Vl8+YxYNV55aQ
	Da1wq69Q1xiAHokJ9oILGdhGR5TZQxwJTSBizELnIG3HKzRamrshLvpLNA/+M1JmcR5q53
	VxjgXE2dr8QYemoKKg7U5rxSrUgive0oXyomTR7Wf1vn0Z7Y75VR20+NmhymkVi7zOcevk
	lzUtmXaEyZCRhIPQPcU7V1y9BadI4EN8LaeawoE7tktDmktre7YG9MaCEu9TicCDFSeR/N
	iYmWkn0KTiQIgHKzgWKs7UzoUNtO13GD28o2yRJLQ7j0G8Ev4WFJlTN8NWIMOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dulH4uTFGHjZfiwmh5wTwYSUbBhMPUk3D6gHo+246W0=;
	b=QiXbx7oE4vDke9/uZ44k7k21fMsLQKRToJN9tPxb+hM7GI2qYu0A5+vThpVToe1d2Ki58B
	5EpLq38dMFioq3DQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 08/14] printk: ringbuffer: Cleanup reader terminology
Date: Thu, 14 Dec 2023 22:47:55 +0106
Message-Id: <20231214214201.499426-9-john.ogness@linutronix.de>
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the lockless ringbuffer, it is allowed that multiple
CPUs/contexts write simultaneously into the buffer. This creates
an ambiguity as some writers will finalize sooner.

The documentation for the prb_read functions is not clear as it
refers to "not yet written" and "no data available". Clarify the
return values and language to be in terms of the reader: records
available for reading.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 244d991ffd73..67ee1c62fcd6 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1987,11 +1987,13 @@ u64 prb_first_seq(struct printk_ringbuffer *rb)
 }
 
 /*
- * Non-blocking read of a record. Updates @seq to the last finalized record
- * (which may have no data available).
+ * Non-blocking read of a record.
  *
- * See the description of prb_read_valid() and prb_read_valid_info()
- * for details.
+ * On success @seq is updated to the record that was read and (if provided)
+ * @r and @line_count will contain the read/calculated data.
+ *
+ * On failure @seq is updated to a record that is not yet available to the
+ * reader, but it will be the next record available to the reader.
  */
 static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			    struct printk_record *r, unsigned int *line_count)
@@ -2010,7 +2012,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			*seq = tail_seq;
 
 		} else if (err == -ENOENT) {
-			/* Record exists, but no data available. Skip. */
+			/* Record exists, but the data was lost. Skip. */
 			(*seq)++;
 
 		} else {
@@ -2043,7 +2045,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
  * On success, the reader must check r->info.seq to see which record was
  * actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a record not yet available to the reader.
  */
 bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 		    struct printk_record *r)
@@ -2073,7 +2075,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
  * On success, the reader must check info->seq to see which record meta data
  * was actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a record not yet available to the reader.
  */
 bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 			 struct printk_info *info, unsigned int *line_count)
-- 
2.39.2


