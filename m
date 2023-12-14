Return-Path: <linux-kernel+bounces-145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B7813CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2911C21CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2EF6DD13;
	Thu, 14 Dec 2023 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b+oQS7ov";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="phT90Otf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E496ABB5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muVNDGHsflpPS75QT30/xhAWDErFJBhvBumoamznaLA=;
	b=b+oQS7ovxSclsqr8szoXFqH5thsF+V/j7hxOLnR6shH6GCgYLVavhZbEycUD0bPh8KIsd3
	/HQ8unq761Xz6A/zlKW0c1tqBwiK+RPYSw8z9b3h5Fag97ckFU1lZUqITRUv/S8r46v69P
	BCQGaJacgenSB1odluZ4hrYsY04KsCHBS8BmWKl/jka072/PNjXPSNQSd+5MzTOBt7Sr6C
	6aD0jtwk9E1j9N8Z7odbKB2nM7msQTNTwU86Opx5sL9z3eT6Elac/AcyaHBTJHTLOTf2qA
	jUzNItuhD/asRLVfhBa/aDlLPiko1FuNfZqi2A01jZUn8r3708PYNY4WE1C9Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muVNDGHsflpPS75QT30/xhAWDErFJBhvBumoamznaLA=;
	b=phT90OtfDCug3ZR3eWCa6Yqoc+ndgc1bUViER55GRkZespCIz0VYuEMEEGNPQB0TvYN5gX
	9z3IEeo8V9KuY7BA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 03/14] printk: Use prb_first_seq() as base for 32bit seq macros
Date: Thu, 14 Dec 2023 22:47:50 +0106
Message-Id: <20231214214201.499426-4-john.ogness@linutronix.de>
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: This change only applies to 32bit architectures. On 64bit
      architectures the macros are NOPs.

Currently prb_next_seq() is used as the base for the 32bit seq
macros __u64seq_to_ulseq() and __ulseq_to_u64seq(). However, in
a follow-up commit, prb_next_seq() will need to make use of the
32bit seq macros.

Use prb_first_seq() as the base for the 32bit seq macros instead
because it is guaranteed to return 64bit sequence numbers without
relying on any 32bit seq macros.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 2 +-
 kernel/printk/printk_ringbuffer.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index fde338606ce8..49a82ccce8e9 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1832,7 +1832,7 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 }
 
 /* Get the sequence number of the tail descriptor. */
-static u64 prb_first_seq(struct printk_ringbuffer *rb)
+u64 prb_first_seq(struct printk_ringbuffer *rb)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	enum desc_state d_state;
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 12f60c782e46..ee294aaf4aeb 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -378,6 +378,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 			 struct printk_info *info, unsigned int *line_count);
 
+u64 prb_first_seq(struct printk_ringbuffer *rb);
 u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
 
@@ -392,12 +393,12 @@ u64 prb_next_seq(struct printk_ringbuffer *rb);
 
 static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
 {
+	u64 rb_first_seq = prb_first_seq(rb);
 	u64 seq;
-	u64 rb_next_seq;
 
 	/*
 	 * The provided sequence is only the lower 32 bits of the ringbuffer
-	 * sequence. It needs to be expanded to 64bit. Get the next sequence
+	 * sequence. It needs to be expanded to 64bit. Get the first sequence
 	 * number from the ringbuffer and fold it.
 	 *
 	 * Having a 32bit representation in the console is sufficient.
@@ -406,8 +407,7 @@ static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
 	 *
 	 * Also the access to the ring buffer is always safe.
 	 */
-	rb_next_seq = prb_next_seq(rb);
-	seq = rb_next_seq - (s32)((u32)rb_next_seq - ulseq);
+	seq = rb_first_seq - (s32)((u32)rb_first_seq - ulseq);
 
 	return seq;
 }
-- 
2.39.2


