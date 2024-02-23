Return-Path: <linux-kernel+bounces-78254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5878610D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D512863B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6557C093;
	Fri, 23 Feb 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgjtbGYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCC7BAEF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689122; cv=none; b=bTmHAmUARrJGY6vuqm9ZtZYOcAtS6m72pRKKDtemytVEaD4AeFSCnpvSZRSnU4gynOK2N0S8gukjdgkWvkZeQs2iteOeEbw8+o0O6qAXS/5CGSF7Y3hVDitBZX8IZBPN0B+byCoRW7kgyepxlLJS8z3X4puGNdt5+/SvceBqygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689122; c=relaxed/simple;
	bh=FNEmQ819X+4jzsi2LEQDgwiIxK1a6W9fcLNJsEFzcXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDMC0MfleAAtUXxcy8Xj0N9ACLW23QLtSfH1YP079naHHyXuteXwNqZiceN2qGFc7rcRFRLNGWoNDUvOitiLV38IfHb9IAb+ljoMwg05MdTTVcnul69BBXm+8OBcDsds8xy3aOG3rv1D1Ne7Mw7ZTD/4SUEcZjq6VqMkQ6Qta/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgjtbGYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D13C43390;
	Fri, 23 Feb 2024 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708689121;
	bh=FNEmQ819X+4jzsi2LEQDgwiIxK1a6W9fcLNJsEFzcXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgjtbGYD7QTuXEz/tAsXFo0qynF8zdVuzsGr6cjWw9N1j+03d4f9L1AMdlb3rHNNw
	 xVbSrZheauh+O0tka2zI2kgH66iabZOLWU0S61NcSFzbStTn0hAsEz3EgzoyRfuq0H
	 0Ii400wqnFm2owHwuxwKMLFKXVzr/mXsC8AsGb7m4htqpex+E2w5TuN2DEJ99SZcfi
	 hit+GaowoEvv4mEoZbuwXm2I7IPC4XzJtF/G+YR6wFMCUF9Ev8oqR6N/tzxokDY13g
	 jt7DZBJFGRdx0heCzq0tMr75+yXQVNRpGXxwwEXev/lv7GC2lES/PTusdqGms2MFPK
	 l/jj7/KYLkUkg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: stefani@seibold.net
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/4] kfifo: introduce and use kfifo_skip_count()
Date: Fri, 23 Feb 2024 12:51:53 +0100
Message-ID: <20240223115155.8806-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223115155.8806-1-jirislaby@kernel.org>
References: <20240223115155.8806-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfifo_skip_count() is an extended version of kfifo_skip(), accepting
also count. This will be useful in the serial code later.

Now, it can be used to implement both kfifo_skip() and
kfifo_dma_out_finish(). In the latter, 'len' only needs to be divided by
'type' size (as it was until now).

And stop using statement expressions when the return value is cast to
'void'. Use classic 'do {} while (0)' instead.

Note: perhaps we should skip 'count' records for the 'recsize' case, but
the original (kfifo_dma_out_finish()) used to skip only one record. So
this is kept unchanged and 'count' is still ignored in the recsize case.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/kfifo.h | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index bc7a1f5bb0ce..9e64eb03c535 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -304,19 +304,25 @@ __kfifo_uint_must_check_helper( \
 )
 
 /**
- * kfifo_skip - skip output data
+ * kfifo_skip_count - skip output data
  * @fifo: address of the fifo to be used
+ * @count: count of data to skip
  */
-#define	kfifo_skip(fifo) \
-(void)({ \
+#define	kfifo_skip_count(fifo, count) do { \
 	typeof((fifo) + 1) __tmp = (fifo); \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	if (__recsize) \
 		__kfifo_skip_r(__kfifo, __recsize); \
 	else \
-		__kfifo->out++; \
-})
+		__kfifo->out += (count); \
+} while(0)
+
+/**
+ * kfifo_skip - skip output data
+ * @fifo: address of the fifo to be used
+ */
+#define	kfifo_skip(fifo)	kfifo_skip_count(fifo, 1)
 
 /**
  * kfifo_peek_len - gets the size of the next fifo record
@@ -790,17 +796,10 @@ __kfifo_int_must_check_helper( \
  * Note that with only one concurrent reader and one concurrent
  * writer, you don't need extra locking to use these macros.
  */
-#define kfifo_dma_out_finish(fifo, len) \
-(void)({ \
+#define kfifo_dma_out_finish(fifo, len) do { \
 	typeof((fifo) + 1) __tmp = (fifo); \
-	unsigned int __len = (len); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (__recsize) \
-		__kfifo_skip_r(__kfifo, __recsize); \
-	else \
-		__kfifo->out += __len / sizeof(*__tmp->type); \
-})
+	kfifo_skip_count(__tmp, (len) / sizeof(*__tmp->type)); \
+} while (0)
 
 /**
  * kfifo_out_peek - gets some data from the fifo
-- 
2.43.2


