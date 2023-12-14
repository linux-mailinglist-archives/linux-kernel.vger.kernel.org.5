Return-Path: <linux-kernel+bounces-151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B6813CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAC21C21D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE86FCEE;
	Thu, 14 Dec 2023 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rYKzl1gL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4nJ9zge"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572B6E2DB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+Rj9ow8fovhfkl47C5quy90KNsRy8XmYEJxuaPSPxc=;
	b=rYKzl1gLfyiH9IJP+TFLliwyltsoWallmmQO2rIWW8Z/fGewTSWXqFjmYrmYTF+CeN4zKV
	wPontEoTCZuXFuB3Ybr6bj8SPuuXyeVscircT/Ol/ro4/4dtG60znLbdixzbjBmpbJlFq3
	J3TKHO8N6BO1RKK25l+KflE1Xq/GC2yT5PjTw3ZWCPgmMuFfXHba9D9gMifVHVXsifgcar
	/6IPOTBBy9xorvPK9ZfRGwCxypgXJ6rrybFNb9io6crG3P4hKA5Ph1junGYvzLOycp+ckA
	d1JYd/lzSbUDSdRQ2G9pcAEg7G9bpuDMUoSFxsEw+Kaq+kojiFKqWrbCnXIIhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+Rj9ow8fovhfkl47C5quy90KNsRy8XmYEJxuaPSPxc=;
	b=E4nJ9zgeLAGTpX7uf+GwQSKNUOUmHjHZFCXuM4dmVdN4NYPZT8iNldWycwr5Ytv/BL7qeg
	JD1ZUoqpcg9ry0DQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 11/14] printk: ringbuffer: Consider committed as finalized in panic
Date: Thu, 14 Dec 2023 22:47:58 +0106
Message-Id: <20231214214201.499426-12-john.ogness@linutronix.de>
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A descriptor in the committed state means the record does not yet
exist for the reader. However, for the panic CPU, committed
records should be handled as finalized records since they contain
message data in a consistent state and may contain additional
hints as to the cause of the panic.

Add an exception for records in the commit state to not be
considered non-existing when reading from the panic CPU.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d6ed33683b8b..e7b808b829a0 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1857,6 +1857,8 @@ static bool copy_data(struct prb_data_ring *data_ring,
  * descriptor. However, it also verifies that the record is finalized and has
  * the sequence number @seq. On success, 0 is returned.
  *
+ * For the panic CPU, committed descriptors are also considered finalized.
+ *
  * Error return values:
  * -EINVAL: A finalized record with sequence number @seq does not exist.
  * -ENOENT: A finalized record with sequence number @seq exists, but its data
@@ -1875,16 +1877,25 @@ static int desc_read_finalized_seq(struct prb_desc_ring *desc_ring,
 
 	/*
 	 * An unexpected @id (desc_miss) or @seq mismatch means the record
-	 * does not exist. A descriptor in the reserved or committed state
-	 * means the record does not yet exist for the reader.
+	 * does not exist. A descriptor in the reserved state means the
+	 * record does not yet exist for the reader.
 	 */
 	if (d_state == desc_miss ||
 	    d_state == desc_reserved ||
-	    d_state == desc_committed ||
 	    s != seq) {
 		return -EINVAL;
 	}
 
+	/*
+	 * A descriptor in the committed state means the record does not yet
+	 * exist for the reader. However, for the panic CPU, committed
+	 * records are also handled as finalized records since they contain
+	 * message data in a consistent state and may contain additional
+	 * hints as to the cause of the panic.
+	 */
+	if (d_state == desc_committed && !this_cpu_in_panic())
+		return -EINVAL;
+
 	/*
 	 * A descriptor in the reusable state may no longer have its data
 	 * available; report it as existing but with lost data. Or the record
-- 
2.39.2


